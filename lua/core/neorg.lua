local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    return
end

neorg.setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = { notes = "~/notes" },
            },
        },
    },
}
