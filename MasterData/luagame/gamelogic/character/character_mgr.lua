local Base = require("gamelogic.base_system")
local UnityTime = UnityEngine.Time
local _tinsert = table.insert
local _list_delete_func = UtilTable.list_delete_by_func
local M = Util.create_child_mt(Base)
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local TRIGGER_SOUND_TYPE = CHARACTER_CONFIG.TRIGGER_SOUND_TYPE
local LAST_SELECT_BUDDY_IDX_TYPE = CHARACTER_CONFIG.LAST_SELECT_BUDDY_IDX_TYPE
local SOUND_STATUS = Config.SOUND_STATUS
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local RES2MAX = FightDefine.RES2MAX
local NAME2ATTR = FightDefine.CONFIG_NAME_ATTR_ID
local CombatEffectiveness = require("cs_share.combat_effectiveness")
local UtilTable = require("utils.util_table")
local LocalStorage = require("utils.localstorage")
local CommonDefine = require("cs_share.common_define")
local ACTY_TYPE = CommonDefine.ACTY_TYPE
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_TYPE_TO_SYSID = ActivityCfg.ACTY_TYPE_TO_SYSID
local LocalStorage = require("utils.localstorage")
local AttributeDefine = ShareRes.create("buddy.attribute_define")
local HIDE_LANGUAGE_TYPE = {
  [1] = "CN",
  [2] = "EN",
  [3] = "JP",
  [4] = "KR"
}
M.HideCvMap = {
  [100100930] = true,
  [100100931] = true,
  [100100932] = true
}

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_SHOW_UI, self.check_is_clear_temp_data_test, self)
  self:sys_mq_bind(Const.MSG_ON_DAILY_RESET, self.on_daily_reset, self)
  self:reset_data()
end

function M:on_reconnect()
  self:reset_data()
end

function M:check_is_clear_temp_data_test(msg)
  local ui_name = msg.mm_obj
  if "uimain" == ui_name then
    self:reset_temp_data()
    self:set_card_show_data()
    self:set_show_all_buddy_temp()
  end
end

function M:reset_temp_data()
  self.v_is_drop = false
  self:set_screen_condtion(1)
  self:set_last_select_buddy_id()
  self:set_aid_data()
  self:set_last_select_page()
end

local WEAPON_LOCK = {NOT_LOCK = 0, LOCK = 1}

function M:reset_data()
  self.v_res_list = {}
  self.filter_cache_data = {}
  self.occupation_cache_data = {}
  self.res_attr_cache_data = {}
  self.v_buddy_trigger_sound_map = {}
  self.v_change_fight_val_id = {}
  self.v_report_npc_dict = {}
  self.v_new_buddy_map = {}
end

local function get_attr_value(base_attr, upgrade_attr, lv, key, advance_cfg)
  local advance_val = advance_cfg and advance_cfg[key] or 0
  local base_val = base_attr[key] or 0
  if not upgrade_attr[key] then
    return base_val + advance_val
  end
  local attr_val = math.floor(base_val + upgrade_attr[key] * lv)
  attr_val = attr_val + advance_val
  return attr_val
end

local function _refresh_buddy_attr(buddy_info)
  buddy_info.attrs = M.cal_buddy_attr(buddy_info.id, buddy_info.break_lv, buddy_info.lv, buddy_info.advance, buddy_info.talent_lv)
end

local function _refresh_equip_attr(equip_info)
  equip_info.attrs = M.cal_equip_attr(equip_info.id, equip_info.break_lv, equip_info.lv)
end

local sort_list = {
  [CHARACTER_CONFIG.ESORT_TYPE.lv] = {
    "sort_index",
    "lv",
    "quality",
    "advance"
  },
  [CHARACTER_CONFIG.ESORT_TYPE.quality] = {
    "sort_index",
    "quality",
    "lv",
    "advance"
  },
  [CHARACTER_CONFIG.ESORT_TYPE.advance] = {
    "sort_index",
    "advance",
    "lv",
    "quality"
  }
}

local function sort_buddy_list(type, a, b, dec_sort)
  local sort_data = sort_list[type]
  for _, sort_key in ipairs(sort_data) do
    if a[sort_key] ~= b[sort_key] then
      if dec_sort then
        return a[sort_key] > b[sort_key]
      else
        return a[sort_key] < b[sort_key]
      end
    end
  end
  return a.id < b.id
end

function M.cal_buddy_attr(id, break_lv, lv, advance_lv, talent_lv)
  advance_lv = advance_lv or 1
  local buddy_data = {
    id = id,
    break_lv = break_lv,
    advance = advance_lv,
    lv = lv,
    talent_lv = talent_lv
  }
  local base_attr = CHARACTER_CONFIG.get_buddy_base_attr(id, buddy_data)
  local attr_list = CHARACTER_CONFIG.correction_attr(base_attr)
  local show_buddy_attr_cfg = ShareRes.get_show_buddy_attr_cfg(id)
  local show_attrs = {}
  local name_key
  for _, attr_id in ipairs(show_buddy_attr_cfg.BaseAttr) do
    name_key = AttributeDefine[attr_id].Name
    show_attrs[name_key] = Util.round(attr_list[attr_id] or 0)
  end
  return show_attrs, attr_list
end

function M.cal_equip_attr(id, break_lv, lv)
  local attr_list = M.cal_equip_attr_no_floor(id, break_lv, lv)
  local attr_key_tab = {
    hp = Util.round(attr_list.hp),
    energy = Util.round(attr_list.energy),
    attack = Util.round(attr_list.attack),
    penetrate = Util.round(attr_list.penetrate or 0),
    crit_atk_per = Util.round(attr_list.crit_atk_per or 0),
    defense = Util.round(attr_list.defense or 0)
  }
  return attr_key_tab
end

local function get_attr_value_no_floor(base_attr, upgrade_attr, lv, key)
  if not upgrade_attr[key] then
    return base_attr[key]
  end
  local attr_val = base_attr[key] + upgrade_attr[key] * lv
  return attr_val
end

function M.get_equip_advance_add_fixed_attr(id, advance_lv, check_ratio)
  local advance_cfg = ShareRes.create("equip.equip_advance", id)
  local skill_id = advance_cfg[advance_lv].SkillId
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  local no_attr = 0 == skill_cfg.AttrId or 0 == skill_cfg.AttrValue
  if no_attr then
    return
  end
  local is_ratio = 1 == skill_cfg.AttrType
  if not check_ratio and is_ratio then
    return
  end
  return skill_cfg.AttrId, skill_cfg.AttrValue, is_ratio
end

function M.cal_equip_attr_no_floor(id, break_lv, lv)
  local last_break_lv = break_lv - 1
  local last_max_lv = last_break_lv > 0 and ShareRes.get_equip_max_level(last_break_lv) or 0
  lv = lv - last_max_lv
  local base_attr_cfg = ShareRes.create("equip.equip_base_attr", id)
  assert(base_attr_cfg, "Weapon Config Error" .. id)
  local upgrade_attr_cfg = ShareRes.create("equip.equip_upgrade_attr", id)
  local base_attr = base_attr_cfg[break_lv]
  local upgrade_attr = upgrade_attr_cfg[break_lv]
  if not base_attr or not upgrade_attr then
    Log.Error("获取武器属性失败, id、break_lv、lv:", id, break_lv, lv)
    return
  end
  assert(base_attr, "break_lv base_attr is nil, equip_id = " .. id .. ", break lv = " .. break_lv)
  assert(upgrade_attr, "break_lv upgrade_attr is nil, equip_id = " .. id .. ", break lv = " .. break_lv)
  local hp = get_attr_value_no_floor(base_attr, upgrade_attr, lv, "hp")
  local energy = get_attr_value_no_floor(base_attr, upgrade_attr, lv, "energy")
  local attack = get_attr_value_no_floor(base_attr, upgrade_attr, lv, "attack")
  local penetrate = get_attr_value_no_floor(base_attr, upgrade_attr, lv, "penetrate")
  local crit_atk_per = get_attr_value_no_floor(base_attr, upgrade_attr, lv, "crit_atk_per")
  local defense = get_attr_value_no_floor(base_attr, upgrade_attr, lv, "defense")
  local attr_key_tab = {
    hp = hp,
    energy = energy,
    attack = attack,
    penetrate = penetrate,
    crit_atk_per = crit_atk_per,
    defense = defense
  }
  local attr_id_tab = {
    [ATTR_TYPE.CHAR_HP] = hp,
    [ATTR_TYPE.CHAR_SP] = energy,
    [ATTR_TYPE.CHAR_ATTACK] = attack,
    [ATTR_TYPE.CHAR_PENETRATE] = penetrate,
    [ATTR_TYPE.CHAR_CRIT_ATK_PER] = crit_atk_per,
    [ATTR_TYPE.CHAR_DEFENSE] = defense
  }
  return attr_key_tab, attr_id_tab
end

function M:cal_angrave_add_attr(buddy_id, attr_id, cur_val)
  local refine = self:get_engrave_info(buddy_id)
  local add_attr_val = 0
  if not refine then
    return add_attr_val
  end
  local add_attr_list = ShareRes.get_buddy_engrave_attr_list(buddy_id, refine.lv)
  if not add_attr_list then
    return add_attr_val
  end
  for _, info in pairs(add_attr_list) do
    if info[1] == attr_id then
      add_attr_val = add_attr_val + info[2]
      break
    end
  end
  local entry_id = refine.entry_id
  if entry_id then
    local cur_entry_cfg = ShareRes.create("buddy.buddy_refine_entry", entry_id)
    local entry_add_attr = cur_entry_cfg.EffectList
    for _, entry_info in pairs(entry_add_attr) do
      if entry_info[1] == attr_id then
        local add_val = add_attr_val + entry_info[2]
        add_attr_val = add_attr_val + add_val
        break
      end
    end
  end
  return add_attr_val
end

function M.cal_potential_add_attr(buddy_id, pontential_lv)
  local upgrade_advance_attr = ShareRes.create("buddy.buddy_upgrade_advance_attr")
  local all_advance_attr_cfg = upgrade_advance_attr[buddy_id]
  local attr_add_list = {}
  if all_advance_attr_cfg then
    for lv = 1, pontential_lv do
      local advance_attr_cfg = all_advance_attr_cfg[lv]
      if advance_attr_cfg then
        for attr_name, add_val in pairs(advance_attr_cfg) do
          local attr_id = NAME2ATTR[attr_name]
          if attr_id then
            if not attr_add_list[attr_id] then
              attr_add_list[attr_id] = 0
            end
            attr_add_list[attr_id] = attr_add_list[attr_id] + add_val
          end
        end
      end
    end
  end
  return attr_add_list
end

function M.cal_talent_add_attr(buddy_id, talent_lv)
  local upgrade_talent_cfg = ShareRes.create("buddy.buddy_talent_new_attr")[buddy_id]
  local attr_add_list = {}
  if upgrade_talent_cfg then
    for lv = 1, talent_lv do
      local talent_lv_cfg = upgrade_talent_cfg[lv]
      if talent_lv_cfg then
        for attr_name, add_val in pairs(talent_lv_cfg) do
          local attr_id = NAME2ATTR[attr_name]
          if attr_id then
            attr_add_list[attr_id] = (attr_add_list[attr_id] or 0) + add_val
          end
        end
      end
    end
  end
  return attr_add_list
end

