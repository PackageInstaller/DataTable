local Base = require("ui.uibase")
local AssetBarView = require("ui.asset_bar.asset_bar")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local WeaponAttr = require("uimodule.character.weapon_attr")
local WeaponEnhance = require("uimodule.character.weapon_enhance")
local WeaponTongTiao = require("uimodule.character.weapon_tongtiao")
local WeaponModelRtView = require("ui.model_rt_view.model_rt_weapon_view")
local Char_Helper = require("uimodule.character.char_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_asset_bar_obj = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_replace = {
    "BtnReplace",
    BIND_TYPE.BUTTON
  },
  v_holder = {
    "Holder",
    BIND_TYPE.IMAGE
  },
  v_holder_obj = {
    "Holder",
    BIND_TYPE.OBJECT
  },
  v_rb_weapon = {
    "RBWeapon",
    BIND_TYPE.OBJECT
  },
  v_weapon_attr_obj = {
    "WeaponAttrNew",
    BIND_TYPE.OBJECT
  },
  v_weapon_tongtiao_obj = {
    "WeaponTongtiao",
    BIND_TYPE.OBJECT
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")

function ui:ui_finish_load()
  self.v_weapon_attr_open_type = CHARACTER_CONFIG.WEAPON_ATTR_OPEN_TYPE.WEAPON
  self:init_model(MODEL)
  self:set_button("BtnWeaponRet", function()
    if self.v_need_return_attr then
      self.v_need_return_attr = false
      self:refresh_attr()
    else
      if self.v_return_cb then
        self.v_return_cb()
      end
      self:ui_hide()
    end
  end)
  self:set_button("BtnEnhance", function()
    UIMgr:get_ui("weapon_detail"):ui_show(nil, self.v_equip_uuid)
  end)
  self:set_button("BtnPreview", function()
    self.v_fake_equip_info = self:build_fake_equip_info(self.v_fake_equip_info.id, 1 == self.v_fake_equip_info.lv)
    self.v_equip_info = self.v_fake_equip_info
    self.v_dont_change_weapon_rt = true
    self:refresh()
  end)
  self.v_init_bg = Util.get_canvas_group("FullScreenBackground", self.v_object)
  self.v_weapon_attr = WeaponAttr:ui_wrap_ex(self, self.v_weapon_attr_obj, true)
  self.v_weapon_tongtiao = WeaponTongTiao:ui_wrap_ex(self, self.v_weapon_tongtiao_obj)
  self.v_asset_bar_obj:SetActive(false)
  self.v_story_ret = Util.get_scrollrect(nil, self.v_uiobjects.StoryScrollView)
end

function ui:build_fake_equip_info(fake_equip_id, is_max)
  local id = fake_equip_id
  local break_lv = is_max and ShareRes.get_max_equip_break_lv(id) + 1 or 1
  local lv = is_max and ShareRes.get_equip_max_level(break_lv) or 1
  local advance = is_max and ShareRes.get_equip_max_advance_lv(id) or 1
  local attrs = CharacterMgr.cal_equip_attr(id, break_lv, lv)
  local fake_equip_info = {
    id = id,
    lv = lv,
    break_lv = break_lv,
    advance = advance,
    attrs = attrs,
    exp = 0,
    owner = 0,
    lock = 0,
    is_fake = true
  }
  return fake_equip_info
end

function ui:set_return_cb(return_cb)
  self.v_return_cb = return_cb
end

function ui:ui_on_show(parent_ui, buddy_id, equip_uuid, fake_equip_id, fake_equip_is_max)
  self.v_fake_equip_id = nil
  self.v_uimain = UIMgr:try_get_visible_ui("uimain")
  if self.v_uimain then
    self.v_uimain:set_model_view_visible(false)
  end
  self.v_init_bg.alpha = 1
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.refresh_btns, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_TIPS_WIN_HIDE, self.on_item_tips_hide, self)
  self.v_parent_ui = parent_ui
  self.v_buddy_id = buddy_id
  self.v_can_show_attr = true
  self.v_is_fake = false
  self.v_equip_uuid = equip_uuid
  self.v_fake_equip_info = nil
  if buddy_id then
    local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
    local equip_info = CharacterMgr:get_equip_info(buddy_info.weapon)
    self.v_equip_uuid = buddy_info.weapon
    self.v_equip_info = equip_info
  elseif equip_uuid then
    local equip_info = CharacterMgr:get_equip_info(equip_uuid)
    self.v_equip_info = equip_info
    self.v_buddy_id = CharacterMgr:get_buddy_id_by_equip_uuid(equip_uuid)
  elseif fake_equip_id then
    local show_max = fake_equip_is_max
    self.v_fake_equip_info = self:build_fake_equip_info(fake_equip_id, show_max)
    self.v_equip_info = self.v_fake_equip_info
    self.v_buddy_id = nil
    self.v_fake_equip_id = fake_equip_id
  end
  self:refresh()
  self:refresh_tog_page()
