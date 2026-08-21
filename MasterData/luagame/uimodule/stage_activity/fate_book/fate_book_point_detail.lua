local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SELECT_ITEM = require("uimodule.common.multi_select_item")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local Item_Helper = require("utils.item_helper")
local FATE_SELECT_ITEM = "FATE_SELECT_ITEM"
local FATE_SELECT_POINT_ITEM = "FATE_SELECT_POINT_ITEM"
local CHALLENGE_RING_RING_BOX_ITEM_KEY = "CHALLENGE_RING_RING_BOX_ITEM_KEY"
local DESTINY_LEVEL_AWARD = "DESTINY_LEVEL_AWARD"
local FATE_STAGE_ITEM = "FATE_STAGE_ITEM"
local ENEMY_PREVIEW_ITEM = "ENEMY_PREVIEW_ITEM"
local AssetBarView = require("ui.asset_bar.asset_bar")
local ENEMYPREVIEWITEM = require("uimodule.ui_common_item.enemy_preview_item")
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local DESTINY_DROP_STATE = curse_com_def.DESTINY_DROP_STATE
local CURSE_BOX_STATE = Config.CommonDefine.CURSE_BOX_STATE
local UNLOCK_COLOR = {
  [true] = "FFFFFF",
  [false] = "909090"
}
local ASSET_ITEM = {29, 28}
local COST_ID = 11
local SHOP_HELPER = require("uimodule.shop.shop_helper")

function ui:open_drop_tips()
  local fate_book_select_drop_tips = UIMgr:get_ui("fate_book_select_drop_tips")
  fate_book_select_drop_tips:ui_show(self.v_config_id)
end

function ui:on_click_enemy_show_btn()
  self:on_click_enemy_preview_item(1)
end

function ui:on_click_group_button(group_id)
  if group_id and group_id == self.v_group_id or self.v_is_init or not ChallengeRingPlusMgr:check_ring_group_is_unlock(group_id, true) then
    return
  end
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.fate_book_point_detail_tog_UI_SOUND)
  self.v_group_id = group_id
  self.v_config_ids = UtilTable.copy_table(ShareRes.get_curse_ring_config_group_to_point_cfg(group_id))
  table.sort(self.v_config_ids, function(a, b)
    if a ~= b then
      return a < b
    end
    return false
  end)
  self.v_last_type_select_group[self.v_show_point_type] = self.v_group_id
  local config_id, point_id = self:get_first_point_id_and_ring_id()
  self:change_multi_difficulty_root_active(false)
  self:on_click_point_button(point_id, config_id)
end

function ui:on_click_point_button(point_id, config_id)
  self.v_point_id = point_id
  self.v_config_id = config_id
  self:refresh_point_detail()
  self:refresh_group_select()
  self:refresh_award_content()
  self:refresh_destiny_drop()
  self:refresh_multi_point()
  self.v_uiobjects.MultiSelectRoot:SetActive(false)
end

function ui:on_click_fight_btn()
  if TowerMgr:check_fight_progress() then
    return
  end
  if not self.v_point_id or not ChallengeRingPlusMgr:check_ring_is_unlock(self.v_config_id, true) then
    return
  end
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  if ring_cfg.DestinyLevelDropType == Config.CommonDefine.CURSE_DROP_TYPE.SELECT_DROP and not ChallengeRingPlusMgr:get_destiny_drop_index(self.v_config_id) then
    self:open_drop_tips()
    Util.show_message_tip("请选择奖励")
    return
  end
  UIMgr:get_ui("choose_genres_view"):ui_show(self.v_point_id)
  FateBookMgr:set_last_type_select_group_and_point(self.v_last_type_select_group)
end

function ui:on_click_return_btn()
  self.v_show_point_type = nil
  self:ui_hide()
end

function ui:on_click_skill_tree_btn()
  UIMgr:get_ui("fate_book_skill_tree"):ui_show()
end

function ui:on_click_story_drop_btn()
  if not ChallengeRingPlusMgr:check_ring_is_unlock(self.v_config_id, false) then
    return
  end
  local active = self.v_uiobjects.MultiSelectRoot.activeSelf
  self.v_uiobjects.MultiSelectRoot:SetActive(not active)
end

function ui:on_click_task_btn()
  UIMgr:get_ui("fate_book_course_main"):ui_show()
end

