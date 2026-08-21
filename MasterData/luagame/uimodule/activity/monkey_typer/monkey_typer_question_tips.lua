local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnCheckAnswer()
  UIMgr:get_ui("monkey_typer_question_panel"):ui_show(self.v_activity_id, self.v_question_id)
  self:ui_hide()
end

function ui:on_click_BtnStart()
  MonkeyTyperMgr:req_start_question(self.v_activity_id, self.v_question_id, function()
    self:ui_hide()
  end)
end

function ui:ui_finish_load()
  self:set_button("BtnCheckAnswer", function()
    self:on_click_BtnCheckAnswer()
  end)
  self:set_button("BtnStart", function()
    self:on_click_BtnStart()
  end)
end

function ui:ui_on_show(activity_id, question_id, is_done)
  self.v_activity_id = activity_id
  self.v_question_id = question_id
  self.v_uiobjects.CompleteTips:SetActiveEx(is_done)
  self.v_uiobjects.BtnCheckAnswer:SetActiveEx(is_done)
  self.v_uiobjects.BtnStart:SetActiveEx(not is_done)
  local cfg = ShareRes.get_monkey_typer_question_cfg(activity_id, question_id)
  self.v_uicompents.QuestionDesc_txt.text = cfg.QuestionDesc
  self.v_uicompents.Title_txt.text = cfg.QuestionName
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
