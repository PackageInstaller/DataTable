local Base = require("gamelogic.base_system")
local CommonDefine = require("cs_share.common_define")
local BUFF_TYPE = CommonDefine.BUFF_TYPE
local M = Util.create_child_mt(Base)
local ornament_buff_type_list = {
  [BUFF_TYPE.REDUCE_CURSE_VAL] = BUFF_TYPE.REDUCE_CURSE_VAL,
  [BUFF_TYPE.PAY_CURSE_DISCOUNT] = BUFF_TYPE.PAY_CURSE_DISCOUNT,
  [BUFF_TYPE.PAY_COIN_DISCOUNT_ALL] = BUFF_TYPE.PAY_COIN_DISCOUNT_ALL,
  [BUFF_TYPE.KILL_MONSTER_ADD_COIN_ALL] = BUFF_TYPE.KILL_MONSTER_ADD_COIN_ALL,
  [BUFF_TYPE.INLAY_ORNAMENT] = BUFF_TYPE.INLAY_ORNAMENT
}
local BORN_MAGIC_MAP = {
  [BUFF_TYPE.EXTRA_CURSE_VALUE_MAGIC] = true
}

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_SKIP_CARD_FAIL, self.on_curse_skip_fail, self)
  self:sys_mq_bind(Const.MSG_ON_CURSE_RING_RUNE_CHANGE, self.on_change_rune, self)
  self:sys_mq_bind(Const.MSG_ON_CURSE_RING_PASS_RING, self.on_pass_curse_ring, self)
  self:sys_mq_bind(Const.MSG_ON_ALL_HERO_REBORN_END, self.hero_reborn, self)
  self:sys_mq_bind(Const.MSG_ON_GAME_PAUSE, self.battle_pause, self)
  self:sys_mq_bind(Const.MSG_ON_ORNAMENT_CHANGE, self.on_inlay_ornament, self)
  self:sys_mq_bind(Const.MSG_ON_FIGHT_END, self.update_fight_state, self)
  self:sys_mq_bind(Const.MSG_SCENE_LOAD_FINISH, self.update_fight_state, self)
  self.v_battle_buff_list = {}
  self.v_cur_max_hp_hurt_by_skip_card_uuid = 0
  self.v_cur_pay_hp_replace_curse_uuid = 0
  self.v_ornament_buff_id_list = {}
  self.v_buff_type_map = {}
  self.v_borrow_money_map = {}
  self.v_forbid_switch_hero = nil
end

function M:on_battle_buff_list()
end

function M:add_battle_buff()
end

function M:update()
  self:update_forbid_switch_hero_buff()
end

function M:get_time()
  return Global.delta_time * GlobalTimeMgr:get_time_scale()
end

function M:update_forbid_switch_hero_buff()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local buff_data = self.v_forbid_switch_hero
  if not buff_data then
    return
  end
  local time = self:get_time()
  if buff_data.cd_time > 0 then
    buff_data.cd_time = buff_data.cd_time - time
    buff_data.cd_time = math.max(buff_data.cd_time, 0)
    return
  end
  if not buff_data.is_trigger then
    return
  end
  buff_data.trigger_time = buff_data.trigger_time + time
  if buff_data.trigger_time >= buff_data.life_time then
    buff_data.trigger_time = 0
    buff_data.is_trigger = false
    buff_data.cd_time = buff_data.cd
    SceneMgr:set_forbid_switch_hero_state(false)
  end
end

function M:remove_buff(buff_data)
  local uuid = buff_data.uuid
  local buff_cfg = buff_data.buff_cfg
  local buff_id = buff_cfg.Id
  Network:call("c2gs_remove_buff", {buff_uuid = uuid}, function(ok, resp)
    if ok then
      BehaviorMgr:call_event_fun("remove_buff", buff_id)
      self:remove_buff_effect(buff_data.buff_cfg, buff_data)
      MsgGame:mq_publish2(Const.MSG_ON_BUFF_REMOVE)
    end
  end)
end

