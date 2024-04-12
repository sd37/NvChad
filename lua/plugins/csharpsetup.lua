return {
  "sd37/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function()
    require("mason").setup() -- Mason setup must run before csharp

    local opts = {
      lsp = {
        -- When set, csharp.nvim won't install omnisharp automatically. Instead, the omnisharp instance in the cmd_path will be used.
        cmd_path = "omnisharp.cmd",
      },
    }

    require("csharp").setup(opts)
  end,
  ft = { "cs" },
}
