{ pkgs, lib, ... }:

{
  programs.neovim = {
     enable = true;
     defaultEditor = true;
     plugins = with pkgs.vimPlugins; [
        gruvbox
        vim-airline
        lazygit-nvim
        vim-dispatch
        plenary-nvim
        telescope-nvim
        pkgs.jai-vim 
        rust-vim
        vim-glsl
        vim-polyglot
        nvim-lspconfig
     ];
     extraConfig = ''
	"remove gui menus & stuff 
	set guioptions-=m
	set guioptions-=T
	set guioptions-=
	set guioptions-=L
	set signcolumn=number

	" UTF-8
	set encoding=utf-8
	set fileencoding=utf-8

	" Tab stuff
	set tabstop=4
	set shiftwidth=4
	set expandtab
	set softtabstop=4
	set smarttab
	set startofline

	" Indentation stuff
	set cindent
	set cinoptions=l1
	syntax enable
	filetype plugin indent on
	set autoindent
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	set breakindent
	set breakindentopt=shift:2,sbr

	" File stuff
	set autoread
	set autowrite
	set nobackup
	set nowritebackup

	" Line stuff
	set number

	" Theme
	set background=dark
	autocmd vimenter * ++nested colorscheme gruvbox
	set guifont=Source\ Code\ Pro:h10
	let g:gruvbox_bold = 0
	let g:gruvbox_italicize_comments = 1
	let g:airline_symbols_ascii = 1

	" Make backspace behave normally
	set backspace=indent,eol,start

	" Jump build errors
	noremap <C-2> :cp<CR>
	noremap <C-7> :cn<CR>

	" Move window to window with CTRL+movement
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l
	noremap <C-h> <C-w>h

	" Resize windows with CTRL+Arrows
	noremap <C-Up>    <C-w>+
	noremap <C-Down>  <C-w>-
	noremap <C-Left>  <C-w><
	noremap <C-Right> <C-w>>

	"=== C Stuff ===
	" autocmd FileType c set makeprg=build.bat
	" autocmd FileType cpp set makeprg=build.bat
	" autocmd FileType c set efm=%f:%l:%c:%m
	" autocmd FileType cpp set efm=%f:%l:%c:%m
	let c_no_curly_error = 1

	" === Vimspector ===
	let g:vimspector_enable_mappings = 'HUMAN'

	" === Remedy setup ===
	" :command RemedyOpen :silent !start remedybg.exe .rdbg
	" :command RemedyStart :silent !start remedybg.exe start-debugging
	" :command RemedyStop :silent !start remedybg.exe stop-debugging
	" :command Breakpoint :exe "silent !remedybg.exe add-breakpoint-at-file %:p " line('.')
	" :command RemBreakpoint exe "silent !remedybg.exe remove-breakpoint-at-file %:p " line('.')

	" noremap <F5> :RemedyStart<CR> 
	" noremap <S-F5> :RemedyStop<CR>
	" noremap <F9> :Breakpoint<CR>
	" noremap <S-F9> :RemBreakpoint<CR>

	"=== Rust stuff ===
	let g:cargo_makeprg_params = 'build'

	" === JAI ===
	let g:jai_compiler = "jai"
	autocmd FileType jai compiler jai

	" Search for an ident in the compiler folder (modules & how_to)
	function! s:JaiSearch(myParam) 
	    exe "vimgrep /". a:myParam ."/ /opt/jai/**/*.jai"
	endfunction
	command! -nargs=1 JaiFind call s:JaiSearch(<f-args>)

	function! s:OpenJaiDoc(param)
	    silent! exe "noautocmd pedit jai_doc"
	    noautocmd wincmd P
	    set buftype=nofile
	    set filetype=jai
	    exe "noautocmd r! jai -no_color /opt/jai/examples/module_info.jai - " . a:param 
	    noautocmd wincmd p
	endfunction
	command! -nargs=1 JaiDoc call s:OpenJaiDoc(<f-args>)

	" === Telescope ===
	nnoremap <F1> <cmd>Telescope find_files<cr>
	nnoremap <F2> <cmd>Telescope live_grep<cr>
	nnoremap <F3> <cmd>Telescope grep_string<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
     '';
     extraLuaConfig = ''
       local lspconfig = require('lspconfig')

       local opts = { noremap=true, silent=true }
       vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
       vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
       vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
       vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

       -- Use an on_attach function to only map the following keys
       -- after the language server attaches to the current buffer
       local on_attach = function(client, bufnr)
         vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

         -- Mappings.
         -- See `:help vim.lsp.*` for documentation on any of the below functions
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
       end

       -- " lspconfig['rust_analyzer'].setup {
       --     " on_attach = on_attach,
       --     " flags = lsp_flags,
       --     " -- Server-specific settings...
       --     " settings = {
       --       " ["rust-analyzer"] = {}
       --     " }
       -- " }
       
       -- run : `dotnet tool install --global csharp-ls`
       -- https://github.com/razzmatazz/csharp-language-server
       lspconfig['csharp_ls'].setup {
           cmd = {"csharp-ls"},
         on_attach = on_attach,
       }
     '';
  };
}
