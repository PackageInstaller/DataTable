local Base = require("gamelogic.base_system")
local CommonDefind = require("cs_share.common_define")
local M = Util.create_child_mt(Base)
local Seri = require("seri")
local FUN_NPC_HELPER = require("gamelogic.functional_npc.functional_npc_helper")
local BATTLE_TASK_CFG = require("uimodule.fight_task.battle_task_config")
local NOTICE_TYPE = BATTLE_TASK_CFG.NOTICE_TYPE
local CommonDefine = require("cs_share.common_define")
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local _tinsert = table.insert
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local bubble_point = "qipao_gd"

function M:init_sys()
  Base.init_sys(self)
  self.v_is_get_thing = false
  self.v_show_battle_award_show_panel = false
  self:sys_mq_bind(Const.MSG_NETWORK_FIGHT_RCT_SUC, self._reconnect, self)
  self:sys_mq_bind(Const.MSG_ON_SETTLEMENT_WIN_OPEN, self.on_settlement_win_open, self)
end

function M:on_interact_with_npc(npc_data, param, cb, drop_tb)
  local npc_id = npc_data.npc_id
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  if not npc_cfg and npc_data.npc_cfg and npc_data.npc_cfg.Type and npc_data.npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.EXHIBITION then
    npc_cfg = npc_data.npc_cfg
  end
  local npc_type = npc_cfg.Type
  self.cur_interact_npc_type = npc_type
  self.cur_npc_data = npc_data
  if FUN_NPC_HELPER.is_reward_npc(npc_id) then
    self.v_is_get_thing = true
  end
  local send_data = param and {id = npc_id, pack_args = param} or {id = npc_id}
  local scene_logic = SceneMgr:get_scene_logic()
  local npc_obj = scene_logic:get_func_npc(npc_id)
  if drop_tb and (drop_tb.is_equip or drop_tb.is_rune or drop_tb.is_ornament) then
    if drop_tb.is_equip then
      local need_equip = drop_tb.need_equip
      FightBagMgr:request_operate_equip_item("c2gs_interact_with_npc", send_data, need_equip, cb)
    elseif drop_tb.is_rune and drop_tb.need_sell then
      local sell_param = {
        uuid = drop_tb.uuid,
        npc_id = npc_id
      }
      Rune2Mgr:sell_rune_item(sell_param, RUNE2_SOURCE.NPC_DROP)
    elseif drop_tb.is_ornament then
      if drop_tb.need_sell then
        BattleOrnamentMgr:sell_ornaments(drop_tb, RUNE2_SOURCE.NPC_DROP, cb)
      else
        BattleOrnamentMgr:inlaid_ornament(drop_tb, RUNE2_SOURCE.NPC_DROP, cb)
      end
    end
  else
    Network:call("c2gs_interact_with_npc", send_data, function(ok, resp)
      if ok then
        if npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.CHALLENGE_RING then
          ChallengeRingMgr:set_is_start(true)
          MsgGame:mq_publish2(Const.MSG_ON_CR_OPEN_PAUSE_BTN)
          UIMgr:get_ui("ui_challenge_ring"):ui_show()
        elseif npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.INIT_BOX then
          Global.camera:set_target(npc_obj)
        elseif npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.REWARD or npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.FIXED_DROP then
          local drop_info = Seri.unpack(param)
          local action = drop_info.action
          local uuid = drop_info.uuid
          if action == CommonDefind.REWARD_NPC_ACTION.PICK_DROP then
            local drop_list = npc_data.mArgs.drop_list
            drop_list[uuid] = nil
          end
          local tower = TowerMgr:get_tower()
          tower:update_npc_list(npc_data.room_num, npc_data)
          self.v_is_get_thing = false
          self:show_collection_tip(npc_data.mArgs.drop_list)
        elseif npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.CURSE_RING then
          MsgGame:mq_publish2(Const.MSG_ON_FATE_BOOK_CHECK_NEXT_START_STEP)
        end
        local msg = MsgGame:mq_publish2(Const.MSG_ON_INTERACT_NPC_SUCCESS)
        msg.mm_obj = npc_data
        msg.mm_x = param
        msg.mm_y = resp
        if cb then
          cb()
        end
        if self:is_need_send_interact_npc(npc_data, param) then
          SceneMgr:c2gs_call_scene("on_func_npc_interact_end", npc_id)
          BehaviorMgr:call_scene_logic_event_fun("on_func_npc_interact_end", npc_id)
        end
      elseif FUN_NPC_HELPER.is_reward_npc(npc_id) then
        self.v_is_get_thing = false
      end
    end)
  end
