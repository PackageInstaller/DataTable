local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnDetail()
  if self.v_weapon_id then
    UIMgr:get_ui("char_weapon", true):ui_show(nil, nil, nil, self.v_weapon_id)
  end
end

function ui:on_click_btn()
  self.v_parent_ui:on_click_waepon_item(self.v_weapon_id)
end

function ui:ui_finish_load()
  self:set_button("BtnDetail", function()
    self:on_click_BtnDetail()
  end)
  self:set_button_listener(nil, function()
    self:on_click_btn()
  end)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(weapon_gourd_id, weapon_id)
  local cfg = ShareRes.get_gold_equip_single_group_cfg(weapon_gourd_id, weapon_id)
  self.v_weapon_id = weapon_id
  local weapon_cfg = ShareRes.get_equip(self.v_weapon_id)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, string.format("Icon/Item/%s", weapon_cfg.Icon))
  local special = cfg.Special == true
  local time = Util.is_more_than_zero(cfg.BeginTime) and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
  local is_unlock = not time or time <= Date.server_time()
  self.v_uiobjects.LimitTips:SetActive(special)
  self.v_uiobjects.Char:SetActive(is_unlock)
  self.v_uiobjects.CharName:SetActive(is_unlock)
  self.v_uiobjects.UnLockCondition:SetActive(not is_unlock)
  self.v_uiobjects.SpecialBg:SetActive(special)
  self.v_uiobjects.Bg:SetActive(not special)
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.WeaponName:SetActive(is_unlock)
  self.v_uicompents.WeaponName_txt.text = weapon_cfg.Name
  local char_id = ShareRes.get_equip_user(self.v_weapon_id)
  local char_icon = UtilUI.get_hero_images(char_id, 1)
  ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, char_icon)
  self.v_uiobjects.BtnDetail:SetActive(is_unlock)
  if is_unlock then
    local char_name = ShareRes.get_buddy_name(char_id)
    self.v_uicompents.CharName_txt.text = char_name
    Util.set_color(self.v_uicompents.Icon_img, "FFFFFF")
  else
    self.v_uicompents.UnLockCondition_txt.text = Date.standard_data2(time)
    Util.set_color(self.v_uicompents.Icon_img, "000000")
  end
end

function ui:on_select(select_weapon_id)
  self.v_uiobjects.Select:SetActive(select_weapon_id == self.v_weapon_id)
end

return ui
