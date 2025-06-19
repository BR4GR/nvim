local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function parse_ascii_table_to_json_and_copy()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Find header line (the first line starting with |)
    local header_line
    for _, line in ipairs(lines) do
        if line:match("^|") then
            header_line = line
            break
        end
    end
    if not header_line then
        print("No header line found")
        return
    end

    -- Parse headers with trimming
    local headers = {}
    for header in header_line:gmatch("|%s*([^|]+)%s*") do
        table.insert(headers, trim(header))
    end

    -- Parse rows (lines starting with | but not separator lines)
    local data = {}
    for _, line in ipairs(lines) do
        if line:match("^|") and not line:match("^%+[-+]+%+$") and line ~= header_line then
            local row = {}
            local i = 1
            for cell in line:gmatch("|%s*([^|]+)%s*") do
                row[headers[i]] = trim(cell)
                i = i + 1
            end
            table.insert(data, row)
        end
    end

    -- Encode to JSON
    local json_string = vim.fn.json_encode(data)

    -- Copy to clipboard
    vim.fn.setreg("+", json_string)
    print("Copied JSON to clipboard")
end

return {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    {
        "kristijanhusak/vim-dadbod-ui",
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        dependencies = "vim-dadbod",
        keys = {
            { "<leader>DB", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
            {
                "<leader>DJ",
                parse_ascii_table_to_json_and_copy,
                desc = "Parse current buffer table and copy JSON to clipboard",
                noremap = true,
                silent = true,
            },
        },
        init = function()
            local data_path = vim.fn.stdpath("data")

            vim.g.db_ui_auto_execute_table_helpers = 1
            vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
            vim.g.db_ui_show_database_icon = true
            vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
            vim.g.db_ui_use_nerd_fonts = true
            vim.g.db_ui_use_nvim_notify = true

            -- NOTE: The default behavior of auto-execution of queries on save is disabled
            -- this is useful when you have a big query that you don't want to run every time
            -- you save the file running those queries can crash neovim to run use the
            -- default keymap: <leader>S
            vim.g.db_ui_execute_on_save = true
        end,
    },
}
