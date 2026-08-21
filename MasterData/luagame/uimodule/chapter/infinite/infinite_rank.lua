local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local FontStyle = UnityEngine.FontStyle
local ToggleTab = require("ui.widget.widget_toggle_tab")
local HERO_ICON_PATH = "Icon/Profile/%s"
local LoopListClass = require("ui.widget.infinite_loop_list")
local RankItemClass = require("uimodule.chapter.infinite.infinite_rank_item")
local INFINITE_RANK_STAGE_ITEM_KEY = "INFINITE_RANK_STAGE_ITEM_KEY"
local _floor = math.floor
local _insert = table.insert
local ONE_HOUR_SEC = 3600
local ONE_MINUTE_SEC = 60
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_stage = {
    "BtnStage",
    BIND_TYPE.BUTTON
  },
  v_arrow_layout = {
    "ArrowLayout",
    BIND_TYPE.OBJECT
  },
  v_right_arrow = {
    "RightArrow",
    BIND_TYPE.OBJECT
  },
  v_down_arrow = {
    "DownArrow",
    BIND_TYPE.OBJECT
  },
  v_stage_name = {
    "StageName",
    BIND_TYPE.TEXT
  },
  v_player_icon = {
    "Profile",
    BIND_TYPE.IMAGE
  },
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  },
  v_no_record = {
    "NoRecord",
    BIND_TYPE.OBJECT
  },
  v_best_record = {
    "BestRecord",
    BIND_TYPE.OBJECT
  },
  v_floor_num = {
    "Floor",
    BIND_TYPE.TEXT
  },
  v_time_num = {
    "Time",
    BIND_TYPE.TEXT
  },
  v_rank_num = {
    "RankNum",
    BIND_TYPE.TEXT
  },
  v_no_rank = {
    "NoRank",
    BIND_TYPE.OBJECT
  },
  v_tips = {
    "Tips",
    BIND_TYPE.TEXT
  },
  v_member_scroll = {
    "MemberScroll",
    BIND_TYPE.OBJECT
  },
  v_stage_tem = {
    "StageTem",
    BIND_TYPE.OBJECT
  },
  v_stage_list = {
    "StageList",
    BIND_TYPE.OBJECT
  },
  v_btn_close_stage = {
    "BtnCloseStage",
    BIND_TYPE.OBJECT
  },
  v_member_empty_tip = {
    "MemberEmptyTip",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnStage", function()
    self:on_click_stage()
  end)
  self:set_button("BtnCloseStage", function()
    self.v_stage_list:SetActive(false)
    self.v_btn_close_stage:SetActive(false)
    self.v_right_arrow:SetActive(false)
    self.v_down_arrow:SetActive(true)
  end)
  self.v_rank_list = LoopListClass:new(self, self.v_member_scroll, RankItemClass)
  self:register_exist_auto_template(INFINITE_RANK_STAGE_ITEM_KEY, self.v_stage_tem, self.v_stage_list)
end

function ui:ui_on_show(infinite_id, rank_info)
  self:bind_auto_mq(Const.MSG_CHAPTER_RANK_UPDATE, self.fefresh_all_info, self)
  self.v_infinite_id = infinite_id
  self.v_rank_info = rank_info
  self.v_infinite_cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
  self:set_player_info()
  self:refresh_rank_info()
end

function ui:ui_on_hide()
  self.v_rank_list:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_rank_list:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_infinite_id, self.v_rank_info
end

function ui:fefresh_all_info(msg)
  local rank_info = msg.mm_x
  self.v_rank_info = rank_info
  self.v_infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  self:set_player_info()
  self:refresh_rank_info()
end

