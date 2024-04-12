-- Debugging.
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        opts = {
          floating = { border = "rounded" },
          layouts = {
            {
              elements = {
                { id = "stacks", size = 0.30 },
                { id = "breakpoints", size = 0.20 },
                { id = "scopes", size = 0.50 },
              },
              position = "left",
              size = 40,
            },
          },
        },
      },
      -- Virtual text.
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          virt_text_pos = "eol",
        },
      },
      -- Lua adapter.
      {
        "jbyuki/one-small-step-for-vimkind",
        keys = {
          {
            "<leader>dl",
            function()
              require("osv").launch { port = 8086 }
            end,
            desc = "Launch Lua adapter",
          },
        },
      },
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        "<cmd>FzfLua dap_breakpoints<cr>",
        desc = "List breakpoints",
      },
      {
        "<leader>dc",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Breakpoint condition",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dx",
        function()
          require("dapui").close()
        end,
        desc = "Close DAP UI",
      },
      {
        "<leader>dt",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- Automatically open the UI when a new debug session is created.
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Lua configurations.
      dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
      end
      dap.configurations["lua"] = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }
    end,
  },
}
