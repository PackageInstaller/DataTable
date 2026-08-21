local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local QUALITY_PATH = Config.ENTRY_QUALITY_PATH
local TASK_CONDITION_DESC_KEY = "TASK_CONDITION_DESC_KEY"
local CONDITION_DESC_KEY = "CONDITION_DESC_KEY"
local STAGE_BUFF_ITEM = "STAGE_BUFF_ITEM"
local STAGE_VIEW_COMBOTEM = "STAGE_VIEW_COMBOTEM"
local STAGE_VIEW_COMBONOIMAGE = "STAGE_VIEW_COMBONOIMAGE"
local STAGE_VIEW_SKILLTEM = "STAGE_VIEW_SKILLTEM"
local COMBO_TEM_CLASS = require("uimodule.battle_bag.combo_item")
local CommonDefine = require("cs_share.common_define")
local _tinsert = table.insert
local _sformat = string.format
local INIT_BUFF_TIPS_POS_X, INIT_BUFF_TIPS_POS_Y
local INIT_BUFF_TIPS_POS_OFFSET = 80

function ui:ui_finish_load()
  local buff_tips_pos = self.v_uicompents.EndlessBufftips_rect.anchoredPosition
  INIT_BUFF_TIPS_POS_X = buff_tips_pos.x
  INIT_BUFF_TIPS_POS_Y = buff_tips_pos.y
  self:set_button("FullBtn", function()
    self.v_uiobjects.EndlessBufftips:SetActive(false)
    self.v_uiobjects.FullBtn:SetActive(false)
  end)
  self:set_button("BtnBoxGuide", function()
    self:on_btn_box_guide_click()
  end)
  self:register_exist_auto_template(CONDITION_DESC_KEY, self.v_uiobjects.StarTem, self.v_uiobjects.StarCondition)
  self:register_exist_auto_template(TASK_CONDITION_DESC_KEY, self.v_uiobjects.TaskTem, self.v_uiobjects.TaskCondition)
  self:register_exist_auto_template(STAGE_BUFF_ITEM, self.v_uiobjects.EndlessBuffTem, self.v_uiobjects.EndlessBuffTem.transform.parent.gameObject)
  self:register_exist_auto_template(STAGE_VIEW_COMBOTEM, self.v_uiobjects.ComboTem, self.v_uiobjects.TeachObj)
  self:register_exist_auto_template(STAGE_VIEW_COMBONOIMAGE, self.v_uiobjects.ComboNoImage, self.v_uiobjects.TeachObj)
  local skill_tem = Util.get_child_gameobj("SkillContent_/SkillTem_", self.v_uiobjects.ComboTem)
  self:register_exist_auto_template(STAGE_VIEW_SKILLTEM, skill_tem)
  self.v_combo_luaobj_list = {}
end

function ui:ui_on_show()
  self:clear_wrap()
  self:refresh_stage_info()
  self:refresh_stage_ui()
  self:refresh_box_guide_state(true)
end

function ui:on_btn_box_guide_click()
  local is_open_box_guide = BattleSettingMgr:load_treasure_chest_guide_state()
  is_open_box_guide = not is_open_box_guide
  BattleSettingMgr:save_treasure_chest_guide_state(is_open_box_guide)
  self:refresh_box_guide_state(false)
  self:call_scene_logic(is_open_box_guide)
end

function ui:refresh_box_guide_state(is_refresh_count)
  local is_show_box_guide = false
  local tower_progress = TowerMgr:get_tower_progress()
  local node_cfg
  if tower_progress and tower_progress.node_id and tower_progress.challenge_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    node_cfg = ShareRes.get_chapter_node_cfg(tower_progress.node_id)
  end
  if ChapterMgr:check_episode_complete(tower_progress.episode_id) and node_cfg and node_cfg.BoxGroupId and 0 ~= node_cfg.BoxGroupId then
    is_show_box_guide = true
  end
  self.v_uiobjects.BtnBoxGuide:SetActive(is_show_box_guide)
  if not is_show_box_guide then
    return
  end
  local is_open_box_guide = BattleSettingMgr:load_treasure_chest_guide_state()
  self.v_uiobjects.BoxGuideClose:SetActive(not is_open_box_guide)
  self.v_uiobjects.BoxGuideOpen:SetActive(is_open_box_guide)
  if is_refresh_count then
    self:refresh_box_guide_count(node_cfg.BoxGroupId)
  end
end

function ui:call_scene_logic(is_open_box_guide)
  BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_TREASURE_CHEST_GUIDE_STATE_UPDATE, is_open_box_guide)
