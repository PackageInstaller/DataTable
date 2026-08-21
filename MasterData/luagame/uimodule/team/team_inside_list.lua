local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CHAR_SELECT_CLASS = require("uimodule.team.team_inside_list_select_item")
local CharacterConfig = require("uimodule.character.character_config")
local _insert = table.insert
local GridLayoutGroup = UnityEngine.UI.GridLayoutGroup
local CommonDefine = require("cs_share.common_define")
local TEAM_BUDDY_TYPE = CommonDefine.TEAM_BUDDY_TYPE
local CHAR_SELECT_KEY = "TEAM_LIST_ITEM_KEY"
local ORDER_TYPE2_NAME = CharacterConfig.ORDER_TYPE2_NAME
local ORDER_TYPE = CharacterConfig.ORDER_TYPE
local SORT_RULE = CharacterConfig.SORT_RULE

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:on_click_close()
  end)
  self:set_button("Btn_screen", function()
    if self.v_close_blocker then
      return
    end
    UIMgr:get_ui("screen_buddy_tips"):ui_show(nil, nil, nil, self:get_no_screen_list())
  end)
  self:set_button("BtnSort", function()
    if self.v_close_blocker then
      return
    end
    UIMgr:get_ui("sort_buddy_tips"):ui_show()
  end)
  self:set_button("ScreenUpDown", function()
    if self.v_close_blocker then
      return
    end
    CharacterMgr.v_is_drop = not CharacterMgr.v_is_drop
    local rot_z = CharacterMgr.v_is_drop and 0 or 180
    self.v_uicompents.ScreenUpDown_rect:SetEuler(0, 0, rot_z)
    self:refresh_char_select_list()
  end)
  self:set_button("BtnSave", function()
    if self.v_close_blocker then
      return
    end
    self.v_parent_ui:quick_change_team(self.v_pos_data)
    self:do_close()
  end)
  self.v_content_grid_layout_group = Util.get_component(nil, self.v_uiobjects.CharContent, typeof(GridLayoutGroup))
  self:register_exist_auto_template(CHAR_SELECT_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.CharContent)
end

function ui:on_click_close()
  if self.v_close_blocker then
    return
  end
  if self.v_parent_ui:check_quick_change_team(self.v_pos_data) then
    local function confirm_cb()
      self:do_close()
    end
    
    local function cancel_cb()
      self.v_parent_ui:quick_change_team(self.v_pos_data)
      self:do_close()
    end
    
    Util.show_conform_tip("是否保存编队", nil, nil, confirm_cb, cancel_cb)
  else
    self:do_close()
  end
end

function ui:do_close()
  if self.v_close_blocker then
    return
  end
  self.v_close_blocker = true
  self.v_parent_ui:enable_inside_list(false)
  self:remove_delay_close_timer()
  self.v_delay_close_timer = Timer:add_timer("delay_close_team_inside_list_timer", 0.35, function()
    self.v_close_blocker = false
    self:set_enable(false)
  end)
end

function ui:ui_on_show(team_data)
  self.v_close_blocker = false
  self.v_team_data = team_data
  self.v_pos_data = team_data.pos_data
  self.v_ban_buddys = team_data.ban_buddys
  self.v_fixed_buddys = team_data.fixed_buddys
  self.v_offer_robot_list = team_data.offer_robot_list
  self.fight_type = self.v_parent_ui.v_fight_type
  if self.fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    self.v_content_grid_layout_group.spacing = UnityVector2(18, 52)
    self.v_content_grid_layout_group.padding.bottom = 54
  else
    self.v_content_grid_layout_group.spacing.y = UnityVector2(18, 18)
    self.v_content_grid_layout_group.padding.bottom = 20
  end
  self:refresh_char_select_list()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.refresh_char_select_list, self)
end

function ui:ui_on_hide()
  self:clear_wrap_item()
  self:remove_delay_close_timer()
  CharacterMgr:reset_temp_data()
end

function ui:ui_on_destroy()
end

function ui:remove_delay_close_timer()
  if self.v_delay_close_timer then
    Timer:remove_timer(self.v_delay_close_timer)
    self.v_delay_close_timer = nil
  end
end

function ui:clear_wrap_item()
  if self.v_all_buddy_item_list then
    for _, buddy_item in pairs(self.v_all_buddy_item_list) do
      buddy_item.obj:ui_destroy()
      buddy_item.obj = nil
    end
    self.v_all_buddy_item_list = nil
  end
end

