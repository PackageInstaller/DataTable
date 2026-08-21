local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local CommonDefine = require("cs_share.common_define")
local SET_TYPE = Config.ATTR_SET_TYPE
TEN_THOUSANDTH_RATIO = 10000
local helper = {}
helper.v_hero_base_max_blood = {}
helper.v_last_added_blood = {}
helper.v_finish_init = false
helper.v_change_value = {}

function helper._init_blood_info(module, hero)
  if not helper.v_hero_base_max_blood[hero.uuid] then
    helper.v_hero_base_max_blood[hero.uuid] = hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  end
  if not helper.v_last_added_blood[hero.uuid] then
    helper.v_last_added_blood[hero.uuid] = 0
  end
  if not helper.v_change_value[hero.uuid] then
    helper.v_change_value[hero.uuid] = {}
  end
end

function helper._adjust_blood(module, hero, attr_list)
  local hp_max_attr = attr_list[ATTR_TYPE.CHAR_HP_MAX]
  local base_max_hp = helper._get_max_blood(hero)
  local change_attr
  if hp_max_attr then
    change_attr = helper._get_total_change_value(module, hero, hp_max_attr)
  else
    change_attr = helper._get_total_change_value(nil, hero)
  end
  local add_max = (base_max_hp + change_attr.FIXED) * (1 + change_attr.RATIO / 10000) - base_max_hp
  if hp_max_attr then
    local nMaxHp = hero.attr_mgr:get_attr_max(ATTR_TYPE.CHAR_HP)
    if hero.nLastMaxHp and nMaxHp > hero.nLastMaxHp then
      hero.attr_mgr:set_attr_by_ratio(Config.ATTR_GROUP_TYPE.BASE, ATTR_TYPE.CHAR_HP, ATTR_TYPE.CHAR_HP, (nMaxHp - hero.nLastMaxHp) / hero.nLastMaxHp * TEN_THOUSANDTH_RATIO, SET_TYPE.CHANGE_BY_DELTA)
    end
    local last_add = helper._get_last_add_blood(module, hero)
    if add_max - last_add > 0 then
    end
    helper._set_last_add_blood(module, hero, add_max)
  end
  base_max_hp = base_max_hp + add_max
  local hp = hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  if base_max_hp < hp then
    hero.attr_mgr:change_attr(Config.ATTR_GROUP_TYPE.BASE, ATTR_TYPE.CHAR_HP, base_max_hp - hp)
  end
  hero.attr_mgr.v_change_attrs = {}
  hero.nLastMaxHp = nil
end

function helper._get_max_blood(hero)
  return helper.v_hero_base_max_blood[hero.uuid]
end

function helper._get_last_add_blood(module, hero)
  return helper.v_last_added_blood[hero.uuid]
end

function helper._set_last_add_blood(module, hero, new_val)
  helper.v_last_added_blood[hero.uuid] = new_val
end

function helper._get_total_change_value(module, hero, blood_attr)
  if module and blood_attr then
    helper.v_change_value[hero.uuid][module] = blood_attr
  end
  local temp = FightDefine.init_single_attr()
  for _, v in pairs(helper.v_change_value[hero.uuid]) do
    temp.FIXED = temp.FIXED + v.FIXED
    temp.RATIO = temp.RATIO + v.RATIO
  end
  return temp
end

function helper.sync_module_attrs(module, attr_list, init, is_preview)
  local hero_list = SceneMgr:get_hero_list()
  if nil == hero_list then
    return
  end
  Log.Info(module, "sync attr list", attr_list)
  for _, hero in pairs(hero_list) do
    hero:update_module_attrs(module, attr_list, false)
    hero.attr_mgr:update_module_attrs()
    helper._init_blood_info(module, hero)
    if not init then
    elseif not helper.v_finish_init then
    end
    if CommonDefine.MODULE_FOLLOW_HP_MAX[module] then
      helper._adjust_blood(module, hero, attr_list)
    end
    if StateReport and not is_preview then
      StateReport:sync_module_attrs(hero.uuid)
      if UNITY_EDITOR then
        hero:check_attrs(module)
      end
    end
  end
end

function helper.set_finish(flag)
  helper.v_finish_init = flag
end

function helper.clear()
  helper.v_hero_base_max_blood = {}
  helper.v_last_added_blood = {}
  helper.v_finish_init = false
  helper.v_change_value = {}
end

return helper
