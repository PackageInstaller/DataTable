local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ENEMY_SKILL_ITEM_KEY = "ENEMY_SKILL_ITEM_KEY"
local ToggleTab = require("ui.widget.widget_toggle_tab")
local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local CommonDefind = require("cs_share.common_define")
local MODEL_PARAM = MODEL_CONFIG.UI_ENEMY_MODEL_PARAM
local UIArchivePath = "UIArchive/%s"
local SHOWPAGE = {SKILL = 1, DATE = 2}
local UnityShader = UnityEngine.Shader

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnAssess", function()
    if ArchiveMgr.v_enemy_info_list[self.v_enemy_id].scoretime >= Date.get_time_stamp(0, 5) then
      Util.show_message_tip(2332)
      return
    end
    self.v_is_show_assess_pnl = not self.v_is_show_assess_pnl
    self:update_assess_show()
  end)
  self:set_button("BtnSure", function()
    self.v_is_show_assess_pnl = not self.v_is_show_assess_pnl
    self:update_assess_show()
    local MonsterScore = {}
    MonsterScore.fraction = self.v_set_score
    MonsterScore.difficulty = self.v_set_difficult
    ArchiveMgr:req_set_monster_score(self.v_enemy_id, MonsterScore)
  end)
  self:set_button("PupUpCloseBtn", function()
    self.v_is_show_assess_pnl = not self.v_is_show_assess_pnl
    self:update_assess_show()
  end)
  self:set_button("PupUpCloseBg", function()
    self.v_is_show_assess_pnl = not self.v_is_show_assess_pnl
    self:update_assess_show()
  end)
  self.v_select_page = SHOWPAGE.DATE
  self.v_enemy_id = nil
  self.v_features_list = {}
  self.v_weakness_list = {}
  self.v_score_list = {}
  self.v_difficulty_list = {}
  self.v_score_list_myself = {}
  self.v_difficulty_list_myself = {}
  for index = 1, 5 do
    table.insert(self.v_score_list, self.v_uiobjects["AllScoreLightup" .. index])
    table.insert(self.v_difficulty_list, self.v_uiobjects["AllDicLightup" .. index])
    table.insert(self.v_score_list_myself, self.v_uiobjects["ScoreLightup" .. index])
    table.insert(self.v_difficulty_list_myself, self.v_uiobjects["DicLightup" .. index])
    self:set_button("ScoreStar" .. index, function()
      self:click_score_btn(index)
    end)
    self:set_button("DicStar" .. index, function()
      self:click_difficult_btn(index)
    end)
  end
  local FeaturesList_go = self.v_uiobjects.FeaturesList.transform
  table.insert(self.v_features_list, FeaturesList_go:GetChild(0).gameObject)
  local WeaknessList_go = self.v_uiobjects.WeaknessList.transform
  table.insert(self.v_weakness_list, WeaknessList_go:GetChild(0).gameObject)
  self:register_exist_auto_template(ENEMY_SKILL_ITEM_KEY, self.v_uiobjects.SkillItem, self.v_uiobjects.SkillList)
end

function ui:ui_on_show(enemy_id)
  self.v_enemy_id = enemy_id
  self.v_is_show_assess_pnl = false
  if not self.v_enemy_id then
    return
  end
  self.v_enemy_info_list = ArchiveMgr.v_enemy_info_list
  self.v_gesture_type = ArchiveMgr.v_enemy_info_list[enemy_id].gesture_type
  self:init_tog()
  self:update_pnl()
end

function ui:init_tog()
  self.v_select_toggle = {}
  table.insert(self.v_select_toggle, self.v_uicompents.SkillTog_tog)
  table.insert(self.v_select_toggle, self.v_uicompents.DateTog_tog)
  self.v_select_toggle_tab = ToggleTab:new(self)
  self.v_gestrue_tog = {}
  table.insert(self.v_gestrue_tog, self.v_uicompents.ThumbsDown_tog)
  table.insert(self.v_gestrue_tog, self.v_uicompents.ThumbsUp_tog)
  self:init_click_list()
  self.v_gestrue_tog_tab = ToggleTab:new(self)
  for index, toggle in ipairs(self.v_gestrue_tog) do
    self.v_gestrue_tog_tab:_set_toggle(toggle, function()
      self:click_gestrue_toggle(index)
    end)
  end
