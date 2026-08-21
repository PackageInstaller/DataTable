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
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY = {
  MAP_NO_ACTIVE_ROOM = "MAP_NO_ACTIVE_ROOM",
  MAP_ACTIVE_ROOM = "MAP_ACTIVE_ROOM",
  MAP_RANDOM_ROOM = "MAP_RANDOM_ROOM"
}
local COMMON_EXIT_FUNC = "common_exit"
local EXIT_FUNC = {
  [CommonDef.CHALLENGE_TYPE.LONG_CHAPTER] = "long_chapter_exit",
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = "chapter_exit"
}
local Defatult_dis = 222

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    if self.v_callback and Global.hero then
      local hero_pos = Global.hero.transform.localPosition
      local direction, target_pos
      if self.v_cur_touch_tp_point and self.v_cur_touch_tp_point:get_game_obj() and not self.v_cur_touch_tp_point:get_game_obj().gameObject:IsNull() then
        direction = self.v_cur_touch_tp_point:get_game_obj().transform.forward
        target_pos = Vec3.New(direction.x * 2 + hero_pos.x, hero_pos.y, direction.z * 2 + hero_pos.z)
      else
        local center_pos_x, center_pos_z = Behavior.get_scene_map_pos_postion("center")
        direction = Vec3.Normalize(Vec3.New(center_pos_x - hero_pos.x, hero_pos.y, center_pos_z - hero_pos.z))
        target_pos = Vec3.New(direction.x * 2 + hero_pos.x, hero_pos.y, direction.z * 2 + hero_pos.z)
      end
      Global.hero:set_pos(target_pos.x, target_pos.y, target_pos.z)
      local fight_ui = UIMgr:get_ui("fight")
      fight_ui:real_show_joystick()
      fight_ui:set_safe_panel_visible()
      fight_ui:set_fight_obj_ui_visible("Main", true)
    end
    self:ui_hide()
    if StoryMgr.v_is_cache_story then
      StoryMgr.v_is_cache_story = false
      StoryMgr:on_start(StoryMgr.v_story_id)
    end
  end)
  self:set_button("ResetBtn", function()
    self:_onclick_reset_btn()
  end)
  self:set_button("QuitBtn", function()
    self:_onclick_quit_btn()
  end)
  self:set_button("Btn_NextFloor", function()
    self:_onclick_next_floor()
    self:ui_hide()
  end)
  self:set_button("Btn_Save", function()
    self:_onclick_save_btn()
  end)
  self:set_button("SettingBtn", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  Util.set_drag(self.v_uiobjects.MapView, self.v_object, function(x, y)
    self:_drag_ui(x, y)
  end)
  self.floor_obj = Util.get_child_gameobj("SafeArea/StageInfor/FloorDi", self.v_object)
  self.v_template_key = "current_item" .. self:ui_get_name()
  self:register_exist_auto_template(self.v_template_key, self.v_uiobjects.Asset_Item, self.v_uiobjects.AssetBar)
  self:_init_map_view()
  self.v_active_list = {}
  self.v_no_active_list = {}
  self.v_random_list = {}
  self.v_pre_room_list = {}
  self.v_out_room = nil
  self.v_out_port = 0
  self.v_currency_list = {}
  self.v_canvas = self.v_object:GetComponent(typeof(UnityEngine.Canvas))
  self.v_skip_sort_order = false
end

function ui:_init_map_view()
  self:register_exist_auto_template(TEMPLATE_KEY.MAP_NO_ACTIVE_ROOM, self.v_uiobjects.RoomNotTemp, self.v_uiobjects.MapView)
  self:register_exist_auto_template(TEMPLATE_KEY.MAP_ACTIVE_ROOM, self.v_uiobjects.RoomActiveTemp, self.v_uiobjects.MapView)
  self:register_exist_auto_template(TEMPLATE_KEY.MAP_RANDOM_ROOM, self.v_uiobjects.RandomRoomTemp, self.v_uiobjects.MapView)
  self.v_map_view_rect = self:get_rect_transform(nil, self.v_uiobjects.MapView)
end

function ui:_onclick_save_btn()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function ui:_onclick_next_floor()
  if not self.v_callback then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  local wait_hero_list = {}
  local tower = TowerMgr:get_tower()
  for uuid, hero in pairs(hero_list) do
    if uuid ~= Global.hero_uuid then
      table.insert(wait_hero_list, hero)
    end
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_FINISHED, Global.hero, wait_hero_list[1], wait_hero_list[2], tower.v_floor_num)
  self.v_callback()
  MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
  MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
