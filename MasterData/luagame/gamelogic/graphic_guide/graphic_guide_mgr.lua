local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local Graphic_Guide_Cfg = require("uimodule.graphic_guide.graphic_guide_cfg")

function M:init_sys()
  Base.init_sys(self)
  self.v_complete_list = {}
  self.read_direction_cfg = Graphic_Guide_Cfg.READ_DIR
  self.read_state_cfg = Graphic_Guide_Cfg.READ_STA
  self.v_all_grphic = ShareRes.create("graphic_guide.graphic_guide_detail")
  self.v_save_state = ShareRes.create("graphic_guide.graphic_guide_save")
  self.now_page_index = 1
  self.group_id = 0
  self.need_save_groups = {}
  self:get_need_save_groups()
end

function M:refresh()
  self.now_page_index = 1
end

function M:player_operation(direction)
  if direction == self.read_direction_cfg.FORWARD then
    if self.now_page_index == self.now_group_len then
      return false
    else
      self.now_page_index = self.now_page_index + 1
    end
  elseif direction == self.read_direction_cfg.BACK then
    if 1 == self.now_page_index then
      return false
    else
      self.now_page_index = self.now_page_index - 1
    end
  end
end

function M:init(group_id)
  if nil == group_id then
    Log.Error("组id为空")
  end
  self.group_id = group_id
  local save_state = self:check_save_state()
  local com_state = self:check_compelete_list()
  local ui_chapter_detail_info = UIMgr:try_get_visible_ui("ui_chapter_detail_info")
  if ui_chapter_detail_info then
    ui_chapter_detail_info:record_group_id(group_id)
    return
  end
  if save_state then
    if com_state then
      UIMgr:get_ui("graphic_guide"):ui_show()
    else
      self:finish_teaching()
    end
  else
    UIMgr:get_ui("graphic_guide"):ui_show()
  end
end

local function _sorter(a, b)
  if a.sort == b.sort then
    return a.id < b.id
  end
  return a.sort < b.sort
end

function M:get_spec_group_data()
  self.v_spec_group_data = {}
  for _, data in pairs(self.v_all_grphic) do
    if data.group == self.group_id then
      table.insert(self.v_spec_group_data, data)
    end
  end
  self.now_group_len = #self.v_spec_group_data
  table.sort(self.v_spec_group_data, _sorter)
  return self.v_spec_group_data
end

function M:get_now_group_data()
  return self.v_spec_group_data[self.now_page_index]
end

function M:check_border()
  if self.now_group_len < 2 then
    return self.read_state_cfg.SPEC
  else
    if 1 == self.now_page_index then
      return self.read_state_cfg.MIN
    end
    if self.now_page_index == self.now_group_len then
      return self.read_state_cfg.MAX
    end
    return self.read_state_cfg.NORMAL
  end
end

function M:get_need_save_groups()
  for _, data in pairs(self.v_save_state) do
    if 1 == data.is_save then
      table.insert(self.need_save_groups, data)
    end
  end
end

function M:check_save_state()
  for _, data in pairs(self.need_save_groups) do
    if data.id == self.group_id then
      self:request_complete_teaching(self.group_id)
      return true
    end
  end
  return false
end

function M:finish_teaching()
  if not self.group_id or 0 == self.group_id then
    return
  end
  for _, data in pairs(self.need_save_groups) do
    if data.id == self.group_id then
      self.v_complete_list[self.group_id] = self.group_id
    end
  end
  UIMgr:try_hide_ui("graphic_guide")
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TEXTURE_GUIDE_FINISH, self.group_id)
  SceneMgr:c2gs_call_scene(BehaviorMgr.EVENTS.ON_TEXTURE_GUIDE_FINISH, self.group_id)
  BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_TEXTURE_GUIDE_FINISH, self.group_id)
  self.group_id = 0
end

function M:check_compelete_list()
  for _, data in pairs(self.v_complete_list) do
    if self.group_id == data then
      return false
    end
  end
  return true
end

function M:sync_guide_update(data)
  for _, v in pairs(data.teaching_list) do
    self.v_complete_list[v] = v
  end
end

function M:request_complete_teaching(group_id)
  Network:call("c2gs_complete_teaching", {id = group_id})
end

function M:on_reconnect()
  self:refresh()
  self.v_complete_list = {}
  self.need_save_groups = {}
end

return M
