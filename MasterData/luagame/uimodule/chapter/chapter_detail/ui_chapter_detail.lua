local Base = require("ui.uibase")
local SCREEN_WIDTH = Global.screen_width
local high_x = SCREEN_WIDTH * 3 / 4
local SCREEN = UnityEngine.Screen
local CENTER = SCREEN.width / 2
local CHAPTER_DETAIL_GROUP = require("uimodule.chapter.chapter_detail.ui_chapter_detail_group")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local CHALLENGE_TYPE = Config.CommonDefine.CHALLENGE_TYPE
local CHAPTER_DETAIL_GROUP_TEMP = "CHAPTER_DETAIL_GROUP_TEMP"
local CHAPTER_DETAIL_ITEM_TEMP = "CHAPTER_DETAIL_ITEM_TEMP"
local GROUP_AWARD_NODE_TEMP = "GROUP_AWARD_NODE_TEMP"
local GROUP_LONGITUDE_TEMP = "GROUP_LONGITUDE_TEMP"
local GROUP_LINE_TEMP = "GROUP_LINE_TEMP"
local ui = Util.create_child_mt(Base)
local vec2 = require("base.vec2")
local VEC2TEMP = vec2.New()
local MIN_POS_X = -99999999
local DELAY_MOVE_TIME = 0.05
local SCROLL_OFFSET = -430
local TOGGLE_LIST = {
  [1] = {tog_name = "TogEasy"},
  [2] = {tog_name = "TogHard"}
}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("LeftArrow", function()
    self:on_click_arrow()
  end)
  self:set_button("RightArrow", function()
    self:on_click_arrow(true)
  end)
  self:set_button("ChapterAward", function()
    self:on_click_chapter_task_btn(nil, "进度奖励")
  end)
  self:set_button("BtnStoryPreview", function()
    self:on_click_story_preheat_btn()
  end)
  self:set_button("BoxProgress", function()
    self:on_box_click()
  end)
  self.MOVE_TIME = 0.4
  self.CLICK_CD = 0.5 + self.MOVE_TIME
  self.v_content_width = self.v_uiobjects.NodeContent.transform.rect.width
  self.v_scroll_pos = self.v_uiobjects.ScrollView.transform.anchoredPosition
  self.v_cache_obj_map = {}
  self.v_detail_group_item_map = {}
  self.v_group_award_item_map = {}
  self.v_change_pos_map = {}
  local horizontal_grp = self.v_uiobjects.NodeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
  self.v_horizontal_grp_left = horizontal_grp.padding.left
  self.v_scr_rect = self.v_uiobjects.ScrollView:GetComponent(typeof(UnityEngine.UI.ScrollRect))
  self.v_left_cg = self:get_canvas_group(nil, self.v_uiobjects.LeftArrow)
  self.v_right_cg = self:get_canvas_group(nil, self.v_uiobjects.RightArrow)
  self:init_toggle()
  self:register_exist_auto_template(CHAPTER_DETAIL_GROUP_TEMP, self.v_uiobjects.NodeGroup, self.v_uiobjects.NodeContent)
  self:register_exist_auto_template(CHAPTER_DETAIL_ITEM_TEMP, self.v_uiobjects.StageTem, self.v_uiobjects.CacheRoot)
  self:register_exist_auto_template(GROUP_LONGITUDE_TEMP, self.v_uiobjects.LongitudeTem, self.v_uiobjects.CacheRoot)
  self:register_exist_auto_template(GROUP_AWARD_NODE_TEMP, self.v_uiobjects.AwardNode, self.v_uiobjects.CacheRoot)
  self:register_exist_auto_template(GROUP_LINE_TEMP, self.v_uiobjects.LineTem, self.v_uiobjects.CacheRoot)
end

function ui:ui_on_show(chapter_id, pass_param, auto_select, story_id, jump_target_node, jump_to_team, record_select_chapter_id)
  self.v_init_tog_idx = nil
  self.v_cur_tog_idx = nil
  self.v_left_click_cd = 0
  self.v_right_click_cd = 0
  self.v_hide_ui = false
  self.v_chapter_id = chapter_id
  self.v_jump_target_node = jump_target_node
  self.v_jump_to_team = jump_to_team
  self.v_page_type = ShareRes.get_chapter_page_type(chapter_id)
  self.v_all_chapter_id = ChapterMgr:get_all_unlock_chapter_cfg(self.v_page_type)
  self.v_select_chapter_index = self:get_select_chapter_index()
  if record_select_chapter_id then
    ChapterMgr:set_record_select_chapter_id(chapter_id)
  end
  self:reset_scroll()
  self:delay_enable_scr()
  self.v_is_first_show = true
  self.v_pass_param = pass_param
  self.v_auto_select = auto_select
  self:refresh_difficulty_visible()
  self:play_enter_anima()
  self:play_story_on_ui_show(story_id)
  if Global.sound_mgr then
    local SOURCE_TYPE = Config.SOURCE_TYPE
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE", 0)
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.BGM2, "BGM", 0)
    Global.sound_mgr:clear_sound_pause_set()
    Global.sound_mgr:set_audio_active(false, true)
  end
  self:call_info_view()
  self.v_is_first_show = false
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.on_task_update, self)
  self:bind_auto_mq(Const.MSG_CHAPTER_NODE_COMPLETE, self.on_node_complete, self)
end

function ui:on_node_complete()
  self:refresh_difficulty_visible()
end

