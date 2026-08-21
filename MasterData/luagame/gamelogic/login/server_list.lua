local M = Util.create_class()
local LocalStorage = require("utils.localstorage")

function M:_init()
  if GAME_DEBUG or UNITY_EDITOR or PUBLISH_GM then
    self:_init_server_list_by_local_config()
  end
end

function M:_init_server_list_by_local_config()
  self.server_list = {}
  for _, server_info in ipairs(ShareRes.create("common.server_list")) do
    local show = false
    if UNITY_EDITOR then
      if not server_info.DontShowInPC then
        show = true
      end
    elseif GAME_RELEASE then
      show = 1 == server_info.tag
    else
      show = 1 == server_info.DebugTag
    end
    if show then
      table.insert(self.server_list, server_info)
    end
  end
end

function M:init_server_list_by_net_data(data)
  self.server_list = {}
  for _, server_info in pairs(data) do
    local show = false
    if UNITY_EDITOR then
      if not server_info.DontShowInPC then
        show = true
      end
    elseif GAME_RELEASE then
      show = 1 == server_info.tag
    else
      show = 1 == server_info.DebugTag
    end
    if show then
      table.insert(self.server_list, server_info)
    end
  end
end

function M:get_server_list()
  return self.server_list
end

function M:get_default_server()
  local id = self:get_default_server_id()
  return self.server_list and self.server_list[id]
end

function M:get_default_server_id()
  local last_selected_server = LocalStorage:load_int(Config.SELECTED_SERVER_KEY, 1)
  return self.server_list and self.server_list[last_selected_server] and last_selected_server or 1
end

return M
