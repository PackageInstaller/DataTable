local SpineController = typeof(CS.Game.SpineController)
local M = Util.create_class()

function M:_init()
  self.v_spine_list = {}
  self.v_last_loop_anim_name = {}
  Util.bind_msg(self, Const.MSG_ON_SET_STORY_SPEED, self.set_anim_speed, self)
end

function M:on_destory()
  for _, obj in pairs(self.v_spine_list) do
    if not obj:IsNull() then
      ResPoolMgr:release(obj)
    end
  end
  self.v_spine_list = {}
  self.v_last_loop_anim_name = {}
  Util.unbind_all_msg(self)
end

function M:release_spine_obj(res_name)
  local spine_obj = self.v_spine_list[res_name]
  if not spine_obj or spine_obj:IsNull() then
    return
  end
  ResPoolMgr:release(spine_obj)
  self.v_spine_list[res_name] = nil
  self.v_last_loop_anim_name[res_name] = nil
end

function M:load_spine_res(res_name, callback, is_sync_load)
  res_name = Path.get_spine_name(res_name)
  
  local function load_cb(obj)
    self.v_spine_list[res_name] = obj
    local spine_component = obj:GetComponent(SpineController)
    if spine_component and not spine_component:IsNull() then
      spine_component:ClearAnimationInfo()
    end
    if callback then
      callback(obj)
    end
  end
  
  if is_sync_load then
    local obj = ResPoolMgr:get_spine(res_name)
    load_cb(obj)
  else
    ResPoolMgr:get_spine_async(res_name, load_cb)
  end
end

function M:play_loop_anim(res_name, anim_name)
  if not res_name or "" == res_name then
    return
  end
  local spine_obj = self.v_spine_list[res_name]
  if not spine_obj or spine_obj:IsNull() then
    return
  end
  local last_loop_anim_name = self.v_last_loop_anim_name[res_name]
  if last_loop_anim_name == anim_name then
    return
  end
  local spine_component = spine_obj:GetComponent(SpineController)
  spine_component:SetLoopAnimation(anim_name)
  self.v_last_loop_anim_name[res_name] = anim_name
end

function M:play_anim(res_name, anim_name, is_loop, track_index, delay, callback, timeScale)
  local spine_obj = self.v_spine_list[res_name]
  if not spine_obj or spine_obj:IsNull() then
    return
  end
  local spine_component = spine_obj:GetComponent(SpineController)
  spine_component.OnPlayEnd = callback
  spine_component:PlayAnimation(track_index, anim_name, is_loop)
end

function M:add_animation(res_name, track_index, anim_name, is_loop, delay)
  local spine_obj = self.v_spine_list[res_name]
  if not spine_obj or spine_obj:IsNull() then
    return
  end
  local spine_component = spine_obj:GetComponent(SpineController)
  spine_component:AddAnimation(track_index, anim_name, is_loop, delay)
end

function M:set_anim_speed(msg)
  if not msg then
    return
  end
  local speed = msg.mm_obj
  for _, spine_obj in pairs(self.v_spine_list) do
    if spine_obj and not spine_obj:IsNull() then
      local spine_component = spine_obj:GetComponent(SpineController)
      if spine_component then
        local spine_anim = spine_component.mSkeletonAnimation
        if spine_anim then
          spine_anim.timeScale = speed or 1
        end
      end
    end
  end
end

function M:get_default_mix_duration(res_name)
  local spine_obj = self.v_spine_list[res_name]
  if not spine_obj or spine_obj:IsNull() then
    return
  end
  local spine_component = spine_obj:GetComponent(SpineController)
  local mix_duration = spine_component:GetDefaultMixDuration()
  return mix_duration
end

return M