function ui:get_jump_to_team()
  return self.v_jump_to_team
end

function ui:play_story_on_ui_show(story_id)
  if story_id then
    self.v_play_story_id = story_id
    local node_id = self.v_pass_param.pass_id
    self:set_black_bg_active(true)
    
    local function story_real_start_cb()
      self.v_play_story_id = nil
      self:set_black_bg_active(false)
    end
    
    StoryMgr:set_story_real_start_cb(story_id, story_real_start_cb)
    ChapterMgr:chapter_node_play_story(self.v_chapter_id, node_id, nil, true)
    StoryMgr:on_start(story_id)
    local detail_info = UIMgr:get_ui("ui_chapter_detail_info")
    if detail_info then
      local function cb()
        TowerMgr:show_long_chapter_award(true)
      end
      
      detail_info:set_click_settle_cb(cb)
    end
  end
end

function ui:init_toggle()
  self.v_tag_toggles = {}
  self.v_toggle_tab = ToggleTab:new(self)
  for i, v in ipairs(TOGGLE_LIST) do
    local tog = self:get_toggle(nil, self.v_uiobjects[v.tog_name])
    table.insert(self.v_tag_toggles, tog)
  end
  self.v_toggle_tab:init_by_toggles(self.v_tag_toggles, function(select, last_select, select_toggle, last_select_toggle)
    self:select_tag_toggle(select, last_select, select_toggle, last_select_toggle)
  end, 1, false)
end

function ui:refresh_difficulty_visible()
  self.v_toggle_tab:set_toggle_by_index(-1)
  local cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  self.v_init_tog_idx = cfg.ChapterMode == Config.Chapter_Mode.HARD and 2 or 1
  self.v_toggle_tab:set_toggle_by_index(self.v_init_tog_idx)
  local hard_id = cfg.HardChapter
  local hard_cfg
  if cfg.ChapterMode == Config.Chapter_Mode.HARD then
    hard_id = cfg.Id
    hard_cfg = cfg
  end
  if hard_id and hard_id > 0 then
    hard_cfg = ShareRes.get_chapter_cfg(hard_id)
    if not hard_cfg or not Condition:check_condition(hard_cfg.ShowCondition) then
      self.v_uiobjects.Difficulty:SetActive(false)
      return
    end
  else
    self.v_uiobjects.Difficulty:SetActive(false)
    return
  end
  self.v_uiobjects.Difficulty:SetActive(true)
  local hard_lock = Util.get_child_gameobj("Lock", self.v_uiobjects.TogHard)
  local hard_un_lock = Util.get_child_gameobj("UnLock", self.v_uiobjects.TogHard)
  local is_open = hard_cfg and 0 == Condition:check_condition_list(hard_cfg.Condition)
  hard_lock:SetActive(not is_open)
  hard_un_lock:SetActive(is_open)
end

function ui:select_tag_toggle(select, last_select, select_toggle, last_select_toggle)
  if self.v_init_tog_idx and self.v_init_tog_idx ~= select then
    return
  end
  self.v_init_tog_idx = nil
  if self.v_cur_tog_idx == select then
    return
  end
  self.v_cur_tog_idx = select
  self.v_jump_detail_item_cfg = nil
  local chapter_id = self.v_all_chapter_id[self.v_select_chapter_index]
  self.v_select_chapter_type = select
  if select == Config.Chapter_Mode.NORMAL then
    if self.v_pass_param and self.v_pass_param.is_hard then
      self.v_pass_param = nil
    end
    self.v_chapter_id = chapter_id
    if self.v_is_need_jump_select_toggle then
      self.v_is_need_jump_select_toggle = nil
      return
    end
    self:play_change_chapter_anima(chapter_id)
  else
    if self.v_pass_param and not self.v_pass_param.is_hard then
      self.v_pass_param = nil
    end
    local cfg = ShareRes.get_chapter_cfg(chapter_id)
    chapter_id = cfg.HardChapter
    local hard_cfg = ShareRes.get_chapter_cfg(chapter_id)
    if not hard_cfg or not ChapterMgr:check_chapter_is_unlock(chapter_id, true) then
      self.v_select_chapter_type = Config.Chapter_Mode.NORMAL
      self.v_is_need_jump_select_toggle = true
      last_select_toggle.isOn = true
      return
    end
    self.v_chapter_id = chapter_id
    self:play_change_chapter_anima(chapter_id)
  end
end

function ui:delay_enable_scr()
  self:set_scr_rect_enabled(false)
  
  local function cb()
    self:set_scr_rect_enabled(true)
    self.v_delay_enable_scr_timer = nil
  end
  
  self.v_delay_enable_scr_timer = Timer:add_timer("delay_enable_scr_timer", 0.1, cb)
end

function ui:select_pass_param_item(pass_param, is_select)
  if not is_select or not pass_param then
    return
  end
  local detail_item_type
  if pass_param.is_hard == false then
    detail_item_type = Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE
  else
    detail_item_type = Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT
  end
  local detail_item_cfg = ShareRes.get_chapter_area_point_cfg_by_module(detail_item_type, pass_param.pass_id)
  self.v_select_pass_param_item_timer = Timer:add_timer("select_chapter_node_item", 0.3, function()
    self:on_click_detail_item(detail_item_cfg)
    self.v_select_pass_param_item_timer = nil
  end)
end

