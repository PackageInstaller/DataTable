local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local Char_Helper = require("uimodule.character.char_helper")
local CURSE_RING_CURRENCY_MAIN = 29
local MAX_CHAR_ITEM_COUNT = Config.MAX_CHAR_ITEM_COUNT
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local ASSET_ITEM = {4, 11}
local SHOP_HELPER = require("uimodule.shop.shop_helper")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")

local function sort(a, b)
  if a.pos ~= b.pos then
    return a.pos < b.pos
  else
    return false
  end
end

function ui:on_click_fate_btn()
  if not self.v_progress then
    return
  end
  local fate_book_level_tips = UIMgr:get_ui("fate_book_level_tips")
  fate_book_level_tips:set_hide_cb(function()
    self:refresh_destiny_level()
  end)
  fate_book_level_tips:ui_show(self.v_ring_id, self.v_progress, self.v_get_new_ring_data_suc)
end

function ui:on_click_BtnSaveFile()
  local fate_book_file = UIMgr:get_ui("fate_book_file")
  fate_book_file:ui_show(curse_com_def.FILE_VIEW_STATE.SETTLE, self.v_ring_id)
end

function ui:on_click_settle_btn()
  local function confirm_cb()
    local callback
    
    self.v_progress = nil
    if SceneMgr:check_main_scene() then
      self:ui_hide()
    else
      function callback()
        Global.scene_mgr:on_enter_main_scene()
        
        UIMgr:revert_cache_ui()
      end
    end
    if self.v_is_get_award or not Util.is_more_than_zero(TowerMgr:get_cur_point_id()) then
      if callback then
        callback()
      end
    else
      TowerMgr:get_fight_reward(callback)
    end
  end
  
  local save_id = self.v_ring_cfg and self.v_ring_cfg.SaveId
  local has_temp_data = nil ~= save_id and nil ~= FateBookMgr:get_fate_book_temp_save_data(save_id)
  if has_temp_data and not FateBookMgr:check_fate_book_has_file_data(save_id) then
    Util.show_conform_tip("未保存存档，是否退出", nil, nil, nil, confirm_cb)
  else
    confirm_cb()
  end
end

function ui:on_show_ui(msg)
end

function ui:on_hide_ui(msg)
end

