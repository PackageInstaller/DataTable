local Base = require("ui.uiobject")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local FightDefine = require("cs_share.fight_define")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local WEAPON_MODEL = {
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
  v_btn_weapon_break_pre = {
    "BtnWeaponBreakPre",
    BIND_TYPE.BUTTON
  },
  v_equip_change_title = {
    "EquipChangeTitle",
    BIND_TYPE.OBJECT
  },
  v_equip_name_now = {
    "EquipNameNow",
    BIND_TYPE.TEXT
  },
  v_equip_name_select = {
    "EquipNameSelect",
    BIND_TYPE.TEXT
  },
  v_equip_name_self = {
    "EquipNameSelf",
    BIND_TYPE.TEXT
  },
  v_equip_now = {
    "EquipNow",
    BIND_TYPE.OBJECT
  },
  v_equip_select = {
    "EquipSelect",
    BIND_TYPE.OBJECT
  },
  v_equip_self = {
    "EquipSelf",
    BIND_TYPE.OBJECT
  },
  v_equip_name = {
    "Equip_name",
    BIND_TYPE.TEXT
  },
  v_equip_quality = {
    "Equip_quality",
    BIND_TYPE.IMAGE
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
  v_lv_now_max = {
    "LVNowMax",
    BIND_TYPE.TEXT
  },
  v_lv_now_now = {
    "LVNowNow",
    BIND_TYPE.TEXT
  },
  v_lv_select_max = {
    "LVSelectMax",
    BIND_TYPE.TEXT
  },
  v_lv_select_now = {
    "LVSelectNow",
    BIND_TYPE.TEXT
  },
  v_lv_self_max = {
    "LVSelfMax",
    BIND_TYPE.TEXT
  },
  v_lv_self_now = {
    "LVSelfNow",
    BIND_TYPE.TEXT
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
  v_quality_now = {
    "QualityNow",
    BIND_TYPE.IMAGE
  },
  v_quality_select = {
    "QualitySelect",
    BIND_TYPE.IMAGE
  },
  v_quality_self = {
    "QualitySelf",
    BIND_TYPE.IMAGE
  },
  v_scroll_view = {
    "ScrollView",
    BIND_TYPE.IMAGE
  },
  v_skill_desc = {
    "SkillDesc",
    BIND_TYPE.TEXT
  },
  v_skill_lv_max = {
    "SkillLvMax",
    BIND_TYPE.TEXT
  },
  v_skill_lv_num = {
    "SkillLvNum",
    BIND_TYPE.TEXT
  },
  v_skill_name = {
    "SkillName",
    BIND_TYPE.TEXT
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
  self:init_model(WEAPON_MODEL)
  self:init_now_and_select_ui()
  self:set_button("Lock", function()
    if not self.v_equip_info then
      return
    end
    CharacterMgr:equip_lock(self.v_equip_info.uuid, function()
      self:refresh_lock_view()
    end)
  end)
  if self.v_uiobjects.BtnWeaponBreakPre then
    self:set_button("BtnWeaponBreakPre", function()
      local data = {
        weapon_uid = self.v_equip_info.uuid,
        type = 2
      }
      UIMgr:get_ui("break_preview"):ui_show(data)
    end)
  end
  self.v_template_key = "WEAPON_REPLACE"
  self:register_exist_auto_template(self.v_template_key, self.v_attr_temp, self.v_attr_content)
end

function ui:init_now_and_select_ui()
  self.ui_info_list = {
    parent_ui = {
      [1] = self.v_equip_now,
      [2] = self.v_equip_select,
      [3] = self.v_equip_self
    },
    equip_name = {
      [1] = self.v_equip_name_now,
      [2] = self.v_equip_name_select,
      [3] = self.v_equip_name_self
    },
    quality = {
      [1] = self.v_quality_now,
      [2] = self.v_quality_select,
      [3] = self.v_quality_self
    },
    level_now = {
      [1] = self.v_lv_now_now,
      [2] = self.v_lv_select_now,
      [3] = self.v_lv_self_now
    },
    level_max = {
      [1] = self.v_lv_now_max,
      [2] = self.v_lv_select_max,
      [3] = self.v_lv_self_max
    }
  }
end

function ui:ui_on_show()
  if self.v_bind_red then
    RedPointMgr:bind_redpoint(self, self.v_red_weapon_homology, RedEnum.CHAR_EQUIP_HOMOLOGY_MATERIAL)
  end
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self._on_weapon_change, self)
end

function ui:ui_on_hide()
end

function ui:refresh_lock_view()
  local lock = self:get_uiobject("Lock")
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_info.uuid)
  local img_lock = Util.get_image("img_lock", lock)
  local img_no_lock = Util.get_image("img_no_lock", lock)
  local lock = 1 == equip_info.lock
  img_lock.gameObject:SetActive(lock)
  img_no_lock.gameObject:SetActive(not lock)
end

function ui:_on_weapon_change()
  if self.v_buddy_id then
    local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
    local equip_info = CharacterMgr:get_equip_info(buddy_info.weapon)
    self:refresh_equip_info(equip_info)
  elseif self.v_equip_uuid then
    local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
    self:refresh_equip_info(equip_info)
  end
end

function ui:refresh(equip_uuid, buddy_id)
  if buddy_id then
    local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
    self.v_buddy_id = buddy_id
    local equip_info = CharacterMgr:get_equip_info(buddy_info.weapon)
    self:refresh_equip_info(equip_info)
  elseif equip_uuid then
    self.v_equip_uuid = equip_uuid
    local equip_info = CharacterMgr:get_equip_info(equip_uuid)
    self:refresh_equip_info(equip_info)
  end
end

function ui:refresh_equip_info(now_equip_info, select_equip_info)
  self.now_info = now_equip_info
  self.select_info = select_equip_info
  self:refresh_now_equip_info()
  self:refresh_select_equip_info()
  self.v_equip_info = select_equip_info
  self:refresh_lock_view()
  self:refresh_attr_list(now_equip_info, select_equip_info)
  self:refresh_cur_skill(select_equip_info)
end

function ui:refresh_now_equip_info()
  self:refresh_equip_data(1)
end

function ui:refresh_select_equip_info()
  if self.now_info.uuid == self.select_info.uuid then
    self.ui_info_list.parent_ui[1]:SetActive(false)
    self.ui_info_list.parent_ui[2]:SetActive(false)
    self.ui_info_list.parent_ui[3]:SetActive(true)
    self:refresh_equip_data(3)
    return
  end
  self.ui_info_list.parent_ui[1]:SetActive(true)
  self.ui_info_list.parent_ui[2]:SetActive(true)
  self.ui_info_list.parent_ui[3]:SetActive(false)
  self:refresh_equip_data(1)
  self:refresh_equip_data(2)
end

function ui:refresh_equip_data(index)
  local equip_info
  if 1 == index or 3 == index then
    equip_info = self.now_info
  else
    equip_info = self.select_info
  end
  local equip_id = equip_info.id
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  self.ui_info_list.equip_name[index].text = Util.format_quality_txt_color(equip_cfg.Name, equip_cfg.Quality)
  local quality_cfg = ShareRes.get_equip_icon_cfg(equip_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(self.ui_info_list.quality[index], path)
  local level = equip_info.lv
  self.ui_info_list.level_now[index].text = tostring(level)
  local break_lv = equip_info.break_lv
  local max_level = ShareRes.get_equip_max_level(break_lv)
  self.ui_info_list.level_max[index].text = tostring(max_level)
end

function ui:refresh_attr_list(now_equip_info, select_equip_info)
  self:give_back_auto_cache(self.v_template_key)
  local is_same_weapon = now_equip_info.uuid == select_equip_info.uuid
  local now_attrs = now_equip_info.attrs
  local now_equip_cfg = ShareRes.create("equip.equip", now_equip_info.id)
  local attr_key_list = {}
  for i, v in ipairs(now_equip_cfg.BaseAttrList) do
    local attr_cfg = ShareRes.get_buddy_attr_cfg(v)
    local is_have_attr = self:is_have_attr_type(attr_key_list, attr_cfg.Name)
    if not is_have_attr then
      attr_key_list[#attr_key_list + 1] = attr_cfg.Name
    end
  end
  local select_attrs, select_equip_cfg
  if not is_same_weapon then
    select_attrs = select_equip_info.attrs
    select_equip_cfg = ShareRes.create("equip.equip", select_equip_info.id)
    for i, v in ipairs(select_equip_cfg.BaseAttrList) do
      local attr_cfg = ShareRes.get_buddy_attr_cfg(v)
      local is_have_attr = self:is_have_attr_type(attr_key_list, attr_cfg.Name)
      if not is_have_attr then
        attr_key_list[#attr_key_list + 1] = attr_cfg.Name
      end
    end
  end
  local index = 0
  for i, _ in ipairs(attr_key_list) do
    local attr_key = _
    index = index + 1
    local now_attrs_value = now_attrs[attr_key]
    local select_attrs_value
    if select_attrs then
      select_attrs_value = select_attrs[attr_key]
    end
    select_attrs_value = select_attrs_value or 0
    now_attrs_value = now_attrs_value or 0
    local attr_ui = self:get_auto_cache(self.v_template_key)
    self:update_attr_item(attr_ui, attr_key, index, now_attrs_value, select_attrs_value, is_same_weapon)
  end
end

function ui:is_have_attr_type(attr_key_list, value)
  local is_have = false
  for i, v in ipairs(attr_key_list) do
    if v == value then
      is_have = true
      break
    end
  end
  return is_have
end

function ui:update_attr_item(attr_ui, attr_key, index, now_attrs_value, select_attrs_value, is_same_weapon)
  local attr_id = FightDefine.CONFIG_NAME_ATTR_ID[attr_key]
  local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
  assert(attr_cfg, "ATTR_CFG NULL = " .. attr_id)
  local attr_icon = Util.get_image("AttrIcon", attr_ui)
  Util.load_attr_icon(attr_icon, attr_cfg.IconName)
  local attr_name_txt = Util.get_text("AttrName", attr_ui)
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  attr_name_txt.text = attr_name
  local is_ration = ShareRes.get_is_ration_attr(attr_id)
  local now_val_txt = Util.get_text("BeforeAttrVal", attr_ui)
  now_val_txt.text = Util.format_number(now_attrs_value, is_ration)
  local select_val_txt = Util.get_text("AttrVal", attr_ui)
  select_val_txt.text = Util.format_number(select_attrs_value, is_ration)
  if is_same_weapon then
    now_val_txt.gameObject:SetActive(false)
    select_val_txt.text = Util.format_number(now_attrs_value, is_ration)
  else
    now_val_txt.gameObject:SetActive(true)
  end
  local bg_img = Util.get_image("Bg", attr_ui)
  bg_img:SetActive(0 ~= index % 2)
  local allow = Util.get_child_gameobj("Arrow", attr_ui)
  allow:SetActive(not is_same_weapon)
  local up = Util.get_child_gameobj("Up", attr_ui)
  up:SetActive(not is_same_weapon and now_attrs_value < select_attrs_value)
  local down = Util.get_child_gameobj("Down", attr_ui)
  down:SetActive(not is_same_weapon and select_attrs_value < now_attrs_value)
  if up.activeSelf == true then
    select_val_txt.text = "<color=#40ff86>" .. select_val_txt.text .. "</color>"
  elseif down.activeSelf == true then
    select_val_txt.text = "<color=#ff3030>" .. select_val_txt.text .. "</color>"
  end
end

local desc_format_str = [[
<color=#D56D2E>+%s %s</color>
%s]]
local desc_format_str_percent = [[
<color=#D56D2E>+%s%% %s</color>
%s]]

function ui:refresh_cur_skill(equip_info)
  local advance_lv = equip_info.advance
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  local skill_id = advance_cfg[advance_lv].SkillId
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  local no_skill = nil == skill_cfg or skill_cfg.Name == ""
  local no_attr = 0 == skill_cfg.AttrId or 0 == skill_cfg.AttrValue
  if no_skill and no_attr then
    self.v_uicompents.SkillName_txt.text = Util.format_str("无同调技能")
    self.v_uicompents.SkillLvNum_txt.text = ""
    self.v_uicompents.SkillDesc_txt.text = ""
    self.v_uiobjects.SkillLvMax:SetActive(false)
    if skill_cfg then
      local show_skill_lv = skill_cfg.Lv
      local skill_max_lv = ShareRes.get_weapon_skill_max_lv(equip_info.id)
      self.v_uiobjects.SkillLvMax:SetActive(show_skill_lv == skill_max_lv)
    end
    return
  end
  local show_skill_lv = skill_cfg.Lv
  local skill_max_lv = ShareRes.get_weapon_skill_max_lv(equip_info.id)
  self.v_uicompents.SkillName_txt.text = skill_cfg.Name
  self.v_uicompents.SkillLvNum_txt.text = Util.format_str("Lv.{1}", show_skill_lv)
  self.v_uiobjects.SkillName:SetActive(false)
  self.v_uiobjects.SkillName:SetActive(true)
  if not no_attr then
    local attribute_name = ShareRes.get_attr_name(skill_cfg.AttrId)
    local attribute_isratio = ShareRes.get_is_ration_attr(skill_cfg.AttrId)
    local isratio = attribute_isratio or 1 == skill_cfg.AttrType
    local value = isratio and skill_cfg.AttrValue / 100 or skill_cfg.AttrValue
    local format_key = isratio and desc_format_str_percent or desc_format_str
    self.v_uicompents.SkillDesc_txt.text = string.format(format_key, value, attribute_name, skill_cfg.Desc)
  else
    self.v_uicompents.SkillDesc_txt.text = skill_cfg.Desc
  end
  self.v_uiobjects.SkillLvMax:SetActive(show_skill_lv == skill_max_lv)
end

return ui