function ui:refresh(chapter_id, is_next_change, pass_param)
  if not self.v_pass_param then
    self.v_pass_param = pass_param
  end
  UtilTable.clear_map(self.v_change_pos_map)
  UtilTable.clear_map(self.v_group_award_item_map)
  self:give_back_auto_cache(CHAPTER_DETAIL_GROUP_TEMP)
  self:clear_group_item()
  self.v_cur_pos_index = 1
  self.v_chapter_id = chapter_id
  self.v_all_area_data = ChapterMgr:get_chapter_area_data(chapter_id)
  self:refresh_button_state()
  self:refresh_chapter_txt()
  self:refresh_all_detail_group()
  self:refresh_top()
  self:refresh_bg()
  self:refresh_chapter_award()
  self:refresh_treasure_chest()
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.NodeContent_rect)
  if self.v_pass_param then
    self:on_pass_node()
  else
    self:get_jump_area_point_cfg(chapter_id)
    self:move_to_jump_detail_item(is_next_change)
    self:check_award_obj_in_screen()
  end
  self:refresh_effect()
end

function ui:refresh_effect()
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  self.v_uiobjects.Effect_Normal:SetActive(chapter_cfg.ChapterMode ~= Config.Chapter_Mode.HARD)
  self.v_uiobjects.Effect_Difficulty:SetActive(chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD)
end

function ui:refresh_top()
  local pass_param = self.v_pass_param
  local is_show = (nil == pass_param or pass_param.not_show_anima == true) and SceneMgr:check_main_scene()
  self.v_uiobjects.ArrowRoot:SetActive(is_show)
  self.v_uiobjects.Top:SetActive(is_show)
  self.v_uiobjects.ChapterAward:SetActive(is_show)
  self:set_no_click_active(not is_show)
  self.v_uiobjects.BtnStoryPreview:SetActive(is_show and ChapterMgr:check_story_preheat_group_open(self.v_chapter_id))
end

function ui:refresh_bg(use_bg_index)
  local bg_path, index
  if not use_bg_index then
    index = self.v_cur_pos_index
  elseif use_bg_index ~= self.v_cur_pos_index then
    index = use_bg_index
    self.v_cur_pos_index = index
  end
  if index and self.v_change_pos_map[index] then
    bg_path = self.v_change_pos_map[index].bg_path
    if bg_path then
      self.v_cur_bg_path = bg_path
      self:dot_change_bg(nil == use_bg_index)
      return true
    else
      Log.Error("获取背景图路径失败", debug.traceback())
    end
  end
end

function ui:dot_change_bg(is_first)
  Util.change_component_alpha(self.v_uicompents.ShowBg_img, 255)
  if is_first then
    self:set_black_bg_active(true)
  end
  
  local function load_done_cb()
    if not self:visible() or self:is_destroy() or Util.is_nil(self.v_object) then
      return
    end
    if self.v_tween then
      ResMgr:load_set_icon(self.v_uicompents.ShowBg_img, self.v_cur_bg_path, nil, true, self)
      Util.change_component_alpha(self.v_uicompents.ShowBg_img, 255)
      self.v_tween:Kill()
      self.v_tween = nil
    end
    if is_first then
      ResMgr:load_set_icon(self.v_uicompents.ShowBg_img, self.v_cur_bg_path, nil, true, self)
      Util.change_component_alpha(self.v_uicompents.ShowBg_img, 255)
      self:play_enter_anima()
      if not self.v_play_story_id then
        self:set_black_bg_active(false)
      end
    else
      self.v_tween = self.v_uicompents.ShowBg_img:DOFade(0, 0.5)
      self.v_tween:OnComplete(function()
        ResMgr:load_set_icon(self.v_uicompents.ShowBg_img, self.v_cur_bg_path, nil, true, self)
        Util.change_component_alpha(self.v_uicompents.ShowBg_img, 255)
        self.v_tween = nil
      end)
    end
  end
  
  ResMgr:load_set_icon(self.v_uicompents.ChangeBg_img, self.v_cur_bg_path, load_done_cb, true, self)
end

function ui:refresh_all_detail_group()
  self.v_max_pos = self.v_horizontal_grp_left
  if self.v_all_area_data then
    for index, data in ipairs(self.v_all_area_data) do
      self:create_single_detail_group(index, data)
    end
  end
end

function ui:create_single_detail_group(index, data)
  local area_id = data.area_cfg.Id
  local obj = self:get_auto_cache_by_key(CHAPTER_DETAIL_GROUP_TEMP)
  local item = CHAPTER_DETAIL_GROUP:ui_wrap(self, obj, true)
  item:set_data(self.v_chapter_id, self.v_all_area_data, index)
  self.v_detail_group_item_map[area_id] = item
  self:check_have_bg(data.area_cfg, self.v_max_pos)
  self.v_max_pos = -data.area_cfg.AreaWidth + self.v_max_pos
end

function ui:check_have_bg(area_cfg, pos)
  local bg = area_cfg.AreaBgPath
  if not Util.is_empty(bg) then
    local temp
    local pos_map = self.v_change_pos_map
    local len = #pos_map
    temp = {
      start_pos = pos,
      end_pos = MIN_POS_X,
      bg_path = bg
    }
    table.insert(pos_map, temp)
    if pos_map[len] then
      pos_map[len].end_pos = pos
    end
  end
end

function ui:refresh_detail_item_select_state()
  for key, item in pairs(self.v_detail_group_item_map) do
    item:set_detail_item_select_state()
  end
end

function ui:refresh_button_state()
  self.v_uiobjects.BtnNext:SetActive(false)
  self.v_uiobjects.BtnLast:SetActive(false)
