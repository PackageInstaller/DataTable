local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")

function ui:ui_finish_load()
  self:set_button("CharBtn", function()
    if self.v_uuid == PlayerMgr:get_player_uid() then
      local equip_info = CharacterMgr:get_equip_info(self.v_buddy_info.weapon)
      self.v_buddy_info.weapon_info = equip_info
      Player_Hero_Helper.set_hero_data(self.v_buddy_info, true)
      UIMgr:get_ui("player_hero"):ui_show()
      return
    end
    
    local function cb(data)
      Player_Hero_Helper.set_hero_data(data)
      UIMgr:get_ui("player_hero"):ui_show()
    end
    
    FriendMgr:c2gs_get_role_buddy_info(self.v_uuid, self.v_buddy_info.id, cb)
  end)
end

function ui:set_data(data, uuid, bg_type)
  self.v_buddy_info = data
  self.v_uuid = uuid
  self.v_bg_type = bg_type
  self:refresh_char_icon()
  self:refresh_quailty_icon()
  self:refresh_quailty_bg()
  self:refresh_element_icon()
  self:refresh_job_icon()
  self:refresh_break_icon()
  self:refresh_lv_num()
  self:refresh_advance_icon()
  self:refresh_aid_icon()
end

function ui:refresh_char_icon()
  local icon_path
  if self.v_bg_type == Config.CHAR_QUALITY_TYPE.SHORT then
    icon_path = UtilUI.get_hero_images(self.v_buddy_info.id, 2, self.v_buddy_info.fashion)
    ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, icon_path)
  else
    icon_path = UtilUI.get_hero_images(self.v_buddy_info.id, 3, self.v_buddy_info.fashion)
    ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, icon_path, nil, true, self)
  end
end

function ui:refresh_quailty_icon()
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, nil, self.v_buddy_info.id)
end

function ui:refresh_quailty_bg()
  local char_qual_icon = Char_Helper.get_char_icon_quality(self.v_buddy_info.id, self.v_bg_type)
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, char_qual_icon)
end

function ui:refresh_element_icon()
  local icon_path = Char_Helper.get_char_element_icon(self.v_buddy_info.id)
  local element_icon = self.v_uicompents.Ele_img
  ResMgr:load_set_icon(element_icon, icon_path)
end

function ui:refresh_job_icon()
  local icon_path = Char_Helper.get_char_job_icon(self.v_buddy_info.id)
  local element_icon = self.v_uicompents.Job_img
  ResMgr:load_set_icon(element_icon, icon_path)
end

function ui:refresh_break_icon()
  for i = 1, 3 do
    local star_obj = self.v_uiobjects["Light" .. i]
    star_obj:SetActive(i < self.v_buddy_info.break_lv)
  end
end

function ui:refresh_lv_num()
  self.v_uicompents.CharLv_txt.text = string.format("%.2d", self.v_buddy_info.lv)
end

function ui:refresh_advance_icon()
  local potential_icon = Char_Helper.get_char_potential_icon_by_advance(self.v_buddy_info.advance)
  ResMgr:load_set_icon(self.v_uicompents.Advance_img, potential_icon, nil, true)
end

function ui:refresh_aid_icon()
  self.v_uiobjects.Assistant:SetActive(self.v_buddy_info.is_aid)
end

return ui