end

local WEAPON_TOG_PAGE = {ATTR_PAGE = 1, STORY_PAGE = 2}

function ui:refresh_tog_page()
  if not self.v_fake_equip_id then
    self.v_uiobjects.Left:SetActive(false)
    self.v_uiobjects.WeaponAttrNew:SetActive(true)
    self.v_uiobjects.WeaponStory:SetActive(false)
    return
  end
  self.v_uiobjects.Left:SetActive(true)
  local attr_tog = self.v_uicompents.AttrTog_tog
  local story_tog = self.v_uicompents.StoryTog_tog
  attr_tog.interactable = true
  story_tog.interactable = true
  self.v_cur_select_weapon_page = nil
  self:set_toggle_listener(attr_tog, function(isOn)
    if isOn then
      if self.v_cur_select_weapon_page ~= WEAPON_TOG_PAGE.ATTR_PAGE then
        self:on_click_attr()
      end
      self.v_cur_select_weapon_page = WEAPON_TOG_PAGE.ATTR_PAGE
    end
  end)
  self:set_toggle_listener(story_tog, function(isOn)
    if isOn then
      if self.v_cur_select_weapon_page ~= WEAPON_TOG_PAGE.STORY_PAGE then
        self:on_click_story()
      end
      self.v_cur_select_weapon_page = WEAPON_TOG_PAGE.STORY_PAGE
    end
  end)
  attr_tog.isOn = false
  attr_tog.isOn = true
end

function ui:attr_or_story_panel(set_flag)
  self.v_uiobjects.WeaponAttrNew:SetActive(set_flag)
  self.v_uiobjects.BtnPreview:SetActive(set_flag)
  self.v_uiobjects.WeaponStory:SetActive(not set_flag)
  self.v_uicompents.AttrTog_tog.interactable = not set_flag
  self.v_uicompents.StoryTog_tog.interactable = set_flag
end

function ui:on_click_attr()
  self:attr_or_story_panel(true)
end

function ui:on_click_story()
  self:attr_or_story_panel(false)
  self:update_weapon_story()
end

function ui:update_weapon_story()
  if self.v_fake_equip_id then
    self.v_uicompents.WeaponStoryDesc_txt.text = ShareRes.get_equip_desc(self.v_fake_equip_id) or ""
  end
end

function ui:refresh()
  self:update_equip_hold_view()
  self:update_weapon_view()
  self:update_weapon_story()
  if self.v_need_return_tongtiao then
    self.v_need_return_tongtiao = false
    self:refresh_tongtiao()
  else
    self.v_weapon_attr:set_enable(self.v_can_show_attr)
    self.v_weapon_tongtiao:set_enable(not self.v_can_show_attr)
    if self.v_can_show_attr then
      self.v_weapon_attr:refresh(self.v_equip_uuid, nil, self.v_fake_equip_info)
    else
      self.v_weapon_tongtiao:refresh(self.v_equip_uuid)
    end
    self.v_cur_page_is_attr = self.v_can_show_attr
  end
  self:refresh_btns()
  self.v_btn_replace.gameObject:SetActive(false)
end

function ui:refresh_btns()
  local is_fake = self.v_fake_equip_info ~= nil
  self.v_rb_weapon:SetActive(self.v_cur_page_is_attr and not is_fake)
  if self.v_cur_page_is_attr and not is_fake then
    local can_operation = CharacterMgr:check_equip_can_operation(self.v_equip_uuid)
    self.v_uiobjects.BtnEnhance:SetActive(can_operation)
    self.v_uiobjects.ButtonMax:SetActive(not can_operation)
  end
  self.v_uiobjects.BtnPreview:SetActive(is_fake)
  if is_fake then
    self.v_uicompents.PreviewText_txt.text = Util.format_str(self.v_fake_equip_info.lv > 1 and "满级" or "初始")
  end
