local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local helper = {}

function helper.get_task_receive_num()
  local result_num = helper.get_task_active_receive_num()
  result_num = result_num + TaskMgr:get_task_event_red_count()
  return result_num
end

function helper.get_task_active_receive_num()
  local daily_task_reward_list = ShareRes.create("task.daily_task")
  local weekly_task_reward_list = ShareRes.create("task.weekly_task")
  local result_num = 0
  result_num = result_num + helper.cal_receive_num(daily_task_reward_list)
  result_num = result_num + helper.cal_receive_num(weekly_task_reward_list)
  return result_num
end

function helper.cal_receive_num(task_list)
  local result_num = 0
  for _, config in pairs(task_list) do
    local task_id = config.TaskId
    local task_info = TaskMgr:get_task_by_id(task_id)
    if task_info then
      local task_state = task_info.state
      if task_state == TASK_STATE.receive then
        result_num = result_num + 1
      end
    end
  end
  return result_num
end

return helper
