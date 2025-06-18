return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            -- Define the PHP debug adapter
            -- This tells nvim-dap how to communicate with the php-debug-adapter
            dap.adapters.php = {
                type = "executable",
                command = "php-debug-adapter",
                name = "PHP Debug Adapter (Xdebug)",
            }

            -- Define PHP launch configurations
            -- These are the "profiles" you can choose when starting a debug session
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003,
                    breakOnException = true,
                    breakOnError = true,
                    pathMappings = {
                        ["/opt/"] = "${workspaceFolder}",
                    },
                },
                {
                    type = "php",
                    request = "launch",
                    name = "Launch current script (Xdebug)",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    port = 9003,
                    breakOnException = true,
                    breakOnError = true,
                    pathMappings = {
                        ["/opt/"] = "${workspaceFolder}",
                    },
                },
            }

            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

            -- Eval var under cursor
            vim.keymap.set("n", "<F9>", function()
                require("dapui").eval(nil, { enter = true, context = "hover" })
            end)

            vim.keymap.set("n", "<F4>", dap.continue)
            vim.keymap.set("n", "<F5>", dap.step_over)
            vim.keymap.set("n", "<F6>", dap.step_into)
            vim.keymap.set("n", "<F7>", dap.step_out)
            vim.keymap.set("n", "<F8>", dap.step_back)
            vim.keymap.set("n", "<F9>", dap.stop)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
            dap.defaults.fallback.exception_breakpoints = { "raised", "uncaught" }
        end,
    },
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
}
