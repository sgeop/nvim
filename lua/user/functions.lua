M = {}

M.packer_snapshot = function()
    vim.notify "packer install/sync complete"
    require("packer").snapshot "packer_snapshot_tmp.json"
    require("user.functions").packer_lockfile()
end

M.packer_lockfile = function()
    local config_path = vim.fn.stdpath "config"
    local snapshot_file = config_path .. "/packer_snapshot_tmp.json"
    local lock_file = config_path .. "/packer.lock.json"
    os.execute("jq --sort-keys . " .. snapshot_file .. " > " .. lock_file)
    os.remove(vim.fn.stdpath "config" .. "/packer_snapshot_tmp.json")
end

vim.api.nvim_create_user_command("PackerTmpSnapshot", function()
    require("packer").snapshot "packer_snapshot_tmp.json"
end, {})
vim.api.nvim_create_user_command("PackerLockFromTmp", M.packer_lockfile, {})

return M
