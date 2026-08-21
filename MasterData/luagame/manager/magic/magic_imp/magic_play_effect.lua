local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

local function _get_owner_auto_scale(owner)
  local model_cfg = owner.model_cfg
  if not model_cfg then
    return
  end
  return model_cfg.EffectScale
end

function M:on_effect()
  local owner = self.owner
  local effect = self.cfg.Effect
  local bone = self.cfg.EffectJoint
  local is_world = self.cfg.EffectWorld ~= nil
  local is_auto_scaling = self.cfg.AutoScaling
  assert(owner, "Effect Target is nil")
  assert(effect, "Effect is nil")
  local scale
  if is_auto_scaling then
    scale = _get_owner_auto_scale(owner)
  end
  if is_world then
    SceneMgr:create_scene_effect(effect, owner.transform.position, nil, nil, nil, nil, scale)
  else
    local effect_data = owner.act_effect_ctrl.create_effect_param()
    effect_data.prefab_name = effect
    effect_data.attach_point = bone
    effect_data.scale = scale
    effect_data.is_world = is_world
    effect_data.is_weapon_attach = self.cfg.IsWeaponAttach
    self.v_effect_id = owner.act_effect_ctrl:play_attach_effect(effect_data, owner)
  end
end

function M:on_remove(magic_map)
  if next(magic_map) == nil then
    self.owner.act_effect_ctrl:stop_effect(self.v_effect_id)
  end
end

return M