end

function ui:refresh_chapter_txt()
  local cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  self.v_uicompents.ChaptNumber_txt.text = cfg.NumText
  self.v_uicompents.ChaptName_txt.text = cfg.Name
end

function ui:reset_scroll(duration)
  self:clear_sequence()
  self:set_scr_rect_enabled(true)
  if duration then
    self.v_sequence = Util.create_sequence()
  end
  self:refresh_top()
  self:refresh_chapter_award()
end

function ui:clear_group_item()
  for key, item in pairs(self.v_detail_group_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_detail_group_item_map[key] = nil
  end
end

function ui:ui_on_hide()
  if Global.sound_mgr and not UIMgr:try_get_visible_ui("loading") then
    local SOURCE_TYPE = Config.SOURCE_TYPE
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE")
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.BGM2, "BGM")
    Global.sound_mgr:set_audio_active(true, true, 0.5, true)
  end
  self.v_auto_select = nil
  self.v_pass_param = nil
  self.v_select_chapter_id = nil
  self.v_select_module_param = nil
  self.v_select_module_type = nil
  self.v_select_area_point_cfg = nil
  self.v_left_award = nil
  self.v_right_award = nil
  self:clear_timer()
  self:clear_sequence()
  self:remove_pass_node_timer()
  self:clear_group_item()
  UtilTable.clear_map(self.v_change_pos_map)
  UtilTable.clear_map(self.v_group_award_item_map)
  if self.v_tween then
    if self.v_cur_bg_path then
      ResMgr:load_set_icon(self.v_uicompents.ShowBg_img, self.v_cur_bg_path, nil, true)
    end
    Util.change_component_alpha(self.v_uicompents.ShowBg_img, 255)
    self.v_tween:Kill()
    self.v_tween = nil
  end
  self.v_cur_bg_path = nil
  self.v_play_story_id = nil
  self.v_jump_detail_item_cfg = nil
  if self.v_record_select_chapter_id or self.v_record_select_param_id then
    ChapterMgr:set_record_select_chapter_id()
    ChapterMgr:set_record_select_param_id()
    self.v_record_select_chapter_id = nil
    self.v_record_select_param_id = nil
  end
end

function ui:ui_on_destroy()
  self.v_scr_rect = nil
end

function ui:update_click_cd(delta_time)
  self.v_left_click_cd = self.v_left_click_cd - delta_time
  if self.v_left_click_cd > 0 then
    if self.v_left_award then
      self.v_left_cg.alpha = (self.CLICK_CD - self.v_left_click_cd) / self.CLICK_CD
    end
  elseif 1 ~= self.v_left_cg.alpha then
    self.v_left_cg.alpha = 1
  end
  self.v_right_click_cd = self.v_right_click_cd - delta_time
  if self.v_right_click_cd > 0 then
    if self.v_right_award then
      self.v_right_cg.alpha = (self.CLICK_CD - self.v_right_click_cd) / self.CLICK_CD
    end
  elseif 1 ~= self.v_right_cg.alpha then
    self.v_right_cg.alpha = 1
  end
end

function ui:ui_on_update(delta_time)
  local x = self.v_uiobjects.NodeContent.transform.anchoredPosition.x
  self:check_content_pos(x)
  self:check_award_obj_in_screen()
  self:update_click_cd(delta_time)
end

function ui:check_content_pos(x)
  local index
  for i = #self.v_change_pos_map, 1, -1 do
    local data = self.v_change_pos_map[i]
    if x < data.start_pos + high_x then
      index = i
      break
    end
  end
  if index then
    self:refresh_bg(index)
  end
end

function ui:change_select_chapter(is_next)
  if not self.v_select_chapter_index then
    return
  end
  local next_index = is_next and self.v_select_chapter_index + 1 or self.v_select_chapter_index - 1
  local next_id = self.v_all_chapter_id[next_index]
  local chapter_id = next_id
  if self.v_select_chapter_type and self.v_select_chapter_type ~= Config.Chapter_Mode.NORMAL then
    local cfg = ShareRes.get_chapter_cfg(chapter_id)
    chapter_id = cfg.HardChapter
  end
  if not ChapterMgr:check_chapter_is_unlock(chapter_id, true) then
    return
  end
  if chapter_id then
    self.v_select_chapter_index = next_index
    self.v_jump_detail_item_cfg = nil
    self:play_change_chapter_anima(chapter_id)
  end
end

function ui:change_select_by_chapter_id(chapter_id)
  for index, cfg_id in pairs(self.v_all_chapter_id) do
    if cfg_id == chapter_id then
      self.v_select_chapter_index = index
      self.v_jump_detail_item_cfg = nil
      self:play_change_chapter_anima(chapter_id)
      break
    end
  end
end

function ui:get_detail_item_temp()
  return self:get_auto_cache_by_key(CHAPTER_DETAIL_ITEM_TEMP)
end

function ui:give_back_detail_item_temp(obj)
  self:give_back_cache_obj(CHAPTER_DETAIL_ITEM_TEMP, obj)
end

function ui:get_group_longitude_temp()
  return self:get_auto_cache_by_key(GROUP_LONGITUDE_TEMP)
end

function ui:give_back_group_longitude_temp(obj)
  self:give_back_cache_obj(GROUP_LONGITUDE_TEMP, obj)
end

function ui:get_group_line_temp()
  return self:get_auto_cache_by_key(GROUP_LINE_TEMP)
