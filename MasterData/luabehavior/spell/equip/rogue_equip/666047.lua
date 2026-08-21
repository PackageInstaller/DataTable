local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
  self:self_cast_magic(self.come_on_hero)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if true == is_showup then
    self.come_on_hero = npc
    self:self_cast_magic(self.come_on_hero)
  end
end

function M:on_frame()
  self:self_cast_magic(self.come_on_hero)
end

function M:self_cast_magic(npc)
  local magic_level = 0
  magic_level = math.floor((1 - get_npc_attr(npc, 1) / get_npc_attr(npc, 4)) * 10)
  if 0 ~= magic_level then
    cast_magic(npc, npc, 66604701, magic_level)
  end
end

return M