function ui:on_click_task1_btn()
  if ChallengeRingPlusMgr:get_task_id_red() then
    ChallengeRingPlusMgr:request_activity_curse_clicked_red()
  end
  UIMgr:get_ui("fate_book_task"):ui_show()
end

function ui:on_click_fate_btn()
  local fate_book_level_tips = UIMgr:get_ui("fate_book_level_tips")
  fate_book_level_tips:set_hide_cb(function()
    self:refresh_destiny_level()
  end)
  fate_book_level_tips:ui_show(self.v_config_id)
end

function ui:on_difficulty_drop_btn()
  self:change_multi_difficulty_root_active(not self.v_dif_root_active)
end

function ui:on_click_BtnQuickFight()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  if ring_cfg.DestinyLevelDropType == Config.CommonDefine.CURSE_DROP_TYPE.SELECT_DROP and not ChallengeRingPlusMgr:get_destiny_drop_index(self.v_config_id) then
    self:open_drop_tips()
    Util.show_message_tip("请选择奖励")
    return
  end
  local fate_book_file = UIMgr:get_ui("fate_book_file")
  fate_book_file:ui_show(curse_com_def.FILE_VIEW_STATE.QUICK_CHALLENGE, self.v_config_id)
end

function ui:on_click_BtnFile()
  local fate_book_file = UIMgr:get_ui("fate_book_file")
  fate_book_file:ui_show(curse_com_def.FILE_VIEW_STATE.NORMAL, self.v_config_id)
end

function ui:on_click_BtnAwardChoose()
  self:open_drop_tips()
end

function ui:on_click_BtnPuzzleChoose()
  self:open_drop_tips()
end

function ui:on_click_change_type_btn()
  self:try_change_type()
end

function ui:get_change_type_info(target_type)
  local is_type_unlock = false
  local last_lock_gourp, first_in_time_group
  local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(target_type)
  local type_red = false
  if group_ids then
    for _, group_id in pairs(group_ids) do
      if ChallengeRingPlusMgr:check_ring_group_is_in_time(group_id) then
        if ChallengeRingPlusMgr:check_ring_group_is_unlock(group_id) then
          is_type_unlock = true
          if target_type == Config.FATE_POINT_TYPE.HARD then
            type_red = self:check_group_red(group_id)
          end
          break
        elseif not first_in_time_group then
          first_in_time_group = group_id
        end
      else
        last_lock_gourp = last_lock_gourp or group_id
      end
    end
  end
  return type_red, is_type_unlock, first_in_time_group, last_lock_gourp
end

function ui:try_change_type(next_type, not_show_tip)
  if not next_type then
    local cur_type = self.v_show_point_type
    if cur_type == Config.FATE_POINT_TYPE.POINT then
      next_type = Config.FATE_POINT_TYPE.HARD
    elseif cur_type == Config.FATE_POINT_TYPE.HARD then
      next_type = Config.FATE_POINT_TYPE.POINT
    end
  end
  local type_red, is_type_unlock, first_in_time_group, last_lock_gourp = self:get_change_type_info(next_type)
  self.v_uiobjects.ChangeTypeRed:SetActive(type_red)
  if not is_type_unlock then
    local lock_group = first_in_time_group or last_lock_gourp
    if lock_group then
      ChallengeRingPlusMgr:check_ring_group_is_unlock(lock_group, not not_show_tip)
    end
    return false
  end
  self.v_show_point_type = next_type
  self.v_uicompents.ChangeTypePd_pd:ResetPD()
  self.v_uicompents.ChangeTypePd_pd:Play()
  self:refresh_view()
  return true
end

function ui:on_click_enemy_preview_item(selectIdx)
  if not self.v_enemyPreviewList then
    return
  end
  UIMgr:get_ui("enemy_info_tips"):ui_show(selectIdx, self.v_enemyPreviewList)
end

