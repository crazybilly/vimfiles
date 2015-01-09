set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set directory=.,$TEMP

set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction
"
 function MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
 endfunction



"desert color scheme
colo crazybilly 
"colo mustang

"show white space characters
set listchars=eol:$,tab:>-,trail:_,extends:>,precedes:<
set list

"turns off that annoying bell!
autocmd VimEnter * set vb t_vb=

"make the window a nice size
autocmd GUIEnter * winsize 120 82


set encoding=utf-8 
"set gfn=Droid_Sans_Mono:h10:cANSI
"set pfn=Droid_Sans_Mono:h8:cANSI
set gfn=Powerline_Consolas:h11:cANSI

"Airline config

	"make airline show up all the time
	set laststatus=2
	
	" turn on airline fonts
	let g:airline_powerline_fonts = 1

"turn off the gui buttons
set go-=T

"removes those annoying vim backup files 
"(yes, they are useful, but I can't stand the clutter)
set nobk


" reload vimrc automatically
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END


"turn off wrapping
set nowrap

"auto-indent turned on
set ai

"incremental search turned off
set is

"set tab widths
set tabstop=3
set shiftwidth=3
" for R files, don't use tabs
autocmd FileType r,R   setlocal expandtab

"turn folding on via indenting
set foldmethod=indent

"turn off pasting with the mouse wheel
map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

"turn on pathogen
execute pathogen#infect()


"turn line numbering on
set number

"set some reasonable print options
set printoptions=header:0
set pfn=Consolas:h9

" turn on CtrlP
"set runtimepath^=C:/Program~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
	"change the working directory to C:\Users\jtolbert
	cd C:\Users\jtolbert
	"be sure to cache the results of ctrlp
	let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
	" ignore various files by extension
	set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.ttf,*.otf,*.mp3,*.flac,*.mp4,*.pdf,*.doc,*.docx,*.xls,*.xlsx,*.pdf.txt



" turn the leader to the spacebar
let mapleader = "\<Space>"

	" Leader shortcuts
	nnoremap <Leader>o :CtrlP<CR>
	"clear searches by whacking <space><space>
	nmap <silent> <Leader><Leader> :nohl<CR>
	"print
	nmap <Leader>p :ha!<CR>
	"markdown bullet
	nmap <Leader>- :%s/^/- /g<CR>

	" Commenting blocks of code.
	autocmd FileType c,cpp,java,javascript,mysql,sql     let b:comment_leader = '// '
	autocmd FileType sh,ruby,python,r,R   let b:comment_leader = '# '
	autocmd FileType conf,fstab           let b:comment_leader = '# '
	autocmd FileType tex                  let b:comment_leader = '% '
	autocmd FileType mail                 let b:comment_leader = '> '
	autocmd FileType vim                  let b:comment_leader = '" '
	autocmd FileType autohotkey,ahk       let b:comment_leader = '; '
	noremap <silent><Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
	noremap <silent><Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"see either side of a DIFF
"map <F2> :v/^</d<CR>:%s/^< //<CR>
"map <F3> :v/^>/d<CR>:%s/^> //<CR>

"remove special characters from contact reports (and other text blobs)
map <F2> :%s/“/"/ge<CR>:%s/”/"/ge<CR>:%s/’/'/ge<CR>:%s/¿/'/ge<CR>:%s/‘/'/ge<CR>:%s/`/'/ge<CR>

" turns a Hobsons list of multiple attributes into a normalized list
" 	uses a recursive macro that calls itself till it throws an error (because it doesn't find anything)
let @q = ':%s/^\(.\{-}\)\t\(.\{-}\)\~/\1\t\2\r\1\t/g @q<CR>'
map <F4> @q

map <F5> :NumbersToggle<CR>

