local M = Util.create_class()
local CD = 0

function M:_init(npc)
  self.kill_numbs = 0
  self.hero1 = nil
end

function M:on_start()
  self.hero1 = get_come_on_hero()
  self.hero2 = get_scene_hero_by_poskey(21)
  self.hero3 = get_scene_hero_by_poskey(22)
  cast_magic(self.npc, self.npc, 6070040, 1)
  cast_magic(self.npc, self.hero2, 6070040, 1)
  cast_magic(self.npc, self.hero3, 6070040, 1)
end

function M:logic(now_hp)
  if self.kill_numbs >= 30 then
    abort_magic_by_id(self.npc, 6070040)
    abort_magic_by_id(self.hero2, 6070040)
    abort_magic_by_id(self.hero3, 6070040)
    abort_magic_by_id(self.npc, 607004)
  end
end

function M:on_frame()
  self:logic()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if is_showup then
    self.hero1 = get_come_on_hero()
  end
end

function M:on_frame_background()
  if self.hero1 ~= self.npc then
    self:logic()
  end
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.hero2 and npc ~= self.hero3 and npc ~= self.hero1 then
    self.kill_numbs = self.kill_numbs + 1
  end
end

return M
