local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local MathX = require("base.mathx")
local _clamp = MathX.Clamp
local QiannnengProgressImgFill = ShareRes.get_comm_string_value("QiannnengProgressImgFill")

function ui:ui_finish_load()
  self:set_button("AdvanceDesc", function()
    self:try_show_keyword()
  end)
  self.v_btn_list = {}
  for i = 1, 6 do
    self:set_button("Advance" .. i, function()
      self:on_click_btn(i)
    end)
    local go = self.v_uiobjects["Advance" .. i]
    self.v_btn_list[i] = {
      normal_bg = Util.get_child_gameobj("NorBg_", go),
      normal_selected = Util.get_child_gameobj("NorBg_/NorSelect_", go),
      active_bg = Util.get_child_gameobj("ActiveBg_", go),
      active_selected = Util.get_child_gameobj("ActiveBg_/ActiveSelect_", go),
      red_go = Util.get_child_gameobj("Red", go),
      icon = Util.get_image("AdvanceIcon_", go)
    }
  end
  self.v_tmp_text = self.v_uiobjects.AdvanceDesc:GetComponent(typeof(CS.TMPro.TMP_Text))
end

function ui:ui_on_show(buddy_id)
  self.v_buddy_id = buddy_id
  self:update_btn_list_img()
  self:update_info()
end

function ui:on_click_btn(idx)
  self.v_cur_selected_idx = idx
  self:update_info()
end

function ui:update_btn_list_img()
  for i, v in ipairs(self.v_btn_list) do
    local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", i + 1)
    local icon_path = advance_icon_cfg.AdvacneAfter
    ResMgr:load_set_icon(v.icon, icon_path, nil, true)
  end
end

function ui:update_info()
  self.v_buddy_info = {}
  local advance_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_id)
  self.v_role_cur_lv = self.v_buddy_info.advance or 1
  self.v_cur_selected_idx = self.v_cur_selected_idx or 1
  self.v_cur_selected_idx = _clamp(self.v_cur_selected_idx, 1, #self.v_btn_list)
  self:update_btn_list()
  self.v_uiobjects.IconBgActive:SetActive(self.v_cur_selected_idx <= self.v_role_cur_lv - 1)
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", self.v_cur_selected_idx + 1)
  local icon_path = advance_icon_cfg.AdvacneAfter
  ResMgr:load_set_icon(self.v_uicompents.AdcanveIcon_img, icon_path, nil, true)
  local advance_skill_cfg = advance_cfg[self.v_cur_selected_idx + 1]
  self.v_uicompents.AdvanceLv_txt.text = Config.NUM_2_ROMAN[self.v_cur_selected_idx]
  self.v_uicompents.AdvanceName_txt.text = advance_skill_cfg.SkillName
  local skill_desc = ""
  if advance_skill_cfg.SkillDesc and "" ~= advance_skill_cfg.SkillDesc then
    skill_desc = advance_skill_cfg.SkillDesc
  elseif advance_skill_cfg.UpSkillLv > 0 then
    skill_desc = Util.format_str("技能等级+{1}", advance_skill_cfg.UpSkillLv)
  else
    local add_value = 0
    skill_desc, add_value = self:get_prop_desc(advance_skill_cfg.Lv)
    if add_value > 0 then
      skill_desc = Util.format_str("{1}+{2}", skill_desc, add_value)
    end
  end
  self.v_tmp_text.text = skill_desc
  self.v_keyword_list = advance_skill_cfg.Keywords
end

function ui:update_btn_list()
  for i, v in ipairs(self.v_btn_list) do
    v.normal_bg:SetActiveEx(i >= self.v_role_cur_lv)
    v.active_bg:SetActiveEx(i < self.v_role_cur_lv)
    local is_selected = self.v_cur_selected_idx == i
    local alpha = (i < self.v_role_cur_lv or is_selected) and 1 or 0.2
    Util.set_color(v.icon, is_selected and "292929" or "f5ede2", alpha)
    if i >= self.v_role_cur_lv then
      v.normal_selected:SetActiveEx(is_selected)
    else
      v.active_selected:SetActiveEx(is_selected)
    end
    v.red_go:SetActive(false)
  end
  if QiannnengProgressImgFill then
    local fill_amount = QiannnengProgressImgFill[self.v_role_cur_lv] or 0
    self.v_uicompents.ProcessFill_img.fillAmount = fill_amount
  end
end

function ui:ui_on_hide()
  self.v_cur_selected_idx = nil
end

function ui:try_show_keyword()
  if self.v_keyword_list then
    UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_keyword_list)
  end
end

return ui
