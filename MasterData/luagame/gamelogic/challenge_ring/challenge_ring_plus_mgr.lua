local Base = require("gamelogic.base_system")
local Seri = require("seri")
local Battle_Shop_Cfg = require("uimodule.battle_shop.battle_shop_cfg")
local CommonDef = require("cs_share.common_define")
local CommonDefine = require("cs_share.common_define")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local DESTINY_DROP_STATE = curse_com_def.DESTINY_DROP_STATE
local Award_type = curse_com_def.AWARD_TYPE
local Act_ID = CommonDefine.ACTY_TYPE.CURSE_CIRCLE
local DROP_TYPE = Config.DROP_TYPE
local CURSE_CARD_TYPE = CommonDefine.CURSE_CARD_TYPE
local CURSE_TASK_COMPLETE_TYPE = CommonDefine.CURSE_TASK_COMPLETE_TYPE
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local TEAM_LV_CHANGE_STATE = RUNE_HELPER.TEAM_LV_CHANGE_STATE
local PICK_UP_BACK_TIME = 1.75
local CURSE_COUNT_LIMIT = 4
local LocalStorage = require("utils.localstorage")
local LOCAL_CHAL_RING_DIFFICULTY_LEVEL_KEY = "LOCAL_CHAL_RING_DIFFICULTY_LEVEL_KEY"
local FightDefine = require("cs_share.fight_define")
local DESTINY_DROP_RED = "DESTINY_DROP_RED"
local ATTR_TYPE = FightDefine.ATTR_TYPE
local M = Util.create_child_mt(Base)
local ADD_CURSE_TYPE = curse_com_def.ADD_CURSE_TYPE
local ADD_CURSE_ORDER = {
  [1] = ADD_CURSE_TYPE.SELECT_CARD,
  [2] = ADD_CURSE_TYPE.FIGHT_END,
  [3] = ADD_CURSE_TYPE.KILL_ENEMY,
  [4] = ADD_CURSE_TYPE.KILL_BOSS,
  [5] = ADD_CURSE_TYPE.SELL_ORN,
  [6] = ADD_CURSE_TYPE.SHOP_BUY
}
local BEFORE_BACK_RING_CHECK_UI = {battle_bag4 = true, challenge_ring_plus = true}
local CRAD_TYPE_FUN = {
  [CommonDef.CURSE_CARD_TYPE.FIGHT_PRIMARY] = "select_battle_card",
  [CommonDef.CURSE_CARD_TYPE.FIGHT_SENIOR] = "select_battle_card",
  [CommonDef.CURSE_CARD_TYPE.FIGHT_COIN] = "select_battle_card",
  [CommonDef.CURSE_CARD_TYPE.BOSS] = "select_battle_card",
  [CommonDef.CURSE_CARD_TYPE.SHOP_RUNE] = "select_shop_room",
  [CommonDef.CURSE_CARD_TYPE.RESTORE_HP] = "select_heal_card",
  [CommonDef.CURSE_CARD_TYPE.SHOP_ORNAMENTS] = "select_shop_room",
  [CommonDef.CURSE_CARD_TYPE.FORGE_UPGRADE] = "select_rune_forge_room",
  [CommonDef.CURSE_CARD_TYPE.DOOR] = "select_door_card",
  [CommonDef.CURSE_CARD_TYPE.FORGE_ENTRY] = "select_rune_forge_room",
  [CommonDef.CURSE_CARD_TYPE.TASK] = "select_task_room",
  [CommonDef.CURSE_CARD_TYPE.RECUPERATION] = "select_recuperation_card",
  [CommonDef.CURSE_CARD_TYPE.EVENT] = "select_event_card",
  [CommonDef.CURSE_CARD_TYPE.MINI_GAME] = "select_battle_card",
  [CommonDef.CURSE_CARD_TYPE.NEW_SHOP] = "select_shop_card"
}
local BATTLE_CARD = {
  [CommonDef.CURSE_CARD_TYPE.FIGHT_PRIMARY] = true,
  [CommonDef.CURSE_CARD_TYPE.FIGHT_SENIOR] = true,
  [CommonDef.CURSE_CARD_TYPE.FIGHT_COIN] = true,
  [CommonDef.CURSE_CARD_TYPE.BOSS] = true,
  [CommonDef.CURSE_CARD_TYPE.MINI_GAME] = true
}
local MULTI_BUY_CARD = {
  [CommonDef.CURSE_CARD_TYPE.RESTORE_HP] = true,
  [CommonDef.CURSE_CARD_TYPE.FORGE_ENTRY] = true,
  [CommonDef.CURSE_CARD_TYPE.FORGE_UPGRADE] = true,
  [CommonDef.CURSE_CARD_TYPE.NEW_SHOP] = true
}
local BUFF_STATE = {INACTIVE = 0, ACTIVE = 1}

function M:init_sys()
  Base.init_sys(self)
  self:init_data()
end

function M:init_data()
  self.v_battle_msg_handles = {}
  self.v_is_frist_enter = true
  self.v_last_total_curse = 0
  self.v_curse_val = 0
  self.v_debuff_list = {}
  self.v_ornaments_list = {}
  self.v_card_list = {}
  self.v_show_card_index_list = {}
  self.v_curse_val_limit = 0
  self.v_add_curse_limit = 0
  self.v_cur_circle_index = nil
  self:set_cur_select_card_index(nil)
  self.v_acty_level = 0
  self.v_weekly_get_contribute_point = 0
  self.v_contribute_shop_list = {}
  self.v_bless_list = {}
  self.v_bless_unlock_map = {}
  self.v_last_ring_data_map = nil
  self.v_ring_data_map = {}
  self.v_destiny_level_data = {}
  self.v_bless_pos_list = {}
  self.v_add_jump_card_pro = 0
  self.v_curse_delay_time = 0
  self.v_per_interval_add_curse_ratio = 0
  self.v_curse_interval_ratio = 0
  self.v_curse_interval_value = 0
  self.v_round_cnt = 0
  self.v_fight_time = 0
  self.v_weekly_get_contribute_point_limit = 0
  self.v_on_battle_bless_list = {}
  self.v_debuff_list_old = {}
  self.v_attr_by_uuid = {}
  self.v_pay_coin_discount = 0
  self.v_is_first_max_value = false
  self.v_pay_curse_discount = 0
  self.v_is_in_curse_fighting = false
  self.v_is_in_multi_buy_view = false
  self.is_have_reduce_curse_val_buff = false
  self.is_have_add_kill_boss_buff = false
  self.fight_add_curse_list = {}
  self.kill_enemy_uuids = {}
  self.kill_enemy_npc_ids = {}
  self.kill_not_monster_uuids = {}
  self.kill_not_monster_npc_ids = {}
  self.sell_orn_curse_value = 0
  self.skip_card_add_curse_value = 0
  self.reduce_curse_mulit = 0
  self.kill_boss_add_curse = 0
  self.is_not_use_curse_buy = false
  self.v_ring_box_list = {}
  self.v_door_status = false
  self.v_update_data_queue = {}
  self.v_curse_task_map = {}
  self.v_card_drop_lock = {}
  self.v_invalid_debuff_indexs = nil
  self.v_destiny_drop_red_map = LocalStorage:load_table(DESTINY_DROP_RED, true)
end

function M:init_cfg()
  self.v_card_cfg = ShareRes.create("activity/curse_ring_card")
end

function M:bind_battle_event()
  for event_name, func_name in pairs(curse_com_def.BATTLE_EVENT_NAME) do
    if self[func_name] then
      self.v_battle_msg_handles[event_name] = self:sys_mq_bind(event_name, self[func_name], self)
    end
  end
end

function M:unbind_battle_event()
  for key, handle in pairs(self.v_battle_msg_handles) do
    self:sys_mq_unbind(handle)
    self.v_battle_msg_handles[key] = nil
  end
end

function M:enter_tower()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    return
  end
  self:bind_battle_event()
end

function M:exit_tower()
  self:check_remove_back_ring_timer()
  self.v_remove_data = nil
  self.v_cur_circle_index = nil
  self.fight_add_curse_list = {}
  self.kill_enemy_uuids = {}
  self.kill_enemy_npc_ids = {}
  self.kill_not_monster_uuids = {}
  self.kill_not_monster_npc_ids = {}
  self.v_drop_award_data_queue = {}
  self.sell_orn_curse_value = 0
  self.v_curse_val_limit = 0
  self.v_last_total_curse = 0
  self.v_add_curse_limit = 0
  self.v_add_jump_card_pro = 0
  self.v_curse_delay_time = 0
  self.v_per_interval_add_curse_ratio = 0
  self.v_curse_interval_ratio = 0
  self.v_curse_interval_value = 0
  self.v_round_cnt = 0
  self.v_fight_time = 0
  self.reduce_curse_mulit = 0
  self.kill_boss_add_curse = 0
  self.v_attr_by_uuid = {}
  self.v_is_frist_enter = true
  self.v_debuff_list_old = {}
  self.v_debuff_list = {}
  self.before_fight_curse_value = 0
  self.before_fight_debuff_list = {}
  self.v_curses_library_cfg = nil
  self.v_curse_level_change_param = nil
  self.v_record_mini_game_task_item = nil
  self.v_choose_recuperation_id = nil
  self.v_pay_coin_discount = 0
  self.v_pay_curse_discount = 0
  self.skip_card_add_curse_value = 0
  self.v_is_in_curse_fighting = false
  self.v_is_in_multi_buy_view = false
  self.is_on_pre_tp_room = false
  self.is_on_tp_room_finish = false
  self:set_is_curse_fight_state(false)
  self.is_have_reduce_curse_val_buff = false
  self.is_have_add_kill_boss_buff = false
  self.is_not_use_curse_buy = false
  self.v_door_status = false
  self:set_is_show_card_plus(false)
  self.v_curse_task_map = {}
  self.v_card_drop_lock = {}
  self.v_update_data_queue = {}
  self.v_invalid_debuff_indexs = nil
  self.v_select_mini_game_id = nil
  UIMgr:try_destory_ui("challenge_ring_plus")
  self:unbind_battle_event()
end

function M:add_fight_time(add_time)
  self.v_fight_time = self.v_fight_time + add_time
end

function M:get_round_cnt()
  return self.v_round_cnt
end

function M:get_fight_time()
  return self.v_fight_time
end

function M:get_jump_card_pro()
  return math.max(self.v_jump_card_pro, 0)
end

function M:set_curse_val(curse_val)
  self.v_curse_val = curse_val
end

function M:get_curse_val()
  return self.v_curse_val
end

function M:get_debuff()
  return self.v_debuff_list
end

function M:get_debuff_old()
  return self.v_debuff_list_old
end

function M:set_debuff_old(buff_list)
  self.v_debuff_list_old = buff_list
end

function M:get_ornaments()
  return self.v_ornaments_list
end

function M:get_show_card_index_list()
  return self.v_show_card_index_list
end

function M:get_show_card_index_list_num()
  return #self.v_show_card_index_list
end

function M:get_curse_val_limit()
  return self.v_curse_val_limit
end

function M:add_pay_coin_discount(add_val)
  self.v_pay_coin_discount = self.v_pay_coin_discount + add_val
  MsgGame:mq_publish2(Const.MSG_ON_PAYMENT_BUFF_CAHNGE)
end

function M:get_pay_coin_discount()
  return self.v_pay_coin_discount
end

function M:add_pay_curse_discount(add_val)
  self.v_pay_curse_discount = self.v_pay_curse_discount + add_val
  MsgGame:mq_publish2(Const.MSG_ON_PAYMENT_BUFF_CAHNGE)
end

function M:get_pay_curse_discount()
  return self.v_pay_curse_discount
end

function M:get_after_discount_price(count)
  return math.ceil((1 - self:get_pay_coin_discount()) * count)
end

function M:get_after_discount_curse_price(count)
  return math.ceil((1 - self:get_pay_curse_discount()) * count)
end

function M:add_curse_val_limit(add_curse_limit, uuid, state)
  if not add_curse_limit then
    self.v_attr_by_uuid[uuid] = nil
    local _, next_map = next(self.v_attr_by_uuid)
    self.v_add_curse_limit = next_map and next_map.add_curse_limit or 0
    self:update_curse_val_limit()
    MsgGame:mq_publish2(Const.MSG_CURSE_UPDATE)
    return
  end
  if not self.v_attr_by_uuid[uuid] then
    self.v_attr_by_uuid[uuid] = {}
  end
  if state == BUFF_STATE.ACTIVE then
    self.v_attr_by_uuid[uuid].add_curse_limit = add_curse_limit or 0
  elseif self.v_attr_by_uuid[uuid].add_curse_limit then
    self.v_attr_by_uuid[uuid].add_curse_limit = -1 * self.v_attr_by_uuid[uuid].add_curse_limit
  else
    self.v_attr_by_uuid[uuid].add_curse_limit = 0
  end
  self.v_add_curse_limit = self.v_attr_by_uuid[uuid].add_curse_limit
  self:update_curse_val_limit()
  MsgGame:mq_publish2(Const.MSG_CURSE_UPDATE)
end

