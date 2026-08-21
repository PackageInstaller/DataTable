local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local ATTR_BUDDY_KEY = "ATTR_BUDDY_KEY_PLAYER"
local LEVEL_COMPONENT = require("uimodule.character.char_level_component")
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local MODEL = {
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_detil = {
    "AttrDetil",
    BIND_TYPE.BUTTON
  },
  v_attr_temp = {
    "AttrTemp",
    BIND_TYPE.OBJECT
  },
  v_btn_break_up = {
    "BtnBreakUp",
    BIND_TYPE.BUTTON
  },
  v_btn_level_up = {
    "BtnLevelUp",
    BIND_TYPE.BUTTON
  },
  v_char_name = {
    "CharName",
    BIND_TYPE.TEXT
  },
  v_char_quality = {
    "CharQuality",
    BIND_TYPE.IMAGE
  },
  v_culture_max = {
    "CultureMax",
    BIND_TYPE.IMAGE
  },
  v_element = {
    "Element",
    BIND_TYPE.IMAGE
  },
  v_rb_character = {
    "RBCharacter",
    BIND_TYPE.OBJECT
  },
  v_red_char_break = {
    "RedCharBreak",
    BIND_TYPE.IMAGE
  },
  v_red_char_up = {
    "RedCharUp",
    BIND_TYPE.IMAGE
  },
  v_ui_char_level = {
    "UIChar_Level",
    BIND_TYPE.BUTTON
  }
}
local SHOW_ATTR_TYPE = {BASE = 1}
local CHARACTER_CONFIG = require("uimodule.character.character_config")

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("AttrDetil", function()
    UIMgr:get_ui("char_attr_detail"):ui_show(nil, self.v_buddy_info, true)
  end)
  self:set_button("BtnLevelUp", function()
    UIMgr:get_ui("char_levelup_box"):ui_show(self.v_buddy_id)
  end)
  self:set_button("BtnBreakUp", function()
    UIMgr:get_ui("char_levelup_box"):ui_show(self.v_buddy_id)
  end)
  self:set_button("BtnPreview", function()
    if self.v_buddy_info.lv > 1 then
      Player_Hero_Helper.switch_fake_buddy_to_min_lv()
    else
      Player_Hero_Helper.switch_fake_buddy_to_max_lv()
    end
    self:refresh()
  end)
  self:set_button("Element", function()
    UIMgr:get_ui("element_job_tips"):ui_show(self.v_buddy_id, Config.CHAR_TIP_PAGE_TYPE.ELEMENT)
  end)
  self:set_button("Job", function()
    UIMgr:get_ui("element_job_tips"):ui_show(self.v_buddy_id, Config.CHAR_TIP_PAGE_TYPE.JOB)
  end)
  self:register_exist_auto_template(ATTR_BUDDY_KEY, self.v_attr_temp, self.v_attr_content)
  self.v_rb_character:SetActive(false)
  self.v_level_ui = LEVEL_COMPONENT:ui_wrap_ex(self, self.v_ui_char_level.gameObject, false)
end

function ui:ui_on_show()
  self:refresh()
end

function ui:ui_on_hide()
end

function ui:refresh()
  self.v_buddy_info = Player_Hero_Helper.get_hero_data()
  self.v_buddy_id = self.v_buddy_info.id
  self.v_show_attr_type = SHOW_ATTR_TYPE.BASE
  self.v_level_ui:set_enable(true, self.v_buddy_id, self.v_buddy_info)
  self.v_level_ui:refresh_level_ui(self.v_buddy_id, self.v_buddy_info, true, Player_Hero_Helper.is_fake)
  self:update_buddy_advance_info()
  self:update_buddy_attr_info()
  self:refresh_buddy_break_info()
  self.v_uiobjects.BtnPreview:SetActive(Player_Hero_Helper.is_fake)
  if Player_Hero_Helper.is_fake then
    self.v_uicompents.PreviewText_txt.text = Util.format_str(self.v_buddy_info.lv > 1 and "满级" or "初始")
  end
end

function ui:update_buddy_advance_info()
  local buddy_cfg = ShareRes.create("buddy.buddy", self.v_buddy_id)
  self.v_char_name.text = Util.format_quality_txt_color(buddy_cfg.Name, buddy_cfg.Quality)
  Char_Helper.set_buddy_tag_txt(self.v_uicompents.Tag1_txt, self.v_uicompents.Tag2_txt, buddy_cfg)
  local element_icon_path = Char_Helper.get_char_element_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_element, element_icon_path)
  local job_icon_path = Char_Helper.get_char_job_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.Job_img, job_icon_path)
end

function ui:update_buddy_attr_info()
  self:update_attr_list()
end

