local M = Util.create_class()

function M:_init(npc)
  self.skill01 = {
    300203601,
    5.0,
    0,
    0,
    0,
    get_skill_cfg(315010201).CastTime,
    get_skill_cfg(315010201).AfterTime
  }
  self.skill02 = {
    300203602,
    0.0,
    0,
    0,
    0,
    get_skill_cfg(315010102).CastTime,
    get_skill_cfg(315010102).AfterTime
  }
  self.control = 0
  cast_skill(npc, nil, self.skill02[1], nil, nil)
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.skillDelay = 0
  self.startTime = get_npc_time(npc)
end

function M:skill_logic(skill_instant_ID)
  if skill_instant_ID == self.skill01 then
    if 1 == self.control then
      return
    else
      abort_skill(self.npc)
      cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
      self.control = 1
    end
  elseif skill_instant_ID == self.skill02 then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if skill_id == self.skill02[1] and npc == self.npc then
    self:skill_logic(self.skill01)
  end
end

function M:on_room_pass(room_id)
  abort_skill(self.npc)
end

function M:on_frame()
  if 0 == self.skillDelay then
    return
  elseif get_npc_time(self.npc) - self.startTime >= self.skillDelay then
    self.control = 0
    cast_skill(self.npc, nil, self.skill02[1], nil, nil)
    self.skillDelay = 0
  end
end

return M