end

function ui:ui_on_show(is_cut_pnl, cb, tp_point)
  if self.v_skip_sort_order then
    self.v_canvas.sortingOrder = Config.UI_SORT_ORDER.Special + 5
  end
  self:set_floor_obj_status()
  UIMgr:try_hide_ui("ui_battle_item")
  self.v_is_cut_pnl = is_cut_pnl
  self.v_callback = cb
  self.v_cur_touch_tp_point = tp_point
  self.scale_factor = self.v_object_transform.localScale.x
  self.v_uiobjects.Btn_Save:SetActive(self:get_btn_save_visible())
  self.v_uiobjects.Btn_NextFloor:SetActive(is_cut_pnl)
  self.v_uiobjects.StageComplete:SetActive(is_cut_pnl)
  self.v_uiobjects.ResetBtn:SetActive(not is_cut_pnl)
  self.v_uiobjects.QuitBtn:SetActive(not is_cut_pnl)
  self.v_uiobjects.SettingBtn:SetActive(not is_cut_pnl)
  self:_refresh_map()
  self:_refresh_currency_list()
  self:update_stage_info()
  self:_regist_client_event()
end

function ui:get_btn_save_visible()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDef.CHALLENGE_TYPE.CHAPTER and fight_type ~= CommonDef.CHALLENGE_TYPE.LONG_CHAPTER and fight_type ~= CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI and fight_type ~= CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI and fight_type ~= CommonDef.CHALLENGE_TYPE.NEW_MATERIAL and fight_type ~= CommonDef.CHALLENGE_TYPE.INDEPENDENT and fight_type ~= CommonDef.CHALLENGE_TYPE.LINEAR then
    return true
  end
  return false
end

function ui:set_floor_obj_status()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    self.floor_obj:SetActive(false)
  else
    self.floor_obj:SetActive(true)
  end
end

function ui:update_stage_info()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local roomList = tower:get_cur_floor_room_list()
  self.v_uicompents.Floor_txt.text = tower.v_floor_num
  self.v_uicompents.RoomMax_txt.text = UtilTable.hash_lenth(roomList)
  local pass_num = 0
  for key, room in pairs(roomList) do
    if tower:is_pass_room(room.RoomNum, true) then
      pass_num = pass_num + 1
    end
  end
  self.v_uicompents.RoomNow_txt.text = pass_num
end

function ui:_refresh_currency_list()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    self.v_uiobjects.AssetBar:SetActive(false)
    return
  end
  self.v_uiobjects.AssetBar:SetActive(true)
  for idx, v in pairs(bagConfig.SHOW_CURRENCY) do
    if not self.v_currency_list[idx] then
      local obj = self:get_auto_cache(self.v_template_key)
      self.v_currency_list[idx] = obj
    end
    self:_set_currency(self.v_currency_list[idx], idx)
  end
end

function ui:_set_currency(obj, index)
  if nil == obj then
    Log.Error("获取货币item对象失败！！！")
    return
  end
  obj:SetActive(true)
  local data = bagConfig.SHOW_CURRENCY[index]
  local cfg = FightBagMgr:get_cfg_by_id(data)
  local moneyIcon = self:get_image("Label", obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyNum = self:get_text("Aomunt", obj)
  moneyNum.text = CharacterMgr:get_res_val(data)
end

function ui:ui_on_hide()
  self.v_wrap_uis = {}
  self.v_active_list = {}
  self.v_no_active_list = {}
  self.v_random_list = {}
  self.v_pre_room_list = {}
  self.v_currency_list = {}
  self.v_cur_touch_tp_point = nil
  if self.v_notice_seqence then
    self.v_notice_seqence:Kill()
    self.v_notice_seqence = nil
  end
  self.v_uicompents.Bg2_rect:SetEuler(0, 0, 0)
  self.v_callback = nil
end

function ui:ui_on_destroy()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_ENTER_ROOM, self.response_enter_room_event, self)
  self:bind_auto_mq(Const.MSG_ON_PASS_ROOM, self.response_pass_room_event, self)
  self:bind_auto_mq(Const.MSG_ON_USE_MAP_ITEM, self.response_use_item_event, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency_list, self)
end

