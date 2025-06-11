# PHP Xdebug Setup for LazyVim in WSL with Docker

This guide explains how to set up PHP debugging with Xdebug in Neovim using LazyVim when working in a WSL environment with Docker containers.

## Prerequisites

- WSL with a Linux distribution
- Docker installed natively within WSL (not Docker Desktop)
- Neovim with LazyVim configuration
- PHP project running in Docker containers

## Step 1: LazyVim DAP Configuration

Create a new file `lua/plugins/dap_php.lua` in your Neovim configuration:

```lua
-- filepath: lua/plugins/dap_php.lua
return {
  -- 1. Configure mason-nvim-dap to ensure php-debug-adapter is installed
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "php-debug-adapter") then
        table.insert(opts.ensure_installed, "php-debug-adapter")
      end
    end,
  },

  -- 2. Configure nvim-dap for PHP
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      if not dap then
        return
      end

      -- Define the PHP debug adapter
      dap.adapters.php = {
        type = "executable",
        command = "php-debug-adapter",
        name = "PHP Debug Adapter (Xdebug)",
      }

      -- Define PHP launch configurations
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003, -- Xdebug 3 default port
          pathMappings = {
            ["/opt/"] = "${workspaceFolder}", -- Adjust based on your Docker volume mapping
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Launch current script (Xdebug)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          port = 9003,
          pathMappings = {
            ["/opt/"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },
}