return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = "/usr/bin/codelldb", -- rendszeredtől függ
          args = {"--port", "${port}"},
        }
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", "./", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
}

