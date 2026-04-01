var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// main.ts
var main_exports = {};
__export(main_exports, {
  default: () => VimYankHighlightPlugin
});
module.exports = __toCommonJS(main_exports);
var import_obsidian = require("obsidian");

// markViewPlugin.ts
var import_view = require("@codemirror/view");
var import_state = require("@codemirror/state");
var MarkViewPlugin = class {
  constructor(view) {
    this.decorations = import_view.Decoration.none;
  }
  update(update) {
    if (update.docChanged) {
      this.decorations = this.decorations.map(update.changes);
    }
  }
  setYankText(text, view) {
    if (!text)
      return;
    const builder = new import_state.RangeSetBuilder();
    const content = view.state.doc.toString();
    const searchText = text.replace(/\n$/, "");
    let pos = content.indexOf(searchText);
    const cursorPos = view.state.selection.main.head;
    let closestPos = -1;
    let minDistance = Infinity;
    while (pos !== -1) {
      const distance = Math.abs(pos - cursorPos);
      if (distance < minDistance) {
        minDistance = distance;
        closestPos = pos;
      }
      pos = content.indexOf(searchText, pos + 1);
    }
    if (closestPos !== -1) {
      const mark = import_view.Decoration.mark({
        class: "yank-highlight"
      });
      builder.add(closestPos, closestPos + text.length, mark);
    }
    this.decorations = builder.finish();
    view.update([]);
  }
  cleanYankText(view) {
    this.decorations = import_view.Decoration.none;
    view.update([]);
  }
};
var markViewPlugin = import_view.ViewPlugin.fromClass(MarkViewPlugin, {
  decorations: (v) => v.decorations
});

// types.ts
var vimEvents = {
  keypress: "vim-keypress",
  commanddone: "vim-command-done"
};

// main.ts
var VimYankHighlightPlugin = class extends import_obsidian.Plugin {
  constructor() {
    super(...arguments);
    this.vimCommand = [];
    this.vimCommandDone = false;
    this.onVimKeypress = (vimKey) => {
      this.vimCommand.push(vimKey);
      if (!this.vimCommandDone)
        return;
      if (this.vimCommand.contains("y") || this.vimCommand.contains("Y")) {
        this.highlightYank();
      }
      this.vimCommandDone = false;
      this.vimCommand.splice(0, this.vimCommand.length);
    };
    this.onVimCommandDone = () => {
      this.vimCommandDone = true;
    };
  }
  get activeView() {
    return this.app.workspace.getActiveViewOfType(
      import_obsidian.MarkdownView
    );
  }
  get activeEditorView() {
    var _a, _b;
    return (_b = ((_a = this.activeView) == null ? void 0 : _a.leaf.view).editor) == null ? void 0 : _b.cm;
  }
  get codeMirror() {
    var _a, _b, _c, _d;
    return (_d = (_c = (_b = (_a = this.activeView) == null ? void 0 : _a.editMode) == null ? void 0 : _b.editor) == null ? void 0 : _c.cm) == null ? void 0 : _d.cm;
  }
  async onload() {
    this.registerEditorExtension([markViewPlugin]);
    this.registerEvent(
      this.app.workspace.on("active-leaf-change", () => {
        if (!this.initialized)
          this.initialize();
      })
    );
  }
  initialize() {
    var _a;
    if (this.activeView && this.codeMirror) {
      this.codeMirrorVimObject = (_a = window.CodeMirrorAdapter) == null ? void 0 : _a.Vim;
      const cmV = this.codeMirror;
      cmV.off(vimEvents.keypress, this.onVimKeypress);
      cmV.on(vimEvents.keypress, this.onVimKeypress);
      cmV.off(vimEvents.commanddone, this.onVimCommandDone);
      cmV.on(vimEvents.commanddone, this.onVimCommandDone);
    }
  }
  highlightYank() {
    const yankRegister = this.codeMirrorVimObject.getRegisterController().getRegister("yank");
    const currentYankBuffer = yankRegister.keyBuffer[0];
    if (!this.activeEditorView)
      return;
    const plugin = this.activeEditorView.plugin(
      markViewPlugin
    );
    plugin.setYankText(currentYankBuffer, this.activeEditorView);
    const timeoutEditorView = this.activeEditorView;
    clearTimeout(this.timeoutHandle);
    this.timeoutHandle = window.setTimeout(() => {
      plugin.cleanYankText(timeoutEditorView);
    }, 500);
  }
  onunload() {
    const cmV = this.codeMirror;
    if (!cmV)
      return;
    cmV.off(vimEvents.keypress, this.onVimKeypress);
    cmV.off(vimEvents.commanddone, this.onVimCommandDone);
  }
};
