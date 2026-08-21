local Const = require("const")
local Mathx = require("base.mathx")
local Vec2 = require("base.vec2")
local Base = require("obj.base_component")
local _floor = math.floor
local _abs = math.abs
local DEFAULT_TURN_SPEED = 0.5
local TARGET_MODE = 1
local LOCK_TARGET_MODE = 2
local FREE_MODE = 3
local LOCK_FORWARD = 4
local TURN_TO_TARGET_SPEED = 10
local PLAYER_TURN_SPEED = ShareRes.get_comm_value("HeroTurnVelocity")
local M = Util.create_child_mt(Base)

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_lookat_enabled = true
  self.v_target_dir = nil
  self.v_mode = FREE_MODE
  self.v_enable = true
  self.v_character_cfg = char.character_cfg
  self.v_default_turn_speed = char:is_hero() and PLAYER_TURN_SPEED or TURN_TO_TARGET_SPEED
  if self.v_character_cfg and self.v_character_cfg.LockVelocity and 0 ~= self.v_character_cfg.LockVelocity then
    self.v_default_turn_speed = self.v_character_cfg.LockVelocity
  end
  self:reset_rotate_speed()
end

function M:on_before_destroy()
  self.v_char = nil
  self.v_character_cfg = nil
end

function M:on_destroy_gameobj()
  self.v_trans_body = nil
  self.v_has_setup = nil
  self.v_mode = FREE_MODE
end

function M:set_enable(v)
  self.v_enable = v
end

function M:orienter_setup()
  if not self.v_char:is_real_finish_init() then
    return
  end
  self.v_trans_body = self.v_char.transform
  self.v_rot_body = self.v_trans_body:GetEulerY()
  self.v_now_rot = self.v_rot_body
  self.v_has_setup = true
end

function M:is_setup()
  return self.v_has_setup
end

function M:update_orienter()
  if not self:is_setup() then
    return
  end
  if not self.v_enable then
    return
  end
  if self.v_mode == TARGET_MODE or self.v_mode == LOCK_TARGET_MODE then
    if not self.v_target_uuid and not self.v_target_npc_id then
      return
    end
    local target
    if self.v_target_uuid then
      target = Global.scene_mgr:pick_by_uuid(self.v_target_uuid)
    elseif self.v_target_npc_id then
      target = Global.scene_mgr:get_npc(self.v_target_npc_id)
    end
    if not target or not target.transform then
      return
    end
    local deg = Util.get_lookat_dir(self.v_trans_body, target.transform)
    self:_turn_body(deg)
    self.v_rot_body = self:_clamp_deg(self.v_rot_body)
    local diff = self:_clamp_deg(deg - self.v_rot_body)
    if _abs(diff) <= 1 then
      if self.v_mode == TARGET_MODE then
        self.v_mode = FREE_MODE
      end
      if self.v_callback then
        local callback = self.v_callback
        self.v_callback = nil
        callback()
      end
      self:reset_rotate_speed()
    end
  elseif self.v_mode == LOCK_FORWARD then
    local _, cam_euler = Global.camera:get_euler_angles()
    self:_turn_body(cam_euler)
  else
    if self.v_target_dir and not self:_turn_body(self.v_target_dir) then
      self.v_target_dir = nil
    end
    self.v_callback = nil
  end
end

function M:lock_target(target_uuid)
  if not target_uuid or not Global.scene_mgr:pick_by_uuid(target_uuid) then
    return
  end
  self:unlock_target()
  self.v_mode = LOCK_TARGET_MODE
  self.v_target_uuid = target_uuid
  self.v_target_dir = nil
end

function M:unlock_target()
  self.v_mode = FREE_MODE
  self.v_target_uuid = nil
  self.v_target_npc_id = nil
end

function M:lock_forward()
  self.v_mode = LOCK_FORWARD
  self.v_target_dir = nil
end

function M:get_dir()
  if not self.v_trans_body or self.v_trans_body:IsNull() then
    return 0
  end
  self.v_now_rot = self.v_trans_body:GetEulerY()
  return self.v_now_rot
end

function M:set_euler_y(deg)
  if not self.v_trans_body or self.v_trans_body:IsNull() or self.v_mode ~= FREE_MODE then
    return
  end
  if not self.v_enable then
    return
  end
  self.v_rot_body = deg
  self.v_now_rot = deg
  assert(deg)
end

function M:reset_rotate_speed()
  self.v_turn_speed = DEFAULT_TURN_SPEED
end

function M:set_turn_speed(speed)
  self.v_default_turn_speed = speed
end

function M:set_target_dir(target_dir, force)
  if not self.v_enable then
    return
  end
  if not force then
    if self.v_mode == FREE_MODE or self.v_mode == TARGET_MODE then
      self.v_target_dir = target_dir
      self.v_mode = FREE_MODE
    end
  else
    self.v_target_dir = target_dir
    self.v_rot_body = target_dir
    if self.v_char:is_missile() then
      self.v_trans_body:SetEulerY2(target_dir)
    else
      self.v_trans_body:SetEulerY(target_dir)
    end
    assert(target_dir)
  end
end

function M:_turn_body(deg)
  if not self.v_enable then
    return false
  end
  if _abs(self.v_rot_body - deg) > 0.5 then
    local dt = self.v_char.time_mgr:get_dt_time()
    self.v_rot_body = Mathx.lerp_angle(self.v_rot_body, deg, self.v_default_turn_speed * dt) % 360
    if self.v_char:is_missile() then
      self.v_trans_body:SetEulerY2(self.v_rot_body)
    else
      self.v_trans_body:SetEulerY(self.v_rot_body)
    end
    return true
  else
    self.v_rot_body = deg
    self.v_now_rot = self.v_rot_body
    if self.v_char:is_missile() then
      self.v_trans_body:SetEulerY2(self.v_rot_body)
    else
      self.v_trans_body:SetEulerY(self.v_rot_body)
    end
    return false
  end
end

function M:set_dir_test(dir)
  if self.v_char:is_missile() then
    self.v_trans_body:SetEulerY2(dir)
  else
    self.v_trans_body:SetEulerY(dir)
  end
end

function M:_clamp_deg(deg)
  return _floor(deg) % 360
end

function M:get_target_euler_y()
  if self.v_mode == TARGET_MODE or self.v_mode == LOCK_TARGET_MODE then
    if not self.v_target_uuid and not self.v_target_npc_id then
      return
    end
    local target
    if self.v_target_uuid then
      target = Global.scene_mgr:pick_by_uuid(self.v_target_uuid)
    elseif self.v_target_npc_id then
      target = Global.scene_mgr:get_npc(self.v_target_npc_id)
    end
    if not target or not target.transform then
      return
    end
    return Util.get_lookat_dir(self.v_trans_body, target.transform)
  elseif self.v_target_dir then
    return self.v_target_dir
  else
    local owner_trans = self.v_char.transform
    if owner_trans then
      local _, y = owner_trans:GetEulerAnglesA()
      return y
    end
  end
end

return M
