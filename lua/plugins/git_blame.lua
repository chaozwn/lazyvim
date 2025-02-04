---@type LazySpec
return {
  "f-person/git-blame.nvim",
  event = "LazyFile",
  cmd = {
    "GitBlameToggle",
    "GitBlameEnable",
    "GitBlameOpenCommitURL",
    "GitBlameCopyCommitURL",
    "GitBlameOpenFileURL",
    "GitBlameCopyFileURL",
    "GitBlameCopySHA",
  },
  opts = {
    enabled = true,
    date_format = "%r",
    message_template = "  <author> 󰔠 <date> 󰈚 <summary>  <sha>",
    message_when_not_committed = "  Not Committed Yet",
  },
}
