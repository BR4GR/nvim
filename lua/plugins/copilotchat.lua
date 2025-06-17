return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            model = "claude-sonnet-4",

            window = {
                title = "dahole",
            },

            highlight_headers = false,
            error_header = "> [!ERROR] Error",
            separator = "---",

            auto_follow_cursor = false,
            auto_insert_mode = false,
            chat_autocomplete = false,
            question_header = "# batman ",
            answer_header = "# robin ",

            mappings = {
                reset = {
                    normal = "<C-r>",
                    insert = "<C-r>",
                },
            },
            contexts = {
                buffer = { "listed" },
            },
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
