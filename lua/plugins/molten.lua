local prefix = "<leader>j"

local function ensure_kernel_for_venv()
  local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
  if not venv_path then
    vim.notify("No virtual environment found.", vim.log.levels.WARN)
    return
  end

  -- Canonicalize the venv_path to ensure consistency
  venv_path = vim.fn.fnamemodify(venv_path, ":p")

  -- Check if the kernel spec already exists
  local handle = io.popen("jupyter kernelspec list --json")
  local existing_kernels = {}
  if handle then
    local result = handle:read("*a")
    handle:close()
    local json = vim.fn.json_decode(result)
    -- Iterate over available kernel specs to find the one for this virtual environment
    for kernel_name, data in pairs(json.kernelspecs) do
      existing_kernels[kernel_name] = true -- Store existing kernel names for validation
      local kernel_path = vim.fn.fnamemodify(data.spec.argv[1], ":p") -- Canonicalize the kernel path
      if kernel_path:find(venv_path, 1, true) then
        vim.notify("Kernel spec for this virtual environment already exists.", vim.log.levels.INFO)
        return kernel_name
      end
    end
  end

  -- Prompt the user for a custom kernel name, ensuring it is unique
  local new_kernel_name
  repeat
    new_kernel_name = vim.fn.input("Enter a unique name for the new kernel spec: ")
    if new_kernel_name == "" then
      vim.notify("Please provide a valid kernel name.", vim.log.levels.ERROR)
      return
    elseif existing_kernels[new_kernel_name] then
      vim.notify(
        "Kernel name '" .. new_kernel_name .. "' already exists. Please choose another name.",
        vim.log.levels.WARN
      )
      new_kernel_name = nil
    end
  until new_kernel_name

  -- Create the kernel spec with the unique name
  print("Creating a new kernel spec for this virtual environment...")
  local cmd = string.format(
    '%s -m ipykernel install --user --name="%s"',
    vim.fn.shellescape(venv_path .. "/bin/python"),
    new_kernel_name
  )

  os.execute(cmd)
  vim.notify("Kernel spec '" .. new_kernel_name .. "' created successfully.", vim.log.levels.INFO)
  return new_kernel_name
end

---@type LazySpec
return {
  "benlubas/molten-nvim",
  ft = { "python" },
  cmd = {
    "MoltenEvaluateLine",
    "MoltenEvaluateVisual",
    "MoltenEvaluateOperator",
    "MoltenEvaluateArgument",
    "MoltenImportOutput",
  },
  version = "^1", -- use version <2.0.0 to avoid breaking changes
  build = ":UpdateRemotePlugins",
  opts = function()
    vim.g["molten_auto_image_popup"] = false
    vim.g["molten_auto_open_html_in_browser"] = false
    vim.g["molten_auto_open_output"] = false
    vim.g["molten_cover_empty_lines"] = true

    vim.g["molten_enter_output_behavior"] = "open_and_enter"
    -- molten_output
    vim.g["molten_image_location"] = "both"
    vim.g["molten_image_provider"] = "image.nvim"
    vim.g["molten_output_show_more"] = true
    vim.g["molten_use_border_highlights"] = true

    vim.g["molten_output_virt_lines"] = false
    vim.g["molten_virt_lines_off_by_1"] = false
    vim.g["molten_virt_text_output"] = false
    vim.g["molten_wrap_output"] = true
  end,
  keys = {
    {
      prefix .. "e",
      function()
        vim.cmd([[MoltenEvaluateOperator]])
      end,
      desc = "Run operator selection",
    },
    {
      prefix .. "l",
      function()
        vim.cmd([[MoltenEvaluateLine]])
      end,
      desc = "Evaluate line",
    },
    {
      prefix .. "c",
      function()
        vim.cmd([[MoltenReevaluateCell]])
      end,
      desc = "Re-evaluate cell",
    },
    {
      prefix .. "k",
      ":noautocmd MoltenEnterOutput<cr>",
      desc = "Enter Output",
    },
    {
      prefix .. "K",
      function()
        vim.cmd("noautocmd MoltenEnterOutput")
        if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        end
      end,
      desc = "Enter Output",
    },
    {
      prefix .. "mi",
      function()
        vim.cmd([[MoltenInit]])
      end,
      desc = "Initialize the plugin",
    },
    {
      prefix .. "mh",
      function()
        vim.cmd([[MoltenHideOutput]])
      end,
      desc = "Hide Output",
    },
    {
      prefix .. "mI",
      function()
        vim.cmd([[MoltenInterrupt]])
      end,
      desc = "Interrupt kernel",
    },
    {
      prefix .. "mR",
      function()
        vim.cmd([[MoltenRestart]])
      end,
      desc = "Restart kernel",
    },
    {
      prefix .. "mp",
      function()
        local kernel_name = ensure_kernel_for_venv()
        if kernel_name then
          vim.cmd(("MoltenInit %s"):format(kernel_name))
        else
          vim.notify("No kernel to initialize.", vim.log.levels.WARN)
        end
      end,
      desc = "Restart kernel",
      silent = true,
    },
    {
      prefix .. "r",
      ":<C-u>MoltenEvaluateVisual<cr>",
      desc = "Evaluate visual selection",
      mode = "v",
    },
    {
      "]c",
      "<Cmd>MoltenNext<CR>",
      desc = "Next Molten Cell",
    },
    {
      "[c",
      "<Cmd>MoltenPrev<CR>",
      desc = "Previous Molten Cell",
    },
  },
  specs = {
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        spec = {
          { prefix, group = "Molten", icon = "󱓞", mode = { "n", "v" } },
          { prefix .. "m", group = "Commands", icon = "󱓞" },
        },
      },
    },
  },
}
