return {
    -- 1. Configure mason-nvim-dap to ensure php-debug-adapter is installed
    {
        "jay-babu/mason-nvim-dap.nvim",
        -- This opts function will be merged with the existing opts for mason-nvim-dap
        opts = function(_, opts)
            -- Ensure that the 'php-debug-adapter' is added to the list of adapters to be installed
            opts.ensure_installed = opts.ensure_installed or {}
            if not vim.tbl_contains(opts.ensure_installed, "php-debug-adapter") then
                table.insert(opts.ensure_installed, "php-debug-adapter")
            end
            -- You could also set up automatic installation for other adapters here
            -- Example: table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
    },

    -- 2. Configure nvim-dap for PHP
    {
        "mfussenegger/nvim-dap",
        -- The config function will be called after the plugin is loaded.
        -- LazyVim's base DAP config will have already run.
        config = function()
            -- It's good practice to ensure dap is available, though it should be by this point
            local dap = require("dap")
            if not dap then
                return
            end

            -- Define the PHP debug adapter
            -- This tells nvim-dap how to communicate with the php-debug-adapter
            dap.adapters.php = {
                type = "executable",
                command = "php-debug-adapter", -- This should be in your PATH (Mason handles this)
                name = "PHP Debug Adapter (Xdebug)",
            }

            -- Define PHP launch configurations
            -- These are the "profiles" you can choose when starting a debug session
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003, -- Ensure this matches xdebug.client_port in your php container
                    -- stopOnEntry = false,
                    breakOnException = true,
                    breakOnError = true,
                    pathMappings = {
                        ["/opt/"] = "${workspaceFolder}", -- Corrected mapping
                    },
                    -- log = true,
                },
                {
                    type = "php",
                    request = "launch",
                    name = "Launch current script (Xdebug)",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    port = 9003, -- Ensure this matches xdebug.client_port
                    -- stopOnEntry = false,
                    breakOnException = true,
                    breakOnError = true,
                    pathMappings = {
                        ["/opt/"] = "${workspaceFolder}", -- Corrected mapping
                    },
                    -- log = true,
                },
            }
            -- You can add more configurations here if needed

            -- Note: Keymaps and DAP UI setup are already handled by LazyVim's default DAP configuration.
            -- This file just adds the PHP-specific parts.
        end,
    },
}
