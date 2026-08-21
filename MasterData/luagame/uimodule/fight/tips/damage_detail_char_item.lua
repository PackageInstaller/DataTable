local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(data, role_id)
  local fashion_id = data.fashion_id
  local buddy_config = ShareRes.get_buddy_cfg(role_id)
  local element_cfg = ShareRes.create("buddy.buddy_element", buddy_config.Element)
  local char_job_icon = Char_Helper.get_char_job_icon(role_id)
  local line_path = Char_Helper.get_char_line_quality_icon(buddy_config.Quality)
  local bg_path = Char_Helper.get_char_select_quality_icon(role_id)
  local coms = self.v_uicompents
  local icon_path = UtilUI.get_hero_images(role_id, 3, fashion_id)
  coms.LvNum_txt.text = data.lv
  local max_break_lv = ShareRes.get_role_max_break_lv(role_id)
  local max_break_count = self.v_uiobjects.BreakRoot.transform.childCount
  for index = 1, max_break_count do
    self.v_uiobjects["BreakBg" .. index]:SetActive(index <= max_break_lv)
    self.v_uiobjects["Break" .. index]:SetActive(index <= data.break_lv)
  end
  ResMgr:load_set_icon(coms.Char_icon_img, icon_path, nil, true, self)
  ResMgr:load_set_icon(coms.EleIcon_img, element_cfg.ElementIconPath)
  ResMgr:load_set_icon(coms.JobIcon_img, char_job_icon)
  ResMgr:load_set_icon(coms.QualityLine_img, line_path)
  ResMgr:load_set_icon(coms.Quality_Icon_img, bg_path)
end

function ui:set_cure_value(value, per_value)
  self.v_uicompents.CureNum_txt.text = value
  self.v_uicompents.CurePercent_txt.text = per_value
end

function ui:set_damage_value(value, per_value)
  self.v_uicompents.DamageNum_txt.text = value
  self.v_uicompents.DamagePercent_txt.text = per_value
end

function ui:set_tdamage_value(value, per_value)
  self.v_uicompents.TDamageNum_txt.text = value
  self.v_uicompents.TDamagePercent_txt.text = per_value
end

function ui:set_cure_mvp(is_active)
  self.v_uiobjects.CureMvp:SetActive(is_active)
end

function ui:set_damage_mvp(is_active)
  self.v_uiobjects.DamageMvp:SetActive(is_active)
end

function ui:set_tdamage_mvp(is_active)
  self.v_uiobjects.TDamageMvp:SetActive(is_active)
end

return ui