"convert a list of pidms to hobsons filter rows
map <F6> :%s/\n/\~/ge<CR>:%s/\(.\{247}.\{-}\)\~/\1\r/ge<CR>:%s/^\~*//ge<CR>:%s/\~*\s*$//ge<CR>:%s/\~0\+/\~/ge<CR>:%s/^0\+//ge<CR>

"turn a popsel log file into a list of pidms
map <F7> :%s/^\s\+//ge<CR>:%s/^\(XPARM2-KEY.*\n\)\@!//ge<CR>:%s/^[A-W].*\n//ge<CR>:%s/^[Y-Z].*\n//ge<CR>:%s/^\n//ge<CR>:%s/^-.*\n//ge<CR>:%s/^\*.*\n//ge<CR>:%s/^[a-z].*\n//ge<CR>:%s/XPARM2-KEY = \s\+.*\n//ge<CR>:%s/XPARM2-KEY\s\+=\s\+//ge<CR>:%s/^<---.*//ge<CR>:%s/^\s*\n//ge<CR>:%s/\s\+$//ge<CR>


"set syntax to sql 
map <F9> :set syntax=R<CR>

"format sql
"map <F10> :1,$!SqlFormatter.exe <CR><CR>

" fix up XAPRSPCT
map <F10>  :11s/\s\s\s\s\sClass/Class/e<CR>
			 \:12s/\s\s\s\s\s\(\d\d\d\d\)$/\1/e<CR>
			 \:%s/^\(\s\+325657\)               /\1    Caterpillar/e<CR>
			 \:%s/# GIFTS\n\s\+/# GIFTS\r  /e<CR>
			 \:%s/^-\d*DEC-9999/                /e<CR>

"see the YankRing window
":nnoremap <silent> <F11> :YRShow<CR>
"

"Set up counting variables for totaling the cashiering report
"	Summing variables
	let g:S = 0  "result in global variable S
	let g:Sp = 0  "result in global variable Sp for gifts applied pledges
	let g:Snp = 0  "result in global variable Snp for gifts not applied to pledges
	let g:Sg = 0  "result in global variable Sg for total of gift amount
"	Function to sum
	function! Sum(number)
	  let g:S = g:S + str2float(a:number)
	  return a:number
	endfunction