function M:update_curse_val_limit()
  local cur_num = math.min(CURSE_COUNT_LIMIT, #self.v_debuff_list)
  if not self.v_curses_library_cfg then
    self.v_curse_val_limit = self.v_add_curse_limit
    return
  end
  if self.v_curses_library_cfg.MaxValue[cur_num + 1] then
    self.v_curse_val_limit = self.v_curses_library_cfg.MaxValue[cur_num + 1] + self.v_add_curse_limit
  else
    self.v_curse_val_limit = self.v_curses_library_cfg.MaxValue[cur_num] + self.v_add_curse_limit
  end
end

function M:add_jump_crad_pro(add_val)
  self.v_add_jump_card_pro = self.v_add_jump_card_pro + add_val
  self:update_jump_crad_pro()
end

function M:update_jump_crad_pro()
  self.v_jump_card_pro = self.v_cur_ring_cfg.SkipWeight / 10000
  self.v_jump_card_pro = self.v_jump_card_pro + self.v_add_jump_card_pro
end

function M:add_curse_time(add_val, uuid, state)
  if not self.v_attr_by_uuid[uuid] then
    self.v_attr_by_uuid[uuid] = {}
  end
  if state == BUFF_STATE.ACTIVE then
    self.v_attr_by_uuid[uuid].add_val = add_val or 0
  elseif self.v_attr_by_uuid[uuid].add_val then
    self.v_attr_by_uuid[uuid].add_val = -1 * self.v_attr_by_uuid[uuid].add_val
  else
    self.v_attr_by_uuid[uuid].add_val = 0
  end
  self.v_curse_delay_time = self.v_curse_delay_time + self.v_attr_by_uuid[uuid].add_val
end

function M:get_curse_delay_time()
  return self.v_curse_delay_time
end

function M:per_interval_add_curse_ratio(add_curse_value_ratio, uuid, state)
  if not self.v_attr_by_uuid[uuid] then
    self.v_attr_by_uuid[uuid] = {}
  end
  if state == BUFF_STATE.ACTIVE then
    self.v_attr_by_uuid[uuid].add_curse_value_ratio = add_curse_value_ratio or 0
  elseif self.v_attr_by_uuid[uuid].add_curse_value_ratio then
    self.v_attr_by_uuid[uuid].add_curse_value_ratio = -1 * self.v_attr_by_uuid[uuid].add_curse_value_ratio
  else
    self.v_attr_by_uuid[uuid].add_curse_value_ratio = 0
  end
  self.v_per_interval_add_curse_ratio = self.v_per_interval_add_curse_ratio + self.v_attr_by_uuid[uuid].add_curse_value_ratio
end

function M:get_per_interval_add_curse_ratio()
  return self.v_per_interval_add_curse_ratio
end

function M:add_curse_interval_ratio(curse_interval_ratio, uuid, state)
  if not self.v_attr_by_uuid[uuid] then
    self.v_attr_by_uuid[uuid] = {}
  end
  if state == BUFF_STATE.ACTIVE then
    self.v_attr_by_uuid[uuid].curse_interval_ratio = curse_interval_ratio or 0
  elseif self.v_attr_by_uuid[uuid].curse_interval_ratio then
    self.v_attr_by_uuid[uuid].curse_interval_ratio = -1 * self.v_attr_by_uuid[uuid].curse_interval_ratio
  else
    self.v_attr_by_uuid[uuid].curse_interval_ratio = 0
  end
  self.v_curse_interval_ratio = self.v_curse_interval_ratio + self.v_attr_by_uuid[uuid].curse_interval_ratio
end

function M:get_curse_interval_ratio()
  return self.v_curse_interval_ratio
end

function M:add_curse_interval_value(curse_interval_value, uuid, state)
  if not self.v_attr_by_uuid[uuid] then
    self.v_attr_by_uuid[uuid] = {}
  end
  if state == BUFF_STATE.ACTIVE then
    self.v_attr_by_uuid[uuid].curse_interval_value = curse_interval_value or 0
  elseif self.v_attr_by_uuid[uuid].curse_interval_value then
    self.v_attr_by_uuid[uuid].curse_interval_value = -1 * self.v_attr_by_uuid[uuid].curse_interval_value
  else
    self.v_attr_by_uuid[uuid].curse_interval_value = 0
  end
  self.v_curse_interval_value = self.v_curse_interval_value + self.v_attr_by_uuid[uuid].curse_interval_value
end

function M:get_curse_interval_value()
  return self.v_curse_interval_value
end

function M:get_weekly_contribute_point()
  return self.v_weekly_get_contribute_point
end

function M:get_weekly_contribute_point_limit()
  return self.v_weekly_get_contribute_point_limit
end

function M:get_acty_level()
  return self.v_acty_level
end

function M:get_contribute_shop_list()
  return self.v_contribute_shop_list
end

function M:get_bless_list()
  return self.v_bless_list
end

function M:get_ring_box_list()
  return self.v_ring_box_list
end

function M:get_bless_pos_list()
  return self.v_bless_pos_list
end

function M:get_card_cfg_info(card_index)
  local card_id
  for _, card_data in ipairs(self.v_card_list) do
    if card_data.index == card_index then
      card_id = card_data.id
      break
    end
  end
  return self.v_card_cfg[card_id]
end

function M:get_cur_card_cfg_info()
  if not self.v_cur_select_card_index or not self.v_card_list then
    return
  end
  local card_id
  local card_index = self.v_cur_select_card_index
  for _, card_data in ipairs(self.v_card_list) do
    if card_data.index == card_index then
      card_id = card_data.id
      break
    end
  end
  return self.v_card_cfg[card_id]
end

function M:get_card_info(card_index)
  for _, card_data in ipairs(self.v_card_list) do
    if card_data.index == card_index then
      return card_data
    end
  end
end

function M:get_cur_card_info()
  return self:get_card_info(self.v_cur_select_card_index)
end

function M:hero_reborn()
  for index, debuff_id in ipairs(self.v_debuff_list) do
    self:update_curse_effect(debuff_id)
  end
end

function M:_back_challenge_ring_plus_check()
  local visiale_ui
  for ui_name in pairs(BEFORE_BACK_RING_CHECK_UI) do
    visiale_ui = UIMgr:try_get_visible_ui(ui_name)
    if visiale_ui then
      if Global.back_ring_debug then
        Log.Error("返回环失败，ui:", ui_name, "未关闭, 开始重新倒计时", debug.traceback())
      end
      self:check_remove_back_ring_timer()
      visiale_ui:set_hide_cb(function()
        self:start_back_ring_timer()
      end)
      return false
    end
  end
  if not UIMgr.ui_queue_mgr:check_cur_scene_queue_is_empty() then
    return false
  end
  return true
end

function M:back_challenge_ring_plus()
  if self:is_quick_fight() and self:is_end_ring() and self:is_door_open() then
    self:req_enter_door()
    return
  end
  if not self:_back_challenge_ring_plus_check() then
    return
  end
  
  local function story_cb()
    local event_data = self:get_card_event_data()
    if event_data then
      if Util.is_more_than_zero(event_data.event_id) then
        UIMgr:try_show_ui("challenge_ring_plus", "refresh_data")
        UIMgr:try_show_ui("fate_book_event_card", nil, self.v_cur_select_card_index, event_data, true)
      else
        local function remove_cb()
          UIMgr:try_show_ui("challenge_ring_plus", "refresh_data")
        end
        
        self:req_remove_card(remove_cb)
      end
    else
      UIMgr:try_show_ui("challenge_ring_plus", "refresh_data")
    end
  end
  
  self.is_pick_up_all_item = false
  self.v_is_in_curse_fighting = false
  self:check_remove_back_ring_timer()
  self:reset_sell_orn_curse_value()
  local fight_ui = UIMgr:try_get_ui("fight")
  if fight_ui then
    fight_ui:set_hp_visible(false)
  end
  self:check_select_card_story(false, story_cb)
end

function M:response_drop_show_item_end(msg)
  if nil == msg or nil == msg.mm_x or msg.mm_x ~= DROP_TYPE.FIGHT_END then
    return
  end
  local no_drop_point = SceneMgr and SceneMgr:get_scene_item_mgr() and not SceneMgr:get_scene_item_mgr():check_have_drop_point()
  if no_drop_point and self.v_is_in_curse_fighting and self.is_curse_fight_end then
    if UIMgr:try_get_visible_ui("challenge_ring_plus") then
      return
    end
    self:try_start_back_ring_timer()
  end
end

function M:try_start_back_ring_timer()
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info or fight_info.type ~= CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    if Global.back_ring_debug then
      Log.Error("返回环失败，活动模式不为诅咒之环", debug.traceback())
    end
    return
  end
  if not UIMgr.ui_queue_mgr:check_cur_scene_queue_is_empty() then
    if Global.back_ring_debug then
      Log.Error("返回环失败，ui队列不为空", debug.traceback())
    end
    return
  end
  if not self:check_have_ability_drop() and not self:check_have_ornament_drop() and not self:is_in_floor_start_room() then
    if Global.back_ring_debug then
      Log.Error("条件通过，开始倒计时", debug.traceback())
    end
    self:start_back_ring_timer()
    return
  end
  if Global.back_ring_debug then
    if self:check_have_ability_drop() then
      Log.Error("返回环失败，能力掉落尚未选取", debug.traceback())
    end
    if self:check_have_ornament_drop() then
      Log.Error("返回环失败，饰品掉落尚未选取", debug.traceback())
    end
    if self:is_in_floor_start_room() then
      Log.Error("返回环失败，在初始房间内", debug.traceback())
    end
  end
end

function M:start_back_ring_timer()
  self:check_remove_back_ring_timer()
  self.back_challenge_ring_plus_timer = Timer:add_timer("pick_up_all_item_timer", PICK_UP_BACK_TIME, self.back_challenge_ring_plus, self, nil, nil, true)
end

function M:check_remove_back_ring_timer()
  if self.back_challenge_ring_plus_timer then
    Timer:remove_timer(self.back_challenge_ring_plus_timer)
    self.back_challenge_ring_plus_timer = nil
    return true
  end
end

function M:is_in_back_ring_timer()
  return self.back_challenge_ring_plus_timer ~= nil
end

function M:set_is_drop_tips_show(is_show)
  self.is_drop_tips_show = is_show
end

function M:update_card_info(card_info)
  local data = card_info.card_data
  for index, card_data in pairs(self.v_card_list) do
    if card_data.index == data.index then
      self.v_card_list[index] = data
      break
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_CARD_DATA)
end

function M:select_battle_card(card_index)
  self:tp_battle_room(card_index)
end

function M:is_battle_card(card_type)
  return nil ~= card_type and BATTLE_CARD[card_type]
end

function M:select_heal_card(card_index)
  local card_cfg_info = self:get_card_cfg_info(card_index)
  local head_id = card_cfg_info.Arg[1]
  UIMgr:get_ui("curse_blood_room"):ui_show(head_id)
end

function M:select_shop_room(select_index)
  local select_card_info = self:get_card_info(select_index)
  local select_card_cfg_info = self:get_card_cfg_info(select_index)
  assert(select_card_info.goods_list, "goods_list为空")
  UIMgr:get_ui("challenge_ring_plus_shop_room"):ui_show(select_card_info.goods_list, select_card_cfg_info.Type)
end

function M:select_rune_forge_room(select_index)
  local select_card_cfg_info = self:get_card_cfg_info(select_index)
  UIMgr:get_ui("challenge_ring_plus_rune_forge_room"):ui_show(select_card_cfg_info.Type, select_card_cfg_info.Arg[1])
end

function M:select_task_room(select_index)
  local select_card_cfg_info = self:get_card_cfg_info(select_index)
  local head_id = select_card_cfg_info.Arg[1]
  UIMgr:get_ui("curse_task_room"):ui_show(select_index, head_id)
end

function M:select_recuperation_card(select_index)
  local recuperation_card_data = self:get_recuperation_card_data()
  if not UtilTable.is_empty(recuperation_card_data) then
    self.v_last_recuperation_data = {}
    self.v_last_recuperation_data.select_index = select_index
    for key, data in pairs(recuperation_card_data.recuperation_data) do
      self:set_last_recuperation_use_count(data.id, data.use_count)
    end
    UIMgr:get_ui("curse_recuperation_room"):ui_show(select_index, recuperation_card_data)
  end
end

function M:select_event_card(select_index, by_continue)
  local event_data = self:get_card_event_data()
  if event_data and Util.is_more_than_zero(event_data.event_id) then
    UIMgr:get_ui("fate_book_event_card"):ui_show(select_index, event_data, nil, by_continue)
  else
    Log.Error("获取事件牌数据失败")
  end
end

function M:select_shop_card(select_index, by_continue)
  local shop_data = self:get_shop_data()
  if shop_data then
    UIMgr:get_ui("fate_book_shop_card"):ui_show(select_index, shop_data)
  else
    Log.Error("获取商店牌数据失败")
  end
end

function M:on_save_notify_card(data)
  self.v_save_notify_card = {}
  if not data then
    self.v_save_notify_card = {}
    return
  end
  for _, card_type in pairs(data) do
    self.v_save_notify_card[card_type] = true
  end
end

function M:request_save_notify_card(card_type)
  card_type = card_type or self:get_cur_card_cfg_info().Type
  Network:protect_call("c2gs_save_notify_card_type", {card_type = card_type}, function(ok)
    if ok then
      self.v_save_notify_card[card_type] = true
    end
  end)
end

function M:is_notify_card(card_type)
  self.v_save_notify_card = self.v_save_notify_card or {}
  return self.v_save_notify_card[card_type]
end

function M:select_door_card()
  if not self:is_door_open() then
    return
  end
  
  local function story_cb()
    if self:is_end_ring() then
      self:req_enter_door()
      return
    end
    UIMgr:get_ui("fate_book_floor"):ui_show()
  end
  
  self:check_start_or_end_ring_story(false, story_cb)
end