function ui:refresh_char_select_list()
  self:set_screen_list()
  self:clear_wrap_item()
  self.v_all_buddy_item_list = {}
  self:give_back_auto_cache(CHAR_SELECT_KEY)
  for idx, screen_buddy_data in ipairs(self.v_screen_list) do
    local item = self:get_auto_cache(CHAR_SELECT_KEY)
    local buddy_id = screen_buddy_data.id
    local select_obj = CHAR_SELECT_CLASS:ui_wrap_ex(self, item, true)
    select_obj.go = item
    select_obj:set_linked_parent(self)
    select_obj:set_data(screen_buddy_data)
    local insert_data = {
      id = buddy_id,
      obj = select_obj,
      buddy_info = screen_buddy_data
    }
    _insert(self.v_all_buddy_item_list, insert_data)
  end
  self.v_uicompents.CharContent_rect:SetAnchoredPositionA(0, 0)
end

function ui:set_screen_list()
  local v_order_type = CharacterMgr.v_screen_type or ORDER_TYPE.DEFAULT
  self.v_uicompents.ScreenText_txt.text = ORDER_TYPE2_NAME[v_order_type]
  local element_list = CharacterMgr.v_attr_screen_list
  local job_list = CharacterMgr.v_job_screen_list
  local tag_list = CharacterMgr.v_tag_screen_list
  self.v_screen_list = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  local own_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  for buddy_id, info in pairs(own_list) do
    local cfg = buddy_config[info.id]
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(buddy_id) then
      local element_cond = not element_list or 0 == #element_list or UtilTable.contains(element_list, cfg.Element)
      local job_cond = not job_list or 0 == #job_list or UtilTable.contains(job_list, cfg.Job)
      local tag_cond = not tag_list or 0 == #tag_list or cfg.Tag and (UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2]))
      local team_pos = self:get_team_pos(buddy_id)
      if team_pos or element_cond and job_cond and tag_cond then
        local is_ban, is_weekly_used = self:is_buddy_ban(buddy_id)
        local is_fixed = self:is_buddy_fixed(buddy_id)
        info.element = cfg.Element
        info.fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
        local data = {
          id = buddy_id,
          element = cfg.Element,
          info = info,
          is_ban = is_ban,
          is_weekly_used = is_weekly_used,
          is_fixed = is_fixed,
          team_pos = team_pos,
          fashion_id = info.fashion_id
        }
        _insert(self.v_screen_list, data)
      end
    end
  end
  local assist_buddy = self:get_assist_buddy()
  if assist_buddy then
    local cfg = buddy_config[assist_buddy]
    local assist_info = AssistMgr:get_assist_buddy_info()
    if assist_info and assist_buddy == assist_info.id then
      local data = {
        id = assist_buddy,
        element = cfg.Element,
        info = nil,
        is_ban = false,
        is_fixed = true,
        is_assist = true,
        team_pos = 3,
        fashion_id = assist_info.fashion
      }
      _insert(self.v_screen_list, data)
    end
  end
  if self.v_offer_robot_list then
    for _, robot_id in pairs(self.v_offer_robot_list) do
      local robot_cfg = ShareRes.get_fixed_buddy_config(robot_id)
      if not robot_cfg then
        Log.Error("机器人配置不存在，ID：", robot_id)
        break
      end
      local buddy_id = robot_cfg.BuddyId
      local cfg = buddy_config[buddy_id]
      local robot_info = {
        break_lv = robot_cfg.BreakLv,
        advance = robot_cfg.AdvanceLv,
        lv = robot_cfg.Lv,
        quality = cfg.Element,
        power = robot_cfg.Power,
        fashion_id = robot_cfg.FashionId
      }
      local element_cond = not element_list or 0 == #element_list or UtilTable.contains(element_list, cfg.Element)
      local job_cond = not job_list or 0 == #job_list or UtilTable.contains(job_list, cfg.Job)
      local tag_cond = not tag_list or 0 == #tag_list or cfg.Tag and (UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2]))
      local team_pos = self:get_team_pos(buddy_id, robot_id)
      if team_pos or element_cond and job_cond and tag_cond then
        local is_ban = self:is_buddy_ban(buddy_id)
        local is_fixed = self:is_buddy_fixed(buddy_id)
        local data = {
          id = buddy_id,
          element = cfg.Element,
          info = nil,
          is_ban = is_ban,
          is_fixed = is_fixed,
          team_pos = team_pos,
          robot_id = robot_id,
          robot_info = robot_info,
          fashion_id = robot_cfg.FashionId
        }
        _insert(self.v_screen_list, data)
      end
    end
  end
  self:sort_type(v_order_type)
end

