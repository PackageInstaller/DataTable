local Base = require("gamelogic.base_system")
local CommonDef = require("cs_share.common_define")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local M = Util.create_child_mt(Base)
local DEBUG = false
local CR_RING_CFG_PATH = require("uimodule.stage_activity.challenge_ring.challenge_ring_cfg")
local CARD_DECK_STATE = CR_RING_CFG_PATH.CARD_DECK_STATE
local CARD_TYPE = CommonDef.CHL_RING_CARD_TYPE
local EMBLEM_UPDATE_SOURCE = CommonDef.EMBLEM_UPDATE_SOURCE
local _tinsert = table.insert
local CARD_STATUS = {
  INIT = 1,
  SUSPEND = 2,
  ON_CHOOSE = 3,
  DONE = 4
}
local DROP_TYPE = Config.DROP_TYPE

function M:init_sys()
  Base.init_sys(self)
  self:init_data()
  self:sys_mq_bind(Const.MSG_ON_DROP_SHOW_ITEM_END, self.response_drop_show_item_end, self)
end

function M:on_ring_card_end(draw_card_cb)
  if DEBUG then
    Log.Error("上报card end")
    Log.Error(debug.traceback())
  end
  self.v_select_card_list = {}
  self.v_is_send_card_end = true
  self.v_cache_fight_end = nil
  Network:call("c2gs_chal_ring_card_end", nil, function(ok)
    if ok then
      if DEBUG then
        Log.Error("card end 回包")
      end
      if draw_card_cb then
        draw_card_cb()
      end
      self.v_is_send_card_end = false
      self:get_new_card_list()
      self:reset_selecting_card_state()
      MsgGame:mq_publish2(Const.MSG_ON_DRAW_CARD_END)
    end
  end)
end

function M:on_select_card(select_idx, cb)
  if DEBUG then
    Log.Error("select_idx", select_idx)
    Log.Error("self.v_select_card_list", self.v_select_card_list)
  end
  Network:call("c2gs_chal_ring_choose_card", {index = select_idx}, function(ok, resp)
    if ok then
      Log.Info("select success", select_idx)
      Util.show_message_tip(2051)
      MsgGame:mq_publish2(Const.MSG_ON_CR_SELECT_CARD_END)
      if cb then
        cb()
      end
    end
  end)
end

function M:on_get_chal_ring_towerinfo(tower_id)
  if not self.v_is_get_ring_info then
    self:init_data()
    Network:call("c2gs_chal_ring_towerinfo", {tower_id = tower_id}, function(ok, resp)
      if ok then
        local tower = TowerMgr:get_tower()
        if tower then
          local floor_num = tower:get_tower_cur_floor_num()
          self.v_cur_cal_ring_circle = resp.circle_list[floor_num]
          self:refresh_ring_data()
        else
          Log.Error("塔不存在")
        end
        Log.Info("cur cal ring info :", self.v_cur_cal_ring_circle)
        MsgGame:mq_publish2(Const.MSG_ON_CR_GET_RING_INFO_SUCCESS)
        self.v_is_get_ring_info = true
      end
    end)
  end
end

function M:refresh_ring_data()
  self.v_select_card_list = self.v_cur_cal_ring_circle.ans_list
  local is_start = self.v_cur_cal_ring_circle.is_start
  self:set_is_start(is_start)
  self.v_show_emblem = self.v_cur_cal_ring_circle.emblem
  local choose_uuid = self.v_cur_cal_ring_circle.choose_uuid
  if choose_uuid then
    local card_data = self:get_card_by_uuid(choose_uuid)
    self:cache_select_card_data(card_data)
  end
end

