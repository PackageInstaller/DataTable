local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CHAR_HELPER = require("uimodule.character.char_helper")
local WEAPON_BREAK_INFO_ITEM_KEY = "WEAPON_BREAK_INFO_ITEM_KEY"
local MODEL = {}
local ATTR_TYPE = {
  HP = "HP",
  ENERGY = "ENERGY",
  ATTACK = "ATTACK",
  ENERGY_ATTACK = "ENERGY_ATTACK"
}
local ATTR2UI = {
  HP = "Infor_xueliang",
  ENERGY = "Infor_moli",
  ATTACK = "Infor_gongji",
  ENERGY_ATTACK = "Infor_tegong"
}
local STAR_START_IDX = 1
local STAR_END_IDX = 4
local CHARACTER_CONFIG = require("uimodule.character.character_config")

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_max_star_count = self.v_uiobjects.StarList.transform.childCount
  self:register_exist_auto_template(WEAPON_BREAK_INFO_ITEM_KEY, self.v_uiobjects.InfoTem, self.v_uiobjects.Infor_list)
end

function ui:ui_on_show(buddy_idx)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:refresh(buddy_idx)
end

function ui:ui_on_hide()
end

function ui:refresh(buddy_idx)
  local equip_info = CharacterMgr:get_equip_info(buddy_idx)
  local equip_id = equip_info.id
  local v_uicompents = self.v_uicompents
  local break_lv = equip_info.break_lv
  local new_lv = break_lv - 1
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  v_uicompents.Last_Lv_txt.text = new_lv - 1
  v_uicompents.New_Lv_txt.text = new_lv
  local last_max_level = ShareRes.get_equip_max_level(new_lv)
  local last_attr = CharacterMgr.cal_equip_attr(equip_id, equip_info.break_lv - 1, last_max_level)
  local new_attr = equip_info.attrs
  local show_attr_list = CharacterMgr:get_show_attr_list(equip_info.id, true)
  self:give_back_auto_cache(WEAPON_BREAK_INFO_ITEM_KEY)
  for key, value in pairs(last_attr) do
    local attr_id = Config.FightDefine.CONFIG_NAME_ATTR_ID[key]
    if show_attr_list[attr_id] and value ~= new_attr[key] then
      local item = self:get_auto_cache(WEAPON_BREAK_INFO_ITEM_KEY)
      local AttrName = Util.get_text("AttrName", item)
      AttrName.text = ShareRes.get_buddy_attr_name(attr_id)
      local LastValue = Util.get_text("LastValue", item)
      local NowValue = Util.get_text("NowValue", item)
      if attr_id == Config.FightDefine.ATTR_TYPE.CHAR_CRIT_ATK_PER then
        NowValue.text = string.format("%.2f%s", new_attr[key] / 100, "%")
        LastValue.text = string.format("%.2f%s", value / 100, "%")
      else
        NowValue.text = new_attr[key]
        LastValue.text = value
      end
    end
  end
  local max_break_lv = ShareRes.get_max_equip_break_lv(equip_id)
  for i = STAR_START_IDX, self.v_max_star_count do
    local star_obj = self.v_uiobjects["Break" .. i]
    local parent = star_obj.transform.parent.gameObject
    if i <= max_break_lv then
      parent:SetActive(true)
      star_obj.gameObject:SetActive(i <= break_lv - 1)
    else
      parent:SetActive(false)
    end
  end
  self:refresh_weapon_icon(equip_id)
end

function ui:refresh_attr_view(ui_type, old_val, new_val)
  local show = old_val == new_val
  local ui_name = ATTR2UI[ui_type]
  local obj = self.v_uiobjects[ui_name]
  obj:SetActive(not show)
end

function ui:refresh_weapon_icon(equip_id)
  local icon = CHAR_HELPER.get_equip_icon(equip_id, 2)
  local equip_img = self.v_uicompents.show_weapon_img
  ResMgr:load_set_icon(equip_img, icon, nil, true)
end

return ui
