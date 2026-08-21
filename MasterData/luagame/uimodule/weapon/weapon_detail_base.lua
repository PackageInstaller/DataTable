local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local WEAPON_ATTR_ITEM_KEY_BASE_PANEL = "WEAPON_ATTR_ITEM_KEY_BASE_PANEL"
local CHAR_HELPER = require("uimodule.character.char_helper")
local FightDefine = require("cs_share.fight_define")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_temp = {
    "AttrTemp",
    BIND_TYPE.OBJECT
  },
  v_btn_change = {
    "BtnChange",
    BIND_TYPE.BUTTON
  },
  v_btn_max = {
    "BtnMax",
    BIND_TYPE.BUTTON
  },
  v_btn_upgrade = {
    "BtnUpgrade",
    BIND_TYPE.BUTTON
  },
  v_btn_weapon_break_pre = {
    "BtnWeaponBreakPre",
    BIND_TYPE.BUTTON
  },
  v_equip_name = {
    "Equip_name",
    BIND_TYPE.TEXT
  },
  v_exp_max = {
    "ExpMax",
    BIND_TYPE.TEXT
  },
  v_exp_now = {
    "ExpNow",
    BIND_TYPE.TEXT
  },
  v_exp_silder = {
    "Exp_Silder",
    BIND_TYPE.IMAGE
  },
  v_lock = {
    "Lock",
    BIND_TYPE.BUTTON
  },
  v_lv_max = {
    "LvMax",
    BIND_TYPE.TEXT
  },
  v_lv_now = {
    "LvNow",
    BIND_TYPE.TEXT
  },
  v_red_weapon_enhance = {
    "RedWeaponEnhance",
    BIND_TYPE.IMAGE
  },
  v_star1 = {
    "Star1",
    BIND_TYPE.IMAGE
  },
  v_star2 = {
    "Star2",
    BIND_TYPE.IMAGE
  },
  v_star3 = {
    "Star3",
    BIND_TYPE.IMAGE
  },
  v_star4 = {
    "Star4",
    BIND_TYPE.IMAGE
  },
  v_star5 = {
    "Star5",
    BIND_TYPE.IMAGE
  },
  v_star_layout = {
    "StarLayout",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:set_button("BtnUpgrade", function()
    UIMgr:get_ui("char_weapon_levelup_box"):ui_show(nil, self.v_equip_uuid)
  end)
  self:set_button("BtnWeaponBreakPre", function()
    local data = {
      weapon_uid = self.v_equip_info.uuid,
      type = 2
    }
    if self.v_fake_equip_info then
      data.fixed_data = self.v_fake_equip_info
      data.hide_reward = self.v_hide_preview_reward
    end
    UIMgr:get_ui("break_preview"):ui_show(data)
  end)
  self:set_button("Lock", function()
    if not self.v_equip_info then
      return
    end
    CharacterMgr:equip_lock(self.v_equip_info.uuid, function()
      self:refresh_lock_view()
    end)
  end)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedWeaponEnhance, RedEnum.CHAR_EQUIP_BASE_STRENGTHEN_BTN)
  self.v_max_star_count = self.v_uiobjects.StarLayout.transform.childCount
  self:register_exist_auto_template(WEAPON_ATTR_ITEM_KEY_BASE_PANEL, self.v_uiobjects.AttrTemp, self.v_uiobjects.AttrContent)
end

function ui:refresh_lock_view()
  local lock = self.v_uiobjects.Lock
  lock:SetActive(self.v_fake_equip_info == nil)
  if self.v_fake_equip_info ~= nil then
    return
  end
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_info.uuid)
  local img_lock = Util.get_image("img_lock", lock)
  local img_no_lock = Util.get_image("img_no_lock", lock)
  local is_lock = 1 == equip_info.lock
  img_lock.gameObject:SetActive(is_lock)
  img_no_lock.gameObject:SetActive(not is_lock)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.refresh_equip_info, self)
end

function ui:refresh(equip_uuid)
  self.v_equip_uuid = equip_uuid
  self:refresh_equip_info()
end

