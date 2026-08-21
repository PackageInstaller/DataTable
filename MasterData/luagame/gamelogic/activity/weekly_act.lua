local Base = require("gamelogic.activity.activity")
local M = Util.create_child_mt(Base)
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_STATE = ActivityCfg.ACTY_STATE
local CommonDefine = require("cs_share.common_define")

function M:_init(activity_id, config_id)
  Base._init(self, activity_id)
end

function M:is_end()
  return self.v_is_end
end

function M:get_activity_open_state()
  return ACTY_STATE.ACTY_OPEN
end

return M
