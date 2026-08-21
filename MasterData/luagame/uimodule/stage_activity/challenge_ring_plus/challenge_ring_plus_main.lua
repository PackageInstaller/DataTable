local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Shop_Helper = require("uimodule.shop.shop_helper")
local commonDef = require("cs_share.common_define")
local CURSE_BOX_STATE = commonDef.CURSE_BOX_STATE
local Act_ID = commonDef.ACTY_TYPE.CURSE_CIRCLE
local Challenge_Type = commonDef.CHALLENGE_TYPE.CURSE_CIRCLE
local icon_path_prefix = "Icon/item/%s"
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local _sformat = string.format
local AssetBarView = require("ui.asset_bar.asset_bar")
local CHALLENGE_RING_BLESS_POS_ITEM_KEY = "CHALLENGE_RING_BLESS_POS_ITEM_KEY"
local CHALLENGE_RING_RING_BOX_ITEM_KEY = "CHALLENGE_RING_RING_BOX_ITEM_KEY"
local STAGE_STATE = {LOCK = 1, UNLOCK = 2}
local ASSET_ITEM = {29, 28}
local _tinsert = table.insert
local Contribute_Item_Id = 28
local ONE_DAY_SEC = 86400
local ONE_HOUR_SEC = 3600
local ONE_MINUTE_SEC = 60
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_remain_time = {
    "RemainTime",
    BIND_TYPE.TEXT
  },
  v_stage_name1 = {
    "StageName",
    BIND_TYPE.TEXT
  },
  v_stage_name2 = {
    "StageName2",
    BIND_TYPE.TEXT
  },
  v_reward_reset_text = {
    "RewardReset",
    BIND_TYPE.TEXT
  },
  v_weekly_get_now = {
    "WeeklyGetNow",
    BIND_TYPE.TEXT
  },
  v_weekly_get_limit = {
    "WeeklyGetLimit",
    BIND_TYPE.TEXT
  },
  v_current_hold_item_num = {
    "CurrentHoldItemNum",
    BIND_TYPE.TEXT
  },
  v_bless_pos_content = {
    "BlessingPosContent",
    BIND_TYPE.OBJECT
  },
  v_bless_pos_tem = {
    "BlessingPosTem",
    BIND_TYPE.OBJECT
  },
  v_award_tem = {
    "AwardTem",
    BIND_TYPE.OBJECT
  },
  v_award_content = {
    "AwardContent",
    BIND_TYPE.OBJECT
  },
  v_award_bar_fill = {
    "AwardBarFill",
    BIND_TYPE.OBJECT
  },
  v_award_bar = {
    "AwardBar",
    BIND_TYPE.OBJECT
  },
  v_difficulty_lock = {
    "Lock",
    BIND_TYPE.OBJECT
  },
  v_unlock_condition = {
    "UnlockCondition",
    BIND_TYPE.TEXT
  },
  v_fight_lock = {
    "FightLock",
    BIND_TYPE.OBJECT
  },
  v_fight_lock_btn = {
    "FightLock",
    BIND_TYPE.BUTTON
  },
  v_btn_resetaward = {
    "Btn_ResetAward",
    BIND_TYPE.BUTTON
  },
  v_curr_icon = {
    "CurrIcon",
    BIND_TYPE.IMAGE
  },
  v_curr_num = {
    "CurrNum",
    BIND_TYPE.TEXT
  },
  v_progress_now = {
    "ProgressNow",
    BIND_TYPE.TEXT
  },
  v_progress_max = {
    "ProgressMax",
    BIND_TYPE.TEXT
  },
  v_stage_desc = {
    "StageDesc",
    BIND_TYPE.TEXT
  },
  v_ani_reshow = {
    "Ani_Reshow",
    BIND_TYPE.OBJECT
  },
  v_ani_click_l = {
    "Ani_VX_UIChalRingMain_Click_L",
    BIND_TYPE.OBJECT
  },
  v_ani_click_r = {
    "Ani_VX_UIChalRingMain_Click_R",
    BIND_TYPE.OBJECT
  },
  v_ani_click_l_2 = {
    "Ani_VX__Click_L_2",
    BIND_TYPE.OBJECT
  },
  v_ani_click_r_2 = {
    "Ani_VX__Click_R_2",
    BIND_TYPE.OBJECT
  },
  v_btn_last_obj = {
    "Btn_Last",
    BIND_TYPE.OBJECT
  },
  v_btn_next_obj = {
    "Btn_Next",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnDifficulty", function()
    if not self:is_in_fight() then
      UIMgr:get_ui("challenge_ring_plus_difficulty"):ui_show(self.v_select_difficulty_index)
    end
  end)
  self:set_button("BtnContributeShop", function()
    UIMgr:get_ui("challenge_ring_plus_contribute_shop"):ui_show()
  end)
  self:set_button("BtnCardAtlas", function()
    UIMgr:get_ui("challenge_ring_card_atlas"):ui_show()
  end)
  self:set_button("BtnBlessing", function()
    if not self:is_in_fight() then
      UIMgr:get_ui("challenge_ring_plus_blessing_view"):ui_show()
    end
  end)
  self:set_button("BtnFight", function()
    self:on_click_fight()
  end)
  self:set_button("Btn_Last", function()
    self:switch_difficulty(-1)
  end)
  self:set_button("Btn_Next", function()
    self:switch_difficulty(1)
  end)
  self:set_button("BtnOrnaments", function()
    UIMgr:get_ui("ui_ornaments"):ui_show()
  end)
  self:set_button("Btn_ResetAward", function()
    self:reset_treasure_progress(self.v_episode_id)
  end)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local epi_id = main_cfg.EpisodeIds[1]
  local reset_item_id = ShareRes.get_curse_award(epi_id) and ShareRes.get_curse_award(epi_id).ResetItemId or 11
  local asset = {}
  for _, item_id in ipairs(ASSET_ITEM) do
    _tinsert(asset, item_id)
  end
  _tinsert(asset, reset_item_id)
  local asset_config = Shop_Helper.get_asset_list(asset)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
  self:register_exist_auto_template(CHALLENGE_RING_BLESS_POS_ITEM_KEY, self.v_bless_pos_tem, self.v_bless_pos_content)
  self:register_exist_auto_template(CHALLENGE_RING_RING_BOX_ITEM_KEY, self.v_award_tem, self.v_award_content)
