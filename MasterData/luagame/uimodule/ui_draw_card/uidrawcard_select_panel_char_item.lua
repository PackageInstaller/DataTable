local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")

function ui:ui_finish_load()
  self.v_object:SetActive(true)
  self.v_toggle = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(self.v_toggle, function(is_on)
    if is_on then
      self.v_parent_ui:set_choose_id(self.v_choose_id)
    end
  end)
  self:set_button("BtnDetail", function()
    self:on_click_jump()
  end)
end

function ui:on_click_jump()
  Player_Hero_Helper.build_fake_buddy(self.v_buddy_id)
  UIMgr:get_ui("player_hero"):ui_show()
end

function ui:set_data(cfg, is_selected, delay)
  self.v_choose_id = cfg.Id
  self.v_buddy_id = cfg.ItemId
  self.v_buddy_cfg = ShareRes.get_buddy_cfg(self.v_buddy_id)
  self:refresh_select()
  self:refresh_quality_icon()
  self:refresh_char_icon()
  self:refresh_name()
  self:refresh_element()
  self:refresh_job()
  self:refresh_own()
end

function ui:refresh_select()
  local selected = self.v_parent_ui:get_choose_id() == self.v_choose_id
  self.v_uiobjects.Select:SetActive(selected)
end

function ui:refresh_quality_icon()
  local char_quality_icon_path = Char_Helper.get_char_select_quality_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.Bg_img, char_quality_icon_path)
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, nil, self.v_buddy_id)
end

function ui:refresh_char_icon()
  local icon_path = UtilUI.get_hero_images(self.v_buddy_id, 3)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, icon_path, nil, true, self)
end

function ui:refresh_name()
  self.v_uicompents.CharName_txt.text = self.v_buddy_cfg.Name
end

function ui:refresh_element()
  local element_icon_path = Char_Helper.get_char_element_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.EleIcon_img, element_icon_path)
end

function ui:refresh_job()
  local char_job_icon = Char_Helper.get_char_job_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.JobIcon_img, char_job_icon)
end

function ui:refresh_own()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  self.v_uiobjects.Own:SetActive(nil ~= buddy_info)
end

function ui:ui_on_hide()
end

return ui
