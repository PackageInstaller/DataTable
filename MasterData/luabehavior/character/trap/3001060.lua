local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local misle = 0
local fall_pos, summon_pos

function M:_init()
  self.skill01 = {
    300106001,
    3,
    0,
    0,
    0,
    get_skill_cfg(300106001).CastTime,
    get_skill_cfg(300106001).AfterTime
  }
  self.control = nil
  self.target = nil
  self.splash_timer = nil
  summon_pos = {
    0,
    0,
    0
  }
end

function M:skill_logic()
  if 0 == self.control and self.target then
    self:cast_skill(self.skill01)
  else
    self.control = nil
  end
end

function M:cast_skill(skill_instant_ID)
  if self.target then
    fall_pos = get_npc_pos(self.target)
  end
  if 300106001 == skill_instant_ID[1] and self.target then
    summon_pos.x = fall_pos.x + math.random(-2, 2)
    summon_pos.z = fall_pos.z + math.random(-2, 2)
    cast_skill(self.npc, nil, 300106001, summon_pos.x, summon_pos.z)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 8, nil, 1)
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  self:skill_logic()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
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
