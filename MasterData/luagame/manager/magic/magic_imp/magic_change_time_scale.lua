local TARGET_TYPE = {
  SELF = 0,
  ALL_NPC = 1,
  TIME_SCALE = 2,
  ALL_ENEMY = 3,
  OTHER = 4
}
local TARGET_TYPE_FUNC_NAME = {
  [TARGET_TYPE.SELF] = "add_self_time_scale",
  [TARGET_TYPE.ALL_NPC] = "add_all_npc_time_scale",
  [TARGET_TYPE.TIME_SCALE] = "add_global_time_scale",
  [TARGET_TYPE.ALL_ENEMY] = "add_all_enemy_time_scale",
  [TARGET_TYPE.OTHER] = "add_other_time_scale"
}
local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect(magic_list)
  local scale = self.cfg[1]
  local duration = Util.frame2realtime(self.cfg[2], 0)
  local ease_in = Util.frame2realtime(self.cfg[3], 0)
  local ease_out = Util.frame2realtime(self.cfg[4], 0)
  self.v_target_type = self.cfg[5]
  local ignoral_missile = self.cfg[6]
  local impact_sound_type = self.cfg[7]
  local impact_sound_volume = self.cfg[8]
  local ignore_move = self.cfg[9]
  local func_name = TARGET_TYPE_FUNC_NAME[self.v_target_type]
  if func_name then
    self[func_name](self, scale, duration, ease_in, ease_out, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move)
  end
end

function M:on_remove(magic_list)
  if self.v_target_type == TARGET_TYPE.SELF then
    self.owner.time_mgr:remove_time_scale(self.magic_id)
  elseif self.v_target_type == TARGET_TYPE.TIME_SCALE then
    if GlobalTimeMgr:remove_globale_time_scale(self.v_time_scale_index) then
      SceneMgr:set_gloabl_time_scale()
    end
  elseif self.v_target_type == TARGET_TYPE.ALL_NPC then
    SceneMgr:remove_obj_time_scale(self.magic_id, false)
  elseif self.v_target_type == TARGET_TYPE.ALL_ENEMY then
    SceneMgr:remove_obj_time_scale(self.magic_id, true)
  elseif self.v_target_type == TARGET_TYPE.OTHER then
    SceneMgr:remove_other_time_scale(self.magic_id, self.owner.uuid)
  end
end

function M:add_self_time_scale(scale, duration, ease_in, ease_out, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move)
  local scale_data = {
    ease_in = ease_in,
    ease_out = ease_out,
    magic_id = self.magic_id,
    ignoral_missile = ignoral_missile,
    impact_sound_type = impact_sound_type,
    impact_sound_volume = impact_sound_volume,
    ignore_move = ignore_move
  }
  self.owner.time_mgr:add_time_scale(scale, duration, scale_data)
end

function M:add_all_npc_time_scale(scale, duration, ease_in, ease_out, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move)
  SceneMgr:add_obj_time_scale(scale, duration, ease_in, ease_out, self.magic_id, nil, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move, false)
end

function M:add_global_time_scale(scale, duration, ease_in, ease_out, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move)
  self.v_time_scale_index = GlobalTimeMgr:add_global_time_scale(scale)
  SceneMgr:set_gloabl_time_scale(duration, true, ease_in, ease_out, self.owner, self.v_time_scale_index, self.magic_id)
end

function M:add_all_enemy_time_scale(scale, duration, ease_in, ease_out, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move)
  SceneMgr:add_obj_time_scale(scale, duration, ease_in, ease_out, self.magic_id, nil, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move, true)
end

function M:add_other_time_scale(scale, duration, ease_in, ease_out, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move)
  SceneMgr:add_other_time_scale(scale, duration, ease_in, ease_out, self.magic_id, nil, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move, self.owner.uuid)
end

function M:get_target_type()
  return self.v_target_type
end

return M
