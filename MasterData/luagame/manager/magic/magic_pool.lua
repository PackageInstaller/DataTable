local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local MagicDef = require("cs_share.magic_def")
local MAGIC_EFFECT_TYPE = MagicDef.MAGIC_EFFECT_TYPE
local BROARDCAST_TYPE = MagicDef.MAGIC_BROARDCAST_TYPE
local MAGIC_TYPE = MagicDef.MAGIC_TYPE
local MagicEffectFunc = require("manager.magic.magic_event.magic_effect_func")
local DebugToolMgr, MagicActionType
if UNITY_EDITOR_WIN then
  DebugToolMgr = CS.Game.DebugToolMgr.Instance
  MagicActionType = CS.Game.MagicActionType
end
local M = Util.create_class()

function M:_init()
  self.v_magic_class = {}
  self.v_magic_pool_mgr = {}
  Util.bind_msg(self, Const.MSG_ON_LEAVE_ROOM, self.call_free_objs_on_release, self)
end

M.Event = {
  [MAGIC_TYPE.SkillEnergy] = {
    fun = "on_skill_energy"
  },
  [MAGIC_TYPE.HurtDamage] = {
    fun = "on_hurt_damage"
  },
  [MAGIC_TYPE.UIObjectVisble] = {
    fun = "on_ui_object_visble"
  },
  [MAGIC_TYPE.Heal] = {fun = "on_heal"},
  [MAGIC_TYPE.BeGrab] = {fun = "on_grab"},
  [MAGIC_TYPE.BeThrow] = {fun = "on_throw"},
  [MAGIC_TYPE.EnergyRecovery] = {
    fun = "on_energy_recovery"
  },
  [MAGIC_TYPE.CutHpShield] = {
    fun = "on_cut_hp_shield"
  },
  [MAGIC_TYPE.SPECAIL_DMG] = {
    fun = "on_special_dmg"
  }
}
M.Magic = {
  [MAGIC_TYPE.FightBtnEffect] = {
    file = "magic_fight_btn_effect"
  },
  [MAGIC_TYPE.ChangeTimeScale] = {
    file = "magic_change_time_scale"
  },
  [MAGIC_TYPE.ChangeAttribAdditive] = {
    file = "magic_attr_additive"
  },
  [MAGIC_TYPE.AddBehavior] = {
    file = "magic_behavior"
  },
  [MAGIC_TYPE.ShakeCamera] = {
    file = "magic_shake_camera"
  },
  [MAGIC_TYPE.TrackCamera] = {
    file = "magic_track_camera"
  },
  [MAGIC_TYPE.SetNpcStatus] = {
    file = "magic_npc_status"
  },
  [MAGIC_TYPE.HideJoint] = {
    file = "magic_hide_joint"
  },
  [MAGIC_TYPE.PlayEffect] = {
    file = "magic_play_effect"
  },
  [MAGIC_TYPE.NoLogic] = {
    file = "magic_no_logic"
  },
  [MAGIC_TYPE.ForceShift] = {
    file = "magic_force_shift"
  },
  [MAGIC_TYPE.CamPosition] = {
    file = "magic_camera_position"
  },
  [MAGIC_TYPE.CamTransform] = {
    file = "magic_camera_transform"
  },
  [MAGIC_TYPE.CamFOV] = {
    file = "magic_camera_fov"
  },
  [MAGIC_TYPE.ChangeAttr] = {
    file = "magic_change_attr"
  },
  [MAGIC_TYPE.SetArmor] = {
    file = "magic_set_armor"
  },
  [MAGIC_TYPE.DamageCorrect] = {
    file = "magic_damage_correct"
  },
  [MAGIC_TYPE.RgbSplit] = {
    file = "magic_rgb_split"
  },
  [MAGIC_TYPE.HealCorrect] = {
    file = "magic_heal_correct"
  },
  [MAGIC_TYPE.HpShield] = {
    file = "magic_hp_shield"
  },
  [MAGIC_TYPE.SparmorCorrect] = {
    file = "magic_sparmor_correct"
  },
  [MAGIC_TYPE.CamFocusBlur] = {
    file = "magic_camera_focus_blur"
  },
  [MAGIC_TYPE.CritCorret] = {
    file = "magic_crit_correct"
  },
  [MAGIC_TYPE.SkillMaxEnergy] = {
    file = "magic_skill_max_energy"
  },
  [MAGIC_TYPE.ShakeBone] = {
    file = "magic_shake_bone"
  },
  [MAGIC_TYPE.ChangeModelScale] = {
    file = "magic_change_model_scale"
  },
  [MAGIC_TYPE.TempBlue] = {
    file = "magic_temp_blue"
  },
  [MAGIC_TYPE.KILL_LEVEL] = {
    file = "magic_kill_level"
  },
  [MAGIC_TYPE.DemageImmune] = {
    file = "magic_damage_immunity"
  },
  [MAGIC_TYPE.CameraDutch] = {
    file = "magic_camera_dutch"
  },
  [MAGIC_TYPE.Trigger] = {
    file = "magic_trigger"
  },
  [MAGIC_TYPE.ForbidSwitchHero] = {
    file = "magic_forbid_switch_hero"
  },
  [MAGIC_TYPE.ChangeTough] = {
    file = "magic_change_tough"
  },
  [MAGIC_TYPE.ChangeAbnormalStatus] = {
    file = "magic_change_abnormal_status"
  },
  [MAGIC_TYPE.CustomEvent] = {
    file = "magic_custom_event"
  },
  [MAGIC_TYPE.ElementAbnormalEffect] = {
    file = "magic_element_abnormal"
  },
  [MAGIC_TYPE.DamageSharing] = {
    file = "magic_damage_sharing"
  },
  [MAGIC_TYPE.ChangeWeaponAttachPoint] = {
    file = "magic_change_weapon_attach_point"
  },
  [MAGIC_TYPE.SpecialElementAbnormalEffect] = {
    file = "magic_special_element_abnormal"
  },
  [MAGIC_TYPE.VisibleMesh] = {
    file = "magic_visible_mesh"
  },
  [MAGIC_TYPE.Abnormal_Flag] = {
    file = "magic_abnormal_flag"
  },
  [MAGIC_TYPE.SnapShot_Sound] = {
    file = "magic_snapshot_sound"
  },
  [MAGIC_TYPE.AttrLimit] = {
    file = "magic_attr_limit"
  }
}

