local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Math = require("base.mathx")
local MONKEY_QUESTION_ITEM_CLASS = require("uimodule.activity.monkey_typer.monkey_question_item")
local QUESTIONCONTENT_QUESTIONTEM_TEMP_KEY = "QUESTIONCONTENT_QUESTIONTEM_TEMP_KEY"
local QUESTION_STATU = Config.CommonDefine.MONKEY_TYPEWRITER_QUESTION_STATE

function ui:on_click_BtnRet1()
  if self.v_blocker then
    return
  end
  self.v_blocker = true
  MonkeyTyperMgr:req_finish_question(self.v_activity_id, self.v_question_id, function()
    self:ui_hide()
  end)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnJump", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnNext", function()
    self:on_click_BtnRet1()
  end)
  self.v_content_vertical_layout_group = Util.get_component(nil, self.v_uiobjects.QuestionContent, typeof(UnityEngine.UI.VerticalLayoutGroup))
  self:register_exist_auto_template(QUESTIONCONTENT_QUESTIONTEM_TEMP_KEY, self.v_uiobjects.QuestionTem, self.v_uiobjects.QuestionContent)
end

function ui:ui_on_show(activity_id, question_id)
  self.v_blocker = false
  self.v_activity_id = activity_id
  self.v_question_id = question_id
  self.v_selected_idx = nil
  self:refresh_list()
  self:bind_auto_mq(Const.MSG_ON_MONKEY_TYPER_DATA_UPDATE, self.on_refresh_data, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
  self.v_blocker = false
end

function ui:ui_on_destroy()
end

function ui:refresh_list(force_to_top)
  local question_id, question_state = MonkeyTyperMgr:get_last_question_data(self.v_activity_id)
  local question_cfg_list = MonkeyTyperMgr:get_question_cfg_list(self.v_activity_id)
  if not question_id then
    return
  end
  local selected_idx
  self.v_question_id = question_id
  self.v_question_num = #question_cfg_list
  self:clear_wrap_items()
  self.v_question_item_list = {}
  self:give_back_auto_cache(QUESTIONCONTENT_QUESTIONTEM_TEMP_KEY)
  for idx, cfg in ipairs(question_cfg_list) do
    if cfg.QuestionId == self.v_question_id then
      self.v_selected_cfg = cfg
      selected_idx = idx
    end
    local state = MonkeyTyperMgr:get_question_state(cfg.ActivityId, cfg.QuestionId)
    local is_lock = not state
    local obj = self:get_auto_cache(QUESTIONCONTENT_QUESTIONTEM_TEMP_KEY)
    local item = MONKEY_QUESTION_ITEM_CLASS:ui_wrap_ex(self, obj, true)
    item:set_data(self.v_activity_id, cfg, idx, is_lock)
    self.v_question_item_list[#self.v_question_item_list + 1] = item
  end
  self:refresh_selected(self.v_selected_cfg, selected_idx)
  local move_row, offset = 0, 0
  if not force_to_top then
    move_row = Math.Clamp(selected_idx - 3, 0, #self.v_question_item_list - 4)
    offset = self.v_content_vertical_layout_group.spacing + self.v_uicompents.QuestionTem_rect.rect.height
  end
  self.v_uicompents.QuestionContent_rect:SetAnchoredPositionA(0, move_row * offset)
end

function ui:clear_wrap_items()
  if self.v_question_item_list then
    for idx = #self.v_question_item_list, 1, -1 do
      local item = self.v_question_item_list[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_question_item_list[idx] = nil
    end
    self.v_question_item_list = nil
  end
end

function ui:on_refresh_data()
  local idx = self.v_selected_idx
  self.v_selected_idx = nil
  self:refresh_selected(self.v_selected_cfg, idx, nil, true)
  MonkeyTyperMgr:req_refresh_question(self.v_activity_id)
end

function ui:refresh_selected(cfg, idx, is_click, is_msg)
  if idx == self.v_selected_idx then
    return
  end
  self.v_selected_idx = idx
  self.v_uicompents.Title_txt.text = Util.format_str("问题{1}", Config.NUMBER_TO_CHINESE[idx])
  self.v_uicompents.QuestionDesc_txt.text = cfg.QuestionDesc
  self.v_uicompents.AnswerDesc_txt.text = cfg.Answer
  local state = MonkeyTyperMgr:get_question_state(cfg.ActivityId, cfg.QuestionId)
  if not state or state == QUESTION_STATU.PARSING then
    local target_font_count = cfg.FontCount
    local cur_font_count = MonkeyTyperMgr:get_font_count(self.v_activity_id)
    local progress = cur_font_count / target_font_count
    self.v_uicompents.AnswerSlider_sld.value = progress
    if progress >= 1 then
      progress = 0.99
    end
    self.v_uicompents.Progress_txt.text = math.floor(progress * 100) .. "%"
    self.v_uiobjects.Answering:SetActiveEx(true)
    self.v_uiobjects.AnswerDesc:SetActiveEx(false)
  else
    self.v_uiobjects.Answering:SetActiveEx(false)
    self.v_uiobjects.AnswerDesc:SetActiveEx(true)
  end
  local is_last_one = idx == self.v_question_num
  self.v_uiobjects.BtnNext:SetActiveEx(state == QUESTION_STATU.COMPLETE and not is_last_one)
  self.v_uiobjects.BtnDone:SetActiveEx(state == QUESTION_STATU.GAINED_AWARD or state == QUESTION_STATU.COMPLETE and is_last_one)
  self.v_uiobjects.BtnJump:SetActiveEx(state == QUESTION_STATU.PARSING)
  if not is_msg then
    self:update_items_selected(idx, is_click)
  end
end

function ui:update_items_selected(idx, is_click)
  if self.v_question_item_list then
    for i, item in ipairs(self.v_question_item_list) do
      item:update_selected(i == idx, is_click)
    end
  end
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

return ui
