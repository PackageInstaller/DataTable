local Base = require("ui.uibase")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_blur = {
    "Blur",
    BIND_TYPE.RAW_IMAGE
  },
  v_btn_ret = {
    "BtnRet",
    BIND_TYPE.BUTTON
  },
  v_last_lv = {
    "Last_Lv",
    BIND_TYPE.TEXT
  },
  v_lv = {
    "Lv",
    BIND_TYPE.OBJECT
  },
  v_new_lv = {
    "New_Lv",
    BIND_TYPE.TEXT
  },
  v_skill_desc = {
    "SkillDesc",
    BIND_TYPE.TEXT
  },
  vshow_weapon = {
    "show_weapon",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.bg_btn = Util.get_button("FullScreenBackground/Bg2", self.v_object)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
end

local desc_format_str = [[
<color=#D56D2E>+%s %s</color>
%s]]
local desc_format_str_percent = [[
<color=#D56D2E>+%s%% %s</color>
%s]]

function ui:ui_on_show(last_advance_lv, equip_uuid, close_cb)
  self.close_cb = close_cb
  self.v_last_lv.text = CommonDef.ROME_NUM[last_advance_lv]
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  self.v_new_lv.text = CommonDef.ROME_NUM[equip_info.advance]
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  assert(advance_cfg, "no such equip_advance, id " .. equip_info.id)
  local skill_id = advance_cfg[equip_info.advance].SkillId
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  assert(skill_cfg, "NO SKILL CFG = " .. skill_id)
  self.v_skill_desc.text = Util.format_str("{1}", skill_cfg.Desc)
  if skill_cfg.AttrId and skill_cfg.AttrValue then
    local attribute_name = ShareRes.get_attr_name(skill_cfg.AttrId)
    local attribute_isratio = ShareRes.get_is_ration_attr(skill_cfg.AttrId)
    local isratio = attribute_isratio or 1 == skill_cfg.AttrType
    local value = isratio and skill_cfg.AttrValue / 100 or skill_cfg.AttrValue
    local format_key = isratio and desc_format_str_percent or desc_format_str
    self.v_skill_desc.text = string.format(format_key, value, attribute_name, skill_cfg.Desc)
  else
    self.v_skill_desc.text = skill_cfg.Desc
  end
  local equip_cfg = ShareRes.get_equip(equip_info.id)
  local path = UtilUI.get_weapon_tex(equip_cfg.Painting[2])
  ResMgr:load_set_icon(self.vshow_weapon, path, nil, true)
end

function ui:set_max_select_count(value)
  self.max_select_count = value
end

function ui:ui_on_hide()
  if self.close_cb then
    self.close_cb()
  end
end

function ui:ui_on_update()
end

return ui
