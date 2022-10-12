return {
  settings = {
    gopls = {
      analyses = {
        unreachable = true,
        nillness = true,
        unusedparam = true,
        useany = true,
        unusedwrite = true,
        undeclaredname = true,
        fillreturns = true,
        nonewvars = true,
        fieldalignment = true,
      },
      usePlaceholders = true,
      staticcheck = true,
    }
  }
}