"	counting variables
	let N = [0]
	let Np = 0
	let Nnp = 0
	let Ng = 0


	map <F11> :let g:S = 0<CR>
				\:let g:Sg = 0<CR>
				\:let g:Sp = 0<CR>
				\:let g:Snp = 0<CR>
				\:silent! %s/\(NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .  \+[0-9]\+\),/\1/<CR>
				\:silent! %s/\(NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .  \+[0-9]\+\),/\1/<CR>
				\:%v/NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}-[0-9]\+\.[0-9][0-9]$/s/NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}\zs[0-9]\+\.[0-9][0-9]$/\=Sum(submatch(0))/<CR>
				\:let g:Sg = g:S<CR>:let g:S = 0<CR>
				\:%v/NC  \+0000000.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}-[0-9]\+\.[0-9][0-9]$/s/NC  \+ \+0000000.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}\zs[0-9]\+\.[0-9][0-9]$/\=Sum(submatch(0))/<CR>
				\:let g:Snp = g:S<CR>:let g:Sp = g:Sg - g:Snp<CR>:let N = [0]<CR>
				\:let N[0] = 0<CR>
				\:%s/^\s\+NC\zs/\=map(N,'v:val+1')[1:]/ge<CR>
				\:let Ng = N[0]<CR>
				\:let N[0] = 0<CR>
				\:%s/^\s\+NC\s\+0000000\zs/\=map(N,'v:val+1')[1:]/ge<CR>
				\:let Nnp = N[0]<CR>
				\:let N[0] = 0<CR>
				\:%s/^\s\+NC  \+.\{-}-[0-9]\+\.[0-9][0-9]\zs$/\=map(N,'v:val+1')[1:]/ge<CR>
				\:let Nneg = N[0]<CR>
				\:let Np = Ng - Nnp<CR>
				\:let Ng = Ng - Nneg<CR>
				\:let Np = Np - Nneg<CR>
				\:echo "\n\n\nTOTAL GIFTS:\t\t$"g:Sg"\t\t"Ng"\nGIFTS TO PLEDGES:\t$"g:Sp"\t\t"Np<CR>
	"works for totals
	"	map <F11> :let g:S = 0<CR>:let g:Sg = 0<CR>:let g:Sp = 0<CR>:let g:Snp = 0<CR>:silent! %s/\(NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  \+[0-9]\+\),/\1/<CR>:%v/NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}-[0-9]\+\.[0-9][0-9]$/s/NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}\zs[0-9]\+\.[0-9][0-9]$/\=Sum(submatch(0))/<CR>:let g:Sg = g:S<CR>:let g:S = 0<CR>:%v/NC  \+0000000.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}-[0-9]\+\.[0-9][0-9]$/s/NC  \+ \+0000000.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}\zs[0-9]\+\.[0-9][0-9]$/\=Sum(submatch(0))/<CR>:let g:Snp = g:S<CR>:let g:Sp = g:Sg - g:Snp<CR>:let N = [0]<CR>:let N[0] = 0<CR>:%s/^\s\+NC\zs/\=map(N,'v:val+1')[1:]/ge<CR>:let Ng = N[0]<CR>:let N[0] = 0<CR>:%s/^\s\+NC\s\+0000000\zs/\=map(N,'v:val+1')[1:]/ge<CR>:let Nnp = N[0]<CR>:let Np = Ng - Nnp<CR>:echo "\n\n\nTOTAL GIFTS:\t\t$"g:Sg"\t\t"Ng"\nGIFTS TO PLEDGES:\t$"g:Sp"\t\t"Np<CR>
	"map <F11> :let g:S = 0<CR>:let g:Sg = 0<CR>:let g:Sp = 0<CR>:let g:Snp = 0<CR>:silent! %s/\(NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  \+[0-9]\+\),/\1/<CR>:%s/NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}\zs-*[0-9]\+\.[0-9][0-9]$/\=Sum(submatch(0))/<CR>:let g:Sg = g:S<CR>:let g:S = 0<CR>:%s/NC  \+0000000.\{-}[A-Z][A-Z][A-Z][A-Z]\+  .\{-}\zs-*[0-9]\+\.[0-9][0-9]$/\=Sum(submatch(0))/<CR>:let g:Snp = g:S<CR>:let g:Sp = g:Sg - g:Snp<CR>:let N = [0]<CR>:let N[0] = 0<CR>:%s/^\s\+NC\zs/\=map(N,'v:val+1')[1:]/ge<CR>:let Ng = N[0]<CR>:let N[0] = 0<CR>:%s/^\s\+NC\s\+0000000\zs/\=map(N,'v:val+1')[1:]/ge<CR>:let Nnp = N[0]<CR>:let Np = Ng - Nnp<CR>:echo "\n\n\nTOTAL GIFTS:\t\t$"g:Sg"\t\t"Ng"\nGIFTS TO PLEDGES:\t$"g:Sp"\t\t"Np<CR>
	"map <F11> :let g:S = 0<CR>:let g:Sg = 0<CR>:let g:Sp = 0<CR>:let g:Snp = 0<CR>:%s/\(NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  \+[0-9]\+\),/\1/<CR>:%s/NC  \+.\{-}[A-Z][A-Z][A-Z][A-Z]\+  \+\zs.*/\=Sum(submatch(0))/<CR>:let g:Sg = g:S<CR>:let g:S = 0<CR>:%s/NC  \+0000000.\{-}[A-Z][A-Z][A-Z][A-Z]\+  \+\zs.*/\=Sum(submatch(0))/<CR>:let g:Snp = g:S<CR>:let g:Sp = g:Sg - g:Snp<CR>:let N = [0]<CR>:let N[0] = 0<CR>:%s/^\s\+NC\zs/\=map(N,'v:val+1')[1:]/ge<CR>:let Ng = N[0]<CR>:let N[0] = 0<CR>:%s/^\s\+NC\s\+0000000\zs/\=map(N,'v:val+1')[1:]/ge<CR>:let Nnp = N[0]<CR>:let Np = Ng - Nnp<CR>:echo "\n\n\nTOTAL GIFTS:\t\t$"g:Sg"\t\t"Ng"\nGIFTS TO PLEDGES:\t$"g:Sp"\t\t"Np<CR>