function ui:set_player_info()
  local infinite_count = ChapterMgr:get_inf_chapter_count()
  if infinite_count <= 1 then
    self.v_btn_stage.interactable = false
    self.v_arrow_layout:SetActive(false)
  else
    self.v_btn_stage.interactable = true
    self.v_arrow_layout:SetActive(true)
    self.v_right_arrow:SetActive(false)
    self.v_down_arrow:SetActive(true)
  end
  local player_data = self.v_rank_info.my_rank
  local player_snapinfo = player_data.snapinfo
  local avatar_cfg = ShareRes.create("player.player_avatar", player_snapinfo.face_id)
  ResMgr:load_set_icon(self.v_player_icon, string.format(HERO_ICON_PATH, avatar_cfg.Icon))
  self.v_player_name.text = player_snapinfo.name
  self.v_stage_name.text = self.v_infinite_cfg.Name .. Util.format_str("排行")
  if -1 == player_data.value then
    self.v_no_record:SetActive(true)
    self.v_best_record:SetActive(false)
  else
    self.v_no_record:SetActive(false)
    self.v_best_record:SetActive(true)
    self.v_floor_num.text = player_data.value
    local cost_time = player_data.infinite_data.fight_time
    local hour_num = _floor(cost_time / ONE_HOUR_SEC)
    local remain_time = cost_time - hour_num * ONE_HOUR_SEC
    local minute_num = _floor(remain_time / ONE_MINUTE_SEC)
    remain_time = remain_time - minute_num * ONE_MINUTE_SEC
    self.v_time_num.text = Util.format_str("{1}时{2}分{3}秒", hour_num, minute_num, remain_time)
  end
  self.v_rank_num.gameObject:SetActive(-1 ~= player_data.rank)
  self.v_no_rank.gameObject:SetActive(-1 == player_data.rank)
  if -1 ~= player_data.rank then
    if player_data.rank > self.v_infinite_cfg.rankArea then
      self.v_rank_num.text = ">" .. self.v_infinite_cfg.rankArea
    else
      self.v_rank_num.text = player_data.rank
    end
  end
  self.v_tips.text = Util.format_str("仅通关层数{1}时纳入排行统计", string.format("<size=30><color=#ffffff>≥%s</color></size>", self.v_infinite_cfg.rankLimit))
end

function ui:refresh_rank_info()
  local rank_list = UtilTable.copy_table(self.v_rank_info.rank_list)
  if #rank_list > 0 then
    table.sort(rank_list, function(a, b)
      return a.rank < b.rank
    end)
  end
  local total_rank = self.v_rank_info.total_rank
  local rank_num = self.v_infinite_cfg.rankNum
  if 0 == total_rank then
    self.v_member_empty_tip:SetActive(true)
    self.v_member_scroll:SetActive(false)
  else
    self.v_member_empty_tip:SetActive(false)
    self.v_member_scroll:SetActive(true)
    if rank_num >= total_rank + 1 then
      _insert(rank_list, {})
    end
    self.v_rank_list:refresh_data(rank_list)
  end
end

function ui:on_click_stage()
  self.v_stage_list:SetActive(true)
  self.v_btn_close_stage:SetActive(true)
  self.v_right_arrow:SetActive(true)
  self.v_down_arrow:SetActive(false)
  local inf_id_list = ChapterMgr:get_inf_id_list()
  local infinite_cfg_list = {}
  for _, inf_id in pairs(inf_id_list) do
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(inf_id)
    _insert(infinite_cfg_list, infinite_cfg)
  end
  table.sort(infinite_cfg_list, function(a, b)
    return a.Priority > b.Priority
  end)
  self.v_cur_toggle_index = 1
  local pages = {}
  local label_list = {}
  local select_list = {}
  self:give_back_auto_cache(INFINITE_RANK_STAGE_ITEM_KEY, false)
  for index, infinite_cfg in ipairs(infinite_cfg_list) do
    if self.v_infinite_id == infinite_cfg.Id then
      self.v_cur_toggle_index = index
    end
    local obj = self:get_auto_cache(INFINITE_RANK_STAGE_ITEM_KEY)
    local label_text = Util.get_text("Label", obj)
    local select_obj = Util.get_child_gameobj("Select", obj)
    label_text.text = infinite_cfg.Name .. Util.format_str("排行")
    _insert(pages, Util.get_toggle(nil, obj))
    _insert(label_list, label_text)
    _insert(select_list, select_obj)
  end
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(pages, function(idx)
    self:on_click_stage_toggle(idx, infinite_cfg_list[idx])
  end)
  self.v_page_toggle_tab:set_toggle_by_index(self.v_cur_toggle_index)
  for i, label in ipairs(label_list) do
    label.color = i == self.v_cur_toggle_index and Util.get_unity_color_by_hex(tonumber("ffda9d", 16)) or Util.get_unity_color_by_hex(tonumber("fff0d5", 16))
    label.fontStyle = i == self.v_cur_toggle_index and FontStyle.Bold or FontStyle.Normal
  end
  for index, select_obj in ipairs(select_list) do
    select_obj:SetActive(index == self.v_cur_toggle_index)
  end
end

function ui:on_click_stage_toggle(index, infinite_cfg)
  if index == self.v_cur_toggle_index then
    return
  end
  self.v_stage_list:SetActive(false)
  self.v_btn_close_stage:SetActive(false)
  self.v_right_arrow:SetActive(false)
  self.v_down_arrow:SetActive(true)
  self.v_infinite_id = infinite_cfg.Id
  ChapterMgr:request_inf_chapter_rank(infinite_cfg.Id)
end

return ui
