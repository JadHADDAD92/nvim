return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    mason.setup()

    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    -- load per-server tables from lua/lsp/*.lua
    local lsp_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/lsp", "*.lua", false, true)
    for _, file_path in ipairs(lsp_files) do
      local server = vim.fn.fnamemodify(file_path, ":t:r")
      local ok, custom = pcall(require, "lsp." .. server)
      local cfg = { capabilities = capabilities }
      if ok and type(custom) == "table" then
        cfg = vim.tbl_deep_extend("force", cfg, custom)
      end

      vim.lsp.config(server, cfg)
      vim.lsp.enable(server)
    end
  end,
}
