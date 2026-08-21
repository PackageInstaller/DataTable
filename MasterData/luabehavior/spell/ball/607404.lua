local M = Util.create_class()

function M:_init()
  self.ball = 0
  self.npc1 = nil
  self.npc2 = nil
  self.npc3 = nil
end

function M:on_start()
  if get_come_on_hero() then
    self.npc1 = get_come_on_hero()
  end
  if get_scene_hero_by_poskey(21) then
    self.npc2 = get_scene_hero_by_poskey(21)
  end
  if get_scene_hero_by_poskey(22) then
    self.npc3 = get_scene_hero_by_poskey(22)
  end
  local ball3 = get_ball_level()
  self.ball = ball3.blue // 20
  if 0 ~= self.ball then
    if self.npc1 then
      cast_magic(self.npc1, self.npc1, 60740401, self.ball)
    end
    if self.npc2 then
      cast_magic(self.npc2, self.npc2, 60740401, self.ball)
    end
    if self.npc3 then
      cast_magic(self.npc3, self.npc3, 60740401, self.ball)
    end
  end
end

function M:on_ball_level_change(red, blue, yellow)
  local ball2 = blue // 20
  if self.ball == ball2 then
    return
  end
  self.ball = ball2
  if 0 == self.ball then
    abort_magic_by_id(self.npc1, 60740401, 1)
    if self.npc2 then
      abort_magic_by_id(self.npc2, 60740401, 1)
    end
    if self.npc3 then
      abort_magic_by_id(self.npc3, 60740401, 1)
    end
    return
  end
  if self.npc1 then
    cast_magic(self.npc1, self.npc1, 60740401, self.ball)
  end
  if self.npc2 then
    cast_magic(self.npc2, self.npc2, 60740401, self.ball)
  end
  if self.npc3 then
    cast_magic(self.npc3, self.npc3, 60740401, self.ball)
  end
end

function M:on_remove()
  if 0 == self.ball then
    return
  end
  abort_magic_by_id(self.npc1, 60740401, 1)
  if self.npc2 then
    abort_magic_by_id(self.npc2, 60740401, 1)
  end
  if self.npc3 then
    abort_magic_by_id(self.npc3, 60740401, 1)
  end
end

return M
