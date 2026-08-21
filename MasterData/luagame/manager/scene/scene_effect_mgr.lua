local Vec3 = require("base.vec3")
local EFFECT_LOOP_TIME = -1
local UPDATE_INTERVAL = 0.2
local EFFECT_IDX = 0
local TypeRgbSplit = typeof(CS.EffectRgbSplit)
local M = Util.create_class()

function M:_init()
  self.v_is_destroy = false
  self.v_update_time = 0
  self.v_effect_list = {}
end

function M:release()
  self.v_is_destroy = true
  self:clear_effect_list()
end

function M:clear_effect_list()
  for k, v in pairs(self.v_effect_list) do
    self:_destroy_effect(v, k)
  end
end

function M:remove_effect_by_name(obj_name)
  if not obj_name then
    return
  end
  for k, v in pairs(self.v_effect_list) do
    if v.obj_name and v.obj_name == obj_name then
      self:_destroy_effect(v, k)
      return
    end
  end
end

function M._realease_gameobj(gameobj)
  gameobj.transform:SetPositionA(0, 10000, 0)
  ResPoolMgr:release(gameobj)
end

function M:_destroy_effect(effect_info, k)
  if effect_info.remove_callback then
    effect_info.remove_callback()
  end
  effect_info.is_destroy = true
  if k then
    self.v_effect_list[k] = nil
  end
  local gameobject = effect_info.gameobject
  if gameobject and not gameobject:IsNull() then
    if k and effect_info.end_length > 0 then
      if effect_info.effect_status then
        effect_info.effect_status:PlayEndEffect()
      end
      Timer:add_timer("delay cache", effect_info.end_length, M._realease_gameobj, gameobject)
    else
      M._realease_gameobj(gameobject)
    end
  end
end

function M:create_effect(prefab_name, position, duration, obj_name, callback, remove_callback, dir, scale, not_time_scale)
  EFFECT_IDX = EFFECT_IDX + 1
  local effect_info = {
    elapse_time = 0,
    duration = duration,
    index = EFFECT_IDX,
    obj_name = obj_name,
    dir = dir,
    scale = scale,
    not_time_scale = not_time_scale
  }
  ResPoolMgr:get_spell_effect_async(prefab_name, nil, function(gameobject, _, need_restart)
    if self.v_is_destroy or effect_info.is_destroy then
      effect_info.gameobject = gameobject
      self:_destroy_effect(effect_info)
      return
    end
    gameobject:ResetAttr()
    gameobject:SetActive(true)
    local transform = gameobject.transform
    if not position then
      transform:SetPositionA(0, 10000, 0)
    else
      transform:SetPositionA(position.x, position.y, position.z)
    end
    if obj_name then
      gameobject.name = obj_name
    end
    if dir then
      transform:SetEulerY2(dir)
    end
    if scale then
      transform:SetLocalScaleA(scale, scale, scale)
    end
    local cid = gameobject:GetInstanceID()
    local effect_duration, effect_status = ResPoolMgr:get_effect_data(cid)
    effect_info.cid = cid
    effect_info.gameobject = gameobject
    effect_info.loading = false
    effect_info.remove_callback = remove_callback
    effect_info.effect_status = effect_status
    local animator = Util.get_animator(nil, gameobject)
    local end_effect_time = animator and effect_status:GetEndLength() or -1
    effect_info.end_length = end_effect_time
    if not duration or 0 == duration then
      effect_info.duration = effect_duration
    end
    if 1 ~= GlobalTimeMgr:get_time_scale() and not effect_info.not_time_scale then
      effect_status:SetSpeed(GlobalTimeMgr:get_time_scale())
    else
      effect_status:SetSpeed(1)
    end
    if callback then
      callback(effect_info)
    end
  end)
  self.v_effect_list[effect_info.index] = effect_info
  return effect_info
end

function M:show_rgb_split(delay, time, power, inteval, dirx, diry, dirz)
  time = time or 0
  if time <= 0 or power <= 0 or inteval > time then
    return
  end
  delay = delay or 0
  if not self.v_rgb_split then
    local node = UnityFind("Service")
    self.v_rgb_split = node:AddComponent(TypeRgbSplit)
    self.v_rgb_split:Stop()
  end
  local sp = self.v_rgb_split
  sp.Delay = delay
  sp.Duration = time
  sp.ShakeStrength = power
  sp.ShakeInteval = inteval
  sp.ShakeDir = Vec3.New(dirx, diry, dirz)
  sp:Restart()
end

function M:stop_rgb_split()
  if not self.v_rgb_split then
    return
  end
  self.v_rgb_split:Stop()
end

function M:update(dt)
  if Util.is_destroy(Global.hero) then
    return
  end
  self.v_update_time = self.v_update_time + Global.delta_time
  if self.v_update_time < UPDATE_INTERVAL then
    return
  end
  local time_mgr = Global.hero.time_mgr
  local dt_time = self.v_update_time * time_mgr:get_time_scale()
  for idx, effect_info in pairs(self.v_effect_list) do
    if effect_info.duration ~= EFFECT_LOOP_TIME and effect_info.gameobject then
      effect_info.elapse_time = effect_info.elapse_time + dt_time
      if effect_info.elapse_time > effect_info.duration then
        self:_destroy_effect(effect_info, idx)
      end
    end
  end
  self.v_update_time = 0
end

function M:update_speed(pause, is_global_scale)
  local new_speed
  for _, effect_info in pairs(self.v_effect_list) do
    if pause then
      new_speed = 0
    elseif is_global_scale and not effect_info.not_time_scale then
      new_speed = GlobalTimeMgr:get_time_scale()
    else
      new_speed = 1
    end
    if effect_info.effect_status then
      effect_info.effect_status:SetSpeed(new_speed)
    end
  end
end

return M