function M:get_talent_attr_desc(buddy_id, lv)
  local lv_cfg = ShareRes.get_buddy_talent_attr(buddy_id, lv)
  if not lv_cfg then
    return
  end
  local attr_id = lv_cfg.AttrId
  local attr_val = lv_cfg.AttrValue
  if attr_id and 0 ~= attr_val then
    local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
    if not attr_cfg then
      Log.Error("ATTR_CFG NULL = " .. attr_id)
      return
    end
    local is_ration = ShareRes.get_is_ration_attr(attr_id)
    if 1 == lv_cfg.AttrType then
      is_ration = true
    end
    if is_ration then
      return string.format("%s +%.2f%%", attr_cfg.AttrName, attr_val / 100)
    else
      return string.format("%s +%s", attr_cfg.AttrName, attr_val)
    end
  end
end

function M.get_buddy_lvMax_need_cost_data(buddy_info)
  local need_exp = M.get_buddy_lvmax_need_exp(buddy_info)
  if not need_exp then
    return {}
  end
  local item_data = {}
  local levelup_items = ShareRes.create("buddy.buddy_exp")
  for _, item_info in pairs(levelup_items) do
    local item_num = BagMgr:get_item_num(item_info.Id)
    if item_num > 0 then
      local item_cfg = ShareRes.create("item.item", item_info.Id)
      _tinsert(item_data, {
        item_info.Id,
        item_cfg.Arg[1]
      })
    end
  end
  table.sort(item_data, function(a, b)
    return a[2] > b[2]
  end)
  local cost_data = {}
  cost_data = M.get_exp_costdata(item_data, cost_data, need_exp, buddy_info, false)
  local coin_not_enough = #item_data > 0 and 0 == #cost_data
  return cost_data, coin_not_enough
end

function M.get_buddy_cost_item_num(cost_data, add_item_id, add_num, last_add_exp, buddy_info)
  local buddy_id = buddy_info.id
  local break_lv = buddy_info.break_lv
  local level = buddy_info.lv
  local level_info = M.get_level_info(CharacterMgr, buddy_id)
  local max_level = ShareRes.get_buddy_max_level(break_lv)
  local target_level = level
  local quick_add_exp = buddy_info.exp + last_add_exp
  local use_num = M.get_use_item_num(add_item_id, add_num, level_info, level, max_level, target_level, quick_add_exp)
  return use_num
end

function M.get_equip_lvMax_need_cost_data(equip_info)
  local need_exp = M.get_equip_lvmax_need_exp(equip_info)
  if not need_exp then
    return {}
  end
  local item_data = {}
  local levelup_items = ShareRes.create("equip.equip_exp")
  for _, item_info in pairs(levelup_items) do
    local item_num = BagMgr:get_item_num(item_info.Id)
    local item_cfg = ShareRes.create("item.item", item_info.Id)
    if item_num > 0 then
      _tinsert(item_data, {
        item_info.Id,
        item_cfg.Arg[1]
      })
    end
  end
  table.sort(item_data, function(a, b)
    return a[2] > b[2]
  end)
  local cost_data = {}
  cost_data = M.get_exp_costdata(item_data, cost_data, need_exp, equip_info, true)
  local coin_not_enough = #item_data > 0 and 0 == #cost_data
  return cost_data, coin_not_enough
end

function M.get_equip_cost_item_num(cost_data, add_item_id, add_num, last_add_exp, equip_info)
  if add_num <= 0 then
    return
  end
  local break_lv = equip_info.break_lv
  local level = equip_info.lv
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local level_info = ShareRes.get_equip_lv_up_cfg(quality)[break_lv]
  local max_level = ShareRes.get_equip_max_level(break_lv)
  local target_level = level
  local quick_add_exp = equip_info.exp + last_add_exp
  local use_num = M.get_use_item_num(add_item_id, add_num, level_info, level, max_level, target_level, quick_add_exp)
  return use_num
end

function M.get_use_item_num(add_item_id, add_num, level_info, level, max_level, target_level, quick_add_exp)
  local coin_num = CharacterMgr:get_coin() or 0
  local item_cfg = ShareRes.create("item.item", add_item_id)
  local add_exp = item_cfg.Arg[1]
  local use_num = 0
  for i = 1, add_num do
    local new_add_exp = quick_add_exp + add_exp * i
    local _target_level, need_coin = CharacterMgr.cal_exp_target_info(level_info, level, max_level, target_level, new_add_exp)
    if coin_num >= need_coin then
      use_num = i
    else
      break
    end
    if max_level <= _target_level then
      break
    end
  end
  return use_num
end

function M.get_exp_costdata(item_data, cost_data, need_exp, add_obj_info, is_equip)
  local last_add_exp = 0
  for i, cfg in ipairs(item_data) do
    local item_num = BagMgr:get_item_num(cfg[1])
    if item_num then
      local need_num = math.ceil(need_exp / cfg[2])
      local use_num = item_num
      if add_obj_info then
        if is_equip then
          use_num = M.get_equip_cost_item_num(cost_data, cfg[1], item_num, last_add_exp, add_obj_info)
        else
          use_num = M.get_buddy_cost_item_num(cost_data, cfg[1], item_num, last_add_exp, add_obj_info)
        end
      end
      if use_num > 0 then
        local dec_val = need_num
        if need_num > use_num then
          dec_val = use_num
        end
        local use_items = {
          id = cfg[1],
          count = dec_val
        }
        _tinsert(cost_data, use_items)
        if need_exp - dec_val * cfg[2] <= 0 then
          break
        end
        last_add_exp = last_add_exp + dec_val * cfg[2]
        need_exp = need_exp - dec_val * cfg[2]
      end
    end
  end
  return cost_data
end

function M.get_buddy_lvmax_need_exp(buddy_info)
  local lv = buddy_info.lv
  local exp = buddy_info.exp
  local break_lv = buddy_info.break_lv
  local buddy_level_cfgs = ShareRes.create("buddy.buddy_level")
  local level_info = buddy_level_cfgs[break_lv]
  local max_level = ShareRes.get_buddy_max_level(break_lv)
  local need_exp = 0 - exp
  local star_lv = lv + 1
  if max_level < star_lv then
    return
  end
  for i = star_lv, max_level do
    local lv_exp = level_info[i].Exp
    need_exp = need_exp + lv_exp
  end
  return need_exp
end

function M.get_equip_lvmax_need_exp(equip_info)
  local lv = equip_info.lv
  local exp = equip_info.exp
  local break_lv = equip_info.break_lv
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local all_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_level_cfgs = all_level_cfgs[equip_info.break_lv]
  local max_level = ShareRes.get_equip_max_level(break_lv)
  local need_exp = 0 - exp
  local star_lv = lv + 1
  if max_level < star_lv then
    return
  end
  for i = star_lv, max_level do
    local lv_exp = equip_level_cfgs[i].Exp
    need_exp = need_exp + lv_exp
  end
  return need_exp
end

function M:on_get_buddy_list(buddy_list)
  self.v_buddys = buddy_list
  self.v_buddy_map = {}
  for _, buddy in pairs(self.v_buddys) do
    buddy.quality = ShareRes.get_buddy_cfg(buddy.id).Quality
    self.v_buddy_map[buddy.id] = buddy
    _refresh_buddy_attr(buddy)
  end
end

function M:get_buddy_skill_by_id(buddy_id)
  return self.v_buddy_map[buddy_id].lSkill
end

function M:on_get_buddy_info(buddy_info)
  self:update_buddy_archive_red_point(buddy_info)
  buddy_info.quality = ShareRes.get_buddy_cfg(buddy_info.id).Quality
  self.v_buddy_map[buddy_info.id] = buddy_info
  _refresh_buddy_attr(buddy_info)
  local is_have_buddy = false
  for idx, buddy in pairs(self.v_buddys) do
    if buddy.uuid == buddy_info.uuid then
      self.v_buddys[idx] = buddy_info
      is_have_buddy = true
      break
    end
  end
  if not is_have_buddy then
    table.insert(self.v_buddys, buddy_info)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_BUDDY_DATA_UPDATE)
  msg.mm_x = buddy_info.id
  MsgGame:mq_publish2(Const.MSG_REFRESH_CHARACTER_ENTRY_RED)
  self:update_buddy_red(buddy_info.id)
end

function M:get_buddy_screen_data()
  return self.filter_cache_data, self.occupation_cache_data, self.res_attr_cache_data
end

function M:get_buddy_sort_cache_type()
  return self.v_buddy_sort_type
end

function M:on_buddy_to_advance_item(data)
  MsgGame:mq_publish2(Const.MSG_ON_BUDDY_TO_ADVANCE_ITEM)
end

function M:check_potential_red(buddy_id)
  if self.v_not_show_sys_red then
    return false
  end
  local is_red = true
  if buddy_id then
    return self:check_buddy_advance(buddy_id)
  end
  for buddy_id, _ in pairs(self.v_buddy_map) do
    if self:check_buddy_advance(buddy_id) then
      return true
    end
  end
  return false
end

