local M = {}
M.effect_func = {}
local effect_func = M.effect_func
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local Math = require("base.mathx")
local _rotate_vec2 = Math.rotate_vec2
local FightDefine = require("cs_share.fight_define")
local CommDefine = require("cs_share.common_define")
local MagicDefine = require("cs_share.magic_def")
local MAGIC_TYPE = MagicDefine.MAGIC_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE
local VALUE_TYPE = CommDefine.VALUE_TYPE
local VALUE_FUNCTION = CommDefine.VALUE_FUNCTION
local SET_TYPE = Config.ATTR_SET_TYPE
local TIME_SCELE_TYPE = MagicDefine.TIME_SCELE_TYPE
M.EffectFunc = {
  [MAGIC_TYPE.ChangeAttr] = "change_attr",
  [MAGIC_TYPE.FightBtnEffect] = "fight_btn_effect",
  [MAGIC_TYPE.ShakeBone] = "shake_bone",
  [MAGIC_TYPE.VisibleMesh] = "visible_mesh",
  [MAGIC_TYPE.NoLogic] = "no_logic",
  [MAGIC_TYPE.Trigger] = "trigger",
  [MAGIC_TYPE.CustomEvent] = "custom_event",
  [MAGIC_TYPE.ChangeAttribAdditive] = "attr_additive"
}

function M.call_effect_func(magic_target, magic_info, ...)
  local fun = M.EffectFunc[magic_info.logic_cfg.type]
  M.add_effect(magic_target, magic_info)
  if not fun or not effect_func[fun] then
    M.release_magic_param(magic_info)
    return false
  end
  effect_func[fun](false, magic_target, magic_info, ...)
  M.release_magic_param(magic_info)
  return true
end

function M.call_effect_func_by_object(magic, ...)
  local fun = M.EffectFunc[magic.cfg.type]
  if not fun or not effect_func[fun] then
    Log.Error("获取effect_func失败，请检查逻辑代码", debug.traceback())
    return false
  end
  return effect_func[fun](true, magic.owner, magic.magic_info, ...)
end

function M.add_effect(magic_target, magic_info)
  local effect_cfg = magic_info.effect_cfg
  if effect_cfg and not magic_info.effect_cfg.IsRemoveSelfOnCompleted then
    local effect = effect_cfg.Effect
    local bone = effect_cfg.EffectJoint
    local effect_world = effect_cfg.EffectWorld
    local is_world = effect_world == MagicDefine.EFFECT_BIND_TYPE.ONLY_ROTATION or effect_world == MagicDefine.EFFECT_BIND_TYPE.SCENE_MAGIC
    local is_timescale = magic_info.logic_cfg and magic_info.logic_cfg.IsTimeScale or TIME_SCELE_TYPE.NONE
    local effect_scale = effect_cfg.EffectScale
    local effect_time_scale = effect_cfg.EffectTimeScale
    local not_time_scale
    if is_timescale == TIME_SCELE_TYPE.NONE or is_timescale == TIME_SCELE_TYPE.EXCEPT_EFFECT or is_timescale == TIME_SCELE_TYPE.UNSCALE then
      not_time_scale = true
    end
    local effect_data = magic_target.act_effect_ctrl.create_effect_param()
    effect_data.prefab_name = effect
    effect_data.attach_point = bone
    effect_data.scale = effect_scale
    effect_data.time_scale = effect_time_scale
    effect_data.effect_bind_type = effect_world
    effect_data.is_world = is_world
    effect_data.not_time_scale = not_time_scale
    effect_data.is_weapon_attach = effect_cfg.IsWeaponAttach
    magic_target.act_effect_ctrl:play_attach_effect(effect_data, magic_target)
  end
end

function M.release_magic_param(magic_info)
  local pool = LuaObjPoolMgr.get_pool("magic_param_pool")
  if pool then
    pool:destroy_obj(magic_info)
  end
end

