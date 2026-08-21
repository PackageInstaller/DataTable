local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")

function M:init_sys()
  Base.init_sys(self)
  local minesweeper_misc = ShareRes.get_minesweeper_misc()
  self.v_time_cost_tuple = minesweeper_misc.StaminaSub
  table.insert(self.v_time_cost_tuple, 1, {0, 0})
end

function M:on_destroy()
end

function M:on_reconnect()
end

function M:start_timer()
  local ui = UIMgr:get_ui("ui_act_minesweeper_battle"):ui_show()
end

function M:stop_timer()
  local fight_type = TowerMgr:get_tower_type()
  if fight_type == CommonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    local ui = UIMgr:try_get_visible_ui("ui_act_minesweeper_battle")
    if ui then
      ui:ui_hide()
    end
  end
end

function M:get_hp_cost_range_index(cost_time)
  local index = 0
  for i = #self.v_time_cost_tuple, 1, -1 do
    if cost_time >= self.v_time_cost_tuple[i][1] then
      index = i
      break
    end
  end
  return index
end

function M:get_hp_cost(cost_time)
  local index = self:get_hp_cost_range_index(cost_time)
  return self.v_time_cost_tuple[index][2]
end

function M:get_time_cost_tuple()
  return self.v_time_cost_tuple
end

function M:bind_battle_event()
  self.v_event_handle = self:sys_mq_bind(Const.MSG_SCENE_LOAD_FINISH, self.on_scene_load_finish, self)
end

function M:unbind_battle_event()
  if self.v_event_handle then
    self:sys_mq_unbind(self.v_event_handle)
    self.v_event_handle = nil
  end
end

function M:enter_tower()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    return
  end
  self:bind_battle_event()
end

function M:exit_tower()
  self:unbind_battle_event()
end

function M:on_scene_load_finish()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MINESWEEPER_BATTLE_START)
  end
end

return M
