local M = {}

-- This file is automatically ran last in the setup process and is a good place to configure
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
function M.yaml_ft(path, bufnr)
  local buf_text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  if
    -- check if file is in roles, tasks, or handlers folder
    vim.regex("(tasks\\|roles\\|handlers)/"):match_str(path)
    -- check for known ansible playbook text and if found, return yaml.ansible
    or vim.regex("hosts:\\|tasks:"):match_str(buf_text)
  then
    return "yaml.ansible"
  elseif vim.regex("AWSTemplateFormatVersion:"):match_str(buf_text) then
    return "yaml.cfn"
  else -- return yaml if nothing else
    return "yaml"
  end
end

function M.remove_keymap(mode, key)
  for _, map in pairs(vim.api.nvim_get_keymap(mode)) do
    ---@diagnostic disable-next-line: undefined-field
    if map.lhs:upper() == key:upper() then
      vim.api.nvim_del_keymap(mode, key)
      return map
    end
  end
end

function M.contains_arg(args, arg)
  for _, v in ipairs(args) do
    if v == arg then
      return true
    end
  end
  return false
end

function M.get_parent_dir(path)
  return path:match("(.+)/")
end

function M.file_exists(filepath)
  return vim.fn.glob(filepath) ~= ""
end

function M.copy_file(source_file, target_file)
  local target_file_parent_path = M.get_parent_dir(target_file)
  local cmd = string.format("mkdir -p %s", vim.fn.shellescape(target_file_parent_path))
  os.execute(cmd)
  cmd = string.format("cp %s %s", vim.fn.shellescape(source_file), vim.fn.shellescape(target_file))
  os.execute(cmd)
  vim.schedule(function()
    vim.notify("File " .. target_file .. " created success.", vim.log.levels.INFO)
  end)
end

function M.get_launch_json_by_source_file(source_file)
  local target_file = vim.fn.getcwd() .. "/.vscode/launch.json"
  local file_exist = M.file_exists(target_file)
  if file_exist then
    local confirm = vim.fn.confirm("File `.vscode/launch.json` Exist, Overwrite it?", "&Yes\n&No", 1, "Question")
    if confirm == 1 then
      M.copy_file(source_file, target_file)
    end
  else
    M.copy_file(source_file, target_file)
  end
end

function M.create_launch_json()
  vim.ui.select({
    "go",
    "node",
    "rust",
    "python",
    "chrome",
    "angular",
    "nextjs",
  }, { prompt = "Select Language Debug Template: ", default = "go" }, function(select)
    if not select then
      return
    end
    if select == "go" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/go_launch.json"
      M.get_launch_json_by_source_file(source_file)
    elseif select == "node" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/node_launch.json"
      M.get_launch_json_by_source_file(source_file)
    elseif select == "rust" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/rust_launch.json"
      M.get_launch_json_by_source_file(source_file)
      source_file = vim.fn.stdpath("config") .. "/.vscode/rust_tasks.json"
      M.get_tasks_json_by_source_file(source_file)
    elseif select == "python" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/python_launch.json"
      M.get_launch_json_by_source_file(source_file)
    elseif select == "chrome" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/chrome_launch.json"
      M.get_launch_json_by_source_file(source_file)
    elseif select == "angular" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/angular_launch.json"
      M.get_launch_json_by_source_file(source_file)
      source_file = vim.fn.stdpath("config") .. "/.vscode/angular_tasks.json"
      M.get_tasks_json_by_source_file(source_file)
    elseif select == "nextjs" then
      local source_file = vim.fn.stdpath("config") .. "/.vscode/nextjs_launch.json"
      M.get_launch_json_by_source_file(source_file)
    end
  end)
end

function M.remove_keys(key_binding, remove_key_list)
  for i1, v1 in ipairs(remove_key_list) do
    for i2, v2 in ipairs(key_binding) do
      if v1:upper() == v2[1]:upper() then
        table.remove(key_binding, i2)
      end
    end
  end
end

function M.better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then
      vim.schedule(function()
        vim.notify(error, vim.log.levels.ERROR)
      end)
    end
  end
end

--- Insert one or more values into a list like table and maintain that you do not insert non-unique values (THIS MODIFIES `dst`)
---@param dst any[]|nil The list like table that you want to insert into
---@param src any[] Values to be inserted
---@return any[] # The modified list like table
function M.list_insert_unique(dst, src)
  if not dst then
    dst = {}
  end
  local added = {}
  for _, val in ipairs(dst) do
    added[val] = true
  end
  for _, val in ipairs(src) do
    if not added[val] then
      table.insert(dst, val)
      added[val] = true
    end
  end
  return dst
end

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

function M.size(max, value)
  return value > 1 and math.min(value, max) or math.floor(max * value)
end

return M