function ui:update_attr_list()
  self:give_back_auto_cache(ATTR_BUDDY_KEY)
  if not self.v_buddy_info then
    return
  end
  local attrs = self.v_buddy_info.attrs
  local show_buddy_attr_cfg = ShareRes.get_show_buddy_attr_cfg(self.v_buddy_id)
  assert(show_buddy_attr_cfg, "ATTR CFG NULL = " .. self.v_buddy_id)
  local show_type = SHOW_ATTR_TYPE.BASE
  local attr_list = show_buddy_attr_cfg.BaseAttr
  local puzzle_add_attrs = PuzzleMgr:get_puzzle_attrs_by_data(self.v_buddy_info.puzzle_graph)
  local equip_info = self.v_buddy_info.weapon_info
  local equip_add_attrs = equip_info.attrs
  local advance_add_attr_id, advance_add_attr_val, is_ratio = CharacterMgr.get_equip_advance_add_fixed_attr(equip_info.id, equip_info.advance, true)
  local equip_advance_add_attr = {
    id = advance_add_attr_id,
    val = advance_add_attr_val,
    is_ratio = is_ratio
  }
  local upgrade_talent_cfg = ShareRes.create("buddy.buddy_talent_new_attr")[self.v_buddy_id]
  local talent_lv = self.v_buddy_info.talent_lv
  local talent_add_ratio_attrs = {}
  if talent_lv then
    for lv = 1, talent_lv do
      local talent_lv_cfg = upgrade_talent_cfg[lv]
      if talent_lv_cfg and 1 == talent_lv_cfg.AttrType then
        talent_add_ratio_attrs[talent_lv_cfg.AttrId] = talent_lv_cfg.AttrValue
      end
    end
  end
  local idx = 0
  for index, attr_id in ipairs(attr_list) do
    if not ShareRes.get_is_masked_attr(attr_id) then
      idx = idx + 1
      local attr_ui = self:get_auto_cache(ATTR_BUDDY_KEY)
      self:update_attr_info(attr_ui, attr_id, idx, attrs, puzzle_add_attrs, equip_add_attrs, equip_advance_add_attr, talent_add_ratio_attrs)
    end
  end
end

function ui:update_attr_info(attr_ui, attr_id, index, attrs, puzzle_add_attrs, equip_add_attrs, equip_advance_add_attr, talent_add_ratio_attrs)
  local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
  assert(attr_cfg, "ATTR_CFG NULL = " .. attr_id)
  local attr_name_txt = Util.get_text("AttrName", attr_ui)
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  attr_name_txt.text = attr_name
  local attr_icon = Util.get_image("AttrIcon", attr_ui)
  Util.load_attr_icon(attr_icon, attr_cfg.IconName)
  local attr_val_txt = Util.get_text("AttrVal", attr_ui)
  local base_and_potential_talent = attrs[attr_cfg.Name] or 0
  local equip_add = equip_add_attrs[attr_cfg.Name] or 0
  local talent_ratio_val = talent_add_ratio_attrs[attr_id] or 0
  local advance_fixed_val, advance_ratio_val = 0, 0
  if attr_id == equip_advance_add_attr.id and equip_advance_add_attr.val then
    if equip_advance_add_attr.is_ratio then
      advance_ratio_val = equip_advance_add_attr.val
    else
      advance_fixed_val = equip_advance_add_attr.val
    end
  end
  local puzzle_fixed_val, puzzle_ratio_val = 0, 0
  if puzzle_add_attrs[attr_id] then
    puzzle_fixed_val = puzzle_add_attrs[attr_id].FIXED
    puzzle_ratio_val = puzzle_add_attrs[attr_id].RATIO
  end
  local fixed_val = base_and_potential_talent + equip_add + advance_fixed_val + puzzle_fixed_val
  local ratio_val = talent_ratio_val + advance_ratio_val + puzzle_ratio_val
  local final_val = fixed_val + fixed_val * ratio_val / 10000
  local is_ration = ShareRes.get_is_ration_attr(attr_id)
  attr_val_txt.text = Util.format_number(final_val, is_ration)
  local bg_img = Util.get_image("Bg", attr_ui)
  bg_img:SetActive(0 ~= index % 2)
end

function ui:refresh_buddy_break_info()
  self.v_culture_max.gameObject:SetActive(false)
  if not self.v_buddy_id then
    return
  end
  local buddy_break_cfg = ShareRes.create("buddy.buddy_break", self.v_buddy_id)[self.v_buddy_info.break_lv + 1]
  if not buddy_break_cfg then
    self:check_buddy_can_lvup()
    return
  end
  local need_break = CharacterMgr:is_need_break(self.v_buddy_id)
  self.v_btn_break_up.gameObject:SetActive(need_break)
  self.v_btn_level_up.gameObject:SetActive(not need_break)
end

function ui:check_buddy_can_lvup()
  local max_level = ShareRes.get_buddy_max_level(self.v_buddy_info.break_lv)
  if max_level <= self.v_buddy_info.lv then
    self.v_btn_break_up.gameObject:SetActive(false)
    self.v_btn_level_up.gameObject:SetActive(false)
    self.v_culture_max.gameObject:SetActive(true)
  else
    self.v_btn_break_up.gameObject:SetActive(false)
    self.v_btn_level_up.gameObject:SetActive(true)
  end
end

return ui