end

function ui:give_back_group_line_temp(obj)
  self:give_back_cache_obj(GROUP_LINE_TEMP, obj)
end

function ui:get_group_award_node_temp()
  return self:get_auto_cache_by_key(GROUP_AWARD_NODE_TEMP)
end

function ui:give_back_group_award_node_temp(obj)
  self:give_back_cache_obj(GROUP_AWARD_NODE_TEMP, obj)
end

function ui:get_auto_cache_by_key(temp_key)
  local obj = self:get_auto_cache(temp_key)
  self.v_cache_obj_map[obj] = temp_key
  return obj
end

function ui:give_back_cache_obj(temp_key, obj)
  if obj:IsNull() then
    return
  end
  obj.transform:SetParent(self.v_uiobjects.CacheRoot.transform)
  self:give_back_auto_cache_obj(temp_key, obj)
end

function ui:on_click_detail_item(area_point_cfg, not_move)
  self.v_select_chapter_id = area_point_cfg.Chapter
  self.v_select_module_param = area_point_cfg.ModuleParam
  self.v_select_module_type = area_point_cfg.ModuleType
  self.v_select_area_point_cfg = area_point_cfg
  self:refresh_detail_item_select_state()
  if not not_move then
    local area_id = area_point_cfg.AreaId
    local area_point_id = area_point_cfg.Id
    self:move_to_target_area_point(area_id, area_point_id, true, true, false)
  end
  local detail_info = UIMgr:get_ui("ui_chapter_detail_info")
  if not detail_info:visible() then
    detail_info:ui_show(self.v_select_chapter_id, self.v_select_module_param, self.v_select_module_type, nil, self.v_jump_to_team)
  else
    detail_info:refresh_view(self.v_select_chapter_id, self.v_select_module_param, self.v_select_module_type)
  end
end

function ui:on_click_chapter_task_btn(group_id, title_str)
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  local task_group_id = chapter_cfg and chapter_cfg.TaskGroupId
  if not task_group_id then
    return
  end
  local cfg_group = ShareRes.get_chapter_task_cfg(task_group_id)
  if not cfg_group then
    return
  end
  UIMgr:get_ui("chapter_task"):ui_show(self.v_chapter_id, group_id, title_str)
end

function ui:on_click_story_preheat_btn()
  UIMgr:get_ui("chapter_story_preheat"):ui_show(self.v_chapter_id)
end

function ui:on_box_click()
  TreasureChestMgr:on_chapter_box_progress_click()
  self:refresh_treasure_chest_red()
  UIMgr:get_ui("ui_treasure_chest_handbook"):ui_show(self.v_chapter_id)
end

function ui:clear_select_param(duration)
  self.v_select_chapter_id, self.v_select_module_param, self.v_select_module_type = nil, nil, nil
  self.v_pass_param = nil
  self:reset_scroll()
  self:refresh_detail_item_select_state()
end

function ui:get_select_param()
  return self.v_select_chapter_id, self.v_select_module_param, self.v_select_module_type
end

function ui:get_vec2_temp()
  return VEC2TEMP
end

function ui:get_select_chapter_index()
  local chapter_id = self.v_chapter_id
  local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
  if chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD then
    for index, id in pairs(self.v_all_chapter_id) do
      local normal_cfg = ShareRes.get_chapter_cfg(id)
      if normal_cfg.HardChapter == chapter_id then
        chapter_id = id
        return index
      end
    end
  end
  for index, id in pairs(self.v_all_chapter_id) do
    if id == chapter_id then
      return index
    end
  end
end

function ui:scroll_to_item_pos(tf, sequence, cal_scale, add_offset, move_time, need_select)
  local scroll_tf = self.v_uiobjects.ScrollView.transform
  local x, y, z = scroll_tf:GetInverseTransformPointA(tf.position.x, tf.position.y, tf.position.z)
  local pos = self.v_uiobjects.NodeContent.transform.localPosition
  pos.x = pos.x - x
  if add_offset then
    pos.x = pos.x + SCROLL_OFFSET
  end
  if sequence then
    sequence:Join(self.v_uiobjects.NodeContent.transform:DOLocalMove(pos, move_time or self.MOVE_TIME))
  else
    self.v_uiobjects.NodeContent.transform.localPosition = pos
  end
end

function ui:get_jump_area_point_cfg(chapter_id)
  if self.v_jump_target_node then
    if ShareRes.get_chapter_node_cfg(self.v_jump_target_node) then
      self.v_jump_detail_item_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE, self.v_jump_target_node)
    else
      self.v_jump_detail_item_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT, self.v_jump_target_node)
    end
  end
  if not self.v_jump_detail_item_cfg then
    self.v_record_select_param_id = ChapterMgr:get_record_select_param_id()
    if self.v_record_select_param_id then
      self.v_record_select_chapter_id = ChapterMgr:get_record_select_chapter_id()
      if self.v_chapter_id ~= self.v_record_select_chapter_id then
        self.v_record_select_param_id = nil
        self.v_record_select_chapter_id = nil
        ChapterMgr:set_record_select_chapter_id()
        ChapterMgr:set_record_select_param_id()
      end
    end
    local param_id
    local point_data = ChapterMgr:get_chapter_newst_point_data(chapter_id)
    if point_data then
      param_id = self.v_record_select_param_id or point_data.id
      local point_cfg = ShareRes.get_chapter_point_cfg(point_data.id)
      if point_cfg.FightType == CHALLENGE_TYPE.CHAPTER or point_cfg.FightType == CHALLENGE_TYPE.INDEPENDENT then
        self.v_jump_detail_item_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT, param_id)
      elseif point_cfg.FightType == CHALLENGE_TYPE.LONG_CHAPTER then
        local node_cfg, all_suc = ChapterMgr:get_cur_chapter_newest_node_info(point_data.id, chapter_id)
        local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
        if not self.v_jump_detail_item_cfg then
          if chapter_cfg and chapter_cfg.ChapterMode == Config.Chapter_Mode.DIFFICULTY then
            self.v_jump_detail_item_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT, point_data.id)
          else
            param_id = self.v_record_select_param_id or node_cfg.Id
            self.v_jump_detail_item_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE, param_id)
          end
        end
      end
    else
      local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
      if chapter_cfg and chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD then
        Log.Error("服务器章节未开启或该章节没有开启的关卡,先检查一下开启条件,没问题再找服务器看看, 章节id:", chapter_id)
      end
    end
  end
