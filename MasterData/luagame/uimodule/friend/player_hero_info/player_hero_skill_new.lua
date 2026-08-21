local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local Timer = Global.timer
local CharcterConfig = require("uimodule.character.character_config")
local PanelType = CharcterConfig.PANEL_TYPE
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local Char_Helper = require("uimodule.character.char_helper")
local CONSUMETEM_CLASS = require("uimodule.character.consumeTem")
local TEMPLATE_KEY_DATA_ITEM = "PLAYER_CHAR_SKILL_TEMPLATE_KEY_DATA_ITEM"
local Skill_Num = 7
local Talent_Num = 5
local Select_Type = {Talent = 1, Skill = 2}
local Skill_Page_Type = {Desc = 1, Data = 2}
local MODEL = {
  v_content_root = {
    "ContentRoot",
    BIND_TYPE.OBJECT
  },
  v_info_root = {
    "InfoRoot",
    BIND_TYPE.OBJECT
  },
  v_viewport = {
    "Viewport",
    BIND_TYPE.TRANSFORM
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_skill_selected_eff1 = Util.get_child_gameobj("Animation/Ani_Char_Skill_Select", self.v_parent_ui.v_object)
  self.v_skill_selected_eff2 = Util.get_child_gameobj("Animation/Ani_Char_Skill_Selectloop", self.v_parent_ui.v_object)
  self.v_talent_selected_eff1 = Util.get_child_gameobj("Animation/Ani_Char_Talent_Select", self.v_parent_ui.v_object)
  self.v_talent_selected_eff2 = Util.get_child_gameobj("Animation/Ani_Char_Talent_SelectLoop", self.v_parent_ui.v_object)
  self.v_show_info_eff = Util.get_child_gameobj("Animation/Ani_VX_SkillPannel_IN", self.v_parent_ui.v_object)
  self.v_hide_info_eff = Util.get_child_gameobj("Animation/Ani_VX_SkillPannel_Out", self.v_parent_ui.v_object)
  self.v_desc_layout_element = self:get_layout_element(nil, self.v_uiobjects.SkillDesc)
  self.v_info_root_width = self.v_uicompents.InfoRoot_rect.rect.width
  self.v_tmp_text = self.v_uiobjects.SkillDesc:GetComponent(typeof(CS.TMPro.TMP_Text))
  self:set_button("BtnBack", function()
    self:on_selected(0)
  end)
  self:set_button("SkillDesc", function()
    self:try_show_keyword()
  end)
  self:set_button("BtnCharRet", function()
    UIMgr:try_hide_ui("player_hero")
  end)
  self:set_button("BtnHeroTeaching", function()
    self:jump_to_teaching()
  end)
  self:set_button("PageDescBtn", function()
    self:switch_skill_page(Skill_Page_Type.Desc)
  end)
  self:set_button("PageDataBtn", function()
    self:switch_skill_page(Skill_Page_Type.Data)
  end)
  self:init_talent_items()
  self:init_skill_items()
  self:register_exist_auto_template(TEMPLATE_KEY_DATA_ITEM, self.v_uiobjects.DataItem, self.v_uiobjects.DataContent)
end

function ui:is_open_teaching()
  return CharacterMgr:is_open_teaching_entry(self.v_buddy_id)
end

function ui:jump_to_teaching()
  if self:is_open_teaching() then
    UIMgr:get_ui("teach_chapter_point"):ui_show(nil, self.v_buddy_id)
  end
end

function ui:ui_on_show()
  self.v_buddy_info = Player_Hero_Helper.get_hero_data()
  self.v_buddy_id = self.v_buddy_info.id
  self:refresh()
end

function ui:refresh()
  self.v_info_root:SetActiveEx(false)
  self.v_uiobjects.BtnHeroTeaching:SetActive(self:is_open_teaching() and Player_Hero_Helper.is_fake)
  self.v_buddy_skill_list_cfg = ShareRes.get_buddy_skill_list_cfg(self.v_buddy_id)
  self:refresh_talent_list()
  self:refresh_skill_list()
end

function ui:refresh_talent_list()
  self.v_talent_detail_list = ShareRes.get_buddy_talent_lv_cfg_list(self.v_buddy_id)
  table.sort(self.v_talent_detail_list, function(a, b)
    return a.Lv < b.Lv
  end)
  for idx = 1, Talent_Num do
    self:set_talent_item(idx)
  end
end

function ui:refresh_skill_list()
  local buddy_info = self.v_buddy_info
  self.v_skill_lv_data = {}
  local skill_list = buddy_info.lSkill or buddy_info.skill
  for _, v in pairs(skill_list) do
    self.v_skill_lv_data[v.id] = v.lv
  end
  self.v_skill_detail_list = {}
  local all_skill = self.v_buddy_skill_list_cfg.Skill
  for _, skill_id in ipairs(all_skill) do
    local detail_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
    self.v_skill_detail_list[#self.v_skill_detail_list + 1] = detail_cfg
  end
  table.sort(self.v_skill_detail_list, function(a, b)
    return a.SortIndex < b.SortIndex
  end)
  for idx = 1, Skill_Num do
    self:set_skill_item(idx)
  end
end

function ui:init_skill_items()
  self.v_skill_items = {}
  for idx = 1, Skill_Num do
    local item_obj = self.v_uiobjects["Skill" .. idx]
    local btn = Util.get_button(nil, item_obj)
    local select_obj = Util.get_child_gameobj("Select_", item_obj)
    local red_obj = Util.get_child_gameobj("RedPoint_", item_obj)
    local icon = Util.get_image("Icon_", item_obj)
    local lv_txt = Util.get_text("SkillLevel/SkillLvNum_", item_obj)
    local lv_obj = Util.get_child_gameobj("SkillLevel/SkillLvNum_", item_obj)
    local max_obj = Util.get_child_gameobj("SkillLevel/LvMax_", item_obj)
    local type_txt = Util.get_text("SkillNameLayout/SkillType_", item_obj)
    local name_txt = Util.get_text("SkillNameLayout/SkillName_", item_obj)
    self.v_skill_items[idx] = {
      item_obj = item_obj,
      btn = btn,
      select_obj = select_obj,
      red_obj = red_obj,
      icon = icon,
      lv_txt = lv_txt,
      lv_obj = lv_obj,
      max_obj = max_obj,
      type_txt = type_txt,
      name_txt = name_txt
    }
  end
end

function ui:init_talent_items()
  self.v_talent_items = {}
  for idx = 1, Talent_Num do
    local item_obj = self.v_uiobjects["Talent" .. idx]
    local btn = Util.get_button(nil, item_obj)
    local select_obj = Util.get_child_gameobj("Select_", item_obj)
    local red_obj = Util.get_child_gameobj("RedPoint_", item_obj)
    local icon = Util.get_image("TalentIcon_", item_obj)
    local icon_obj = Util.get_child_gameobj("TalentIcon_", item_obj)
    local lock_bg_obj = Util.get_child_gameobj("Bg/LockBg_", item_obj)
    local unlock_bg_obj = Util.get_child_gameobj("Bg/UnLockBg_", item_obj)
    local active_bg_obj = Util.get_child_gameobj("Bg/ActiveBg_", item_obj)
    local active_eff_obj = Util.get_child_gameobj("LineActive_", item_obj)
    local line_obj = Util.get_child_gameobj("Line_", item_obj)
    self.v_talent_items[idx] = {
      item_obj = item_obj,
      btn = btn,
      select_obj = select_obj,
      red_obj = red_obj,
      icon = icon,
      icon_obj = icon_obj,
      lock_bg_obj = lock_bg_obj,
      unlock_bg_obj = unlock_bg_obj,
      active_bg_obj = active_bg_obj,
      active_eff_obj = active_eff_obj,
      line_obj = line_obj
    }
  end
end

function ui:set_skill_item(idx)
  local skill_item = self.v_skill_items[idx]
  if not skill_item then
    return
  end
  local skill_detail_cfg = self.v_skill_detail_list[idx]
  skill_item.item_obj:SetActiveEx(nil ~= skill_detail_cfg)
  if not skill_detail_cfg then
    return
  end
  local skill_id = skill_detail_cfg.Id
  local skill_lv = self.v_skill_lv_data[skill_id] or 1
  local max_lv = ShareRes.get_buddy_skill_max_lv(skill_id)
  skill_item.lv_obj:SetActiveEx(skill_lv < max_lv)
  skill_item.max_obj:SetActiveEx(skill_lv >= max_lv)
  if skill_lv < max_lv then
    skill_item.lv_txt.text = skill_lv
  end
  skill_item.type_txt.text = skill_detail_cfg.SkillTypeName
  skill_item.name_txt.text = skill_detail_cfg.Name
  skill_item.select_obj:SetActiveEx(false)
  Util.load_skill_icon(skill_detail_cfg.Icon, skill_item.icon)
  self:set_button_listener(skill_item.btn, function()
    self:on_selected(idx, Select_Type.Skill)
  end)
  skill_item.red_obj:SetActiveEx(false)
end

local icon_lock_color = Util.get_unity_color_by_hex(tonumber("9a9a9a", 16))
local icon_unlock_color = Util.get_unity_color_by_hex(tonumber("ffffff", 16))

function ui:set_talent_item(idx)
  local talent_item = self.v_talent_items[idx]
  if not talent_item then
    return
  end
  local talent_detail_cfg = self.v_talent_detail_list[idx]
  talent_item.item_obj:SetActiveEx(nil ~= talent_detail_cfg)
  if not talent_detail_cfg then
    return
  end
  local buddy_info = self.v_buddy_info
  local buddy_break_lv = buddy_info.break_lv
  local buddy_talent_lv = buddy_info.talent_lv or 0
  local need_break_lv = talent_detail_cfg.NeedBreak
  local item_talent_lv = talent_detail_cfg.Lv
  local is_active = buddy_talent_lv >= item_talent_lv
  local cond_done = buddy_break_lv >= need_break_lv
  local can_active = not is_active and cond_done
  talent_item.lock_bg_obj:SetActiveEx(not cond_done)
  talent_item.unlock_bg_obj:SetActiveEx(is_active)
  talent_item.active_bg_obj:SetActiveEx(can_active)
  if talent_item.active_eff_obj then
    talent_item.active_eff_obj:SetActiveEx(is_active)
  end
  if talent_item.line_obj then
    talent_item.line_obj:SetActiveEx(not is_active)
  end
  talent_item.icon.color = is_active and icon_unlock_color or icon_lock_color
  talent_item.select_obj:SetActiveEx(false)
  Util.load_talent_icon(talent_detail_cfg.Icon, talent_item.icon)
  self:set_button_listener(talent_item.btn, function()
    self:on_selected(idx, Select_Type.Talent)
  end)
  local red = false
  talent_item.red_obj:SetActiveEx(red)
end

function ui:on_selected(idx, select_ty)
  self.v_select_ty = select_ty
  local select_skill_idx = select_ty == Select_Type.Skill and idx or 0
  for i, skill_item in ipairs(self.v_skill_items) do
    skill_item.select_obj:SetActiveEx(select_skill_idx == i)
  end
  local select_talent_idx = select_ty == Select_Type.Talent and idx or 0
  for i, skill_item in ipairs(self.v_talent_items) do
    skill_item.select_obj:SetActiveEx(select_talent_idx == i)
  end
  self.v_skill_selected_eff1:SetActiveEx(false)
  self.v_skill_selected_eff1:SetActiveEx(0 ~= select_skill_idx)
  self.v_skill_selected_eff2:SetActiveEx(0 ~= select_skill_idx)
  self.v_talent_selected_eff1:SetActiveEx(false)
  self.v_talent_selected_eff1:SetActiveEx(0 ~= select_talent_idx)
  self.v_talent_selected_eff2:SetActiveEx(0 ~= select_talent_idx)
  self.v_info_root:SetActiveEx(0 ~= idx)
  self.v_show_info_eff:SetActiveEx(0 ~= idx)
  self.v_hide_info_eff:SetActiveEx(0 == idx)
  if 0 ~= idx then
    self.v_uiobjects.BtnBack:SetActive(true)
    if select_ty == Select_Type.Skill then
      self:show_skill_info(idx)
    else
      self:show_talent_info(idx)
    end
    self.v_is_show_info = true
  else
    self.v_cur_skill_page = nil
  end
  self:set_timer(idx)
  if self.v_idx_cache ~= idx or self.v_type_cache ~= select_ty then
    self.v_idx_cache, self.v_type_cache = idx, select_ty
  end
end

function ui:set_timer(idx)
  self:clear_timer()
  if 0 == idx then
    self.v_timer_idx = Timer:add_timer("char_skill_new:set_timer", 0.4, function()
      self.v_uiobjects.BtnBack:SetActive(false)
      self.v_is_show_info = false
    end)
  else
    self.v_timer_idx = Timer:add_timer("char_skill_new:set_timer", 0.1, function()
      self.v_desc_layout_element.minHeight = self.v_viewport.rect.height + 3
    end)
  end
end

function ui:switch_skill_page(skill_page_type)
  if not self.v_cur_skill_idx or self.v_cur_skill_page == skill_page_type then
    return
  end
  self.v_cur_skill_page = skill_page_type
  self:show_skill_info(self.v_cur_skill_idx)
end

function ui:show_skill_info(idx, is_preview_next_lv, skill_page_type, is_preview_max_lv)
  local buddy_info = self.v_buddy_info
  local buddy_break_lv = buddy_info.break_lv
  skill_page_type = skill_page_type or self.v_cur_skill_page or Skill_Page_Type.Desc
  self.v_cur_skill_page = skill_page_type
  self.v_cur_skill_idx = idx
  self.v_uiobjects.PageDescSelected:SetActiveEx(skill_page_type == Skill_Page_Type.Desc)
  self.v_uiobjects.PageDataSelected:SetActiveEx(skill_page_type == Skill_Page_Type.Data)
  self.v_uiobjects.SkillPage:SetActive(true)
  self.v_uiobjects.TalentType:SetActive(false)
  local skill_detail_cfg = self.v_skill_detail_list[idx]
  local skill_id = skill_detail_cfg.Id
  local skill_lv = self.v_skill_lv_data[skill_id] or 1
  local max_lv = ShareRes.get_buddy_skill_max_lv(skill_id)
  local is_max = skill_lv >= max_lv
  local is_fix_lv = 1 == max_lv
  local is_preview = is_preview_next_lv and not is_fix_lv and not is_max
  local can_preview = not is_preview_next_lv and not is_fix_lv and not is_max
  self.v_uiobjects.FixTip:SetActiveEx(is_fix_lv)
  self.v_uiobjects.SkillLv:SetActiveEx(not is_fix_lv)
  self.v_uicompents.Name_txt.text = skill_detail_cfg.Name
  local lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  local desc = lv_cfg.Desc
  self.v_uiobjects.Padding:SetActiveEx(is_preview)
  self.v_uiobjects.SkillNextLv:SetActiveEx(is_preview)
  self.v_uiobjects.SkillNextLvNum:SetActiveEx(is_preview)
  if not is_fix_lv then
    self.v_uicompents.SkillLvNum_txt.text = skill_lv
    if is_preview then
      self.v_uicompents.SkillNextLvNum_txt.text = skill_lv + 1
    elseif is_preview_max_lv then
      self.v_uicompents.SkillLvNum_txt.text = max_lv
    end
    self:set_button_listener(self.v_uicompents.BtnPreviewMax_btn, function()
      self:show_skill_info(idx, nil, nil, not is_preview_max_lv)
    end)
  end
  self.v_uiobjects.DateScroll:SetActiveEx(skill_page_type ~= Skill_Page_Type.Desc)
  self.v_uiobjects.DescScroll:SetActiveEx(skill_page_type == Skill_Page_Type.Desc)
  self.v_uiobjects.BtnPreviewMax:SetActiveEx(skill_page_type == Skill_Page_Type.Data and not is_fix_lv and Player_Hero_Helper.is_fake)
  if skill_page_type == Skill_Page_Type.Desc then
    self.v_tmp_text.text = desc
    self.v_uicompents.SkillDesc_rect:SetAnchoredPositionA(0, 0, 0)
  else
    local next_lv_cfg
    if is_preview then
      next_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv + 1)
    elseif is_preview_max_lv then
      lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, max_lv)
    end
    self:_show_data_items(lv_cfg, next_lv_cfg)
    self.v_uicompents.TxtPreviewMax_txt.text = is_preview_max_lv and "返回" or "满级"
  end
  self.v_keyword_list = skill_detail_cfg.Keywords
  self.v_uiobjects.MaxTip:SetActiveEx(is_max and not is_fix_lv and not is_preview and not is_preview_max_lv)
  self.v_uiobjects.CostLayout:SetActiveEx(false)
  self:set_timer(idx)
end

local normal_color = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))
local highlight_color = Util.get_unity_color_by_hex(tonumber("ffd07b", 16))