function M:remove_buff_effect(buff_cfg, buff_data)
  local buff_type = buff_cfg.Type
  if buff_type == BUFF_TYPE.FORBID_SWITCH_HERO then
    self.v_forbid_switch_hero = nil
    SceneMgr:set_forbid_switch_hero_state(false)
  elseif buff_cfg.Type == BUFF_TYPE.REDUCE_HP_BY_SECOND then
    self:hero_remove_magic(buff_cfg.Arg[1])
  elseif buff_cfg.Type == BUFF_TYPE.REDUCE_SKIP_CARD_RATE then
    local add_val = buff_cfg.Arg[1] / 10000
    ChallengeRingPlusMgr:add_jump_crad_pro(add_val)
  elseif buff_cfg.Type == BUFF_TYPE.PAY_COIN_DISCOUNT_ALL then
    local reduce_discount = -(buff_cfg.Arg[1] / 100)
    ChallengeRingPlusMgr:add_pay_coin_discount(reduce_discount)
  elseif buff_cfg.Type == BUFF_TYPE.PAY_CURSE_DISCOUNT then
    local reduce_discount = -(buff_cfg.Arg[1] / 100)
    ChallengeRingPlusMgr:add_pay_curse_discount(reduce_discount)
  elseif buff_cfg.Type == BUFF_TYPE.REDUCE_CURSE_VAL then
    ChallengeRingPlusMgr:set_have_reduce_curse_val_buff(false, 0)
  elseif buff_type == BUFF_TYPE.ADD_KILL_BOSS_CURSE_VAL then
    local bless_cfg = ChallengeRingPlusMgr:get_bless_lv_cfg(1006, 1)
    ChallengeRingPlusMgr:set_have_add_kill_boss_buff(true, bless_cfg.BuffArg[1][1])
  elseif buff_type == BUFF_TYPE.CURSE_LEVEL_CHANGE then
    ChallengeRingPlusMgr:remove_curse_level_change()
  elseif buff_type == BUFF_TYPE.PAY_HP_REPLACE_CURSE then
    self.v_cur_pay_hp_replace_curse_uuid = 0
  elseif buff_type == BUFF_TYPE.BORROW_MONEY then
    local item_id = buff_cfg.Arg[1]
    self.v_borrow_money_map[item_id] = nil
  elseif buff_type == BUFF_TYPE.CURSE_MAX_SUB then
    if buff_data.arg[1] then
      ChallengeRingPlusMgr:add_curse_val_limit(nil, buff_data.uuid, buff_data.state)
    else
      ChallengeRingPlusMgr:add_curse_val_limit(nil, buff_data.uuid, buff_data.state)
    end
  elseif buff_type == BUFF_TYPE.ADD_CURSE_MAX_VAL then
    ChallengeRingPlusMgr:add_curse_val_limit(nil, buff_data.uuid, buff_data.state)
  elseif buff_type == BUFF_TYPE.ADD_ATTR_BY_CURSE_BUFF then
    local magic_id = buff_data.buff_cfg.Arg[1]
    local level = buff_data.level
    self:hero_remove_magic(magic_id, level, true)
  elseif buff_type == BUFF_TYPE.INLAY_ORNAMENT then
    local lv = buff_data.level
    for key, magic_id in ipairs(buff_cfg.Arg) do
      if magic_id > 0 then
        if 5 ~= key then
          self:hero_remove_magic(magic_id, lv, true)
        else
          self:hero_add_magic(magic_id, lv, true, true)
        end
      end
    end
  end
  if BORN_MAGIC_MAP[buff_type] then
    self:check_monster_born_magic_on_remove(buff_cfg.Arg)
  end
end

function M:tower_exit()
  self.v_forbid_switch_hero = nil
  self.v_cur_max_hp_hurt_by_skip_card_uuid = 0
  self.v_cur_pay_hp_replace_curse_uuid = 0
  self.v_ornament_buff_id_list = {}
  SceneMgr:set_forbid_switch_hero_state(false)
end

function M:update_battle_buff_list()
  self.v_battle_buff_list = FightBagMgr:get_item_buffs()
  self.v_buff_type_map = FightBagMgr:get_buff_type_map()
