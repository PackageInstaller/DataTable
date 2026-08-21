local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ENEMYINFOTIPS_ENEMY_ITEM = "ENEMYINFOTIPS_ENEMY_ITEM"
local ENEMYINFOTIPS_ENEMY_ITEM_ELEMENT = "ENEMYINFOTIPS_ENEMY_ITEM_ELEMENT"
local ENEMYINFOTIPS_ENEMY_ELEMENT_WEAKNESS = "ENEMYINFOTIPS_ENEMY_ELEMENT_WEAKNESS"
local ENEMYINFOTIPS_ENEMY_FEATURES = "ENEMYINFOTIPS_ENEMY_FEATURES"
local ENEMYINFOTIPS_ENEMY_SKILLTEM = "ENEMYINFOTIPS_ENEMY_SKILLTEM"
local UIArchivePath = "UIArchive/%s"
local DETAILTYPE = {SKILL = 1, BACKGROUND = 2}
local DETAILTYPE_DESC = {
  "技能详情",
  "信息档案"
}

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:on_click_close_btn()
  end)
  self:set_button("BtnChangeInfo", function()
    self:on_click_changeinfo_btn()
  end)
  self:register_exist_auto_template(ENEMYINFOTIPS_ENEMY_ITEM, self.v_uiobjects.EnemyTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(ENEMYINFOTIPS_ENEMY_ITEM_ELEMENT, self.v_uiobjects.EnemyTem:FindChild("EleWeak/EleIcon_"))
  self:register_exist_auto_template(ENEMYINFOTIPS_ENEMY_ELEMENT_WEAKNESS, self.v_uiobjects.WeaknessTem, self.v_uiobjects.WeaknessList)
  self:register_exist_auto_template(ENEMYINFOTIPS_ENEMY_FEATURES, self.v_uiobjects.FeaturesTem, self.v_uiobjects.FeaturesList)
  self:register_exist_auto_template(ENEMYINFOTIPS_ENEMY_SKILLTEM, self.v_uiobjects.SkillTem, self.v_uiobjects.SkillContent)
  self.v_toggle_list = {}
end

function ui:ui_on_show(selectIdx, enemyIDList)
  self.v_selectIdx = selectIdx
  self.v_enemyIDList = enemyIDList
  self.v_detail_type = DETAILTYPE.SKILL
  self:update_enemyitem_list()
  self:on_click_enemylist_item(self.v_selectIdx, true, true)
end

function ui:ui_on_hide()
end

function ui:update_enemyitem_list()
  self:give_back_auto_cache(ENEMYINFOTIPS_ENEMY_ITEM)
  self:give_back_auto_cache(ENEMYINFOTIPS_ENEMY_ITEM_ELEMENT)
  for index, enemyID in ipairs(self.v_enemyIDList) do
    local obj = self:get_auto_cache(ENEMYINFOTIPS_ENEMY_ITEM)
    local enemy_cfg = ShareRes.get_enemy_cfg(enemyID)
    if not enemy_cfg then
      Log.Error("怪物配置获取失败：", enemyID)
      return
    end
    local headIcon = string.format(UIArchivePath, enemy_cfg.HeadIcon)
    local enemy_image = Util.get_image("EnemyIcon/EnemyIcon_", obj)
    ResMgr:load_set_icon(enemy_image, headIcon, nil, true)
    local enemy_image_rect = Util.get_rect_transform("EnemyIcon/EnemyIcon_", obj)
    if enemy_cfg.IconOffset ~= nil then
      enemy_image_rect:SetAnchoredPositionA(enemy_cfg.IconOffset[1], enemy_cfg.IconOffset[2] - 40)
    else
      enemy_image_rect:SetAnchoredPositionA(0, -40)
    end
    local enemy_character_cfg = ShareRes.get_character_cfg(enemyID)
    if enemy_character_cfg.ElementWeakList then
      for index, elementID in ipairs(enemy_character_cfg.ElementWeakList) do
        local element_obj = self:get_auto_cache(ENEMYINFOTIPS_ENEMY_ITEM_ELEMENT)
        local element_cfg = ShareRes.get_element_cfg(elementID)
        local elementIconPath = element_cfg.ElementIconPath
        local image_com = Util.get_image(nil, element_obj)
        ResMgr:load_set_icon(image_com, elementIconPath)
        local eleWeak = self:get_child_gameobj("EleWeak", obj)
        element_obj.transform:SetParent(eleWeak.transform, false)
      end
    end
    local toggle_component = Util.get_toggle(nil, obj)
    self.v_toggle_list[index] = toggle_component
    self:set_toggle_listener(toggle_component, function(is_on)
      self:on_click_enemylist_item(index, is_on)
    end)
  end
end

function ui:update_enemyitem_desc()
  self:give_back_auto_cache(ENEMYINFOTIPS_ENEMY_ELEMENT_WEAKNESS)
  self:give_back_auto_cache(ENEMYINFOTIPS_ENEMY_FEATURES)
  local enemy_cfg = ShareRes.get_enemy_cfg(self.v_enemyIDList[self.v_selectIdx])
  local headIcon = string.format(UIArchivePath, enemy_cfg.HeadIcon)
  local enemy_image = Util.get_image(nil, self.v_uiobjects.EnemyIcon)
  ResMgr:load_set_icon(enemy_image, headIcon, nil, true)
  local enemyname_text = Util.get_text(nil, self.v_uiobjects.EnemyName)
  enemyname_text.text = enemy_cfg.Name
  local enemy_character_cfg = ShareRes.get_character_cfg(self.v_enemyIDList[self.v_selectIdx])
  if enemy_character_cfg.ElementWeakList then
    for _, elementID in ipairs(enemy_character_cfg.ElementWeakList) do
      local element_obj = self:get_auto_cache(ENEMYINFOTIPS_ENEMY_ELEMENT_WEAKNESS)
      local element_cfg = ShareRes.get_element_cfg(elementID)
      local elementIconPath = element_cfg.ElementIconPath
      local image_com = Util.get_image("WeaknessIcon", element_obj)
      ResMgr:load_set_icon(image_com, elementIconPath)
    end
  end
  for index, featuresID in ipairs(enemy_cfg.features) do
    local features_item = self:get_auto_cache(ENEMYINFOTIPS_ENEMY_FEATURES)
    local features_cfg = ShareRes.get_enemy_feature_cfg(featuresID)
    local features_text = Util.get_text("Features", features_item)
    local bg = Util.get_image("Bg", features_item)
    features_text.text = features_cfg.Name
  end
  self:update_detail_content()
end

function ui:update_detail_content()
  self:give_back_auto_cache(ENEMYINFOTIPS_ENEMY_SKILLTEM)
  local title_text = Util.get_text(nil, self.v_uiobjects.InfoTitle)
  title_text.text = DETAILTYPE_DESC[self.v_detail_type]
  self.v_uiobjects.SkillDesc:SetActive(self.v_detail_type == DETAILTYPE.BACKGROUND)
  self.v_uicompents.SkillContent_rect:SetAnchoredPositionA(0, 0)
  if self.v_detail_type == DETAILTYPE.SKILL then
    local enemy_cfg = ShareRes.get_enemy_cfg(self.v_enemyIDList[self.v_selectIdx])
    for _, skill_id in ipairs(enemy_cfg.skill) do
      local obj = self:get_auto_cache(ENEMYINFOTIPS_ENEMY_SKILLTEM)
      local skill_cfg = ShareRes.get_enemy_skill_cfg(skill_id)
      local skill_name_text = Util.get_text("SkillName", obj)
      local skill_desc_text = Util.get_text("SkillDesc", obj)
      skill_name_text.text = skill_cfg.Name
      skill_desc_text.text = skill_cfg.Desc
    end
  elseif self.v_detail_type == DETAILTYPE.BACKGROUND then
    local skilldesc_text = Util.get_text("SkillDesc", self.v_uiobjects.SkillDesc)
    local enemy_cfg = ShareRes.get_enemy_cfg(self.v_enemyIDList[self.v_selectIdx])
    skilldesc_text.text = enemy_cfg.Desc
  end
end

function ui:on_click_close_btn()
  self:ui_hide()
end

function ui:on_click_changeinfo_btn()
  self.v_detail_type = 2 == self.v_detail_type and 1 or self.v_detail_type + 1
  self:update_detail_content()
end

function ui:on_click_enemylist_item(index, is_on, forceRefresh)
  if not is_on or index == self.v_selectIdx and not forceRefresh then
    return
  end
  self.v_selectIdx = index
  self.v_detail_type = DETAILTYPE.SKILL
  self.v_toggle_list[self.v_selectIdx].isOn = true
  self:update_enemyitem_desc()
end

return ui
