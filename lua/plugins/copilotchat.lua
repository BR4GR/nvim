return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            model = "claude-sonnet-4",

            window = {
                title = "dahole",
            },

            auto_follow_cursor = false,
            auto_insert_mode = false,
            chat_autocomplete = true,
            question_header = "# batman ",
            answer_header = "# robin ",

            mappings = {
                reset = {
                    normal = "<C-r>",
                    insert = "<C-r>",
                },
            },
            contexts = {
                buffers = { "listed" },
            },
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