end

function M:on_inlay_ornament()
  UtilTable.clear_map(self.v_ornament_buff_id_list)
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    local id = buff_info.buff_cfg.Id
    if ornament_buff_type_list[buff_info.buff_cfg.Type] then
      self.v_ornament_buff_id_list[id] = buff_info
    end
  end
end

function M:on_discharge_onament(buff_cfg)
  if not buff_cfg or not buff_cfg.Arg then
    return
  end
  self.v_ornament_buff_id_list[buff_cfg.Id] = nil
end

function M:on_curse_skip_fail()
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    if buff_info.buff_cfg.Type == BUFF_TYPE.MAX_HP_HURT_BY_SKIP_CARD then
      if self.v_cur_max_hp_hurt_by_skip_card_uuid ~= buff_info.uuid then
        self:hero_add_magic(buff_info.buff_cfg.Arg[1], buff_info.level, true)
        MsgGame:mq_publish2(Const.MSG_ON_SKIP_CARD_FAIL_BUFF_EFFECT)
      else
        self.v_cur_max_hp_hurt_by_skip_card_uuid = 0
      end
    end
  end
end

function M:on_change_rune()
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    if buff_info.buff_cfg.Type == BUFF_TYPE.ADD_HP_WITH_RUNE_CHANGE then
      self:hero_add_magic(buff_info.buff_cfg.Arg[1], buff_info.level)
    end
  end
end

function M:on_curse_pay()
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    if buff_info.buff_cfg.Type == BUFF_TYPE.PAY_HP_REPLACE_CURSE then
      if self.v_cur_pay_hp_replace_curse_uuid ~= buff_info.uuid then
        self:hero_add_magic(buff_info.buff_cfg.Arg[1], buff_info.level)
      else
        self.v_cur_pay_hp_replace_curse_uuid = 0
      end
    end
  end
end

function M:on_pass_curse_ring()
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    if buff_info.buff_cfg.Type == BUFF_TYPE.ADD_HP_WITH_PASS_RING then
      self:hero_add_magic(buff_info.buff_cfg.Arg[1], buff_info.level)
    end
  end
end