function M:enter_next_floor()
  self:call_floor_finished()
  local tower = TowerMgr:get_tower()
  if tower then
    tower:tp_next_floor()
  end
end

function M:call_floor_finished()
  local hero_list = SceneMgr:get_hero_list()
  local wait_hero_list = {}
  local tower = TowerMgr:get_tower()
  for uuid, hero in pairs(hero_list) do
    if uuid ~= Global.hero_uuid then
      table.insert(wait_hero_list, hero)
    end
  end
  local floor_num = self.v_cur_circle_index or 1
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_FINISHED, Global.hero, wait_hero_list[1], wait_hero_list[2], floor_num)
end

function M:is_achieve_total_limit()
  return #self.v_debuff_list >= self.v_max_curse_num
end

function M:is_can_buy(remain_value, show_tips)
  if BuffMgr:have_pay_hp_replace_curse_buff() then
    local hp_value = self:get_consume_hp_value(remain_value)
    if hp_value then
      local need_percent = -hp_value / Config.RATIO_TO_NUM
      local cur_percent
      local hero_list = SceneMgr:get_hero_list()
      for key, hero in pairs(hero_list) do
        cur_percent = (hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP) or 0) / (hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX) or 1)
        if need_percent > cur_percent then
          if show_tips then
            Util.show_message_tip(2064)
          end
          return false
        end
      end
      return true
    else
      Log.Error("获取血量消耗失败", debug.traceback())
    end
    return false
  end
  if self:is_achieve_total_limit() then
    if show_tips then
      Util.show_message_tip(2065)
    end
    return false
  end
  local sum = 0
  for index = #self.v_debuff_list + 1, #self.v_curses_library_cfg.MaxValue do
    sum = sum + self.v_curses_library_cfg.MaxValue[index] + self.v_add_curse_limit
  end
  if sum - self.v_curse_val - remain_value >= 0 then
    return true
  else
    if show_tips then
      Util.show_message_tip(2066)
    end
    return false
  end
end

function M:is_in_start_room()
  local ring_id = self:get_cur_ring_id()
  local ring_cfg = ShareRes.create("activity.rings_of_curse_ring", ring_id)
  local start_room_id = ring_cfg.StartRoomId
  local tower = TowerMgr:get_tower()
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    local room = tower:get_room()
    local room_id = room:get_room_id()
    if room_id == start_room_id then
      return true
    end
  end
  return false
end

function M:is_in_floor_start_room()
  local tower = TowerMgr:get_tower()
  if tower then
    return 0 == tower:get_room_num()
  end
  return false
end

function M:get_cur_ring_id()
  local tower = TowerMgr:get_tower()
  local tower_id = tower:get_tower_id()
  local tower_ring_cfg = ShareRes.create("activity.rings_of_curse_ring_by_tower", tower_id)
  if not tower_ring_cfg then
    Log.Error("塔环配置不存在, tower id = ", tower_id)
  end
  local ring_cfg = tower_ring_cfg[self.v_cur_circle_index or 1]
  if not ring_cfg then
    Log.Error("环配置不存在, tower id = ", tower_id)
  end
  local ring_id = ring_cfg.Id
  return ring_id
end

function M:get_cur_circle_index()
  return self.v_cur_circle_index
end

function M:is_end_ring()
  local tower = TowerMgr:get_tower()
  local tower_progress = TowerMgr:get_tower_progress()
  local max_floor
  if not tower and tower_progress then
    local tower_cfg = self.v_tower_cfg or ShareRes.create("tower.tower", tower_progress.tower_id)
    max_floor = tower_cfg.FloorMax
  else
    max_floor = tower:get_max_floor()
  end
  if max_floor then
    return self.v_cur_circle_index == max_floor
  else
    return false
  end
end

function M:get_main_cfg()
  local game_id = ActivityMgr:invoke(Act_ID, "get_game_id")
  return ShareRes.create("activity.curse_ring_main", game_id)
end

function M:get_max_treasure_box_num(index)
  return self.v_cur_ring_cfg.RewardCount[index]
end

function M:update_settlement_info(tower_info)
  if not tower_info.curse_tower_data then
    Log.Error("服务端木有下发数据")
    return
  end
  local data = tower_info.curse_tower_data
  self.v_round_cnt = data.fight_round
  self.v_fight_time = data.fight_time
  self.v_weekly_get_contribute_point = data.curse_point_data.week_get
  self.v_weekly_get_contribute_point_limit = data.curse_point_data.week_get_limit
  self.v_battle_exchange_item = tower_info.battle_exchange_item
end

function M:get_battle_exchange_item()
  return self.v_battle_exchange_item
end

function M:update_contribute_shop_buy_count(id, num)
  assert(self.v_contribute_shop_list[id], "贡献商店id相关配置不存在, id为：" .. id)
  self.v_contribute_shop_list[id].buy_cnt = self.v_contribute_shop_list[id].buy_cnt + num
end

function M:on_update_chal_ring_plus_point_data(data)
  self.v_weekly_get_contribute_point = data.point_week_get
end

function M:get_bless_group(group_id)
  local bless_group = {}
  local temp_bless_group = ShareRes.create("activity.curse_ring_bless_group")
  for _, bless_cfg in ipairs(temp_bless_group) do
    if bless_cfg.GroupID == group_id then
      table.insert(bless_group, bless_cfg)
    end
  end
  return bless_group
end

function M:get_bless_lv_cfg(bless_id, lv)
  local bless_cfg_list = ShareRes.create("activity.curse_ring_bless", bless_id)
  assert(bless_cfg_list, "bless_id相关配置不存在, id为：" .. bless_id)
  return bless_cfg_list
end

function M:get_bless_max_lv(bless_id)
  local bless_cfg_list = ShareRes.create("activity.curse_ring_bless", bless_id)
  return #bless_cfg_list
end

function M:get_battle_bless_list()
  return self.v_on_battle_bless_list
end

function M:set_quick_view_state()
  local top_ui = UIMgr:get_top_ui_by_sorting_order(curse_com_def.QUICK_FILTER_UI_MAP)
  if not top_ui then
    return
  end
  local area_visible, pause_active = false, false
  local ui_name = top_ui:ui_get_name()
  if curse_com_def.SHOW_MAIN_UI_NAME[ui_name] then
    area_visible, pause_active = true, true
  elseif curse_com_def.NOT_PUASE_SHOW_MAIN_UI_NAME[ui_name] then
    area_visible, pause_active = true, false
  end
  local order = top_ui.canvas.sortingOrder
  UIMgr:try_show_ui("fate_book_quick_view", "set_save_area_visible", area_visible, pause_active, order)
end

function M:on_show_ui()
  if Util.is_in_loading() or TowerMgr:is_on_enter_room() then
    return
  end
  self:set_quick_view_state()
end

function M:on_hide_ui(msg)
  self:set_quick_view_state()
end

function M:on_pre_tp_room()
  self.is_on_pre_tp_room = true
  self.is_on_tp_room_finish = false
end

function M:on_tp_room_finish()
  self.is_on_tp_room_finish = true
  self.is_on_pre_tp_room = false
end

function M:on_fight_end(is_win)
  self:set_is_curse_fight_state(true)
  if is_win then
    local mini_game_id = self:get_select_mini_game_id()
    if mini_game_id then
      self:on_mini_game_fight_end(mini_game_id)
    end
  end
end

function M:on_mini_game_fight_end(mini_game_id)
  local mini_game_cfg = ShareRes.get_curse_mini_game_cfg(mini_game_id)
  if not mini_game_cfg then
    Log.Error("获取小游戏配置失败", mini_game_id, debug.traceback())
    return
  end
  local task_id = mini_game_cfg.TaskId
  local task_cfg = Util.is_more_than_zero(task_id) and ShareRes.get_battle_task_cfg(task_id)
  if task_cfg then
    UIMgr:add_ui_queue_no_repeat(Config.UI_QUEUE_GROUP.Fight_Tips, "fate_book_mini_game_clear", task_id)
  end
end

function M:on_change_track_battle_task_id(msg)
  local fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    return
  end
  local task_item = BattleTaskMgr:get_track_task_item()
  if task_item then
    local mini_game_id = self:get_select_mini_game_id()
    if mini_game_id then
      local mini_game_cfg = ShareRes.get_curse_mini_game_cfg(mini_game_id)
      if not mini_game_cfg then
        Log.Error("获取小游戏配置失败", mini_game_id, debug.traceback())
        return
      end
      if task_item:get_task_id() == mini_game_cfg.TaskId then
        self.v_record_mini_game_task_item = task_item
      end
    end
  end
end

function M:on_uiqueue_empty()
  if Global.back_ring_debug then
    if not self.v_is_in_curse_fighting then
      Log.Error("返回环失败，不在环战斗中", debug.traceback())
    end
    if not SceneMgr:get_scene_item_mgr() then
      Log.Error("返回环失败，获取item管理器失败", debug.traceback())
    end
    if SceneMgr:get_scene_item_mgr():check_have_drop_point() then
      Log.Error("返回环失败，有掉落物未拾取", debug.traceback())
    end
    if not self.is_curse_fight_end then
      Log.Error("返回环失败，战斗未结束", debug.traceback())
    end
  end
  local no_drop_point = SceneMgr and SceneMgr:get_scene_item_mgr() and not SceneMgr:get_scene_item_mgr():check_have_drop_point()
  if no_drop_point and self.v_is_in_curse_fighting and self.is_curse_fight_end then
    self:back_challenge_ring_plus()
  end
end

function M:record_kill_enemy_count(id, npc_id)
  self.kill_enemy_uuids[id] = id
  if not self.kill_enemy_npc_ids[npc_id] then
    self.kill_enemy_npc_ids[npc_id] = 1
  else
    self.kill_enemy_npc_ids[npc_id] = self.kill_enemy_npc_ids[npc_id] + 1
  end
  local is_statistics_all_enemy = true
  local scene_logic_runner = SceneMgr:get_scene_logic_runner()
  local need_statistics_npc_id_map
  if scene_logic_runner and scene_logic_runner.get_need_statistics_npc_id_map then
    need_statistics_npc_id_map = scene_logic_runner:get_need_statistics_npc_id_map()
  end
  if need_statistics_npc_id_map then
    is_statistics_all_enemy = false
    if not need_statistics_npc_id_map[npc_id] then
      return
    end
  end
  local num
  if is_statistics_all_enemy then
    num = self:get_curr_kill_enemy_count()
  else
    num = self:get_kill_statistics_enemy_count(need_statistics_npc_id_map)
  end
  local msg = MsgGame:mq_publish2(Const.KILL_ENEMY_COUNT_REFRESH)
  msg.mm_x = num
  msg.mm_y = 0
end

function M:record_kill_not_monster_count(kind, uuid, npc_id)
  if not self.kill_not_monster_uuids[kind] then
    self.kill_not_monster_uuids[kind] = {}
  end
  self.kill_not_monster_uuids[kind][uuid] = uuid
  if not self.kill_not_monster_npc_ids[kind] then
    self.kill_not_monster_npc_ids[kind] = {}
  end
  if not self.kill_not_monster_npc_ids[kind][npc_id] then
    self.kill_not_monster_npc_ids[kind][npc_id] = 1
  else
    self.kill_not_monster_npc_ids[kind][npc_id] = self.kill_not_monster_npc_ids[kind][npc_id] + 1
  end
  local is_statistics_all_enemy = true
  local scene_logic_runner = SceneMgr:get_scene_logic_runner()
  local need_statistics_npc_id_map
  if scene_logic_runner and scene_logic_runner.get_need_statistics_npc_id_map then
    need_statistics_npc_id_map = scene_logic_runner:get_need_statistics_npc_id_map()
  end
  if need_statistics_npc_id_map then
    is_statistics_all_enemy = false
    if not need_statistics_npc_id_map[npc_id] then
      return
    end
  end
  local num
  if is_statistics_all_enemy then
    num = self:get_curr_kill_not_monster_count(kind)
  else
    num = self:get_kill_statistics_not_monster_count(kind, need_statistics_npc_id_map)
  end
  local msg = MsgGame:mq_publish2(Const.KILL_ENEMY_COUNT_REFRESH)
  msg.mm_x = num
  if kind == Config.CommonDefine.NPC_KIND.TRAP then
    msg.mm_y = 1
  elseif kind == Config.CommonDefine.NPC_KIND.OBSTRUCT then
    msg.mm_y = 2
  else
    msg.mm_y = 3
  end
end

function M:reset_kill_enemy_list()
  self.kill_enemy_uuids = {}
  self.kill_enemy_npc_ids = {}
end

function M:get_curr_kill_enemy_count()
  local num = 0
  for i, v in pairs(self.kill_enemy_uuids) do
    num = num + 1
  end
  return num
end

function M:get_kill_statistics_enemy_count(list)
  local num = 0
  for npc_id, _ in pairs(list) do
    if self.kill_enemy_npc_ids[npc_id] then
      num = num + self.kill_enemy_npc_ids[npc_id]
    end
  end
  return num
end

function M:get_curr_kill_count(statistics_type)
  if 0 == statistics_type then
    return self:get_curr_kill_enemy_count()
  elseif 1 == statistics_type then
    return self:get_curr_kill_not_monster_count(Config.CommonDefine.NPC_KIND.TRAP)
  elseif 2 == statistics_type then
    return self:get_curr_kill_not_monster_count(Config.CommonDefine.NPC_KIND.OBSTRUCT)
  else
    return 0
  end
end