end

function ui:refresh_box_guide_count(box_group_id)
  local finish_count, max_count = TreasureChestMgr:get_scene_treasure_chest_count(box_group_id)
  self.v_uicompents.BoxAll_txt.text = max_count
  self.v_uicompents.BoxNow_txt.text = finish_count
end

function ui:ui_on_hide()
  self.v_show_data = nil
end

function ui:ui_on_destroy()
  self.v_combo_luaobj_list = nil
end

function ui:refresh_stage_info()
  local stage_cfg = TowerMgr:get_stage_info()
  local point_id = stage_cfg.Id
  local tower_type = TowerMgr:get_tower_type()
  local node_id = TowerMgr:get_cur_node_id()
  local fight_type = TowerMgr:get_fight_type()
  self.v_show_data = {}
  self.v_show_data.tower_type = tower_type
  self.v_show_data.stage_title = stage_cfg.PointName
  self.v_show_data.stage_target = stage_cfg.PointTargetDesc
  self.v_show_data.point_id = point_id
  self.v_show_data.node_id = node_id
  self.v_show_data.fight_type = fight_type
  self.v_show_data.stage_cond_desc = self:get_starrating_data(point_id)
  self.v_show_data.battle_task_data = self:get_battle_task_data()
  if self.v_show_data.fight_type == CommonDefine.CHALLENGE_TYPE.CHAPTER or self.v_show_data.fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    local param = TowerMgr:get_cur_fight_info_param()
    local cfg = ShareRes.get_chapter_cfg(param)
    if cfg then
      self.v_show_data.chapter_mode = cfg.ChapterMode
    end
  end
  if CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH == tower_type then
    self.v_show_data.teach_data = self:get_teach_data(point_id)
  elseif CommonDefine.CHALLENGE_TYPE.INFINITE == tower_type then
    self.v_show_data.enless_data = self:get_endless_data(point_id)
  elseif self:check_weekly_fight(tower_type) then
    self.v_show_data.week_acty_data = self:get_week_acty_data(point_id)
  end
end

function ui:get_starrating_data(point_id)
  local condition_list = ShareRes.get_point_star_condition(point_id) or {}
  local condition_desc = {}
  for _, id in pairs(condition_list) do
    if not id or id <= 0 then
    else
      local cfg = ShareRes.get_point_star_condition_cfg(id)
      local temp = cfg.ConditionDesc
      local arg = cfg.Arg[1]
      if cfg.ConditionType == Config.Condition_Type.HealthMoreThan then
        local percent_health = arg / 100
        percent_health = math.max(percent_health, 1)
        arg = string.format("%d", percent_health) .. "%"
      end
      temp = Util.format_str(temp, arg)
      _tinsert(condition_desc, temp)
    end
  end
  return condition_desc
end

