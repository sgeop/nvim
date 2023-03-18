return {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },

    max_jobs = 20,
    preview_updates = true,
    snapshot_path = vim.fn.stdpath "config",
    snapshot = "packer.lock.json",
}
