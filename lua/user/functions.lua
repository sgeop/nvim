local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify "could not load packer"
end

local config_path = vim.fn.stdpath "config"
local snapshot_file = "packer_snapshot_tmp.json"
local snapshot_file_absolute = config_path .. snapshot_file
local lockfile_absolute = config_path .. "packer.lock.json"

local packer_snapshot = function()
    packer.snapshot(snapshot_file)
end

local packer_lockfile = function()
    os.execute("jq --sort-keys . " .. snapshot_file_absolute .. " > " .. lockfile_absolute)
    os.remove(snapshot_file_absolute)
end

vim.api.nvim_create_user_command("PackerTmpSnapshot", packer_snapshot, {})
vim.api.nvim_create_user_command("PackerLockFromTmp", packer_lockfile, {})
