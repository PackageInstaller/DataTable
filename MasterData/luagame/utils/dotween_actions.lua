local _tinsert = table.insert
local Vec3 = require("base.vec3")
local DOTWEEN_FUN = {
  fade = "_fade",
  move = "_move",
  scale = "_scale",
  wait = "_wait"
}
local ACTION_MAX = 9
local ACTION_GROUP_MAX = 5
local DotweenAction = Util.create_class()

function DotweenAction:_init(action_id, transform, alpha_target, call_back)
  self.v_action_id = action_id
  self.v_transform = transform
  self.v_alpha_target = alpha_target
  self.v_call_back = call_back
  self.v_sequence = Util.create_sequence()
  if Global.BloodHelper then
    Global.BloodHelper.cache_tween_handler(self.v_sequence, self)
  end
  self:_start()
end

function DotweenAction:_fade(time, alpha_value)
  self.v_sequence:Append(self.v_alpha_target:DOFade(alpha_value, time))
end

function DotweenAction:_move(time, x, y, z)
  local position = self.v_transform.localPosition
  local vector3 = Vec3.New(position.x + x, position.y + y, position.z + z)
  self.v_sequence:Append(self.v_transform:DOLocalMove(vector3, time, false))
end

function DotweenAction:_scale(time, scale)
  self.v_sequence:Append(self.v_transform:DOScale(scale, time))
end

function DotweenAction:_wait(time)
  self.v_sequence:AppendInterval(time)
end

function DotweenAction:do_cb()
  if self.v_call_back then
    local cb = self.v_call_back
    self.v_call_back = nil
    cb()
  end
end

function DotweenAction:_start()
  for i = 1, ACTION_MAX do
    local id = self.v_action_id + (i - 1)
    local dotween_cfg = ShareRes.create("common.dotween", id)
    if not dotween_cfg then
      break
    end
    local func = DOTWEEN_FUN[dotween_cfg.name]
    if not Util.is_client_only() and func == DOTWEEN_FUN.scale then
      local scale_data = dotween_cfg.params[1]
      local scale_num = scale_data[2]
      local time = scale_data[1]
      self[func](self, time, scale_num)
    else
      self[func](self, table.unpack(dotween_cfg.params[1]))
    end
  end
  self.v_sequence:OnComplete(function()
    self:do_cb()
    local sq = self.v_sequence
    self.v_sequence = nil
    if sq and Global.BloodHelper then
      Global.BloodHelper.remove_single_handler(sq)
    end
  end)
end

local M = {}

function M.play(transform, alpha_target, base_action_id, call_back)
  local action_run_count = 0
  
  local function complete_call_back()
    action_run_count = action_run_count - 1
    if 0 == action_run_count and call_back then
      call_back()
    end
  end
  
  local do_action_list = {}
  for i = 0, ACTION_GROUP_MAX do
    local action_id = base_action_id + i * 10
    local dotween_cfg = ShareRes.create("common.dotween", action_id)
    if not dotween_cfg then
      break
    end
    local action = DotweenAction:new(action_id, transform, alpha_target, complete_call_back)
    _tinsert(do_action_list, action)
  end
  action_run_count = #do_action_list
  return do_action_list
end

return M
