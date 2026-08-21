local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _insert = table.insert
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local FightDefine = require("cs_share.fight_define")
local _tinsert = table.insert
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_template = {
    "AttrTemp",
    BIND_TYPE.OBJECT
  }
}
local FightDefine = require("cs_share.fight_define")
local ATTR_MAX_TYPE = FightDefine.RES2MAX
local ATTR_DETAIL_KEY = "ATTR_DETAIL_KEY"
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
    self.v_buddy_info = nil
  end)
  self:set_button("NoClick", function()
    self.v_uiobjects.AttrDetailTips:SetActive(false)
  end)
  self:register_exist_auto_template(ATTR_DETAIL_KEY, self.v_attr_template, self.v_attr_content)
end

function ui:ui_update()
end

function ui:ui_on_show(buddy_id, buddy_info, is_other)
  self.v_buddy_id = buddy_id
  self.v_buddy_info = buddy_info
  if self.v_buddy_info then
    self.v_buddy_id = buddy_info.id
  else
    self.v_buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  end
  self.v_is_other = is_other
  self.v_attr_item_list = {}
  self.v_uicompents.AttrContent_rect:SetAnchoredPositionA(0, 0)
  self.v_uiobjects.NoClick:SetActive(false)
  self.v_uiobjects.AttrDetailTips:SetActive(false)
  self:update_attr_group()
end

function ui:ui_on_hide()
  for _, obj in pairs(self.v_attr_item_list) do
    ResMgr:destroy_gameobj(obj)
  end
  self.v_attr_item_list = {}
end

function ui:update_attr_group()
  local buddy_info = self.v_buddy_info
  local buddy_data = {
    break_lv = buddy_info.break_lv,
    advance = buddy_info.advance,
    talent_lv = buddy_info.talent_lv,
    lv = buddy_info.lv
  }
  local attrs = CHARACTER_CONFIG.get_buddy_base_attr(self.v_buddy_id, buddy_data)
  local attr_group = ShareRes.get_buddy_group_attr()
  local group_cfg = ShareRes.get_attr_group_cfg()
  self.v_puzzle_add_attrs = PuzzleMgr:get_puzzle_attrs_by_data(buddy_info.puzzle_graph)
  local equip_info
  if self.v_is_other then
    equip_info = buddy_info.weapon_info
  else
    equip_info = CharacterMgr:get_equip_info(buddy_info.weapon)
  end
  self.v_equip_add_attrs = equip_info.attrs
  local advance_add_attr_id, advance_add_attr_val, is_ratio = CharacterMgr.get_equip_advance_add_fixed_attr(equip_info.id, equip_info.advance, true)
  self.v_equip_advance_add_attr = {
    id = advance_add_attr_id,
    val = advance_add_attr_val,
    is_ratio = is_ratio
  }
  local upgrade_talent_cfg = ShareRes.create("buddy.buddy_talent_new_attr")[self.v_buddy_id]
  local talent_lv = buddy_info.talent_lv
  self.v_talent_add_ratio_attrs = {}
  if talent_lv then
    for lv = 1, talent_lv do
      local talent_lv_cfg = upgrade_talent_cfg[lv]
      if talent_lv_cfg and 1 == talent_lv_cfg.AttrType then
        self.v_talent_add_ratio_attrs[talent_lv_cfg.AttrId] = talent_lv_cfg.AttrValue
      end
    end
  end
  self:give_back_auto_cache(ATTR_DETAIL_KEY)
  for group_id, attr_list in ipairs(attr_group) do
    local group_obj = self:get_auto_cache(ATTR_DETAIL_KEY)
    local cfg = group_cfg[group_id]
    local group_name = Util.get_text("Title/Text", group_obj)
    group_name.text = cfg.GroupName
    self:update_attr_list(group_obj, attr_list, attrs)
  end
end