function M:get_curr_kill_not_monster_count(kind)
  local num = 0
  if self.kill_not_monster_uuids[kind] then
    for i, v in pairs(self.kill_not_monster_uuids[kind]) do
      num = num + 1
    end
  end
  return num
end

function M:get_kill_statistics_not_monster_count(kind, list)
  local num = 0
  if self.kill_not_monster_npc_ids[kind] then
    for npc_id, _ in pairs(list) do
      if self.kill_not_monster_npc_ids[kind][npc_id] then
        num = num + self.kill_not_monster_npc_ids[kind][npc_id]
      end
    end
  end
  return num
end

function M:get_kill_enemy_count()
  return UtilTable.hash_lenth(self.kill_enemy_uuids)
end

function M:set_is_curse_fight_state(fight_end)
  self.is_curse_fight_end = fight_end
end

function M:get_is_curse_fight_state()
  return self.is_curse_fight_end
end

function M:get_is_on_pre_tp_room()
  return self.is_on_pre_tp_room or false
end

function M:get_is_on_tp_room_finish()
  return self.is_on_tp_room_finish or false
end

function M:on_scene_ready()
  UIMgr:try_hide_ui("fate_book_floor")
  local is_show = false
  if self.v_is_show_card_plus then
    UIMgr:get_ui("challenge_ring_plus"):ui_show()
    MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_PASS_RING)
    self:set_is_show_card_plus(false)
    is_show = true
  end
  local tower = TowerMgr:get_tower()
  if tower:is_pass_room() and not DropShowMgr:is_have_drop_item() and not self:check_have_ability_drop() and not self:check_have_ornament_drop() then
    is_show = true
    UIMgr:get_ui("challenge_ring_plus"):ui_show()
    self:check_select_card_type_on_first_enter()
    if TowerMgr:check_continue_tower() then
      FateBookMgr:check_curse_options_in_continue_tower()
    end
  end
  if is_show and not self.v_is_frist_enter then
    self:check_start_or_end_ring_story(true)
  end
  self.v_is_frist_enter = false
end

function M:on_scene_load_finish()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FATE_BOOK_BATTLE_START)
  end
end

function M:on_skip_card_fail_buff_effect()
  local hero_list = SceneMgr:get_hero_list()
  local is_need_show_tips = false
  local need_show_hero
  if hero_list then
    for key, hero_info in pairs(hero_list) do
      local hp = math.ceil(hero_info.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP))
      if hp <= 1 then
        is_need_show_tips = true
        need_show_hero = hero_info
        break
      end
    end
  end
  if is_need_show_tips then
    local msg = {
      mm_x = ATTR_TYPE.CHAR_HP,
      mm_y = {hero = need_show_hero}
    }
    self:on_hero_attr_change(msg)
  end
end

function M:on_hero_attr_change(msg)
  if self.v_is_in_curse_fighting then
    return
  end
  local cur_card_cfg = self:get_cur_card_cfg_info()
  local challenge_ring_plus = UIMgr:try_get_visible_ui("challenge_ring_plus")
  if challenge_ring_plus or cur_card_cfg and not BATTLE_CARD[cur_card_cfg.Type] then
    local hero_tips = UIMgr:get_ui("curse_ring_hero_tip", true)
    if not hero_tips:visible() then
      hero_tips:ui_show(true)
    else
      hero_tips:refresh_data()
    end
  end
end

function M:get_local_difficulty_key()
  return LOCAL_CHAL_RING_DIFFICULTY_LEVEL_KEY .. Global.player_uuid
end

function M:save_local_difficulty_level_data(episode_id)
  LocalStorage:save_table(self:get_local_difficulty_key(), {episode_id = episode_id})
end

function M:load_local_difficulty_level_data()
  return LocalStorage:load_table(self:get_local_difficulty_key()) or {}
end

function M:on_curse_data(msg)
  self:update_max_curse_config()
  if self.v_is_frist_enter then
    self.before_fight_curse_value = msg.curse_value or 0
    self.before_fight_debuff_list = msg.curse_debuff_list or {}
  end
  self:set_cur_select_card_index(nil)
  self:set_is_selecting_card(false)
  self.v_wait_skip_card = false
  if not self:get_is_sell_reduce_curse_orn() then
    self.v_last_total_curse = self:get_cur_total_curse()
  end
  self.v_curse_val = msg.curse_value
  self.v_cur_circle_index = msg.circle_index
  self.v_show_card_index_list = msg.card_index_list
  self.v_ornaments_list = msg.ornaments_slot
  self.v_card_list = msg.card_list
  self.v_debuff_list = msg.curse_debuff_list
  self.v_round_cnt = msg.round_cnt
  self.v_on_battle_bless_list = msg.curse_bless
  self.v_debuff_list_old = msg.curse_debuff_list
  self.v_door_status = msg.door_status
  self.v_invalid_debuff_indexs = msg.invalid_debuff_indexs
  self:set_ability_remodel_count(msg.remoduling_count)
  if msg.curse_task then
    self.v_curse_task_map = msg.curse_task
  end
  self:update_curse_val_limit()
  self:on_curse_level_change()
  self:update_jump_crad_pro()
  self:add_bless_magic()
  self:add_task_complete_magic()
  MsgGame:mq_publish2(Const.MSG_CURSE_UPDATE)
  local tower = TowerMgr:get_tower()
  local curse_tower_data = tower:get_tower_curse_tower_data()
  if curse_tower_data then
    self.v_fight_time = curse_tower_data.fight_time
  end
  self:set_cur_select_card_index(msg.card_index)
  local room_pass = tower:cur_room_is_pass()
  self:set_is_curse_fight_state(room_pass)
  if tower:get_room_num() > 0 then
    local hav_drop_point = SceneMgr and SceneMgr:get_scene_item_mgr() and SceneMgr:get_scene_item_mgr():check_have_drop_point()
    self.v_is_in_curse_fighting = hav_drop_point or not self.is_curse_fight_end or self:check_have_ability_drop() or self:check_have_ornament_drop()
  end
  for index, debuff_id in ipairs(self.v_debuff_list) do
    self:update_curse_effect(debuff_id)
  end
  if msg.sect_module then
    GenresMgr:on_update_genres_data(msg)
  end
end

function M:get_card_index_by_cur_room_num()
  local tower = TowerMgr:get_tower()
  local tower_info = tower:get_towet_info()
  local cur_room_num = tower_info.cur_room_num
  cur_room_num = cur_room_num or 0
  return cur_room_num
end

function M:on_chal_ring_plus_data(data)
  self:init_cfg()
  self.v_curse_activity_data = data
  self.v_weekly_get_contribute_point = data.point_week_get
  self.v_acty_level = data.acty_level
  self.v_challenge_red = data.challenge_red
  if data.shop_goods then
    for _, good_data in pairs(data.shop_goods) do
      self.v_contribute_shop_list[good_data.id] = good_data
    end
  end
  if data.bless_sys then
    for _, bless_data in pairs(data.bless_sys) do
      self.v_bless_list[bless_data.bless_id] = bless_data
    end
  end
  if data.bless_bag then
    for _, bless_pos_data in pairs(data.bless_bag) do
      self.v_bless_pos_list[bless_pos_data.pos_id] = bless_pos_data
    end
  end
  if data.bless_data then
    for key, bless_id in pairs(data.bless_data) do
      self.v_bless_unlock_map[bless_id] = true
    end
    self:check_bless_redpoint()
  end
  for key, curse_data in pairs(data.curse_data) do
    self.v_ring_data_map[curse_data.id] = curse_data
  end
  if data.ring_box then
    for _, box_data in pairs(data.ring_box) do
      self.v_ring_box_list[box_data.epi_id] = box_data.box_list
    end
  end
  self.v_task_is_red = data.is_red
  MsgGame:mq_publish2(Const.MSG_ON_RING_DATA_UPDATE)
end

function M:get_task_id_red()
  return self.v_task_is_red
end

function M:on_chal_ring_plus_curse_data(data)
  if self.v_last_ring_data_map == nil then
    self.v_last_ring_data_map = {}
    for _, curse_data in pairs(self.v_ring_data_map) do
      self.v_last_ring_data_map[curse_data.id] = true
    end
  end
  if data.curse_data then
    self.v_ring_data_map[data.curse_data.id] = data.curse_data
    MsgGame:mq_publish2(Const.MSG_ON_RING_DATA_UPDATE)
  end
end

function M:on_activity_curse_destiny_level(data)
  self.v_destiny_level_data = data.destiny_level
end

function M:get_real_destiny_level(ring_type)
  return self.v_destiny_level_data[ring_type] and self.v_destiny_level_data[ring_type].level or 0
end

function M:add_bless_magic()
  for bless_id, value in pairs(self.v_bless_unlock_map) do
    local bless_cfg = self:get_bless_lv_cfg(bless_id)
    if bless_cfg.MagicId > 0 then
      local hero_list = SceneMgr:get_hero_list()
      for _, hero in pairs(hero_list) do
        hero.magic_mgr:add_magic(hero, bless_cfg.MagicId)
      end
    end
  end
end

function M:on_update_curse(data)
  if not data then
    return
  end
  if not self:get_is_sell_reduce_curse_orn() then
    self.v_last_total_curse = self:get_cur_total_curse()
  end
  self.v_curse_val = data.curse_value
  self.v_invalid_debuff_indexs = data.invalid_debuff_indexs
  MsgGame:mq_publish2(Const.MSG_CURSE_UPDATE)
  local new_debuff_list = data.curse_debuff_list
  if not new_debuff_list then
    return
  elseif UtilTable.hash_lenth(new_debuff_list) <= 0 and #new_debuff_list >= #self.v_debuff_list then
    return
  end
  if not self.v_is_in_multi_buy_view then
    self.v_debuff_list_old = UtilTable.copy_table(self.v_debuff_list)
  end
  local last_debuff_list = {}
  for _, debuff_id in pairs(self.v_debuff_list) do
    last_debuff_list[debuff_id] = true
  end
  local new_id_list = {}
  for _, debuff_id in pairs(new_debuff_list) do
    if not last_debuff_list[debuff_id] then
      new_id_list[debuff_id] = true
    else
      last_debuff_list[debuff_id] = nil
    end
  end
  for debuff_id, _ in pairs(new_id_list) do
    self:update_curse_effect(debuff_id)
  end
  if #new_debuff_list >= 4 and not self.v_is_first_max_value and self.v_is_in_curse_fighting then
    self.v_is_first_max_value = nil ~= next(new_id_list)
  end
  for debuff_id, _ in pairs(last_debuff_list) do
    self:update_curse_effect(debuff_id, true)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.REMOVE_CURSE, debuff_id)
  end
  self.v_debuff_list = new_debuff_list
  self:update_curse_val_limit()
  self:on_curse_level_change()
end

function M:update_curse_effect(curse_effect_id, is_remove, remove_num)
  local curse_cfg = ShareRes.create("activity.curse_effect", curse_effect_id)
  if not curse_cfg then
    Log.Error("获取诅咒效果配置失败, id", curse_effect_id, debug.traceback())
    return
  end
  local magic_id = curse_cfg.MagicId
  local buff_id = curse_cfg.BuffId
  remove_num = remove_num or 1
  if 0 ~= magic_id then
    local hero_list = SceneMgr:get_hero_list()
    local magic_id = magic_id
    for uuid, hero in pairs(hero_list) do
      if not hero:is_die() then
        if not is_remove then
          hero.magic_mgr:add_magic(hero, magic_id)
        else
          hero.magic_mgr:remove_magic_by_id(magic_id, remove_num)
        end
      end
    end
  end
end

function M:on_remove_current_card(msg)
  self.v_remove_data = msg
  if self.v_remove_data.remove_pos then
    self:clear_drop_data_on_remove_card(self.v_remove_data.remove_pos)
  end
  if self.v_remove_data.additional_remove_pos then
    self:clear_drop_data_on_remove_card(self.v_remove_data.additional_remove_pos)
  end
  self.v_is_in_multi_buy_view = false
end

function M:get_remove_card_data()
  return self.v_remove_data
end

function M:clear_drop_data_on_remove_card(remove_pos)
  local card_index = self.v_show_card_index_list[remove_pos]
  local card_data = card_index and self.v_card_list[card_index]
  if card_data then
    self.v_card_drop_lock[card_index] = nil
    card_data.ability_drop_data = nil
    card_data.ornaments_drop_data = nil
  end
end

function M:update_remove_card()
  if self.v_remove_data then
    local remove_data = self.v_remove_data
    local add_remove_pos = remove_data.additional_remove_pos
    local remove_pos = remove_data.remove_pos
    local first_remove_pos, after_remove_pos
    if add_remove_pos then
      if add_remove_pos > remove_data.remove_pos then
        first_remove_pos = add_remove_pos
        after_remove_pos = remove_pos
      else
        first_remove_pos = remove_pos
        after_remove_pos = add_remove_pos
      end
    else
      first_remove_pos = remove_pos
    end
    table.remove(self.v_show_card_index_list, first_remove_pos)
    if after_remove_pos then
      table.remove(self.v_show_card_index_list, after_remove_pos)
    end
    self.v_round_cnt = remove_data.round_cnt
    self.v_remove_data = nil
    self:set_cur_select_card_index(nil)
    MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_CARD_REMOVE_DATA_UPDATE)
  end
end