function ui:ui_finish_load()
  self:set_button("BtnEnemyShow", function()
    self:on_click_enemy_show_btn()
  end)
  self:set_button("BtnFight", function()
    self:on_click_fight_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnSkillTree", function()
    self:on_click_skill_tree_btn()
  end)
  self:set_button("BtnStoryDrop", function()
    self:on_click_story_drop_btn()
  end)
  self:set_button("BtnTask", function()
    self:on_click_task_btn()
  end)
  self:set_button("BtnChangeType", function()
    self:on_click_change_type_btn()
  end)
  self:set_button("Btn_ResetAward", function()
    self:reset_treasure_progress()
  end)
  self:set_button("BtnTask1", function()
    self:on_click_task1_btn()
  end)
  self:set_button("BtnFateLv", function()
    self:on_click_fate_btn()
  end)
  self:set_button("BtnQuickFight", function()
    self:on_click_BtnQuickFight()
  end)
  self:set_button("BtnFile", function()
    self:on_click_BtnFile()
  end)
  self:set_button("BtnAwardChoose", function()
    self:on_click_BtnAwardChoose()
  end)
  self:set_button("BtnPuzzleChoose", function()
    self:on_click_BtnPuzzleChoose()
  end)
  self.v_select_story_item_list = {}
  self.v_group_obj_list = {}
  self.v_enemy_preview_item_list = {}
  self.v_item_list = {}
  self.v_destiny_item_list = {}
  local asset_config = SHOP_HELPER.get_asset_list(ASSET_ITEM)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
  self:register_exist_auto_template(FATE_SELECT_ITEM, self.v_uiobjects.MultiSelectTem, self.v_uiobjects.MultiSelectRoot)
  self:register_exist_auto_template(FATE_STAGE_ITEM, self.v_uiobjects.StageTem, self.v_uiobjects.StageContent)
  self:register_exist_auto_template(CHALLENGE_RING_RING_BOX_ITEM_KEY, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardContent)
  self:register_exist_auto_template(DESTINY_LEVEL_AWARD, self.v_uiobjects.AwardShowTem, self.v_uiobjects.AwardShowContent)
end

function ui:ui_on_show(show_point_type, show_by_pop_stack)
  self:clear_point_end_timer()
  self.v_last_type_select_group = FateBookMgr:get_last_type_select_group_and_point() or {}
  FateBookMgr:set_last_type_select_group_and_point(nil, nil)
  self.v_uicompents.Btn_ResetAward_btn.enabled = true
  self:bind_auto_mq(Const.MSG_ON_RESET_CURSE_BOX, self.refresh_box_state, self)
  self:bind_auto_mq(Const.MSG_ON_RING_BOX_UPDATE, self.refresh_box_state, self)
  self:bind_auto_mq(Const.MSG_ON_COMPLETE_RESET, self._reset_box_compplete, self)
  if show_point_type == Config.FATE_POINT_TYPE.POINT and show_by_pop_stack and self:get_change_type_info(Config.FATE_POINT_TYPE.HARD) then
    show_point_type = Config.FATE_POINT_TYPE.HARD
  end
  if not self:try_change_type(show_point_type, true) then
    self.v_show_point_type = show_point_type
    self:try_change_type()
  end
end

function ui:ui_on_hide()
  self.v_point_id = nil
  self.v_config_id = nil
  self.v_group_id = nil
  self:clear_item_list()
  self:remove_all_story_select_item()
  self:remove_all_point_select_item()
  self.v_asset_bar:on_hide()
  self:clear_point_end_timer()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_view()
  self:refresh_point_tog()
  self.v_uiobjects.MultiSelectRoot:SetActive(false)
  self:refresh_redpoint()
  self:refresh_story_entrance()
  local stage_name
  if self.v_show_point_type == Config.FATE_POINT_TYPE.POINT then
    stage_name = "探索模式"
  elseif self.v_show_point_type == Config.FATE_POINT_TYPE.STORY then
    stage_name = "故事模式"
  elseif self.v_show_point_type == Config.FATE_POINT_TYPE.HARD then
    stage_name = "书页重组"
  end
  self.v_uicompents.StageMode_txt.text = stage_name
  self.v_uicompents.StageModeLock_txt.text = stage_name
end

