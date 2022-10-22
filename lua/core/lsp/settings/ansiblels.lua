local util = require "lspconfig.util"

return {
    filetypes = {
        "yaml.ansible",
        -- "yaml",
    },
    root_dir = util.root_pattern("ansible.cfg", ".ansible-lint"),
    single_file_support = true,
    settings = {
        ansible = {
            ansible = {
                path = "ansible",
                useFullyQualifiedCollectionNames = true,
            },
            ansibleLint = {
                enabled = true,
                path = "ansible-lint",
            },
            executionEnvironment = {
                enabled = false,
            },
            python = {
                interpreterPath = "python",
            },
            completion = {
                provideRedirectModules = true,
                provideModuleOptionAliases = true,
            },
        },
    },
}