end

function ui:move_to_jump_detail_item(is_next_change)
  if not self.v_jump_detail_item_cfg then
    Log.Error("获取推荐点位失败", debug.traceback())
    return
  end
  if not self.v_all_area_data then
    return
  end
  local area_id = self.v_jump_detail_item_cfg.AreaId
  local area_point_id = self.v_jump_detail_item_cfg.Id
  if self.v_all_area_data[1].area_cfg.Id == area_id then
    local init_y = self.v_uiobjects.NodeContent.transform.anchoredPosition.y
    self.v_uiobjects.NodeContent.transform:SetAnchoredPositionA(0, init_y)
  else
    self:set_scr_rect_enabled(true)
    self:move_to_target_area_point(area_id, area_point_id, false, false, is_next_change)
  end
  if self.v_jump_target_node then
    local node_state = ChapterMgr:get_node_state(self.v_chapter_id, self.v_jump_target_node)
    if self.v_auto_select ~= nil then
      if self.v_auto_select then
        self:on_click_detail_item(self.v_jump_detail_item_cfg, true)
      end
    elseif node_state ~= Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED then
      self:on_click_detail_item(self.v_jump_detail_item_cfg, true)
    end
  end
end

function ui:move_to_target_area_point(area_id, area_point_id, need_dot, add_offset, cal_scale, move_time, cb, play_unlock_anima)
  local area_group = self.v_detail_group_item_map[area_id]
  if not area_group then
    Log.Error("获取目标区域失败，请检查区域配置中是否含有ID为：", area_id, debug.traceback())
    return
  end
  local area_item = area_group:get_detail_item(area_point_id)
  if not play_unlock_anima then
    area_item:update_lock_state()
  end
  local tf = area_item:get_object_transform()
  if need_dot then
    self:before_scroll_to_item_pos(add_offset, cb)
  end
  self:scroll_to_item_pos(tf, self.v_sequence, cal_scale, add_offset, move_time)
end

function ui:before_scroll_to_item_pos(add_offset, cb)
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self:set_scr_rect_enabled(false)
  self.v_sequence:OnComplete(function()
    if not add_offset then
      self:set_scr_rect_enabled(true)
    end
    if cb then
      cb()
    end
    self.v_sequence = nil
  end)
end

function ui:move_scroll(x, y, sequence, duration)
  if sequence then
    sequence:Join(self.v_uicompents.ScrollView_rect:DOAnchorPosX(x, duration or self.MOVE_TIME))
  else
    VEC2TEMP.x = x
    VEC2TEMP.y = y
    self.v_uiobjects.ScrollView.transform.anchoredPosition = VEC2TEMP
  end
end