function ui:refresh_point_tog()
  local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(self.v_show_point_type)
  local obj, text, button, lock, icon, redpoint, bg, is_unlock, last_show_group, default_show_group
  self:give_back_auto_cache(FATE_STAGE_ITEM)
  local group_cfg
  local last_group = self.v_last_type_select_group[self.v_show_point_type]
  self.v_last_type_select_group[self.v_show_point_type] = nil
  if last_group and not ChallengeRingPlusMgr:check_ring_group_is_unlock(last_group) then
    last_group = nil
  end
  UtilTable.clear_map(self.v_group_obj_list)
  for key, group_id in pairs(group_ids) do
    local ring_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
    local open_ring_count = 0
    if ring_ids then
      for _, ring_id in pairs(ring_ids) do
        local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
        if ring_cfg and (not ring_cfg.StartTime or Date.server_time() >= Date.get_time_stamp_by_scheme_id(ring_cfg.StartTime)) and (not ring_cfg.EndTime or Date.server_time() < Date.get_time_stamp_by_scheme_id(ring_cfg.EndTime)) then
          open_ring_count = open_ring_count + 1
        end
      end
    end
    if open_ring_count > 0 then
      obj = self:get_auto_cache(FATE_STAGE_ITEM)
      group_cfg = ShareRes.get_curse_ring_group_cfg(group_id)
      is_unlock = ChallengeRingPlusMgr:check_ring_group_is_unlock(group_id, false)
      text = self:get_text("StageName", obj)
      text.gameObject:SetActive(is_unlock)
      if is_unlock then
        text.text = group_cfg.NumText
      end
      button = self:get_button(nil, obj)
      self:set_button_listener(button, function()
        self:on_click_group_button(group_id)
      end)
      bg = self:get_child_gameobj("Bg", obj)
      bg:SetActive(is_unlock)
      lock = self:get_child_gameobj("Lock", obj)
      lock:SetActive(not is_unlock)
      redpoint = self:get_child_gameobj("RedPoint", obj)
      redpoint:SetActive(self:check_group_red(group_id))
      self.v_group_obj_list[group_id] = obj
      if is_unlock then
        if last_group then
          if last_group == group_id then
            default_show_group = group_id
          end
        else
          last_show_group = group_id
        end
      end
      self.v_group_obj_list[group_id] = obj
    end
  end
  local first_show_group = default_show_group or last_show_group
  self:on_click_group_button(first_show_group)
end

function ui:refresh_group_select()
  local select_obj, redpoint
  local select_name = "Select"
  local redpoint_name = "RedPoint"
  for group_id, obj in pairs(self.v_group_obj_list) do
    select_obj = self:get_child_gameobj(select_name, obj)
    if group_id == self.v_group_id then
      redpoint = self:get_child_gameobj(redpoint_name, obj)
      self:check_group_red(group_id)
      redpoint:SetActive(false)
      select_obj:SetActive(true)
    else
      select_obj:SetActive(false)
    end
  end
end

function ui:refresh_point_detail()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.StageDesc_txt.text = point_cfg.PointDesc
  ResMgr:load_set_icon(self.v_uicompents.StageIcon_img, point_cfg.PointBgPath, nil, true)
  local show_zhanli = point_cfg.RecomFightVal ~= nil and point_cfg.RecomFightVal >= 0
  if show_zhanli then
    self.v_uicompents.ZhanliNow_txt.text = point_cfg.RecomFightVal
  end
  self.v_uiobjects.Now:SetActive(show_zhanli)
  self.v_uiobjects.BtnQuickFight:SetActive(Util.is_more_than_zero(ring_cfg.FastChallengeId))
  self.v_uiobjects.BtnFile:SetActive(Util.is_more_than_zero(ring_cfg.SaveId))
  self.v_enemyPreviewList = point_cfg.EnemyPreviewList
  self.v_uicompents.BtnDifficultyDropText_txt.text = ring_cfg.DifficultyText
  local has_end_time = Util.is_more_than_zero(ring_cfg.EndTime)
  if has_end_time then
    local end_time = Date.get_time_stamp_by_scheme_id(ring_cfg.EndTime)
    if end_time then
      local remain_time = end_time - Date.server_time()
      self.v_uicompents.Time_txt.text = Date.get_time_formate_2(remain_time)
      if remain_time > 0 and remain_time <= 3600 then
        self:clear_point_end_timer()
        self.v_point_end_timer = Global.ct_timer:add_timer(nil, remain_time + 60, self.refresh_point_end_time, self, end_time)
      end
    else
      has_end_time = false
    end
  end
  self.v_uiobjects.TimeTag:SetActive(has_end_time)
  self:refresh_story_select_item()
  self:refresh_box_state()
  self:refresh_destiny_level()
  self:set_bg_node()
end

