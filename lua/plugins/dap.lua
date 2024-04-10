return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
      },
      "nvim-neotest/nvim-nio",
      "folke/neodev.nvim",

      -- Lua adapter.
      {
        'jbyuki/one-small-step-for-vimkind',
      },
    },
    keys = {
        {
          '<leader>db',
          function()
            require('dap').toggle_breakpoint()
          end,
          desc = 'Toggle breakpoint',
        },
        {
          '<leader>dl',
          function()
            require('osv').launch { port = 8086 }
          end,
          desc = 'Launch Lua adapter',
        },
    },
    config = function ()
      local dap = require('dap')

      -- Lua configurations.
      dap.adapters.nlua = function(callback, config)
        callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
      end
      dap.configurations['lua'] = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to running Neovim instance',
          port = 8086
        },
      }
    end
  }
}
