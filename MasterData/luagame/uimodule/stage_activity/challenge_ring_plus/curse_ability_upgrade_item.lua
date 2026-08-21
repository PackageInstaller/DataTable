local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local enough_color = Util.get_unity_color_by_hex(tonumber("F5EDE2", 16))
local not_enough_color = Util.CommonColor_RedWarm
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local CURSE_CHOOSE_ITEM_TYPE = curse_common_define.CURSE_CHOOSE_ITEM_TYPE

function ui:on_click_Recommend()
  UIMgr:try_show_ui("equation_show_tips")
end

function ui:on_click_TalentDesc()
  if UtilTable.is_empty(self.v_key_id_list) then
    return
  end
  UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_key_id_list)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_ability_cfg = nil
  self.v_quality = nil
  self.v_ability_index = nil
  self.v_main_genres_id = nil
  self.v_ability_grade = nil
  self.v_ability_id = nil
  self.v_is_only_show = nil
end

function ui:ui_on_destroy()
end

function ui:set_data(ability_id, ability_index, is_only_show, show_type)
  self.v_show_type = show_type
  self.v_is_only_show = is_only_show
  self.v_ability_index = ability_index
  self.v_ability_id = ability_id
  self.v_main_genres_id = GenresMgr:get_main_genres_id()
  self.v_ability_grade = GenresMgr:get_ability_grade(ability_id) or 1
  local ability_cfg = ShareRes.get_ability_cfg(ability_id)
  self.v_quality = ability_cfg.Quality
  self.v_ability_cfg = ability_cfg
  self.v_ability_upgrade_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, self.v_ability_grade)
  if not self.v_ability_upgrade_cfg then
    Log.Error("配置能力升级配置获取失败，能力id:", self.v_ability_id, "等级：", self.v_ability_grade)
    return
  end
  self:set_lv_up_ability_item_info()
  local toggle = self:get_toggle()
  self:set_toggle_listener(toggle, function()
    self:on_click_toggle()
  end)
  return toggle
end

function ui:set_lv_up_ability_item_info()
  self:set_start()
  self:set_icon(false)
  self:set_text(false)
  self:set_lv()
end

function ui:set_lv()
  local max_lv = ShareRes.get_ability_max_lv(self.v_ability_id)
  local cur_lv_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, self.v_ability_grade + 1)
  if self.v_uiobjects.IllustratedLock then
    self.v_uiobjects.IllustratedLock:SetActive(false)
  end
  if self.v_uiobjects.Lock then
    self.v_uiobjects.Lock:SetActive(false)
  end
  if self.v_uiobjects.HandBookUnlock then
    self.v_uiobjects.HandBookUnlock:SetActive(false)
  end
  local is_max_level = max_lv <= self.v_ability_grade
  local is_cost_updagrade = self.v_show_type == CURSE_CHOOSE_ITEM_TYPE.COST_UPDAGRADE_ABILITY
  local show_cost = is_cost_updagrade and not is_max_level and cur_lv_cfg and Util.is_more_than_zero(cur_lv_cfg.CostItem) and Util.is_more_than_zero(cur_lv_cfg.CostItemCount)
  if show_cost then
    local final_cost = ChallengeRingPlusMgr:get_after_discount_price(cur_lv_cfg.CostItemCount)
    local path = UtilUI.get_item_icon(cur_lv_cfg.CostItem)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, path)
    self.v_uicompents.CurrText_txt.text = final_cost
  end
  if not is_cost_updagrade then
    self.v_uicompents.LvMax_txt.text = is_max_level and "已强化" or "未强化"
  end
  if self.v_uiobjects.LvMax then
    self.v_uiobjects.LvMax:SetActive(is_max_level or not is_cost_updagrade)
  end
  self.v_uiobjects.CurrLayout:SetActive(show_cost)
end

function ui:set_start()
  local start_layout_tf = self.v_uiobjects.StarLayout.transform
  if start_layout_tf.childCount < self.v_ability_cfg.Star then
    for index = start_layout_tf.childCount, self.v_ability_cfg.Star do
      local child_tf = start_layout_tf:GetChild(0)
      UnityGameObject.Instantiate(child_tf.gameObject, start_layout_tf)
    end
  end
  for index = 1, start_layout_tf.childCount do
    local child_tf = start_layout_tf:GetChild(index - 1)
    if index <= self.v_ability_cfg.Star and index <= self.v_ability_cfg.Star then
      child_tf.gameObject:SetActive(true)
    else
      child_tf.gameObject:SetActive(false)
    end
  end
end

function ui:set_icon(is_drop)
  local genres_cfg = ShareRes.get_genres_cfg(self.v_ability_cfg.Sect)
  local quality_cfg = ShareRes.get_ability_quality_cfg(self.v_quality)
  ResMgr:load_set_icon(self.v_uicompents.SectIcon_img, genres_cfg.IconPath, nil, true, self)
  local bg_path = (self.v_is_only_show or is_drop) and quality_cfg.QualityBg1 or quality_cfg.QualityBg3
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, bg_path, nil, true, self)
  if self.v_uiobjects.RedPoint then
    self.v_uiobjects.RedPoint:SetActive(false)
  end
  if self.v_uiobjects.IllustratedLock then
    self.v_uiobjects.IllustratedLock:SetActive(false)
  end
end

function ui:set_text(is_drop)
  if self.v_uiobjects.ScrollView then
    self.v_uiobjects.ScrollView:SetActive(true)
  end
  if is_drop then
    self.v_uicompents.TalentDesc_txt.text = self.v_ability_upgrade_cfg.Desc
    self.v_uicompents.Tag_txt.text = self.v_ability_cfg.Tag
  end
  if self.v_is_only_show and self.v_uiobjects.TalentLvUpDesc then
    local ability_next_lv_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, self.v_ability_grade + 1)
    if ability_next_lv_cfg then
      self.v_uicompents.TalentLvUpDesc_txt.text = "<color=#ffda90>升级后：</color>" .. ability_next_lv_cfg.Desc
      self.v_uiobjects.TalentLvUpDesc:SetActive(true)
    else
      self.v_uiobjects.TalentLvUpDesc:SetActive(false)
    end
  end
  local grade = self.v_ability_upgrade_cfg.Grade
  self.v_uicompents.TalentName_txt.text = self.v_ability_upgrade_cfg.Name
  local color_str = grade >= 2 and "FFD07B" or "FFFFFF"
  Util.set_color(self.v_uicompents.TalentName_txt, color_str)
end

function ui:on_click_toggle()
  self.v_parent_ui:on_select_drop_ability(self.v_ability_index, self.v_ability_id)
end

function ui:on_select(ability_id)
  self.v_uiobjects.Select:SetActive(self.v_ability_id == ability_id)
end

return ui
