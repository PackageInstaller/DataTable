local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local WEEKLY_PVP_STAGE_ITEM = require("uimodule.weekly.weekly_pvp_stage_item")
local ENEMYPREVIEWITEM = require("uimodule.ui_common_item.enemy_preview_item")
local WEEKLY_PVP_STAGE_TEAM_ITEM_KEY = "WEEKLY_PVP_STAGE_TEAM_ITEM_KEY"
local WEEKLY_PVP_STAGE_TARGET_ITEM_KEY = "WEEKLY_PVP_STAGE_TARGET_ITEM_KEY"
local MAX_STAGE_COUNT = 6
local STAGE_STR = "Stage"
local EFFECT_NAME = "Effect"
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")

function ui:on_select_episode(episode_id)
  if self.v_select_episode_id == episode_id then
    return
  end
  local data = WeeklyMgr:get_weekly_hurdle_data(episode_id, true)
  if not data.is_open then
    Util.show_message_tip(2067)
    return
  end
  self.v_select_episode_id = episode_id
  for key, item in pairs(self.v_stage_item_list) do
    item:on_select_episode(episode_id)
  end
  self:move_target_item()
  self:set_episode_info_visible(true)
  self:refresh_episode_info()
end

function ui:on_click_full_btn()
  self:set_episode_info_visible(false)
  self:clear_select_data()
end

function ui:click_stage_rule_btn()
  UIMgr:get_ui("weekly_rule"):ui_show(true)
end

function ui:on_click_fight_btn()
  if Game_AssetBundle and DownloadMgr and not DownloadMgr:check_res_is_integrity() then
    local msg = "资源不完整，是否前往下载所有资源"
    Util.show_notify_popup_message(function()
      UIMgr:get_ui("battle_setting"):ui_show(Setting_Cfg.PageTag.Download)
    end, msg, "提示", "确定", "取消", nil, false)
    return
  end
  if TowerMgr:check_fight_progress() then
    return
  end
  if not self.v_select_episode_id then
    return
  end
  local data = WeeklyMgr:get_weekly_hurdle_data(self.v_select_episode_id, true)
  if not data.is_open then
    Util.show_message_tip(2067)
    return
  end
  WeeklyMgr:start_pvp_fight(self.v_select_episode_id)
  local ui_name = "weekly_pvp_stage"
  UIMgr:set_main_scene_after_load_ui(ui_name)
  self.v_uiobjects.NoClick:SetActive(true)
end

function ui:on_click_emeny_btn()
  self:on_click_enemy_preview_item(1)
end

function ui:on_click_enemy_preview_item(selectIdx)
  if not self.v_enemyPreviewList then
    return
  end
  UIMgr:get_ui("enemy_info_tips"):ui_show(selectIdx, self.v_enemyPreviewList)
end

function ui:init_effect_obj()
  self.v_effect_obj_map = {}
  local all_cfg = ShareRes.create("buddy.buddy_element")
  local effect_name, effect_obj
  for key, cfg in pairs(all_cfg) do
    effect_name = EFFECT_NAME .. cfg.Id
    if self.v_uiobjects[effect_name] then
      effect_obj = self.v_uiobjects[effect_name]
      self.v_effect_obj_map[cfg.Id] = self.v_effect_obj_map[cfg.Id] or {}
      table.insert(self.v_effect_obj_map[cfg.Id], effect_obj)
    end
  end
end