function M:confirm_select_curse_task(card_index, task_id)
  Network:protect_call("c2gs_accept_curse_task", {card_index = card_index, task_id = task_id}, function(ok)
    if ok then
      if not self.v_curse_task_map[task_id] then
        self.v_curse_task_map[task_id] = {}
      end
      self.v_curse_task_map[task_id].id = task_id
      self.v_curse_task_map[task_id].state = CURSE_TASK_COMPLETE_TYPE.RECEIVED
      MsgGame:mq_publish2(Const.MSG_ON_CONFIRM_TASK)
      self:_set_associated_magic(task_id)
    end
  end)
end

function M:get_curse_task(task_id)
  return self.v_curse_task_map[task_id]
end

function M:get_curse_task_map()
  return self.v_curse_task_map
end

function M:get_curse_task_count()
  return UtilTable.hash_lenth(self.v_curse_task_map)
end

function M:on_update_curse_task(data)
  local task = data.task
  local old_task_comp = self:is_complete_curse_task(task.id, true)
  self.v_curse_task_map[task.id] = task
  MsgGame:mq_publish2(Const.MSG_ON_CURSE_TASK_UPDATE)
  if self:is_complete_curse_task(task.id) then
    self:_set_associated_magic(task.id, true)
    if not old_task_comp then
      local ui_tip = UIMgr:get_ui("common_battle_tips")
      local task_cfg = ShareRes.get_curse_task(task.id)
      local show_text = task_cfg.competeText
      if ui_tip:visible() then
        ui_tip:task_complete_ui_on_show(show_text)
      else
        local show_data = {task_complete_tip = show_text}
        ui_tip:ui_show(show_data)
      end
    end
  end
end

function M:on_curse_task_faild(data)
  local task_id = data.task_id
  self:_set_associated_magic(task_id, true)
  self.v_curse_task_map[task_id] = nil
  if self:is_complete_curse_task(task_id) then
    local ui_tip = UIMgr:get_ui("common_battle_tips")
    local show_text = Util.format_str("目标失败")
    if ui_tip:visible() then
      ui_tip:task_complete_ui_on_show(show_text)
    else
      local show_data = {task_complete_tip = show_text}
      ui_tip:ui_show(show_data)
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_CURSE_TASK_UPDATE)
end

function M:add_task_complete_magic()
  for task_id, curse_task in pairs(self.v_curse_task_map) do
    if curse_task.task_reward.reward_type == Award_type.GET_MAGIC and curse_task.state == CURSE_TASK_COMPLETE_TYPE.GET_AWARD then
      local hero_list = SceneMgr:get_hero_list()
      for _, hero in pairs(hero_list) do
        hero.magic_mgr:add_magic(hero, curse_task.value)
      end
    else
      local task_cfg = ShareRes.get_curse_task(task_id)
      if task_cfg.BornMagic > 0 then
        self:_set_associated_magic(task_id, false)
      end
    end
  end
end

function M:_set_associated_magic(task_id, is_remove)
  local task_cfg = ShareRes.get_curse_task(task_id)
  if task_cfg.BornMagic > 0 then
    self:_set_heros_magic(task_cfg.BornMagic, is_remove)
  end
end

function M:_set_heros_magic(magic_id, is_remove)
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  if 0 == magic_id then
    return
  end
  for _, hero in pairs(hero_list) do
    if is_remove then
      hero.magic_mgr:remove_first_magic(magic_id)
    else
      hero.magic_mgr:add_magic(hero, magic_id)
    end
  end
end

function M:is_complete_curse_task(task_id, check_complete)
  local curse_task = self:get_curse_task(task_id)
  if curse_task then
    if check_complete then
      local state = curse_task.state
      return state == CURSE_TASK_COMPLETE_TYPE.NOT_GET_AWARD or state == CURSE_TASK_COMPLETE_TYPE.GET_AWARD
    else
      return curse_task.state == CURSE_TASK_COMPLETE_TYPE.NOT_GET_AWARD
    end
  end
  return false
end

function M:check_have_curse_task_complete()
  for task_id, _ in pairs(self.v_curse_task_map) do
    if self:is_complete_curse_task(task_id) then
      return true
    end
  end
  return false
end

function M:is_orn_award(task_id)
  local curse_task = self:get_curse_task(task_id)
  if curse_task then
    return curse_task.task_reward.reward_type == Award_type.DROP_ORNAMENT
  end
  return false
end

function M:get_curse_task_award(task_id, action_type, ornaments_pos, ability_index, ornaments_index, cb)
  local temp = {
    action_type = action_type,
    ornaments_pos = ornaments_pos,
    ability_index = ability_index,
    ornaments_index = ornaments_index
  }
  local pack_args = Seri.packstring(temp)
  if self:is_complete_curse_task(task_id) then
    Network:protect_call("c2gs_get_task_reward", {task_id = task_id, pack_args = pack_args}, function(ok, resp)
      if ok then
        local curse_task = self.v_curse_task_map[task_id]
        if curse_task then
          local magic = curse_task.task_reward.reward_type == Award_type.GET_MAGIC and curse_task.task_reward.value
          if magic then
            local hero_list = SceneMgr:get_hero_list()
            for _, hero in pairs(hero_list) do
              hero.magic_mgr:add_magic(hero, magic)
            end
          end
          if resp.is_remove then
            self.v_curse_task_map[task_id] = nil
          elseif ability_index then
            local copy_data = UtilTable.copy_table(curse_task)
            copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.TASK_ABILITY_AWARD
            copy_data.uuid = copy_data.ability_drop_data.uuid
            self:drop_award_data_enqueue(copy_data)
          elseif ornaments_index then
            local copy_data = UtilTable.copy_table(curse_task)
            copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.TASK_ORNAMENT_AWARD
            copy_data.uuid = copy_data.ornaments_drop_data.uuid
            self:drop_award_data_enqueue(copy_data)
          end
        end
        if cb then
          cb(resp)
        end
        MsgGame:mq_publish2(Const.MSG_ON_GET_CURSE_TASK_AWARD)
      end
    end)
  end
end

function M:get_ring_box_award(epi_id, ring_index)
  Network:protect_call("c2gs_curse_get_ring_reward", {epi_id = epi_id, ring_index = ring_index}, function(ok)
    if ok then
      MsgGame:mq_publish2(Const.MSG_ON_RING_BOX_UPDATE)
    end
  end)
end

function M:reset_box_progress(epi_id)
  Network:protect_call("c2gs_curse_ring_epi_box_reset", {epi_id = epi_id}, function(ok)
    MsgGame:mq_publish2(Const.MSG_ON_COMPLETE_RESET)
  end)
end

function M:on_update_curse_box(data)
  if self.v_ring_box_list then
    self.v_ring_box_list[data.epi_id] = data.box_list
    MsgGame:mq_publish2(Const.MSG_ON_RESET_CURSE_BOX)
  end
end

function M:req_select_card(card_uuid)
  if self:is_selecting_card() then
    return
  end
  if self:is_in_curse_fighting() then
    return
  end
  if Util.is_more_than_zero(self:get_cur_select_card_index()) then
    return
  end
  self:set_is_selecting_card(true)
  Network:protect_call("c2gs_curse_try_select_card", {card_index = card_uuid}, function(ok, resp)
    if ok then
      self:set_cur_select_card_index(card_uuid)
      local show_idx = 1
      for idx, card_idx in pairs(self.v_show_card_index_list) do
        if card_uuid == card_idx then
          show_idx = idx
        end
      end
      local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_CARD_END)
      msg.mm_x = show_idx
    else
      self:set_is_selecting_card(false)
    end
  end)
end

function M:is_selecting_card()
  return self.v_is_selecting_card
end

function M:check_select_card_story(is_start, story_cb)
  local data = self.v_card_list[self.v_cur_select_card_index]
  if not data then
    Log.Error("获取牌数据失败， 当前牌索引", self.v_cur_select_card_index, "牌全部数据", self.v_card_list, debug.traceback())
    return
  end
  local card_id = data.id
  local cfg = self.v_card_cfg[card_id]
  local story_id = is_start and cfg.StartStoryID or cfg.EndStoryID
  if cfg and Util.is_more_than_zero(story_id) then
    if story_cb then
      StoryMgr:set_story_end_cb(story_id, story_cb)
    end
    StoryMgr:on_start(story_id)
  elseif story_cb then
    story_cb()
  end
end

function M:select_card_logic(curse_value, debuff_list)
  local function story_cb()
    local select_index = self.v_cur_select_card_index
    
    local card_cfg_info = self:get_card_cfg_info(select_index)
    local fun_name = CRAD_TYPE_FUN[card_cfg_info.Type]
    self[fun_name](self, select_index)
    self:set_is_selecting_card(false)
    if BATTLE_CARD[card_cfg_info.Type] then
      self:after_tp_battle_room()
    elseif MULTI_BUY_CARD[card_cfg_info.Type] then
      self.v_is_in_multi_buy_view = true
    end
  end
  
  self:check_select_card_story(true, story_cb)
end

function M:req_skip_card(skip_index)
  if self.v_wait_skip_card or self:is_selecting_card() then
    return
  end
  skip_index = skip_index or #self.v_show_card_index_list
  if self.v_wait_setting_rune then
    Util.show_message_tip(2045)
    return
  end
  self.v_wait_skip_card = true
  Network:protect_call("c2gs_curse_skip_card", {index = skip_index}, function(ok, resp)
    if ok then
      self.v_show_card_index_list = resp.card_index_list
      self.v_round_cnt = resp.round_cnt
      local is_skip_success = resp.success
      if is_skip_success then
        local msg = MsgGame:mq_publish2(Const.MSG_ON_SKIP_CARD_SUC)
        msg.mm_x = skip_index
      else
        local msg = MsgGame:mq_publish2(Const.MSG_ON_SKIP_CARD_FAIL)
        msg.mm_x = skip_index
      end
    end
  end)
end

function M:wait_skip_end()
  self.v_wait_skip_card = false
end

function M:is_quick_fight()
  local point_id = TowerMgr:get_cur_point_id()
  if not Util.is_more_than_zero(point_id) then
    return
  end
  local ring_id = ShareRes.get_ring_id_by_point_id(point_id)
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  return ring_cfg.IsQuickFight
end

function M:show_sellte_ui(state)
  local settle_ui
  if self:is_quick_fight() then
    settle_ui = "not_progress_battle_suc_settle"
  else
    settle_ui = "fate_book_settle"
  end
  UIMgr:get_ui(settle_ui):ui_show(state)
  self:cancle_challenge_red()
end

function M:req_enter_door()
  local is_end_ring = self:is_end_ring()
  Network:protect_call("c2gs_curse_enter_door", {}, function(ok, resp)
    if ok then
      if is_end_ring then
        Timer:add_timer("dealy_curse_ring_settlement", 0.5, function()
          self:show_sellte_ui()
        end)
        return
      end
      self:set_is_show_card_plus(true)
      self:enter_next_floor()
    end
  end)
end

function M:is_in_curse_fighting()
  if self:is_in_floor_start_room() then
    return false
  elseif not self.v_is_in_curse_fighting then
    local scene_item_mgr = SceneMgr:get_scene_item_mgr()
    if scene_item_mgr and scene_item_mgr:check_have_drop_point() then
      return true
    else
      return false
    end
  end
  return true
end

function M:can_back_ring_plus_view()
  return self.v_is_in_curse_fighting and not SceneMgr:get_scene_item_mgr():check_have_drop_point() and self.is_curse_fight_end
end

function M:req_restore_hp(cb)
  if #self.v_debuff_list >= 4 then
    return
  end
  Network:protect_call("c2gs_curse_restore_hp", {
    card_index = self.v_cur_select_card_index
  }, function(ok, resp)
    if ok then
      self.v_card_list[self.v_cur_select_card_index].restore_cnt = resp.restore_cnt
      cb()
      MsgGame:mq_publish2(Const.MSG_CURSE_UPDATE)
      MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_COURSE_PAY_SUC)
    end
  end)
end

function M:req_remove_card(cb)
  Network:protect_call("c2gs_request_remove_card", {
    card_index = self.v_cur_select_card_index
  }, function(ok, resp)
    if ok then
      if self.v_last_recuperation_data and self.v_last_recuperation_data.select_index == self.v_cur_select_card_index then
        self.v_last_recuperation_data = nil
      end
      if cb then
        cb()
      end
    end
  end)
end

function M:request_buy_contribution_shop_goods(id, num, callback)
  Network:protect_call("c2gs_curse_ring_shop_buy", {good_id = id, good_num = num}, function(ok, resp)
    if ok then
      if callback then
        callback()
      end
      self:update_contribute_shop_buy_count(id, num)
      MsgGame:mq_publish2(Const.MSG_ON_BUY_RING_CONTRI_SHOP_GOODS)
    end
  end)
end

function M:request_upgrade_bless(bless_id, callback)
  Network:protect_call("c2gs_curse_ring_up_bless_lv", {bless_id = bless_id}, function(ok, resp)
    if ok then
      local bless_list = self:get_bless_list()
      bless_list[bless_id].level = bless_list[bless_id].level + 1
      if callback then
        callback()
      end
    end
  end)
end