function ui:ui_finish_load()
  local asset_config = SHOP_HELPER.get_asset_list(ASSET_ITEM)
  asset_config[2].func = "_onclick_fate_book_tickets"
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
  self:set_button("BtnClose", function()
    self:on_click_settle_btn()
  end)
  self:set_button("BtnFateLv", function()
    self:on_click_fate_btn()
  end)
  self:set_button("BtnSaveFile", function()
    self:on_click_BtnSaveFile()
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

function ui:on_ring_data_update()
  self.v_get_new_ring_data_suc = true
  self:refresh_destiny_level()
end

function ui:ui_on_show(fight_state, cache_progress)
  self.v_after_award_panel_check_destiny = false
  self:bind_auto_mq(Const.MSG_ON_RING_DATA_UPDATE, self.on_ring_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.on_show_ui, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.on_hide_ui, self)
  self:bind_auto_mq(Const.MSG_ON_CURSE_SAVE_DATA_UPDATE, self.refresh_view, self)
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self.v_state = fight_state
  self.v_all_die = fight_state == CHAPTER_CONFIG.POINTSTATE.all_die
  local progress = cache_progress or TowerMgr:get_tower_progress()
  self.v_progress = progress
  self.v_ring_id = ShareRes.get_ring_id_by_point_id(self.v_progress.episode_id)
  self.v_ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  self.v_asset_bar:on_create()
  self:refresh_view()
end

function ui:refresh_view()
  self:refresh_point_info()
  self:refresh_player_info()
  self:refresh_award()
  self:check_need_get_award()
  self:refresh_destiny_level()
  self:refresh_save_file_btn()
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

function ui:refresh_point_info()
  local point_id = self.v_progress.episode_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.FloorNum_txt.text = self.v_progress.floor_id
  local path = UtilUI.get_item_icon(CURSE_RING_CURRENCY_MAIN)
  ResMgr:load_set_icon(self.v_uicompents.Item29Icon_img, path)
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

function ui:refresh_award()
  if self.v_is_get_award or self.v_is_refresh_award then
    return
  end
  self.v_is_refresh_award = true
  local has_tower = TowerMgr:get_tower() ~= nil
  
  local function refresh_cb(ok, resp, tower_info)
    tower_info = tower_info or resp.tower_info
    local curse_data = tower_info.curse_tower_data
    if curse_data then
      self.v_uicompents.CardNum_txt.text = has_tower and ChallengeRingPlusMgr:get_round_cnt() or curse_data.fight_round
      self.v_uicompents.TalentNum_txt.text = curse_data.ability_count or 0
      self.v_uicompents.OrnNum_txt.text = curse_data.ornament_count or 0
      local item29_count = 0
      for key, data in pairs(tower_info.battle_exchange_item) do
        if data.id == CURSE_RING_CURRENCY_MAIN then
          item29_count = data.count + item29_count
          break
        end
      end
      if item29_count > 0 then
        self.v_uicompents.Item29Num_txt.text = "+" .. item29_count
        self.v_uiobjects.Item29:SetActive(true)
      else
        self.v_uiobjects.Item29:SetActive(false)
      end
      self:refresh_hero_item(curse_data)
    end
  end
  
  local point_id = self.v_progress.episode_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uiobjects.Item29:SetActive(false)
  TowerMgr:req_tower_info(point_cfg.FightId, refresh_cb)
end

function ui:check_need_get_award()
  local progress = TowerMgr:get_tower_progress()
  if progress and Util.is_more_than_zero(progress.episode_id) then
    local _, _, reborn_cost_id = TowerMgr:get_reborn_cost()
    local save_id = self.v_ring_cfg and self.v_ring_cfg.SaveId
    local has_temp_data = nil ~= save_id and nil ~= FateBookMgr:get_fate_book_temp_save_data(save_id)
    if not has_temp_data and not self.v_all_die and not TowerMgr:can_archieve() and not Util.is_more_than_zero(reborn_cost_id) then
      TowerMgr:get_fight_reward()
      self.v_is_get_award = true
    end
  end
end

function ui:refresh_save_file_btn()
  self.v_uiobjects.BtnSaveFile:SetActive(self.v_ring_cfg.SaveId ~= nil and nil ~= FateBookMgr:get_fate_book_temp_save_data(self.v_ring_cfg.SaveId))
end

function ui:refresh_destiny_level()
  local cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  if cfg.DestinyLevelDrop and not cfg.IsQuickFight then
    ResMgr:load_set_icon(self.v_uicompents.FateIcon_img, cfg.IconPath)
    self.v_uiobjects.BtnFateLv:SetActive(true)
    local destiny_level = self:get_destiny_level()
    local max_level = cfg.MaxDestinyLevel
    self.v_uicompents.FateLv_txt.text = string.format("(%d/%d)", destiny_level, max_level)
  else
    self.v_uiobjects.BtnFateLv:SetActive(false)
  end
end

function ui:refresh_hero_item(curse_data)
  local hero_list = self.v_progress and self.v_progress.battle_buddy_data
  hero_list = hero_list or curse_data and curse_data.buddy_list
  if not hero_list then
    for index = 1, MAX_CHAR_ITEM_COUNT do
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
    return
  end
  local main_pos
  if not SceneMgr:check_main_scene() and not SceneMgr:global_hero_is_destroyed() then
    main_pos = Global.hero:get_team_pos()
  else
    main_pos = curse_data.main_pos or 1
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

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
  self.v_asset_bar:on_destory()
end

function ui:get_destiny_level()
  local destiny_level
  if self.v_get_new_ring_data_suc then
    destiny_level = ChallengeRingPlusMgr:get_ring_destiny_level(self.v_ring_id)
  else
    destiny_level = ChallengeRingPlusMgr:get_ring_destiny_level(self.v_ring_id)
    local all_cfg = ShareRes.get_curse_destiny_level_cfg()
    local pass_floor_id = self.v_progress and self.v_progress.pass_floor_id or 0
    local cfg
    for floor_id = 1, pass_floor_id do
      cfg = all_cfg[floor_id]
      if cfg then
        destiny_level = destiny_level + (cfg.Grade or 0)
      end
    end
    self.v_ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
    if self.v_ring_cfg.MaxDestinyLevel then
      destiny_level = math.min(destiny_level, self.v_ring_cfg.MaxDestinyLevel)
    end
  end
  return destiny_level
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_state, self.v_progress
end

return ui
