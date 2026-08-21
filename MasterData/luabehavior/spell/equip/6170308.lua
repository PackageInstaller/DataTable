local M = Util.create_class()
local team_hero_list = {}
local time = 0
local hero_time = 0
local hero_time_level = 0
local hero_showup = false
local ability = 40008
local level = 1
local magic_1 = {61703081, 61703082}

function M:_init(npc)
end

function M:on_start()
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    abort_magic_by_id(self.npc, 61703081)
    abort_magic_by_id(self.npc, 61703082)
    hero_time = time + 3
    hero_time_level = 0
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc then
    if true == is_showup then
      hero_time = time + 3
    elseif false == is_showup then
      hero_time_level = 0
      abort_magic_by_id(self.npc, 61703081)
      abort_magic_by_id(self.npc, 61703082)
    end
  end
end

function M:on_frame()
  time = get_time()
  if self.npc == get_come_on_hero() and time >= hero_time and hero_time_level <= 3 then
    hero_time = time + 3
    hero_time_level = hero_time_level + 1
    cast_magic(self.npc, self.npc, 61703081, level)
    cast_magic(self.npc, self.npc, 61703082, level)
  end
end

return M