function ui:ui_finish_load()
  self:init_effect_obj()
  self:set_button("BtnEnemyShow", function()
    self:on_click_emeny_btn()
  end)
  self:set_button("BtnFight", function()
    self:on_click_fight_btn()
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("FullBtn", function()
    self:on_click_full_btn()
  end)
  self:set_button("BtnRule", function()
    self:click_stage_rule_btn()
  end)
  self:set_button("BtnEffectDetail", function()
    local group_cfg = ShareRes.get_weekly_pvp_epi_pool_cfg(WeeklyMgr:get_cur_stage_episode_group_id())
    UIMgr:get_ui("weekly_pvp_stage_tip"):ui_show(group_cfg.StageDesc)
  end)
  self.v_stage_item_list = {}
  self.v_scv = self:get_scrollrect(nil, self.v_uiobjects.ScrollView).component
  self.v_enemy_preview_item_list = {}
  self:register_exist_auto_template(WEEKLY_PVP_STAGE_TEAM_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.CharListTemp)
  self:register_exist_auto_template(WEEKLY_PVP_STAGE_TARGET_ITEM_KEY, self.v_uiobjects.TargetTem, self.v_uiobjects.TargetContent)
end

function ui:ui_on_show()
  self.v_uiobjects.NoClick:SetActive(false)
  UIMgr:remove_stace_by_ui_name("team")
  self:set_episode_info_visible(false)
  self:refresh_episode_view()
  self:refresh_remain_time()
  self:refresh_content_pos()
  self:refresh_stage_name()
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_UPDATE_PVP_SEGMENT, self.update_player_data, self)
  self:update_player_data()
end

function ui:ui_on_hide()
  self.v_select_episode_id = nil
  self:remove_stage_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_remain_time()
  local remain_time = WeeklyMgr:get_pvp_remaining_time()
  if not remain_time or remain_time < 0 then
    self.v_uicompents.Time_txt.text = "已结束"
    return
  end
  if remain_time <= 3600 then
    self:refresh_remain_timer(remain_time)
  else
    self:refresh_remain_text(remain_time)
  end
end

function ui:refresh_remain_timer(remain_time)
  self:remove_timer()
  self.v_remian_timer = Global.ct_timer:add_timer("weekly_remain_timer", remain_time, function(time)
    self:refresh_remain_text(time)
  end)
end

function ui:refresh_remain_text(remain_time)
  if remain_time <= 0 then
    self:remove_timer()
    self.v_uicompents.Time_txt.text = "已结束"
    return
  end
  local show_desc = Date.get_time_desc(remain_time)
  self.v_uicompents.Time_txt.text = show_desc
end

function ui:remove_timer()
  if self.v_remian_timer then
    Global.ct_timer:remove_timer(self.v_remian_timer)
    self.v_remian_timer = nil
  end
end

function ui:refresh_episode_view()
  self:remove_stage_item()
  local target_stage = WeeklyMgr:get_weekly_stage()
  local data = WeeklyMgr:get_stage_data(target_stage)
  self:check_is_new_season(data)
  local stage_obj, stage_str
  local show_count = 0
  local item
  if not data.epi_data then
    return
  end
  for index, episode_data in pairs(data.epi_data) do
    stage_str = STAGE_STR .. episode_data.epi_index
    stage_obj = self.v_uiobjects[stage_str]
    if not stage_obj then
      Log.Error("周常关卡索引异常，索引为：", episode_data.epi_index)
      return
    end
    item = WEEKLY_PVP_STAGE_ITEM:ui_wrap_ex(self, stage_obj, true)
    item:set_data(episode_data)
    self.v_stage_item_list[episode_data.epi_id] = item
    show_count = show_count + 1
  end
  self:set_stage_active_visible(show_count)
end

function ui:check_is_new_season(data)
  local is_new_season = data.is_new
  local history_max_star = data.history_max_star
  if is_new_season and history_max_star then
    if history_max_star > 0 then
      UIMgr:get_ui("weekly_skip_stage"):ui_show(data)
    end
    WeeklyMgr:set_week_new_season_read(0, data.epi_stage)
  else
    local curr_star = WeeklyMgr:get_pvp_curr_star()
    local is_can_receive = WeeklyMgr:get_star_award_red_state()
    if data.is_pop_reward and curr_star >= 3 and is_can_receive then
      UIMgr:get_ui("weekly_pvp_star_award"):ui_show()
      WeeklyMgr:set_week_new_season_read(1, data.epi_stage)
    end
  end
end

function ui:set_stage_active_visible(show_count)
  if show_count < MAX_STAGE_COUNT then
    local stage_obj, stage_str
    for index = show_count + 1, MAX_STAGE_COUNT do
      stage_str = STAGE_STR .. index
      stage_obj = self.v_uiobjects[stage_str]
      stage_obj:SetActive(false)
    end
  end
end