end

function ui:ui_on_show(difficulty_index)
  self.v_ani_reshow:SetActive(false)
  self.v_ani_click_l:SetActive(false)
  self.v_ani_click_r:SetActive(false)
  self.v_ani_click_l_2:SetActive(false)
  self.v_ani_click_r_2:SetActive(false)
  self:bind_event()
  self:set_remain_time()
  local msg
  if difficulty_index then
    msg = {}
    local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
    for index, episode_id in ipairs(main_cfg.EpisodeIds) do
      if difficulty_index == index then
        msg.mm_obj = episode_id
        break
      end
    end
  end
  self:refresh_base_info(msg)
  self.v_asset_bar:on_create()
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  for index = 1, 4 do
    self.v_uiobjects["StageIcon" .. index]:SetActive(false)
  end
  for index, _ in pairs(main_cfg.EpisodeIds) do
    self.v_uiobjects["StageIcon" .. index]:SetActive(true)
  end
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  self.v_asset_bar = nil
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_select_difficulty_index
end

function ui:bind_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_RING_DIFFICULTY, self.refresh_difficulty_info, self)
  self:bind_auto_mq(Const.MSG_ON_RESET_CURSE_BOX, self.refresh_box_state, self)
  self:bind_auto_mq(Const.MSG_ON_RING_BOX_UPDATE, self.refresh_box_state, self)
  self:bind_auto_mq(Const.MSG_ON_COMPLETE_RESET, self._reset_box_compplete, self)
end