end

function M:check_scene_event_function(npc_cfg)
  if npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.CHOOSE_NPC then
    SceneEventMgr:set_npc_id(npc_cfg.Id)
    UIMgr:get_ui("scene_event_main"):ui_show(npc_cfg.Id)
    return true
  end
  return false
end

function M:choose_battle_task_end(npc_data, task_id)
  local temp = {task_id = task_id}
  local pack_args = Seri.packstring(temp)
  self:on_interact_with_npc(npc_data, pack_args)
end

function M:interact_with_no_fight_game_npc(npc_data, action)
  local temp = {action = action}
  local pack_args = Seri.packstring(temp)
  self:on_interact_with_npc(npc_data, pack_args)
end

function M:interact_with_challenge_ring_npc(npc_data)
  self:on_interact_with_npc(npc_data)
end

function M:interact_with_rune_shop_npc(npc_data)
  self:on_interact_with_npc(npc_data)
end

function M:interact_with_ornaments_shop_npc(npc_data)
  self:on_interact_with_npc(npc_data)
end

function M:interact_with_init_box_npc(npc_data)
  self:on_interact_with_npc(npc_data)
end

function M:interact_with_reawrd_npc(npc_data, cb)
  local temp = {
    action = CommonDefind.REWARD_NPC_ACTION.SHOW_DROP
  }
  local pack_args = Seri.packstring(temp)
  self:on_interact_with_npc(npc_data, pack_args, cb)
end

function M:interact_reawrd_npc_auto_get(npc_data)
  local drop_list = npc_data.mArgs.drop_list
  if not drop_list then
    Log.Error("npc not have drop list npc_id = ", npc_data.npc_id)
    return
  end
  for uuid, _ in pairs(drop_list) do
    local temp = {
      action = CommonDefind.REWARD_NPC_ACTION.PICK_DROP,
      uuid = uuid
    }
    local pack_args = Seri.packstring(temp)
    self:on_interact_with_npc(npc_data, pack_args)
  end
end

function M:interact_reawrd_npc_item_get(npc_data, uuid, cb, drop_tb)
  if not uuid then
    Log.Error("npc not have drop list npc_id = ", npc_data.npc_id)
    return
  end
  local temp = {
    action = CommonDefind.REWARD_NPC_ACTION.PICK_DROP,
    uuid = uuid
  }
  local pack_args = Seri.packstring(temp)
  self:on_interact_with_npc(npc_data, pack_args, cb, drop_tb)
end

function M:interact_choose_npc(npc_data)
  UIMgr:get_ui("scene_event_main"):ui_show(npc_data, function()
    local index = SceneEventMgr:get_choose_option_index()
    local temp = {option_index = index}
    local pack_args = Seri.packstring(temp)
    self:on_interact_with_npc(npc_data, pack_args)
  end)
end

function M:interact_game_npc(npc_data)
  local arg3 = npc_data.npc_cfg.Arg[3]
  if not (arg3 and arg3[1]) or #arg3[1] < 2 then
    Log.Error("param Arg[3] is error, npc_id = ", npc_data.npc_id)
    return
  end
  local game_type = arg3[1][1]
  local game_id = arg3[1][2]
  
  local function finish_cb()
    self:on_interact_with_npc(npc_data)
    BehaviorMgr:call_scene_logic_event_fun("on_mini_game_finish", game_type, game_id)
  end
  
  local arg2 = npc_data.npc_cfg.Arg[2]
  if arg2 then
    if tonumber(arg2[1]) < #arg3[1] - 1 then
      Log.Error("非常规挑战模式配置游戏id数量小于目标, npc_id = ", npc_data.npc_id)
      return
    end
    local game_id_list = {}
    for index = 2, #arg3[1] do
      game_id_list[index - 1] = arg3[1][index]
    end
    if game_type == Config.MINI_GAME_TYPE.WATER_PIPE then
      local first_game_id = game_id_list[1]
      local first_game_cfg = ShareRes.create("minigame.waterpipe." .. first_game_id)
      if 2 == first_game_cfg.uiType then
        UIMgr:get_ui("ui_water_pipe_sp"):ui_show(game_id, finish_cb, arg2, game_id_list)
      else
        UIMgr:get_ui("ui_water_pipe"):ui_show(game_id, finish_cb, arg2, game_id_list)
      end
    elseif game_type == Config.MINI_GAME_TYPE.INSERT_NEEDLE then
      UIMgr:get_ui("mini_game_insert_needle"):ui_show(game_id, finish_cb, arg2, game_id_list)
    end
    return
  end
  if game_type == Config.MINI_GAME_TYPE.WATER_PIPE then
    if game_id and 0 ~= game_id then
      local game_cfg = ShareRes.create("minigame.waterpipe." .. game_id)
      if 2 == game_cfg.uiType then
        UIMgr:get_ui("ui_water_pipe_sp"):ui_show(game_id, finish_cb)
      else
        UIMgr:get_ui("ui_water_pipe"):ui_show(game_id, finish_cb)
      end
    end
  elseif game_type == Config.MINI_GAME_TYPE.INSERT_NEEDLE then
    UIMgr:get_ui("mini_game_insert_needle"):ui_show(game_id, finish_cb)
  end
