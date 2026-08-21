local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local LocalStorage = require("utils.localstorage")
M.GRID_STATE = {
  NOTSHOW = 0,
  SHOW = 1,
  SHOWANDUSE = 2
}
M.GRID_UI_STATE = {
  FORBID = 1,
  HIDEFORBID = 2,
  HIDE = 3,
  SHOW = 4,
  GHOST = 5
}
M.GRID_TYPE = {
  EMPTY = 0,
  ENTRANCE = 1,
  EXIT = 2,
  ITEM = 3,
  MONSTER = 4,
  BOSS = 5,
  BLESS = 6,
  SHOP = 7
}
M.GAME_SETTLEMENT_TYPE = {
  SUCCESS = 1,
  FAIL = 2,
  MANUAL_EXIT = 3
}
M.GAME_MODE = {BASE = 1, ENDLESS = 2}
M.ITEM_TYPE = {
  GOLD = 1,
  HEALTH = 2,
  SCORE = 3
}
M.MINESWEEPER_KEY = "MINESWEEPER_KEY"

function M:init_sys()
  Base.init_sys(self)
  self.gained_score_award_id_map = {}
end

function M:on_destroy()
end

function M:on_reconnect()
end

function M:on_gs2c_activity_minesweeper_info(data)
  if not data.minesweeper_chapter[1] then
    return
  end
  self.activity_id = data.activity_id
  local pre_grids = self.v_minesweeper_chapter_info and self.v_minesweeper_chapter_info.grids
  self.v_minesweeper_chapter_info = data.minesweeper_chapter[1]
  self.v_minesweeper_chapter_info.grids = self.v_minesweeper_chapter_info.grids or pre_grids
  local minesweeper_chapter_cfg = ShareRes.create("minesweeper.minesweeper_chapter")[self.v_minesweeper_chapter_info.chapter_id]
  self.chapter_group_id = minesweeper_chapter_cfg.GroupId
  self.base_max_floor = ShareRes.create("minesweeper.minesweeper")[self.activity_id].BaseFloor
  self.endless_max_floor = #ShareRes.create("minesweeper.minesweeper_floor")[self.chapter_group_id]
  self.knowledge_level = self:calc_minesweeper_knowledge_level(self.v_minesweeper_chapter_info.knowledge_level_score, self.v_minesweeper_chapter_info.chapter_id)
  UtilTable.clear_map(self.gained_score_award_id_map)
  for _, v in ipairs(self.v_minesweeper_chapter_info.gained_score_award_id) do
    self.gained_score_award_id_map[v] = true
  end
  if self.v_minesweeper_chapter_info.grids then
    self.exit_grid_unlocked = true
    self.finish_all_monster = true
    for _, grid_info in ipairs(self.v_minesweeper_chapter_info.grids) do
      local grid_type = ShareRes.get_minesweeper_grid_type(grid_info.grid_id)
      grid_info.grid_type = grid_type
      if grid_type == M.GRID_TYPE.MONSTER or grid_type == M.GRID_TYPE.BOSS then
        if grid_info.state == M.GRID_STATE.SHOW then
          self.exit_grid_unlocked = false
        end
        if grid_info.state ~= M.GRID_STATE.SHOWANDUSE then
          self.finish_all_monster = false
        end
      end
    end
  else
    self.exit_grid_unlocked = false
  end
  self:refresh_redpoint()
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_MINESWEEPER_INFO)
end

function M:on_gs2c_activity_minesweeper_grid_update(data)
  local grids = data.grids
  for _, grid_info in ipairs(grids) do
    local grid_index = grid_info.index
    grid_info.grid_type = ShareRes.get_minesweeper_grid_type(grid_info.grid_id)
    self.v_minesweeper_chapter_info.grids[grid_index] = grid_info
  end
  self:update_exit_grid_state()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_UPDATE_MINESWEEPER_GRID_INFO)
  msg.mm_x = grids
end

function M:request_get_score_award()
  Network:protect_call("c2gs_activity_minesweeper_score_award_gain", {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id
  })
