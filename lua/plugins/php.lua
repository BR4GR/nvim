return {
    -- LSP config for PHP
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- @type lspconfig.options
            servers = {
                intelephense = {
                    filetypes = { "php", "blade", "php_only" },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade", "php_only" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
                            },
                        },
                    },
                },
            },
        },
    },

    -- Configure formatter using conform.nvim (new approach)
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                php = { "phpcbf" },
                javascript = { "eslint_d" },
                html = { "htmlhint" },
            },
            formatters = {
                phpcbf = {
                    prepend_args = { "--standard=PSR12" },
                    cwd = function(ctx)
                        -- Try to use local version first
                        return vim.fs.dirname(
                            vim.fs.find({ "vendor/bin/phpcbf" }, { path = ctx.filename, upward = true })[1] or ""
                        )
                    end,
                },
            },
        },
    },

    -- Configure linter using nvim-lint (new approach)
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                php = { "phpcs" },
                html = { "htmlhint" },
            },
            linters = {
                phpcs = {
                    args = {
                        "--report=json",
                        "-s",
                        "--standard=PSR12",
                        "-",
                    },
                    ignore_exitcode = true,
                    prepend_args = function(_, ctx)
                        -- Try to use local version if available
                        local local_phpcs =
                            vim.fs.find({ "vendor/bin/phpcs" }, { path = ctx.filename, upward = true })[1]
                        if local_phpcs then
                            return { local_phpcs }
                        end
                        return {}
                    end,
                },
            },
        },
    },
}
