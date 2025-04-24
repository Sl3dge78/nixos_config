# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "sl3dge";
    homeDirectory = "/home/sl3dge";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    gohufont
    lazygit
	discord
    alacritty
    git-credential-oauth
    unzip
    # outputs.packages.${system}.jai
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "sl3dge78";
    userEmail = "sl3dge78@users.noreply.github.com";
    extraConfig.credential.helper = "oauth";
    extraConfig.credential.credentialStore = "cache --timeout 21600";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  # ======== ALACRITTY ========
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          startup_mode = "Maximized";
        };
        font = {
          size = 10;
          normal.family = "GohuFont";
        };
        colors = {
          primary = {
            background = "#282828";
            foreground = "#ebdbb2";
          };
          normal = {
            black   = "#282828";
            red     = "#cc241d";
            green   = "#98971a";
            yellow  = "#d79921";
            blue    = "#458588";
            magenta = "#b16286";
            cyan    = "#689d6a";
            white   = "#a89984";
          };
          bright = {
            black   = "#928374";
            red     = "#fb4934";
            green   = "#b8bb26";
            yellow  = "#fabd2f";
            blue    = "#83a598";
            magenta = "#d3869b";
            cyan    = "#8ec07c";
            white   = "#ebdbb2";
          };
        };
      };
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
            "panel2:right:1:calendar@cinnamon.org:16"
            "panel2:left:0:window-list@cinnamon.org:17"
		];
		next-applet-id = 18;
        panel-zone-icon-sizes = "[{\"panelId\":1,\"left\":0,\"center\":0,\"right\":24},{\"left\":0,\"center\":0,\"right\":0,\"panelId\":2}]";
        panel-zone-symbolic-icon-sizes = "[{\"panelId\":1,\"left\":28,\"center\":28,\"right\":16},{\"left\":28,\"center\":28,\"right\":28,\"panelId\":2}]";
        panel-zone-text-sizes = "[{\"panelId\":1,\"left\":0,\"center\":0,\"right\":0},{\"left\":0,\"center\":0,\"right\":0,\"panelId\":2}]";
		panels-enabled = ["1:0:top" "2:1:top"];
		panels-height = ["1:20" "2:20"];
        panels-autohide = ["1:false" "2:false"];
        panels-hide-delay = ["1:0" "2:0"];
        panels-show-delay = ["1:0" "2:0"];
	};
    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Aqua";
    };
    "org/cinnamon/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Classic";
      gtk-theme = "Mint-Y-Dark-Aqua";
      icon-theme = "Mint-Y-Sand";
      monospace-font-name = "GohuFont 10";
      font-name = "Ubuntu 10";
    };
    "org/gnome/desktop/interface" = {
      gtk-theme = "Mint-Y-Dark-Aqua";
      monospace-font-name = "GohuFont 10";
      document-font-name = "Sans 10";
      font-name = "Ubuntu 10";
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
      exec-arg = "";
    };
    "org/cinnamon/desktop/wm/preferences" = {
      mouse-button-modifier = "<Super>";
      titlebar-font = "Ubuntu 10";
    };
    "org/gnome/desktop/wm/preferences" = {
      mouse-button-modifier = "<Super>";
      titlebar-font = "Ubuntu 10";
    };
    "org/nemo/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = true;
    };
    "org/nemo/desktop" = {
      font = "Ubuntu 10";
    };
    "org/x/apps/portal" = {
      color-scheme = "prefer-dark";
    };
  };
}