function ui:set_remain_time()
  self.v_remain_time.text = self:time_format(ActivityMgr:invoke(Act_ID, "get_remain_time"))
end

function ui:time_format(time)
  local remain_time, hour_num
  local day_num = math.floor(time / ONE_DAY_SEC)
  if day_num >= 1 then
    remain_time = time - day_num * ONE_DAY_SEC
    hour_num = math.floor(remain_time / ONE_HOUR_SEC)
    return Util.format_str("{1}天{2}时", day_num, hour_num)
  else
    hour_num = math.floor(time / ONE_HOUR_SEC)
    remain_time = time - hour_num * ONE_HOUR_SEC
    local minute_num = math.floor(remain_time / ONE_MINUTE_SEC)
    return Util.format_str("{1}时{2}分", hour_num, minute_num)
  end
end

function ui:refresh_base_info(msg)
  self:refresh_difficulty_info(msg)
  self:refresh_contribute_shop_info()
  self:refresh_bless_info()
end

function ui:init_bg(cur_select)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  self.v_epi_bg = {}
  self.v_epis_length = #main_cfg.EpisodeIds
  for idx, epi in ipairs(main_cfg.EpisodeIds) do
    local point_cfg = ShareRes.get_chapter_point_cfg(epi)
    local bg_path = point_cfg.PointBgPath
    self.v_epi_bg[idx] = bg_path
  end
  local new_epi_bg = {}
  for i = 1, self.v_epis_length do
    local new_idx = i - cur_select + 1
    if new_idx <= 0 then
      new_idx = new_idx + self.v_epis_length
    end
    new_epi_bg[new_idx] = self.v_epi_bg[i]
  end
  self.v_epi_bg = new_epi_bg
end

function ui:refresh_difficulty_info(msg)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  if msg then
    self.v_episode_id = msg.mm_obj
  else
    local local_difficulty_level_data = ChallengeRingPlusMgr:load_local_difficulty_level_data()
    if next(local_difficulty_level_data) then
      self.v_episode_id = local_difficulty_level_data.episode_id
    else
      self.v_episode_id = main_cfg.EpisodeIds[1]
    end
  end
  local stage_cfg = ShareRes.get_chapter_point_cfg(self.v_episode_id)
  self.v_stage_name1.text = stage_cfg.PointName
  self.v_stage_name2.text = stage_cfg.PointName
  self.v_select_difficulty_index = 1
  for index, episode_id in ipairs(main_cfg.EpisodeIds) do
    if self.v_episode_id == episode_id then
      self.v_select_difficulty_index = index
      break
    end
  end
  self:init_bg(self.v_select_difficulty_index)
  self:set_stage_info(self.v_episode_id, self.v_select_difficulty_index)
  self:refresh_box_state()
end