end

function ui:on_item_tips_show()
  self:set_model_visible(false)
end

function ui:on_item_tips_hide()
  self:set_model_visible(true)
end

function ui:set_model_visible(value)
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:set_model_visible(value)
  end
end

function ui:show_tongtiao()
  self.v_need_return_attr = true
  self:refresh_tongtiao()
end

function ui:selected_tongtiao()
  self.v_need_return_tongtiao = true
end

function ui:refresh_tongtiao()
  self.v_cur_page_is_attr = false
  self.v_weapon_attr:set_enable(false)
  self.v_weapon_tongtiao:set_enable(true)
  self.v_weapon_tongtiao:refresh(self.v_equip_uuid)
  self:refresh_btns()
end

function ui:refresh_attr()
  self.v_cur_page_is_attr = true
  self.v_weapon_tongtiao:set_enable(false)
  self.v_weapon_attr:set_enable(true)
  self.v_weapon_attr:refresh(self.v_equip_uuid, nil, self.v_fake_equip_info)
  self:refresh_btns()
end

function ui:is_bag_open()
  return self.v_is_bag_open
end

function ui:update_weapon_view()
  self.v_init_bg.alpha = 0
  if self.v_weapon_model_rt then
    if self.v_dont_change_weapon_rt then
      self.v_dont_change_weapon_rt = false
    else
      self.v_weapon_model_rt:change_weapon(self.v_equip_info.id)
    end
    self.v_weapon_model_rt:set_rotate_weapon()
    return
  end
  self.v_weapon_model_rt = WeaponModelRtView:new(nil, false, nil, nil, true, "UIModelRtViewWeapon")
  self.v_weapon_model_rt:set_x_offset()
  self.v_weapon_model_rt:init_weapon_info(self.v_equip_info.id)
  self.v_weapon_model_rt:set_rotate_weapon()
  self.v_weapon_model_rt:set_visible(true)
end

function ui:set_weapon_model_visible(is_on)
  if self.v_weapon_model_rt then
    if is_on then
      self.v_weapon_model_rt:set_visible(true)
    else
      self.v_weapon_model_rt:set_camera_culling_mask_zero()
    end
  end
end

function ui:check_can_levelup()
  local equip_info = self.v_equip_info
  local can_operation = CharacterMgr:check_equip_can_operation(equip_info.uuid)
  if not can_operation then
    self.v_enhance_toggle.gameObject:SetActive(false)
    self.v_toggles:set_toggle_by_index(1)
    return false
  end
  return true
end

function ui:play_level_up_effect()
  self.v_levelup_effect:SetActive(false)
  self.v_levelup_effect:SetActive(true)
end

function ui:ui_on_hide()
  self.v_return_cb = nil
  if self.v_parent_ui then
    self.v_parent_ui:show_attrs(true)
    self.v_parent_ui:show_main(true)
  end
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
end

function ui:ui_on_destroy()
end

function ui:update_equip_hold_view()
  self.v_holder_obj:SetActive(false)
  if not self.v_buddy_id then
    return
  end
  self.v_holder_obj:SetActive(true)
  local path = UtilUI.get_hero_images(self.v_buddy_id, 2)
  local icon = Util.get_image("Icon", self.v_holder_obj)
  ResMgr:load_set_icon(icon, path)
end

function ui:ui_on_update()
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:update()
  end
  if self.v_fake_equip_id then
    self.v_uiobjects.StoryArrow:SetActive(CSHelper.CheckScrollPosition(self.v_uiobjects.StoryScrollView, self.v_story_ret.content.gameObject, 0.02))
  end
end

function ui:get_cache_data()
  local fake_equip_id, fake_equip_is_max
  if self.v_fake_equip_info then
    fake_equip_id = self.v_fake_equip_info.id
    fake_equip_is_max = self.v_fake_equip_info.lv > 1
  end
  return self.v_parent_ui, self.v_buddy_id, self.v_equip_uuid, fake_equip_id, fake_equip_is_max
end

function ui:cache_ui()
  return true
end

return ui
