local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  self.control = nil
  self.target = nil
  self.laser_missile = {
    [1] = 30020080101,
    [2] = 30020080102
  }
  self.skill_set = false
  self.effect_missile = {}
end

function M:on_start()
  listen_missile_end_pos(self.npc, self.laser_missile[1], self.on_missile_end_pos, self)
  listen_missile_end_pos(self.npc, self.laser_missile[2], self.on_missile_end_pos, self)
  listen_missile_begin_pos(self.npc, self.laser_missile[2], self.on_missile_begin_pos, self)
end

function M:on_remove()
  unlisten_missile_end_pos(self.npc, self.laser_missile[1], self)
  unlisten_missile_end_pos(self.npc, self.laser_missile[2], self)
  unlisten_missile_begin_pos(self.npc, self.laser_missile[2], self)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner == self.npc and missile_cfg.Id == self.laser_missile[2] then
    self.effect_missile[1] = missile
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc or missile_cfg.Id == self.laser_missile[1] then
  end
end

function M:move_func(control1_dir, control2_dir)
  local timer
  if get_sync_var("T3002008_movetimer") then
    timer = get_sync_var("T3002008_movetimer")
  else
    timer = 4
  end
  if 1 == self.control then
    switch_move_type(self.npc, control1_dir)
    CommonMonster.tiktok_timer_func(self, timer, function()
      self.control = 2
    end)
  elseif 2 == self.control then
    switch_move_type(self.npc, control2_dir)
    CommonMonster.tiktok_timer_func(self, timer, function()
      self.control = 1
    end)
  end
  self.control = 99
end

function M:skill_logic()
  if 99 ~= self.control and self.control ~= nil then
    if not self.skill_set then
      cast_missile(self.npc, nil, nil, nil, self.laser_missile[1], 1)
      cast_missile(self.npc, nil, nil, nil, self.laser_missile[2], 1)
      self.skill_set = true
    end
    if 1 == get_sync_var("T3002008_movedir") or not get_sync_var("T3002008_movedir") then
      self:move_func(3, 4)
    elseif 2 == get_sync_var("T3002008_movedir") then
      self:move_func(4, 3)
    end
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 18, nil, 1)
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  CommonMonster.tiktok_timer_frame(self)
  self:skill_logic()
  self:search_target()
  if self.target and self.control == nil then
    local now_time = get_npc_time(self.npc)
    if now_time >= 1.2 then
      self.control = 1
    end
  elseif self.target then
    move_by_dir(self.npc)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and npc ~= self.npc and hit_type > 0 then
    cast_magic(self.npc, self.npc, 3002002003, 2)
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc ~= self.npc then
    return
  end
  create_scene_effect("Fx_T3001010_05", npc:get_pos_vec3(), 0)
  self.npc:on_dead(nil, true)
  remove_npc(npc)
end

return M
