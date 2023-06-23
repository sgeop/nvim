return {
    single_file_support = true,
    settings = {
        yaml = {
            schemas = require("schemastore").yaml.schemas {
                replace = {
                    ["Argo Workflows"] = {
                        description = "Argo Workflow configuration file",
                        name = "Argo Workflows",
                        url = "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json",
                        fileMatch = { "*workflow.yaml", "*.wf.yaml" },
                    },
                },
            },
            validate = { enable = true },
        },
    },
}