function M:check_buddy_advance(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  assert(buddy_info, "NO BUDDY INFO " .. buddy_id)
  local advance_lv = buddy_info.advance
  local advance_cfg = ShareRes.create("buddy.buddy_advance", buddy_id)
  assert(advance_cfg, "没有该角色升阶配置 buddy_id = " .. buddy_id)
  assert(advance_cfg[advance_lv], "没有该角色升阶等级配置 buddy_id =  " .. buddy_id)
  local cur_cfg = advance_cfg[advance_lv]
  local max_lv = #advance_cfg
  if advance_lv >= max_lv then
    return false
  end
  local next_cost_item_id = cur_cfg.CostId
  local next_cost_item_num = cur_cfg.CostCnt
  local item_num = BagMgr:get_item_num(next_cost_item_id)
  if next_cost_item_num <= item_num then
    return true
  end
end

function M:get_max_advance_need_mat(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  if not buddy_info then
    return nil
  end
  local advance_lv = buddy_info.advance
  local advance_cfg = ShareRes.create("buddy.buddy_advance", buddy_id)
  if not advance_cfg or not advance_cfg[advance_lv] then
    Log.Error("没有该角色升阶配置 buddy_id = " .. buddy_id)
    return 0
  end
  local max_lv = #advance_cfg
  local need_cost_item_id = advance_cfg[advance_lv].CostId
  local need_count = 0
  advance_lv = advance_lv + 1
  while max_lv >= advance_lv do
    local cfg = advance_cfg[advance_lv]
    if not cfg then
      break
    end
    need_count = need_count + cfg.CostCnt
    advance_lv = advance_lv + 1
  end
  local item_num = BagMgr:get_item_num(need_cost_item_id)
  return need_count - item_num
end

function M:update_equip_num_cache(equip_id, change_num)
  local update_all
  if not equip_id then
    update_all = true
    self.equip_num_cache = {}
  end
  local cahce = self.equip_num_cache
  if update_all then
    for _, equip in pairs(self.v_equip_list) do
      local id = equip.id
      cahce[id] = cahce[id] and cahce[id] + 1 or 1
    end
  else
    cahce[equip_id] = cahce[equip_id] and cahce[equip_id] + change_num or change_num
  end
end

function M:on_get_equip_list(equip_list)
  self.v_equip_list = equip_list
  self:update_equip_num_cache()
  self.v_equip_map = {}
  for _, equip in pairs(equip_list) do
    self.v_equip_map[equip.uuid] = equip
    _refresh_equip_attr(equip)
  end
  MsgGame:mq_publish2(Const.MSG_ROLE_WEAPENLIST_CHANGE)
end

function M:on_get_equip(equip_info)
  self.v_equip_map[equip_info.uuid] = equip_info
  _refresh_equip_attr(equip_info)
  local flag = false
  for idx, equip in pairs(self.v_equip_list) do
    if equip.uuid == equip_info.uuid then
      self.v_equip_list[idx] = equip_info
      flag = true
      break
    end
  end
  if not flag then
    _tinsert(self.v_equip_list, equip_info)
    self:update_equip_num_cache(equip_info.id, 1)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ROLE_WEAPENLIST_CHANGE)
  msg.mm_obj = equip_info
end

function M:on_delete_equip(data)
  local equip_info = self.v_equip_map[data.uuid]
  self:update_equip_num_cache(equip_info.id, -1)
  self.v_equip_map[data.uuid] = nil
  _list_delete_func(self.v_equip_list, function(equip)
    return equip.uuid == data.uuid
  end)
  MsgGame:mq_publish2(Const.MSG_ROLE_WEAPENLIST_CHANGE)
end

function M:on_delete_equip_list(msg)
  if not msg.uuid_list then
    return
  end
  for i, uuid in pairs(msg.uuid_list) do
    local equip_info = self.v_equip_map[uuid]
    self:update_equip_num_cache(equip_info.id, -1)
    self.v_equip_map[uuid] = nil
    _list_delete_func(self.v_equip_list, function(equip)
      return equip.uuid == uuid
    end)
  end
  MsgGame:mq_publish2(Const.MSG_ROLE_WEAPENLIST_CHANGE)
end

function M:on_res_update(data)
  if next(data) == nil then
    return
  end
  self.v_res_list = self.v_res_list or {}
  local id = data.id
  self.v_res_list[id] = data.count
  if id == Config.COIN_ITEMID then
    MsgGame:mq_publish2(Const.MSG_ON_COIN_UPDATE)
  elseif id == Config.DIAMOND_ITEMID then
    MsgGame:mq_publish2(Const.MSG_ON_DIAMOND_UPDATE)
  elseif id == Config.PLAYER_SP_ITEMID or id == BagMgr.RES_ENUM.BUILDING_STAMINA then
    MsgGame:mq_publish2(Const.MSG_ON_PLAYER_SP_UPDATE)
  elseif id == Config.DP_ITEMID then
    MsgGame:mq_publish2(Const.MSG_ON_DP_UPDATE)
  elseif id == Config.GILTGOLD_ITEMID then
    MsgGame:mq_publish2(Const.MSG_ON_GOLD_UPDATE)
  end
  MsgGame:mq_publish2(Const.MSG_ROLE_RES_CHANGE)
end

function M:on_res_list(res_data)
  for _, data in pairs(res_data.res_list) do
    self.v_res_list[data.id] = data.count
  end
end

function M:equip_lock(equip_uuid, callback)
  Network:protect_call("c2gs_equip_lock", {uuid = equip_uuid}, function(ok, resp)
    if ok then
      local equip_info = self:get_equip_info(equip_uuid)
      if not equip_info then
        return
      end
      if equip_info.lock == WEAPON_LOCK.LOCK then
        Util.show_message_tip(2071)
      else
        Util.show_message_tip(2063)
      end
      local msg = MsgGame:mq_publish2(Const.MSG_ON_UPDATE_EQUIP_LOCK)
      msg.mm_x = equip_uuid
      callback()
    end
  end)
end

function M:buddy_break(buddy_id, callback)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  Network:protect_call("c2gs_buddy_break", {
    id = buddy_info.id
  }, function(ok, resp)
    if ok then
      buddy_info.break_lv = resp.newlv
      if callback then
        callback(resp)
      end
      self.v_change_fight_val_id[buddy_info.id] = true
    end
  end)
end

function M:upgrade_buddy(buddy_id, items, callback)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  Network:protect_call("c2gs_buddy_upgrade", {
    id = buddy_info.id,
    cost = items
  }, function(ok, resp)
    if ok then
      local lv_up = resp.newlv > buddy_info.lv
      buddy_info.lv = resp.newlv
      callback(lv_up)
      if lv_up then
        MsgGame:mq_publish2(Const.MSG_ON_CHAPTER_UPDATE)
        self.v_change_fight_val_id[buddy_info.id] = true
      end
      self:trigger_buddy_sound(TRIGGER_SOUND_TYPE.LV_UP, buddy_info.id)
    else
      Log.Info("角色升级消耗出现错误---消耗数据 = ", items)
      for _, data in pairs(items) do
        local item_id = data.id
        local num = data.count
        local cur_num = BagMgr:get_item_num(item_id)
        Log.Info("背包数据 id = ", item_id, "数量 = ", cur_num)
      end
    end
  end)
end

function M:upgrade_buddy_onekey(buddy_index, callback)
  local buddy_info = self.v_buddys[buddy_index]
  Network:protect_call("c2gs_buddy_onekey_upgrade", {
    id = buddy_info.id
  }, function(ok, resp)
    if ok then
      local lv_up = resp.newlv > buddy_info.lv
      buddy_info.lv = resp.newlv
      callback(lv_up)
    end
  end)
end

function M:equip_break(equip_uuid, callback)
  local equip_info = self.v_equip_map[equip_uuid]
  Network:protect_call("c2gs_equip_break", {uuid = equip_uuid}, function(ok, resp)
    if ok then
      equip_info.lv = 1
      callback()
      self:update_equip_break_red(equip_uuid)
      self:update_equip_up_red(equip_uuid)
    end
  end)
end

function M:upgrade_equip(equip_uuid, items, callback, fail_callback)
  local equip_info = self.v_equip_map[equip_uuid]
  Network:protect_call("c2gs_equip_upgrade", {uuid = equip_uuid, cost = items}, function(ok, resp)
    if ok then
      local lv_up = resp.newlv > equip_info.lv
      equip_info.lv = resp.newlv
      callback(lv_up)
      self:update_equip_up_red(equip_uuid)
      self:update_equip_break_red(equip_uuid)
    else
      fail_callback()
      Log.Error("武器升级消耗出现错误player_uuid,equip_uuid,items:", Global.player_uuid, equip_uuid, items)
    end
  end)
end

function M:advance_equip(equip_uuid, cost_uuid, callback)
  Network:protect_call("c2gs_equip_advance", {uuid = equip_uuid, cost_equip_uuid = cost_uuid}, function(ok, resp)
    if ok then
      self.v_equip_map[cost_uuid] = nil
      callback()
      self:update_equip_homology_red(equip_uuid)
    end
  end)
end

function M:advance_equip_new(equip_uuid, cost_uuid_list, cost_item_count, callback)
  local body = {
    uuid = equip_uuid,
    cost_equip_uuid_list = cost_uuid_list,
    cost_item_count = cost_item_count
  }
  Network:protect_call("c2gs_equip_advance_list", body, function(ok, resp)
    if ok then
      for i = 1, #cost_uuid_list do
        self.v_equip_map[cost_uuid_list[i]] = nil
      end
      callback()
      self:update_equip_homology_red(equip_uuid)
    end
  end)
end

function M:wear_equip(buddy_id, equip_uuid, callback)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  local uuid = buddy_info.uuid
  Network:protect_call("c2gs_wear_equip", {
    buddy_id = buddy_info.id,
    equip_uuid = equip_uuid
  }, function(ok, resp)
    if ok then
      callback()
      self:check_replace_weapon_red(equip_uuid)
    end
  end)
end

function M:upgrade_equip_onekey(equip_uuid, callback)
  local equip_info = self.v_equip_map[equip_uuid]
  Network:protect_call("c2gs_equip_onekey_upgrade", {uuid = equip_uuid}, function(ok, resp)
    if ok then
      equip_info.lv = resp.newlv
      callback()
    end
  end)
end

function M:clear_advance_red(buddy_index, skill_id, callback)
  local buddy_info = self.v_buddys[buddy_index]
  Network:protect_call("c2gs_buddy_clear_advance", {
    id = buddy_info.id,
    sk_id = skill_id
  }, function(ok, resp)
    if ok then
      callback()
    end
  end)
end

function M:upgrade_skill(buddy_id, skill_id, callback)
  local buddy_info = self.v_buddy_map[buddy_id]
  Network:protect_call("c2gs_buddy_skill_upgrade", {
    id = buddy_info.id,
    sk_id = skill_id
  }, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:upgrade_talent(buddy_id, callback)
  Network:protect_call("c2gs_buddy_talent_up_level", {buddy_id = buddy_id}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:char_advance(buddy_id, callback)
  Network:protect_call("c2gs_buddy_advance", {id = buddy_id}, function(ok, resp)
    if ok then
      _refresh_buddy_attr(self.v_buddy_map[buddy_id])
      callback()
    end
  end)
end

function M:get_virtural_list()
  return self.v_res_list
end

function M:get_coin()
  return self.v_res_list[Config.COIN_ITEMID] or 0
end

function M:get_diamond()
  return self.v_res_list[Config.DIAMOND_ITEMID] or 0
end

function M:get_res_val(res_id)
  return self.v_res_list[res_id] or 0
end

function M:get_buddy_list_show()
  local list = self.v_buddys
  local buddy_config = ShareRes.create("buddy.buddy")
  UtilTable.list_delete_by_func(list, function(info)
    return 1 == buddy_config[info.id].IsShow or not self:check_buddy_release(info.id)
  end)
  return list
end

function M:get_buddy_attr(idx)
  if idx > #self.v_buddys then
    return
  end
  return self.v_buddys[idx].attrs
end

function M:get_buddy_by_id(buddy_id)
  return self.v_buddy_map[buddy_id]
end

function M:get_buddy_map()
  return self.v_buddy_map
end

function M:get_buddy_id_by_idx(idx)
  if idx > #self.v_buddys then
    return
  end
  return self.v_buddys[idx].id
end

function M:get_buddy_info(idx)
  if self.v_buddys[idx] then
    return self.v_buddys[idx]
  else
    Log.Error("获取角色信息有问题,idx不对")
    return self.v_buddys[1]
  end
end

function M:get_equip_info(equip_uuid)
  return self.v_equip_map[equip_uuid]
end

function M:get_equip_list()
  return self.v_equip_list
end

function M:get_equip_num(equip_id)
  return self.equip_num_cache[equip_id] or 0
end

function M:is_equip_advance_max(equip_id)
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  local advance_max_lv = advance_cfg[#advance_cfg].Lv
  local total_advance = 0
  for _, equip in pairs(self.v_equip_list) do
    if equip_id == equip.id then
      total_advance = total_advance + equip.advance
      if advance_max_lv <= total_advance then
        return true
      end
    end
  end
  return false
end

function M:get_weapon_id(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  if not buddy_info then
    return
  end
  local equip_info = self:get_equip_info(buddy_info.weapon)
  if not equip_info then
    return
  end
  return equip_info.id
end

function M:get_buddy_icon_path(buddy_id, check_fashion)
  local fashion_id
  if check_fashion then
    fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  end
  return UtilUI.get_hero_images(buddy_id, 1, fashion_id)
end

function M:get_buddy_element_icon_path(buddy_id)
  local buddy_config = ShareRes.create("buddy.buddy", buddy_id)
  local element_id = buddy_config.Element
  local element_cfg = ShareRes.create("buddy.buddy_element", element_id)
  assert(element_cfg, "ERROR ELEMENT_CFG ID = " .. element_id)
  return element_cfg.ElementIconPath
end

function M:get_level_info(buddy_id)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return
  end
  local break_lv = buddy_info.break_lv
  local buddy_level_cfgs = ShareRes.create("buddy.buddy_level")
  local level_info = buddy_level_cfgs[break_lv]
  return level_info
end

function M:get_character_exp_info(buddy_id)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  local level_info = M.get_level_info(self, buddy_id)
  local get_lv = buddy_info.lv + 1
  local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  get_lv = math.min(get_lv, max_level)
  return buddy_info.exp, level_info[get_lv].Exp
end

function M:get_character_next_exp_info(id)
  local buddy_info = self:get_buddy_by_id(id)
  local level_info = M.get_level_info(self, id)
  return level_info[buddy_info.lv + 1].Exp
end

function M:get_buddy_lvup_costcoin(id, target_lv)
  local level_info = M.get_level_info(self, id)
  return level_info[target_lv].Coin
end

function M:get_equip_exp_info(equip_uuid, _equip_info)
  local equip_info = equip_uuid and self.v_equip_map[equip_uuid] or _equip_info
  local break_lv = equip_info.break_lv
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local equip_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_level_info = equip_level_cfgs[break_lv]
  local get_lv = equip_info.lv + 1
  local max_level = ShareRes.get_equip_max_level(break_lv)
  get_lv = math.min(get_lv, max_level)
  return equip_info.exp, equip_level_info[get_lv].Exp
end

function M:get_buddy_id_by_equip_uuid(uuid)
  local equip_info = self.v_equip_map[uuid]
  for i, v in ipairs(self.v_buddys) do
    if v.weapon == uuid then
      return v.id
    end
  end
end

function M:get_buddy_index_by_equip_uuid(uuid)
  local equip_info = self.v_equip_map[uuid]
  for i, v in ipairs(self.v_buddys) do
    if v.weapon == uuid then
      return i
    end
  end
end

function M:get_buddy_index_by_id(id)
  for i, v in ipairs(self.v_buddys) do
    if v.id == id then
      return i
    end
  end
end

function M:get_equip_next_exp_info(equip_uuid)
  local equip_info = self.v_equip_map[equip_uuid]
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local equip_break_cfg = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_level_cfgs = equip_break_cfg[equip_info.break_lv]
  return equip_level_cfgs[equip_info.lv].Exp
end

function M:get_buddy_skill_info_by_id(buddy_id, skill_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  if not buddy_info then
    return
  end
  local skill_list = buddy_info.lSkill
  for k, skill in pairs(skill_list) do
    if skill.id == skill_id then
      return skill
    end
  end
end

function M:is_equip_need_break(equip_uuid, _equip_info)
  local equip_info = equip_uuid and self.v_equip_map[equip_uuid] or _equip_info
  if not equip_info then
    return
  end
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local equip_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_level_info = equip_level_cfgs[equip_info.break_lv]
  return not equip_level_info[equip_info.lv + 1]
end

function M:check_equip_can_operation(equip_uuid, _equip_info)
  local equip_info = equip_uuid and self:get_equip_info(equip_uuid) or _equip_info
  if not equip_info then
    return
  end
  local break_lv = equip_info.break_lv
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local equip_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_level_info = equip_level_cfgs[break_lv + 1]
  if equip_level_info then
    return true
  end
  local max_level = ShareRes.get_equip_max_level(break_lv)
  if max_level <= equip_info.lv then
    return false
  end
  return true
end

function M:is_need_break(buddy_id)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return
  end
  local level_info = M.get_level_info(self, buddy_id)
  local lv = buddy_info.lv
  if level_info[lv + 1] then
    return
  else
    local buddy_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv + 1]
    if buddy_break_cfg then
      return true
    end
  end
  return false
end

function M.cal_exp_target_info(level_info, level, max_level, target_level, add_exp)
  local coin_cost = 0
  local sum = 0
  for lv = level + 1, max_level do
    sum = sum + level_info[lv].Exp
    if add_exp >= sum then
      target_level = lv
      coin_cost = coin_cost + level_info[lv].Coin
    else
      break
    end
  end
  return target_level, coin_cost
end

function M:get_add_exp_info(buddy_id, add_exp)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  local break_lv = buddy_info.break_lv
  local level = buddy_info.lv
  local level_info = M.get_level_info(self, buddy_id)
  local max_level = ShareRes.get_buddy_max_level(break_lv)
  local target_level = level
  add_exp = add_exp + buddy_info.exp
  return M.cal_exp_target_info(level_info, level, max_level, target_level, add_exp)
end

function M:get_equip_add_exp_info(equip, add_exp)
  local equip_info = self.v_equip_map[equip]
  local break_lv = equip_info.break_lv
  local level = equip_info.lv
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local level_info = ShareRes.get_equip_lv_up_cfg(quality)[break_lv]
  local max_level = ShareRes.get_equip_max_level(break_lv)
  local target_level = level
  add_exp = add_exp + equip_info.exp
  return M.cal_exp_target_info(level_info, level, max_level, target_level, add_exp)
end

function M:on_init_exchange_times(res_data)
  self.v_exchange_table = {}
  for index, info in ipairs(res_data.exchange_info) do
    self.v_exchange_table[info.exchange_id] = info.remaining_times
  end
end

function M:request_exchange_item(exchange_id, consume_times, callback)
  local params = {exchange_id = exchange_id, consume_times = consume_times}
  local exchange_config = ShareRes.get_item_exchange_cfg(exchange_id)
  local lMaterial = exchange_config.Material
  local nCostItemId = lMaterial[1]
  if nCostItemId == Config.DIAMOND_ITEMID and BagMgr:get_item_num(Config.GILTGOLD_ITEMID) < 0 then
    Util.show_notify_popup_message(nil, Util.get_tips_with_error_code(2366), "提示", "确定", nil, nil, true)
    return
  end
  Network:protect_call("c2gs_exchange_virtual_res", params, function(ok, resp)
    if ok then
      MsgGame:mq_publish2(Const.MSG_ON_EXCHANGE_ITEM_SUC)
      self.v_exchange_table[exchange_id] = resp.remaining_times
      if callback then
        callback()
      end
    end
  end)
end

function M:get_exchange_remain_time(exchange_id)
  return self.v_exchange_table[exchange_id]
end

function M:get_exchange_config(exchange_type, targetId, MaterialId)
  local item_exchange_config = ShareRes.create("item.item_exchange")
  local exchange_type_config = ShareRes.create("item.exchange_type", exchange_type)
  for index, config in pairs(item_exchange_config) do
    if config.Id >= exchange_type_config.IdBegin and config.Id <= exchange_type_config.IdEnd and config.TargetId == targetId and MaterialId == config.Material[1] then
      return config
    end
  end
end

function M:get_exchange_config_by_target_id(exchange_type, targetId)
  local item_exchange_config = ShareRes.create("item.item_exchange")
  local exchange_type_config = ShareRes.create("item.exchange_type", exchange_type)
  for index, config in pairs(item_exchange_config) do
    if config.Id >= exchange_type_config.IdBegin and config.Id <= exchange_type_config.IdEnd and config.TargetId == targetId then
      return config
    end
  end
end

function M:get_res_force_max_val()
  local role_lv = PlayerMgr:get_role_lv()
  local player_upgrade_config = ShareRes.create("player.player_upgrade")
  for _, data in pairs(player_upgrade_config) do
    if role_lv == data.Level then
      return data.RecLimit
    end
  end
  return 0
end

function M:set_last_select_buddy_id(buddy_id)
  self.v_last_select_buddy_id = buddy_id
end

function M:set_last_select_page(page)
  self.v_last_select_page = page
end

function M:get_last_select_page()
  return self.v_last_select_page
end

function M:get_buddy_archive_data(buddy_id)
  for idx, buddy in pairs(self.v_buddys) do
    if buddy.id == buddy_id then
      return self.v_buddys[idx].lArchives
    end
  end
end

function M:on_buddy_archives_add(data)
  for idx, buddy in pairs(self.v_buddys) do
    if buddy.id == data.id then
      for k, v in pairs(data.archive_id) do
        table.insert(buddy.lArchives, {state = 1, archive_id = v})
      end
      return
    end
  end
end

function M:on_update_archive_state(buddy_id, archive_id, cb)
  Network:protect_call("c2gs_buddy_archives_change", {id = buddy_id, archive_id = archive_id}, function(ok)
    if ok and cb then
      self:_refresh_archive_state(buddy_id, archive_id)
      cb()
      self:on_update_archive_info_red(buddy_id)
    end
  end)
end

function M:req_read_buddy_voice(voice_id, buddy_id, cb)
  Network:protect_call("c2gs_read_buddy_voice", {voice_id = voice_id}, function(ok)
    if ok then
      self.v_voice_list[voice_id].is_read = true
      self:on_update_archive_voice_red(buddy_id)
      if cb then
        cb()
      end
    end
  end)
end

function M:on_get_all_buddy_voice_info(data)
  self.v_voice_list = data.voice_info or {}
end

function M:is_have_unread_buddy_voice(buddy_id)
  for _, info in pairs(self.v_voice_list) do
    local voice_cfg = ShareRes.get_buddy_voice_cfg(info.voice_id)
    if not voice_cfg then
    elseif voice_cfg.HeroId == buddy_id and info.is_read == false then
      return true
    end
  end
  return false
end

function M:unlock_new_buddy_voice(data)
  self.v_voice_list[data.voice_id] = {}
  self.v_voice_list[data.voice_id].voice_id = data.voice_id
  self.v_voice_list[data.voice_id].is_read = false
  if not self.HideCvMap[data.voice_id] then
    local voice_cfg = ShareRes.get_buddy_voice_cfg(data.voice_id)
    self:active_red(RedEnum.CHAR_CV_VOICE, voice_cfg.HeroId)
  end
end

function M:on_update_archive_info_red(buddy_id)
  local is_show_red = false
  local archive_list = self.v_buddy_map[buddy_id].lArchives
  for id, info in pairs(archive_list) do
    if 0 == info.state then
      is_show_red = true
      break
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_CV_INFO, is_show_red)
end

function M:on_update_archive_voice_red(buddy_id)
  local is_show_red = false
  if self.v_voice_list then
    for _, info in pairs(self.v_voice_list) do
      local voice_cfg = ShareRes.get_buddy_voice_cfg(info.voice_id)
      if not voice_cfg then
        Log.Error("角色-角色语音表中无此音效Id:", info.voice_id)
        return false
      end
      if not info.is_read and voice_cfg.HeroId == buddy_id then
        is_show_red = true
        break
      end
    end
  end
  return is_show_red
end

function M:_refresh_archive_state(buddy_id, refresh_id)
  local archive_data = self:get_buddy_archive_data(buddy_id)
  for _, data in pairs(archive_data) do
    local archive_id = data.archive_id
    if refresh_id == archive_id then
      data.state = 1
      break
    end
  end
end

function M:trigger_buddy_sound(trigger_type, buddy_id, call_back)
  local trigger_cfg = ShareRes.get_buddy_trigger_sound_cfg(trigger_type, buddy_id)
  if not trigger_cfg then
    return
  end
  local now_time = UnityTime.realtimeSinceStartup
  self.v_buddy_trigger_sound_map[trigger_type] = self.v_buddy_trigger_sound_map[trigger_type] or {}
  local trigger_data = self.v_buddy_trigger_sound_map[trigger_type]
  local buddy_record = trigger_data[buddy_id]
  local sound_index = trigger_cfg.SoundId
  local sound_id = self:get_trigger_sound_id(sound_index)
  if CHARACTER_CONFIG.CHECK_SOUND_PLAY_STATUS[trigger_type] then
    if Global.sound_mgr:check_source_play_status(SOUND_STATUS.PLAYING, nil, sound_id) then
      if buddy_record then
        buddy_record.trigger_time = now_time
      end
      return
    end
  else
    local _, _, sound_type = ShareRes.get_play_sound_info(sound_id)
    Global.sound_mgr:stop_sound_by_type(sound_type)
  end
  local cd = trigger_cfg.CDTime
  if not buddy_record then
    buddy_record = {trigger_time = now_time}
    self:play_buddy_trigger_sound(sound_index, call_back)
    trigger_data[buddy_id] = buddy_record
  else
    if cd > now_time - buddy_record.trigger_time then
      return
    end
    buddy_record.trigger_time = now_time
    self:play_buddy_trigger_sound(sound_index, call_back)
  end
end

function M:stop_buddy_sound(trigger_type, buddy_id)
  local trigger_cfg = ShareRes.get_buddy_trigger_sound_cfg(trigger_type, buddy_id)
  if not trigger_cfg then
    return
  end
  local sound_index = trigger_cfg.SoundId
  local sound_id = self:get_trigger_sound_id(sound_index)
  local _, _, sound_type = ShareRes.get_play_sound_info(sound_id)
  Global.sound_mgr:stop_sound_by_type(sound_type)
end

function M:get_trigger_sound_id(sound_index)
  local buddy_cv_cfg = ShareRes.get_buddy_cv_config(sound_index)
  if not buddy_cv_cfg then
    return
  end
  local sound_id = buddy_cv_cfg.ChineseSound
  return sound_id
end

function M:get_trigger_sound_txt(sound_index)
  local buddy_cv_cfg = ShareRes.get_buddy_cv_config(sound_index)
  return buddy_cv_cfg and buddy_cv_cfg.ChineseSoundTxt
end

function M:get_trigger_sound_idx(trigger_type, buddy_id)
  local trigger_cfg = ShareRes.get_buddy_trigger_sound_cfg(trigger_type, buddy_id)
  return trigger_cfg and trigger_cfg.SoundId
end

function M:play_buddy_trigger_sound(sound_index, call_back)
  if not Global.sound_mgr then
    return
  end
  local sound_id = self:get_trigger_sound_id(sound_index)
  Global.sound_mgr:play_sound_by_id(sound_id, nil, call_back)
end

function M:cal_double_arry_sum(array1, array2)
  local length1 = UtilTable.hash_lenth(array1)
  local length2 = UtilTable.hash_lenth(array2)
  if length1 >= length2 then
    for index, value in pairs(array2) do
      local realId = RES2MAX[index] or index
      if array1[realId] then
        array1[realId] = array1[realId] + value
      end
    end
    return array1
  else
    for index, value in pairs(array1) do
      local realId = RES2MAX[index] or index
      if array2[realId] then
        array2[realId] = array2[realId] + value
      end
    end
    return array2
  end
end

function M.get_buddy_skill_list_by_id(skill_list)
  local skill_list_new = {}
  for _, skill in pairs(skill_list) do
    skill_list_new[skill.id] = skill.lv
  end
  return skill_list_new
end

function M:get_buddy_combat_effectiveness(buddy_id, is_fixed_point, fixed_id)
  if is_fixed_point and fixed_id then
    local fixed_buddy_cfg = ShareRes.get_fixed_buddy_config(fixed_id)
    if not fixed_buddy_cfg then
      return 0
    end
    return fixed_buddy_cfg.Power
  else
    local buddy_info = self:get_buddy_by_id(buddy_id)
    if not buddy_info then
      return 0
    end
    return buddy_info.power or 0
  end
end

function M:build_gemstone_list(gemstone_slot)
  local gemstone_list = {}
  if not gemstone_slot or next(gemstone_slot) == nil then
    return gemstone_list
  end
  for i, gemstone_data in ipairs(gemstone_slot) do
    local uuid = gemstone_data.uuid
    if uuid and 0 ~= uuid then
      local data = GemStoneMgr:get_gem_data(uuid)
      if data then
        gemstone_list[#gemstone_list + 1] = {
          id = data.id,
          level = data.level
        }
      end
    end
  end
  return gemstone_list
end

function M:add_engrave(buddy_id, attr_list, entry_temp)
  local refine = self:get_engrave_info(buddy_id)
  if not refine then
    return
  end
  local add_attr_list = ShareRes.get_buddy_engrave_attr_list(buddy_id, refine.lv)
  if not add_attr_list then
    return
  end
  attr_list = self:add_engrave_attr(attr_list, add_attr_list)
  local entry_id = entry_temp and refine.temporary_entry_id or refine.entry_id
  if entry_id then
    local cur_entry_cfg = ShareRes.create("buddy.buddy_refine_entry", entry_id)
    local entry_add_attr = cur_entry_cfg.EffectList
    attr_list = self:add_engrave_attr(attr_list, entry_add_attr)
  end
end

function M:add_engrave_attr(attr_list, add_attr_list)
  for key, add_entry_attr_info in pairs(add_attr_list) do
    local add_attr_id = add_entry_attr_info[1]
    local add_attr_val = add_entry_attr_info[2]
    local add_attr_type = add_entry_attr_info[3]
    if 1 == add_attr_type then
      attr_list[add_attr_id] = attr_list[add_attr_id] + add_attr_val
    elseif 2 == add_attr_type then
      attr_list[add_attr_id] = attr_list[add_attr_id] * (1 + add_attr_val / 10000)
    end
  end
  return attr_list
end

function M:get_equip_attr(equip_id, equip_break_lv, equip_lv, advance_lv)
  local attr_list = M.cal_equip_attr_no_floor(equip_id, equip_break_lv, equip_lv)
  local advance_add_attr_id, advance_add_attr_val = M.get_equip_advance_add_fixed_attr(equip_id, advance_lv)
  local equip_attrs = {}
  for attr_key, attr_val in pairs(attr_list) do
    local attr_id = NAME2ATTR[attr_key]
    local attr_info = FightDefine.init_single_attr()
    if attr_id == advance_add_attr_id and advance_add_attr_val then
      attr_info.FIXED = attr_val + advance_add_attr_val
    else
      attr_info.FIXED = attr_val
    end
    equip_attrs[attr_id] = attr_info
  end
  return equip_attrs
end

function M:get_engrave_attr(buddy_id, engrave_lv, entry_id)
  local engrave_attrs = {}
  local add_engrave_attr_list = ShareRes.get_buddy_engrave_attr_list(buddy_id, engrave_lv)
  if not add_engrave_attr_list then
    return
  end
  engrave_attrs = self:calculate_engrave_attr_add(engrave_attrs, add_engrave_attr_list)
  if entry_id then
    local cur_entry_cfg = ShareRes.create("buddy.buddy_refine_entry", entry_id)
    local add_entry_attr_list = cur_entry_cfg.EffectList
    engrave_attrs = self:calculate_engrave_attr_add(engrave_attrs, add_entry_attr_list)
  end
  return engrave_attrs
end

function M:calculate_engrave_attr_add(engrave_attrs, add_attr_list)
  for key, add_engrave_attr_info in pairs(add_attr_list) do
    local add_attr_id = add_engrave_attr_info[1]
    local add_attr_val = add_engrave_attr_info[2]
    local add_attr_type = add_engrave_attr_info[3]
    local attr_info = engrave_attrs[add_attr_id]
    attr_info = attr_info or FightDefine.init_single_attr()
    if 1 == add_attr_type then
      attr_info.FIXED = attr_info.FIXED + add_attr_val
    elseif 2 == add_attr_type then
      attr_info.RATIO = attr_info.RATIO + add_attr_val
    end
    engrave_attrs[add_attr_id] = attr_info
  end
  return engrave_attrs
end

function M:is_show_character_main_red()
  if self:check_potential_red() then
    return true
  end
  if self:is_have_buddy_not_click() then
    return true
  end
end

function M:update_buddy_red(buddy_id)
  self:update_up_lv_red(buddy_id)
  self:update_topu_red(buddy_id)
  self:update_level_red(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  if not buddy_info then
    return
  end
  local weapon_uuid = buddy_info.weapon
  self:update_equip_break_red(weapon_uuid)
  self:update_equip_up_red(weapon_uuid)
  self:update_equip_homology_red(weapon_uuid)
  self:update_equip_replace_red(weapon_uuid)
  self:update_equip_red(weapon_uuid)
end

function M:update_up_lv_red(buddy_id)
  local is_show_red = false
  if self.v_not_show_sys_red then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_UP_BTN, is_show_red)
    return is_show_red
  end
  local buddy_info = self.v_buddy_map[buddy_id]
  local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  if max_level <= buddy_info.lv then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_UP_BTN, is_show_red)
    return is_show_red
  end
  if not self:is_need_break(buddy_id) then
    local levelup_items = ShareRes.create("buddy.buddy_exp")
    local add_exp_item_data = {}
    for k, v in pairs(levelup_items) do
      local item_cfg = ShareRes.create("item.item", v.Id)
      local data = {
        Exp = item_cfg.Arg[1],
        Id = v.Id
      }
      table.insert(add_exp_item_data, data)
    end
    table.sort(add_exp_item_data, function(a, b)
      return a.Exp < b.Exp
    end)
    local add_exp
    for _, item_info in ipairs(add_exp_item_data) do
      if BagMgr:get_item_num(item_info.Id) > 0 then
        add_exp = item_info.Exp
      end
    end
    if add_exp then
      local _, coin_cost = self:get_add_exp_info(buddy_id, add_exp)
      local coin_have = BagMgr:get_item_num(Config.COIN_ITEMID)
      if coin_cost <= coin_have then
        is_show_red = true
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_UP_BTN, is_show_red)
  return is_show_red
end

function M:update_topu_red(buddy_id)
  local is_show_red = false
  if self.v_not_show_sys_red then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_BREAK_BTN, is_show_red)
    return is_show_red
  end
  local idx = self:get_buddy_index_by_id(buddy_id)
  local buddy_info = self.v_buddys[idx]
  if self:is_need_break(buddy_id) then
    local buddy_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv]
    local pass_condition = true
    if buddy_break_cfg.Condition and buddy_break_cfg.Condition > 0 then
      pass_condition = Condition:check_condition(buddy_break_cfg.Condition)
    end
    if not pass_condition then
      is_show_red = false
    else
      local cost_coin_num = buddy_break_cfg.Coin
      local coin_have = BagMgr:get_item_num(Config.COIN_ITEMID)
      if cost_coin_num <= coin_have then
        is_show_red = true
        for idx, item_id in ipairs(buddy_break_cfg.Item) do
          local item_count = BagMgr:get_item_num(item_id)
          local need_num = buddy_break_cfg.ItemCount[idx]
          if item_count < need_num then
            is_show_red = false
            break
          end
        end
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_BREAK_BTN, is_show_red)
  return is_show_red