end

function M:is_get_thing()
  return self.v_is_get_thing
end

function M:reset_get_thing()
  self.v_is_get_thing = false
end

function M:_reconnect()
  self:reset_get_thing()
end

function M:is_need_send_interact_npc(npc_data)
  local npc_id = npc_data.npc_id
  if FUN_NPC_HELPER.is_reward_npc(npc_id) then
    return false
  end
  return true
end

function M:show_collection_tip(drop_list)
  for key, value in pairs(drop_list) do
    local item_cfg = Item_Helper.get_item_cfg(value.id)
    if item_cfg.Type == BagCfg.BATTLE_ITEM_TYPE.MAIN_COLLECTION then
      UIMgr:get_ui("collection_tip"):ui_show(value.id)
      return
    end
  end
end

local function _show_challenge_ring_plus_shop_room(self, shop_type)
  local challenge_ring_plus_shop_room = UIMgr:get_ui("challenge_ring_plus_shop_room")
  if challenge_ring_plus_shop_room:visible() then
    challenge_ring_plus_shop_room:refresh_data(self.shop_data.shop_data, shop_type, self.cur_npc_data)
  else
    challenge_ring_plus_shop_room:ui_show(self.shop_data.shop_data, shop_type, self.cur_npc_data)
  end
end

function M:on_refresh_npc_shop_data(data)
  if self.cur_interact_npc_type then
    self.shop_data = data
    local shop_type
    if self.cur_interact_npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.ORNAMENTS_SHOP then
      shop_type = CommonDefind.CURSE_CARD_TYPE.SHOP_ORNAMENTS
    elseif self.cur_interact_npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.RUNE_SHOP then
      shop_type = CommonDefind.CURSE_CARD_TYPE.SHOP_RUNE
    end
    if shop_type then
      _show_challenge_ring_plus_shop_room(self, shop_type)
    end
  end
end

function M:get_shop_data()
  return self.shop_data
end

local prefab_name = "UI_Hud5"
local npc_hud_list = {}
local is_need_update_progress = false
local UnityTime = UnityEngine.Time
local rich_callback
local on_curr_press_interaction_npc_id = 0
local is_point_click
local normal_click_add_progress = 0.1
local curr_hud_add_or_release_type = 0

function M:add_interaction_npc_hud(npc_data)
  local npc_id = npc_data.npc_id
  on_curr_press_interaction_npc_id = npc_id
  if not npc_hud_list then
    return
  end
  local curr_info = npc_hud_list[npc_id]
  if curr_info then
    curr_hud_add_or_release_type = 1
    curr_info.last_press_time = UnityTime.realtimeSinceStartup
    return
  end
  local dynamic_ui = UIMgr:try_get_ui("uidynamic_canvas")
  if not dynamic_ui then
    Log.Error("uidynamic_canvas 不存在")
    return
  end
  local pos = npc_data.pos
  ResPoolMgr:get_ui_effect_async(prefab_name, function(go)
    local parent = dynamic_ui:get_interaction_npc_hud_root_trans()
    local trans = go.transform
    trans:SetParent(parent)
    trans:SetLocalScaleA(1.5, 1.5, 1.5)
    curr_info = {}
    curr_info.trans = trans
    curr_info.pos = UnityVector3(pos.x, pos.y + 1.5, pos.z)
    curr_info.last_press_time = UnityTime.realtimeSinceStartup
    curr_info.pressed_time = 0
    curr_info.long_press_time = 5
    curr_info.long_press_time = npc_data.npc_cfg.LongPressTime
    curr_info.go = go
    npc_hud_list[npc_id] = curr_info
    self:on_npc_hud_init(npc_id)
  end)
