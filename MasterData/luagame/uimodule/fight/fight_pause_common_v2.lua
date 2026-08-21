local Base = require("ui.uibase")
local ActiveRoomClass = require("uimodule.fight_map.active_room")
local NoActiveRoomClass = require("uimodule.fight_map.no_active_room")
local RandomRoomClass = require("uimodule.fight_map.random_room")
local MAP_HELPER = require("uimodule.fight_map.fight_map_helper")
local CommonDef = require("cs_share.common_define")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local Behavior = require("manager.fight.behavior")
local UnityScreen = UnityEngine.Screen
local DrapSpeed = 0.7
local Vec3 = require("base.vec3")
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local ROOM_ITEM_CLASS = require("uimodule.fight_map.room_item")
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY = {
  MAP_NO_ACTIVE_ROOM = "MAP_NO_ACTIVE_ROOM",
  MAP_ACTIVE_ROOM = "MAP_ACTIVE_ROOM",
  MAP_RANDOM_ROOM = "MAP_RANDOM_ROOM"
}
local MAP_PAGE_ITEM = "MAP_PAGE_ITEM"
local COMMON_EXIT_FUNC = "common_exit"
local EXIT_FUNC = {
  [CommonDef.CHALLENGE_TYPE.LONG_CHAPTER] = "long_chapter_exit",
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = "chapter_exit"
}
local Defatult_dis = 222

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
    if StoryMgr.v_is_cache_story then
      StoryMgr.v_is_cache_story = false
      StoryMgr:on_start(StoryMgr.v_story_id)
    end
  end)
  self:set_button("QuitBtn", function()
    self:_onclick_quit_btn()
  end)
  self:set_button("ButtonTP", function()
    self:on_click_room()
  end)
  self:set_button("SettingBtn", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  self.v_canvas = self.v_object:GetComponent(typeof(UnityEngine.Canvas))
  self:register_exist_auto_template(MAP_PAGE_ITEM, self.v_uiobjects.PageTem, self.v_uiobjects.PageContent)
  self.v_room_item_dict = {}
end

function ui:ui_on_show()
  if self.v_skip_sort_order then
    self.v_canvas.sortingOrder = Config.UI_SORT_ORDER.Special + 5
  end
  UIMgr:try_hide_ui("ui_battle_item")
  self:update_stage_info(true)
end

function ui:update_stage_info(is_on_show)
  self:clear_room_item()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  self.v_uiobjects.ButtonTP:SetActive(tower:can_archieve())
  local temp_cfg_list = {}
  local roomList = tower:get_cur_floor_room_list()
  local room_map = tower:get_tower_floor_room_map()
  local temp = {}
  for key, value in pairs(roomList) do
    local room_info = room_map[key]
    local room_cfg = ShareRes.get_room_cfg(room_info.room_id)
    temp_cfg_list[key] = room_cfg
    if not room_info.maze_room then
      table.insert(temp, value)
    end
  end
  table.sort(temp, function(a, b)
    local a_room_info = room_map[a.RoomNum]
    local b_room_info = room_map[b.RoomNum]
    if a_room_info.room_id ~= b_room_info.room_id then
      return a_room_info.room_id < b_room_info.room_id
    end
    return false
  end)
  for index, room_connect_cfg in ipairs(temp) do
    local room_num = room_connect_cfg.RoomNum
    local room_cfg = temp_cfg_list[room_num]
    local obj = self:get_auto_cache(MAP_PAGE_ITEM)
    local item = ROOM_ITEM_CLASS:ui_wrap(self, obj, true)
    item:set_data(room_cfg, room_num)
    self.v_room_item_dict[room_num] = item
    if not self.v_select_room_num and tower:get_room_num() == room_num then
      self:on_select_item(room_num, room_cfg)
    end
  end
  if not self.v_select_room_num then
    local _, cfg = next(temp)
    if cfg then
      local room_info = room_map[cfg.RoomNum]
      local room_cfg = ShareRes.get_room_cfg(room_info.room_id)
      self:on_select_item(cfg.RoomNum, room_cfg)
    end
  end
  if is_on_show and self.v_select_room_num then
    local target_obj = self.v_room_item_dict[self.v_select_room_num]:get_object()
    local tf = target_obj.transform
    local scroll_tf = self.v_uiobjects.ScrollView.transform
    local x, y, z = scroll_tf:GetInverseTransformPointA(tf.position.x, tf.position.y, tf.position.z)
    local pos = self.v_uiobjects.PageContent.transform.localPosition
    pos.y = pos.y - y
    self.v_uiobjects.PageContent.transform.localPosition = pos
  end
end

function ui:ui_on_hide()
  self.v_select_room_num = nil
  self:clear_room_item()
end

function ui:ui_on_destroy()
end

function ui:_onclick_quit_btn()
  local fight_info = TowerMgr:get_fight_info()
  local fight_type = fight_info and fight_info.type
  if fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_exit_top_ver_tower()
  else
    self:_exit_tower(fight_type)
  end
end

function ui:_exit_top_ver_tower()
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("退出")
  
  local function sure_callback()
    UIMgr:get_ui("top_ver_settlement"):ui_show()
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn)
  UIMgr:get_ui("uinotice_tips"):enable_bg_click(true)