end

function M:update_equip_up_red(equip_uuid)
  local is_show_red = false
  if self.v_not_show_sys_red then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_STRENGTHEN_UP, is_show_red)
    return is_show_red
  end
  local equip_info = self.v_equip_map[equip_uuid]
  if not equip_info then
    return
  end
  local max_level = ShareRes.get_equip_max_level(equip_info.break_lv)
  if max_level <= equip_info.lv then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_STRENGTHEN_UP, is_show_red)
    return is_show_red
  end
  if not self:is_equip_need_break(equip_uuid) then
    local levelup_items = ShareRes.create("equip.equip_exp")
    local add_exp = 0
    for k, v in pairs(levelup_items) do
      if BagMgr:get_item_num(v.Id) > 0 then
        local item_cfg = ShareRes.create("item.item", v.Id)
        local Exp = item_cfg.Arg[1]
        if 0 == add_exp then
          add_exp = Exp
        end
        if Exp < add_exp then
          add_exp = Exp
        end
      end
    end
    if add_exp > 0 then
      local _, coin_cost = self:get_equip_add_exp_info(equip_uuid, add_exp)
      local coin_have = BagMgr:get_item_num(Config.COIN_ITEMID)
      if coin_cost <= coin_have then
        is_show_red = true
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_STRENGTHEN_UP, is_show_red)
  return is_show_red