end

function M:on_npc_hud_init(npc_id)
  local trans = npc_hud_list[npc_id].trans
  self:set_interaction_npc_progress(0)
  self:set_hud_progress_over_timeline_visible(trans, false)
  self:set_hud_hide_unglow_timeline_visible(trans, false)
  self:set_hud_show_timeline_visible(trans, true)
  local canvas_group = Util.get_canvas_group("Slider", trans.gameObject)
  canvas_group.alpha = 1
  local fill_area_group = Util.get_canvas_group("Slider/Fill Area", trans.gameObject)
  fill_area_group.alpha = 1
  self:set_ring_effect_visible(npc_id, false)
  curr_hud_add_or_release_type = 2
end

function M:release_interaction_npc_hud(npc_id, is_play_anim)
  SceneMgr:set_player_control_on()
  is_need_update_progress = false
  if not npc_hud_list then
    return
  end
  if not npc_hud_list[npc_id] then
    return
  end
  local go = npc_hud_list[npc_id].go
  if not go then
    npc_hud_list[npc_id] = nil
    return
  end
  local obj = npc_hud_list[npc_id].trans.gameObject
  curr_hud_add_or_release_type = 2
  self:set_ring_effect_visible(npc_id, true)
  if is_play_anim then
    self:set_hud_hide_unglow_timeline_visible(obj.transform, true)
    Timer:add_timer("hide_interaction_npc", 0.4, function()
      if 1 == curr_hud_add_or_release_type then
        curr_hud_add_or_release_type = 2
        self:set_hud_show_timeline_visible(obj.transform, false)
        self:on_npc_hud_init(npc_id)
        return
      end
      ResPoolMgr:release(go)
      npc_hud_list[npc_id] = nil
    end)
    return
  end
  ResPoolMgr:release(go)
  npc_hud_list[npc_id] = nil
end

function M:get_interaction_npc_list()
  return npc_hud_list
end

function M:update_interaction_npc_hud()
  if npc_hud_list then
    for i, v in pairs(npc_hud_list) do
      if v and v.trans and v.pos then
        local half_screen_width = Global.ui_dynamic_canvas:get_rect_size_delta_x() / 2
        local half_screen_height = Global.ui_dynamic_canvas:get_rect_size_delta_y() / 2
        local view_port = Global.camera:get_camera():WorldToViewportPoint(v.pos)
        if view_port.z < 0 then
          v.trans:SetLocalPositionA(9999, 9999, -1)
        else
          local result_pos_x = view_port.x * Global.ui_dynamic_canvas:get_rect_size_delta_x()
          local result_pos_y = view_port.y * Global.ui_dynamic_canvas:get_rect_size_delta_y()
          v.trans:SetLocalPositionA(result_pos_x - half_screen_width, result_pos_y - half_screen_height, 0)
        end
      end
    end
  end
  if is_need_update_progress then
    self:update_interaction_npc_progress()
  end
end

function M:set_is_need_update(npc_data, value, is_normal_click)
  if is_need_update_progress == value then
    return
  end
  if value then
    SceneMgr:set_player_control_off()
  else
    SceneMgr:set_player_control_on()
  end
  local npc_id = npc_data.npc_id
  if not npc_hud_list then
    return
  end
  local npc_info = npc_hud_list[npc_id]
  if not npc_info then
    return
  end
  is_need_update_progress = value
  is_point_click = is_normal_click
  if value then
    npc_info.last_press_time = UnityTime.realtimeSinceStartup
  elseif npc_data.npc_cfg.LongPressStop then
    self:set_interaction_npc_progress(0)
  else
    local press_time = UnityTime.realtimeSinceStartup - npc_info.last_press_time
    npc_info.pressed_time = npc_info.pressed_time + press_time
  end
end

function M:update_interaction_npc_progress()
  if not npc_hud_list then
    return
  end
  self:set_interaction_npc_progress()
end