function effect_func.change_attr(by_object, magic_target, magic_info)
  local magic_id = magic_info.magic_id
  local logic_cfg = magic_info.logic_cfg
  local magic_level = magic_info.magic_level
  local attr_mgr = magic_target.attr_mgr
  local attr_type = logic_cfg[1]
  local value = logic_cfg[2][magic_level]
  if not value then
    local level_max = #logic_cfg[2]
    value = logic_cfg[2][level_max]
  end
  local value_type = logic_cfg[3]
  local set_type = logic_cfg[4]
  local attr_ratio_type = logic_cfg[5][1]
  local is_can_deal = logic_cfg[7]
  local need_add_other_hero = false
  local attr_group_type = ATTR_GROUP_TYPE.BASE
  if magic_target:is_hero() and attr_type == ATTR_TYPE.TEAM_SKILL_ENERGY and value > 0 then
    need_add_other_hero = true
  end
  if value_type == VALUE_TYPE.FIXED and attr_ratio_type then
    local attacker_attr_mngr = magic_info.attacker.attr_mgr
    if not attacker_attr_mngr then
      Log.Error("获取攻击者属性管理器失败", magic_id, magic_target.id, magic_info.attacker.id, debug.traceback())
      return
    end
    local attacker_attr_value
    if 1 == logic_cfg[5][2] then
      attacker_attr_value = attacker_attr_mngr:get_fixed_attr(attr_ratio_type)
    else
      attacker_attr_value = attacker_attr_mngr:get_attr(attr_ratio_type)
    end
    if attacker_attr_value then
      local limit_value = logic_cfg[6][1]
      local limit_divide = logic_cfg[6][2]
      local offset_value = math.max(attacker_attr_value - limit_value, 0)
      if limit_divide > 0 then
        offset_value = math.floor(offset_value / limit_divide)
      end
      if offset_value > 0 then
        value = tonumber(string.format("%0.2f", offset_value * value / 10000))
      else
        value = 0
      end
    end
  end
  attr_ratio_type = attr_type
  attr_mgr:set_cur_attr(attr_group_type, attr_type, value, value_type, set_type, attr_ratio_type, nil, is_can_deal, magic_info.attacker, magic_id, magic_info.owner_missile)
  if need_add_other_hero then
    local ratio = ShareRes.get_comm_value("SkillEneryRatio")
    local other_value = math.floor(value * ratio + 0.5) / 100
    local hero_list = SceneMgr:get_hero_list()
    if hero_list then
      for _, hero in pairs(hero_list) do
        if hero.uuid ~= magic_target.uuid and not hero:is_die() and not hero:is_destroy() then
          hero.attr_mgr:set_cur_attr(attr_group_type, attr_type, other_value, value_type, set_type, attr_ratio_type, nil, is_can_deal)
        end
      end
    end
  end
end

function effect_func.fight_btn_effect(by_object, magic_target, magic_info)
  local logic_cfg = magic_info.logic_cfg
  local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_BUTTON_EFFECT)
  msg.mm_x = logic_cfg[1]
  msg.mm_y = logic_cfg[2]
  msg.mm_obj = logic_cfg
end

function effect_func.shake_bone(by_object, magic_target, magic_info)
  local logic_cfg = magic_info.logic_cfg
  local shake_time = logic_cfg[1]
  local shake_param = logic_cfg[2]
  local angle = shake_param[1]
  local strength = shake_param[2]
  local interval = shake_param[3]
  local owner_dir = magic_target:get_dir()
  local x, z = _rotate_vec2(0, 1, owner_dir + angle)
  magic_target:on_bone_shake(shake_time, strength, interval, x, z, angle)
end

function effect_func.visible_mesh(by_object, magic_target, magic_info)
  local logic_cfg = magic_info.logic_cfg
  local visible = logic_cfg[1]
  Global.camera:adjust_all_mesh_culling_mask(visible)
end

