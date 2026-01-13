" Use system clipboard by default
set clipboard=unnamed

" Remap go and gO to start new lines without moving cursor 
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" Remap Q to repeat last macro
nnoremap Q @@

" Remap BS to "_d
nnoremap <BS> "_d
vnoremap <BS> "_d

" Don't exit visual mode when indenting/outdent
vnoremap < <gv
vnoremap > >gv

" Hotkeys for surrounding selections
vnoremap g` <Esc>`>a`<Esc>`<i`<Esc>
nnoremap g`iw ciw`<C-r>"`<Esc>
nnoremap g`aw caw`<C-r>"`<Esc>
nnoremap g`iW ciW`<C-r>"`<Esc>
nnoremap g`aW caW`<C-r>"`<Esc>
nnoremap g`is cis`<C-r>"`<Esc>
nnoremap g`as cas`<C-r>"`<Esc>
nnoremap g`ip cip`<C-r>"`<Esc>
nnoremap g`ap cap`<C-r>"`<Esc>
nnoremap g`i" ci"`<C-r>"`<Esc>
nnoremap g`a" ca"`<C-r>"`<Esc>
nnoremap g`i' ci'`<C-r>"`<Esc>
nnoremap g`a' ca'`<C-r>"`<Esc>
nnoremap g`i` ci``<C-r>"`<Esc>
nnoremap g`a` ca``<C-r>"`<Esc>
nnoremap g`i( ci(`<C-r>"`<Esc>
nnoremap g`a( ca(`<C-r>"`<Esc>
nnoremap g`i[ ci[`<C-r>"`<Esc>
nnoremap g`a[ ca[`<C-r>"`<Esc>
nnoremap g`i{ ci{`<C-r>"`<Esc>
nnoremap g`a{ ca{`<C-r>"`<Esc>
nnoremap g`i< ci<`<C-r>"`<Esc>
nnoremap g`a< ca<`<C-r>"`<Esc>
nnoremap g`it cit`<C-r>"`<Esc>
nnoremap g`at cat`<C-r>"`<Esc>