end

function M:request_start_game(callback)
  Network:protect_call("c2gs_activity_minesweeper_open_game", {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id
  }, function(ok, resp)
    if true == ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:request_flip_grid(grid_index)
  local grid_info = self.v_minesweeper_chapter_info.grids[grid_index]
  grid_info.state = M.GRID_STATE.SHOW
  if grid_info.grid_type == M.GRID_TYPE.MONSTER or grid_info.grid_type == M.GRID_TYPE.BOSS then
    self.exit_grid_unlocked = false
  end
  Network:call("c2gs_activity_minesweeper_open_grid", {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id,
    grid_index = grid_index
  })
end

function M:request_use_grid(grid_index, args, callback)
  local body = {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id,
    grid_index = grid_index,
    args = args
  }
  Network:protect_call("c2gs_activity_minesweeper_use_grid", body, function(ok, resp)
    if ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:request_rank_list(minesweeper_chapter_id, callback)
  local body = {
    rank_name = "minesweeper-" .. minesweeper_chapter_id,
    start_pos = 1,
    count = ShareRes.create("minesweeper.minesweeper_chapter")[minesweeper_chapter_id].RankNum
  }
  Network:protect_call("c2gs_get_rank_list", body, function(ok, resp)
    if ok and 0 == resp.errcode then
      self.minesweeper_rank_list = resp.rank_list
      self.minesweeper_rank_user_count = body.count
      if callback then
        callback()
      end
    end
  end)
end

function M:request_reset_floor(callback, fall_callback)
  local body = {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id
  }
  Network:protect_call("c2gs_activity_minesweeper_reset_floor", body, function(ok, resp)
    if ok and 0 == resp.errcode then
      if callback then
        callback()
      end
      self.cool_down_time = Global.real_time + 20
      MsgGame:mq_publish2(Const.MSG_ON_MINESWEEPER_RESET_FLOOR)
    elseif fall_callback then
      fall_callback()
    end
  end)
end

function M:request_minesweeper_settlement(callback)
  local body = {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id
  }
  Network:protect_call("c2gs_minesweeper_chapter_settlement", body, function(ok, resp)
    if ok and 0 == resp.errcode then
      self.v_minesweeper_chapter_info.grids = nil
      if callback then
        callback()
      end
    end
  end)
end

function M:request_minesweeper_remove_bless(bless_id, callback)
  local body = {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id,
    bless_id = bless_id
  }
  Network:protect_call("c2gs_minesweeper_remove_bless", body, function(ok, resp)
    if ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:request_minesweeper_open_all_grid(callback)
  local body = {
    activity_id = self.activity_id,
    chapter_group_id = self.chapter_group_id
  }
  Network:protect_call("c2gs_activity_minesweeper_open_all_grid", body, function(ok, resp)
    if ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:get_minesweeper_chapter_id()
  return self.v_minesweeper_chapter_info.chapter_id
end

function M:get_minesweeper_chapter_info()
  return self.v_minesweeper_chapter_info
end

function M:get_minesweeper_record_score()
  return self.v_minesweeper_chapter_info.history_max_score
end

function M:calc_minesweeper_knowledge_level(knowledge_level_score, chapter_id, calc_range)
  local minesweeper_chapter_cfg = ShareRes.create("minesweeper.minesweeper_chapter")[chapter_id]
  local knowledge_level_id = minesweeper_chapter_cfg.KnowledgeLevelId
  local knowledge_level_cfg = ShareRes.create("minesweeper.minesweeper_level")[knowledge_level_id]
  local cur_level_cfg
  for _, v in ipairs(knowledge_level_cfg) do
    if knowledge_level_score >= v.NeedScore then
      cur_level_cfg = v
    end
  end
  if calc_range then
    local level = cur_level_cfg.Level
    local level_range_begin = false
    local level_range_end = false
    if level ~= #knowledge_level_cfg then
      level_range_begin = knowledge_level_score - cur_level_cfg.NeedScore
      local next_level_cfg = knowledge_level_cfg[level + 1]
      if not next_level_cfg.StartTime or Date.get_time_stamp_by_scheme_id(next_level_cfg.StartTime) < Date.server_time() then
        level_range_end = next_level_cfg.NeedScore - knowledge_level_cfg[level].NeedScore
      end
    end
    return level, level_range_begin, level_range_end
  else
    return cur_level_cfg.Level
  end
end

function M:get_minesweeper_grid_list()
  return self.v_minesweeper_chapter_info.grids
end

function M:get_minesweeper_grid(index)
  return self.v_minesweeper_chapter_info.grids[index]
end

function M:get_minesweeper_record_buddy_list()
  return self.v_minesweeper_chapter_info.record_buddy
end

function M:use_grid(grid_index, args, callback)
  local grid_info = self.v_minesweeper_chapter_info.grids[grid_index]
  if grid_info.grid_type == M.GRID_TYPE.EXIT or grid_info.grid_type == M.GRID_TYPE.ITEM or grid_info.grid_type == M.GRID_TYPE.BLESS or grid_info.grid_type == M.GRID_TYPE.SHOP then
    self:request_use_grid(grid_index, args, callback)
  elseif grid_info.grid_type == M.GRID_TYPE.MONSTER or grid_info.grid_type == M.GRID_TYPE.BOSS then
    if not DebugSetting:is_enter_chapter() then
      local function confirm_cb()
        local tower_id = DebugSetting:get_tower_id()
        
        if tower_id and tower_id > 0 then
          TowerMgr:on_gm_enter_tower(tower_id)
        end
      end
      
      Util.show_notify_popup_message(confirm_cb, "GM进塔", "GM进塔")
    else
      if TowerMgr:check_fight_progress() then
        return
      end
      local temp = {
        self.activity_id,
        self.chapter_group_id,
        grid_info.index
      }
      self.battle_grid_id = grid_info.grid_id
      UIMgr:get_ui("team"):ui_show(nil, grid_info.args[1], CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER, nil, nil, nil, temp)
    end
  end
end

function M:update_exit_grid_state()
  if self.v_minesweeper_chapter_info.grids then
    self.exit_grid_unlocked = true
    self.finish_all_monster = true
    for _, grid_info in ipairs(self.v_minesweeper_chapter_info.grids) do
      local grid_type = grid_info.grid_type
      if grid_type == M.GRID_TYPE.MONSTER or grid_type == M.GRID_TYPE.BOSS then
        if grid_info.state == M.GRID_STATE.SHOW then
          self.exit_grid_unlocked = false
        end
        if grid_info.state ~= M.GRID_STATE.SHOWANDUSE then
          self.finish_all_monster = false
        end
      end
    end
  else
    self.exit_grid_unlocked = false
  end
end

function M:refresh_redpoint()
  local t = LocalStorage:load_table(M.MINESWEEPER_KEY, true)
  local redpoint_enable = t and t[self.chapter_group_id]
  if not redpoint_enable then
    RedPointMgr:enable_redpoint(RedEnum.MINESWEEPER_AWARD, true)
  else
    local minesweep_chapter_id = self:get_minesweeper_chapter_id()
    local minesweeper_chapter_cfg = ShareRes.create("minesweeper.minesweeper_chapter")[minesweep_chapter_id]
    local score_award_id = minesweeper_chapter_cfg.ScoreAwardId
    local award_list = ShareRes.create("minesweeper.minesweeper_score_award")[score_award_id]
    local record_scroe = self:get_minesweeper_record_score()
    local enable_redpoint = false
    for _, data in ipairs(award_list) do
      if record_scroe >= data.NeedScore then
        if not self.gained_score_award_id_map[data.KeyId] then
          enable_redpoint = true
          break
        end
      else
        break
      end
    end
    RedPointMgr:enable_redpoint(RedEnum.MINESWEEPER_AWARD, enable_redpoint)
  end
end

return M
