local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local MODEL = {}
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")
local RANK_TYPE = WEEKLY_CFG.RANK_TYPE
local LoopListClass = require("ui.widget.infinite_loop_list")
local RankItemClass = require("uimodule.weekly.weekly_pvp_top_rank_item")
local PREFIX_ICON_PATH = WEEKLY_CFG.PREFIX_ICON_PATH
local WEEKLY_RES_PATH = WEEKLY_CFG.RANK_ICON_PATH
local TOP_ICON_RES = {
  "Weekly_icon_no1",
  "Weekly_icon_no2",
  "Weekly_icon_no3"
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnSort", function()
    self:click_sort_btn()
  end)
  
  local function cb()
  end
  
  self.v_rank_view = LoopListClass:new(self, self.v_uiobjects.RankingList, RankItemClass, cb)
end

function ui:click_sort_btn()
  self.v_is_sequence = not self.v_is_sequence
  self:update_rank_item(1)
end

function ui:ui_on_show()
  self.v_is_sequence = true
  WeeklyMgr:reset_top_rank()
  WeeklyMgr:request_rank_list(WeeklyMgr:get_max_difficulty(), 1, WeeklyMgr.once_request_top_rank_count, true)
  self.v_last_end_rank = false
  self.v_is_request = false
  self.v_rank_list = {}
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_UPDATE_PVP_RANK_DATA, self.msg_update_rank_data, self)
end

function ui:check_sequence()
  return self.v_is_sequence
end

function ui:ui_on_hide()
  self.v_last_rank_num = nil
  self.v_rank_view:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_rank_view:ui_on_destroy()
end

function ui:msg_update_rank_data()
  local rank_list = WeeklyMgr:get_rank_list()
  self.v_uiobjects.NoPlayer:SetActive(nil == rank_list or #rank_list <= 0)
  if #rank_list == self.v_last_rank_num then
    self.v_last_end_rank = true
    return
  end
  self.v_is_request = false
  local index = 1
  if nil ~= self.v_last_rank_num then
    index = self.v_last_rank_num
  end
  self:update_rank_item(index)
  self:update_mine_rank_data()
end

function ui:update_rank_item(select_idx)
  local rank_list = WeeklyMgr:get_rank_list()
  if not rank_list then
    return
  end
  local rank_map = rank_list
  if not self.v_is_sequence then
    rank_map = self:reverse_table(rank_list)
  end
  self.v_last_rank_num = #rank_list
  self.v_rank_view:refresh_data(rank_map)
  self.v_rank_view:scroll_to_item(select_idx - 1)
end

function ui:reverse_table(tab)
  local tmp = {}
  local idx = 1
  for i = #tab, 1, -1 do
    tmp[idx] = tab[i]
    idx = idx + 1
  end
  return tmp
end

function ui:check_last_show_rank()
  if not self.v_rank_view then
    return
  end
  if self.v_last_end_rank then
    return
  end
  if self.v_is_request then
    return
  end
  local cur_num = self.v_last_rank_num
  if self.v_rank_view:check_vertical_scoll_bottom() then
    self.v_is_request = true
    WeeklyMgr:request_rank_list(WeeklyMgr:get_max_difficulty(), cur_num + 1, WeeklyMgr.once_request_top_rank_count)
  end
end

function ui:update_mine_rank_data()
  local mine_rank = WeeklyMgr:get_mine_rank()
  local rank_val = mine_rank.rank
  self.v_uiobjects.RankTop3:SetActive(false)
  self.v_uiobjects.NoRankNum:SetActive(rank_val <= 0)
  self.v_uicompents.RankNum_txt.text = rank_val
  self.v_uiobjects.RankNum:SetActive(rank_val > 0)
  local curr_difficulty = WeeklyMgr:get_cur_pvp_segment()
  local segment_cfg = ShareRes.get_week_acty_segment_cfg(curr_difficulty)
  self.v_uicompents.RankName_txt.text = segment_cfg.SegmentName
  self.v_uicompents.PlayerName_txt.text = PlayerMgr:get_player_name()
  local score = mine_rank.value <= 0 and 0 or mine_rank.value
  self.v_uicompents.Score_txt.text = score
  local avatar_cfg = ShareRes.create("player.player_avatar")
  local avatar_id = PlayerMgr:get_player_head_id()
  local icon_name = nil == avatar_cfg[avatar_id] and avatar_cfg[700051].Icon or avatar_cfg[avatar_id].Icon
  local avatar_icon_path = string.format(PREFIX_ICON_PATH, icon_name)
  ResMgr:load_set_icon(self.v_uicompents.ProfileIcon_img, avatar_icon_path)
end

return ui
