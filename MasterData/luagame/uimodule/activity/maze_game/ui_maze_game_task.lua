local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TASK_ITEM_CLASS = require("uimodule.activity.maze_game.ui_maze_game_task_item")
local CONTENT_TASKTEM_TEMP_KEY = "CONTENT_TASKTEM_TEMP_KEY"
local TASK_STATE = Config.CommonDefine.TaskState

function ui:on_click_BtnAllGet()
  local task_list = ShareRes.get_task_group_cfg(self.v_task_group_id)
  self.v_get_task_id_list = {}
  for task_id in pairs(task_list) do
    local task_data = TaskMgr:get_task_by_id(task_id)
    if task_data and task_data.state == TASK_STATE.Complete then
      table.insert(self.v_get_task_id_list, task_id)
    end
  end
  TaskMgr:submit_task_list(self.v_get_task_id_list, function()
    self:refresh_task()
  end)
end

function ui:click_get_award_btn(task_id)
  if not TaskMgr:check_task_can_receive(task_id) then
    return
  end
  TaskMgr:submit_task(task_id, function()
    self:refresh_task()
  end)
end

function ui:on_click_BtnClose()
  self:ui_hide()
end

function ui:on_click_BtnRetX()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnAllGet", function()
    self:on_click_BtnAllGet()
  end)
  self:set_button("BtnClose", function()
    self:on_click_BtnClose()
  end)
  self:set_button("BtnRetX", function()
    self:on_click_BtnRetX()
  end)
  self.v_task_item_list = {}
  self:register_exist_auto_template(CONTENT_TASKTEM_TEMP_KEY, self.v_uiobjects.CtTem, self.v_uiobjects.TaskContent)
end

function ui:ui_on_show(task_group_id)
  self:refresh_task(task_group_id)
end

function ui:ui_on_hide()
  self:clear_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_task(task_group_id)
  if task_group_id then
    self.v_task_group_id = task_group_id
  end
  self:clear_item()
  local task_id_list, all_task_got, is_have_task_receive = TaskMgr:get_sort_task_list(self.v_task_group_id)
  self.v_uiobjects.BtnAllGet:SetActive(is_have_task_receive)
  self.v_uiobjects.AllGot:SetActive(all_task_got)
  for i = 1, #task_id_list do
    local task_id = task_id_list[i]
    local obj = self:get_auto_cache(CONTENT_TASKTEM_TEMP_KEY)
    local task_item = TASK_ITEM_CLASS:ui_wrap_ex(self, obj, true)
    self.v_task_item_list[task_id] = task_item
    task_item:set_data(task_id, function()
      self:ui_hide()
    end, true)
  end
end

function ui:clear_item()
  self:give_back_auto_cache(CONTENT_TASKTEM_TEMP_KEY)
  for key, item in pairs(self.v_task_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_task_item_list[key] = nil
  end
end

return ui
