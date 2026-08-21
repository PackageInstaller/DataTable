local Base = require("gamelogic.tower_mgr.room")
local M = Util.create_child_mt(Base)
local PRE_FIGHT_STORY_STATE = M.PRE_FIGHT_STORY_STATE

function M:_init(room_data)
  self.v_archive_video_id = room_data.archive_video_id
  self.v_archive_video_cfg = ShareRes.get_archive_video_cfg(self.v_archive_video_id)
  self.v_tower_id = self.v_archive_video_cfg.TowerID
  self.v_floor_id = self.v_archive_video_cfg.Floor
  self.v_room_id = self.v_archive_video_cfg.RoomID
  if not self.v_archive_video_cfg then
    Log.Error("获取剧情回顾配置失败，ID：", self.v_archive_video_id, debug.traceback())
    return
  end
  if not (self.v_archive_video_cfg.TowerID and self.v_archive_video_cfg.Floor) or not self.v_archive_video_cfg.RoomID then
    Log.Error("剧情回顾未配置塔、层、房间，ID：", self.v_archive_video_id, debug.traceback())
    return
  end
  self.v_tower_cfg = ShareRes.get_tower_cfg(self.v_archive_video_cfg.TowerID)
  if not self.v_tower_cfg then
    Log.Error("剧情回顾获取塔配置失败，ID：", self.v_archive_video_id, debug.traceback())
    return
  end
  self.v_floor_cfg = ShareRes.create("tower.tower_floor", self.v_tower_cfg.FloorGroup[self.v_archive_video_cfg.Floor][1])
  if not self.v_floor_cfg then
    Log.Error("剧情回顾获取层配置失败，ID：", self.v_archive_video_id, debug.traceback())
    return
  end
  self.room_cfg = ShareRes.create("tower.tower_room", self.v_room_id)
  if not self.room_cfg then
    Log.Error("剧情回顾获取房间配置失败，ID：", self.v_archive_video_id, debug.traceback())
    return
  end
  local scene_logic_id = self.v_archive_video_cfg.SceneLogicID
  if not Util.is_empty(scene_logic_id) then
    scene_logic_id = string.lower(scene_logic_id)
    if "default" == scene_logic_id then
      scene_logic_id = self.room_cfg.SceneLogicID
    else
      scene_logic_id = self.v_archive_video_cfg.SceneLogicID
    end
    self.v_scene_logic_id = scene_logic_id
    self.room_preload_cfg = ShareRes.create("preload." .. string.lower(self.v_scene_logic_id))
  end
  assert(self.room_cfg, "can't find tower_room config: " .. self.v_room_id)
  if not SceneMgr:try_enter_scene(self.room_cfg.SceneID) then
    self:enter_room()
  end
end

function M:update()
  if self.v_room_preload and self.v_room_preload:update_preload_res() then
    self.v_room_preload = nil
  end
end

function M:_preload_res_done_cb()
  self:set_pre_fight_story_play_state(PRE_FIGHT_STORY_STATE.WAIT_START)
  SceneMgr:set_curtain_show(true)
  SceneMgr:set_scene_on_story_room()
  if not Util.is_empty(self.v_scene_logic_id) then
    SceneMgr:create_scene_logic_on_story_room(self.v_scene_logic_id, self)
    self:_play_pre_fight_story()
  else
    StoryMgr:on_start(self.v_archive_video_cfg.PoltId)
  end
  UIMgr:get_ui("ui_blackfade"):ui_show(0, 0.1)
  Global.sound_mgr:set_audio_active(true, true, 1)
end

function M:enter_room()
  self.v_on_enter_room = true
  
  local function preload_res_cb()
    self:_preload_res_done_cb()
  end
  
  self:preload_res(preload_res_cb)
end

function M:scene_ready_end_logic()
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  MsgGame:mq_publish2(Const.MSG_ON_SCENE_READY)
  SceneMgr:start_scene_logic()
end

function M:on_pre_fight_play(state)
  if self.v_pre_fight_story_play_state == state then
    if self.v_pre_fight_story_play_state == PRE_FIGHT_STORY_STATE.WAIT_START then
      self.v_pre_fight_story_play_state = PRE_FIGHT_STORY_STATE.WAIT_END
      SceneMgr:set_curtain_show(false)
    elseif self.v_pre_fight_story_play_state == PRE_FIGHT_STORY_STATE.WAIT_END then
      self.v_pre_fight_story_play_state = PRE_FIGHT_STORY_STATE.NONE
      SceneMgr:set_curtain_show(true)
      TowerMgr:exit_story_room()
      self.v_on_enter_room = false
    end
  end
end

function M:init_room_preload()
  if not self.v_room_preload then
    self.v_room_preload = require("gamelogic.tower_mgr.story_room_preload"):new(self.room_preload_cfg, nil, nil, self.v_archive_video_id)
  end
end

function M:preload_res(cb)
  self:init_room_preload()
  self.v_room_preload:set_callback(cb)
end

function M:release()
  self.v_room_preload = nil
  local msg = MsgGame:mq_publish2(Const.MSG_ON_LEAVE_ROOM)
  msg.mm_obj = self.v_room_num
  ResPoolMgr:clear_room_pool()
end

function M:get_diff_light_index()
  return self.v_floor_cfg and self.v_floor_cfg.LightFxIdx or 0
end

function M:get_diff_light_index_AB()
  return self.v_floor_cfg and self.v_floor_cfg.LightFxIdxAB
end

return M