function M:request_equip_bless(bless_id, pos_id, callback)
  Network:protect_call("c2gs_curse_ring_cargo_bless", {bless_id = bless_id, pos_id = pos_id}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:request_discharge_bless(pos_id, callback)
  Network:protect_call("c2gs_uninstall_bless_bag", {pos_id = pos_id}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:on_update_chal_ring_plus_bless_pos_data(data)
  local pos_data = data.bless_data
  self.v_bless_pos_list[pos_data.pos_id] = pos_data
end

function M:on_update_chal_ring_plus_acty_level(data)
  self.v_acty_level = data.level
end

function M:request_purchase_rune(goods_index, is_use_curse_value, hero_uuid, pos, callback)
  if self.v_wait_setting_rune then
    Util.show_message_tip(2045)
    return
  end
  self.v_wait_setting_rune = true
  local param = {
    card_index = self.v_cur_select_card_index,
    goods_index = goods_index,
    use_curse_value = is_use_curse_value,
    hero_uuid = hero_uuid,
    pos = pos
  }
  local hero = SceneMgr:get_hero_by_uuid(hero_uuid)
  local buddy_id = hero.buddy_cfg.Id
  Network:protect_call("c2gs_curse_buy_rune", param, function(ok, resp)
    if ok then
      Rune2Mgr:set_team_change_state(TEAM_LV_CHANGE_STATE.NO_CHANGE)
      Rune2Mgr:change_buddy_rune(buddy_id, hero, pos)
      if callback then
        callback()
      end
      UIMgr:get_ui("ui_rune_set_suc"):ui_show(buddy_id)
      if is_use_curse_value then
        MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_COURSE_PAY_SUC)
      end
      MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_RUNE_CHANGE)
    end
    self.v_wait_setting_rune = nil
  end)
end

function M:request_purchase_ornament(goods_index, is_use_curse_value, ornaments_slot, callback)
  if self.v_wait_setting_ornament then
    Util.show_message_tip(2045)
    return
  end
  self.v_wait_setting_ornament = true
  local param = {
    card_index = self.v_cur_select_card_index,
    goods_index = goods_index,
    use_curse_value = is_use_curse_value,
    ornaments_slot = ornaments_slot
  }
  local card_info = self:get_cur_card_info()
  Network:protect_call("c2gs_curse_buy_ornaments", param, function(ok, resp)
    if ok then
      self.v_ornaments_list[ornaments_slot] = card_info.goods_list[goods_index].id
      if callback then
        callback()
      end
      if is_use_curse_value then
        MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_COURSE_PAY_SUC)
      end
    end
    self.v_wait_setting_ornament = nil
  end)
end

function M:request_rune_forge_upgrade(hero_uuid, is_use_curse_value, callback)
  if self.v_wait_setting_rune_forge_upgrade then
    Util.show_message_tip(2045)
    return
  end
  self.v_wait_setting_rune_forge_upgrade = true
  local param = {
    card_index = self.v_cur_select_card_index,
    hero_uuid = hero_uuid,
    use_curse_value = is_use_curse_value
  }
  Network:protect_call("c2gs_curse_forge_upgrade", param, function(ok, resp)
    if ok then
      local hero = SceneMgr:get_hero_by_uuid(hero_uuid)
      Rune2Mgr:refresh_buddy_rune(hero)
      if callback then
        callback()
      end
      if is_use_curse_value then
        MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_COURSE_PAY_SUC)
      end
    end
    self.v_wait_setting_rune_forge_upgrade = nil
  end)
end

function M:request_rune_forge_entry(hero_uuid, is_use_curse_value, callback)
  if self.v_wait_setting_rune_forge_entry then
    Util.show_message_tip(2045)
    return
  end
  self.v_wait_setting_rune_forge_entry = true
  local param = {
    card_index = self.v_cur_select_card_index,
    hero_uuid = hero_uuid,
    use_curse_value = is_use_curse_value
  }
  Network:protect_call("c2gs_curse_forge_entry", param, function(ok, resp)
    if ok then
      local hero = SceneMgr:get_hero_by_uuid(hero_uuid)
      Rune2Mgr:refresh_buddy_rune(hero)
      if callback then
        callback()
      end
      if is_use_curse_value then
        MsgGame:mq_publish2(Const.MSG_ON_CURSE_RING_COURSE_PAY_SUC)
      end
    end
    self.v_wait_setting_rune_forge_entry = nil
  end)
end

function M:req_pickup_ornaments(ornament_info)
  local req_info = {}
  req_info.uuid = ornament_info.uuid
  req_info.ornaments_slot = ornament_info.ornaments_slot
  req_info.is_sell = ornament_info.is_sell
  Network:protect_call("c2gs_curse_pickup_ornaments", req_info, function(ok, resp)
    if ok and not req_info.is_sell then
      self.v_ornaments_list[req_info.ornaments_slot] = ornament_info.item_id
    end
  end)
end

function M:req_report_curse_info(curse_info)
  if not self.v_is_in_curse_fighting then
    return
  end
  Network:protect_call("c2gs_report_fight_add_curse", curse_info, function(ok, resp)
    if ok then
      if self.is_have_reduce_curse_val_buff then
        self:record_fight_add_curse_value(ADD_CURSE_TYPE.KILL_ENEMY, self:get_kill_enemy_reduce_curse_value())
      end
      local card_info = self:get_cur_card_cfg_info()
      if card_info then
        if self.is_have_add_kill_boss_buff and card_info.Type == CURSE_CARD_TYPE.DOOR then
          self:record_fight_add_curse_value(ADD_CURSE_TYPE.KILL_BOSS, self.kill_boss_add_curse)
        end
      elseif self.v_remove_data and self.v_remove_data.boss_index and self.is_have_add_kill_boss_buff then
        self:record_fight_add_curse_value(ADD_CURSE_TYPE.KILL_BOSS, self.kill_boss_add_curse)
      end
      self:record_fight_add_curse_value(ADD_CURSE_TYPE.FIGHT_END, curse_info.add_curse_val)
    end
  end)
end

function M:get_last_total_curse()
  return self.v_last_total_curse
end

function M:get_cur_total_curse()
  local cur_curse_val = self:is_achieve_total_limit() and 0 or self.v_curse_val or 0
  return cur_curse_val + self:debuff_convert_curse(self.v_debuff_list)
end

function M:debuff_convert_curse(debuff_list)
  local total_curse_value = 0
  if debuff_list then
    local count = #debuff_list
    count = count > #self.v_curses_library_cfg.MaxValue and #self.v_curses_library_cfg.MaxValue or count
    for index = 1, count do
      total_curse_value = total_curse_value + self.v_curses_library_cfg.MaxValue[index] + self.v_add_curse_limit
    end
  end
  return total_curse_value
end

function M:get_max_curse_value()
  local value = 0
  for key, v in pairs(self.v_curses_library_cfg.MaxValue) do
    value = v + value + self.v_add_curse_limit
  end
  return value
end

function M:get_is_first_max_value()
  return self.v_is_first_max_value
end

function M:set_is_first_max_value(v)
  self.v_is_first_max_value = v
end

function M:get_is_sell_reduce_curse_orn()
  return self.v_is_sell_reduce_curse_orn
end

function M:set_is_sell_reduce_curse_orn(v)
  self.v_is_sell_reduce_curse_orn = v
end

function M:record_before_fight_view_info(curse_value, debuff_list)
  self.before_fight_curse_value = curse_value or self.v_curse_val
  if debuff_list then
    self.before_fight_debuff_list = debuff_list
  end
end

function M:get_before_fight_curse_value()
  return self.before_fight_curse_value
end

function M:get_before_fight_debuff_list()
  return self.before_fight_debuff_list
end

function M:record_fight_add_curse_value(key, value)
  if key == ADD_CURSE_TYPE.SELECT_CARD then
    self.fight_add_curse_list[key] = value
  else
    self.fight_add_curse_list[key] = (self.fight_add_curse_list[key] or 0) + value
  end
end

function M:get_fight_add_curse_value()
  local last_debuff_value = self:debuff_convert_curse(self.before_fight_debuff_list)
  local last_total_curse
  local add_curse_value = 0
  for _, key in ipairs(ADD_CURSE_ORDER) do
    if self.fight_add_curse_list[key] then
      add_curse_value = add_curse_value + self.fight_add_curse_list[key]
    end
  end
  local curse_total_curse
  if #self.before_fight_debuff_list >= 4 then
    last_total_curse = last_debuff_value + self.before_fight_curse_value
    curse_total_curse = last_total_curse + add_curse_value
  else
    local max_curse_value = self:get_max_curse_value()
    last_total_curse = math.min(last_debuff_value + self.before_fight_curse_value, max_curse_value)
    curse_total_curse = math.min(max_curse_value, last_total_curse + add_curse_value)
  end
  return curse_total_curse - last_total_curse
end

function M:reset_fight_add_curse_value(key)
  if key then
    self.fight_add_curse_list[key] = nil
  else
    self.fight_add_curse_list = {}
  end
end

function M:record_sell_orn_curse_value(value)
  self.sell_orn_curse_value = self.sell_orn_curse_value + value
end

function M:get_sell_orn_curse_value()
  return self.sell_orn_curse_value
end

function M:reset_sell_orn_curse_value()
  self.sell_orn_curse_value = 0
end

function M:set_have_reduce_curse_val_buff(is_have, mulit)
  self.is_have_reduce_curse_val_buff = is_have
  self.reduce_curse_mulit = mulit
end

function M:set_have_add_kill_boss_buff(is_have, value)
  self.is_have_add_kill_boss_buff = is_have
  self.kill_boss_add_curse = value
end

function M:get_kill_enemy_reduce_curse_value()
  return self:get_kill_enemy_count() * self.reduce_curse_mulit
end

function M:set_skip_card_add_curse_value(value)
  self.skip_card_add_curse_value = value
end

function M:get_skip_card_add_curse_value()
  return self.skip_card_add_curse_value
end

function M:set_is_not_use_curse_buy(b)
  self.is_not_use_curse_buy = b
end

function M:get_is_not_use_curse_buy()
  return self.is_not_use_curse_buy
end

function M:_effect_level_change_magic(is_add)
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    if not hero:is_destroy() then
      if is_add then
        hero.magic_mgr:add_magic(hero, self.v_curse_level_change_param.magic_id)
      else
        hero.magic_mgr:remove_magic_by_id(self.v_curse_level_change_param.magic_id)
      end
    end
  end
  self.v_level_change_magic_effect = is_add
end

function M:on_curse_level_change()
  if self.v_curse_level_change_param then
    local cur_lv = self.v_debuff_list and #self.v_debuff_list or 0
    local param = self.v_curse_level_change_param
    if 0 == param.comparison_type then
      if cur_lv <= param.trigger_level then
        self:_effect_level_change_magic(true)
      elseif self.v_level_change_magic_effect then
        self:_effect_level_change_magic(false)
      end
    elseif 1 == param.comparison_type then
      if cur_lv >= param.trigger_level then
        self:_effect_level_change_magic(true)
      elseif self.v_level_change_magic_effect then
        self:_effect_level_change_magic(false)
      end
    end
  end
end

function M:set_curse_level_change_param(param)
  self.v_curse_level_change_param = param
  self:on_curse_level_change()
end

function M:remove_curse_level_change()
  if self.v_curse_level_change_param then
    self:_effect_level_change_magic(false)
    self.v_curse_level_change_param = nil
    self.v_level_change_magic_effect = false
  end
end

function M:check_have_ornament_drop()
  local fight_type = TowerMgr:get_fight_type()
  if CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE == fight_type then
    local card_info = self.v_card_list[self.v_cur_select_card_index]
    local drop_data = card_info and card_info.ornaments_drop_data
    if drop_data and not UtilTable.is_empty(drop_data.choose_ornamets) and not drop_data.is_finish then
      return true
    end
  end
  return false
end

function M:check_have_ability_drop()
  local fight_type = TowerMgr:get_fight_type()
  if CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE == fight_type then
    local card_info = self.v_card_list[self.v_cur_select_card_index]
    local drop_data = card_info and card_info.ability_drop_data
    if drop_data and not UtilTable.is_empty(drop_data.ability_drop) then
      return true
    end
  end
  return false
end

function M:check_drop_func(delay_time)
  if self.v_card_drop_lock[self.v_cur_select_card_index] then
    return true
  end
  local have_dorp = false
  if self:check_have_ability_drop() then
    local card_info = self.v_card_list[self.v_cur_select_card_index]
    local copy_data = {
      ability_drop_data = UtilTable.copy_table(card_info.ability_drop_data),
      data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.ABILITY,
      uuid = card_info.ability_drop_data.uuid
    }
    self:drop_award_data_enqueue(copy_data)
    have_dorp = true
  end
  if self:check_have_ornament_drop() then
    local card_info = self.v_card_list[self.v_cur_select_card_index]
    local copy_data = {
      ornaments_drop_data = UtilTable.copy_table(card_info.ornaments_drop_data),
      data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.MINI_GAME_ORNAMENT,
      uuid = card_info.ornaments_drop_data.uuid
    }
    self:drop_award_data_enqueue(copy_data)
    have_dorp = true
  end
  if have_dorp then
    self.v_card_drop_lock[self.v_cur_select_card_index] = true
    self:try_choose_drop_award(delay_time)
  end
  return have_dorp
end

function M:get_ability_drop()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.ability_drop_data
  end
end

function M:get_ability_refresh_cnt()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.ability_drop_data.ability_refresh_cnt
  end
end

function M:get_recuperation_card_data()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.recuperation_data
  end
end

function M:get_card_event_data()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.event_data
  end
end

function M:get_shop_data()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.new_shop_data
  end
end

function M:get_single_recuperation_data(recuperation_id)
  local recuperation_data = self:get_recuperation_card_data()
  if recuperation_data then
    return recuperation_data[recuperation_id]
  end
end

function M:get_ability_discount_refresh()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.ability_drop_data.discount_refresh
  end
end

function M:get_ability_discount_value()
  local card_data = self:get_cur_card_info()
  if card_data then
    return card_data.ability_drop_data.discount_value
  end
end

