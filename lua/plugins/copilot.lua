return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      filetypes = {
        ["*"] = true,
      },
      panel = { enabled = true },
      suggestion = {
        auto_trigger = true,
        keymap = {
          next = "<C-n>",
          prev = "<C-p>",
          accept = "<C-y>",
          accept_word = "<M-u>",
          auto_complete = "<C-space>",
        },
      },
      inline_suggestion = { enabled = true },
      jump_to_mark = { enabled = true },
      ghost_text = { enabled = true },
    })
  end,
}