function ui:_show_data_items(lv_cfg, next_lv_cfg)
  self:give_back_auto_cache(TEMPLATE_KEY_DATA_ITEM)
  local cur_show_cfg = next_lv_cfg or lv_cfg
  local data_name_list = cur_show_cfg.DataTxt
  local data_val_list = cur_show_cfg.DataVal
  if not data_name_list or 0 == #data_name_list then
    return
  end
  for idx, name in ipairs(data_name_list) do
    local item = self:get_auto_cache(TEMPLATE_KEY_DATA_ITEM)
    local name_txt = Util.get_text("NameText", item)
    local val_txt = Util.get_text("ValTxt", item)
    name_txt.text = name
    val_txt.text = data_val_list[idx]
    val_txt.color = data_val_list[idx] == lv_cfg.DataVal[idx] and normal_color or highlight_color
  end
end

function ui:show_talent_info(idx)
  local talent_detail_cfg = self.v_talent_detail_list[idx]
  local buddy_info = self.v_buddy_info
  local buddy_break_lv = buddy_info.break_lv
  local buddy_talent_lv = buddy_info.talent_lv or 0
  local need_break_lv = talent_detail_cfg.NeedBreak
  local item_talent_lv = talent_detail_cfg.Lv
  local is_active = buddy_talent_lv >= item_talent_lv
  local is_pre_active = buddy_talent_lv >= item_talent_lv - 1
  local cond_done = buddy_break_lv >= need_break_lv
  local can_active = not is_active and is_pre_active and cond_done
  self.v_uiobjects.SkillPage:SetActive(false)
  self.v_uiobjects.TalentType:SetActive(true)
  self.v_uiobjects.DateScroll:SetActiveEx(false)
  self.v_uiobjects.DescScroll:SetActiveEx(true)
  self.v_uiobjects.BtnPreviewMax:SetActiveEx(false)
  self.v_uiobjects.FixTip:SetActiveEx(false)
  self.v_uiobjects.MaxTip:SetActiveEx(false)
  self.v_uiobjects.SkillLv:SetActiveEx(false)
  self.v_uicompents.Name_txt.text = talent_detail_cfg.Type
  local attr_desc = CharacterMgr:get_talent_attr_desc(self.v_buddy_id, idx)
  if talent_detail_cfg.Desc and talent_detail_cfg.Desc ~= "" then
    if attr_desc then
      self.v_tmp_text.text = talent_detail_cfg.Desc .. "\n" .. attr_desc
    else
      self.v_tmp_text.text = talent_detail_cfg.Desc
    end
  else
    self.v_tmp_text.text = attr_desc
  end
  self.v_keyword_list = talent_detail_cfg.Keywords
  self.v_uiobjects.CostLayout:SetActiveEx(false)
  self:set_timer(idx)
end

function ui:ui_on_hide()
  self:clear_timer()
  self.v_is_show_info = false
end

function ui:ui_on_destroy()
  self:clear_timer()
  self.v_is_show_info = false
end

function ui:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function ui:try_show_keyword()
  if self.v_keyword_list then
    UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_keyword_list)
  end
end

return ui