function M:set_interaction_npc_progress(value)
  local npc_info = npc_hud_list[on_curr_press_interaction_npc_id]
  if not npc_info then
    return
  end
  local trans = npc_info.trans
  local curr_slider = Util.get_slider("Slider", trans.gameObject)
  if not value then
    value = (npc_info.pressed_time + UnityTime.realtimeSinceStartup - npc_info.last_press_time) / npc_info.long_press_time
    if is_point_click then
      if value > normal_click_add_progress * 2 then
        is_point_click = nil
        is_need_update_progress = false
        npc_info.pressed_time = 0
        return
      end
      if value > normal_click_add_progress then
        value = normal_click_add_progress * 2 - value
      end
    end
  end
  curr_slider.value = value
  if curr_slider.value >= 1 and rich_callback then
    self:set_hud_progress_over_timeline_visible(trans, true)
    rich_callback()
    rich_callback = nil
    Timer:add_timer("hide_interaction_npc", 0.2, function()
      is_need_update_progress = false
      self:release_interaction_npc_hud(on_curr_press_interaction_npc_id)
    end)
  end
end

function M:set_hud_progress_over_timeline_visible(trans, visible)
  local show_timeline = Util.get_child_gameobj("Animation/FX_UI_Hud5", trans.gameObject)
  show_timeline:SetActive(visible)
end

function M:set_hud_hide_unglow_timeline_visible(trans, visible)
  local show_timeline = Util.get_child_gameobj("Animation/UI_Hud5_Hide_UnGlow", trans.gameObject)
  show_timeline:SetActive(visible)
end

function M:set_hud_show_timeline_visible(trans, visible)
  local show_timeline = Util.get_child_gameobj("Animation/UI_Hud5_Show", trans.gameObject)
  show_timeline:SetActive(visible)
end

function M:set_rich_callback(callback)
  rich_callback = callback
end

function M:get_functional_npc(npc_id)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  return scene_logic:get_func_npc(npc_id)
end

function M:set_ring_effect_visible(npc_id, visible)
  local func_npc = self:get_functional_npc(npc_id)
  if not func_npc then
    return
  end
  func_npc:set_ring_effect_visible(visible)
end

local chat_prefab_name = "UI_HudTalking"
local role_npc_chat_list = {}

function M:add_role_npc_bubble_chat(npc_lua)
  if self:check_is_need_remove_bubble_or_jump(npc_lua) then
    return
  end
  local npc_data = npc_lua.data
  local npc_id = npc_data.npc_id
  if not role_npc_chat_list then
    return
  end
  local curr_info = role_npc_chat_list[npc_id]
  if curr_info then
    return
  end
  local dynamic_ui = UIMgr:try_get_ui("uidynamic_canvas")
  if not dynamic_ui then
    Log.Error("uidynamic_canvas 不存在")
    return
  end
  ResPoolMgr:get_ui_effect_async(chat_prefab_name, function(go)
    local parent = dynamic_ui:get_role_npc_chat_root_trans()
    local trans = go.transform
    trans:SetParent(parent)
    trans:SetLocalScaleA(1, 1, 1)
    curr_info = {}
    curr_info.trans = trans
    curr_info.npc_lua = npc_lua
    curr_info.const_wait_time = npc_lua.data.npc_cfg.ChatCD or 3
    curr_info.wait_time = curr_info.const_wait_time
    curr_info.const_show_time = npc_lua.data.npc_cfg.ChatDuration or 3
    if -1 == curr_info.const_show_time then
      curr_info.const_show_time = 999999
    end
    curr_info.show_time = curr_info.const_show_time
    curr_info.type = 2
    curr_info.chat_index = 0
    curr_info.index_list, curr_info.content_list = self:get_chat_content_list(curr_info.npc_lua)
    curr_info.go = go
    self:refresh_npc_lua_bubble_point(npc_lua, curr_info)
    self:refresh_chat_content(curr_info)
    role_npc_chat_list[npc_id] = curr_info
  end)
end

function M:set_role_npc_bubble_chat_enable(npc_id, enable)
  if not role_npc_chat_list then
    return
  end
  if not role_npc_chat_list[npc_id] then
    return
  end
  local go = role_npc_chat_list[npc_id].go
  if go then
    go:SetActive(enable)
  end
end

function M:refresh_npc_lua_bubble_point(npc_lua, info)
  if not npc_lua.transform then
    return
  end
  local obj_bubble_point_trans = npc_lua.transform:Find(bubble_point)
  if obj_bubble_point_trans then
    local pos = obj_bubble_point_trans.position
    if npc_lua.data.npc_cfg.ChatHeight then
      pos = UnityVector3(pos.x, pos.y + npc_lua.data.npc_cfg.ChatHeight, pos.z)
    end
    info.bubble_point = pos
  end