function ui:set_stage_info(episode_id, index)
  local stage_cfg = ShareRes.get_chapter_point_cfg(episode_id)
  local lock_obj = self.v_difficulty_lock
  local mask_obj = self.v_uiobjects.Mask1
  local state
  if index <= ChallengeRingPlusMgr:get_acty_level() + 1 then
    state = STAGE_STATE.UNLOCK
    lock_obj:SetActive(false)
    mask_obj:SetActive(false)
    ChallengeRingPlusMgr:save_local_difficulty_level_data(episode_id)
  else
    state = STAGE_STATE.LOCK
    lock_obj:SetActive(true)
    mask_obj:SetActive(true)
  end
  if state == STAGE_STATE.LOCK then
    local str = string.format("通关%s关后解锁", ShareRes.get_chapter_point_cfg(stage_cfg.FrontPointId).PointName)
    self.v_unlock_condition.text = Util.format_str(str)
  end
  self.v_fight_lock:SetActive(state == STAGE_STATE.LOCK)
  self:set_button_listener(self.v_fight_lock_btn, function()
    if state == STAGE_STATE.LOCK and stage_cfg.FrontPointId and stage_cfg.FrontPointId > 0 then
      local str = string.format("通关%s关后解锁", ShareRes.get_chapter_point_cfg(stage_cfg.FrontPointId).PointName)
      local content = Util.format_str(str)
      UIMgr:get_ui("uimessagetip"):ui_show(content)
    end
  end)
  local award_cfg = ShareRes.get_curse_award(episode_id)
  self.v_curr_num.text = award_cfg.ResetItemCount
  local resetItem_id = award_cfg.ResetItemId
  local item_cfg = ShareRes.get_item_cfg(resetItem_id)
  ResMgr:load_set_icon(self.v_curr_icon, _sformat(icon_path_prefix, item_cfg.Icon))
  self.v_state = state
  for idx, path in ipairs(self.v_epi_bg) do
    local bg_path = path
    ResMgr:load_set_icon(self.v_uicompents["StageIcon" .. idx .. "_img"], bg_path, nil, true)
  end
  self.v_ani_reshow:SetActive(false)
  self.v_btn_last_obj:SetActive(true)
  self.v_btn_next_obj:SetActive(true)
  local point_cfg = ShareRes.get_chapter_point_cfg(episode_id)
  if point_cfg.PointDesc then
    self.v_stage_desc.transform.parent.gameObject:SetActive(true)
    self.v_stage_desc.text = point_cfg.PointDesc
  else
    self.v_stage_desc.transform.parent.gameObject:SetActive(false)
  end
end

function ui:_get_resetItem_num(episode_id)
  local award_cfg = ShareRes.get_curse_award(episode_id)
  local resetItem_id = award_cfg.ResetItemId
  local item_num = BagMgr:get_item_num(resetItem_id)
  return item_num, award_cfg.ResetItemCount, ShareRes.get_item_name(resetItem_id)
end

function ui:_reset_box_compplete()
  self.v_btn_resetaward.enabled = true
  self:refresh_box_state()
end

function ui:refresh_box_state()
  self.v_btn_resetaward.enabled = self.v_state == STAGE_STATE.UNLOCK
  local episode_id = self.v_episode_id
  local ring_box_list = ChallengeRingPlusMgr:get_ring_box_list()[episode_id]
  if not ring_box_list then
    return
  end
  self:give_back_auto_cache(CHALLENGE_RING_RING_BOX_ITEM_KEY)
  local count = 0
  local all_count = #ring_box_list
  local bar_rect = self:get_rect_transform(nil, self.v_award_bar)
  local width = bar_rect.sizeDelta.x
  self.v_start_box_pos = self.v_start_box_pos or Util.get_rect_transform(nil, self.v_award_tem).anchoredPosition
  for index, ring in ipairs(ring_box_list) do
    local box_item = self:get_auto_cache(CHALLENGE_RING_RING_BOX_ITEM_KEY)
    local box_item_rect = Util.get_rect_transform(nil, box_item)
    local pos = Vec3.Clone(self.v_start_box_pos)
    pos.x = pos.x + (index - 1) * width / (all_count - 1)
    box_item_rect:SetAnchoredPositionA(pos.x, pos.y, pos.z)
    local award_btn = self:get_button(nil, box_item)
    local state = ring.state
    self:set_button_listener(award_btn, function()
      local award_cfg = ShareRes.get_curse_award(episode_id)
      self:_on_click_award(index, award_cfg.RingReward[index], state, episode_id)
    end)
    if state == CURSE_BOX_STATE.GET_AWARD or state == CURSE_BOX_STATE.FINISH then
      count = count + 1
    end
    local complete_obj = self:get_child_gameobj("Complete", box_item)
    local received_obj = self:get_child_gameobj("Received", box_item)
    local redpoint_obj = self:get_child_gameobj("Redpoint", box_item)
    complete_obj:SetActive(false)
    received_obj:SetActive(false)
    redpoint_obj:SetActive(false)
    if state == CURSE_BOX_STATE.FINISH then
      complete_obj:SetActive(true)
      redpoint_obj:SetActive(true)
    elseif state == CURSE_BOX_STATE.GET_AWARD then
      complete_obj:SetActive(true)
      received_obj:SetActive(true)
    end
  end
  local rect = self:get_rect_transform(nil, self.v_award_bar_fill)
  self.v_max_bar_len = self.v_max_bar_len or rect.sizeDelta.x
  local factor = (count - 1) / (all_count - 1)
  rect.sizeDelta = Vec2.New(self.v_max_bar_len * factor, rect.sizeDelta.y)
  self.v_progress_now.text = count
  self.v_progress_max.text = all_count
  self.v_weekly_get_now.text = ChallengeRingPlusMgr:get_weekly_contribute_point()
