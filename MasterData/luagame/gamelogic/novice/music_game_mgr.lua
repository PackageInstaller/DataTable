local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
end

function M:on_reconnect()
end

function M:on_gs2c_activity_music_game_info(data)
  self.v_activity_id = data.activity_id
  self.v_chapter_datas = {}
  if data.music_games then
    for _, chapter_data in ipairs(data.music_games) do
      self.v_chapter_datas[chapter_data.id] = chapter_data
    end
  end
  self:refresh_new_stage_red()
  MsgGame:mq_publish2(Const.MSG_ON_MUSIC_GAME_DATA_UPDATE)
end

function M:on_gs2c_activity_music_game_update(data)
  local new_chapter_data = data.music_game
  local chapter_id = new_chapter_data.id
  if not self.v_chapter_datas[chapter_id] then
    self.v_chapter_datas[chapter_id] = {}
  end
  self.v_chapter_datas[chapter_id] = new_chapter_data
  self:refresh_new_stage_red()
  MsgGame:mq_publish2(Const.MSG_ON_MUSIC_GAME_DATA_UPDATE)
end

function M:report_score(chapter_id, stage_id, score, combo_num, cb)
  Network:call("c2gs_activity_music_game_report", {
    activity_id = self.v_activity_id,
    game_id = chapter_id,
    episode_id = stage_id,
    score = score,
    combo_num = combo_num
  }, function()
    cb()
  end)
end

function M:read_chapter_new_stage(chapter_id)
  local chapter_data = chapter_id and self.v_chapter_datas[chapter_id]
  if chapter_data and chapter_data.episodes then
    for _, stage_data in pairs(chapter_data.episodes) do
      if stage_data.is_red then
        Network:call("c2gs_activity_music_game_clicked_red", {
          activity_id = self.v_activity_id,
          game_id = chapter_id,
          episode_id = stage_data.episode_id
        })
      end
    end
  end
end

function M:get_activity_id()
  return self.v_activity_id
end

function M:get_chapter_data(chapter_id)
  return self.v_chapter_datas[chapter_id]
end

function M:get_stage_data(chapter_id, stage_id)
  local chapter_data = self.v_chapter_datas[chapter_id]
  local stage_datas = chapter_data and chapter_data.episodes
  if not stage_datas then
    return
  end
  for _, stage_data in pairs(stage_datas) do
    if stage_data.episode_id == stage_id then
      return stage_data
    end
  end
end

function M:refresh_new_stage_red()
  local is_active = NoviceMgr:get_novice_activity_active(self.v_activity_id)
  if not is_active then
  else
    for _, chapter_data in pairs(self.v_chapter_datas) do
      if chapter_data.episodes then
        for _, stage_data in pairs(chapter_data.episodes) do
          if stage_data.is_red then
            RedPointMgr:enable_redpoint(RedEnum.MUSIC_GAME_ACT_NEW_STAGE, true)
            return
          end
        end
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.MUSIC_GAME_ACT_NEW_STAGE, false)
end

function M:get_new_stage_red(chapter_id)
  local chapter_data = self.v_chapter_datas[chapter_id]
  local stage_datas = chapter_data and chapter_data.episodes
  if not stage_datas then
    return false
  end
  for _, stage_data in pairs(stage_datas) do
    if stage_data.is_red then
      return true
    end
  end
  return false
end

return M