function M:set_buff_effect(buff_info)
  local buff_cfg = buff_info.buff_cfg
  local uuid = buff_info.uuid
  local buff_type = buff_cfg.Type
  if buff_type == BUFF_TYPE.CHANGE_GREEDKILL then
    local data = {}
    data.life_time_scale = buff_info.buff_cfg.Arg[1]
    data.lost_level = buff_info.buff_cfg.Arg[2]
    data.greed_id = buff_info.buff_cfg.Arg[3]
    data.state = buff_info.state
  elseif buff_type == BUFF_TYPE.ADD_CURSE_MAX_VAL then
    if buff_info.arg[1] then
      ChallengeRingPlusMgr:add_curse_val_limit(buff_info.arg[1].value, buff_info.uuid, buff_info.state)
    else
      ChallengeRingPlusMgr:add_curse_val_limit(buff_info.buff_cfg.Arg[1], buff_info.uuid, buff_info.state)
    end
  elseif buff_type == BUFF_TYPE.REDUCE_SKIP_CARD_RATE then
    local add_val = -(buff_info.buff_cfg.Arg[1] / 10000)
    ChallengeRingPlusMgr:add_jump_crad_pro(add_val)
    MsgGame:mq_publish2(Const.MSG_ON_SKIP_CARD_PRO_CHANGE)
  elseif buff_type == BUFF_TYPE.CURSE_TIME_ADD then
    if buff_info.arg[1] then
      ChallengeRingPlusMgr:add_curse_time(buff_info.arg[1].value, buff_info.uuid, buff_info.state)
    else
      ChallengeRingPlusMgr:add_curse_time(buff_info.buff_cfg.Arg[1], buff_info.uuid, buff_info.state)
    end
  elseif buff_type == BUFF_TYPE.REDUCE_HP_BY_SECOND then
    local magic_id = buff_info.buff_cfg.Arg[1]
    if 1 == buff_info.state then
      if not SceneMgr:get_game_pause() and not ChallengeRingPlusMgr:get_is_curse_fight_state() then
        self:hero_add_magic(magic_id, buff_info.level)
      end
    else
      self:hero_remove_magic(magic_id, buff_info.level)
    end
  elseif buff_type == BUFF_TYPE.ADD_ATTR_WITH_COIN then
    local magic_id1 = buff_info.buff_cfg.Arg[2]
    local max_count = buff_info.buff_cfg.Arg[3]
    local level = math.min(max_count, buff_info.level)
    if 1 == buff_info.state then
      self:hero_add_magic(magic_id1, level - 1)
    else
      self:hero_remove_magic(magic_id1)
    end
  elseif buff_type == BUFF_TYPE.ADD_ATTR_BY_CURSE_BUFF then
    local magic_id = buff_info.buff_cfg.Arg[1]
    local level = buff_info.level
    if 1 == buff_info.state then
      self:hero_add_magic(magic_id, level)
    end
  elseif buff_type == BUFF_TYPE.PAY_COIN_DISCOUNT then
    if 1 == buff_info.state then
      local old_buff_info = self.v_ornament_buff_id_list[buff_info.buff_cfg.Id]
      if not old_buff_info then
        local reduce_discount = buff_info.buff_cfg.Arg[1] / 10000
        ChallengeRingPlusMgr:add_pay_coin_discount(reduce_discount)
      end
    end
  elseif buff_type == BUFF_TYPE.PAY_CURSE_DISCOUNT then
    if 1 == buff_info.state then
      local old_buff_info = self.v_ornament_buff_id_list[buff_info.buff_cfg.Id]
      if not old_buff_info then
        local reduce_discount = buff_info.buff_cfg.Arg[1] / 100
        ChallengeRingPlusMgr:add_pay_curse_discount(reduce_discount)
      end
    end
  elseif buff_type == BUFF_TYPE.PAY_COIN_DISCOUNT_ALL then
    if 1 == buff_info.state then
      local old_buff_info = self.v_ornament_buff_id_list[buff_info.buff_cfg.Id]
      if not old_buff_info then
        local reduce_discount = buff_info.buff_cfg.Arg[1] / 100
        ChallengeRingPlusMgr:add_pay_coin_discount(reduce_discount)
      end
    end
  elseif buff_type == BUFF_TYPE.HURT_DEBUFF_BY_HURT then
    self:hero_add_magic(buff_info.buff_cfg.Arg[1], buff_info.level)
  elseif buff_type == BUFF_TYPE.MAX_HP_HURT_BY_SKIP_CARD then
    self.v_cur_max_hp_hurt_by_skip_card_uuid = buff_info.uuid
  elseif buff_type == BUFF_TYPE.PAY_HP_REPLACE_CURSE then
    self.v_cur_pay_hp_replace_curse_uuid = buff_info.uuid
  elseif buff_type == BUFF_TYPE.FORBID_SWITCH_HERO then
    self.v_forbid_switch_hero = {
      uuid = uuid,
      life_time = buff_cfg.Arg[1],
      cd = buff_cfg.Arg[2],
      buff_id = buff_cfg.Id,
      is_trigger = false,
      trigger_time = 0,
      cd_time = 0
    }
    if UNITY_EDITOR then
      Log.Info("添加限制切换角色buff，buff Id = ", buff_cfg.Id)
    end
  elseif buff_type == BUFF_TYPE.ADD_MAGIC_LEVEL_LIMIT then
    self:refresh_limit_magic_buff_state(buff_info)
  elseif buff_type == BUFF_TYPE.REDUCE_CURSE_VAL then
    ChallengeRingPlusMgr:set_have_reduce_curse_val_buff(true, -buff_cfg.Arg[1])
  elseif buff_type == BUFF_TYPE.ADD_KILL_BOSS_CURSE_VAL then
    local bless_cfg = ChallengeRingPlusMgr:get_bless_lv_cfg(1006, 1)
    ChallengeRingPlusMgr:set_have_add_kill_boss_buff(true, -bless_cfg.BuffArg[1][1])
  elseif buff_type == BUFF_TYPE.CURSE_LEVEL_CHANGE then
    local tb = {
      trigger_level = buff_cfg.Arg[1],
      comparison_type = buff_cfg.Arg[2],
      magic_id = buff_cfg.Arg[3]
    }
    ChallengeRingPlusMgr:set_curse_level_change_param(tb)
  elseif buff_type == BUFF_TYPE.BORROW_MONEY then
    local item_id = buff_cfg.Arg[1]
    local borrow_count = buff_cfg.Arg[2]
    self.v_borrow_money_map[item_id] = borrow_count
  elseif buff_type == BUFF_TYPE.CURSE_MAX_SUB then
    if buff_info.arg[1] then
      ChallengeRingPlusMgr:add_curse_val_limit(-buff_info.arg[1].value, buff_info.uuid, buff_info.state)
    else
      ChallengeRingPlusMgr:add_curse_val_limit(-buff_info.buff_cfg.Arg[1], buff_info.uuid, buff_info.state)
    end
  elseif buff_type == BUFF_TYPE.INLAY_ORNAMENT then
    local old_buff_info = self.v_ornament_buff_id_list[buff_info.buff_cfg.Id]
    local old_lv = old_buff_info and old_buff_info.level or 0
    local dif_value = buff_info.level - old_lv
    if dif_value > 0 then
      self:hero_add_magic(buff_info.buff_cfg.Arg[1], dif_value, true, true)
    elseif dif_value < 0 then
      self:hero_remove_magic(buff_info.buff_cfg.Arg[1], dif_value, true)
    end
  end
  if BORN_MAGIC_MAP[buff_type] then
    self:check_monster_born_magic_on_add(buff_cfg.Arg)
  end
