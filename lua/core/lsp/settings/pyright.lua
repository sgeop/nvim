return {
    single_file_support = true,
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
}
