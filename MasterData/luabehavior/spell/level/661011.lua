local M = Util.create_class()

function M:_init()
  self.come_on_hero = nil
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
  end
end

function M:on_before_npc_hp_zero(npc)
  if self.npc ~= self.come_on_hero then
    return
  end
  local npc_kind = get_role_kind(npc)
  if npc_kind >= 2 and npc_kind <= 4 or 7 == npc_kind then
    local random = math.random(1, 100)
    if random <= 30 then
      local hero_pos = get_npc_pos(self.come_on_hero)
      local pos = get_npc_pos(npc)
      cast_missile(npc, nil, pos.x, pos.z, 10018010201, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010202, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010203, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010204, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010205, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010206, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
    end
  end
end

return M
