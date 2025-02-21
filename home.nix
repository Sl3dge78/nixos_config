{ config, pkgs, lib, inputs, ... }:
let 
  jai-vim = pkgs.vimUtils.buildVimPlugin {
    name = "jai-vim";
    src = inputs.jai-vim;
  };
  in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sl3dge";
  home.homeDirectory = "/home/sl3dge";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.lazygit
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sl3dge/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "sl3dge78";
    userEmail = "sl3dge78@users.noreply.github.com";
  };

  # ======== NVIM ========
  programs.neovim = {
     enable = true;
     defaultEditor = true;
     plugins = with pkgs.vimPlugins; [
	gruvbox
	vim-airline
	lazygit-nvim
	vim-dispatch
	plenary-nvim
	jai-vim 
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


  # ======== CINNAMON ========
  dconf.settings = {
	"org/cinnamon" = {
		enabled-applets = [
			"panel1:left:0:menu@cinnamon.org:0"
			"panel1:left:1:separator@cinnamon.org:1"
			"panel1:right:1:systray@cinnamon.org:3"
			"panel1:right:2:xapp-status@cinnamon.org:4"
			"panel1:right:3:notifications@cinnamon.org:5"
			"panel1:right:6:keyboard@cinnamon.org:8"
			"panel1:right:8:network@cinnamon.org:10"
			"panel1:right:9:sound@cinnamon.org:11"
			"panel1:right:11:calendar@cinnamon.org:13"
			"panel1:right:12:cornerbar@cinnamon.org:14"
			"panel1:left:2:window-list@cinnamon.org:15"
		];
		next-applet-id = 16;
		panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";
		panels-enabled = ["1:0:top"];
		panels-height = ["1:20"];
	};
    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Aqua";
    };
    "org/cinnamon/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Classic";
      gtk-theme = "Mint-Y-Dark-Aqua";
      icon-theme = "Mint-Y-Sand";
    };
    "org/gnome/desktop/interface" = {
      gtk-theme = "Mint-Y-Dark-Aqua";
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
      exec-arg = "";
    };
    "org/cinnamon/desktop/wm/preferences" = {
      mouse-button-modifier = "<Super>";
    };
    "org/gnome/desktop/wm/preferences" = {
      mouse-button-modifier = "<Super>";
    };
    "org/nemo/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = true;
    };
    "org/x/apps/portal" = {
      color-scheme = "prefer-dark";
    };
  };
}