function M:on_receive_heal_card(is_done, card_cfg)
  if is_done then
    self:on_heal_card_cb()
  else
    local magic_id = card_cfg.Arg[1]
    local list = SceneMgr:get_hero_list()
    local magic_list = {}
    for _, hero in pairs(list) do
      local rtid = -1
      if not hero:is_destroy() and not hero:is_die() and hero:is_can_heal() then
        hero.magic_mgr:remove_magic_by_id(magic_id)
        FightBagMgr:calc_blood_add_list(hero, magic_id, 1)
        rtid = hero.magic_mgr:add_magic(hero, magic_id, nil, nil, 1)
      end
      magic_list[#magic_list + 1] = rtid
    end
    Network:call("c2gs_chal_ring_exec_logic", {magic_rtid_list = magic_list}, function(ok)
      if ok then
        self:on_heal_card_cb()
      end
    end)
  end
end

function M:on_heal_card_cb()
  local function cb()
    MsgGame:mq_publish2(Const.MSG_ON_HEAL_CARD_REFRESH)
  end
  
  self:on_ring_card_end(cb)
end

function M:on_receive_reward_card(is_done)
  if is_done then
    local function cb()
      MsgGame:mq_publish2(Const.MSG_ON_REWARD_CARD_REFRESH)
    end
    
    self:on_ring_card_end(cb)
  else
    local card_data = self:get_selecting_card()
    local card_id = card_data.id
    local card_cfg = ShareRes.get_ring_card(card_id)
    local item_id = card_cfg.Arg[1]
    local ran_ans_uuid = card_data.ran_ans_uuid
    if Item_Helper.get_is_equip_collect(item_id) then
      local has_equip = FightBagMgr:has_same_type_equip(item_id)
      if not has_equip then
        self:on_reward_card_exec_logic(true)
        return
      end
      local param = {
        tips_source = BagCfg.TIPS_SOURCE.OTHER,
        get_cb = function(is_need)
          self:on_reward_card_exec_logic(is_need)
        end
      }
      Item_Helper.show_battle_tips(item_id, ran_ans_uuid, param)
    else
      self:on_reward_card_exec_logic()
    end
  end
end

function M:on_reward_card_exec_logic(is_use_col)
  Network:call("c2gs_chal_ring_exec_logic", {is_use_col = is_use_col}, function(ok)
    if ok then
      local function cb()
        MsgGame:mq_publish2(Const.MSG_ON_REWARD_CARD_REFRESH)
      end
      
      self:on_ring_card_end(cb)
    end
  end)
end

function M:on_receive_shop_card(is_done)
  if is_done then
    self:on_ring_card_end()
  else
    BattleShopMgr:open_battle_shop()
  end
end

function M:on_receive_treasure_card(is_done)
  if is_done then
    self:on_ring_card_end()
  else
    BattleTreasureMgr:open_battle_treasure()
  end
end

function M:on_refresh_door_card(is_done)
  if is_done then
    self:on_ring_card_end()
  else
    Network:call("c2gs_chal_ring_exec_logic", {}, function(ok)
      if ok then
        if DEBUG then
          Log.Error("door card refresh")
        end
        MsgGame:mq_publish2(Const.MSG_ON_CR_REFRESH_DOOR_CARD)
      end
    end)
  end
end

function M:on_receive_cast_card(is_done, cfg)
  if is_done then
    self:on_ring_card_end()
  else
    local cast_id = cfg.Arg[1]
    Rune2Mgr:open_cast_ui(cast_id)
  end
end

function M:on_update_chal_ring_emblem(data)
  local emblem_num = data.emblem
  local source = data.source
  self.v_cur_cal_ring_circle.emblem = emblem_num
  if source == EMBLEM_UPDATE_SOURCE.ITEM_ADD then
    self:refresh_show_emblem()
    MsgGame:mq_publish2(Const.MSG_ON_CR_REFRESH_EMBLEM_NUM)
  end
end

local CARD_TYPE2FUN = {
  [CARD_TYPE.HEAL] = "on_receive_heal_card",
  [CARD_TYPE.RECEIVE] = "on_receive_reward_card",
  [CARD_TYPE.SHOP] = "on_receive_shop_card",
  [CARD_TYPE.TREASURE] = "on_receive_treasure_card",
  [CARD_TYPE.DOOR] = "on_refresh_door_card",
  [CARD_TYPE.CAST] = "on_receive_cast_card"
}

function M:battle_end_open_ui()
  if self.v_is_start and not self.v_is_send_card_end then
    if self:check_pass_ring() then
      return
    end
    UIMgr:get_ui("ui_challenge_ring"):ui_show()
    local card_data = self:get_selecting_card()
    if card_data then
      local id = card_data.id
      local cfg = ShareRes.get_ring_card(id)
      local type = cfg.Type
      local is_done = card_data.is_done
      local special_fun = CARD_TYPE2FUN[type]
      if special_fun then
        self[special_fun](self, is_done, cfg)
      else
        local is_have_drop = DropShowMgr:is_have_drop_seq()
        if not is_have_drop then
          self:on_ring_card_end()
        end
      end
    elseif self:is_draw_card_end() then
      MsgGame:mq_publish2(Const.MSG_ON_CARD_RANDOM_REFRESH)
    else
      self:on_ring_card_end()
    end
  end
end

function M:open_cr_ui()
  UIMgr:get_ui("ui_challenge_ring"):ui_show()
end

function M:on_get_cr_random_card(card_id_list)
  if DEBUG then
    Log.Error("获取随机牌信息", card_id_list)
  end
  self.v_select_card_list = card_id_list.ans_list
  if self.v_select_card_list and next(self.v_select_card_list) then
    MsgGame:mq_publish2(Const.MSG_ON_CARD_RANDOM_REFRESH)
  end
  self:set_is_start(true)
end

function M:on_get_chal_ring_cards_data(card_ring_circle)
  self.v_cur_cal_ring_circle = card_ring_circle.circle
  self:refresh_ring_data()
  MsgGame:mq_publish2(Const.MSG_ON_RING_CARD_REFRESH)
end

function M:on_update_cr_card_state(card_data)
  local circle_idx = card_data.circle_idx
  local card = card_data.card
  local card_uuid = card.uuid
  local card_status = card.status
  local card_id = card.id
  local card_cfg = ShareRes.get_ring_card(card_id)
  local card_type = card_cfg.ShowType
  local card_list = self.v_cur_cal_ring_circle.cards
  local now_circle_idx = self.v_cur_cal_ring_circle.circle_idx
  if now_circle_idx == circle_idx + 1 then
    if card_type == CARD_TYPE.DOOR and card_status == CARD_STATUS.DONE then
      self:enter_next_floor()
    end
    return
  end
  if card_list then
    for key, data in pairs(card_list) do
      local uuid = data.uuid
      if card_uuid == uuid then
        card_list[key].status = card_status
        if card_type == CARD_TYPE.DOOR and card_status == CARD_STATUS.DONE then
          self:enter_next_floor()
        end
        break
      end
    end
  end
end

function M:enter_next_floor()
  local tower = TowerMgr:get_tower()
  if tower and tower:is_challenge_ring_tower() and not self:check_pass_ring(true) then
    self.v_is_get_ring_info = false
    tower:enter_next_floor()
  end
end

function M:get_random_select_card()
  return self.v_select_card_list
end

function M:get_random_select_card_length()
  return #self.v_select_card_list
end

function M:clear_select_random_card()
  self.v_select_card_list = nil
end

function M:get_cur_circle_ans_list()
  return self.v_cur_cal_ring_circle.ans_list
end

function M:get_cur_circle_card_list()
  return self.v_cur_cal_ring_circle.cards
end

function M:get_cur_show_emblem()
  return self.v_show_emblem
end

function M:get_cur_circle_card_num()
  if not self.v_cur_cal_ring_circle.cards then
    Log.Error("牌堆不存在")
    return
  end
  return #self.v_cur_cal_ring_circle.cards
end

function M:get_remain_card_num()
  return self:cal_remain_card_num()
end

function M:cal_remain_card_num()
  if not self.v_cur_cal_ring_circle.cards then
    Log.Error("牌堆不存在")
    return
  end
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local remain_card_num = 0
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local status = card_data.status
    local card_id = card_data.id
    local card_cfg = total_card_cfg[card_id]
    local show_type = card_cfg.ShowType
    local replica = card_data.replica
    if not card_cfg then
      Log.Error("卡牌配置不存在, id = ", card_id)
      return
    end
    if status ~= CARD_STATUS.DONE then
      local KeyThreshold = card_cfg.KeyThreshold
      if not (show_type ~= CARD_TYPE.DOOR or self:is_key_card_delete()) or KeyThreshold and not replica and not self:is_show_key_card() then
      else
        remain_card_num = remain_card_num + 1
      end
    end
  end
  return remain_card_num
end

function M:get_cur_emblem()
  return self.v_cur_cal_ring_circle.emblem or 0
end

function M:get_all_emblem_num()
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local emblem_card_num = 0
  local card_list = self.v_cur_cal_ring_circle.cards
  if card_list then
    for _, card_data in pairs(card_list) do
      local card_id = card_data.id
      local card_cfg = total_card_cfg[card_id]
      local KeyThreshold = card_cfg.KeyThreshold
      if KeyThreshold then
        emblem_card_num = KeyThreshold
      end
    end
  end
  return emblem_card_num
end

function M:get_key_card_probability()
  local pro_num = self:get_cur_emblem() - self:get_all_emblem_num() + 1
  local ring_id = self:get_cur_ring_id()
  local emblem_cfg = ShareRes.create("activity.challenge_ring_emblem", ring_id)
  if not emblem_cfg then
    Log.Error("标记不存在, tower id = ", ring_id)
  end
  local pro_list = emblem_cfg.Probability
  local pro_length = #pro_list
  local pro_value = pro_list[pro_num] or pro_list[pro_length]
  return pro_value
end

function M:get_cur_ring_id()
  local tower = TowerMgr:get_tower()
  local tower_id = tower:get_tower_id()
  local tower_ring_cfg = ShareRes.create("activity.rings_of_challenge_ring_by_tower", tower_id)
  if not tower_ring_cfg then
    Log.Error("塔环配置不存在, tower id = ", tower_id)
  end
  local cur_ring_idx = self:get_cur_ring_num()
  local ring_cfg = tower_ring_cfg[cur_ring_idx]
  if not ring_cfg then
    Log.Error("环配置不存在, tower id = ", tower_id)
  end
  local ring_id = ring_cfg.Id
  return ring_id
end

function M:get_battle_room_idx(card_uuid)
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local now_uuid = card_data.uuid
    local room_index = card_data.room_index
    if now_uuid == card_uuid then
      return room_index
    end
  end
end

function M:get_card_type_list()
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  self.v_card_type_num = {}
  local card_list = self.v_cur_cal_ring_circle.cards
  local is_have_key_card = false
  local key_card_type
  if not card_list or next(card_list) == nil then
    return
  end
  for _, card_data in pairs(card_list) do
    local id = card_data.id
    local cfg = total_card_cfg[id]
    local show_type = cfg.ShowType
    local status = card_data.status
    local KeyThreshold = cfg.KeyThreshold
    self.v_card_type_num[show_type] = self.v_card_type_num[show_type] or 0
    if status ~= CARD_STATUS.DONE then
      if KeyThreshold then
        key_card_type = show_type
        is_have_key_card = true
      end
      self.v_card_type_num[show_type] = self.v_card_type_num[show_type] + 1
    end
  end
  if not self:is_show_key_card() and key_card_type and self.v_card_type_num[key_card_type] then
    if self.v_card_type_num[key_card_type] > 1 then
      self.v_card_type_num[key_card_type] = self.v_card_type_num[key_card_type] - 1
    else
      self.v_card_type_num[key_card_type] = nil
    end
  end
  if not self:is_key_card_delete() then
    self.v_card_type_num[CommonDef.CHL_RING_CARD_TYPE.DOOR] = nil
  end
  return self.v_card_type_num
end

function M:change_now_ring()
  local tower_progress = TowerMgr:get_tower_progress()
  local episode_id = tower_progress.episode_id
  local activity = ActivityMgr:get_challenge_ring_act()
  local stage_info = activity:get_total_stage_info()
  if self.v_cur_ring_info and self.v_cur_ring_info.round ~= stage_info[episode_id].round then
    self:call_on_round_finshed()
  end
  self.v_cur_ring_info = stage_info[episode_id]
end

function M:call_on_round_finshed()
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  local wait_hero_list = {}
  for uuid, hero in pairs(hero_list) do
    if uuid ~= Global.hero_uuid then
      table.insert(wait_hero_list, hero)
    end
  end
  BehaviorMgr:call_event_fun("on_round_finished", Global.hero, wait_hero_list[1], wait_hero_list[2], self.v_cur_ring_info.round)
end

function M:get_cur_ring_num()
  if not self.v_cur_cal_ring_circle then
    return
  end
  return self.v_cur_cal_ring_circle.circle_idx
end

function M:get_cur_ring_info()
  if not self.v_cur_ring_info then
    self:change_now_ring()
  end
  return self.v_cur_ring_info
end

function M:get_cur_round()
  return self.v_cur_ring_info.round or 0
end

function M:is_show_key_card()
  return self:get_cur_emblem() >= self:get_all_emblem_num()
end

function M:is_key_card_delete()
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local card_list = self.v_cur_cal_ring_circle.cards
  local is_key_card_delete = false
  for _, card_data in pairs(card_list) do
    local id = card_data.id
    local cfg = total_card_cfg[id]
    local status = card_data.status
    local KeyThreshold = cfg.KeyThreshold
    local replica = card_data.replica
    if status == CARD_STATUS.DONE and KeyThreshold and not replica then
      is_key_card_delete = true
      break
    end
  end
  return is_key_card_delete
end

function M:get_is_start()
  return self.v_is_start
end

function M:set_is_start(is_on)
  self.v_is_start = is_on
end

function M:get_cur_ring_award()
  local ring_id = self:get_cur_ring_id()
  local total_tower_cfg = ShareRes.create("activity.rings_of_challenge_ring_by_tower")
  local ring_cfg = ShareRes.create("activity.rings_of_challenge_ring", ring_id)
  local sort = ring_cfg.Sort - 1
  local tower_id = ring_cfg.TowerId
  if not ring_cfg then
    return
  end
  local tower_cfg = total_tower_cfg[tower_id]
  local award_list = {}
  local item_list = {}
  for i = 1, sort do
    local now_ring_cfg = tower_cfg[i]
    if now_ring_cfg then
      local award_group_id = now_ring_cfg.AwardId
      local ring_award = ShareRes.create("award.award_group", award_group_id)
      local award_cfg = ShareRes.create("award.award")
      if not ring_award then
        Log.Error("奖励组不存在, ring_id = ", ring_id)
      end
      for _, award_id in pairs(ring_award) do
        if award_id > 0 then
          local id = award_cfg[award_id].ItemId
          local count = award_cfg[award_id].Num
          if item_list[id] then
            item_list[id] = item_list[id] + count
          else
            item_list[id] = count
          end
        end
      end
    end
  end
  for id, count in pairs(item_list) do
    local item_data = {id = id, count = count}
    _tinsert(award_list, item_data)
  end
  return award_list
end

function M:is_in_start_room()
  if not self.v_cur_cal_ring_circle or next(self.v_cur_cal_ring_circle) == nil then
    return false
  end
  local ring_id = self:get_cur_ring_id()
  local ring_cfg = ShareRes.create("activity.rings_of_challenge_ring", ring_id)
  local start_room_id = ring_cfg.StartRoomId
  local tower = TowerMgr:get_tower()
  if tower and tower:is_challenge_ring_tower() then
    local room = tower:get_room()
    local room_id = room:get_room_id()
    if room_id == start_room_id then
      return true
    end
  end
  return false
end

function M:response_drop_show_item_end(msg)
  if nil == msg or nil == msg.mm_x then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  if tower and not tower:is_challenge_ring_tower() then
    return
  end
  if tower:is_all_die() then
    return
  end
  local drop_type = msg.mm_x
  if drop_type == DROP_TYPE.CONTINUE then
    if self.v_is_start then
      if self:check_pass_ring() then
        return
      end
      self:battle_end_open_ui()
    end
  elseif drop_type == DROP_TYPE.FIGHT_END then
    self.v_cache_fight_end = true
    self:battle_end_open_ui()
  elseif drop_type == DROP_TYPE.GM and self.v_cache_fight_end then
    self:battle_end_open_ui()
    self.v_cache_fight_end = nil
  end
end

function M:refresh_show_emblem()
  self.v_show_emblem = self:get_cur_emblem()
end

function M:check_pass_ring(ignore_ui)
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local id = card_data.id
    local cfg = total_card_cfg[id]
    local show_type = cfg.ShowType
    local status = card_data.status
    if show_type == CARD_TYPE.DOOR and status == CARD_STATUS.DONE then
      if not ignore_ui then
        UIMgr:get_ui("fight_settlement"):ui_show()
      end
      return true
    end
  end
  return false
end

function M:select_list_include_door_card()
  if self.v_select_card_list and next(self.v_select_card_list) then
    for _, card_uuid in pairs(self.v_select_card_list) do
      local card_data = self:get_card_by_uuid(card_uuid)
      local card_id = card_data.id
      local show_type = ShareRes.get_ring_card_show_type(card_id)
      if show_type == CARD_TYPE.DOOR then
        return true
      end
    end
  end
  return false
end

function M:select_list_include_card(target_id)
  if self.v_select_card_list and next(self.v_select_card_list) then
    for _, card_uuid in pairs(self.v_select_card_list) do
      local card_id = self:get_card_by_uuid(card_uuid)
      if card_id == target_id then
        return true
      end
    end
  end
  return false
end

function M:is_now_ring_reach_emblem_num(ring_id, emblem_num)
  return self:get_cur_ring_id() == ring_id and emblem_num <= self:get_cur_emblem()
end

function M:get_key_card_data()
  local result
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local id = card_data.id
    local cfg = total_card_cfg[id]
    local KeyThreshold = cfg.KeyThreshold
    if KeyThreshold then
      result = card_data
      break
    end
  end
  return result
end

function M:get_door_card_data()
  local result
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local id = card_data.id
    local cfg = total_card_cfg[id]
    local show_type = cfg.ShowType
    if show_type == CARD_TYPE.DOOR then
      result = card_data
      break
    end
  end
  return result
end

function M:exit_tower()
  self:init_data()
end

function M:init_data()
  self.v_select_card_list = {}
  self.v_cur_cal_ring_circle = {}
  self.v_is_selecting_card = nil
  self.v_is_select_card = nil
  self.v_is_send_card_end = false
  self.v_cache_fight_end = nil
  self:set_is_start(false)
  self.v_show_emblem = 0
  self.v_is_get_ring_info = false
end

function M:get_selecting_card()
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local status = card_data.status
    if status == CARD_STATUS.ON_CHOOSE then
      return card_data
    end
  end
end

function M:is_selecting_door_card()
  local total_card_cfg = ShareRes.create("activity.challenge_ring_card")
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local status = card_data.status
    local id = card_data.id
    local cfg = total_card_cfg[id]
    local show_type = cfg.ShowType
    if status == CARD_STATUS.ON_CHOOSE and show_type == CARD_TYPE.DOOR then
      return true
    end
  end
  return false
end

function M:is_draw_card_end()
  local card_list = self.v_cur_cal_ring_circle.cards
  for _, card_data in pairs(card_list) do
    local status = card_data.status
    if status == CARD_STATUS.SUSPEND and self:is_have_select_ans_list() then
      return true
    end
  end
  return false
end

function M:get_select_card_info()
  return self.v_new_select_card_info
end

function M:set_select_card_info(data)
  local select_idx = data.card_list_idx
  local card_uuid = self.v_select_card_list[select_idx]
  local card_data = self:get_card_by_uuid(card_uuid)
  local card_id = card_data.id
  data.card_id = card_id
  self.v_new_select_card_info = data
  self:cache_select_card_data(card_data)
end

function M:cache_select_card_data(data)
  self.v_select_card_cache = data
end

function M:get_cache_select_card_data()
  return self.v_select_card_cache
end

function M:cache_card_deck_state(state)
  self.v_card_deck_state = state
end

function M:get_card_deck_state()
  self:check_now_state()
  return self.v_card_deck_state
end

function M:check_now_state()
  if self:get_selecting_card() then
    self.v_card_deck_state = CARD_DECK_STATE.CONTINUE_SELECTING
    return
  end
  if self:is_draw_card() then
    self.v_card_deck_state = CARD_DECK_STATE.SELECT
    return
  end
  self.v_card_deck_state = nil
end

function M:draw_card_end()
  self.v_is_select_card = true
  self:reset_selecting_card_state()
end

function M:get_new_card_list()
  self.v_is_select_card = false
end

function M:select_card_end()
  self.v_is_selecting_card = true
end

function M:is_selecting_card()
  return self.v_is_selecting_card
end

function M:is_have_select_ans_list()
  return self.v_select_card_list and next(self.v_select_card_list)
end

function M:reset_selecting_card_state()
  self.v_is_selecting_card = false
end

function M:is_draw_card()
  return self.v_is_select_card
end

function M:get_card_by_uuid(card_uuid)
  local card_list = self.v_cur_cal_ring_circle.cards
  return card_list[card_uuid]
end

function M:get_card_select_idx(now_card_uuid)
  if self.v_select_card_list then
    for index, card_uuid in pairs(self.v_select_card_list) do
      if now_card_uuid == card_uuid then
        return index
      end
    end
  end
end

function M:on_unlock_card(card_uuid)
  local card_idx = self:get_card_select_idx(card_uuid)
  if not card_idx then
    Log.Error("card idx is not exist , card uuid = ", card_uuid)
    return
  end
  Network:call("c2gs_chal_ring_unlock_card", {index = card_idx}, function(ok)
    if ok then
      local card_data = self:get_card_by_uuid(card_uuid)
      card_data.unlock = true
      Util.show_message_tip(2063)
    end
  end)
end

function M:is_get_ring_info()
  return self.v_is_get_ring_info
end

return M