end

function M:update_equip_break_red(equip_uuid)
  local is_show_red = false
  local equip_info = self.v_equip_map[equip_uuid]
  if not equip_info then
    return
  end
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local equip_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  if self.v_not_show_sys_red or equip_info.break_lv >= #equip_level_cfgs then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_STRENGTHEN_BREAK, is_show_red)
    return is_show_red
  end
  if self:is_equip_need_break(equip_uuid) then
    local equip_break_cfg = ShareRes.create("equip.equip_break", equip_info.id)[equip_info.break_lv]
    local pass_condition = true
    if equip_break_cfg.Condition and equip_break_cfg.Condition > 0 then
      pass_condition = Condition:check_condition(equip_break_cfg.Condition)
    end
    if not pass_condition then
      is_show_red = false
    else
      local cost_coin_num = equip_break_cfg.Coin
      local coin_have = BagMgr:get_item_num(Config.COIN_ITEMID)
      if cost_coin_num <= coin_have then
        is_show_red = true
        for idx, item_id in ipairs(equip_break_cfg.Item) do
          local item_count = BagMgr:get_item_num(item_id)
          local need_num = equip_break_cfg.ItemCount[idx]
          if item_count < need_num then
            is_show_red = false
            break
          end
        end
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_STRENGTHEN_BREAK, is_show_red)
  return is_show_red
