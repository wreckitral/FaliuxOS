return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional dependencies
        "nvim-tree/nvim-web-devicons",
        "rcarriga/nvim-notify",
    },
    opts = {
        -- Defines the command to launch the plugin from terminal
        arg = "leetcode.nvim",

        -- Set your preferred language (e.g., "python3", "golang", "cpp")
        lang = "python3",

        -- Use telescope for UI prompts
        injector = {},
        storage = {
            home = "/home/faliux/ohToBeCrack/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
        logging = true,
        console = {
            open_on_runcode = true,
            dir = "row",
        },
    },
}