" Autocomplete already-existing words in the file with tab
"function InsertTabWrapper()
"      let col = col('.') - 1
"      if !col || getline('.')[col - 1] !~ '\k'
"          return "\<tab>"
"      else
"          return "\<c-p>"
"      endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>


" OLD HTML EDITING STUFF
	"mappings for editing Sharepoint HTML
	"map <F2>  :%s/<p>/<p style="clear: none;">/ge<CR>:%s/<ul>/<ul style="font-family: Tahoma, sans-serif; font-size: 8pt; float: none; padding-bottom: 1em; clear: none;">/e<CR>:%s/<ol>/<ol style="font-family: Tahoma; font-size: inherit; float: none; padding-bottom: 1em; clear: none;">/e<CR>:%s/https:\/\/web.millikin.edu\/alumni/\/alumni/e<CR>

	"create mailto links
	"map <F3>  :%s+\(\S\+@\S\+\)+<a href="mailto:\1">\1</a>+gce<CR>

	"put in CSS for tables
	"map <F4>  :%s/<table class="alumniDataTable">/<table class="alumniDataTable" style="border-collapse: collapse; margin: 10px 0;">/e<CR>:%s/<td/<td style="padding: 1em; border: 1px solid #D8D8D8;"/ge<CR>:%s/even" style="/& background: #EBF3FF; "/e<CR>:%s/<th/<th style="padding: 1em; border: 1px solid #D8D8D8;"/ge<CR>

	"convert messy email back to a readable format
	"map <F4>  :1,$!tidy.exe -config C:\Users\jtolbert\Documents\config\tidy-clean.cfg -f NULL<CR><CR>

	"put in CSS for imgs
	"map <F6> :%s/<img src="\(.*\)">/<img src="\1" style="float: left; margin: 4px 20px 15px 0; max-width; 200px;">/e<CR>
	"fix up text files in Class Agent emails
	"map <F6> :%s/^\s\+Make a gift/ - Make a gift/<CR>:%s/^\s\+Keep in/ - Keep in/<CR>:%s/^\s\+Stay in/ - Stay in/<CR>:%s_\(To unsub.\{-}\)click here\._\1 visit:\rhttp://surveys.millikin.edu:8081/survey/entry.jsp?id=1336746762475\&pubs\&mail\&phone\&source=Class-Agt-{#E-mail#}_<CR>:%s/\s*Shilling in winter/---------------------------------------------/<CR>:%s/.*\n\(.*`\)/\1/g<CR><CR>
	"fix up plain text unsubscribe links
	"map <F6> :%s_\(To unsub.\{-}\)click here ( \(.*\) )\._\1 visit:\r\2<CR>
	"toggle line numbers from relative to absolute

	"set syntax to sql 
	"map <F9> :set syntax=html<CR>
	
	"run tidy
	"map <F10> :1,$!tidy.exe -config C:\Users\jtolbert\Documents\config\tidyrc-for-fragments -f NUL<CR><CR>

	"remove jacked up line breaks
	"map <F11> :%s/\r//g<CR>
	"turn on Markdown->HTML
	"map <F11> :1,$!perl "C:\Program Files (x86)\Vim\vim73\plugin\markdown.pl" <CR><CR>

	"remove unpublished sharepoint references
	"map <F12> :%s_https://web.millikin.edu__g<CR>