end

function M:on_orn_count_add_magic_effect(buff_info)
  local buff_cfg = buff_info.buff_cfg
  if buff_cfg.Arg and buff_cfg.Arg[1] then
    local magic_id = buff_cfg.Arg[1]
    local hero_list = SceneMgr:get_hero_list()
    local buff_lv = buff_info.level
    local magic_mgr
    for key, hero in pairs(hero_list) do
      if not Util.is_destroy(hero) then
        magic_mgr = hero.magic_mgr
        magic_mgr:remove_magic_by_id(magic_id)
        magic_mgr:add_magic(hero, magic_id, nil, nil, buff_lv)
      end
    end
  end
end

function M:refresh_limit_magic_buff_state(buff_info)
  local cur_buff_layer = buff_info.layer
  local buff_cfg = buff_info.buff_cfg
  local limit_layer = buff_cfg.Arg[2] or 0
  local magic_id = buff_cfg.Arg[1] or 0
  if 0 == magic_id then
    return
  end
  self:update_magic_state(magic_id, cur_buff_layer > limit_layer)
end

function M:check_forbid_switch_hero_buff()
  local data = self.v_forbid_switch_hero
  if not data then
    return
  end
  if data.is_trigger then
    return
  end
  if data.cd_time > 0 then
    return
  end
  data.is_trigger = true
  data.trigger_time = 0
  SceneMgr:set_forbid_switch_hero_state(true)
end

function M:get_forbid_switch_hero_time()
  local data = self.v_forbid_switch_hero
  if not self.v_forbid_switch_hero then
    return
  end
  local trigger_time = data.trigger_time
  local life_time = data.life_time
  return trigger_time, life_time
end

function M:battle_pause(msg)
  local is_remove = msg.mm_x
  if self:check_cur_room_fight_end() then
    is_remove = true
  end
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    self:update_curse_magci(buff_info, is_remove)
  end
end

function M:hero_reborn()
  if not TowerMgr then
    return
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return
  end
  local is_fight_end = room:is_fight_end()
  if is_fight_end then
    return
  end
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    self:update_curse_magci(buff_info)
  end
end

function M:check_cur_room_fight_end()
  if not TowerMgr then
    return
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return
  end
  local is_fight_end = room:is_fight_end()
  return is_fight_end
end