function M:update_card_ability_drop_data(data)
  local card_data = self:get_cur_card_info()
  if card_data then
    card_data.ability_drop_data = data.ability_drop_data
  end
  return card_data
end

function M:on_update_recuperation_data(card_info)
  self:update_card_info(card_info)
end

function M:add_recuperation_magic(magic_id, magic_level)
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    if not Util.is_destroy(hero) then
      hero.magic_mgr:add_magic(hero, magic_id, nil, nil, magic_level)
    end
  end
end

function M:set_recuperation_updagrade_ability(ability_id)
  self.v_recuperation_updagrade_ability = ability_id
end

function M:get_recuperation_updagrade_ability()
  return self.v_recuperation_updagrade_ability
end

function M:request_use_recuperation_func(recuperation_id, arg, use_curse_value, cb)
  Network:protect_call("c2gs_use_recuperation_func", {
    card_index = self.v_cur_select_card_index,
    recuperation_id = recuperation_id,
    arg = arg,
    use_curse_value = use_curse_value
  }, function(ok, resp)
    if cb then
      cb(resp, ok)
    end
  end)
end

function M:on_update_curse_door_status(data)
  if self.v_door_status ~= data.door_status then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_RING_DOOR_STATE_UPDATE)
    msg.mm_x = data.door_status
  end
  self.v_door_status = data.door_status
end

function M:is_door_open()
  return self.v_door_status
end

function M:check_select_card_type_on_first_enter()
  local card_cfg = self:get_cur_card_cfg_info()
  if card_cfg then
    if card_cfg.Type == CURSE_CARD_TYPE.RECUPERATION then
      self:select_recuperation_card(self.v_cur_select_card_index)
    elseif card_cfg.Type == CURSE_CARD_TYPE.EVENT then
      self:select_event_card(self.v_cur_select_card_index, true)
    elseif card_cfg.Type == CURSE_CARD_TYPE.NEW_SHOP then
      self:select_shop_card(self.v_cur_select_card_index, true)
    elseif card_cfg.Type == CURSE_CARD_TYPE.TASK then
      self:select_task_room(self.v_cur_select_card_index, true)
    end
  end
end

function M:get_consume_hp_value(curse)
  local magic_lv = ShareRes.get_curse_to_magic_level(curse)
  if magic_lv then
    local buff = BuffMgr:get_pay_hp_replace_curse_buff()
    local buff_cfg = buff.buff_cfg
    if buff_cfg.Arg[1] and buff_cfg.Arg[1] > 0 then
      local magic_cfg = ShareRes.get_magic_cfg(buff_cfg.Arg[1])
      if magic_cfg and magic_cfg.logic and magic_cfg.logic[2] then
        return magic_cfg.logic[2][magic_lv]
      else
        Log.Error("获取血量抵扣buff数值失败，请检查magic：%s, buff:%s, 配置", buff_cfg.Arg[1], buff_cfg.Id)
      end
    end
  end
end

function M:check_can_pay_recuperation_card(pay_type, cfg, show_tips)
  if pay_type == Config.PAY_COSE_TYPE.FREE then
    return true
  elseif pay_type == Config.PAY_COSE_TYPE.USE_ITEM then
    if cfg and cfg.CostItem and cfg.CostItem > 0 and cfg.CostCount and cfg.CostCount > 0 then
      local final_cost = self:get_after_discount_price(cfg.CostCount)
      if final_cost > BagMgr:get_item_num(cfg.CostItem) then
        if show_tips then
          Util.show_message_tip(2314, UtilUI.get_item_name(cfg.CostItem))
        end
        return
      end
    end
  elseif pay_type == Config.PAY_COSE_TYPE.USE_CUESE and cfg.CurseValue and cfg.CurseValue > 0 then
    local need_curse = self:get_after_discount_curse_price(cfg.CurseValue)
    if not self:is_can_buy(need_curse, show_tips) then
      return
    end
  end
  return true
end

function M:check_need_push_update_queue(data)
  if TowerMgr:get_fight_type() ~= CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    return
  end
  if ChallengeRingPlusMgr:is_quick_fight() and curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ABILITY ~= data.award_type then
    return
  end
  local ui_name = "curse_get_award_tips"
  local choose_ability_view = UIMgr:try_get_visible_ui("choose_ability_view")
  if choose_ability_view then
    local data_type = choose_ability_view:get_award_type()
    if data.award_type % 2 == data_type % 2 then
      return
    end
  end
  self:enqueue_update_data(data)
  if UIMgr.ui_queue_mgr:get_showing_ui_name() ~= ui_name then
    UIMgr:add_ui_queue_no_repeat(Config.UI_QUEUE_GROUP.Fight_Tips, ui_name)
  end
end

function M:enqueue_update_data(data)
  table.insert(self.v_update_data_queue, data)
end

function M:dequeue_update_data()
  local data = self.v_update_data_queue[1]
  if data then
    table.remove(self.v_update_data_queue, 1)
  end
  return data
end

function M:check_start_or_end_ring_story(is_start, story_cb)
  local circle_index = self:get_cur_circle_index()
  local ring_id = self:get_cur_ring_id(circle_index)
  local ring_cfg = ShareRes.create("activity.rings_of_curse_ring")[ring_id]
  if ring_cfg then
    local story_id
    if is_start then
      story_id = ring_cfg.StartStoryID
    else
      story_id = ring_cfg.EndStoryID
    end
    if Util.is_more_than_zero(story_id) then
      if story_cb then
        StoryMgr:set_story_end_cb(ring_cfg.EndStoryID, story_cb)
      end
      StoryMgr:on_start(ring_cfg.EndStoryID)
      return true
    elseif story_cb then
      story_cb()
    end
  end
end

function M:check_bless_is_unlock(bless_id)
  return self.v_bless_unlock_map[bless_id]
end

function M:check_skill_item_is_active(bless_id)
  if self:check_bless_is_unlock(bless_id) then
    return false
  end
  local cfg = ShareRes.get_curse_ring_bless_cfg(bless_id)
  local pre_bless_id_list = cfg.PreBlessId
  if pre_bless_id_list and next(pre_bless_id_list) then
    for key, pre_bless_id in pairs(pre_bless_id_list) do
      if not self:check_bless_is_unlock(pre_bless_id) then
        return false
      end
    end
    return true
  else
    return true
  end
end

function M:check_skill_item_is_can_unlock(bless_id)
  return not self:check_bless_is_unlock(bless_id) and self:check_skill_item_is_active(bless_id)
end

function M:get_bless_unlock_map()
  return self.v_bless_unlock_map
end

function M:get_bless_unlock_count()
  return UtilTable.hash_lenth(self.v_bless_unlock_map)
end

function M:check_bless_redpoint()
  local all_bless_cfg = ShareRes.get_curse_ring_bless_all_cfg()
  local need_red = false
  for key, cfg in pairs(all_bless_cfg) do
    if not self.v_bless_unlock_map[cfg.Id] and self:check_skill_item_is_active(cfg.Id) and (not Util.is_more_than_zero(cfg.CostItem) or BagMgr:get_item_num(cfg.CostItem) >= cfg.CostCnt) then
      need_red = true
      break
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CURSE_SKILL_TREE_ENTER, need_red)
end

function M:check_group_is_red(group_id)
  if not self:check_ring_group_is_unlock(group_id, false) then
    return false
  end
  local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
  for key, config_id in pairs(config_ids) do
    if self:check_ring_is_red(config_id) then
      return true
    end
  end
  return false
end

function M:check_ring_is_red(ring_id)
  if not self.v_last_ring_data_map then
    return false
  end
  local is_red = self.v_last_ring_data_map[ring_id] == nil
  if is_red then
    self.v_last_ring_data_map[ring_id] = true
  end
  return is_red
end

function M:update_max_curse_config()
  local fight_info = TowerMgr:get_fight_info()
  local point_id = fight_info and fight_info.point_id
  if not point_id then
    Log.Error("获取章节数据失败")
    return
  end
  local all_ring_config = ShareRes.get_curse_ring_config()
  for key, ring_config in pairs(all_ring_config) do
    if ring_config.EpisodeId == point_id then
      self.v_cur_ring_cfg = ring_config
      break
    end
  end
  if not self.v_cur_ring_cfg then
    return
  end
  self.v_curses_library_cfg = ShareRes.create("activity/curse_group", self.v_cur_ring_cfg.CurseGroup)
  self.v_jump_card_pro = self.v_cur_ring_cfg.SkipWeight / 100
  self.v_weekly_get_contribute_point_limit = self.v_cur_ring_cfg.WeekVal
  self.v_max_curse_num = #self.v_curses_library_cfg.MaxValue
end

function M:check_ring_is_pass(ring_id)
  local cfg = ShareRes.get_curse_ring_config(ring_id)
  if cfg then
    return self:_check_ring_is_pass(cfg)
  else
    Log.Error("获取环配置失败，id:", ring_id)
  end
end

function M:_check_ring_is_pass(cfg)
  local data = self.v_ring_data_map[cfg.Id]
  if data then
    local point_cfg = ShareRes.get_chapter_point_cfg(cfg.EpisodeId)
    if point_cfg then
      local tower_id = point_cfg.FightId
      local history_floor = TowerMgr:get_tower_history_floor_num(tower_id)
      local max_floor = ShareRes.get_curse_max_floor_num(tower_id)
      return history_floor >= max_floor
    else
      Log.Error("获取环关卡配置失败，环ID:", cfg.Id)
      return false
    end
  end
  return false
end

function M:get_ring_data(ring_id)
  local data = self.v_ring_data_map[ring_id]
  return data
end

function M:get_ring_destiny_level(ring_id, progress)
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  local group_cfg = ShareRes.get_curse_ring_group_cfg(ring_cfg.OwningGroup)
  local destiny_level = self:get_real_destiny_level(group_cfg.Type)
  if progress then
    local all_cfg = ShareRes.get_curse_destiny_level_cfg()
    local cur_floor_id = progress.floor_id
    for floor_id, cfg in pairs(all_cfg) do
      if floor_id <= cur_floor_id then
        destiny_level = destiny_level + cfg.Grade
      end
    end
  end
  return destiny_level
end

function M:check_ring_is_in_time(config_id, show_tips)
  local ring_cfg = ShareRes.get_curse_ring_config(config_id)
  if ring_cfg.StartTime and Date.server_time() < Date.get_time_stamp_by_scheme_id(ring_cfg.StartTime) then
    if show_tips then
      Util.show_message_tip("不在活动时间内")
    end
    return false
  end
  if ring_cfg.EndTime and Date.server_time() >= Date.get_time_stamp_by_scheme_id(ring_cfg.EndTime) then
    if show_tips then
      Util.show_message_tip("不在活动时间内")
    end
    return false
  end
  return true
end

function M:check_ring_group_is_in_time(group_id, show_tips)
  local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
  if not group_id then
    Log.Error("通过组ID获取环ID组失败, 组ID：", group_id, debug.traceback())
    return
  end
  for key, config_id in pairs(config_ids) do
    if self:check_ring_is_in_time(config_id, show_tips) then
      return true
    end
  end
  return false
end

function M:check_ring_group_is_unlock(group_id, show_tips)
  local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
  for key, config_id in pairs(config_ids) do
    if self:check_ring_is_unlock(config_id, show_tips) then
      return true
    end
  end
  return false
end

function M:check_ring_is_unlock(config_id, show_tips)
  local in_time = self:check_ring_is_in_time(config_id, show_tips)
  if not in_time then
    return false
  end
  local ring_cfg = ShareRes.get_curse_ring_config(config_id)
  local point_id = ring_cfg.EpisodeId
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local group_cfg = ShareRes.get_curse_ring_group_cfg(ring_cfg.OwningGroup)
  if group_cfg.Type ~= Config.FATE_POINT_TYPE.STORY then
    local front_point_id = point_cfg.FrontPointId
    if Util.is_more_than_zero(front_point_id) then
      local front_config_id = ShareRes.get_ring_id_by_point_id(front_point_id)
      if front_config_id then
        local complete = self:check_ring_is_pass(front_config_id)
        if not complete then
          if show_tips then
            Util.show_message_tip(2067)
          end
          return false
        end
      end
    end
  end
  return ring_cfg.Condition == nil or 0 == Condition:check_condition_list(ring_cfg.Condition, show_tips)
end

function M:check_group_has_ring_open(group_id)
  local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
  for _, config_id in pairs(config_ids) do
    local ring_cfg = ShareRes.get_curse_ring_config(config_id)
    if not ring_cfg.StartTime or Date.server_time() >= Date.get_time_stamp_by_scheme_id(ring_cfg.StartTime) then
      return true
    end
    if not ring_cfg.EndTime or Date.server_time() < Date.get_time_stamp_by_scheme_id(ring_cfg.EndTime) then
      return true
    end
  end
  return false
end

function M:check_current_card_have_event_data()
  local event_data = self:get_card_event_data()
  return nil ~= event_data and event_data.event_id > 0
end

function M:after_tp_battle_room()
  self.v_is_in_curse_fighting = true
  self:set_is_curse_fight_state(false)
  self.kill_enemy_uuids = {}
  Global.hero.skill_mgr:abort(Config.SKILL_ABORT_TYPE.BREAK_ABORT)
end

function M:tp_battle_room(room_num)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:cr_tp_room(room_num)
    local fight_ui = UIMgr:try_get_ui("fight")
    if fight_ui then
      fight_ui:set_hp_visible(true)
    end
  end
end

function M:select_battle_option(room_num)
  self:tp_battle_room(room_num)
  self:after_tp_battle_room()
  self.v_is_select_battle_option = true