end

function ui:_exit_tower(fight_type)
  local tip = Util.format_str("是否立即退出关卡")
  local cancel_return = false
  local sure_btn, cancel_btn
  if fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER or fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER or fight_type == CommonDef.CHALLENGE_TYPE.INDEPENDENT or fight_type == CommonDef.CHALLENGE_TYPE.LINEAR then
    cancel_return = true
    tip = Util.format_str("当前节点进度将会丢失，是否立即退出关卡")
    cancel_btn = Util.format_str("取消")
    sure_btn = Util.format_str("确认")
  else
    sure_btn = Util.format_str("中继保存")
    cancel_btn = Util.format_str("直接结算")
  end
  
  local function sure_callback()
    local fun = EXIT_FUNC[fight_type] or COMMON_EXIT_FUNC
    if self[fun] then
      self[fun](self)
    end
  end
  
  local function cancel_callback()
    if cancel_return then
      return
    elseif self:check_weekly_fight(fight_type) then
      local function cb()
        UIMgr:get_ui("weekly_fight_settle"):ui_show()
      end
      
      WeeklyMgr:request_weekly_prepare_score(cb)
    elseif NOT_PROGRESS_BATTLE_TYPE[fight_type] then
      UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
    elseif fight_type == CommonDef.CHALLENGE_TYPE.INFINITE then
      local ui_name
      local tower = TowerMgr:get_tower()
      if tower and tower:get_floor_num() <= 1 and not tower:get_room():is_fight_end() then
        ui_name = "not_progress_battle_def_settle"
      else
        ui_name = "endless_settle"
      end
      UIMgr:get_ui(ui_name):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    else
      UIMgr:get_ui("fight_settlement"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    end
  end
  
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    sure_btn = Util.format_str("返回")
    
    function sure_callback()
      self:ui_hide()
    end
  end
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn, nil, nil, nil, nil, function()
    if fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
      self:refresh_material_btn()
    end
  end)
  UIMgr:get_ui("uinotice_tips"):enable_bg_click(true)
end

function ui:common_exit()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function ui:long_chapter_exit()
  local function cb()
    self:common_exit()
  end
  
  TowerMgr:long_chapter_exit(false, cb, true)
end

function ui:chapter_exit()
  UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
end

function ui:refresh_material_btn()
  local tips_ui = UIMgr:try_get_ui("uinotice_tips")
  if tips_ui then
    tips_ui:only_show_no_btn()
  end
end

function ui:check_weekly_fight(fight_type)
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_is_cut_pnl, self.v_callback
end

function ui:get_select_room_num()
  return self.v_select_room_num
end

function ui:on_select_item(room_num, room_cfg)
  if self.v_select_room_num ~= room_num then
    if self.v_select_room_num then
      self.v_room_item_dict[self.v_select_room_num]:on_select_item(false)
    end
    self.v_room_item_dict[room_num]:on_select_item(true)
    self.v_select_room_num = room_num
  else
    return
  end
  if Util.is_empty(room_cfg.RoomPicture) then
    Log.Error("房间", room_cfg.RoomID, "RoomPicture字段为空")
    return
  end
  ResMgr:load_set_icon(self.v_uicompents.ShowImage_img, room_cfg.RoomPicture, nil, true)
  self.v_uicompents.ShowImage_IN_pd:Play()
end

function ui:on_click_room()
  if TowerMgr.v_is_cut_pnl then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower or not tower:can_archieve() then
    Util.show_message_tip(2181)
    return
  end
  if tower:get_room_num() == self.v_select_room_num then
    Util.show_message_tip(2182)
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  if not self.v_select_room_num then
    return
  end
  if not TowerMgr.v_is_can_transmit then
    Util.show_message_tip(2333)
    return
  end
  UIMgr:get_ui("fight"):change_button(false)
  if not room:is_fight_end() then
    Util.show_message_tip(2333)
    return
  end
  tower:enter_room(self.v_select_room_num, 0, nil, true, function(is_success)
    if is_success then
      UIMgr:get_ui("fight_pause_common_v2"):ui_hide()
    end
  end)
end

function ui:clear_room_item()
  self:give_back_auto_cache(MAP_PAGE_ITEM)
  for key, item in pairs(self.v_room_item_dict) do
    self:remove_wrap_ui(item)
    item:ui_hide()
  end
end

function ui:set_skip_sort_order(skip_sort_order)
  self.v_skip_sort_order = skip_sort_order
end

function ui:skip_sort_order()
  return self.v_skip_sort_order
end

return ui
