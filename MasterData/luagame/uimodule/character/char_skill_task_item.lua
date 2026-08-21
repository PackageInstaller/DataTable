local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_bg_done = {
    "Mask",
    BIND_TYPE.IMAGE
  },
  v_bg_finish = {
    "Bg_finish",
    BIND_TYPE.IMAGE
  },
  v_bg_unfinish = {
    "Bg_unfinish",
    BIND_TYPE.IMAGE
  },
  v_now = {
    "Now",
    BIND_TYPE.TEXT
  },
  v_task_content = {
    "TaskContent",
    BIND_TYPE.TEXT
  },
  v_total = {
    "Total",
    BIND_TYPE.TEXT
  },
  v_task_finish_eff = {
    "Ani_VX_NorTaskObj_FIN",
    BIND_TYPE.OBJECT
  },
  v_task_unfinish_eff = {
    "Ani_VX_NorTaskObj_Unfinish",
    BIND_TYPE.OBJECT
  }
}
local Vec2 = require("base.vec2")
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE

function ui:ui_finish_load()
  self:init_model(MODEL)
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    self:click_task_item()
  end)
end

function ui:ui_on_hide()
  self.v_buddy_info = nil
end

function ui:set_data(task_id)
  self.v_task_id = task_id
  self.v_task_cfg = ShareRes.get_task_cfg(task_id)
  self.v_task_data = TaskMgr:get_task_by_id(task_id)
  self.v_task_unfinish_eff:SetActive(false)
  self.v_task_unfinish_eff:SetActive(true)
  self.v_task_finish_eff:SetActive(false)
  self:refresh_all_ui()
end

function ui:refresh_all_ui()
  self:refresh_task_content()
  self:refresh_task_progress()
  self:refresh_task_state()
end

function ui:refresh_task_content()
  self.v_task_content.text = self.v_task_cfg.Desc
end

function ui:refresh_task_progress()
  local condition_id = self.v_task_cfg.Condition[1]
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local now_num = self.v_task_data.condition[condition_id]
  local need_num = condition_cfg.Value
  local item_count_txt
  if now_num < need_num then
    item_count_txt = Util.set_str_color("<color=#E22525>", now_num)
  else
    item_count_txt = now_num
  end
  self.v_now.text = item_count_txt
  self.v_total.text = need_num
  local bar_fill = Util.get_rect_transform("BarFill", self.v_object)
  local bar_image = Util.get_rect_transform("Image", bar_fill.gameObject)
  bar_image.sizeDelta = Vec2.New(now_num / need_num * bar_fill.sizeDelta.x - bar_image.anchoredPosition.x, bar_fill.sizeDelta.y)
end

local COMPLETE_TYPE = {
  unfinish = 1,
  finish = 2,
  done = 3
}

function ui:refresh_task_state()
  local task_data = self.v_task_data
  local complete
  if task_data.state == TASK_STATE.receive then
    complete = COMPLETE_TYPE.finish
  elseif task_data.state == TASK_STATE.received then
    complete = COMPLETE_TYPE.done
  else
    complete = COMPLETE_TYPE.unfinish
  end
  self.v_uiobjects.Bg_unfinish:SetActive(complete == COMPLETE_TYPE.unfinish)
  self.v_uiobjects.Bg_finish:SetActive(complete == COMPLETE_TYPE.done or complete == COMPLETE_TYPE.finish)
  self.v_uiobjects.Mask:SetActive(complete == COMPLETE_TYPE.done)
  self.v_uicompents.TaskId_txt.text = "任务id:" .. task_data.id
  self.v_uiobjects.TaskId:SetActive(UIMgr:get_ui("char_skill_task").is_show_task_id)
end

function ui:click_task_item()
  local task_data = self.v_task_data
  if task_data.state == TASK_STATE.received then
    return
  elseif task_data.state == TASK_STATE.none then
    Util.show_message_tip(1053)
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SUBMIT_CHAR_TASK_SKILL)
  msg.mm_obj = self.v_task_data
end

function ui:play_eff()
  local task_data = self.v_task_data
  if task_data.state == TASK_STATE.receive then
    self.v_task_unfinish_eff:SetActive(false)
    self.v_task_finish_eff:SetActive(true)
  end
end

function ui:play_eff_by_id(task_id)
  if task_id == self.v_task_id then
    local task_data = self.v_task_data
    if task_data.state == TASK_STATE.receive then
      self.v_task_unfinish_eff:SetActive(false)
      self.v_task_finish_eff:SetActive(true)
    end
  end
end

return ui