end

function ui:click_select_toggle(index)
  self.v_select_page = index
  self.v_uiobjects.Skill:SetActive(index == SHOWPAGE.SKILL)
  self.v_uiobjects.Desc:SetActive(index == SHOWPAGE.DATE)
end

function ui:click_gestrue_toggle(index)
  if index == self.v_gesture_type then
    self.v_gesture_type = CommonDefind.ARCH_MONSTER_GESTURE_TYPE.INIT
  else
    self.v_gesture_type = index
  end
  ArchiveMgr:req_set_monster_true(self.v_enemy_id, self.v_gesture_type, function()
    self:update_Thumbs_show()
  end)
end

function ui:init_click_list()
  if self.v_gestrue_tog then
    for index, tog in pairs(self.v_gestrue_tog) do
      if index == self.v_gesture_type then
        tog.isOn = true
      end
    end
  end
end

function ui:reset_tog_list()
  self.v_gestrue_tog_tab:dispose()
  if self.v_gestrue_tog then
    for _, tog in pairs(self.v_gestrue_tog) do
      tog.onValueChanged:RemoveAllListeners()
      tog.isOn = false
    end
  end
end

function ui:click_score_btn(num)
  self.v_set_score = num
  for index, obj in ipairs(self.v_score_list_myself) do
    obj:SetActive(index <= self.v_set_score)
  end
end

function ui:click_difficult_btn(num)
  self.v_set_difficult = num
  for index, obj in ipairs(self.v_difficulty_list_myself) do
    obj:SetActive(index <= self.v_set_difficult)
  end
end

function ui:update_pnl()
  self.v_uiobjects.Skill:SetActive(self.v_select_page == SHOWPAGE.SKILL)
  self.v_uiobjects.Desc:SetActive(self.v_select_page == SHOWPAGE.DATE)
  self:update_enemy_info()
  self:update_enemy_model_show()
  self:update_assess_show()
  self:update_star_show()
  self:update_Thumbs_show()
end

function ui:update_enemy_info()
  local enemy_cfg = ShareRes.get_enemy_cfg(self.v_enemy_id)
  local enemy_level_cfg = ShareRes.get_enemy_level_cfg(enemy_cfg.Level)
  local enemy_character_cfg = ShareRes.get_character_cfg(self.v_enemy_id)
  local color_str = enemy_level_cfg.BgColor
  local color = Util.get_unity_color_by_hex(tonumber(color_str, 16))
  self.v_uicompents.EnemyName_txt.text = enemy_cfg.Name
  self.v_uicompents.Designer_txt.text = enemy_cfg.designer
  self.v_uicompents.Level_txt.text = enemy_level_cfg.Name
  color.a = 1
  self.v_uicompents.LevelBg_img.color = color
  self.v_uicompents.EnemyDesc_txt.text = enemy_cfg.Desc
  self:update_enemy_features(enemy_cfg.features)
  self:update_enemy_weakness(enemy_character_cfg.ElementWeakList)
  local skill_list = enemy_cfg.skill
  self.v_uiobjects.SkillTog:SetActive(skill_list)
  self.v_uiobjects.NotInfor:SetActive(not skill_list)
  if not skill_list then
    self.v_select_toggle_tab:init_by_toggles(self.v_select_toggle, function(cur_select)
      self:click_select_toggle(cur_select)
    end, 2, false)
    self:click_select_toggle(2)
    return
  end
  self.v_select_toggle_tab:init_by_toggles(self.v_select_toggle, function(cur_select)
    self:click_select_toggle(cur_select)
  end, 1, false)
  self:click_select_toggle(1)
  for _, skill_id in ipairs(skill_list) do
    local item = self:get_auto_cache(ENEMY_SKILL_ITEM_KEY)
    self:set_skill_item_data(item, skill_id)
  end
