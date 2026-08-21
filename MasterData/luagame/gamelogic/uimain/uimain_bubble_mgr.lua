local Base = require("gamelogic.base_system")
local Seri = require("seri")
local M = Util.create_child_mt(Base)
local BoardGirlSpecialBubbleCond = ShareRes.get_comm_value("BoardGirlSpecialBubbleCond")
M.icon_list = {
  "UIMain/New/Main_icon_qp02",
  "UIMain/New/Main_icon_qp",
  "UIMain/New/Main_icon_qp03"
}
M.bubble_data_list = {}
M.npc_bubble_list = {}

function M:init_bubble_list(ui_main_panel)
  self.bubble_data_list = {}
  self.npc_bubble_list = {}
  for i = 1, 6 do
    local bubble_data = {}
    local obj_path = Util.format_str("signBoardGilrRed{1}", i)
    local obj = Util.get_child_gameobj(obj_path, ui_main_panel)
    bubble_data.obj = obj
    bubble_data.rect = Util.get_rect_transform(nil, obj)
    bubble_data.npc_id = nil
    self.bubble_data_list[#self.bubble_data_list + 1] = bubble_data
    obj:SetActive(false)
  end
end

function M:get_idle_bubble_data()
  for index, bubble_data in ipairs(self.bubble_data_list) do
    if bubble_data.npc_id == nil or 0 == bubble_data.npc_id then
      return bubble_data
    end
  end
  return nil
end

function M:get_bubble_data_with_npc_id(npc_id, bubble_state)
  local npc_bubble_data = self.npc_bubble_list[npc_id]
  if not npc_bubble_data then
    npc_bubble_data = self:get_idle_bubble_data()
    if not npc_bubble_data then
      return nil
    end
    npc_bubble_data.npc_id = npc_id
    self.npc_bubble_list[npc_id] = npc_bubble_data
    self:refresh_bubble_icon(npc_bubble_data, bubble_state)
  end
  return npc_bubble_data
end

function M:refresh_bubble_icon(bubble_data, bubble_state)
  local icon_image = Util.get_image("Main", bubble_data.obj)
  ResMgr:load_set_icon(icon_image, self.icon_list[bubble_state])
  for i = 1, 3 do
    local point_obj = Util.get_child_gameobj(Util.format_str("Main/Point0{1}", i), bubble_data.obj)
    if not Util.is_nil(point_obj) then
      point_obj:SetActive(false)
    end
  end
end

function M:set_bubble_state(bubble_data, visible)
  if not bubble_data or Util.is_nil(bubble_data.obj) then
    return
  end
  bubble_data.obj:SetActive(visible)
end

function M:refresh_all_buddy_event_bubble(model_view, camera, safe_area_offset, canvas)
  self:show_journey_event_bubble(model_view, camera, safe_area_offset, canvas)
  if JourneyEventMgr:get_is_need_run_force_journey_event() then
    return
  end
  local need_show_list = TaskMgr:get_need_show_npc_list()
  if need_show_list and next(need_show_list) ~= nil then
    for index, data in ipairs(need_show_list) do
      self:show_bubble(data, model_view, camera, safe_area_offset, canvas)
    end
  end
  local signboard_girl_bubble_data = self:check_board_girl_bubble(need_show_list, model_view)
  if signboard_girl_bubble_data then
    self:show_bubble(signboard_girl_bubble_data, model_view, camera, safe_area_offset, canvas)
  end
end

function M:show_journey_event_bubble(model_view, camera, safe_area_offset, canvas)
  local buddy_data = JourneyEventMgr:get_buddy_data()
  if not (buddy_data and buddy_data.model_index) or 0 == buddy_data.model_index then
    return
  end
  self:show_bubble(buddy_data, model_view, camera, safe_area_offset, canvas, true)
end

function M:show_bubble(data, model_view, camera, safe_area_offset, canvas, is_get_npc_with_index)
  local npc_bubble_data = self:get_bubble_data_with_npc_id(data.npc_id, data.bubble_state)
  if npc_bubble_data then
    local npc_head = data.npc_head
    if not Util.is_nil(npc_head) then
      local x, y, z = npc_head:GetPositionA()
      local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(camera, canvas, x, y, z)
      npc_bubble_data.rect:SetAnchoredPositionA(screen_pos_x - safe_area_offset, screen_pos_y)
      self:set_bubble_state(npc_bubble_data, true)
    elseif is_get_npc_with_index then
      data.npc_head = model_view:get_npc_head_trans_with_npc_index(data.model_index)
    else
      data.npc_head = model_view:get_npc_head_trans_with_npc_id(data.npc_id)
    end
  elseif TaskMgr then
    TaskMgr:set_head_data(data)
  end
end

function M:release_all_bubble_obj_state()
  for npc_id, data in pairs(self.npc_bubble_list) do
    self:release_bubble_obj_state(npc_id)
  end
end

function M:release_bubble_obj_state(npc_id)
  local data = self.npc_bubble_list[npc_id]
  if not data then
    return
  end
  data.npc_id = nil
  self:set_bubble_state(data, false)
  self.npc_bubble_list[npc_id] = nil
end

function M:try_set_board_girl_bubble_played()
  local is_played = PlayerPrefsMgr:get_board_special_red_played()
  if not (not is_played and BoardGirlSpecialBubbleCond) or not Condition:check_condition(BoardGirlSpecialBubbleCond) then
    return
  end
  PlayerPrefsMgr:set_board_special_red_played()
  self.signboard_girl_bubble_data = nil
end

function M:check_board_girl_bubble(need_show_list, model_view)
  local board_id = PlayerMgr:get_signboard_girl_id()
  if need_show_list and next(need_show_list) ~= nil then
    for index, data in ipairs(need_show_list) do
      if data.npc_id == board_id then
        return
      end
    end
  end
  local is_played = PlayerPrefsMgr:get_board_special_red_played()
  if not (not is_played and BoardGirlSpecialBubbleCond) or not Condition:check_condition(BoardGirlSpecialBubbleCond) then
    return
  end
  if not self.signboard_girl_bubble_data then
    local npc_head = model_view:get_npc_head_trans_with_npc_id(board_id)
    self.signboard_girl_bubble_data = {
      npc_head = npc_head,
      npc_id = board_id,
      bubble_state = 2,
      board_id = board_id
    }
  end
  return self.signboard_girl_bubble_data
end

return M
