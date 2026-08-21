local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local GOAL_STATE = {
  NOT = 0,
  CAN = 1,
  HAS = 2
}
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
local COLOR = {
  BRIGHT = "f5ede2",
  DARK = "484243",
  BLACK = "000000",
  LINE_COLOR = "CEBDA7"
}

function ui:set_data(data, template_key, show_mask)
  self.v_data = data
  self.v_show_mask = show_mask
  self.v_template_key = template_key
  self.v_uicompents.BtnGet_btn.enabled = true
  self:refresh()
end

function ui:refresh()
  self:refresh_novice_task_content()
end

function ui:ui_on_hide()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  self:release_items_by_template_key(self.v_template_key)
end

function ui:refresh_novice_task_content()
  local data = self.v_data
  local uicom = self.v_uicompents
  local uiobj = self.v_uiobjects
  uicom.TaskName_txt.text = data.Name
  uicom.TaskDesc_txt.text = data.Desc
  local state = TaskMgr:get_task_state(data.Id)
  local can_get = state == TASK_STATE.COMPLETE
  local has_get = state == TASK_STATE.GET_REWARD
  local reward_list = ShareRes.get_award_item_data(data.Award)
  for i = 1, 6 do
    local item_obj = uiobj["ItemObj" .. i]
    local replace_obj = self:get_child_gameobj("Hang", item_obj)
    local item_num = self:get_text("AmountBg/ItemAmount", item_obj)
    local has_get_obj = self:get_child_gameobj("Got_", item_obj)
    local reward_data = reward_list[i]
    item_obj:SetActive(nil ~= reward_data)
    if reward_data then
      self:create_item_obj(nil, replace_obj, self.v_template_key, {
        item_id = reward_data[1],
        click_cb = function()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = reward_data[1]
          })
        end
      })
      item_num.text = reward_data[2]
      has_get_obj:SetActive(has_get)
      item_num.transform:SetAsLastSibling()
    end
  end
  local task_point = uicom.TaskPoint_txt
  local cfg = ShareRes.create("newbie.newbie_task_point", data.Id)
  if cfg then
    task_point.text = cfg.Task_Point
  end
  self:set_button("BtnGet", function()
    self.v_uicompents.BtnGet_btn.enabled = false
    self.v_parent_ui:set_is_play_get_award_anima(true)
    local task_id_list = self.v_parent_ui:get_finished_task_list()
    TaskMgr:submit_task_list(task_id_list, function()
      self:play_finish_anima()
    end)
  end)
  self:set_button("BtnJump", function()
    local select_day = self.v_parent_ui:get_select_day()
    SysOpenMgr:jump_to_sys(data.Jump, true)
    self.v_parent_ui:before_jump(select_day)
  end)
  local progress = uicom.Progress_txt
  local hasGet = uiobj.HasGet
  local continue = uiobj.BtnContinue
  local jump = uiobj.BtnJump
  local bgGet = uiobj.BgGet
  continue:SetActive(state < TASK_STATE.COMPLETE and 0 == data.Jump)
  hasGet:SetActive(has_get)
  jump:SetActive(state < TASK_STATE.COMPLETE and 0 ~= data.Jump)
  bgGet:SetActive(has_get)
  uiobj.BtnGet:SetActive(not has_get and can_get)
  local temp_color = COLOR.DARK
  local taskpoint_x = Util.get_text("Text", uiobj.TaskPoint)
  Util.set_color(uicom.Line_img, has_get and temp_color or COLOR.LINE_COLOR)
  Util.set_color(progress, temp_color)
  Util.set_color(task_point, temp_color)
  Util.set_color(taskpoint_x, temp_color)
  Util.set_color(uicom.TaskName_txt, temp_color)
  Util.set_color(uicom.TaskDesc_txt, temp_color)
  Util.set_color(uicom.TaskPointIcon_img, temp_color)
  Util.set_color(uicom.TaskPoint_img, temp_color)
  local taskInfo = TaskMgr:get_task_by_id(data.Id)
  local taks_pro = taskInfo and taskInfo.progress and #taskInfo.progress > 0 and taskInfo.progress[1].progress or 0
  local condition_id = data.Condition[1]
  local total = ShareRes.create("condition.condition", condition_id)
  if not total then
    Log.Error("read condition config failure! condition_id=", condition_id)
  end
  if taskInfo and taskInfo.state and (taskInfo.state == Config.CommonDefine.TaskState.Complete or taskInfo.state == Config.CommonDefine.TaskState.GotAward) then
    taks_pro = total.Value
  end
  progress.text = string.format("(%d/%d)", taks_pro, total.Value)
  self.v_uicompents.ProgressBar_sld.value = taks_pro / total.Value
  self.v_uicompents.OnFinshDone_pd:Play()
end

function ui:play_finish_anima()
  self.v_parent_ui:set_is_play_get_award_anima(true)
  self.v_parent_ui:animate_spine()
  
  local function cb()
    self.v_uicompents.OnFinshDone_pd:Play()
    self.v_parent_ui:set_is_play_get_award_anima(false)
    local ui_activity = UIMgr:try_get_visible_ui("ui_activity")
    if ui_activity then
      ui_activity:on_newbie_task_update()
    end
    self.v_timer = nil
  end
  
  local pd = self.v_uicompents.OnFinsh_pd
  if not pd:IsNull() then
    self.v_timer = Timer:add_timer("play_finish_anima", pd.duration, cb)
    pd:Play()
  end
end

return ui