function ui:refresh_destiny_drop()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  local show_drop_btn = false
  if ring_cfg.DestinyLevelDropType == Config.CommonDefine.CURSE_DROP_TYPE.SELECT_DROP then
    local destiny_group_cfg = ShareRes.get_curse_destiny_level_select_drop(ring_cfg.DestinyLevelDrop)
    show_drop_btn = destiny_group_cfg and not UtilTable.is_empty(destiny_group_cfg)
    if show_drop_btn then
      local has_choosed = false
      local select_index = ChallengeRingPlusMgr:get_destiny_drop_index(self.v_config_id)
      if select_index and ChallengeRingPlusMgr:get_destiny_drop_state(self.v_ring_id, select_index) == DESTINY_DROP_STATE.END then
        select_index = nil
      end
      local destiny_cfg = select_index and destiny_group_cfg[select_index] or nil
      if destiny_cfg then
        has_choosed = true
        local result = {}
        ShareRes.get_item_obj_use_award_list(destiny_cfg.ShowAwardId, result, function(award_cfg, index)
          local data = {
            id = award_cfg.ItemId,
            count = award_cfg.Num,
            limit = award_cfg.Limit
          }
          return data
        end)
        local first_result = result[1]
        if first_result then
          local item = ITEM_OBJ_COM:ui_wrap_ex(self, self.v_uiobjects.PuzzleIcon, true)
          item:set_data(first_result)
          self.v_item_list[#self.v_item_list + 1] = item
        end
      end
      local show_red = ChallengeRingPlusMgr:get_destiny_drop_group_red(self.v_config_id)
      self.v_uiobjects.BtnAwardChooseRedPoint:SetActive(show_red)
      self.v_uiobjects.PuzzleUnChoose:SetActive(not has_choosed)
      self.v_uiobjects.PuzzleChoosed:SetActive(has_choosed)
    end
  end
  self.v_uiobjects.BtnAwardChoose:SetActive(show_drop_btn)
  self.v_uiobjects.PuzzleChoose:SetActive(show_drop_btn)
end

function ui:refresh_story_select_item()
  local cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  self:remove_all_story_select_item()
  local is_pass = ChallengeRingPlusMgr:check_ring_is_pass(self.v_config_id)
  self.v_uiobjects.BtnStoryDrop:SetActive(cfg.StoryID ~= nil and nil ~= next(cfg.StoryID) and is_pass)
  if not cfg.StoryID then
    return
  end
  local data
  for index, story_id in ipairs(cfg.StoryID) do
    data = {}
    local obj = self:get_auto_cache(FATE_SELECT_ITEM)
    local item = SELECT_ITEM:ui_wrap(self, obj, true)
    data.text = Util.format_str("片段{1}", index)
    
    function data.cb()
      StoryMgr:on_start(story_id)
    end
    
    data.type = Config.SELECT_ITEM_TYPE.STORY_SNIPPET
    item:set_data(data)
    table.insert(self.v_select_story_item_list, item)
  end
end

function ui:refresh_redpoint()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TaskRedPoint, RedEnum.CURSE_COURSE_ENTER)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TreeRedPoint, RedEnum.CURSE_SKILL_TREE_ENTER)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local task_group_id = main_cfg.WeekTaskGroup
  local is_red = Util.is_more_than_zero(task_group_id) and TaskMgr:get_task_group_red(task_group_id)
  is_red = is_red or ChallengeRingPlusMgr:get_task_id_red()
  self.v_uiobjects.Task1RedPoint:SetActive(is_red)
end

function ui:refresh_story_entrance()
  local is_unlock, check_type
  local cur_type = self.v_show_point_type
  if cur_type == Config.FATE_POINT_TYPE.STORY then
    self.v_uiobjects.BtnChangeType:SetActive(false)
    self.v_uiobjects.ChangeTypeLock:SetActive(true)
    return
  end
  local is_check_pass = false
  if cur_type == Config.FATE_POINT_TYPE.POINT then
    check_type = Config.FATE_POINT_TYPE.HARD
  elseif cur_type == Config.FATE_POINT_TYPE.HARD then
    check_type = Config.FATE_POINT_TYPE.STORY
  end
  local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(check_type)
  if group_ids then
    for key, group_id in pairs(group_ids) do
      if is_check_pass then
        local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
        for key, config_id in pairs(config_ids) do
          if ChallengeRingPlusMgr:check_ring_is_pass(config_id) then
            is_unlock = true
            break
          end
        end
      elseif ChallengeRingPlusMgr:check_group_has_ring_open(group_id) then
        is_unlock = true
        break
      end
      if is_unlock then
        break
      end
    end
  else
    is_unlock = false
  end
  self.v_uiobjects.BtnChangeType:SetActive(is_unlock)
  self.v_uiobjects.ChangeTypeLock:SetActive(not is_unlock)
end

