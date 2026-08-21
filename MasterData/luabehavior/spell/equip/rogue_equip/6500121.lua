local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.ball_counting = get_team_rune_count_by_type(1)
end

function M:on_start()
  if 1 == self.ball_counting then
    cast_magic(self.npc, self.npc, 650012011, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650012011, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650012011, 0)
    end
  elseif 2 == self.ball_counting then
    cast_magic(self.npc, self.npc, 650012012, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650012012, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650012012, 0)
    end
  elseif 3 == self.ball_counting then
    cast_magic(self.npc, self.npc, 650012013, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650012013, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650012013, 0)
    end
  end
end

function M:change_magic_level()
  if 1 == self.ball_counting then
    cast_magic(self.npc, self.npc, 650012011, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650012011, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650012011, 0)
    end
  elseif 2 == self.ball_counting then
    cast_magic(self.npc, self.npc, 650012012, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650012012, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650012012, 0)
    end
  elseif 3 == self.ball_counting then
    cast_magic(self.npc, self.npc, 650012013, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650012013, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650012013, 0)
    end
  elseif 0 == self.ball_counting then
    abort_magic_by_id(self.npc, 650012011)
    abort_magic_by_id(self.npc, 650012012)
    abort_magic_by_id(self.npc, 650012013)
    if self.hero_one then
      abort_magic_by_id(self.npc, 650012011)
      abort_magic_by_id(self.npc, 650012012)
      abort_magic_by_id(self.npc, 650012013)
    end
    if self.hero_two then
      abort_magic_by_id(self.npc, 650012011)
      abort_magic_by_id(self.npc, 650012012)
      abort_magic_by_id(self.npc, 650012013)
    end
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    self.ball_counting = get_team_rune_count_by_type(1)
    self:change_magic_level()
  end
end

function M:on_frame()
end

return M