vnoremap g[ <Esc>`>a]]<Esc>`<i[[<Esc>
nnoremap g[iw ciw[[<C-r>"]]<Esc>
nnoremap g[aw caw[[<C-r>"]]<Esc>
nnoremap g[iW ciW[[<C-r>"]]<Esc>
nnoremap g[aW caW[[<C-r>"]]<Esc>
nnoremap g[is cis[[<C-r>"]]<Esc>
nnoremap g[as cas[[<C-r>"]]<Esc>
nnoremap g[ip cip[[<C-r>"]]<Esc>
nnoremap g[ap cap[[<C-r>"]]<Esc>
nnoremap g[i" ci"[[<C-r>"]]<Esc>
nnoremap g[a" ca"[[<C-r>"]]<Esc>
nnoremap g[i' ci'[[<C-r>"]]<Esc>
nnoremap g[a' ca'[[<C-r>"]]<Esc>
nnoremap g[i` ci`[[<C-r>"]]<Esc>
nnoremap g[a` ca`[[<C-r>"]]<Esc>
nnoremap g[i( ci([[<C-r>"]]<Esc>
nnoremap g[a( ca([[<C-r>"]]<Esc>
nnoremap g[i[ ci[[[<C-r>"]]<Esc>
nnoremap g[a[ ca[[[<C-r>"]]<Esc>
nnoremap g[i{ ci{[[<C-r>"]]<Esc>
nnoremap g[a{ ca{[[<C-r>"]]<Esc>
nnoremap g[i< ci<[[<C-r>"]]<Esc>
nnoremap g[a< ca<[[<C-r>"]]<Esc>
nnoremap g[it cit[[<C-r>"]]<Esc>
nnoremap g[at cat[[<C-r>"]]<Esc>

vnoremap g" <Esc>`>a"<Esc>`<i"<Esc>
nnoremap g"iw ciw"<C-r>""<Esc>
nnoremap g"aw caw"<C-r>""<Esc>
nnoremap g"iW ciW"<C-r>""<Esc>
nnoremap g"aW caW"<C-r>""<Esc>
nnoremap g"is cis"<C-r>""<Esc>
nnoremap g"as cas"<C-r>""<Esc>
nnoremap g"ip cip"<C-r>""<Esc>
nnoremap g"ap cap"<C-r>""<Esc>
nnoremap g"i" ci""<C-r>""<Esc>
nnoremap g"a" ca""<C-r>""<Esc>
nnoremap g"i' ci'"<C-r>""<Esc>
nnoremap g"a' ca'"<C-r>""<Esc>
nnoremap g"i` ci`"<C-r>""<Esc>
nnoremap g"a` ca`"<C-r>""<Esc>
nnoremap g"i( ci("<C-r>""<Esc>
nnoremap g"a( ca("<C-r>""<Esc>
nnoremap g"i[ ci["<C-r>""<Esc>
nnoremap g"a[ ca["<C-r>""<Esc>
nnoremap g"i{ ci{"<C-r>""<Esc>
nnoremap g"a{ ca{"<C-r>""<Esc>
nnoremap g"i< ci<"<C-r>""<Esc>
nnoremap g"a< ca<"<C-r>""<Esc>
nnoremap g"it cit"<C-r>""<Esc>
nnoremap g"at cat"<C-r>""<Esc>

vnoremap g' <Esc>`>`<Esc>`<i'<Esc>
nnoremap g'iw ciw'<C-r>"'<Esc>
nnoremap g'aw caw'<C-r>"'<Esc>
nnoremap g'iW ciW'<C-r>"'<Esc>
nnoremap g'aW caW'<C-r>"'<Esc>
nnoremap g'is cis'<C-r>"'<Esc>
nnoremap g'as cas'<C-r>"'<Esc>
nnoremap g'ip cip'<C-r>"'<Esc>
nnoremap g'ap cap'<C-r>"'<Esc>
nnoremap g'i" ci"'<C-r>"'<Esc>
nnoremap g'a" ca"'<C-r>"'<Esc>
nnoremap g'i' ci''<C-r>"'<Esc>
nnoremap g'a' ca''<C-r>"'<Esc>
nnoremap g'i` ci`'<C-r>"'<Esc>
nnoremap g'a` ca`'<C-r>"'<Esc>
nnoremap g'i( ci('<C-r>"'<Esc>
nnoremap g'a( ca('<C-r>"'<Esc>
nnoremap g'i[ ci['<C-r>"'<Esc>
nnoremap g'a[ ca['<C-r>"'<Esc>
nnoremap g'i{ ci{'<C-r>"'<Esc>
nnoremap g'a{ ca{'<C-r>"'<Esc>
nnoremap g'i< ci<'<C-r>"'<Esc>
nnoremap g'a< ca<'<C-r>"'<Esc>
nnoremap g'it cit'<C-r>"'<Esc>
nnoremap g'at cat'<C-r>"'<Esc>

vnoremap g( <Esc>`>a)<Esc>`<i(<Esc>
nnoremap g(iw ciw(<C-r>")<Esc>
nnoremap g(aw caw(<C-r>")<Esc>
nnoremap g(iW ciW(<C-r>")<Esc>
nnoremap g(aW caW(<C-r>")<Esc>
nnoremap g(is cis(<C-r>")<Esc>
nnoremap g(as cas(<C-r>")<Esc>
nnoremap g(ip cip(<C-r>")<Esc>
nnoremap g(ap cap(<C-r>")<Esc>
nnoremap g(i" ci"(<C-r>")<Esc>
nnoremap g(a" ca"(<C-r>")<Esc>
nnoremap g(i' ci'(<C-r>")<Esc>
nnoremap g(a' ca'(<C-r>")<Esc>
nnoremap g(i` ci`(<C-r>")<Esc>
nnoremap g(a` ca`(<C-r>")<Esc>
nnoremap g(i( ci((<C-r>")<Esc>
nnoremap g(a( ca((<C-r>")<Esc>
nnoremap g(i[ ci[(<C-r>")<Esc>
nnoremap g(a[ ca[(<C-r>")<Esc>
nnoremap g(i{ ci{(<C-r>")<Esc>
nnoremap g(a{ ca{(<C-r>")<Esc>
nnoremap g(i< ci<(<C-r>")<Esc>
nnoremap g(a< ca<(<C-r>")<Esc>
nnoremap g(it cit(<C-r>")<Esc>
nnoremap g(at cat(<C-r>")<Esc>

vnoremap g{ <Esc>`>a}<Esc>`<i{<Esc>
nnoremap g{iw ciw{<C-r>"}<Esc>
nnoremap g{aw caw{<C-r>"}<Esc>
nnoremap g{iW ciW{<C-r>"}<Esc>
nnoremap g{aW caW{<C-r>"}<Esc>
nnoremap g{is cis{<C-r>"}<Esc>
nnoremap g{as cas{<C-r>"}<Esc>
nnoremap g{ip cip{<C-r>"}<Esc>
nnoremap g{ap cap{<C-r>"}<Esc>
nnoremap g{i" ci"{<C-r>"}<Esc>
nnoremap g{a" ca"{<C-r>"}<Esc>
nnoremap g{i' ci'{<C-r>"}<Esc>
nnoremap g{a' ca'{<C-r>"}<Esc>
nnoremap g{i` ci`{<C-r>"}<Esc>
nnoremap g{a` ca`{<C-r>"}<Esc>
nnoremap g{i( ci({<C-r>"}<Esc>
nnoremap g{a( ca({<C-r>"}<Esc>
nnoremap g{i[ ci[{<C-r>"}<Esc>
nnoremap g{a[ ca[{<C-r>"}<Esc>
nnoremap g{i{ ci{{<C-r>"}<Esc>
nnoremap g{a{ ca{{<C-r>"}<Esc>
nnoremap g{i< ci<{<C-r>"}<Esc>
nnoremap g{a< ca<{<C-r>"}<Esc>
nnoremap g{it cit{<C-r>"}<Esc>
nnoremap g{at cat{<C-r>"}<Esc>

vnoremap g< <Esc>`>a><Esc>`<i<<Esc>
nnoremap g<iw ciw<<C-r>"><Esc>
nnoremap g<aw caw<<C-r>"><Esc>
nnoremap g<iW ciW<<C-r>"><Esc>
nnoremap g<aW caW<<C-r>"><Esc>
nnoremap g<is cis<<C-r>"><Esc>
nnoremap g<as cas<<C-r>"><Esc>
nnoremap g<ip cip<<C-r>"><Esc>
nnoremap g<ap cap<<C-r>"><Esc>
nnoremap g<i" ci"<<C-r>"><Esc>
nnoremap g<a" ca"<<C-r>"><Esc>
nnoremap g<i' ci'<<C-r>"><Esc>
nnoremap g<a' ca'<<C-r>"><Esc>
nnoremap g<i` ci`<<C-r>"><Esc>
nnoremap g<a` ca`<<C-r>"><Esc>
nnoremap g<i( ci(<<C-r>"><Esc>
nnoremap g<a( ca(<<C-r>"><Esc>
nnoremap g<i[ ci[<<C-r>"><Esc>
nnoremap g<a[ ca[<<C-r>"><Esc>
nnoremap g<i{ ci{<<C-r>"><Esc>
nnoremap g<a{ ca{<<C-r>"><Esc>
nnoremap g<i< ci<<<C-r>"><Esc>
nnoremap g<a< ca<<<C-r>"><Esc>
nnoremap g<it cit<<C-r>"><Esc>
nnoremap g<at cat<<C-r>"><Esc>

" digraphs
digr ok 9989   " ✅
digr no 10060  " ❌

" turn hybrid line numbers on
set number relativenumber
set nu rnu