function ui:response_enter_room_event(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local roomId = msg.mm_obj
  local tower = TowerMgr:get_tower()
  if tower:is_pass_room(roomId) == false then
    self:ui_hide()
  else
    self:_refresh_map()
  end
end

function ui:response_pass_room_event(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local roomId = msg.mm_obj
  local tower = TowerMgr:get_tower()
  if tower:is_pass_room(roomId) == true then
    self.v_uiobjects.MapView:SetActive(true)
  end
end

function ui:response_use_item_event(msg)
  self:_show_unlock()
end

function ui:_refresh_map()
  self:_create_room()
  self:_set_background()
  self:_set_room_connect()
end

function ui:_rebuild_list()
  for k, v in pairs(self.v_active_list) do
    if self.v_no_active_list[k] ~= nil then
      local ui = self.v_no_active_list[k]
      self:give_back_auto_cache_obj(nil, ui.v_object, true)
      self:remove_wrap_ui(ui)
      ui:ui_hide()
      self.v_no_active_list[k] = nil
    end
  end
  for k, v in pairs(self.v_pre_room_list) do
    if nil ~= self.v_pre_room_list[k] then
      local ui = self.v_pre_room_list[k]
      self:give_back_auto_cache_obj(nil, ui.v_object, true)
      self:remove_wrap_ui(ui)
      ui:ui_hide()
      self.v_pre_room_list[k] = nil
    end
  end
end

function ui:_create_room()
  self:_rebuild_list()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local roomList = tower:get_cur_floor_room_list()
  for _, room in pairs(roomList) do
    local isIn = tower:get_room_num() == room.RoomNum
    if tower:is_pass_room(room.RoomNum) or isIn then
      if tower:is_pass_room(room.RoomNum) then
        self:_get_active_room(room.RoomNum):set_data(room)
        for _, connect in pairs(room.RoomConnectDic) do
          if tower:is_pass_room(connect.TargetRoomNum) == false then
            self:_get_no_active_room(connect.TargetRoomNum):set_data(roomList[connect.TargetRoomNum])
            self:_calc_out_room_dis(room, connect)
          end
        end
        self:_create_out_room(room)
        self:_create_random_room(room)
        local is_maze_room = tower:is_maze_room(room.RoomNum)
        if not isIn and true == is_maze_room then
          self:_get_no_active_room(room.RoomNum):set_data(room)
        end
      else
        self:_get_no_active_room(room.RoomNum):set_data(room)
      end
    end
    if FightBagMgr:get_show_all_map() and not tower:is_pass_room(room.RoomNum) and not self.v_no_active_list[room.RoomNum] then
      self:_get_pre_room(room.RoomNum):set_data(room, false)
    end
    local relate_list = BattleTaskMgr:check_task_relation_room(room.LogicNum)
    if next(relate_list) ~= nil and not tower:is_pass_room(room.RoomNum) then
      self:_get_no_active_room(room.RoomNum):set_data(room)
    end
  end
end

function ui:_get_active_room(roomId)
  if self.v_active_list[roomId] ~= nil then
    return self.v_active_list[roomId]
  end
  local obj = self:get_auto_cache(TEMPLATE_KEY.MAP_ACTIVE_ROOM)
  obj.name = "RoomActiveTemp_" .. roomId
  local bg_obj = Util.get_child_gameobj("RoomNotBg_", obj)
  local tower = TowerMgr:get_tower()
  local isIn = tower:get_room_num() == roomId
  local is_maze_room = tower:is_maze_room(roomId)
  if isIn then
    bg_obj:SetActive(true)
  else
    bg_obj:SetActive(true ~= is_maze_room)
  end
  local item = ActiveRoomClass:ui_wrap(self, obj, true)
  self.v_active_list[roomId] = item
  return item
end

function ui:_get_no_active_room(roomId)
  if self.v_no_active_list[roomId] ~= nil then
    return self.v_no_active_list[roomId]
  end
  local obj = self:get_auto_cache(TEMPLATE_KEY.MAP_NO_ACTIVE_ROOM)
  obj.name = "RoomNotTemp_" .. roomId
  local item = NoActiveRoomClass:ui_wrap(self, obj, true)
  self.v_no_active_list[roomId] = item
  return item
end

function ui:_get_random_room(roomId)
  if self.v_random_list[roomId] ~= nil then
    return self.v_random_list[roomId]
  end
  local obj = self:get_auto_cache(TEMPLATE_KEY.MAP_RANDOM_ROOM)
  obj.name = "RoomRandomTemp_" .. roomId
  local item = RandomRoomClass:ui_wrap(self, obj, true)
  self.v_random_list[roomId] = item
  return item
end

function ui:_get_pre_room(roomId)
  if self.v_pre_room_list[roomId] ~= nil then
    return self.v_pre_room_list[roomId]
  end
  local obj = self:get_auto_cache(TEMPLATE_KEY.MAP_NO_ACTIVE_ROOM)
  obj.name = "RoomNotTemp_" .. roomId
  local item = NoActiveRoomClass:ui_wrap(self, obj, true)
  self.v_pre_room_list[roomId] = item
  return item
end

function ui:_calc_out_room_dis(cur_room, connect_data)
  if self.v_room_dis then
    return
  end
  local pos1
  if self.v_active_list[cur_room.RoomNum] then
    pos1 = self.v_active_list[cur_room.RoomNum]:get_room_world_position()
  end
  local pos2
  if self.v_no_active_list[connect_data.TargetRoomNum] then
    pos2 = self.v_no_active_list[connect_data.TargetRoomNum]:get_room_world_position()
  end
  if nil ~= pos1 and nil ~= pos2 then
    local dir = pos1 - pos2
    self.v_room_dis = Vec3.Magnitude(dir)
  end
end

function ui:_create_out_room(cur_room)
  if cur_room.EndDir <= 0 then
    return
  end
  self:_innner_create_out_room(cur_room)
end

function ui:_innner_create_out_room(cur_room)
  self.v_out_port = cur_room.EndDir
  self.v_out_room = self:_get_no_active_room(-1)
  self.v_out_room:set_data(nil)
  local room_ui = self.v_active_list[cur_room.RoomNum]
  local pos = self.v_room_dis ~= nil and room_ui:get_room_world_position() or room_ui:get_room_anchored_position()
  self.v_out_room:set_pos(self:_get_point_by_port(cur_room.EndDir, pos, self.v_room_dis), self.v_room_dis == nil)
end

function ui:_create_random_room(cur_room)
  local tower = TowerMgr:get_tower()
  local random_list = tower:get_random_room_list(cur_room.RoomNum)
  if not random_list or 0 == #random_list then
    return
  end
  for _, random_data in pairs(random_list) do
    if tower:is_pass_room(random_data.target_room_num) then
      local random_room = self:_get_random_room(random_data.target_room_num)
      local room_data = {
        RoomType = tower:get_random_room_relate_type(random_data.target_room_num),
        RoomNum = random_data.target_room_num
      }
      random_room:set_data(room_data)
      local room_ui = self.v_active_list[cur_room.RoomNum]
      local pos = self.v_room_dis ~= nil and room_ui:get_room_world_position() or room_ui:get_room_anchored_position()
      random_room:set_pos(self:_get_point_by_port(random_data.src_dir, pos, self.v_room_dis), self.v_room_dis == nil)
    end
  end
end

function ui:_set_background()
  local pos
  for k, v in pairs(self.v_active_list) do
    if v:get_is_player_in() == true then
      pos = v:get_room_world_position()
      break
    end
  end
  if not pos then
    for _, v in pairs(self.v_random_list) do
      if v:get_is_player_in() == true then
        pos = v:get_room_world_position()
        break
      end
    end
  end
  if not pos then
    for _, v in pairs(self.v_no_active_list) do
      if v:get_is_player_in() == true then
        pos = v:get_room_world_position()
        break
      end
    end
  end
  if nil == pos then
    return
  end
  local center = self.v_uiobjects.Bg2.transform.position
  local x_offset = center.x - pos.x
  local y_offset = center.y - pos.y
  local originWorldPos = self.v_uiobjects.MapView.transform.position
  self.v_uiobjects.MapView.transform:SetPositionA(originWorldPos.x + x_offset, originWorldPos.y + y_offset, originWorldPos.z)
  local originRectPos = self.v_map_view_rect.anchoredPosition
  self.v_map_view_rect:SetAnchoredPositionA(originRectPos.x - 74, originRectPos.y + 74)
end

function ui:_set_room_connect()
  self:_set_conncet(self.v_active_list, true)
  if FightBagMgr:get_show_all_map() then
    self:_set_conncet(self.v_pre_room_list)
  end
end

function ui:_set_conncet(room_list, is_active_list)
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local roomList = tower:get_cur_floor_room_list()
  for room_id, room_ui in pairs(room_list) do
    if nil ~= roomList[room_id] then
      local connect_data = roomList[room_id].RoomConnectDic
      for _, connect in pairs(connect_data) do
        local target_room
        if is_active_list then
          target_room = tower:is_pass_room(connect.TargetRoomNum) and self.v_active_list[connect.TargetRoomNum] or self.v_no_active_list[connect.TargetRoomNum]
        else
          target_room = self.v_pre_room_list[connect.TargetRoomNum] or self.v_no_active_list[connect.TargetRoomNum]
        end
        if target_room then
          room_ui:set_line(connect, target_room)
        end
      end
      if not is_active_list then
      else
        local random_list = tower:get_random_room_list(room_id)
        if random_list and #random_list > 0 then
          for _, random_data in pairs(random_list) do
            if tower:is_pass_room(random_data.target_room_num) then
              local connect = {
                SrcDir = random_data.src_dir,
                TargetDir = random_data.target_dir,
                TargetRoomNum = random_data.target_room_num
              }
              room_ui:set_line(connect, self.v_random_list[random_data.target_room_num])
            end
          end
        end
        if roomList[room_id].EndDir > 0 and self.v_out_room then
          local tp = {
            SrcDir = self.v_out_port,
            TargetRoomNum = -1,
            TargetDir = self.v_out_port > 2 and self.v_out_port - 2 or self.v_out_port + 2
          }
          room_ui:set_line(tp, self.v_out_room)
        end
      end
    end
  end
end

function ui:_set_connect_to_out_room(room_cfg, room_ui)
  if room_cfg.EndDir > 0 and self.v_out_room then
    local tp = {
      SrcDir = self.v_out_port,
      TargetRoomNum = -1,
      TargetDir = self.v_out_port > 2 and self.v_out_port - 2 or self.v_out_port + 2
    }
    room_ui:set_line(tp, self.v_out_room)
  end
end

function ui:_drag_ui(x, y)
  local originPos = self.v_map_view_rect.localPosition
  self.v_map_view_rect:SetLocalPositionA(originPos.x + x * DrapSpeed, originPos.y + y * DrapSpeed, 0)
end

function ui:_onclick_reset_btn()
  self:_set_background()
end

function ui:_get_point_by_port(port, origin_pos, dis)
  if nil == dis then
    dis = Defatult_dis
  end
  if 1 == port then
    return Vec3.New(origin_pos.x, origin_pos.y + dis, origin_pos.z)
  elseif 2 == port then
    return Vec3.New(origin_pos.x - dis, origin_pos.y, origin_pos.z)
  elseif 3 == port then
    return Vec3.New(origin_pos.x, origin_pos.y - dis, origin_pos.z)
  else
    return Vec3.New(origin_pos.x + dis, origin_pos.y, origin_pos.z)
  end
end

function ui:_show_unlock()
  MsgGame:mq_publish2(Const.MSG_ON_OPEN_DROP_UI)
  for _, v in pairs(self.v_pre_room_list) do
    v:play_tween()
  end
  self.v_uiobjects.UnLockNotice:SetActive(true)
  local notice_group = self:get_canvas_group(nil, self.v_uiobjects.UnLockNotice)
  notice_group.alpha = 1
  local txt_group = self:get_canvas_group(nil, self.v_uiobjects.Complete)
  txt_group.alpha = 0
  local notice_rect = self:get_rect_transform(nil, self.v_uiobjects.UnLockNotice)
  notice_rect:SetAnchoredPositionA(0, 413)
  self.v_notice_seqence = Util.create_sequence()
  self.v_notice_seqence:SetUpdate(true)
  self.v_notice_seqence:Append(notice_rect.transform:DOScaleX(1, 0.1))
  self.v_notice_seqence:Append(notice_rect.transform:DOScaleY(1, 0.1))
  self.v_notice_seqence:Append(txt_group:DOFade(1, 0.1))
  self.v_notice_seqence:AppendInterval(1)
  self.v_notice_seqence:Append(notice_group:DOFade(0, 0.5))
  self.v_notice_seqence:OnComplete(function()
    self.v_uiobjects.UnLockNotice:SetActive(true)
  end)
end

function ui:refresh_map_angle()
  self.v_map_angle = MAP_HELPER.get_map_angle()
  if self.v_map_angle then
    local view_obj = self.v_uiobjects.Bg2
    local rect = Util.get_rect_transform(nil, view_obj)
    rect:SetEuler(0, 0, self.v_map_angle)
  end
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
  local cancal_return = false
  local sure_btn, cancel_btn
  if fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER or fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER or fight_type == CommonDef.CHALLENGE_TYPE.LINEAR then
    cancal_return = true
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
    if cancal_return then
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
  self:ui_hide()
  
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

function ui:set_skip_sort_order(skip_sort_order)
  self.v_skip_sort_order = skip_sort_order
end

function ui:skip_sort_order()
  return self.v_skip_sort_order
end

return ui
