local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local UI_MAZE_GAME_MAIN_ITEM = require("uimodule.activity.maze_game.ui_maze_game_main_item")
local LocalStorage = require("utils.localstorage")
local STAGECONTENT_STAGETEM_TEMP_KEY = "STAGECONTENT_STAGETEM_TEMP_KEY"
local STORY_FIRST_PLAY_KEY = "STORY_FIRST_PLAY_KEY"

function ui:on_click_item(point_id)
  local point_cfg = ShareRes.get_ponder_maze_point_cfg(point_id)
  local unlock_time = point_cfg.UnlockTime and Date.get_time_stamp_by_scheme_id(point_cfg.UnlockTime)
  if unlock_time and unlock_time > Date.server_time() then
    return
  end
  if Util.is_more_than_zero(point_cfg.PrePoint) and not NoviceMgr:get_ponder_maze_point_is_comp(self.v_activity_id, point_cfg.PrePoint) then
    return
  end
  UIMgr:try_show_ui("ui_maze_game_start", nil, self.v_activity_id, point_id)
end

function ui:on_click_BtnRet1()
  self:ui_hide()
end

function ui:on_click_BtnTask()
  local maze_activity_cfg = ShareRes.get_ponder_maze_activity_cfg(self.v_activity_id)
  UIMgr:try_show_ui("ui_maze_game_task", "refresh_task", maze_activity_cfg.TaskGroup)
end

function ui:on_click_BtnHandBook()
  UIMgr:try_show_ui("ui_maze_game_illustrated", nil, self.v_activity_id)
end

function ui:ui_finish_load()
  self:set_button("BtnTask", function()
    self:on_click_BtnTask()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnHandBook", function()
    self:on_click_BtnHandBook()
  end)
  self.v_item_list = {}
  self:register_exist_auto_template(STAGECONTENT_STAGETEM_TEMP_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.StageContent)
end

local TRIGGER_TYPE = {
  DEFAULT_UNLOCK = 1,
  PONDER_UNLOCK = 2,
  POINT_UNLOCK = 3
}

function ui:ui_on_show(activity_id)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TaskRedPoint, RedEnum.MAZE_ACT_TASK, RedEnum.TIME_LIMITED_ACTIVITY_BTN_5_1_2)
  self.v_activity_id = activity_id
  self.v_activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  self:refresh_view()
  NoviceMgr:check_maze_game_tips_and_story(self.v_activity_id)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_update()
  self:refresh_time_remaining()
end

function ui:ui_on_hide()
  self:clear_item(true)
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  local maze_activity_cfg = ShareRes.get_ponder_maze_activity_cfg(self.v_activity_id)
  if maze_activity_cfg then
    local point_list = UtilTable.map2list(maze_activity_cfg.Point, function(a, b)
      if a ~= b then
        return a < b
      end
      return false
    end)
    self:clear_item()
    for i = 1, #point_list do
      local point_id = point_list[i]
      local obj = self:get_auto_cache(STAGECONTENT_STAGETEM_TEMP_KEY)
      local item = UI_MAZE_GAME_MAIN_ITEM:ui_wrap_ex(self, obj, true)
      self.v_item_list[point_id] = item
      self.v_item_list[point_id]:set_data(self.v_activity_id, point_id)
    end
    self.v_uiobjects.BtnTask:SetActive(Util.is_more_than_zero(maze_activity_cfg.TaskGroup))
  end
  self:refresh_ill_red()
end

function ui:clear_item(is_hide)
  self:give_back_auto_cache(STAGECONTENT_STAGETEM_TEMP_KEY)
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[key] = nil
  end
end

function ui:refresh_time_remaining()
  if not self.v_activity_cfg then
    return
  end
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  if not activity_data then
    return
  end
  local time_length = NoviceMgr:get_time_remaining(self.v_activity_cfg.TimeType, self.v_activity_cfg.StopTime, activity_data.open_time, self.v_activity_cfg.SustainTime)
  self.v_uiobjects.LessTime:SetActiveEx(nil ~= time_length)
  if time_length then
    self.v_uicompents.LessTime_txt.text = Date.get_time_format_7(time_length)
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id
end

function ui:refresh_ill_red()
  local is_red = false
  local ponder_cfgs = ShareRes.get_ponder_cfg()
  local key = "ponder_id"
  for ponder_id, cfg in pairs(ponder_cfgs) do
    if cfg.IllustrateShow and NoviceMgr:get_ponder_is_unlock(self.v_activity_id, ponder_id) and NoviceMgr:check_ill_item_red(self.v_activity_id, ponder_id, key) then
      is_red = true
      break
    end
  end
  if not is_red then
    key = "story_id"
    local story_cfgs = ShareRes.get_ponder_maze_story_cfg()
    for story_id, cfg in pairs(story_cfgs) do
      local is_unlock = false
      if cfg.StoryType == TRIGGER_TYPE.DEFAULT_UNLOCK then
        is_unlock = true
      elseif cfg.StoryType == TRIGGER_TYPE.PONDER_UNLOCK then
        is_unlock = NoviceMgr:get_ponder_is_unlock(self.v_activity_id, cfg.Param[1])
      elseif cfg.StoryType == TRIGGER_TYPE.POINT_UNLOCK then
        for _, point_id in pairs(cfg.Param) do
          is_unlock = NoviceMgr:get_ponder_maze_point_is_comp(self.v_activity_id, point_id)
        end
      else
        is_unlock = true
      end
      if cfg.IllustrateShow and is_unlock and NoviceMgr:check_ill_item_red(self.v_activity_id, story_id, key) then
        is_red = true
        break
      end
    end
  end
  self.v_uiobjects.HandBookRedPoint:SetActive(is_red)
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

return ui