function ui:get_no_screen_list()
  local list = {}
  local record_map = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  local own_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  for buddy_id, info in pairs(own_list) do
    local cfg = buddy_config[info.id]
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(buddy_id) and not record_map[buddy_id] then
      _insert(list, {id = buddy_id})
      record_map[buddy_id] = 1
    end
  end
  local assist_buddy = self:get_assist_buddy()
  if assist_buddy then
    local assist_info = AssistMgr:get_assist_buddy_info()
    if assist_info and assist_buddy == assist_info.id and not record_map[assist_buddy] then
      _insert(list, {id = assist_buddy})
      record_map[assist_buddy] = 1
    end
  end
  if self.v_offer_robot_list then
    for _, robot_id in pairs(self.v_offer_robot_list) do
      local robot_cfg = ShareRes.get_fixed_buddy_config(robot_id)
      if not robot_cfg then
        Log.Error("机器人配置不存在，ID：", robot_id)
        break
      end
      local buddy_id = robot_cfg.BuddyId
      local cfg = buddy_config[buddy_id]
      if 1 ~= cfg.IsShow and not record_map[buddy_id] then
        _insert(list, {id = buddy_id})
        record_map[buddy_id] = 1
      end
    end
  end
  return list
end

function ui:sort_type(v_order_type)
  local sort_rule = SORT_RULE[v_order_type]
  table.sort(self.v_screen_list, function(a, b)
    local team_pos_a = a.team_pos or 9
    local team_pos_b = b.team_pos or 9
    if team_pos_a ~= team_pos_b then
      return team_pos_a < team_pos_b
    end
    if a.robot_id ~= nil ~= (b.robot_id ~= nil) then
      return a.robot_id ~= nil
    end
    local info_a = a.info
    local info_b = b.info
    if a.is_fixed ~= b.is_fixed then
      return b.is_fixed
    end
    if a.is_ban ~= b.is_ban then
      return b.is_ban
    end
    if nil ~= info_a then
      for _, type in ipairs(sort_rule) do
        if info_a[type] ~= info_b[type] then
          if CharacterMgr.v_is_drop then
            return info_a[type] < info_b[type]
          else
            return info_a[type] > info_b[type]
          end
        end
      end
    else
      if a.robot_id ~= nil ~= (b.robot_id ~= nil) then
        return a.robot_id ~= nil
      end
      if a.robot_id ~= nil then
        local robot_info_a = a.robot_info
        local robot_info_b = b.robot_info
        for _, type in ipairs(sort_rule) do
          if robot_info_a[type] ~= robot_info_b[type] then
            if CharacterMgr.v_is_drop then
              return robot_info_a[type] < robot_info_b[type]
            else
              return robot_info_a[type] > robot_info_b[type]
            end
          end
        end
      end
    end
    if a.element ~= b.element then
      return a.element < b.element
    end
    if CharacterMgr.v_is_drop then
      return a.id < b.id
    else
      return a.id > b.id
    end
  end)
end

function ui:get_assist_buddy()
  if not self.v_pos_data then
    return
  end
  for pos, data in pairs(self.v_pos_data) do
    if data.buddy_type == TEAM_BUDDY_TYPE.HELP_FIGHT then
      return data.buddy_id
    end
  end
end

function ui:is_buddy_ban(buddy_id)
  if self.v_team_data and self.v_team_data.formation_type == CommonDefine.FORMATION_TYPE.WEEK_ACTY_PVP_TEAM then
    return false, WeeklyMgr:get_is_pvp_used(buddy_id)
  end
  if self.v_ban_buddys and self.v_ban_buddys[buddy_id] then
    return true
  end
end

function ui:is_buddy_fixed(buddy_id)
  if self.v_fixed_buddys and self.v_fixed_buddys[buddy_id] then
    return true
  end
end

function ui:get_team_pos(buddy_id, robot_id)
  if not self.v_pos_data then
    return
  end
  for pos, data in pairs(self.v_pos_data) do
    if data.buddy_type ~= TEAM_BUDDY_TYPE.HELP_FIGHT and data.buddy_id == buddy_id and (not (data.robot_id or robot_id) or data.robot_id and data.robot_id == robot_id) then
      return pos
    end
  end
  return
end

function ui:check_buddy_repeat(buddy_id)
  if not self.v_pos_data then
    return false
  end
  for _, data in pairs(self.v_pos_data) do
    if data.buddy_id == buddy_id then
      return true
    end
  end
  return false
end

function ui:on_select_buddy(buddy_id, robot_id, pos)
  if pos then
    self.v_pos_data[pos].buddy_id = 0
    self.v_pos_data[pos].robot_id = nil
  else
    for index = 1, 3 do
      if not self.v_pos_data[index].ban and 0 == self.v_pos_data[index].buddy_id then
        self.v_pos_data[index] = {buddy_id = buddy_id, robot_id = robot_id}
        return index
      end
    end
    Util.show_message_tip(2219)
  end
end

function ui:refresh_item_mask()
  if self.v_all_buddy_item_list then
    for _, item in ipairs(self.v_all_buddy_item_list) do
      item.obj:refresh_mask()
    end
  end
end

return ui