function ui:set_episode_info_visible(visible)
  self.v_scv.enabled = not visible
  self.v_uiobjects.StageInfo:SetActive(visible)
  self.v_uiobjects.FullBtn:SetActive(visible)
  if visible then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.weekly_pvp_stage_info_UI_SOUND)
  end
end

function ui:refresh_episode_info()
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  local cfg = ShareRes.get_weekly_pvp_epi_cfg(self.v_select_episode_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_select_episode_id)
  local data = WeeklyMgr:get_weekly_hurdle_data(self.v_select_episode_id, true)
  coms.StageName_txt.text = cfg.EpiName
  local buff1, buff2 = cfg.BuffDesc[1], cfg.BuffDesc[2]
  coms.Buff1_txt.text = buff1
  coms.Buff2_txt.text = buff2
  objs.Buff1:SetActive(not Util.is_empty(buff1))
  objs.Buff2:SetActive(not Util.is_empty(buff2))
  coms.ZhanliNeed_txt.text = point_cfg and point_cfg.RecomFightVal
  self.v_enemyPreviewList = point_cfg.EnemyPreviewList
  self:refresh_enemy_info(self.v_enemyPreviewList)
  self:refresh_episode_hero_team()
  self:refresh_target(data)
end

function ui:refresh_enemy_info(enemyPreviewList)
  self:hide_all_enemytem()
  self.v_uiobjects.BtnEnemyShow:SetActiveEx(nil ~= enemyPreviewList)
  if not enemyPreviewList then
    return
  end
  for index, value in ipairs(enemyPreviewList) do
    if index > #self.v_enemy_preview_item_list then
      local obj = ResMgr:load_gameobj(Path.get_language_full_prefab_path("prefab/widget/EnemyTem_.prefab"), nil, nil)
      obj.transform:SetParent(self.v_uiobjects.EnemyList.transform, false)
      local enemytem_lua_obj = ENEMYPREVIEWITEM:ui_wrap_ex(self, obj, false)
      table.insert(self.v_enemy_preview_item_list, enemytem_lua_obj)
      local button_com = self:get_button(nil, obj)
      self:set_button_listener(button_com, function()
        self:on_click_enemy_preview_item(index)
      end)
    end
    self.v_enemy_preview_item_list[index]:set_data(value)
    self.v_enemy_preview_item_list[index].v_object:SetActive(true)
  end
end

function ui:refresh_episode_hero_team()
  local buddy_team = WeeklyMgr:get_pvp_stage_buddy_team()
  local pos_data
  local show_zhanli = 0
  if buddy_team then
    pos_data = {}
    for _, data in pairs(buddy_team) do
      pos_data[data.buddy_pos] = data
    end
  end
  self:give_back_auto_cache(WEEKLY_PVP_STAGE_TEAM_ITEM_KEY)
  local cur_zhanli
  for i = 1, 3 do
    local item = self:get_auto_cache(WEEKLY_PVP_STAGE_TEAM_ITEM_KEY)
    local data = pos_data and pos_data[i]
    local buddy_id
    if data then
      buddy_id = data.buddy_id
    end
    local char_icon_obj = Util.get_child_gameobj("CharIcon", item)
    local no_char_obj = Util.get_child_gameobj("NoChar", item)
    if buddy_id and 0 ~= buddy_id then
      no_char_obj:SetActive(false)
      char_icon_obj:SetActive(true)
      local img = Util.get_image("CharIcon", item)
      local path = CharacterMgr:get_buddy_icon_path(buddy_id, true)
      ResMgr:load_set_icon(img, path)
      cur_zhanli = CharacterMgr:get_buddy_combat_effectiveness(buddy_id, false, false)
      if show_zhanli < cur_zhanli then
        show_zhanli = cur_zhanli
      end
    else
      char_icon_obj:SetActive(false)
      no_char_obj:SetActive(true)
    end
  end
  self.v_uicompents.TeamZhanli_txt.text = show_zhanli
end

function ui:move_target_item()
  self:clear_sqeuence()
  if not self.v_select_episode_id then
    return
  end
  self.v_sequence = Util.create_sequence()
  local rect = self.v_stage_item_list[self.v_select_episode_id]:get_rect_transform()
  local scroll_tf = self.v_uiobjects.ScrollView.transform
  local rect_pos = rect.position
  local x, y, z = scroll_tf:GetInverseTransformPointA(rect_pos.x, rect_pos.y, rect_pos.z)
  local pos = self.v_uiobjects.Content.transform.localPosition
  pos.x = pos.x - x
  pos.x = pos.x + -200
  self.v_sequence:Join(self.v_uiobjects.Content.transform:DOLocalMove(pos, 0.25))