end

function M:get_last_recuperation_use_count(recuperation_id)
  return self.v_last_recuperation_data and self.v_last_recuperation_data[recuperation_id] or 0
end

function M:set_last_recuperation_use_count(recuperation_id, count)
  self.v_last_recuperation_data[recuperation_id] = count
end

function M:set_is_selecting_card(is_selecting)
  self.v_is_selecting_card = is_selecting
end

function M:set_cur_select_card_index(card_index)
  self.v_cur_select_card_index = card_index
end

function M:get_cur_select_card_index()
  return self.v_cur_select_card_index
end

function M:set_select_mini_game_id(mini_game_id)
  self.v_select_mini_game_id = mini_game_id
end

function M:get_select_mini_game_id()
  local cur_card_cfg = self:get_cur_card_cfg_info()
  local card_data = self:get_cur_card_info()
  if cur_card_cfg and card_data then
    if cur_card_cfg.Type == CURSE_CARD_TYPE.MINI_GAME then
      return card_data.mini_game_id
    elseif cur_card_cfg.Type == CURSE_CARD_TYPE.EVENT then
      return self.v_select_mini_game_id
    end
  end
end

function M:replace_award_data_on_queue(data)
  if not data.uuid then
    return
  end
  local len = #self.v_drop_award_data_queue
  local comp_data
  for i = len, 1, -1 do
    comp_data = self.v_drop_award_data_queue[i]
    if data.uuid == comp_data.uuid then
      self.v_drop_award_data_queue[i] = data
      break
    end
  end
end

function M:remove_award_data_on_queue(uuid)
  if not uuid then
    return
  end
  local len = #self.v_drop_award_data_queue
  local comp_data
  for i = len, 1, -1 do
    comp_data = self.v_drop_award_data_queue[i]
    if uuid == comp_data.uuid then
      table.remove(self.v_drop_award_data_queue, i)
    end
  end
end

function M:drop_award_data_enqueue(data)
  self.v_drop_award_data_queue = self.v_drop_award_data_queue or {}
  local len = #self.v_drop_award_data_queue
  if data.uuid then
    local comp_data
    for i = len, 1, -1 do
      comp_data = self.v_drop_award_data_queue[i]
      if data.uuid == comp_data.uuid then
        return
      end
    end
  end
  self.v_drop_award_data_queue[len + 1] = data
end

function M:drop_award_data_dequeue()
  local data = self.v_drop_award_data_queue[1]
  if data and not data.uuid then
    table.remove(self.v_drop_award_data_queue, 1)
  end
  if self.v_cur_select_card_index then
    self.v_card_drop_lock[self.v_cur_select_card_index] = nil
  end
  return data
end

function M:try_choose_drop_award(delay_time)
  local data = self.v_drop_award_data_queue[1]
  if data then
    local ui_name = "choose_ability_view"
    local choose_ability_view = UIMgr:try_get_loaded_ui(ui_name)
    if choose_ability_view and choose_ability_view:visible() then
      if choose_ability_view:is_in_hide_timer() then
        choose_ability_view:stop_hiding_and_restore()
      end
    else
      if UIMgr.ui_queue_mgr:get_showing_ui_name() ~= ui_name then
        UIMgr:add_ui_queue_no_repeat(Config.UI_QUEUE_GROUP.Fight_Tips, ui_name)
      end
      if delay_time then
        UIMgr.ui_queue_mgr:set_open_lock_state(true, math.huge)
        Timer:add_timer(nil, delay_time, function()
          UIMgr.ui_queue_mgr:set_open_lock_state(false, 0)
        end, nil, nil, nil, true)
      end
    end
  end
end

function M:get_record_mini_game_task_item()
  return self.v_record_mini_game_task_item
end

function M:set_choose_recuperation_id(recuperation_id)
  self.v_choose_recuperation_id = recuperation_id
end

function M:get_choose_recuperation_id()
  return self.v_choose_recuperation_id
end

function M:check_option_condition(option_id)
  local option_cfg = ShareRes.get_curse_event_option_cfg(option_id)
  if not option_cfg then
    return false
  end
  local pass = true
  local CURSE_EVENT_OPTION_CONDITION_TYPE = CommonDef.CURSE_EVENT_OPTION_CONDITION_TYPE
  if option_cfg.ConditionType == CURSE_EVENT_OPTION_CONDITION_TYPE.ITEM_NUM then
    local item_id = option_cfg.Arg[1]
    local count = option_cfg.Arg[2]
    pass = Util.check_item_cost_enough(item_id, count)
  elseif option_cfg.ConditionType == CURSE_EVENT_OPTION_CONDITION_TYPE.SECT_ABILITY_QUALITY_NUM then
    local genres_id = option_cfg.Arg[1]
    local quality = option_cfg.Arg[2]
    local count = option_cfg.Arg[3]
    pass = GenresMgr:get_ability_count_by_param(genres_id, quality, count)
  elseif option_cfg.ConditionType == CURSE_EVENT_OPTION_CONDITION_TYPE.ORNAMENT_NUM then
    local count = option_cfg.Arg[1]
    pass = count <= BattleOrnamentMgr:get_ornament_count()
  elseif option_cfg.ConditionType == CURSE_EVENT_OPTION_CONDITION_TYPE.ORNAMENT_ID then
    local ornament_id = option_cfg.Arg[1]
    pass = BattleOrnamentMgr:is_have_same_ornament(ornament_id)
  end
  if not pass then
    Util.show_message_tip(option_cfg.NotPassConditionDesc)
  end
  return pass
end

function M:request_unlock_bless(bless_id, cb)
  Network:protect_call("c2gs_curse_ring_unlock", {bless_id = bless_id}, function(ok)
    if ok then
      self.v_bless_unlock_map[bless_id] = true
      self:check_bless_redpoint()
      if cb then
        cb()
      end
    end
  end)
end

function M:request_select_event_option(card_index, option_idx, cb)
  local card_data = self:get_card_info(card_index)
  local option_room = card_data.event_data and card_data.event_data.option_room
  local mini_game_id = option_room and option_room[option_idx] and option_room[option_idx].mini_game_id
  self:set_select_mini_game_id(mini_game_id)
  Network:protect_call("c2gs_select_event_option", {card_index = card_index, option_idx = option_idx}, function(ok, resp)
    if cb then
      cb(ok, resp)
    end
  end)
end

function M:request_curse_buy_shop_good(card_index, slot_index, cb)
  if not card_index or not slot_index then
    return
  end
  local proto_name = "c2gs_curse_buy_shop_good"
  ScreenMaskMgr:open_one_tag(proto_name)
  Network:protect_call(proto_name, {card_index = card_index, slot_index = slot_index}, function(ok)
    ScreenMaskMgr:close_one_tag(proto_name)
    if ok and cb then
      cb()
    end
  end)
end

function M:request_curse_refresh_shop_good(card_index, cb)
  if not card_index then
    return
  end
  local proto_name = "c2gs_curse_refresh_shop_good"
  Network:protect_call(proto_name, {card_index = card_index}, function(ok)
    if ok and cb then
      cb()
    end
  end)
end

function M:request_curse_recuperation_next_step(card_index, cb)
  if not card_index then
    return
  end
  local proto_name = "c2gs_curse_recuperation_next_step"
  Network:protect_call(proto_name, {card_index = card_index}, function(ok)
    if ok and cb then
      cb()
    end
  end)
end

function M:request_get_curse_destiny_level_award(point_id, grade, cb)
  local proto_name = "c2gs_get_curse_desnity_level_award"
  Network:protect_call(proto_name, {curse_episode = point_id, grade = grade}, function(ok)
    if ok and cb then
      cb()
    end
  end)
end

function M:request_activity_curse_clicked_red(cb)
  local proto_name = "c2gs_activity_curse_clicked_red"
  Network:protect_call(proto_name, {}, function(ok)
    if ok then
      self.v_task_is_red = false
      if cb then
        cb()
      end
    end
  end)
end

function M:set_is_show_card_plus(is_show)
  self.v_is_show_card_plus = is_show
end

function M:get_invalid_debuff_indexs()
  return self.v_invalid_debuff_indexs
end

function M:back_ring_debug()
  Log.Error("queue_is_empty", UIMgr.ui_queue_mgr:check_cur_scene_queue_is_empty(), "have_ability_drop", self:check_have_ability_drop(), "ornament_drop", self:check_have_ornament_drop(), "in_floor_start_room", self:is_in_floor_start_room())
end

function M:set_ability_remodel_count(count)
  self.v_ability_remodel_count = count
end

function M:get_ability_remodel_count()
  return self.v_ability_remodel_count or 0
end

function M:get_challenge_red()
  return self.v_challenge_red
end

function M:cancle_challenge_red()
  self.v_challenge_red = false
end

function M:get_destiny_drop_index(ring_id, ignore_end_check)
  if self.v_curse_activity_data and self.v_curse_activity_data.curse_drop_datas then
    local data = self.v_curse_activity_data.curse_drop_datas
    local drop_index = data[ring_id] and data[ring_id].drop_index
    if not ignore_end_check and drop_index and ChallengeRingPlusMgr:get_destiny_drop_state(ring_id, drop_index) <= DESTINY_DROP_STATE.END then
      drop_index = nil
    end
    return drop_index
  end
end

function M:set_destiny_drop_index(ring_id, drop_index, cb)
  local curse_drop_data = {curse_id = ring_id, drop_index = drop_index}
  local body = {curse_drop_data = curse_drop_data}
  local set_ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  if not set_ring_cfg or set_ring_cfg.DestinyLevelDropType ~= CommonDefine.CURSE_DROP_TYPE.SELECT_DROP then
    return
  end
  local set_group = set_ring_cfg.DestinyLevelDrop
  Network:protect_call("c2gs_activity_curse_select_drop", body, function(ok, resp)
    if ok then
      if cb then
        cb(resp)
      end
      local activity_data = self.v_curse_activity_data
      if activity_data then
        activity_data.curse_drop_datas = activity_data.curse_drop_datas or {}
        local data = activity_data.curse_drop_datas
        local ring_cfgs = ShareRes.get_curse_ring_config()
        for id, ring_cfg in pairs(ring_cfgs) do
          if ring_cfg.DestinyLevelDropType == CommonDefine.CURSE_DROP_TYPE.SELECT_DROP and ring_cfg.DestinyLevelDrop == set_group then
            data[id] = data[id] or {curse_id = id, drop_index = drop_index}
            data[id].drop_index = drop_index
          end
        end
      end
      MsgGame:mq_publish2(Const.MSG_ON_RING_DATA_UPDATE)
    end
  end)
end

function M:get_destiny_drop_state(ring_id, drop_index)
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  if ring_cfg.DestinyLevelDropType ~= CommonDefine.CURSE_DROP_TYPE.SELECT_DROP then
    return DESTINY_DROP_STATE.LOCK
  end
  local destiny_group_cfg = ShareRes.get_curse_destiny_level_select_drop(ring_cfg.DestinyLevelDrop)
  if not destiny_group_cfg or not destiny_group_cfg[drop_index] then
    return DESTINY_DROP_STATE.LOCK
  end
  local destiny_cfg = destiny_group_cfg[drop_index]
  local cur_time = Date.server_time()
  local begin_time = destiny_cfg.BeginTime and Date.get_time_stamp_by_scheme_id(destiny_cfg.BeginTime)
  local unlock_time = destiny_cfg.UnlockTime and Date.get_time_stamp_by_scheme_id(destiny_cfg.UnlockTime)
  if begin_time and cur_time < begin_time then
    return DESTINY_DROP_STATE.LOCK, begin_time
  end
  if unlock_time and cur_time < unlock_time then
    return DESTINY_DROP_STATE.CAN_SHOW, unlock_time
  end
  local end_time = destiny_cfg.EndTime and Date.get_time_stamp_by_scheme_id(destiny_cfg.EndTime)
  if end_time and cur_time >= end_time then
    return DESTINY_DROP_STATE.END
  end
  return DESTINY_DROP_STATE.CAN_SELECT, end_time
end

function M:get_destiny_drop_red(drop_index)
  return not self.v_destiny_drop_red_map or not self.v_destiny_drop_red_map[drop_index]
end

function M:get_destiny_drop_group_red(ring_id)
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  if ring_cfg.DestinyLevelDropType ~= CommonDefine.CURSE_DROP_TYPE.SELECT_DROP then
    return false
  end
  local destiny_group_cfg = ShareRes.get_curse_destiny_level_select_drop(ring_cfg.DestinyLevelDrop)
  if not destiny_group_cfg then
    return false
  end
  for drop_index, destiny_cfg in pairs(destiny_group_cfg) do
    if destiny_cfg.ShowAwardId and self:get_destiny_drop_state(ring_id, drop_index) == DESTINY_DROP_STATE.CAN_SELECT and self:get_destiny_drop_red(drop_index) then
      return true
    end
  end
  return false
end

function M:set_destiny_drop_red(ring_id, drop_index)
  if self:get_destiny_drop_state(ring_id, drop_index) == DESTINY_DROP_STATE.CAN_SELECT and self:get_destiny_drop_red(drop_index) then
    self.v_destiny_drop_red_map = self.v_destiny_drop_red_map or {}
    self.v_destiny_drop_red_map[drop_index] = 1
  end
end

function M:save_destiny_drop_red()
  if self.v_destiny_drop_red_map then
    LocalStorage:save_table(DESTINY_DROP_RED, self.v_destiny_drop_red_map, true)
  end
end

return M