function ui:refresh_destiny_level()
  local cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  if cfg.DestinyLevelDrop and not cfg.IsQuickFight then
    self.v_uiobjects.BtnFateLv:SetActive(true)
    local destiny_level = ChallengeRingPlusMgr:get_ring_destiny_level(self.v_config_id)
    local max_level = cfg.MaxDestinyLevel
    self.v_uicompents.FateLv_txt.text = string.format("(%d/%d)", destiny_level, max_level)
    ResMgr:load_set_icon(self.v_uicompents.FateIcon_img, cfg.IconPath)
  else
    self.v_uiobjects.BtnFateLv:SetActive(false)
  end
  local is_start, activity_id = NoviceMgr:is_double_challenge_start(Config.CommonDefine.DOUBLE_TYPE.FATEBOOK)
  local multi_obj = Util.get_child_gameobj("Multi", self.v_uiobjects.BtnFateLv)
  local quick_multi_obj = Util.get_child_gameobj("Multi", self.v_uiobjects.BtnQuickFight)
  multi_obj:SetActive(is_start)
  quick_multi_obj:SetActive(is_start)
  if is_start then
    local multi_times_txt = Util.get_text("MultiTimes", multi_obj)
    local quick_multi_times_txt = Util.get_text("MultiTimes", quick_multi_obj)
    multi_times_txt.text = ShareRes.get_double_challenge_cfg(activity_id).Double .. "倍"
    quick_multi_times_txt.text = ShareRes.get_double_challenge_cfg(activity_id).Double .. "倍"
  end
end

function ui:reset_treasure_progress()
  local award_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  local cur_num, need_num = BagMgr:get_item_num(award_cfg.ResetItemId), award_cfg.ResetItemCount
  local item_name = ShareRes.get_item_name(award_cfg.ResetItemId)
  if cur_num - need_num < 0 then
    local cost_id = COST_ID
    local lack_cnt = need_num - cur_num
    local exchange_config = CharacterMgr:get_exchange_config_by_target_id(Config.EXCHANGE_TYPE.DEFAULT, cost_id)
    local exchange_cost_id = exchange_config.Material[1]
    local exchange_cost_cnt = exchange_config.Num[1] * lack_cnt
    UIMgr:get_ui("uidrawcard_recharge"):ui_show(cost_id, lack_cnt, exchange_cost_id, exchange_cost_cnt, nil, nil, function()
      CharacterMgr:request_exchange_item(exchange_config.Id, lack_cnt)
    end)
    local str = string.format("【%s】数量不足", item_name)
    local content = Util.format_str(str)
    UIMgr:get_ui("uimessagetip"):ui_show(content)
    return
  end
  
  local function first_sure_cb()
    local function second_sure_cb()
      self.v_uicompents.Btn_ResetAward_btn.enabled = false
      
      ChallengeRingPlusMgr:reset_box_progress(self.v_point_id)
    end
    
    local data = ChallengeRingPlusMgr:get_ring_data(self.v_config_id)
    if data.pass_flooridx < 1 then
      local tip = Util.format_str("检测到所有宝箱均未达成领取条件\n是否确认重置")
      UIMgr:get_ui("uinotice_tips"):ui_show(second_sure_cb, nil, tip, Util.format_str("确定"), Util.format_str("取消"))
    else
      second_sure_cb()
    end
  end
  
  local tip = Util.format_str(string.format("【%s*%d】重置本难度的进度奖励，是否确认？", item_name, need_num))
  UIMgr:get_ui("uinotice_tips"):ui_show(first_sure_cb, nil, tip, Util.format_str("确定"), Util.format_str("取消"))
end