function M:update_fight_state()
  if not TowerMgr then
    return
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return
  end
  local is_fight_end = room:is_fight_end()
  for buff_uuid, buff_info in pairs(self.v_battle_buff_list) do
    self:update_curse_magci(buff_info, is_fight_end)
  end
end

function M:update_curse_magci(buff_info, is_remove)
  local buff_cfg = buff_info.buff_cfg
  if buff_cfg.Type == BUFF_TYPE.REDUCE_HP_BY_SECOND then
    if is_remove and not buff_cfg.IsFightEndEffect then
      self:hero_remove_magic(buff_cfg.Arg[1], buff_info.level)
    elseif 1 == buff_info.state then
      self:hero_add_magic(buff_cfg.Arg[1], buff_info.level)
    end
  end
end

function M:update_magic_state(magic_id, is_remove)
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  for uuid, hero in pairs(hero_list) do
    local magic_mgr = hero.magic_mgr
    if not hero:is_die() then
      if not is_remove then
        magic_mgr:add_magic(hero, magic_id)
      else
        magic_mgr:remove_magic_by_id(magic_id)
      end
    end
  end
end

function M:hero_add_magic(magic_id, count, is_clear, is_die_hero_add)
  if count <= 0 then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  for uuid, hero in pairs(hero_list) do
    if is_die_hero_add then
      self:_hero_add_magic(hero, magic_id, count, is_clear)
    elseif not hero:is_die() then
      self:_hero_add_magic(hero, magic_id, count, is_clear)
    end
  end
end

function M:_hero_add_magic(hero, magic_id, count, is_clear)
  if is_clear then
    hero.magic_mgr:remove_magic_by_id(magic_id)
  end
  local magic_count = hero.magic_mgr:get_magic_num(magic_id)
  if count > magic_count then
    for index = magic_count + 1, count do
      hero.magic_mgr:add_magic(hero, magic_id)
    end
  else
    for index = count + 1, magic_count do
      hero.magic_mgr:remove_magic_by_id(magic_id, 1)
    end
  end
end

function M:hero_remove_magic(magic_id, count, is_die_hero_remove)
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  for uuid, hero in pairs(hero_list) do
    if is_die_hero_remove then
      hero.magic_mgr:remove_magic_by_id(magic_id, count)
    elseif not hero:is_die() then
      hero.magic_mgr:remove_magic_by_id(magic_id, count)
    end
  end
end

function M:get_buff_by_id(buff_id)
  for key, buff in pairs(self.v_battle_buff_list) do
    if buff.id == buff_id then
      return buff
    end
  end
end

function M:get_buff_by_uuid(uuid)
  return self.v_battle_buff_list[uuid]
end

function M:get_buff_lv(buff_id)
  local buff = self:get_buff_by_id(buff_id)
  if buff then
    return buff.level
  end
  return 0
end

function M:get_buff_round_count(buff_id)
  local buff = self:get_buff_by_id(buff_id)
  if buff then
    return buff.round_count
  end
  return -1
end

function M:have_pay_hp_replace_curse_buff()
  return 0 ~= self.v_cur_pay_hp_replace_curse_uuid
end

function M:get_pay_hp_replace_curse_buff()
  return self.v_battle_buff_list[self.v_cur_pay_hp_replace_curse_uuid]
end

function M:check_monster_born_magic_on_add(magic_list)
  for index, magic_id in pairs(magic_list) do
    if Util.is_more_than_zero(magic_id) then
      FightDataMgr:add_monster_born_magic(magic_id, 1)
    end
  end
end

function M:check_monster_born_magic_on_remove(magic_list)
  for index, magic_id in pairs(magic_list) do
    if Util.is_more_than_zero(magic_id) then
      FightDataMgr:remove_monster_born_magic(magic_id)
    end
  end
end

function M:get_buff_type_map(buff_type)
  return self.v_buff_type_map[buff_type]
end

function M:check_borrow_money_map(item_id)
  return self.v_borrow_money_map[item_id] or 0
end

function M:clear()
  self.v_battle_buff_list = {}
  self.v_buff_type_map = {}
  self.v_borrow_money_map = {}
end

return M