end

function M:update_equip_homology_red(equip_uuid)
  local is_show_red = false
  local equip_info = self.v_equip_map[equip_uuid]
  if not equip_info then
    return
  end
  local cost_id = {}
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  local max_advance_lv = #advance_cfg
  if max_advance_lv <= equip_info.advance then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_HOMOLOGY_MATERIAL, is_show_red)
    return
  end
  local cfg = advance_cfg[equip_info.advance]
  cost_id[cfg.CostEquipId] = true
  cost_id[cfg.CostCommonId] = true
  for _, target_equip_info in pairs(self.v_equip_map) do
    local id = target_equip_info.id
    if cost_id[id] and (not target_equip_info.owner or 0 == target_equip_info.owner) and target_equip_info.uuid ~= equip_uuid then
      is_show_red = true
      break
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_HOMOLOGY_MATERIAL, is_show_red)
  return is_show_red
end

function M:update_equip_replace_red(equip_uuid)
  self:check_replace_weapon_red(equip_uuid)
end

function M:check_replace_weapon_red(equip_uuid)
  local curr_equip_info = self.v_equip_map[equip_uuid]
  if 0 == curr_equip_info.owner then
    return
  end
  local equip_list = CharacterMgr:get_equip_list()
  local buddy_config = ShareRes.create("buddy.buddy", curr_equip_info.owner)
  local curr_equip_cfg = ShareRes.create("equip.equip", curr_equip_info.id)
  local curr_quality = curr_equip_cfg.Quality
  local can_replace = false
  for _, equip_info in pairs(equip_list) do
    local id = equip_info.id
    local equip_cfg = ShareRes.create("equip.equip", id)
    equip_info.quality = equip_cfg.Quality
    if equip_cfg.SubType == buddy_config.WeaponSubType and curr_quality < equip_cfg.Quality then
      can_replace = true
      break
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_REPLACE_BTN, can_replace)
end

function M:update_equip_red(equip_uuid)
  local is_show_red = false
  if self.v_not_show_sys_red then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP, is_show_red)
    return is_show_red
  end
  if self:update_equip_break_red(equip_uuid) or self:update_equip_homology_red(equip_uuid) or GemStoneMgr:update_equip_gem_red(equip_uuid) then
    is_show_red = true
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP, is_show_red)
  return is_show_red
end

function M:update_level_red(buddy_id)
  local is_show_red = false
  if self.v_not_show_sys_red then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_LEVEL, is_show_red)
    return is_show_red
  end
  if self:update_topu_red(buddy_id) then
    is_show_red = true
  end
  if self:check_potential_red(buddy_id) then
    is_show_red = true
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_LEVEL, is_show_red)
  return is_show_red
end

function M:update_skill_red(buddy_id)
  local is_show_red = false
  if self.v_not_show_sys_red then
    return is_show_red
  end
  if self:update_skill_up_red(buddy_id) then
    is_show_red = true
  elseif self:get_talent_up_red(buddy_id) then
    is_show_red = true
  end
  return is_show_red
end

function M:update_skill_up_red(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  local skill_list = buddy_info.lSkill
  for _, skill_info in pairs(skill_list) do
    if self:can_skill_upgrade(buddy_id, skill_info.id, skill_info.lv, skill_info.virtual_level) then
      return true
    end
  end
  return false
end

function M:update_buddy_archive_red_point(buddy_info)
  local buddy_id = buddy_info.id
  local before_info = self.v_buddy_map[buddy_info.id] or {}
  local before_archive_list = before_info.lArchives or {}
  local new_archive_list = buddy_info.lArchives or {}
  local before_count = 0
  local new_count = 0
  for _, data in pairs(before_archive_list) do
    before_count = before_count + 1
  end
  for _, data in pairs(new_archive_list) do
    new_count = new_count + 1
  end
  if before_count < new_count then
    self:active_red(RedEnum.CHAR_ARCHIVE_INFO, buddy_id)
  end
end

function M:can_skill_upgrade(buddy_id, skill_id, skill_lv, virtual_level)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  local skill_lv, virtual_level = skill_lv, virtual_level
  if not skill_lv or not virtual_level then
    local skill_list = buddy_info.lSkill
    skill_lv, virtual_level = 1, 1
    for _, skill_info in pairs(skill_list) do
      if skill_id == skill_info.id then
        skill_lv = skill_info.lv
        virtual_level = skill_info.virtual_level
        break
      end
    end
  end
  local virtual_max_lv = ShareRes.get_comm_value("SkillVirtualMaxLevel")
  if virtual_level >= virtual_max_lv then
    return false
  end
  local virtual_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, virtual_level)
  local lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  local next_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv + 1)
  if not next_lv_cfg then
    return false
  end
  local need_break_lv = virtual_lv_cfg.NeedBreak
  local buddy_break_lv = buddy_info.break_lv
  if need_break_lv > buddy_break_lv then
    return false
  end
  local cost = virtual_lv_cfg.ConsumeList
  if cost then
    for _, v in pairs(cost) do
      local own_num = BagMgr:get_item_num(v.id)
      if own_num < v.count then
        return false
      end
    end
  end
  return true
end

