local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local weekly_pvp_difficulty_award_key = "weekly_pvp_difficulty_award_key"
local weekly_pvp_difficulty_drop_down_key = "weekly_pvp_difficulty_drop_down_key"
local curr_score_award_key = "weekly_pvp_difficulty_award_curr_score_award_key"
local award_item = require("uimodule.weekly.weekly_pvp_difficulty_award_item")
local item_obj_com = require("uimodule.item.item_obj_com")
local init_pos

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnRank", function()
    self:on_btn_rank_click()
  end)
  self:register_exist_auto_template(weekly_pvp_difficulty_award_key, self.v_uiobjects.AwardTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(weekly_pvp_difficulty_drop_down_key, self.v_uiobjects.RankTem, self.v_uiobjects.RankList)
  self:register_exist_auto_template(curr_score_award_key, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.AwardContent)
  init_pos = self.v_uiobjects.Content.transform.localPosition
  self.register_award_key_list = {}
end

function ui:on_btn_rank_click()
  local rank_active_self = self.v_uiobjects.RankList.activeSelf
  self.v_uiobjects.RankList:SetActive(not rank_active_self)
  if self.v_uiobjects.RankList.activeSelf then
    self:refresh_rank()
  end
end

function ui:ui_on_show(difficulty)
  if not difficulty or 0 == difficulty then
    difficulty = WeeklyMgr:get_cur_pvp_segment()
  end
  if not difficulty or 0 == difficulty then
    difficulty = 1
  end
  self:refresh_data(difficulty)
  self:refresh_drop_down(self.select_difficulty)
  self:refresh_award_list()
  self:refresh_player_info()
end

function ui:refresh_data(difficulty)
  self.curr_difficulty = difficulty
  self.curr_score_cfg = WeeklyMgr:get_pvp_award_cfg_with_curr_score()
  self.curr_difficulty_cfg = ShareRes.get_week_acty_segment_cfg(self.curr_difficulty)
  self:refresh_select_data(difficulty)
end

function ui:refresh_award_list()
  if self.register_award_key_list and #self.register_award_key_list > 0 then
    for i, item_lua_obj in ipairs(self.register_award_key_list) do
      item_lua_obj:clear_award()
    end
    self.register_award_key_list = {}
  end
  self:give_back_auto_cache(weekly_pvp_difficulty_award_key)
  for index, data in ipairs(self.select_cfg_list) do
    local obj = self:get_auto_cache(weekly_pvp_difficulty_award_key)
    local item_lua_obj = award_item:ui_wrap_ex(self, obj, true)
    item_lua_obj:set_data(index, data, self.curr_score_cfg)
    if not self.register_award_key_list[index] then
      self.register_award_key_list[index] = item_lua_obj
    end
  end
end

function ui:refresh_select_data(select_difficulty)
  self.select_difficulty = select_difficulty
  self.select_difficulty_cfg = ShareRes.get_week_acty_segment_cfg(self.select_difficulty)
  self.select_cfg_list = WeeklyMgr:get_award_cfg_list_with_difficulty(self.select_difficulty)
end

function ui:refresh_drop_down(select_difficulty)
  self:refresh_select_data(select_difficulty)
  self.v_uicompents.RightRankName_txt.text = self.select_difficulty_cfg.SegmentName
  self.v_uiobjects.RankList:SetActive(false)
  local all_cfg = ShareRes.create("activity.segment_fraction_reward")
  self:give_back_auto_cache(weekly_pvp_difficulty_drop_down_key)
  for difficulty, _ in ipairs(all_cfg) do
    local obj = self:get_auto_cache(weekly_pvp_difficulty_drop_down_key)
    self:refresh_difficulty_obj(obj, difficulty)
  end
end

function ui:refresh_difficulty_obj(obj, difficulty)
  local cfg = ShareRes.get_week_acty_segment_cfg(difficulty)
  local difficulty_name = Util.get_text("RankName", obj)
  difficulty_name.text = cfg.SegmentName
  local select = Util.get_child_gameobj("Select", obj)
  select:SetActive(self.select_difficulty == difficulty)
  local btn = Util.get_button(nil, obj)
  self:set_button_listener(btn, function()
    self.v_uiobjects.RankList:SetActive(false)
    self:refresh_drop_down(difficulty)
    self:refresh_award_list()
    self.v_uiobjects.Content.transform.localPosition = init_pos
  end)
end

function ui:refresh_player_info()
  local base_info = PlayerMgr:get_player_base_info()
  self.v_uicompents.PlayerName_txt.text = base_info.name
  self.v_uicompents.Score_txt.text = WeeklyMgr:get_pvp_total_score()
  self.v_uicompents.LeftRankName_txt.text = self.curr_difficulty_cfg.SegmentName
  self:refresh_left_award_list()
end

function ui:refresh_left_award_list()
  local curr_score_cfg = WeeklyMgr:get_pvp_award_cfg_with_curr_score()
  self.v_uiobjects.NoAward:SetActive(not curr_score_cfg)
  self.v_uiobjects.AwardContent:SetActive(nil ~= curr_score_cfg)
  if not curr_score_cfg then
    return
  end
  local data_list = {}
  ShareRes.get_item_obj_use_award_list(curr_score_cfg.RewardGroupId, data_list)
  self:give_back_auto_cache(curr_score_award_key)
  for index, data in ipairs(data_list) do
    local obj = self:get_auto_cache(curr_score_award_key)
    local item = item_obj_com:ui_wrap_ex(self, obj, true)
    item:set_data(data, true)
  end
end

function ui:refresh_rank()
end

function ui:ui_on_hide()
end

return ui