function ui:on_pass_node()
  local pass_param = self.v_pass_param
  local module_param = pass_param.pass_id
  local is_hard = pass_param.is_hard
  local not_show_anima = pass_param.not_show_anima or not ChapterMgr:is_first_save_node(module_param) or is_hard
  local do_unlock_anima = pass_param.do_unlock_anima
  local module_type = is_hard and Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT or Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE
  local area_point_cfg = ShareRes.get_chapter_area_point_cfg_by_module(module_type, module_param)
  local target_area_id, target_area_group = area_point_cfg.AreaId
  local target_area_point_id, target_area_item, next_area_id, next_area_group, next_area_point_id, next_area_item, next_id, next_state, next_point_cfg = area_point_cfg.Id
  target_area_group = self.v_detail_group_item_map[target_area_id]
  if not target_area_group then
    if not self:check_create_new_area() then
      Log.Error("创建目标区域失败", target_area_id, target_area_point_id, module_type, module_param)
    else
      target_area_group = self.v_detail_group_item_map[target_area_id]
    end
    if not target_area_group then
      Log.Error("获取目标区域失败，目标点位：", target_area_point_id, "目标区域:", target_area_id, "请检测目标点位所配置AreaId与节点所对应ID是否相符")
      return false
    end
  end
  target_area_item = target_area_group:get_detail_item(target_area_point_id)
  self.v_pass_param.target_area_point_id = target_area_point_id
  if not not_show_anima or do_unlock_anima then
    if module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
      next_id = ChapterMgr:get_next_point_id(self.v_chapter_id, module_param)
    elseif module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
      next_id = ShareRes.get_chapter_node_behind_node_id(module_param)
    end
  end
  if next_id and next_id > 0 then
    next_point_cfg = ShareRes.get_chapter_area_point_cfg_by_module(module_type, next_id)
    if not next_point_cfg then
      Log.Error("获取下一点位失败，next_id：", next_id, "module_type", module_type, debug.traceback())
      return
    end
    next_area_id = next_point_cfg.AreaId
    next_area_point_id = next_point_cfg.Id
    next_area_group = self.v_detail_group_item_map[next_area_id]
    next_area_item = next_area_group:get_detail_item(next_area_point_id)
    self.v_pass_param.next_area_point_id = next_area_point_id
    self.v_pass_param.next_area_id = next_area_id
    if module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
      next_state = ChapterMgr:get_chapter_point_state(self.v_chapter_id, next_id)
    elseif module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
      next_state = ChapterMgr:get_node_state(self.v_chapter_id, next_id)
    end
  end
  local tf = target_area_item:get_object_transform()
  if not not_show_anima and next_area_item then
    next_area_item:set_enable(next_state == Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED)
    next_area_item:set_lock_state(true, true)
    next_area_group:set_line_visible(module_param, next_area_point_id, false)
    next_area_group:set_empty_point_visible_on_pass_node()
    next_area_group:refresh_longitude_show_state()
  end
  
  local function cb()
    self:scroll_to_item_pos(tf, nil, false, true)
    if not not_show_anima then
      self:set_scr_rect_enabled(false)
      target_area_item:play_clear_pd()
    end
    if do_unlock_anima then
      self:do_unlock_anima(false)
      self:set_scr_rect_enabled(true)
    end
    self.v_on_pass_node_timer = nil
  end
  
  self:remove_pass_node_timer()
  self.v_on_pass_node_timer = Timer:add_timer("on_pass_node", DELAY_MOVE_TIME, cb)
end

function ui:remove_pass_node_timer()
  if self.v_on_pass_node_timer then
    Timer:remove_timer(self.v_on_pass_node_timer)
    self.v_on_pass_node_timer = nil
  end
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:ui_can_auto_destroy(now_time)
  if not self.v_pass_param and not SceneMgr:check_main_scene() then
    return Base.ui_can_auto_destroy(self, now_time)
  else
    return false
  end
end

function ui:on_background_show()
  return self.v_pass_param ~= nil
end

function ui:get_cache_data()
  return self.v_chapter_id
end

function ui:change_chapter_anima_cb(next_id)
  local in_pd = self.v_uicompents.UIStageNew_In_pd
  self:refresh(next_id, true)
  in_pd:ResetPD()
  in_pd:Play()
  self:set_no_click_active(false)
  self.v_guide_ui_ready = true
  GuideMgr:check_sys_guide(self)
end

function ui:play_change_chapter_anima(next_id)
  if self.v_is_first_show then
    self:change_chapter_anima_cb(next_id)
  else
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_chapter_easy_switch_UI_SOUND)
    local in_pd = self.v_uicompents.UIStageNew_In_pd
    local out_pd = self.v_uicompents.UIStageNew_Out_pd
    local duration = out_pd.duration
    in_pd:ResetPD()
    out_pd:ResetPD()
    out_pd:Play()
    self:clear_timer()
    self:set_no_click_active(true)
    self.v_guide_ui_ready = false
    self.v_change_chapter_timer = Timer:add_timer("change_chapter", duration, self.change_chapter_anima_cb, self, next_id)
  end
end

function ui:clear_timer()
  if self.v_change_chapter_timer then
    Timer:remove_timer(self.v_change_chapter_timer)
    self.v_change_chapter_timer = nil
  end
  if self.v_delay_enable_scr_timer then
    Timer:remove_timer(self.v_delay_enable_scr_timer)
    self.v_delay_enable_scr_timer = nil
  end
  if self.v_select_pass_param_item_timer then
    Timer:remove_timer(self.v_select_pass_param_item_timer)
    self.v_select_pass_param_item_timer = nil
  end
end

function ui:add_group_award_item(group_id, item)
  self.v_group_award_item_map[group_id] = item
end

function ui:check_award_obj_in_screen()
  self.v_left_award = nil
  self.v_right_award = nil
  local ui_camera = UIMgr:get_root_camera()
  local pos, award_pos, left_dist, right_dist, last_left_dist, last_right_dist
  for key, item in pairs(self.v_group_award_item_map) do
    if item:get_can_get_award() then
      award_pos = item:get_award_position()
      pos = ui_camera:WorldToScreenPoint(award_pos)
      if pos.x < 0 then
        left_dist = self:cal_dist(pos.x)
        if not last_left_dist or last_left_dist > left_dist then
          self.v_left_award = item
          last_left_dist = left_dist
        end
      elseif pos.x > SCREEN.width then
        right_dist = self:cal_dist(pos.x)
        if not last_right_dist or last_right_dist > right_dist then
          self.v_right_award = item
          last_right_dist = right_dist
        end
      end
    end
  end
  local show_left = self.v_left_award ~= nil
  local show_right = nil ~= self.v_right_award
  self:update_ui_visible(self.v_uiobjects.LeftArrow, show_left)
  self:update_ui_visible(self.v_uiobjects.RightArrow, show_right)
end

