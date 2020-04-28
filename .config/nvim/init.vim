let mapleader =","

" PLUGINS{{{

"{{{ Plug Config
"if ! filereadable(expand('~/.config/vim/autoload/plug.vim'))
	"echo "Downloading junegunn/vim-plug to manage plugins..."
	"silent !mkdir -p ~/.config/nvim/autoload/
	"silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
"endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/syntastic'
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

"{{{ Ultinips
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsListSnippets="<c-u>"
"}}}

"{{{ NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:webdevicons_enable_nerdtree = 1

"}}}

"{{{ vimlatex
let g:vimtex_compiler_progname = 'xelatex'
let g:tex_flavor  = 'xelatex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'latexmk'
let g:vimtex_view_method = 'zathura'
"}}}

"{{{ AirLine Theme
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1
"}}}

"{{{ EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}

"}}}

"{{{ SET
set mouse=a
set clipboard=unnamedplus
set foldenable
set foldmethod=marker
set viewoptions-=options
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0
"}}}

" Some basics:{{{
	nnoremap c "_c
	set nocompatible
	filetype off
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
"}}}

"{{{ Colorscheme
set background=dark
"set termguicolors
"colorscheme solarized8_high
highlight Folded ctermbg=Black ctermfg=White
hi Cursor ctermbg=black ctermfg=black
set cursorline
hi CursorLine   cterm=NONE ctermbg=black
hi CursorColumn cterm=NONE ctermbg=black
"}}}

"{{{ LukeSmith.xyz Tools
" Goyo plugin makes text more readable when writing prose:{{{
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
"}}}

" Spell-check set to <leader>o, 'o' for 'orthography':{{{
	map <leader>o :setlocal spell! spelllang=en_us<CR>
"}}}

" Open my bibliography file in split{{{
	map <leader>b :vsp<space>$BIB<CR>"
	map <leader>r :vsp<space>$REFER<CR>
"}}}

" Compile document, be it groff/LaTeX/markdown/etc.{{{
	map <leader>c :w! \| !compiler <c-r>%<CR> :<CR>
	"}}}

" Open corresponding .pdf/.html or preview{{{
	map <leader>p :!opout <c-r>%<CR><CR>
	"}}}

" Runs a script that cleans out tex build files whenever I close out of a .tex file.{{{
	autocmd VimLeave *.tex !texclear %"
	"}}}

" Ensure files are read as what I want:{{{
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}"
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	"}}}

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):{{{
	vnoremap <C-c> "+y
	map <C-p> "+P
	"}}}

" Automatically deletes all trailing whitespace on save.{{{
	autocmd BufWritePre * %s/\s\+$//e
	"}}}

" When shortcut files are updated, renew bash and vifm configs with new material:{{{
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts"
	"}}}

" Update binds when sxhkdrc is updated.{{{
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
	"}}}

" Run xrdb whenever Xdefaults or Xresources are updated.{{{
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
	"}}}

" Run pdfmom whenever *\.mom files are saved{{{
	autocmd Filetype mom !refer -PS -e "$file" | pdfmom -Tpdf >> "$base".pdf ;;
	"}}}

" Navigating with guides{{{
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l
	"}}}
"}}}

"{{{ GOFF/MOM
	" Definitions

	autocmd FileType  groff inoremap ,d .HEADING 3<CR>"\*[red]Term:\*[black] "\*[black]<CR>\#{{{ DEFINE<CR>.SPACE -10p<CR>.TAB 1<CR>\*[BD]Definition\*[PREV]<CR>.TN<CR><++><CR>.ALD 5p<CR>.TAB 1<CR>\*[BD]Examples\*[PREV]<CR>.TN<CR><++><CR>.TAB 1<CR>\*[BD]Notes\*[PREV]<CR>.TN<CR><++><CR>\#}}}<CR>\<Esc>17k23li
	autocmd FileType groff inoremap ,nil .ITEM<CR>\*[BD]Note:\*[PREV] <Esc>
"}}}

"LATEX{{{
	" Word count
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	" Notes
		" Definition
	autocmd FileType tex inoremap ,def \define<CR>{} %term<CR>{<++>} %Definition<CR>{<++>} %Example<CR>{<++>} %Notes<CR><CR><++><Esc>5k0li
		" Module
		autocmd FileType tex inoremap ,nm \module%{{{<CR>{} %Number<CR>{<++>} %Title<CR><CR><++><CR>%}}}<Esc>4k0a
		" Class
		autocmd FileType tex inoremap ,nc \class<CR>{} %Date<CR><CR><++><Esc>2k6ha
		" Topic
		autocmd FileType tex inoremap ,nt \topic{} %Topic<CR><CR><++><Esc>2k3la
		"1}}}
"
"
"
"
"
"
"
"
"
"
"

"
"
"
"
"
"
"
"
"
"
"
"
"

