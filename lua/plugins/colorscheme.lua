return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        -- 1) first, disable the built-in bg:
        require("rose-pine").setup({
            disable_background = true, -- no more rose-pine bg
            -- disable_float_background = true, -- same for floats
            -- you can still override any groups:
            highlight_groups = {
                -- explicitly set Normal / NormalFloat to black
                -- Normal = { bg = "#000000" },
                -- NormalFloat = { bg = "#000000" },
            },
        })
        -- 2) load the colorscheme
        vim.cmd("colorscheme rose-pine")

        -- 3) (optional) if you need to override again at runtime:
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
    end,
}