end

function ui:set_skill_item_data(item, skilll_id)
  local skill_cfg = ShareRes.get_enemy_skill_cfg(skilll_id)
  local skill_name = Util.get_text("SkillName", Util.get_child_gameobj("Bg", item))
  local skill_desc = Util.get_text("SkillDesc", item)
  skill_name.text = skill_cfg.Name
  skill_desc.text = skill_cfg.Desc
end

function ui:update_star_show()
  local data = ArchiveMgr.v_all_server_sorce_info_list[self.v_enemy_id]
  local sorce = 3
  local difficulty = 3
  if data and data.score_player and 0 ~= data.score_player and data.fraction then
    sorce = math.floor(data.fraction / data.score_player + 0.5)
    difficulty = math.floor(data.difficulty / data.score_player + 0.5)
  end
  for index, obj in ipairs(self.v_score_list) do
    obj:SetActive(index <= sorce)
  end
  for index, obj in ipairs(self.v_difficulty_list) do
    obj:SetActive(index <= difficulty)
  end
end

function ui:update_Thumbs_show()
  local all_server_data = ArchiveMgr.v_all_server_sorce_info_list[self.v_enemy_id]
  local self_data = ArchiveMgr.v_enemy_info_list[self.v_enemy_id]
  local disagree_playernum = 0
  local fabulous_playernum = 0
  local init_state = CommonDefind.ARCH_MONSTER_GESTURE_TYPE.INIT
  if all_server_data then
    disagree_playernum = all_server_data.disagree_playernum and all_server_data.disagree_playernum or 0
    fabulous_playernum = all_server_data.fabulous_playernum and all_server_data.fabulous_playernum or 0
  end
  init_state = self_data and self_data.resettime_gesture and self_data.resettime_gesture or init_state
  if init_state ~= self.v_gesture_type then
    if self.v_gesture_type == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.INIT then
      if init_state == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.DISAGREE then
        disagree_playernum = disagree_playernum - 1
      end
      if init_state == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.FABULOUS then
        fabulous_playernum = fabulous_playernum - 1
      end
    elseif self.v_gesture_type == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.DISAGREE then
      disagree_playernum = disagree_playernum + 1
      if init_state == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.FABULOUS then
        fabulous_playernum = fabulous_playernum - 1
      end
    elseif self.v_gesture_type == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.FABULOUS then
      fabulous_playernum = fabulous_playernum + 1
      if init_state == CommonDefind.ARCH_MONSTER_GESTURE_TYPE.DISAGREE then
        disagree_playernum = disagree_playernum - 1
      end
    end
  end
  self.v_uicompents.DownNum_txt.text = Util.conversion_unit(disagree_playernum)
  self.v_uicompents.UpNum_txt.text = Util.conversion_unit(fabulous_playernum)
end

function ui:update_enemy_model_show()
  local enemy_cfg = ShareRes.get_enemy_cfg(self.v_enemy_id)
  local character_cfg = ShareRes.get_character_cfg(self.v_enemy_id)
  local model_id = character_cfg.ModelId
  if not self.v_model_view then
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME)
    local params = {
      model_id = model_id,
      npc_id = self.v_enemy_id,
      is_reload = true,
      hide_weapon = true
    }
    self.v_model_idx = self.v_model_view:load_npc(params)
    local camera_param = {}
    local content_param = {}
    camera_param.pos_x = enemy_cfg.Position[1]
    camera_param.pos_y = enemy_cfg.Position[2]
    camera_param.pos_z = enemy_cfg.Position[3]
    camera_param.rot_x = 0
    camera_param.rot_y = 0
    camera_param.rot_z = 0
    content_param.pos_x = 0
    content_param.pos_y = 0
    content_param.pos_z = 0
    content_param.rot_x = enemy_cfg.Rotation[1]
    content_param.rot_y = enemy_cfg.Rotation[2]
    content_param.rot_z = enemy_cfg.Rotation[3]
    self.v_model_view:set_camera_param(camera_param)
    self.v_model_view:set_content_pos(content_param)
  end
  self.v_uiobjects.FullScreenBackground:SetActive(false)