end

function M:release_role_npc_bubble_chat(npc_id)
  if not role_npc_chat_list then
    return
  end
  if not role_npc_chat_list[npc_id] then
    return
  end
  local go = role_npc_chat_list[npc_id].go
  if not go then
    role_npc_chat_list[npc_id] = nil
    return
  end
  ResPoolMgr:release(go)
  role_npc_chat_list[npc_id] = nil
end

function M:check_is_need_remove_bubble_or_jump(npc_lua)
  local remove_bubble = npc_lua.data.npc_cfg.RemoveBubble
  if (not remove_bubble or 1 == remove_bubble) and npc_lua.data.is_get == true then
    return true
  end
  return false
end

function M:check_is_need_refresh_bubble_content(npc_lua, npc_chat)
  local remove_bubble = npc_lua.data.npc_cfg.RemoveBubble
  if remove_bubble and 0 == remove_bubble and npc_lua.data.is_get == true and 2 == npc_chat.type then
    npc_chat.type = 3
    return true
  end
  return false
end

function M:update_role_npc_bubble_chat_pos()
  if not role_npc_chat_list then
    return
  end
  if role_npc_chat_list then
    for i, v in pairs(role_npc_chat_list) do
      if 1 == v.type then
        v.wait_time = v.wait_time - Global.delta_time
        if v.wait_time > 0 then
        elseif self:check_is_need_remove_bubble_or_jump(v.npc_lua) then
          self:release_role_npc_bubble_chat(v.npc_lua.data.npc_id)
        else
          v.type = 2
          v.wait_time = v.const_wait_time
          self:refresh_chat_pos(v)
          self:refresh_chat_content(v)
          v.trans.gameObject:SetActive(true)
        end
      else
        if self:check_is_need_remove_bubble_or_jump(v.npc_lua) then
          self:release_role_npc_bubble_chat(v.npc_lua.data.npc_id)
          goto lbl_117
        elseif self:check_is_need_refresh_bubble_content(v.npc_lua, v) then
          self:refresh_chat_content(v)
        end
        if 2 == v.type then
          v.show_time = v.show_time - Global.delta_time
          if v.show_time <= 0 then
            v.type = 1
            v.show_time = v.const_show_time
            v.trans.gameObject:SetActive(false)
            if v.npc_lua and v.chat_index == #v.content_list then
              local interact_over_action = v.npc_lua.data.npc_cfg.InteractOverAction
              if interact_over_action and "" ~= interact_over_action then
                v.npc_lua:player_anim(interact_over_action, function()
                  local role_action_type = v.npc_lua.data.npc_cfg.RoleActionType
                  if role_action_type and "" ~= role_action_type then
                    v.npc_lua:player_anim(role_action_type)
                  else
                    v.npc_lua:player_anim(Config.ACT_DEFINE.Idle2)
                  end
                end)
              end
            end
        end
        else
          self:refresh_chat_pos(v)
        end
      end
      ::lbl_117::
    end
  end
end

function M:refresh_chat_pos(v)
  if not (v and v.trans and v.npc_lua) or not v.npc_lua.transform then
    return
  end
  local half_screen_width = Global.ui_dynamic_canvas:get_rect_size_delta_x() / 2
  local half_screen_height = Global.ui_dynamic_canvas:get_rect_size_delta_y() / 2
  local pos = v.bubble_point
  if not pos then
    self:refresh_npc_lua_bubble_point(v.npc_lua, role_npc_chat_list[v.npc_lua.data.npc_id])
    pos = v.npc_lua.transform.position
    pos = UnityVector3(pos.x, pos.y + 2, pos.z)
  end
  local view_port = Global.camera:get_camera():WorldToViewportPoint(pos)
  if view_port.z < 0 then
    v.trans:SetLocalPositionA(9999, 9999, -1)
  else
    local result_pos_x = view_port.x * Global.ui_dynamic_canvas:get_rect_size_delta_x()
    local result_pos_y = view_port.y * Global.ui_dynamic_canvas:get_rect_size_delta_y()
    v.trans:SetLocalPositionA(result_pos_x - half_screen_width, result_pos_y - half_screen_height, 0)
  end
end

function M:refresh_chat_content(v)
  local show_content = self:get_chat_content(v)
  local text = Util.get_text("Main/TalkDesc", v.trans)
  text.text = show_content