local function default_check_func(logic_cfg)
  local result = false
  if (logic_cfg.IsReceive == BROARDCAST_TYPE.NONE or logic_cfg.IsReceive == BROARDCAST_TYPE.ONLY_BEGIN) and 0 == logic_cfg.Duration then
    result = true
  end
  return result
end

local function attr_additive_check_func(logic_cfg)
  local result = false
  if not default_check_func(logic_cfg) then
    return result
  end
  local set_type = logic_cfg[4]
  return set_type ~= Config.ATTR_SET_TYPE.CHANGE_BY_DELTA
end

local special_check_func = {
  [MAGIC_TYPE.ChangeAttribAdditive] = attr_additive_check_func
}

function M:get_magic(magic_target, magic_info)
  local logic_cfg = magic_info.logic_cfg
  local magic_type = logic_cfg.type
  local event = M.Event[magic_type]
  if event then
    return MAGIC_EFFECT_TYPE.EVENT, event
  end
  local effect_func = MagicEffectFunc.EffectFunc[magic_type]
  if effect_func then
    local check_func = special_check_func[magic_type] or default_check_func
    if check_func(logic_cfg) then
      return MAGIC_EFFECT_TYPE.EFFECT_FUNC, effect_func
    end
  end
  local magic_file = M.Magic[magic_type]
  Util.assert(magic_file, "magic type error, type : ", magic_type, magic_info.magic_id)
  local file = magic_file.file
  local pool = self.v_magic_pool_mgr[file]
  if not pool then
    local class = require("manager.magic.magic_imp." .. file)
    pool = LuaObjPoolMgr.get_pool(file) or LuaObjPoolMgr.register(file, 50, class)
    self.v_magic_pool_mgr[file] = pool
    self.v_magic_class[magic_type] = class
  end
  local magic = pool:new_obj(magic_target, magic_info)
  return MAGIC_EFFECT_TYPE.OBJECT, magic
end

function M:destroy_magic(magic)
  local magic_file = M.Magic[magic.magic_type]
  local file = magic_file.file
  local pool = self.v_magic_pool_mgr[file]
  if pool then
    pool:destroy_obj(magic)
  end
end

function M:get_magic_class(magic_type)
  return self.v_magic_class[magic_type]
end

function M:collection_active_magic_info()
  for key, magic_pool in pairs(self.v_magic_pool_mgr) do
    local active_objs = magic_pool:get_active_objs()
    if active_objs then
      for magic_base in pairs(active_objs) do
        local magic_info = magic_base.magic_info
        local owner_skill_id = magic_info.owner_skill_id or 0
        local owner_missile_id = magic_info.owner_missile and magic_info.owner_missile.missile_id or 0
        local magic_id = magic_base.magic_id
        JournalMgr:collection_magic_info(owner_missile_id, owner_skill_id, magic_id, magic_info.magic_level, 0, magic_base.rtid, magic_base.owner:get_npc_id(), magic_base.owner.uuid, MagicActionType.ACTIVE)
      end
    end
  end
end

function M:call_free_objs_on_release()
  for _, magic_pool in pairs(self.v_magic_pool_mgr) do
    magic_pool:call_free_objs_on_release()
  end
end

return M