function ui:refresh_box_state()
  local data = ChallengeRingPlusMgr:get_ring_data(self.v_config_id)
  local cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  if not cfg.RingReward or not next(cfg.RingReward) then
    self.v_uiobjects.Award:SetActive(false)
    return
  end
  self.v_uiobjects.Award:SetActive(true)
  local max_award_count = #cfg.RingReward
  self.v_uicompents.ProgressNow_txt.text = data and data.pass_flooridx or 0
  self.v_uicompents.ProgressMax_txt.text = max_award_count
  self.v_uicompents.Btn_ResetAward_btn.enabled = ChallengeRingPlusMgr:check_ring_is_unlock(self.v_config_id)
  self.v_uiobjects.Btn_ResetAward:SetActive(Util.is_more_than_zero(cfg.IfReset))
  local episode_id = self.v_point_id
  self:give_back_auto_cache(CHALLENGE_RING_RING_BOX_ITEM_KEY)
  local count = 0
  local bar_rect = self.v_uicompents.AwardBar_rect
  local width = bar_rect.sizeDelta.x
  self.v_start_box_pos = self.v_start_box_pos or self.v_uicompents.AwardTem_rect.anchoredPosition
  local is_get, complete
  for index, ring_reward in ipairs(cfg.RingReward) do
    is_get = nil ~= data and 1 == (data.bit >> index - 1) % 2
    complete = nil ~= data and index <= data.pass_flooridx
    local state
    if not complete then
      state = CURSE_BOX_STATE.LOCK
    elseif not is_get then
      state = CURSE_BOX_STATE.FINISH
    else
      state = CURSE_BOX_STATE.GET_AWARD
    end
    local box_item = self:get_auto_cache(CHALLENGE_RING_RING_BOX_ITEM_KEY)
    local box_item_rect = Util.get_rect_transform(nil, box_item)
    local pos = Vec3.Clone(self.v_start_box_pos)
    pos.x = pos.x + (index - 1) / (max_award_count - 1) * width
    box_item_rect:SetAnchoredPositionA(pos.x, pos.y, pos.z)
    local award_btn = self:get_button(nil, box_item)
    self:set_button_listener(award_btn, function()
      local str = Util.format_str(string.format("第%d层奖励", index))
      
      local function get_award_func()
        ChallengeRingPlusMgr:get_ring_box_award(episode_id, index)
      end
      
      UIMgr:get_ui("ui_award_tips_com"):ui_show(str, cfg.RingReward[index], state, get_award_func)
    end)
    local complete_obj = self:get_child_gameobj("Complete", box_item)
    local complete_pd = self:get_child_gameobj("CompletePd", complete_obj)
    local received_obj = self:get_child_gameobj("Received", box_item)
    local redpoint_obj = self:get_child_gameobj("Redpoint", box_item)
    redpoint_obj:SetActive(not is_get and complete)
    complete_obj:SetActive(complete)
    complete_pd:SetActive(not is_get and complete)
    received_obj:SetActive(is_get)
    if complete then
      count = count + 1
    end
  end
  local rect = self.v_uicompents.AwardBarFill_rect
  self.v_max_bar_len = self.v_max_bar_len or rect.sizeDelta.x
  local factor = (count - 1) / (max_award_count - 1)
  rect.sizeDelta = Vec2.New(self.v_max_bar_len * factor, rect.sizeDelta.y)
  self.v_uicompents.ProgressNow_txt.text = count
  self.v_uicompents.ProgressMax_txt.text = max_award_count
  if Util.is_more_than_zero(cfg.IfReset) then
    self.v_uicompents.CurrNum_txt.text = cfg.ResetItemCount
    local resetItem_id = cfg.ResetItemId
    local path = UtilUI.get_item_icon(resetItem_id)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, path)
  end
  ASSET_ITEM[3] = COST_ID
  local asset_config = SHOP_HELPER.get_asset_list(ASSET_ITEM)
  asset_config[3].func = "_onclick_fate_book_tickets"
  self.v_asset_bar:reset_config(asset_config)
  self.v_asset_bar:on_create()
end

function ui:refresh_enemy_preview(enemyPreviewList)
  if not enemyPreviewList then
    return
  end
  if self.v_enemy_preview_item_list[1] and self.v_enemy_preview_item_list[1].v_object_transform:IsNull() then
    self:remove_wrap_ui_list(self.v_enemy_preview_item_list)
    self.v_enemy_preview_item_list = {}
  end
  self:give_back_auto_cache(ENEMY_PREVIEW_ITEM)
  for index, enemyID in ipairs(enemyPreviewList) do
    if index > 3 then
      return
    end
    local obj = self:get_auto_cache(ENEMY_PREVIEW_ITEM)
    if index > #self.v_enemy_preview_item_list then
      local enemy_preview_item = ENEMYPREVIEWITEM:ui_wrap_ex(self, obj, true)
      table.insert(self.v_enemy_preview_item_list, enemy_preview_item)
      self:set_button_listener(Util.get_button(nil, obj), function()
        self:on_click_enemy_preview_item(index)
      end)
    end
    self.v_enemy_preview_item_list[index]:set_data(enemyID)
  end
end

function ui:refresh_multi_point()
end