function ui:get_battle_task_data()
  local task_map = BattleTaskMgr:get_node_task_map()
  local battle_task_data = {}
  for task_id in pairs(task_map) do
    local task_item = BattleTaskMgr:get_task(task_id)
    if task_item then
      local task_cfg = task_item:get_task_cfg()
      local data = {
        id = task_cfg.Id,
        desc = task_cfg.Name,
        completed = task_item:get_is_complete()
      }
      battle_task_data[#battle_task_data + 1] = data
    end
  end
  table.sort(battle_task_data, function(a, b)
    if a.completed ~= b.completed then
      return not a.completed
    end
    if a.id ~= b.id then
      return a.id > b.id
    end
    return false
  end)
  return battle_task_data
end

function ui:get_teach_data(point_id)
  local teach_stage_cfg = ShareRes.get_buddy_teach_cfg_by_point_id(point_id)
  local cur_floor = TowerMgr:get_cur_tower_floor()
  local buddyt_teach_floor_cfg = ShareRes.get_buddy_teach_floor_cfg_by_point_id(point_id, cur_floor)
  local tips_id = teach_stage_cfg.Tips[cur_floor]
  if not tips_id then
    Log.Error("get tips id failed point_id=", point_id)
  end
  local tips_cfg = ShareRes.create("activity.buddy_skill_tips", tips_id)
  if nil == tips_cfg then
    Log.Error("lack buddy_skill_tips cfg, ", tips_id)
  end
  local temp_data = {}
  temp_data.Detail_Name = tips_cfg.Detail_Name
  temp_data.Detail_Img = tips_cfg.Detail_Img
  temp_data.Detail_Desc = tips_cfg.Detail_Desc
  temp_data.Buddy_Id = teach_stage_cfg.BuddyID
  temp_data.Combo_Id = buddyt_teach_floor_cfg.ComboId
  return temp_data
end

function ui:get_endless_data(point_id)
  local res = {}
  local progress = TowerMgr:get_tower_progress()
  local infinite_id = ShareRes.get_infinite_id_by_point_id(point_id)
  res.diff_val = progress and progress.infinite_progress.coeff or 0
  res.cur_floor, res.max_floor = TowerMgr:get_cur_tower_floor()
  res.current_score = progress and progress.infinite_progress.score or 0
  local data = ChapterMgr:get_inf_chapter_data(infinite_id)
  res.max_score = data and data.history_max_score or 0
  local record_map = ChapterEndlessMgr:get_infinite_select_entry(infinite_id)
  local entry_map = {}
  local entry_cfg = {}
  if record_map then
    entry_map = UtilTable.copy_table(record_map)
  end
  for key, entry_id in pairs(entry_map) do
    local cfg = ShareRes.get_infinite_entry_cfg(entry_id)
    entry_cfg[#entry_cfg + 1] = cfg
  end
  res.entry_cfg = entry_cfg
  return res
end

function ui:get_week_acty_data(point_id)
  local cfg = ShareRes.get_weekly_hundle_cfg(point_id)
  if cfg then
    return cfg.BuffDesc
  else
    return {}
  end
end

function ui:refresh_stage_ui()
  if not self.v_show_data.tower_type then
    return
  end
  self.v_uiobjects.EndlessBufftips:SetActive(false)
  self.v_uiobjects.FullBtn:SetActive(false)
  self.v_uicompents.StagePurpose_txt.text = self.v_show_data.stage_target
  local stage_name_text
  if self.v_show_data.node_id and self.v_show_data.chapter_mode and 1 == self.v_show_data.chapter_mode then
    local node_cfg = ShareRes.get_chapter_node_cfg(self.v_show_data.node_id)
    stage_name_text = node_cfg.TagNumName .. " " .. node_cfg.MainName
  elseif 1 == self.v_show_data.fight_type and self.v_show_data.chapter_mode and 3 == self.v_show_data.chapter_mode then
    local point_cfg = ShareRes.get_chapter_point_cfg(self.v_show_data.point_id)
    stage_name_text = point_cfg.SerialNum .. " " .. self.v_show_data.stage_title
  else
    stage_name_text = self.v_show_data.stage_title
  end
  self.v_uicompents.StageName_txt.text = stage_name_text
  self:give_back_auto_cache(CONDITION_DESC_KEY)
  self:give_back_auto_cache(TASK_CONDITION_DESC_KEY)
  self:give_back_auto_cache(STAGE_BUFF_ITEM)
  self:give_back_auto_cache(STAGE_VIEW_SKILLTEM)
  self:give_back_auto_cache(STAGE_VIEW_COMBOTEM)
  self:give_back_auto_cache(STAGE_VIEW_COMBONOIMAGE)
  for _, desc in pairs(self.v_show_data.stage_cond_desc) do
    local con_desc = self:get_auto_cache(CONDITION_DESC_KEY)
    local con_desc_text = Util.get_text("ConditionDesc", con_desc)
    con_desc_text.text = desc
  end
  local has_cond_data = self.v_show_data.battle_task_data ~= nil
  self.v_uiobjects.TaskCondition:SetActive(has_cond_data)
  local uncomp_color = "806F58"
  local comp_color = "959490"
  if has_cond_data then
    for _, data in pairs(self.v_show_data.battle_task_data) do
      local con_desc = self:get_auto_cache(TASK_CONDITION_DESC_KEY)
      local con_desc_text = self:get_text("ConditionDesc", con_desc)
      con_desc_text.text = data.desc
      local img = self:get_image(nil, con_desc)
      Util.set_color(img, data.completed and comp_color or uncomp_color)
      local arrow = self:get_child_gameobj("Arrow", con_desc)
      arrow:SetActive(not data.completed)
      local check = self:get_child_gameobj("Check", con_desc)
      check:SetActive(data.completed)
    end
  end
  local tower_type = self.v_show_data.tower_type
  self.v_uiobjects.TeachObj:SetActive(tower_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH and not self.v_show_data.teach_data.Buddy_Id)
  self.v_uiobjects.EndlessObj:SetActive(tower_type == CommonDefine.CHALLENGE_TYPE.INFINITE)
  self.v_uiobjects.WeekAct1Obj:SetActive(self:check_weekly_fight(tower_type))
  local use_data
  if tower_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    use_data = self.v_show_data.teach_data
    if use_data.Detail_Img and use_data.Detail_Img ~= "" then
      ResMgr:load_set_icon(self.v_uicompents.TeachImage_img, _sformat("UIHeroTeaching/%s", use_data.Detail_Img), nil, true)
    else
      self.v_uiobjects.TeachImageBg:SetActive(false)
    end
    self.v_uicompents.TeachImage_img:SetNativeSize()
    self.v_uicompents.SKillDesc_txt.text = use_data.Detail_Desc
    for _, combo_id in ipairs(use_data.Combo_Id) do
      local combo_cfg = ShareRes.get_buddy_combo_cfg(combo_id)
      local item = combo_cfg.ComboIcon[1] and self:get_auto_cache(STAGE_VIEW_COMBOTEM) or self:get_auto_cache(STAGE_VIEW_COMBONOIMAGE)
      local skill_item_list = {}
      for i = 1, #combo_cfg.ComboIcon do
        local skill_item_obj = self:get_auto_cache(STAGE_VIEW_SKILLTEM)
        table.insert(skill_item_list, skill_item_obj)
      end
      local lua_obj = COMBO_TEM_CLASS:ui_wrap_ex(self, item, true)
      table.insert(self.v_combo_luaobj_list, lua_obj)
      lua_obj:set_data(combo_id, skill_item_list)
    end
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.INFINITE then
    use_data = self.v_show_data.enless_data
    self.v_uicompents.Floor_txt.text = _sformat("%d/%d", use_data.cur_floor, use_data.max_floor)
    self.v_uicompents.Difficulty_txt.text = use_data.diff_val
    self.v_uicompents.ScoreNow_txt.text = use_data.current_score
    self.v_uicompents.ScoreReward_txt.text = use_data.max_score
    for idx, entry_cfg in ipairs(use_data.entry_cfg) do
      local item = self:get_auto_cache(STAGE_BUFF_ITEM)
      local icon = Util.get_image("BuffIcon", item)
      local quality_icon = Util.get_image("BuffQuality", item)
      local btn = Util.get_button(nil, item)
      ResMgr:load_set_icon(quality_icon, QUALITY_PATH[entry_cfg.Quality])
      ResMgr:load_set_icon(icon, entry_cfg.Icon)
      self:set_button_listener(btn, function()
        self:_on_click_endless_buff(entry_cfg, idx)
      end)
    end
  elseif self:check_weekly_fight(tower_type) then
    use_data = self.v_show_data.week_acty_data
    self.v_uiobjects.SceneBuffTem1:SetActive(nil ~= use_data[1] and "" ~= use_data[1])
    self.v_uiobjects.SceneBuffTem2:SetActive(nil ~= use_data[2] and "" ~= use_data[2])
    self.v_uicompents.BuffDesc1_txt.text = use_data[1]
    self.v_uicompents.BuffDesc2_txt.text = use_data[2]
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
  end
  self.v_uiobjects.Time:SetActive(nil ~= TowerMgr:get_tower_use_time())
  local ui_ct_timer = UIMgr:try_get_ui("ui_ct_timer")
  if ui_ct_timer then
    self.v_uiobjects.Time:SetActive(true)
    local temp_txt = ui_ct_timer:get_record_time()
    self.v_uicompents.Time_txt.text = temp_txt
    self.v_uicompents.TimeTitle_txt.text = Util.format_str("距离结束")
  else
    local use_time = TowerMgr:get_tower_use_time()
    self.v_uicompents.Time_txt.text = use_time
    self.v_uicompents.TimeTitle_txt.text = Util.format_str("战斗耗时")
  end
end

function ui:_on_click_endless_buff(cfg, idx)
  self.v_uiobjects.EndlessBufftips:SetActive(true)
  self.v_uiobjects.FullBtn:SetActive(true)
  self.v_uicompents.BuffName_txt.text = cfg.Name
  self.v_uicompents.BuffDesc_txt.text = cfg.Desc
  self.v_uicompents.EndlessBufftips_rect:SetAnchoredPositionA(INIT_BUFF_TIPS_POS_X + (idx - 1) * INIT_BUFF_TIPS_POS_OFFSET, INIT_BUFF_TIPS_POS_Y)
end

function ui:check_weekly_fight(fight_type)
  if fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function ui:clear_wrap()
  if self.v_combo_luaobj_list then
    self:remove_wrap_ui_list(self.v_combo_luaobj_list)
  end
  UtilTable.clear_list(self.v_combo_luaobj_list)
end

return ui
