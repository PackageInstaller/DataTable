local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local WeaponModelRtView = require("ui.model_rt_view.model_rt_weapon_view")

function ui:ui_finish_load()
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self.v_init_bg = Util.get_canvas_group("FullScreenBackground", self.v_object)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.PageBasicRed, RedEnum.CHAR_EQUIP_STRENGTHEN_PAGE)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.PageTongtiaoRed, RedEnum.CHAR_EQUIP_HOMOLOGY_PAGE)
end

function ui:ui_on_hide()
  self.v_init_bg.alpha = 1
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
end

function ui:ui_on_destroy()
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
end

function ui:ui_on_show(buddy_id, equip_uuid, tab_idx, exparam)
  self:register_event()
  self.v_init_bg.alpha = 1
  if buddy_id then
    local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
    local equip_info = CharacterMgr:get_equip_info(buddy_info.weapon)
    self.v_buddy_id = buddy_id
    self.v_equip_uuid = buddy_info.weapon
    self.v_equip_info = equip_info
  elseif equip_uuid then
    local equip_info = CharacterMgr:get_equip_info(equip_uuid)
    self.v_buddy_id = CharacterMgr:get_buddy_id_by_equip_uuid(equip_uuid)
    self.v_equip_uuid = equip_uuid
    self.v_equip_info = equip_info
  end
  self.v_exparam = exparam
  self:init_toggle_list(tab_idx or 1)
  CharacterMgr:update_equip_break_red(equip_uuid)
  CharacterMgr:update_equip_up_red(equip_uuid)
  CharacterMgr:update_equip_homology_red(equip_uuid)
end

function ui:register_event()
end

function ui:init_toggle_list(tab_idx)
  local uicom = self.v_uicompents
  self.v_tog_list = {
    uicom.PageBasic_tog,
    uicom.PageTongtiao_tog
  }
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(self.v_tog_list, function(idx)
    self:switch_page(idx)
  end, tab_idx)
  self:switch_page(tab_idx)
end

function ui:switch_page(tab_idx)
  self.v_last_tab_idx = tab_idx
  for idx, panel in ipairs(self.v_panels_arr) do
    panel:set_enable(idx == tab_idx)
    if idx == tab_idx then
      panel:refresh(self.v_equip_uuid, self.v_exparam)
    end
  end
  self:update_weapon_view()
end

function ui:update_weapon_view()
  self.v_init_bg.alpha = 0
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:set_rotate_weapon()
    return
  end
  self.v_weapon_model_rt = WeaponModelRtView:new(nil, false, nil, nil, true, "UIModelRtViewWeapon")
  self.v_weapon_model_rt:init_weapon_info(self.v_equip_info.id)
  self.v_weapon_model_rt:set_rotate_weapon()
  self.v_weapon_model_rt:set_visible(true)
end

function ui:set_weapon_model_visible(is_on)
  if self.v_weapon_model_rt then
    local is_change = self.v_weapon_model_rt:is_visible() ~= is_on
    self.v_weapon_model_rt:set_visible(is_on)
    if is_on and is_change then
      self.v_weapon_model_rt:set_rotate_weapon()
      self.v_weapon_model_rt:change_weapon(self.v_equip_info.id)
    end
  end
end

function ui:set_left_tab_visiable(visiable)
  self.v_uiobjects.PageList:SetActive(visiable)
end

function ui:ui_on_update()
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:update()
  end
end

function ui:get_cache_data()
  return nil, self.v_equip_uuid, self.v_last_tab_idx
end

function ui:cache_ui()
  return true
end

return ui