function ui:on_click_arrow(is_right)
  local target_item
  if is_right then
    if self.v_right_click_cd > 0 then
      return
    end
    target_item = self.v_right_award
  else
    if self.v_left_click_cd > 0 then
      return
    end
    target_item = self.v_left_award
  end
  if not target_item then
    return
  end
  if is_right then
    self.v_right_click_cd = self.CLICK_CD
    self.v_left_cg.alpha = 1
    self.v_left_click_cd = 0
  else
    self.v_right_click_cd = 0
    self.v_right_cg.alpha = 1
    self.v_left_click_cd = self.CLICK_CD
  end
  local tf = target_item:get_award_tf()
  
  local function cb()
    self:check_award_obj_in_screen()
  end
  
  self:before_scroll_to_item_pos(false, cb)
  self:scroll_to_item_pos(tf, self.v_sequence, false, false)
end

function ui:cal_dist(x)
  x = math.abs(x - CENTER)
  return x
end

function ui:refresh_chapter_award()
  local obj = self.v_uiobjects.ChapterAward
  local pro_txt = self:get_text("ProgressNum", obj)
  local pro_img = self:get_image("Progress/ProgressFill", obj)
  local effect = self:get_child_gameobj("Progress/Image/Effect", obj)
  local tr = obj:GetComponent(typeof(CS.TouchReciver))
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  local task_group_id = chapter_cfg.TaskGroupId
  if not Util.is_more_than_zero(task_group_id) then
    obj:SetActiveEx(false)
    return
  end
  local task_complete_num, can_get_award_num = ChapterMgr:get_chapter_task_complete_num(self.v_chapter_id)
  local task_max_num
  local task_list = ShareRes.get_chapter_task_cfg(task_group_id)
  if task_list then
    task_max_num = UtilTable.hash_lenth(task_list)
  else
    Log.Error(string.format("获取阶段任务失败，章节任务组%s", task_group_id))
    return
  end
  if effect then
    effect:SetActive(can_get_award_num > 0)
  end
  local percent = task_complete_num / task_max_num
  pro_txt.text = math.floor(percent * 100) .. "%"
  pro_img.fillAmount = percent
  tr.enabled = true
end

function ui:refresh_treasure_chest()
  local total_finish_count, total_count = TreasureChestMgr:get_chapter_treasure_chest_count(self.v_chapter_id)
  if 0 == total_count then
    self.v_uiobjects.BoxProgress:SetActive(false)
    return
  end
  self.v_uiobjects.BoxProgress:SetActive(total_count > 0)
  self.v_uicompents.BoxProgressNum_txt.text = Util.format_str("{1}/{2}", total_finish_count, total_count)
  self:refresh_treasure_chest_red()
end

function ui:refresh_treasure_chest_red()
  local is_need_show_red = TreasureChestMgr:get_is_need_show_chapter_box_red()
  self.v_uiobjects.BoxProgressRed:SetActive(is_need_show_red)
end

function ui:do_unlock_anima(need_refresh_detail)
  if not (self.v_pass_param and self.v_pass_param.target_area_point_id and self.v_pass_param.next_area_point_id) or not self.v_pass_param.next_area_id then
    return false
  end
  local target_area_group = self.v_detail_group_item_map[self.v_pass_param.next_area_id]
  if not target_area_group then
    if not self:check_create_new_area() then
      Log.Error("创建目标区域失败", self.v_pass_param, debug.traceback())
    else
      target_area_group = self.v_detail_group_item_map[self.v_pass_param.next_area_id]
    end
    if not target_area_group then
      Log.Error("获取目标区域失败", self.v_pass_param)
      return false
    end
  end
  return target_area_group:do_unlock_anima(self.v_pass_param.target_area_point_id, self.v_pass_param.next_area_point_id, need_refresh_detail)
end

function ui:on_task_update(msg)
  self:refresh_chapter_award()
  for key, item in pairs(self.v_detail_group_item_map) do
    item:refresh_award_node()
  end
end

function ui:check_create_new_area()
  local length = #self.v_all_area_data
  local target_index = length + 1
  local new_area_data = ChapterMgr:get_target_index_area_data(self.v_chapter_id, target_index)
  if new_area_data then
    self.v_all_area_data[target_index] = new_area_data
    self:create_single_detail_group(target_index, new_area_data)
    return true
  else
    return false
  end
end

function ui:set_scr_rect_enabled(enabled)
  self.v_scr_rect.enabled = enabled
end

function ui:get_move_time()
  return self.MOVE_TIME
end

function ui:call_info_view()
  local detail_info = UIMgr:try_get_visible_ui("ui_chapter_detail_info")
  if detail_info then
    detail_info:on_detail_view_show()
  end
end

function ui:on_unlock_anima_play()
  self:set_no_click_active(true)
end

function ui:on_unlock_anima_end()
  local detail_info = UIMgr:try_get_visible_ui("ui_chapter_detail_info")
  if detail_info then
    detail_info:on_unlock_anima_end()
  end
  self:set_no_click_active(false)
end

function ui:set_no_click_active(is_active)
  self.v_uiobjects.NoClick:SetActive(is_active)
end

function ui:set_black_bg_active(is_active)
  self.v_uiobjects.BlackBg:SetActive(is_active)
end

function ui:play_enter_anima()
  local in_pd = self.v_uicompents.UIStageNew_In_pd
  local out_pd = self.v_uicompents.UIStageNew_Out_pd
  in_pd:ResetPD()
  out_pd:ResetPD()
  in_pd:Play()
end

function ui:check_ui_condition_guide(guide_id)
  local cfg = ShareRes.create("guide.guide", guide_id)
  if cfg.checkui_ready then
    return self.v_guide_ui_ready
  end
end

return ui