function M:get_talent_up_red(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  local talent_lv = buddy_info.talent_lv
  local buddy_break_lv = buddy_info.break_lv
  local next_talent_cfg = ShareRes.get_buddy_talent_lv_cfg(buddy_id, talent_lv + 1)
  if next_talent_cfg then
    local cond_done = buddy_break_lv >= next_talent_cfg.NeedBreak
    if cond_done then
      local cost_enough = true
      local cost = next_talent_cfg.ConsumeList
      if cost then
        for _, v in pairs(cost) do
          local own_num = BagMgr:get_item_num(v.id)
          if own_num < v.count then
            cost_enough = false
          end
        end
      end
      if cost_enough then
        return true
      end
    end
  end
  return false
end

local TALENT_READ_MAP_KEY = "TALENT_READ_MAP"

function M:mark_read_talen(buddy_id, talent_lv)
  local local_select_data = LocalStorage:load_table(TALENT_READ_MAP_KEY, true) or {}
  local_select_data[buddy_id] = local_select_data[buddy_id] or {}
  local_select_data[buddy_id][talent_lv] = 1
  LocalStorage:save_table(TALENT_READ_MAP_KEY, local_select_data, true)
end

function M:get_talent_read(buddy_id, talent_lv)
  local local_select_data = LocalStorage:load_table(TALENT_READ_MAP_KEY, true) or {}
  local_select_data[buddy_id] = local_select_data[buddy_id] or {}
  return 1 == local_select_data[buddy_id][talent_lv]
end

function M:get_talent_not_read_red(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  local talent_lv = buddy_info.talent_lv
  if talent_lv > 0 then
    for i = 1, talent_lv do
      if not self:get_talent_read(buddy_id, i) then
        return true
      end
    end
  end
  return false
end

function M:update_engrave_red(buddy_id)
  if not self.v_buddy_map[buddy_id].refine then
    return
  end
  local streng_lv = self.v_buddy_map[buddy_id].refine.lv
  if streng_lv == CHARACTER_CONFIG.ENGRAVED_MAX_LV then
    return false
  end
  local is_show_red = true
  local buddy_engrave_cfg = ShareRes.create("buddy.buddy_refine", buddy_id)
  local streng_lv_cfg = buddy_engrave_cfg[streng_lv]
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  local need_lv = streng_lv_cfg.Lv
  local cur_lv = buddy_info.lv
  local need_break_lv = streng_lv_cfg.BreakLv
  local cur_break_lv = buddy_info.break_lv
  local cost_id_list = streng_lv_cfg.CostId
  local cost_num_list = streng_lv_cfg.CostNum
  cur_break_lv = cur_break_lv - 1
  need_break_lv = need_break_lv - 1
  for index, item_id in ipairs(cost_id_list) do
    if 0 ~= item_id then
      local cur_num = BagMgr:get_item_num(item_id)
      local need_num = cost_num_list[index]
      if cur_num < need_num then
        is_show_red = false
        break
      end
    end
  end
  if is_show_red then
    if cur_break_lv > need_break_lv then
      is_show_red = true
    elseif cur_break_lv == need_break_lv then
      if need_lv > cur_lv then
        is_show_red = false
      else
        is_show_red = true
      end
    else
      is_show_red = false
    end
  end
  return is_show_red
end

function M:req_first_click_buddy(buddy_id)
  Network:protect_call("c2gs_buddy_first_click", {id = buddy_id}, function(ok)
    if ok then
      for idx, buddy in pairs(self.v_buddys) do
        if buddy.id == buddy_id then
          self.v_buddys[idx].firstclick = true
          break
        end
      end
      MsgGame:mq_publish2(Const.MSG_REFRESH_CHARACTER_ENTRY_RED)
    end
  end)
end

function M:is_have_buddy_not_click()
  for idx, buddy in pairs(self.v_buddys) do
    if not buddy.firstclick then
      return true
    end
  end
  return false
end

function M:set_screen_condtion_sort(type, is_operate_inside_list)
  if not is_operate_inside_list then
    self.v_screen_type = type
  else
    self.v_screen_type_inside_list = type
  end
end

function M:set_screen_condtion_attr(attr_list, job_list, tag_list, is_operate_inside_list)
  if not is_operate_inside_list then
    self.v_attr_screen_list = attr_list
    self.v_job_screen_list = job_list
    self.v_tag_screen_list = tag_list
  else
    self.v_attr_screen_list_inside_list = attr_list
    self.v_job_screen_list_inside_list = job_list
    self.v_tag_screen_list_inside_list = tag_list
  end
end

function M:set_screen_condtion(type, attr_list, job_list, tag_list, is_operate_inside_list)
  if not is_operate_inside_list then
    self.v_screen_type = type
    self.v_attr_screen_list = attr_list
    self.v_job_screen_list = job_list
    self.v_tag_screen_list = tag_list
  else
    self.v_screen_type_inside_list = type
    self.v_attr_screen_list_inside_list = attr_list
    self.v_job_screen_list_inside_list = job_list
    self.v_tag_screen_list_inside_list = tag_list
  end
end

function M:not_show_sys_red(is_not_show)
  self.v_not_show_sys_red = is_not_show
end

function M:get_all_buddys()
  return self.v_buddys
end

function M:get_aid_hero()
  return self.v_assist_buddy_list
end

function M:set_aid_data(data)
  self.v_aid_data = data
end

function M:get_aid_data()
  return self.v_aid_data
end

function M:set_card_show_data(data)
  self.v_card_show_data = data
end

function M:get_card_show_data(data)
  return self.v_card_show_data
end

function M:get_show_all_buddy_temp()
  if self.v_show_all_buddy_temp == nil then
    self.v_show_all_buddy_temp = self.v_show_all_buddy
  end
  return self.v_show_all_buddy_temp
end

function M:set_show_all_buddy_temp(is_show_all)
  self.v_show_all_buddy_temp = is_show_all
end

function M:set_card_show_list_info(pos, buddy_id)
  self.v_card_show_data.select_list[pos] = buddy_id
end

function M:get_card_select_list_info()
  if not self.v_card_show_data then
    self.v_card_show_data = {}
    self.v_card_show_data.select_list = {}
    for index = 1, 5 do
      self.v_card_show_data.select_list[index] = self.v_appoint_buddy_list[index] and self.v_appoint_buddy_list[index] or 0
    end
  end
  return self.v_card_show_data.select_list
end

function M:get_card_real_select_list_info()
  return self.v_appoint_buddy_list
end

function M:get_is_show_all_buddy()
  return self.v_show_all_buddy
end

function M:on_buddy_show_info(msg)
  self.v_assist_buddy_list = msg.assist_buddy_list
  self.v_appoint_buddy_list = msg.appoint_buddy_list
  self.v_show_all_buddy = msg.show_all_buddy
end

function M:req_set_assist_buddy(pos, buddy_id, cb)
  Network:protect_call("c2gs_set_assist_buddy", {index = pos, buddy_id = buddy_id}, function(ok)
    if ok then
      self.v_assist_buddy_list[pos] = buddy_id
      if cb then
        cb()
      end
    end
  end)
end

function M:req_set_show_all_buddy()
  Network:protect_call("c2gs_set_show_all_buddy", {}, function(ok)
    if ok then
      self.v_show_all_buddy = not self.v_show_all_buddy
    end
  end)
end

function M:req_set_appoint_show_buddy(buddy_id_list)
  Network:protect_call("c2gs_appoint_show_buddy", {buddy_id_list = buddy_id_list}, function(ok)
    if ok then
      self.v_appoint_buddy_list = buddy_id_list
      Util.show_message_tip(2074)
    else
      Util.show_message_tip(2075)
    end
  end)
end

function M:get_engrave_info(buddy_id)
  if not self.v_buddy_map[buddy_id] then
    return
  end
  return self.v_buddy_map[buddy_id].refine
end

function M:req_buddy_refine_upgrade(buddy_id, callback)
  Network:protect_call("c2gs_buddy_refine_upgrade", {id = buddy_id}, function(ok)
    if ok and callback then
      callback()
    end
  end)
end

function M:on_update_buddy_refine(msg)
  self.v_buddy_map[msg.id].refine = msg.refine
end

function M:req_get_buddy_refine_new_entry(buddy_id, callback)
  Network:protect_call("c2gs_get_buddy_refine_new_entry", {id = buddy_id}, function(ok, resp)
    if ok and callback then
      self.v_buddy_map[buddy_id].refine.temporary_entry_id = resp.entry
      callback()
    end
  end)
end

function M:req_buddy_refine_replace_entry(buddy_id, callback)
  Network:protect_call("c2gs_buddy_refine_replace_entry", {id = buddy_id}, function(ok)
    if ok then
      callback()
    end
  end)
end

function M:set_buddy_new(data)
  self.v_new_buddy_map[data.buddy_id] = 1
end

function M:is_buddy_new(buddy_id)
  if self.v_new_buddy_map[buddy_id] then
    self.v_new_buddy_map[buddy_id] = nil
    return true
  end
  return false
end

function M:calcu_weapon_reduction_rebate(equip_data, gold_rebate_percent, exp_rebate_percent, break_rebate_percent, exp_item_data, tb, total_exp, has_novice_privilege)
  local add_exp_item_data = exp_item_data or {}
  local rebate_table = tb or {}
  if not add_exp_item_data or not next(add_exp_item_data) then
    local levelup_items = ShareRes.create("equip.equip_exp")
    for k, v in pairs(levelup_items) do
      local item_cfg = ShareRes.create("item.item", v.Id)
      local data = {
        Exp = item_cfg.Arg[1],
        Id = v.Id
      }
      table.insert(add_exp_item_data, data)
    end
    table.sort(add_exp_item_data, function(a, b)
      return a.Exp > b.Exp
    end)
  end
  local exp = equip_data.exp
  local lv = equip_data.lv
  local break_lv = equip_data.break_lv
  local quality = equip_data.quality
  local all_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_break_cfgs = ShareRes.create("equip.equip_break", equip_data.id)
  local coin_cost = 0
  local exp_cost, temp_break_rebate_tb, rebate_coin, rebate_exp
  if lv >= ShareRes.get_equip_max_level(break_lv) then
    exp_cost = total_exp and total_exp or 0
  else
    exp_cost = total_exp and total_exp + exp or exp
  end
  rebate_coin, rebate_exp = self:calcu_level_up_rebate(quality, lv, break_lv, all_level_cfgs)
  exp_cost = exp_cost + rebate_exp
  coin_cost = coin_cost + rebate_coin
  if not has_novice_privilege then
    self:calcu_exp(rebate_table, math.ceil(exp_cost * exp_rebate_percent / 10000), add_exp_item_data)
  end
  if break_lv > 1 then
    rebate_coin, temp_break_rebate_tb = self:calcu_break_rebate(equip_data.id, break_lv, equip_break_cfgs)
    for item_id, count in pairs(temp_break_rebate_tb) do
      rebate_table[item_id] = (rebate_table[item_id] or 0) + math.ceil(count * break_rebate_percent / 10000)
    end
    coin_cost = coin_cost + rebate_coin
  end
  rebate_table[Config.COIN_ITEMID] = (rebate_table[Config.COIN_ITEMID] or 0) + math.ceil(coin_cost * gold_rebate_percent / 10000)
  return rebate_table, exp_cost
end

function M:calcu_break_rebate(equip_id, break_lv, equip_break_cfgs)
  local coin_cost = 0
  equip_break_cfgs = equip_break_cfgs or ShareRes.create("equip.equip_break", equip_id)
  local count = 0
  local break_rebate_tb = {}
  for i = 2, break_lv do
    local equip_break_cfg = equip_break_cfgs[i - 1]
    coin_cost = equip_break_cfg.Coin + coin_cost
    if equip_break_cfg and equip_break_cfg.Item then
      for index, use_item_id in pairs(equip_break_cfg.Item) do
        if use_item_id > 0 then
          count = break_rebate_tb[use_item_id] or 0
          break_rebate_tb[use_item_id] = count + equip_break_cfg.ItemCount[index]
        end
      end
    end
  end
  return coin_cost, break_rebate_tb
end

function M:calcu_level_up_rebate(quality, lv, break_lv, all_level_cfgs)
  local star_lv = 1
  local end_lv
  local coin_cost, exp_cost = 0, 0
  all_level_cfgs = all_level_cfgs or ShareRes.get_equip_lv_up_cfg(quality)
  for bl, single_bl_cfgs in ipairs(all_level_cfgs) do
    if bl <= break_lv then
      if bl < break_lv then
        end_lv = ShareRes.get_equip_max_level(bl)
      else
        end_lv = lv
      end
      for l = star_lv, end_lv do
        local sbcfg = single_bl_cfgs[l]
        coin_cost = coin_cost + sbcfg.Coin
        exp_cost = exp_cost + sbcfg.Exp
      end
      star_lv = end_lv + 1
    else
      break
    end
  end
  return coin_cost, exp_cost
end

function M:calcu_exp(rebate_table, exp_cost, add_exp_item_data)
  local item_id, count
  if not add_exp_item_data or not next(add_exp_item_data) then
    local levelup_items = ShareRes.create("equip.equip_exp")
    for k, v in pairs(levelup_items) do
      local item_cfg = ShareRes.create("item.item", v.Id)
      local data = {
        Exp = item_cfg.Arg[1],
        Id = v.Id
      }
      table.insert(add_exp_item_data, data)
    end
    table.sort(add_exp_item_data, function(a, b)
      return a.Exp > b.Exp
    end)
  end
  for index, item_info in ipairs(add_exp_item_data) do
    local item_count = math.floor(exp_cost / item_info.Exp)
    if item_count > 0 then
      exp_cost = exp_cost % item_info.Exp
      item_id = item_info.Id
      count = rebate_table[item_id] or 0
      rebate_table[item_id] = count + item_count
    end
    if index == #add_exp_item_data and exp_cost > 0 then
      count = rebate_table[item_id] or 0
      rebate_table[item_id] = count + 1
    end
  end
end

function M:reshape_equip(uuid, privilege_id, callback)
  Network:protect_call("c2gs_reshape_equip", {uuid = uuid, newbie_privilege_id = privilege_id}, function(ok, resp)
    if ok then
      callback()
    end
  end)
end

function M:get_equip_info_by_buddy_id(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  if not buddy_info then
    return nil
  end
  local equip_info = self:get_equip_info(buddy_info.weapon)
  if not equip_info then
    return nil
  end
  return equip_info
end

function M:get_show_attr_list(equip_id, is_dict)
  local curr_equip_cfg = ShareRes.create("equip.equip", equip_id)
  local attr_key_list = {}
  for i, v in pairs(curr_equip_cfg.BaseAttrList) do
    if is_dict then
      attr_key_list[v] = true
    else
      local attr_cfg = ShareRes.get_buddy_attr_cfg(v)
      attr_key_list[#attr_key_list + 1] = attr_cfg.Name
    end
  end
  if not next(attr_key_list) then
    if is_dict then
      attr_key_list = {
        [1] = true,
        [20] = true
      }
    else
      attr_key_list = {"hp", "attack"}
    end
  end
  return attr_key_list
end

function M:is_open_teaching_sys()
  return SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[ACTY_TYPE.BUDDY_TEACH], false)
end

function M:is_open_teaching(buddy_id)
  if not self:is_open_teaching_sys() then
    return false
  end
  local teach_cfg = ShareRes.create("activity.buddy_teach_buddy_key", buddy_id)
  if teach_cfg then
    local time = Date.server_time()
    if time <= teach_cfg.EndTime and time >= teach_cfg.StartTime then
      return true
    end
  end
  return false
end

function M:is_open_teaching_entry(buddy_id)
  if not self:is_open_teaching_sys() then
    return false
  end
  local teach_cfg = ShareRes.create("activity.buddy_teach_buddy_key", buddy_id)
  if teach_cfg and self:get_buddy_by_id(buddy_id) then
    return true
  end
  if teach_cfg then
    local time = Date.server_time()
    if time <= teach_cfg.EndTime and time >= teach_cfg.StartTime then
      return true
    end
  end
  return false
end

function M:on_daily_reset()
  self:reset_buddy_favor_already_exp()
end

function M:reset_buddy_favor_already_exp()
  if not self.v_buddy_map then
    return
  end
  for key, buddy_info in pairs(self.v_buddy_map) do
    buddy_info.favor_already_exp = 0
  end
end

function M:journal_get_force_value(role_id, team_pos)
  if not ChapterMgr then
    return 0
  end
  local _, is_fixed, fixed_id
  if not FixedBuddyMgr:check_is_not_robat(role_id) then
    local fixed_id = ChapterMgr:check_cur_fight_robot_id(role_id)
    is_fixed = nil ~= fixed_id
  end
  return CharacterMgr:get_buddy_combat_effectiveness(role_id, is_fixed, fixed_id)
end

function M:cond_buddy_level(buddy_id, buddy_break_lv, buddy_level)
  local buddy_info = self:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return false
  end
  return buddy_break_lv <= buddy_info.break_lv and buddy_level <= buddy_info.lv
end

function M:get_hero_approach_anim_by_type(buddy_id, type)
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local buddy_view_cfg = ShareRes.get_show_buddy_pos_info(buddy_id, fashion_id)
  if not self:_check_buddy_view_cfg_anim(buddy_view_cfg, type) then
    buddy_view_cfg = ShareRes.get_show_buddy_pos_info(0)
    if not self:_check_buddy_view_cfg_anim(buddy_view_cfg, type) then
      return
    end
  end
  local cfg = buddy_view_cfg[type]
  return cfg.ApproachAnim or cfg.StopAnim
end

function M:play_hero_approach_anim(buddy_id, type, model_view, force_play)
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local buddy_view_cfg = ShareRes.get_show_buddy_pos_info(buddy_id, fashion_id)
  if not self:_check_buddy_view_cfg_anim(buddy_view_cfg, type) then
    buddy_view_cfg = ShareRes.get_show_buddy_pos_info(0)
    if not self:_check_buddy_view_cfg_anim(buddy_view_cfg, type) then
      Log.Error("角色视角表没配兜底的默认动作，界面type：", type)
      return
    end
  end
  local cfg = buddy_view_cfg[type]
  local npc = model_view:get_npc_with_npc_id(buddy_id)
  if not npc then
    return
  end
  if not cfg.ApproachAnim and not cfg.StopAnim then
    return
  end
  local index = model_view:get_npc_index_with_npc_id(buddy_id)
  if not index then
    return
  end
  local is_loop = false
  local need_play_anim = cfg.ApproachAnim
  if not need_play_anim then
    need_play_anim = cfg.StopAnim
    is_loop = true
  end
  if not need_play_anim then
    return
  end
  if is_loop then
    model_view:play_anim(need_play_anim, index, nil, true, 0, cfg.StopEffect, force_play)
  else
    model_view:play_anim(need_play_anim, index, function()
      if cfg.StopAnim then
        model_view:play_anim(cfg.StopAnim, index, nil, true, nil, cfg.StopEffect)
      end
    end, false, 0, cfg.ApproachEffect)
  end
end

function M:_check_buddy_view_cfg_anim(buddy_view_cfg, type)
  if not buddy_view_cfg then
    return false
  end
  local cfg = buddy_view_cfg[type]
  return cfg and (cfg.ApproachAnim ~= nil or nil ~= cfg.StopAnim)
end

function M:get_hero_approach_anim(buddy_id, type)
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local buddy_view_cfg = ShareRes.get_show_buddy_pos_info(buddy_id, fashion_id)
  if not buddy_view_cfg or not buddy_view_cfg[type] then
    buddy_view_cfg = ShareRes.get_show_buddy_pos_info(0)
  end
  if not buddy_view_cfg or not buddy_view_cfg[type] then
    return
  end
  local cfg = buddy_view_cfg[type]
  return cfg.ApproachAnim, cfg.StopAnim, cfg.ApproachEffect, cfg.StopEffect
end

function M:active_red(red_id, buddyid)
  if not red_id or not buddyid then
    return
  end
  local storage_key = string.format("character_red_%s_%s", red_id, buddyid)
  LocalStorage:save_int(storage_key, 0, true)
  RedPointMgr:enable_redpoint(red_id, true, true)
  MsgGame:mq_publish2(Const.MSG_REFRESH_UIMAIN_CLOSE_RED_POINT)
end

function M:clear_red(red_id, buddyid)
  if not red_id or not buddyid then
    return
  end
  local storage_key = string.format("character_red_%s_%s", red_id, buddyid)
  LocalStorage:save_int(storage_key, 1, true)
  RedPointMgr:enable_redpoint(red_id, false)
end

function M:update_red_state(buddyid, red_id)
  local storage_key = string.format("character_red_%s_%s", red_id, buddyid)
  local had_click = 1 == LocalStorage:load_int(storage_key, 0, true)
  RedPointMgr:enable_redpoint(red_id, not had_click)
end

function M:get_red_state(buddyid, red_id)
  local storage_key = string.format("character_red_%s_%s", red_id, buddyid)
  local had_click = 1 == LocalStorage:load_int(storage_key, 0, true)
  return not had_click
end

function M:record_team_trail_info(buddy_id, fixed_id, buddy_lock, buddy_assist)
  if not buddy_id or 0 == buddy_id then
    return
  end
  self.v_team_trail_info = self.v_team_trail_info or {}
  self.v_team_trail_info[buddy_id] = {
    buddy_lock = buddy_lock,
    fixed_id = fixed_id,
    buddy_assist = buddy_assist
  }
end

function M:get_team_trail_info(buddy_id)
  if self.v_team_trail_info then
    return self.v_team_trail_info[buddy_id]
  end
end

function M:get_role_count_with_talent_lv(need_talent_lv, is_equal)
  local count = 0
  for index, info in pairs(self.v_buddys) do
    if is_equal and info.talent_lv == need_talent_lv then
      count = count + 1
    elseif not is_equal and need_talent_lv <= info.talent_lv then
      count = count + 1
    end
  end
  return count
end

function M:get_buddy_count_with_combat_effectiveness(combat_effectiveness_value)
  local count = 0
  for index, info in pairs(self.v_buddys) do
    local value = CharacterMgr:get_buddy_combat_effectiveness(info.id)
    if combat_effectiveness_value <= value then
      count = count + 1
    end
  end
  return count
end

function M:check_favor_award(buddy_id)
  local buddy_info = self.v_buddy_map[buddy_id]
  if not buddy_info then
    return false
  end
  local done_lv = buddy_info.gained_favor_award_level or 1
  local reach_lv = buddy_info.favor_lv or 1
  if done_lv < reach_lv then
    for lv = done_lv, reach_lv do
      local favor_lv_cfg = ShareRes.get_favor_lv_cfg(buddy_id, lv)
      if favor_lv_cfg and favor_lv_cfg.AwardGroupId then
        return true
      end
    end
  end
  return false
end

function M:get_favor_award(buddy_id, callback)
  Network:protect_call("c2gs_buddy_get_favor_level_award", {buddy_id = buddy_id}, function(ok, resp)
    if ok then
      local buddy_info = self.v_buddy_map[buddy_id]
      if buddy_info then
        buddy_info.gained_favor_award_level = resp.gained_favor_award_level
      end
    end
    if callback then
      callback(ok)
    end
    MsgGame:mq_publish2(Const.MSG_ON_FAVOR_AWARD_UPDATE)
  end)
end

function M:init_buddy_voice_language()
  self.v_buddy_language_list = {}
  local buddy_list = ShareRes.get_buddy_cfg()
  for _, buddy in pairs(buddy_list) do
    if not self.v_buddy_language_list[buddy.Id] and 1 ~= buddy.IsShow then
      self.v_buddy_language_list[buddy.Id] = Global.curr_language
    end
  end
  self:save_buddy_cv_language()
end

function M:get_buddy_cv_language(buddy_id)
  if not self.v_buddy_language_list then
    self.v_buddy_language_list = LocalStorage:load_table(Config.BUDDY_VOICE_LANGUAGE_KEY)
  end
  if not self.v_buddy_language_list then
    self.v_buddy_language_list = {}
  end
  if not self.v_buddy_language_list[buddy_id] then
    self.v_buddy_language_list[buddy_id] = Global.curr_language
    self:save_buddy_cv_language()
  end
  return self.v_buddy_language_list[buddy_id]
end

function M:refresh_buddy_cv_language(buddy_id, language)
  if not self.v_buddy_language_list then
    self.v_buddy_language_list = {}
  end
  self.v_buddy_language_list[buddy_id] = language
  self:save_buddy_cv_language()
end

function M:refresh_all_buddy_cv_language()
  if self.v_buddy_language_list then
    for i, v in pairs(self.v_buddy_language_list) do
      local hide_type = ShareRes.get_buddy_cfg(i).HideType
      if 0 == hide_type or HIDE_LANGUAGE_TYPE[hide_type] ~= Global.curr_language then
        self.v_buddy_language_list[i] = Global.curr_language
      end
    end
    self:save_buddy_cv_language()
  end
end

function M:save_buddy_cv_language()
  local str
  local temp_table = {}
  for _, language in pairs(self.v_buddy_language_list) do
    if not temp_table[language] then
      temp_table[language] = 1
      str = nil == str and language or str .. "," .. language
    end
  end
  CS.GameToLua.CheckUpdate.SetVoiceLanguage(str)
  LocalStorage:save_table(Config.BUDDY_VOICE_LANGUAGE_KEY, self.v_buddy_language_list)
end

function M:get_cv_name(buddy_id)
  local language_str = self:get_buddy_cv_language(buddy_id)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local cv_name
  if language_str == Config.CommonDefine.LANGUAGE.CN then
    return buddy_cfg.CV
  else
    return buddy_cfg["CV_" .. language_str]
  end
end

function M:check_buddy_release(buddy_id)
  if not buddy_id or 0 == buddy_id then
    return false
  end
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  if buddy_cfg and buddy_cfg.ReleaseTime then
    return Date.check_time_pass_by_scheme_id(buddy_cfg.ReleaseTime)
  end
  return true
end

return M
