local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local Char_Helper = require("uimodule.character.char_helper")
local MAX_CHAR_ITEM_COUNT = Config.MAX_CHAR_ITEM_COUNT
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")

local function sort(a, b)
  if a.pos ~= b.pos then
    return a.pos < b.pos
  else
    return false
  end
end

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:on_click_settle_btn()
  end)
  self:set_button("SpineBtn", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  local x, y, _ = self.v_uicompents.SpineRaw_rect:GetLocalPositionA3()
  local scale, _, _ = self.v_uicompents.SpineRaw_rect:GetLocalScaleA3()
  self.v_default_raw_img_offset = {
    x,
    y,
    scale
  }
  x, y, _ = self.v_uicompents.Char_rect:GetLocalPositionA3()
  scale, _, _ = self.v_uicompents.Char_rect:GetLocalScaleA3()
  self.v_default_img_offset = {
    x,
    y,
    scale
  }
end

function ui:on_click_settle_btn()
  local callback
  if SceneMgr:check_main_scene() then
    self:ui_hide()
  else
    function callback()
      Global.scene_mgr:on_enter_main_scene()
      
      UIMgr:revert_cache_ui()
    end
  end
  if self.v_is_get_award then
    if callback then
      callback()
    end
  else
    TowerMgr:get_fight_reward(callback)
  end
end

function ui:ui_on_show(fight_state, quick_fight_param)
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self.v_quick_fight_param = quick_fight_param
  self.v_state = fight_state
  self.v_all_die = fight_state == CHAPTER_CONFIG.POINTSTATE.all_die
  self:refresh_point_info()
  self:refresh_floor_num()
  self:refresh_hero_item()
  self:refresh_player_info()
  self:refresh_pass_time()
  self:check_need_get_award()
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:ui_on_hide()
  self.v_quick_fight_para = nil
  self.v_state = nil
  self.v_all_die = nil
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
end

function ui:refresh_score(infinite_id)
  local current_score
  if self.v_quick_fight_param then
    current_score = self.v_quick_fight_param.score or 0
  else
    local progress = TowerMgr:get_tower_progress()
    current_score = progress and progress.infinite_progress.score or 0
  end
  self.v_uicompents.ScoreNum_txt.text = current_score
  local data = ChapterMgr:get_inf_chapter_data(infinite_id)
  local max = data and data.history_max_score or 0
  self.v_uiobjects.NewRecord:SetActive(current_score > max)
end

function ui:refresh_point_info()
  local infinite_id, point_id
  if self.v_quick_fight_param then
    infinite_id = self.v_quick_fight_param.infinite_id
    local cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
    point_id = cfg.EpisodeId
  else
    local progress = TowerMgr:get_tower_progress()
    point_id = progress.episode_id
    infinite_id = ShareRes.get_infinite_id_by_point_id(point_id)
  end
  self:refresh_difficulty_num(infinite_id)
  self:refresh_point_name(point_id)
  self:refresh_score(infinite_id)
end

function ui:refresh_point_name(point_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
end

function ui:refresh_difficulty_num(infinite_id)
  local str
  if self.v_quick_fight_param then
    local cfg = ShareRes.get_chapter_infinite_misc()
    str = cfg.QuickFightTip
  else
    local progress = TowerMgr:get_tower_progress()
    local total_num = progress and progress.infinite_progress.coeff or 0
    str = "x" .. total_num
  end
  self.v_uicompents.DifficultyNum_txt.text = str
end

function ui:refresh_floor_num()
  local floor_num
  if self.v_quick_fight_param then
    floor_num = self.v_quick_fight_param.progress_data.floor_idx
  else
    local progress = TowerMgr:get_tower_progress()
    floor_num = progress.floor_id
  end
  self.v_uicompents.FloorNum_txt.text = floor_num
end

function ui:refresh_pass_time()
  local fight_time
  if self.v_quick_fight_param then
    fight_time = self.v_quick_fight_param.progress_data.fight_time
  else
    local progress = TowerMgr:get_tower_progress()
    if progress and progress.infinite_progress then
      fight_time = progress.infinite_progress.fight_time or 0
    else
      fight_time = 0
    end
  end
  local str = Date.get_time_formate_4(fight_time, true)
  self.v_uicompents.TimeNum_txt.text = str
end

function ui:refresh_hero_item()
  local hero_list, infinite_data, main_pos
  if self.v_quick_fight_param then
    infinite_data = self.v_quick_fight_param.progress_data
    hero_list = infinite_data.buddys
  else
    local progress = TowerMgr:get_tower_progress()
    hero_list = progress.battle_buddy_data
  end
  if not SceneMgr:check_main_scene() and not SceneMgr:global_hero_is_destroyed() then
    main_pos = Global.hero:get_team_pos()
  else
    main_pos = infinite_data and infinite_data.main_pos
  end
  if not hero_list then
    for index = 1, MAX_CHAR_ITEM_COUNT do
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
    return
  end
  table.sort(hero_list, sort)
  local role_cfg, role_id, icon_path, qual_val, data, main_role, fashion_id
  for index = 1, MAX_CHAR_ITEM_COUNT do
    data = hero_list[index]
    if data then
      self.v_uiobjects["Char" .. index]:SetActive(true)
      if main_pos and main_pos == data.pos or data.is_main then
        main_role = data
      end
      role_id = data.buddy_id
      fashion_id = data.fashion
      role_cfg = ShareRes.create("buddy.buddy", role_id)
      icon_path = UtilUI.get_hero_images(role_id, 2, fashion_id)
      ResMgr:load_set_icon(self.v_uicompents["CharIcon" .. index .. "_img"], icon_path)
      self.v_uicompents["ZhanliNum" .. index .. "_txt"].text = data.power
      icon_path = Char_Helper.get_char_select_quality_icon(role_id)
      ResMgr:load_set_icon(self.v_uicompents["QualityBg" .. index .. "_img"], icon_path)
      qual_val = role_cfg.Quality
      icon_path = Char_Helper.get_char_line_quality_icon(qual_val)
      ResMgr:load_set_icon(self.v_uicompents["QualityLine" .. index .. "_img"], icon_path)
    else
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
  end
  fashion_id = main_role.fashion
  local spine_id, is_spine, offset = UtilUI.get_hero_settle_spine(main_role.buddy_id, fashion_id)
  self.v_uiobjects.SpineRaw:SetActive(is_spine)
  self.v_uiobjects.Char:SetActive(not is_spine)
  if is_spine then
    self:clear_spine_rt()
    self.v_spine_id = spine_id
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpineRaw)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.SpineRaw)
    offset = offset or self.v_default_raw_img_offset
    self.v_uicompents.SpineRaw_rect:SetLocalPositionA(offset[1], offset[2], 0)
    self.v_uicompents.SpineRaw_rect:SetLocalScaleA(offset[3], offset[3], offset[3])
  else
    self.v_spine_id = nil
    icon_path = spine_id
    ResMgr:load_set_icon(self.v_uicompents.Char_img, icon_path, nil, true, self)
    offset = offset or self.v_default_img_offset
    self.v_uicompents.Char_rect:SetLocalPositionA(offset[1], offset[2], 0)
    self.v_uicompents.Char_rect:SetLocalScaleA(offset[3], offset[3], offset[3])
  end
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:refresh_player_info()
  local base_info = PlayerMgr:get_player_base_info()
  local ucom = self.v_uicompents
  ucom.PlayerName_txt.text = base_info.name
  ucom.IDNum_txt.text = PlayerMgr:get_player_uid()
  local head_id = PlayerMgr:get_player_head_id()
  local avatar_cfg = ShareRes.get_player_head_cfg(head_id)
  local avatar_icon_path = "Icon/Profile/" .. avatar_cfg.Icon
  ResMgr:load_set_icon(ucom.PlayerProfile_img, avatar_icon_path)
end

function ui:check_need_get_award()
  if self.v_quick_fight_param then
    return
  end
  if TowerMgr then
    if self.v_all_die then
      local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
      if not TowerMgr:can_archieve() and (not (_ and reborn_cost_id) or 0 == reborn_cost_id) then
        TowerMgr:get_fight_reward()
        self.v_is_get_award = true
      end
    else
      TowerMgr:get_fight_reward()
      self.v_is_get_award = true
    end
  end
end

return ui