end

function M:get_point_list(npc_id)
  local npc_data = self:get_role_npc_data(npc_id)
  if not npc_data then
    return
  end
  local role_patrol_area_str = npc_data.npc_cfg.RolePatrolArea
  if not role_patrol_area_str then
    return
  end
  local list = Util.split_str(role_patrol_area_str, "|")
  return list
end

function M:get_chat_content_list(npc_lua)
  if not npc_lua or not npc_lua.data then
    return
  end
  local chat_list = npc_lua.data.npc_cfg.ChatContent
  if not chat_list then
    return
  end
  local index_list = {}
  local content_list = {}
  for i = 1, #chat_list do
    local list = Util.split_str(chat_list[i], "|")
    local content_value
    if 2 == #list then
      index_list[#index_list + 1] = tonumber(list[1])
      content_value = list[2]
    else
      content_value = list[1]
    end
    content_list[#content_list + 1] = content_value
  end
  return index_list, content_list
end

function M:get_chat_content(curr_info)
  if 0 == curr_info.npc_lua.data.npc_cfg.RemoveBubble and curr_info.npc_lua.data.is_get == true then
    local content = curr_info.npc_lua.data.npc_cfg.InteractOverChat
    if not content or "" == content then
      if not curr_info.content_list or 0 == #curr_info.content_list then
        return
      end
      content = curr_info.content_list[#curr_info.content_list]
    end
    curr_info.chat_index = 0
    return content
  end
  local num = 0
  if not curr_info.content_list or 0 == #curr_info.content_list then
    return
  end
  local index = 1
  if not curr_info.index_list or 0 == #curr_info.index_list then
    index = curr_info.chat_index + 1
    if index > #curr_info.content_list then
      index = 1
    end
  else
    for i = 1, #curr_info.index_list do
      num = num + curr_info.index_list[i]
    end
    local ran_num = math.random(1, num)
    for i = 1, #curr_info.index_list do
      if ran_num <= curr_info.index_list[i] then
        index = i
        break
      end
    end
  end
  curr_info.chat_index = index
  local chat_action_list = curr_info.npc_lua.data.npc_cfg.ChatActionList
  if chat_action_list and #chat_action_list > 0 then
    local action_name = chat_action_list[index]
    if action_name and "" ~= action_name then
      curr_info.npc_lua:player_anim(action_name, function()
        curr_info.npc_lua:player_anim(Config.ACT_DEFINE.Idle2)
      end)
    end
  end
  return curr_info.content_list[index]
end

function M:is_need_show_bubble_with_npc_cfg(npc_cfg)
  if not npc_cfg.ChatContent or 0 == #npc_cfg.ChatContent then
    return false
  end
  local is_all_nil = true
  for i, v in pairs(npc_cfg.ChatContent) do
    if v and "" ~= v then
      is_all_nil = false
    end
  end
  return false == is_all_nil
end

function M:get_role_npc_data(npc_id)
  if not role_npc_chat_list then
    return
  end
  local info = role_npc_chat_list[npc_id]
  if not (info and info.npc_lua) or not info.npc_lua.data then
    return
  end
  return info.npc_lua.data
end

function M:change_functional_npc_action(npc_id, action_name)
  local all_functional_npc = Global.scene_mgr:get_all_functional_npc()
  for i, npc_lua in pairs(all_functional_npc) do
    if npc_lua.data and npc_lua.data.npc_id == npc_id then
      npc_lua:player_anim(action_name)
      break
    end
  end
end

function M:on_settlement_win_open()
  if TowerMgr and TowerMgr:get_tower() then
    self:release_all()
  end
end

function M:release_all()
  if npc_hud_list then
    local temp_list = {}
    for npc_id, v in pairs(npc_hud_list) do
      temp_list[npc_id] = 1
    end
    for npc_id, v in pairs(temp_list) do
      self:release_interaction_npc_hud(npc_id)
    end
    npc_hud_list = {}
    temp_list = nil
  end
  if role_npc_chat_list then
    for npc_id, v in pairs(role_npc_chat_list) do
      self:release_role_npc_bubble_chat(npc_id)
    end
  end
end

function M:request_interact_with_exhibition_npc(npc_name, callback)
  local send_data = {name = npc_name}
  Network:call("c2gs_interact_with_exhibition_npc", send_data, function(ok, resp)
    if ok and callback then
      callback(resp)
    else
    end
  end)
end

return M
