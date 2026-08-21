local lfs = require("lfs")
local CODE_SEG_CLIENT = 1
local CODE_SEG_SERVER = 2
local CODE_SEG_BOTH = 3
local CLIENT_CODE_SEG = "CLIENT_CODE_SEG"
local SERVER_CODE_SEG = "SERVER_CODE_SEG"

local function has_prefix(s, prefix)
  return s:sub(1, #prefix) == prefix
end

function parser_template(templFile)
  local clientCodes = {}
  local serverCodes = {}
  local code_seg_mark = CODE_SEG_BOTH
  local skip_bytes_num = 0
  local ft = io.open(templFile, "r")
  for line in ft:lines() do
    if line:sub(1, 5) == "--#if" then
      assert(code_seg_mark == CODE_SEG_BOTH)
      local mark = line:sub(7)
      if has_prefix(mark, CLIENT_CODE_SEG) then
        local skipBytes = string.match(mark:sub(#CLIENT_CODE_SEG + 1), "(%d+)")
        skipBytes = tonumber(skipBytes)
        if skipBytes then
          skip_bytes_num = skipBytes
        end
        code_seg_mark = CODE_SEG_CLIENT
      elseif has_prefix(mark, SERVER_CODE_SEG) then
        local skipBytes = string.match(mark:sub(#SERVER_CODE_SEG + 1), "(%d+)")
        skipBytes = tonumber(skipBytes)
        if skipBytes then
          skip_bytes_num = skipBytes
        end
        code_seg_mark = CODE_SEG_SERVER
      else
        error("unknown code seg mark" .. mark)
      end
    elseif line:sub(1, 7) == "--#else" then
      assert(code_seg_mark ~= CODE_SEG_BOTH)
      code_seg_mark = CODE_SEG_BOTH - code_seg_mark
    elseif line:sub(1, 8) == "--#endif" then
      code_seg_mark = CODE_SEG_BOTH
      skip_bytes_num = 0
    elseif code_seg_mark == CODE_SEG_BOTH then
      clientCodes[#clientCodes + 1] = line:sub(skip_bytes_num + 1)
      serverCodes[#serverCodes + 1] = line:sub(skip_bytes_num + 1)
    elseif code_seg_mark == CODE_SEG_SERVER then
      serverCodes[#serverCodes + 1] = line:sub(skip_bytes_num + 1)
    elseif code_seg_mark == CODE_SEG_CLIENT then
      clientCodes[#clientCodes + 1] = line:sub(skip_bytes_num + 1)
    end
  end
  ft:close()
  return table.concat(clientCodes, "\n"), table.concat(serverCodes, "\n")
end

function generate_code(clientFile, clientStream, serverFile, serverStream)
  local fc = io.open(clientFile, "w+")
  fc:write("----This file is generated, don't modify it manually!----\n")
  fc:write("----Client Code Generate Begin----\n")
  fc:write(clientStream)
  fc:write([[

----Client Code Generate End----]])
  fc:close()
  local fs = io.open(serverFile, "w+")
  fs:write("----This file is generated, don't modify it manually!----\n")
  fs:write("----Server Code Generate Begin----\n")
  fs:write(serverStream)
  fs:write([[

----Server Code Generate End----]])
  fs:close()
end

local client_manager_path = "../../../Client/lua/manager/"
local client_magic_path = client_manager_path .. "magic/"
local client_fight_path = "../../../Client/lua/manager/fight/"
local client_utils_path = "../../../Client/lua/utils/"
local server_battle_path = "../../service/battle/"
local server_magic_path = server_battle_path .. "magic/"
local server_utils_path = "../../service/utils/"
local export_list = {
  {
    "attr_mgr/attr_mgr.templ",
    client_manager_path .. "attr_mgr/attr_mgr.lua",
    server_battle_path .. "attr_mgr/attr_mgr.lua"
  },
  {
    "magic/magic_event/magic_event.templ",
    client_magic_path .. "magic_event/magic_event.lua",
    server_magic_path .. "magic_event/magic_event.lua"
  },
  {
    "magic/magic_event/magic_effect_func.templ",
    client_magic_path .. "magic_event/magic_effect_func.lua",
    server_magic_path .. "magic_event/magic_effect_func.lua"
  },
  {
    "magic/magic_pool.templ",
    client_magic_path .. "magic_pool.lua",
    server_magic_path .. "magic_pool.lua"
  },
  {
    "element/element_abnormal_mgr.templ",
    client_fight_path .. "element_abnormal_mgr.lua",
    server_battle_path .. "element_abnormal_mgr/element_abnormal_mgr.lua"
  },
  {
    "utils/single_attr_proxy_table.templ",
    client_utils_path .. "single_attr_proxy_table.lua",
    server_utils_path .. "single_attr_proxy_table.lua"
  }
}
local magic_imp_dir = "magic/magic_imp"
for file in lfs.dir(magic_imp_dir) do
  if file:sub(-6, -1) == ".templ" then
    local prefix = file:sub(1, -7)
    local client_file = client_magic_path .. "magic_imp/" .. prefix .. ".lua"
    local server_file = server_magic_path .. "magic_imp/" .. prefix .. ".lua"
    export_list[#export_list + 1] = {
      magic_imp_dir .. "/" .. file,
      client_file,
      server_file
    }
  end
end
for _, cfg in ipairs(export_list) do
  local cstream, sstream = parser_template(cfg[1])
  generate_code(cfg[2], cstream, cfg[3], sstream)
end
print("template export done!")