end

function ui:_on_click_award(index, award_id, state, episode_id)
  local str = Util.format_str(_sformat("第%d层奖励", index))
  
  local function get_award_func()
    ChallengeRingPlusMgr:get_ring_box_award(episode_id, index)
  end
  
  UIMgr:get_ui("ui_award_tips_com"):ui_show(str, award_id, state, get_award_func)
end

function ui:switch_difficulty(step)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local epi_nums = #main_cfg.EpisodeIds
  local switch_index = self.v_select_difficulty_index + step
  if switch_index <= 0 then
    switch_index = epi_nums
  elseif epi_nums < switch_index then
    switch_index = 1
  end
  local next_index = switch_index
  local stage_icon_index = switch_index
  if 1 == step then
    stage_icon_index = self.v_select_difficulty_index
  end
  self:play_switch_difficulty_eff(step, #main_cfg.EpisodeIds, switch_index, stage_icon_index, next_index)
end

function ui:play_switch_difficulty_eff(step, length, switch_index, stage_icon_index, next_index)
  self.v_btn_last_obj:SetActive(false)
  self.v_btn_next_obj:SetActive(false)
  self.v_ani_click_l:SetActive(false)
  self.v_ani_click_r:SetActive(false)
  self.v_ani_click_l_2:SetActive(false)
  self.v_ani_click_r_2:SetActive(false)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local next_epi = main_cfg.EpisodeIds[stage_icon_index]
  local point_cfg = ShareRes.get_chapter_point_cfg(next_epi)
  local bg_path = point_cfg.PointBgPath
  ResMgr:load_set_icon(self.v_uicompents["StageIcon" .. 5 .. "_img"], bg_path, nil, true)
  if next_index <= ChallengeRingPlusMgr:get_acty_level() + 1 then
    self.v_uiobjects.Mask5:SetActive(false)
  else
    self.v_uiobjects.Mask5:SetActive(true)
  end
  local duration = 0.42
  self.v_sequence = Util.create_sequence()
  self.v_sequence:AppendCallback(function()
    if 1 == step then
      if 2 == length then
        self.v_ani_click_r_2:SetActive(true)
      else
        self.v_ani_click_r:SetActive(true)
      end
    elseif -1 == step then
      if 2 == length then
        self.v_ani_click_l_2:SetActive(true)
      else
        self.v_ani_click_l:SetActive(true)
      end
    end
  end)
  duration = step > 0 and 0 or 0.4
  self.v_sequence:AppendInterval(duration)
  self.v_sequence:AppendCallback(function()
    self:switch_epi_bg(step)
    local msg = {}
    msg.mm_obj = main_cfg.EpisodeIds[switch_index]
    self:refresh_difficulty_info(msg)
  end)
end

function ui:switch_epi_bg(step)
  local new_epi_bg = {}
  for i = 1, self.v_epis_length do
    local new_idx = i - step
    if new_idx <= 0 then
      new_idx = self.v_epis_length
    elseif new_idx > self.v_epis_length then
      new_idx = 1
    end
    new_epi_bg[new_idx] = self.v_epi_bg[i]
  end
  self.v_epi_bg = new_epi_bg
end

function ui:reset_treasure_progress(episode_id)
  local cur_num, need_num, item_name = self:_get_resetItem_num(episode_id)
  if cur_num - need_num < 0 then
    local str = string.format("【%s】数量不足", item_name)
    local content = Util.format_str(str)
    UIMgr:get_ui("uimessagetip"):ui_show(content)
    return
  end
  
  local function sure_cb()
    self.v_btn_resetaward.enabled = false
    ChallengeRingPlusMgr:reset_box_progress(episode_id)
  end
  
  local tip = Util.format_str(string.format("将消耗【%s*%d】重置本难度的进度奖励，未领取的奖励不予返还，是否确认？", item_name, need_num))
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_cb, nil, tip, Util.format_str("确定"), Util.format_str("取消"))
end

