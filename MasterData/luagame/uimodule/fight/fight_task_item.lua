local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TEXT_COLOR_TAG = "<color=#%s>（%s/%s）</color>"
local HP_COLOR_TAG = "<color=#76D884>（%s）</color>"
local COMPLETE_COLOR = {
  [true] = "ffda9d",
  [false] = "ffffff"
}
local TASK_STATUS = {
  COMPLETED = 1,
  UNCOMPLETED = 2,
  FAILED = 3
}
local TOWER_TASK_COLOR = {
  [TASK_STATUS.COMPLETED] = "F5EDE2",
  [TASK_STATUS.UNCOMPLETED] = "F5EDE2",
  [TASK_STATUS.FAILED] = "909090"
}

local function _get_task_status(completed, uncompleted)
  local status
  if completed then
    status = TASK_STATUS.COMPLETED
  elseif uncompleted then
    status = TASK_STATUS.UNCOMPLETED
  else
    status = TASK_STATUS.FAILED
  end
  return status
end

function ui:ui_finish_load()
  self.v_text = self:get_text()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:_get_comp_and_str(task_type, data, is_more_then)
  local status, show_value
  show_value = FightDataMgr:get_tower_task_data(task_type)
  local uncompleted = is_more_then and show_value >= data.arg[1] or show_value <= data.arg[1]
  status = _get_task_status(data.status, uncompleted)
  return status, show_value
end

function ui:get_comp_and_str(task_id, cfg, data)
  local temp_str = cfg.ConditionDesc
  local TOWER_TASK_TYPE = Config.CommonDefine.TOWER_TASK_TYPE
  local percent_str
  local arg_str = data.arg[1]
  local show_value, status, completed
  if cfg.ConditionType == TOWER_TASK_TYPE.FIGHT_TIME_NOT_USE_HELP_BUDDY then
    local not_use_assit = FightDataMgr:get_tower_task_data(cfg.ConditionType) <= 0
    local time = FightDataMgr:get_tower_task_data(TOWER_TASK_TYPE.FIGHT_TIME)
    status = _get_task_status(data.status, not_use_assit and time <= data.arg[1])
    show_value = math.max(0, time)
  elseif cfg.ConditionType == TOWER_TASK_TYPE.API_ADD_PROGRESS then
    local value = BattleTaskMgr:get_record_progress_param(task_id) or 0
    local comp = data.status or value >= data.arg[1]
    status = _get_task_status(comp, not comp)
    show_value = value
  elseif cfg.ConditionType == TOWER_TASK_TYPE.API_ADD_PROGRESS_FAIL then
    local value = BattleTaskMgr:get_record_progress_param(task_id) or 0
    value = data.arg[1] + value
    status = _get_task_status(data.status, value > 0)
    show_value = math.max(value, 0)
  elseif cfg.ConditionType == TOWER_TASK_TYPE.BUDDY_HP_RATIO then
    local value = FightDataMgr:get_tower_task_data(cfg.ConditionType)
    value = math.floor(value * 10000)
    status = _get_task_status(data.status, not data.status)
    arg_str = data.arg[1] / 100 .. "%"
    show_value = value / 100 .. "%"
    percent_str = string.format(HP_COLOR_TAG, show_value)
  elseif cfg.ConditionType == TOWER_TASK_TYPE.PASS_FLOOR_NUM then
    local value = FightDataMgr:get_tower_task_data(cfg.ConditionType)
    local comp = data.status or value >= data.arg[1]
    status = _get_task_status(comp, not comp)
    show_value = value
  elseif cfg.ConditionType == TOWER_TASK_TYPE.FORMAT_LIMIT then
    local value = FightDataMgr:get_tower_task_data(cfg.ConditionType)
    status = _get_task_status(data.status or value <= data.arg[1])
    show_value = value
  elseif cfg.ConditionType == TOWER_TASK_TYPE.FIGHT_TIME then
    local value = FightDataMgr:get_tower_task_data(cfg.ConditionType)
    status = _get_task_status(data.status, value <= data.arg[1])
    show_value = math.min(value, data.arg[1])
  elseif cfg.ConditionType == TOWER_TASK_TYPE.DIED_MONSTER then
    local value = FightDataMgr:get_tower_task_data(cfg.ConditionType)
    local comp = data.status or value >= data.arg[1]
    status = _get_task_status(comp, not comp)
    show_value = math.min(value, data.arg[1])
  else
    status, show_value = self:_get_comp_and_str(cfg.ConditionType, data, false)
  end
  status = status or TASK_STATUS.FAILED
  completed = status == TASK_STATUS.COMPLETED
  local color = TOWER_TASK_COLOR[status]
  if not percent_str and not completed then
    percent_str = string.format(TEXT_COLOR_TAG, color, show_value, arg_str)
  end
  temp_str = Util.format_str(temp_str, arg_str)
  if percent_str then
    temp_str = temp_str .. percent_str
  end
  local alpha = completed and 0.4 or 1
  return status, temp_str, alpha
end

function ui:set_tower_task_data(cfg, data)
  local task_id = cfg.Id
  if not cfg then
    Log.Error("获取评星任务配置失败，id：", task_id)
    return
  end
  local status, show_value, alpha = self:get_comp_and_str(task_id, cfg, data)
  local failed = status == TASK_STATUS.FAILED
  local completed = status == TASK_STATUS.COMPLETED
  self.v_uiobjects.Complete:SetActive(completed)
  self.v_uiobjects.Lose:SetActive(failed)
  self.v_uiobjects.LoseLine:SetActive(failed)
  if show_value then
    local color = TOWER_TASK_COLOR[status]
    Util.set_color(self.v_text, color, alpha)
    self.v_text.text = show_value
    self.v_text.component.enabled = true
  else
    self.v_text.component.enabled = false
  end
end

function ui:set_track_task_data(cfg, task_item)
  local task_com = task_item:check_condition_complete(cfg.Id)
  local max_value = cfg.Value
  local cur_value = task_item:get_task_progress(cfg.Id)
  local temp_str = cfg.Desc
  local percent_str, arg_str, value_str
  local color = COMPLETE_COLOR[task_com]
  self.v_uiobjects.Complete:SetActive(task_com)
  arg_str = max_value
  value_str = cur_value
  percent_str = string.format(TEXT_COLOR_TAG, color, value_str, arg_str)
  temp_str = Util.format_str(temp_str, arg_str) .. percent_str
  self.v_text.text = temp_str
end

return ui