end

function ui:refresh_content_pos()
  if not self.v_init_pos_x then
    self.v_init_pos_x, self.v_init_pos_y = self.v_uiobjects.Content.transform:GetLocalPositionA3()
  end
  local target_stage = WeeklyMgr:get_weekly_stage()
  local info = WeeklyMgr:get_stage_data(target_stage)
  local open_count = 0
  for _, data in pairs(info.epi_data) do
    if data.is_open then
      open_count = open_count + 1
    end
  end
  local temp_num = open_count > 4 and -1000 or 0
  self.v_uiobjects.Content.transform:SetLocalPositionA(self.v_init_pos_x + temp_num, self.v_init_pos_y)
end

function ui:refresh_stage_name()
  local target_stage = WeeklyMgr:get_weekly_stage()
  local info = WeeklyMgr:get_stage_data(target_stage)
  local epi_group_id = info.epi_group_id
  local group_cfg = ShareRes.get_weekly_pvp_epi_pool_cfg(epi_group_id)
  self.v_uicompents.ExplorationArea_txt.text = group_cfg.StageName
end

function ui:hide_all_enemytem()
  for _, obj in ipairs(self.v_enemy_preview_item_list) do
    obj.v_object:SetActive(false)
  end
end

function ui:remove_stage_item()
  for key, item in pairs(self.v_stage_item_list) do
    item:ui_hide()
    self:remove_wrap_ui(item)
    self.v_stage_item_list[key] = nil
  end
end

function ui:clear_select_data()
  if not self.v_select_episode_id then
    return
  end
  self.v_select_episode_id = nil
  for key, item in pairs(self.v_stage_item_list) do
    item:on_select_episode()
  end
end

function ui:clear_sqeuence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:get_effect_obj(element_id)
  if self.v_effect_obj_map[element_id] then
    local obj, effect_objs
    effect_objs = self.v_effect_obj_map[element_id]
    local length = #effect_objs
    if length > 0 then
      obj = effect_objs[length]
      effect_objs[length] = nil
    else
      local effect_name = EFFECT_NAME .. element_id
      if self.v_uiobjects[effect_name] then
        obj = UnityGameObject.Instantiate(self.v_uiobjects[effect_name])
      end
    end
    return obj
  end
end

function ui:give_back_effect_obj(element_id, obj)
  if self.v_effect_obj_map[element_id] then
    table.insert(self.v_effect_obj_map[element_id], obj)
    obj.transform:SetParent(self.v_uiobjects.EffectRoot.transform)
  end
end

function ui:refresh_target(data)
  local conditions = ShareRes.get_point_star_condition(data.epi_id)
  self:give_back_auto_cache(WEEKLY_PVP_STAGE_TARGET_ITEM_KEY)
  if not conditions then
    return
  end
  for i = 1, #conditions do
    local item = self:get_auto_cache(WEEKLY_PVP_STAGE_TARGET_ITEM_KEY)
    local complete = Util.get_child_gameobj("Complete", item)
    local target_desc = Util.get_text("TargetDesc", item)
    local finished = false
    if data.epi_star then
      for _, condition_index in pairs(data.epi_star) do
        if condition_index == i then
          finished = true
          break
        end
      end
    end
    Util.set_color(target_desc, finished and "f5ede1" or "827e78")
    complete:SetActive(finished)
    target_desc.text = ShareRes.get_point_star_condition_desc(conditions[i])
  end
end

function ui:update_player_data()
  local pvp_player_data = WeeklyMgr:get_player_pvp_data()
  if self.v_pvp_player_data and pvp_player_data.periods > self.v_pvp_player_data.periods then
    local function confirmCb()
      UIMgr:go_to_main()
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(confirmCb, nil, "当前活动已结束，请返回主界面", nil, nil, nil, true)
  end
  self.v_pvp_player_data = pvp_player_data
end

return ui
