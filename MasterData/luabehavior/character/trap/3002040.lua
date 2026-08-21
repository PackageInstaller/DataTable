local M = Util.create_class()
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function M:_init(npc)
  self.control = nil
  set_npc_status(npc, 4, true)
  self.skill_standby = 300204001
  self.skill_move = 300204002
  self.skill_boom_warning = 300204003
  self.skill_boom = 300204004
  self.missile_arrow = 30020400102
  self.missile_move = 30020400201
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.missile_move, self.on_missile_hit_monster, self)
  set_npc_target_dir(npc, 0, 1)
  cast_skill(npc, nil, self.skill_standby)
  self.standby = true
  self.arrow = false
end

function M:on_target_self_skill_hit(skill_id, attacker, hit_type, missile_cfg, missile)
  if attacker ~= get_come_on_hero() then
    return
  end
  self.mis = string.sub(tostring(missile_cfg.Id), 1, 4)
  if self.mis ~= "1001" then
    return
  end
  self.standby = false
  cast_magic(self.npc, self.npc, 399930, 1)
  set_npc_status(self.npc, 3, true)
  move_by_dir(self.npc)
  cast_missile(self.npc, self.npc, nil, nil, self.missile_move, 1)
  if get_sync_var("move_time") then
    change_missile_config(self.missile_move, "LiveTime", get_sync_var("move_time"), 0)
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break)
  if skill_id == self.skill_boom_warning then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill_boom)
  elseif skill_id == self.skill_boom then
    remove_npc(self.npc)
  end
end

function M:on_self_missile_end_pos(pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == self.missile_move then
    stop_move(self.npc)
    abort_skill(self.npc)
    if get_sync_var("no_warning") then
      cast_skill(self.npc, nil, self.skill_boom)
      return
    end
    cast_skill(self.npc, nil, self.skill_boom_warning)
  end
end

function M:on_missile_hit_monster(owner, target_npc, missile_cfg, missile)
  if owner == self.npc and 1 ~= get_role_kind(target_npc) and 5 ~= get_role_kind(target_npc) and get_npc_id(target_npc) ~= 10010191 then
    remove_missile(missile)
  end
end

function M:on_room_pass(room_id)
  if not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
  end
end

function M:on_frame()
  local target = get_come_on_hero()
  if self.standby and check_npc_distance(self.npc, target, 4, true) then
    lookat_npc(self.npc, target, false)
    if not self.arrow then
      lookat_npc(self.npc, target, true)
      self.fx_arrow = play_effect(self.npc, "Fx_skillarea_BattingBoomer", "BottomPoint", false)
      self.arrow = true
    end
  elseif self.arrow then
    stop_effect(self.npc, self.fx_arrow)
    self.arrow = false
  end
end

return M