function effect_func.attr_additive(by_object, magic_target, magic_info)
  local logic_cfg = magic_info.logic_cfg
  local magic_id = magic_info.magic_id
  local magic_level = magic_info.magic_level
  local change_args
  if by_object then
    change_args = {}
  end
  local is_change_speed = false
  local need_back = false
  local attr_mgr = magic_target.attr_mgr
  local attr_type_list = logic_cfg[1]
  local change_suc = not magic_target:is_die()
  local value
  if not logic_cfg[7] or logic_cfg[7] == VALUE_FUNCTION.CONST then
    value = logic_cfg[2][magic_level]
    if not value then
      local level_max = #logic_cfg[2]
      value = logic_cfg[2][level_max]
    end
  elseif logic_cfg[7] == VALUE_FUNCTION.LINEAR then
    local a = logic_cfg[8]
    local b = logic_cfg[9]
    value = a * magic_level + b
  end
  local value_type = logic_cfg[3]
  local set_type = logic_cfg[4]
  local attr_group_type = ATTR_GROUP_TYPE.ADDITIVE
  local attr_ratio_type = logic_cfg[5][1]
  if value_type == VALUE_TYPE.FIXED and attr_ratio_type then
    local attacker_attr_mngr = magic_info.attacker.attr_mgr
    local attacker_attr_value
    if 1 == logic_cfg[5][2] then
      attacker_attr_value = attacker_attr_mngr:get_fixed_attr(attr_ratio_type)
    else
      attacker_attr_value = attacker_attr_mngr:get_attr(attr_ratio_type)
    end
    if attacker_attr_value then
      local limit_value = logic_cfg[6][1]
      local limit_divide = logic_cfg[6][2]
      local offset_value = math.max(attacker_attr_value - limit_value, 0)
      if limit_divide > 0 then
        offset_value = math.floor(offset_value / limit_divide)
      end
      if offset_value > 0 then
        value = tonumber(string.format("%0.2f", offset_value * value / 10000))
      else
        value = 0
      end
    end
  end
  local old_speed
  for _, attr in ipairs(attr_type_list) do
    local attr_type = tonumber(attr)
    attr_ratio_type = attr_type
    if magic_target:is_hero() and attr_type == ATTR_TYPE.CHAR_SPEED then
      old_speed = attr_mgr:get_attr(ATTR_TYPE.CHAR_SPEED)
      is_change_speed = true
    end
    attr_mgr:set_cur_attr(attr_group_type, attr_type, value, value_type, set_type, attr_ratio_type, nil, nil, magic_info.attacker, magic_id, magic_info.owner_missile)
    if set_type == SET_TYPE.CHANGE_BY_DELTA then
      need_back = true
      if change_args then
        local insert_data = {
          attr_group_type = attr_group_type,
          attr_type = attr_type,
          value = value,
          value_type = value_type,
          set_type = set_type,
          attr_ratio_type = attr_ratio_type
        }
        table.insert(change_args, insert_data)
      end
    end
  end
  local change_percent
  if is_change_speed then
    local cur_speed = attr_mgr:get_attr(ATTR_TYPE.CHAR_SPEED)
    change_percent = (cur_speed - old_speed) / old_speed
    magic_target.role_move_ctrl:set_change_speed_percent(change_percent)
  end
  if by_object then
    return is_change_speed, need_back, change_args, change_suc, change_percent
  end
end

local CUSTOM_EVENT_FUNC = {
  [MagicDefine.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE.COPY_ATTR] = function(oWner, oTarget, mArgs)
    local oWnerAttrMgr = oWner.attr_mgr
    local oTargetAttrMgr = oTarget.attr_mgr
    local after_change_attrs = {}
    for _, info in pairs(mArgs.attr_list) do
      local attr, ratio = info.attr_id, info.ratio
      local nAttr = math.floor(oTargetAttrMgr:get_attr(attr) * ratio / 10000)
      oWnerAttrMgr:set_cur_attr(ATTR_GROUP_TYPE.BASE, attr, nAttr, CommDefine.VALUE_TYPE.FIXED, SET_TYPE.REPLACE)
      after_change_attrs[attr] = oWnerAttrMgr:get_attr(attr)
    end
    return after_change_attrs
  end,
  [MagicDefine.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE.DEDUCT_HP] = function(oWner, attacker, mTypeArg)
    local oWnerAttrMgr = oWner.attr_mgr
    local lArg = mTypeArg.arg
    oWnerAttrMgr:change_attr(ATTR_GROUP_TYPE.BASE, FightDefine.ATTR_TYPE.CHAR_HP, lArg[1])
    Global.BloodHelper.play_abnor_hurt_dmg(oWner, -lArg[1], lArg[2])
    local after_hp = oWnerAttrMgr:get_attr(FightDefine.ATTR_TYPE.CHAR_HP)
    return after_hp
  end,
  [MagicDefine.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE.CHANGE_ATTR] = function(oWner, attacker, mTypeArg)
    local lArg = mTypeArg.arg
    oWner.attr_mgr:set_cur_attr(lArg[1], lArg[2], lArg[3], lArg[4], lArg[5])
  end
}

function effect_func.custom_event(by_object, magic_target, magic_info)
  local lArg = magic_info.args
  local attacker = magic_info.attacker
  if Util.is_destroy(attacker) then
    return
  end
  if not lArg then
    return
  end
  local nType = lArg.type
  local f = assert(CUSTOM_EVENT_FUNC[nType])
  f(magic_target, attacker, lArg)
end

return M
