local util = require "lspconfig.util"

return {
    filetypes = {
        "terraform",
        "terraform-vars",
    },
    root_dir = util.root_pattern(".git", ".terraform"),
    cmd = { "terraform-ls", "serve" },
}