function ui:refresh_award_content()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  self:clear_item_list()
  if ring_cfg.PreviewAwardGroupID then
    self.v_uiobjects.AwardShow:SetActive(true)
    local award_list = self:get_award_item_list(ring_cfg.PreviewAwardGroupID)
    self.v_uicompents.AwardShowContent_rect:SetAnchoredPositionA(0, self.v_uicompents.AwardShowContent_rect.anchoredPosition.y)
    for _, data in ipairs(award_list) do
      local obj = self:get_auto_cache(DESTINY_LEVEL_AWARD)
      local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
      item:set_data(data)
      self.v_item_list[#self.v_item_list + 1] = item
    end
  else
    self.v_uiobjects.AwardShow:SetActive(false)
  end
  if ring_cfg.DestinyLevelDrop then
    ResMgr:load_set_icon(self.v_uicompents.FateIcon_img, ring_cfg.IconPath)
  end
end

function ui:get_award_item_list(award_group_id)
  local a_item_cfg, b_item_cfg
  local award_list = {}
  ShareRes.get_item_obj_use_award_list(award_group_id, award_list, function(award_cfg, index)
    local temp = {
      ItemId = award_cfg.ItemId,
      Num = award_cfg.Num,
      Name = Item_Helper.get_item_cfg(award_cfg.ItemId).Name,
      Limit = award_cfg.Limit,
      cb = function()
        self:on_click_fate_btn()
      end
    }
    return temp
  end)
  table.sort(award_list, function(a, b)
    a_item_cfg, b_item_cfg = Item_Helper.get_item_cfg(a.ItemId), Item_Helper.get_item_cfg(b.ItemId)
    if a_item_cfg.Quality ~= b_item_cfg.Quality then
      return a_item_cfg.Quality > b_item_cfg.Quality
    elseif a.ItemId ~= b.ItemId then
      return a.ItemId < b.ItemId
    else
      return false
    end
  end)
  return award_list
end

function ui:check_group_red(group_id)
  return ChallengeRingPlusMgr:check_group_is_red(group_id)
end

function ui:_reset_box_compplete()
  self.v_uicompents.Btn_ResetAward_btn.enabled = true
  self:refresh_box_state()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_show_point_type, true
end

function ui:remove_all_story_select_item()
  self:give_back_auto_cache(FATE_SELECT_ITEM)
  for key, item in pairs(self.v_select_story_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_select_story_item_list[key] = nil
  end
end

function ui:remove_all_point_select_item()
end

function ui:check_have_ring_award()
  if not self.v_config_id then
    return
  end
  local data = ChallengeRingPlusMgr:get_ring_data(self.v_config_id)
  local cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  local is_not_get
  for index, ring_reward in ipairs(cfg.RingReward) do
    is_not_get = nil == data or 1 ~= (data.bit >> index - 1) % 2
    if is_not_get then
      return false
    end
  end
  return true
end

function ui:get_first_point_id_and_ring_id()
  local ring_id, point_id
  local max_index = #self.v_config_ids
  for i = max_index, 1, -1 do
    if ChallengeRingPlusMgr:check_ring_is_unlock(self.v_config_ids[i], false) or 1 == i then
      ring_id = self.v_config_ids[i]
      break
    end
  end
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  point_id = ring_cfg.EpisodeId
  return ring_id, point_id
end

function ui:clear_item_list()
  self:give_back_auto_cache(DESTINY_LEVEL_AWARD)
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[key] = nil
  end
end

function ui:change_multi_difficulty_root_active(active)
  self.v_dif_root_active = active
end

function ui:set_bg_node()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_config_id)
  local is_hard = ring_cfg.DifficultyNum >= curse_com_def.HARD_DIFFICULTY_NUM
  self.v_uiobjects.BgHard:SetActive(is_hard)
  self.v_uiobjects.BgEasy:SetActive(not is_hard)
end

function ui.refresh_point_end_time(_, self, end_time)
  if not self:visible() then
    self:clear_point_end_timer()
    return
  end
  local remain_time = end_time - Date.server_time()
  if remain_time <= 0 then
    self:clear_point_end_timer()
    self:try_change_type(Config.FATE_POINT_TYPE.POINT)
  else
    self.v_uicompents.Time_txt.text = Date.get_time_formate_2(end_time - Date.server_time())
  end
end

function ui:clear_point_end_timer()
  if self.v_point_end_timer then
    Global.ct_timer:remove_timer(self.v_point_end_timer)
    self.v_point_end_timer = nil
  end
end

return ui