function ui:refresh_contribute_shop_info()
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  self.v_weekly_get_now.text = ChallengeRingPlusMgr:get_weekly_contribute_point()
  self.v_weekly_get_limit.text = main_cfg.WeekVal
  self.v_current_hold_item_num.text = BagMgr:get_item_num(Contribute_Item_Id)
  local current_day_of_the_week = tonumber(Date:get_week())
  if 1 == current_day_of_the_week and Date.get_time_tbl().hour < Global.daily_reset_hour then
    self.v_reward_reset_text.text = Util.format_str("获取上限1天后重置")
  else
    local reset_stamp = Date.get_time_stamp(8 - current_day_of_the_week, Global.daily_reset_hour)
    local offset_stamp = reset_stamp - Date.server_time()
    local day_num = math.floor(offset_stamp / ONE_DAY_SEC)
    if day_num < 1 then
      day_num = 1
    end
    self.v_reward_reset_text.text = Util.format_str("获取上限{1}天后重置", day_num)
  end
end

function ui:refresh_bless_info()
  self:give_back_auto_cache(CHALLENGE_RING_BLESS_POS_ITEM_KEY, false)
  local bless_pos_list = ChallengeRingPlusMgr:get_bless_pos_list()
  local bless_bag_pos_cfg = ShareRes.create("activity.curse_ring_bless_bag_pos")
  for index, cfg in ipairs(bless_bag_pos_cfg) do
    local pos_item = self:get_auto_cache(CHALLENGE_RING_BLESS_POS_ITEM_KEY)
    local data = bless_pos_list[cfg.Id]
    local icon_obj = self:get_child_gameobj("BlessingIcon", pos_item)
    local icon_img = self:get_image("BlessingIcon", pos_item)
    local lock_obj = self:get_child_gameobj("Lock", pos_item)
    if data then
      if data.is_lock then
        icon_obj:SetActive(false)
        lock_obj:SetActive(true)
      else
        if data.bless_id then
          icon_obj:SetActive(true)
          local bless_list = ChallengeRingPlusMgr:get_bless_list()
          local bless_data = bless_list[data.bless_id]
          local bless_lv_cfg = ChallengeRingPlusMgr:get_bless_lv_cfg(data.bless_id, bless_data.level)
          ResMgr:load_set_icon(icon_img, bless_lv_cfg.Icon)
        else
          icon_obj:SetActive(false)
        end
        lock_obj:SetActive(false)
      end
    else
      icon_obj:SetActive(false)
    end
  end
end

function ui:is_in_fight()
  local game_open = ActivityMgr:get_game_is_open(Act_ID)
  if not game_open then
    return false
  end
  if TowerMgr:check_fight_progress() then
    return true
  end
  return false
end

function ui:on_click_fight()
  local game_open = ActivityMgr:get_game_is_open(Act_ID)
  if not game_open then
    Util.show_message_tip(2280)
    return
  end
  if not self:check_fight() then
    return
  end
  if TowerMgr:check_fight_progress() then
    return
  end
  UIMgr:get_ui("choose_genres_view"):ui_show(self.v_episode_id)
end

function ui:check_fight()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_episode_id)
  local cost_val = point_cfg.FightCost[2]
  local cur_val = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  if cost_val > cur_val then
    UIMgr:get_ui("uiforcerecharg"):ui_show()
    return false
  end
  return true
end

return ui