function ui:update_attr_list(group_obj, attr_list, attrs_list)
  local attr_temp = Util.get_child_gameobj("AttrInfo", group_obj)
  attr_temp.gameObject:SetActive(false)
  table.sort(attr_list, function(a, b)
    return a.AttrId < b.AttrId
  end)
  local buddy_cfg = ShareRes.get_buddy_cfg(self.v_buddy_id)
  local buddy_res_attr = buddy_cfg.ResAttrId
  local new_attr_data = {}
  for index, attr_data in ipairs(attr_list) do
    local attr_id = attr_data.AttrId
    if not ShareRes.get_is_masked_attr(attr_id) then
      local check_res = attr_data.CheckRes or 0
      if 0 == check_res or attr_id == buddy_res_attr then
        _tinsert(new_attr_data, attr_data.AttrId)
        if attr_data.GroupAttr then
          for index, attr_id in ipairs(attr_data.GroupAttr) do
            _tinsert(new_attr_data, attr_id)
          end
        end
      end
    end
  end
  local group_obj_transform = group_obj.transform
  local buddy_info = self.v_buddy_info
  for idx, attr_id in ipairs(new_attr_data) do
    local attr_obj = ResMgr:instantiate(attr_temp)
    attr_obj:SetActive(true)
    attr_obj.transform:SetParent(group_obj_transform, false)
    _tinsert(self.v_attr_item_list, attr_obj)
    local cfg = ShareRes.get_attr_cfg(attr_id)
    local attr_name = cfg.Name
    local name_txt = Util.get_text("AttriName", attr_obj)
    name_txt.text = attr_name
    assert(attrs_list[attr_id], "ERROR ATTR ID = " .. attr_id)
    local attr_val = attrs_list[attr_id].FIXED
    local attr_max_id = ATTR_MAX_TYPE[attr_id]
    if attr_val == math.huge and attr_max_id then
      attr_val = attrs_list[attr_max_id].FIXED
    end
    local attr_txt = Util.get_text("AttriNum", attr_obj)
    local change_txt = Util.get_text("AttriChange", attr_obj)
    local detail_btn = Util.get_button("BtnDetail", attr_obj)
    if not Util.is_empty(cfg.AttrDesc) then
      self:add_detial_listener(detail_btn, attr_val, cfg)
      detail_btn.gameObject:SetActive(true)
    else
      detail_btn.gameObject:SetActive(false)
    end
    local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
    assert(attr_cfg, "ATTR_CFG NULL = " .. attr_id)
    local base_and_potential_talent = attr_val
    local equip_add = self.v_equip_add_attrs[attr_cfg.Name] or 0
    local talent_ratio_val = self.v_talent_add_ratio_attrs[attr_id] or 0
    local advance_fixed_val, advance_ratio_val = 0, 0
    if attr_id == self.v_equip_advance_add_attr.id and self.v_equip_advance_add_attr.val then
      if self.v_equip_advance_add_attr.is_ratio then
        advance_ratio_val = self.v_equip_advance_add_attr.val
      else
        advance_fixed_val = self.v_equip_advance_add_attr.val
      end
    end
    local puzzle_fixed_val, puzzle_ratio_val = 0, 0
    if self.v_puzzle_add_attrs[attr_id] then
      puzzle_fixed_val = self.v_puzzle_add_attrs[attr_id].FIXED
      puzzle_ratio_val = self.v_puzzle_add_attrs[attr_id].RATIO
    end
    local fixed_val = base_and_potential_talent + equip_add + advance_fixed_val + puzzle_fixed_val
    local ratio_val = talent_ratio_val + advance_ratio_val + puzzle_ratio_val
    local add_val = fixed_val * ratio_val / 10000
    local is_ration = ShareRes.get_is_ration_attr(attr_id)
    attr_txt.text = Util.format_number(fixed_val, is_ration)
    if add_val > 0 then
      change_txt.text = string.format("+%s", Util.format_number(add_val, is_ration))
    else
      change_txt.text = ""
    end
  end
end

function ui:add_detial_listener(detail_btn, attr_val, attr_cfg)
  local function cb()
    local str = attr_cfg.AttrDesc
    
    if attr_cfg.Id == FightDefine.ATTR_TYPE.ABNORMAL_PURE_ESSENCE then
      if attr_val < 0 then
        return
      end
      local effect_cfg = ShareRes.get_abnormal_parameter_cfg(attr_val)
      if effect_cfg then
        local temp = table.pack(effect_cfg.WaterArg[1], effect_cfg.WaterArg[2], effect_cfg.FireArg[1], effect_cfg.FireArg[2], effect_cfg.FireArg[3], effect_cfg.FireArg[4], effect_cfg.ThunderArg[1], effect_cfg.ThunderArg[2], effect_cfg.ThunderArg[3], effect_cfg.LightArg[1], effect_cfg.LightArg[2], effect_cfg.DarkArg[1], effect_cfg.DarkArg[2])
        local show_cfg = ShareRes.create("magic.abnormal_parameter_display")
        local temp_result
        for key, cfg in pairs(show_cfg) do
          if temp[key] and cfg.DisplayType then
            if 1 == cfg.DisplayType then
              temp_result = temp[key] / 100
            elseif 2 == cfg.DisplayType then
              temp_result = temp[key] * 100
            end
            temp[key] = temp_result .. "%"
          end
        end
        str = Util.format_str(str, table.unpack(temp))
      end
    end
    self.v_uiobjects.NoClick:SetActive(true)
    self.v_uicompents.AttrName_txt.text = attr_cfg.Name
    self.v_uicompents.AttriDesc_txt.text = str
    self.v_uiobjects.AttrDetailTips:SetActive(true)
    local pos = detail_btn.transform.position
    pos.z = self.v_uiobjects.AttrDetailTips.transform.position.z
    self.v_uiobjects.AttrDetailTips.transform.position = pos
  end
  
  self:set_button_listener(detail_btn, cb)
end

return ui