end

function ui:update_assess_show()
  self.v_uiobjects.PupUp:SetActive(self.v_is_show_assess_pnl)
  if not self.v_is_show_assess_pnl then
    return
  end
  self.v_set_difficult = 3
  self.v_set_score = 3
  local enemy_cfg = ShareRes.get_enemy_cfg(self.v_enemy_id)
  self.v_uicompents.EnemyName2_txt.text = enemy_cfg.Name
  local data = ArchiveMgr.v_all_server_sorce_info_list[self.v_enemy_id]
  local score_player = 0
  if data and data.score_player then
    score_player = data.score_player
  end
  self.v_uicompents.PeopleNum_txt.text = Util.conversion_unit(score_player)
  local icon_path = string.format(UIArchivePath, enemy_cfg.HeadIcon)
  ResMgr:load_set_icon(self.v_uicompents.EnemyIcon_img, icon_path, nil, true)
  for index, obj in ipairs(self.v_score_list_myself) do
    obj:SetActive(index <= self.v_set_score)
  end
  for index, obj in ipairs(self.v_difficulty_list_myself) do
    obj:SetActive(index <= self.v_set_difficult)
  end
end

function ui:update_enemy_features(features_list)
  local parent = self.v_uiobjects.FeaturesList:GetParent()
  local rect = Util.get_rect_transform(nil, parent)
  local rect_hight = 130.0 + math.floor((#features_list - 1) / 2) * 60
  rect:SetSizeDeltaHeightA(rect_hight)
  self:hide_all_features()
  while #features_list > #self.v_features_list do
    local FeaturesList_go = self.v_uiobjects.FeaturesList.transform
    local item = UnityGameObject.Instantiate(self.v_features_list[1], FeaturesList_go)
    table.insert(self.v_features_list, item)
  end
  for index, features_id in ipairs(features_list) do
    local features_cfg = ShareRes.get_enemy_feature_cfg(features_id)
    local features_item = self.v_features_list[index]
    features_item:SetActive(true)
    local features_name = Util.get_text("Features", features_item)
    local bg = Util.get_image("Bg", features_item)
    features_name.text = features_cfg.Name
  end
  for index = #features_list + 1, #self.v_features_list do
    self.v_features_list[index]:SetActive(false)
  end
end

function ui:hide_all_features()
  for _, obj in ipairs(self.v_features_list) do
    obj:SetActive(false)
  end
end

function ui:update_enemy_weakness(weakness_list)
  self:hide_all_weakness()
  if not weakness_list then
    return
  end
  while #weakness_list > #self.v_weakness_list do
    local weaknessList_go = self.v_uiobjects.WeaknessList.transform
    local item = UnityGameObject.Instantiate(self.v_weakness_list[1], weaknessList_go)
    table.insert(self.v_weakness_list, item)
  end
  for index, weakness_id in ipairs(weakness_list) do
    local weakness_cfg = ShareRes.get_element_cfg(weakness_id)
    local weakness_item = self.v_weakness_list[index]
    weakness_item:SetActive(true)
    local image_com = Util.get_image("WeaknessIcon", weakness_item)
    local image_path = weakness_cfg.ElementIconPath
    ResMgr:load_set_icon(image_com, image_path)
  end
end

function ui:hide_all_weakness()
  for _, obj in ipairs(self.v_weakness_list) do
    obj:SetActive(false)
  end
end

function ui:ui_on_hide()
  self:reset_tog_list()
  self.v_select_toggle = nil
  self:release_model()
end

function ui:release_model()
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
end

local CSShadow = CS.Game.Shadow

function ui:ui_on_update()
  if self.v_model_view then
    CSShadow.RenderShadowMap(self.v_model_view:get_model_root(), true, 1, true, 3)
  end
end

return ui