function ui:refresh_equip_info()
  local equip_uuid = self.v_equip_uuid
  self.v_equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local equip_info = self.v_equip_info
  local equip_id = equip_info.id
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local exp, max_exp = CharacterMgr:get_equip_exp_info(equip_info.uuid, equip_info)
  local level = equip_info.lv
  local can_operation = CharacterMgr:check_equip_can_operation(equip_info.uuid, equip_info)
  if not can_operation then
    exp = "-"
    max_exp = "-<color=#ff3030>[MAX]</color>"
  else
    local need_break = CharacterMgr:is_equip_need_break(equip_info.uuid, equip_info)
    if need_break then
      exp = "-"
      max_exp = "-"
      can_operation = false
    end
  end
  local uicom = self.v_uicompents
  uicom.LvNow_txt.text = level
  uicom.LvMax_txt.text = ShareRes.get_equip_max_level(equip_info.break_lv)
  uicom.ExpNow_txt.text = exp
  uicom.ExpMax_txt.text = max_exp
  uicom.Exp_Silder_img.fillAmount = can_operation and exp / max_exp or 1
  uicom.Equip_name_txt.text = Util.format_quality_txt_color(equip_cfg.Name, equip_cfg.Quality)
  local break_lv = equip_info.break_lv
  break_lv = break_lv - 1
  local max_star_num = CHAR_HELPER.get_equip_max_break_star_num(equip_id)
  for i = 1, self.v_max_star_count do
    local star_obj = self.v_uiobjects["Star" .. i]
    if star_obj then
      star_obj.gameObject:SetActive(false)
      if i <= max_star_num then
        star_obj.gameObject:SetActive(true)
        Util.get_child_gameobj("Lightup", star_obj.gameObject):SetActive(i <= break_lv)
      end
    end
  end
  local need_break = CharacterMgr:is_equip_need_break(equip_info.uuid)
  self.v_uiobjects.UpgradeText:SetActive(not need_break)
  self.v_uiobjects.BreakText:SetActive(need_break)
  local can_operation = CharacterMgr:check_equip_can_operation(equip_info.uuid, equip_info)
  self.v_uiobjects.BtnMax:SetActive(not can_operation)
  self.v_uiobjects.BtnUpgrade:SetActive(can_operation)
  self:refresh_lock_view()
  self:refresh_attr_list(equip_info)
end

function ui:refresh_attr_list(equip_info)
  self.v_equip_info = equip_info
  self:give_back_auto_cache(WEAPON_ATTR_ITEM_KEY_BASE_PANEL)
  local attrs = equip_info.attrs
  local curr_equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local attr_key_list = {}
  for i, v in pairs(curr_equip_cfg.BaseAttrList) do
    local attr_cfg = ShareRes.get_buddy_attr_cfg(v)
    attr_key_list[#attr_key_list + 1] = attr_cfg.Name
  end
  if 0 == #attr_key_list then
    attr_key_list = {"hp", "attack"}
  end
  for index, attr_key in ipairs(attr_key_list) do
    local attrs_value = attrs[attr_key]
    attrs_value = attrs_value or 0
    local attr_ui = self:get_auto_cache(WEAPON_ATTR_ITEM_KEY_BASE_PANEL)
    self:update_attr_item(attr_ui, attr_key, index, attrs_value)
  end
end

function ui:update_attr_item(attr_ui, attr_key, index, attr_value)
  local attr_id = FightDefine.CONFIG_NAME_ATTR_ID[attr_key]
  local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
  assert(attr_cfg, "ATTR_CFG NULL = " .. attr_id)
  local attr_name_txt = Util.get_text("AttrName", attr_ui)
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  attr_name_txt.text = attr_name
  local attr_icon = Util.get_image("AttrIcon", attr_ui)
  Util.load_attr_icon(attr_icon, attr_cfg.IconName)
  local is_ration = ShareRes.get_is_ration_attr(attr_id)
  local attr_val_txt = Util.get_text("AttrVal", attr_ui)
  attr_val_txt.text = Util.format_number(attr_value, is_ration)
  local bg_img = Util.get_image("Bg", attr_ui)
  bg_img:SetActive(0 ~= index % 2)
end

return ui
