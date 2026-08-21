local Base = require("obj.state.state_obj_base")
local ACT_DEFINE = Config.ACT_DEFINE
local STATE_NAME = Config.STATE_NAME
local M = Util.create_child_mt(Base)

function M:state_on_enter()
  Base.state_on_enter(self)
  self.v_owner.v_ride.state_manager:to_idle_state()
end

function M:state_update_value()
  self:try_action_auto_leave(ACT_DEFINE.Ride)
  self:set_keep_end(nil, true)
end

function M:state_get_name()
  return Config.STATE_NAME.ride
end

function M:state_can_reenter()
  return true
end

function M:state_on_leave(state_name)
  Base.state_on_leave(self)
  if state_name ~= STATE_NAME.ridemove and self.v_owner:is_hero() then
    RidingSys:req_unride()
  end
end

return M
