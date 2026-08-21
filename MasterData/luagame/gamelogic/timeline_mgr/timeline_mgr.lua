local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
M.preload_timeline_list = nil
M.curr_scene_preload_timeline_list = {}

function M:get_is_need_play_timeline_audio(timeline_name)
  self:set_preload_timeline_list()
  if self.curr_scene_preload_timeline_list[timeline_name] ~= nil then
    return true
  end
  local status = self.preload_timeline_list[timeline_name]
  if nil ~= status then
    self.curr_scene_preload_timeline_list[timeline_name] = status
  end
  return nil == status
end

function M:set_preload_timeline_list()
  if self.preload_timeline_list == nil then
    self.preload_timeline_list = {}
    local all_config = ShareRes.get_tower_preload_cfg()
    for k1, v1 in pairs(all_config) do
      if not v1 then
      else
        for k2, v2 in pairs(v1) do
          if not v2 or not v2.TimeLineRes then
          else
            for k3, v3 in pairs(v2.TimeLineRes) do
              if not v3 then
              else
                for k4, v4 in pairs(v3) do
                  if nil ~= v4 and "" ~= v4 then
                    self.preload_timeline_list[v4] = 1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

function M:clear_curr_scene_preload_timeline()
  self.curr_scene_preload_timeline_list = {}
end

M.curr_timeline_audio_name = nil
M.curr_timeline_audio_id = nil

function M:set_curr_timeline_audio(type, audio)
  if 1 == type then
    self.curr_timeline_audio_name = audio
  else
    self.curr_timeline_audio_id = audio
  end
end

function M:clear_curr_timelin_audio()
  self.curr_timeline_audio_name = nil
  self.curr_timeline_audio_id = nil
end

function M:check_curr_timeline_audio()
  if self.curr_timeline_audio_name then
    local sound_info = ShareRes.get_play_sound_info(self.curr_timeline_audio_name)
    Global.sound_mgr:remove_cue_sheet(sound_info)
  end
end

function M:register_track_play_sound(sound, stop_on_skip, track_cri)
  self.v_track_sound = self.v_track_sound or {}
  self.v_stop_on_skip = self.v_stop_on_skip or {}
  self.v_track_cri = self.v_track_cri or {}
  self.v_track_idx = self.v_track_idx or 0
  self.v_track_idx = self.v_track_idx + 1
  self.v_track_sound[self.v_track_idx] = sound
  self.v_stop_on_skip[self.v_track_idx] = stop_on_skip
  self.v_track_cri[self.v_track_idx] = track_cri
end

function M:on_timeline_skip()
  if self.v_track_idx == nil or self.v_track_idx < 1 then
    return
  end
  for i = 1, self.v_track_idx do
    local track_sound = self.v_track_sound[i]
    local stop_on_skip = self.v_stop_on_skip[i]
    local track_cri = self.v_track_cri[i]
    if stop_on_skip and track_sound then
      Global.sound_mgr:stop_sound_by_id(track_sound, track_cri)
      self.v_track_sound[i] = nil
      self.v_stop_on_skip[i] = nil
      self.v_track_cri[i] = nil
    end
  end
  self.v_track_idx = nil
end

return M
