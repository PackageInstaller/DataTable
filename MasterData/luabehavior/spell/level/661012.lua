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
    local skillType = math.random(1, 3)
    local hero_pos = get_npc_pos(self.come_on_hero)
    local pos = get_npc_pos(npc)
    if 1 == skillType then
      cast_missile(npc, nil, pos.x, pos.z, 10018010301, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010302, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010303, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
    end
    if 2 == skillType then
      cast_missile(npc, nil, pos.x, pos.z, 10018010304, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010305, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010306, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
    end
    if 3 == skillType then
      cast_missile(npc, nil, pos.x, pos.z, 10018010307, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010308, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
      cast_missile(npc, nil, pos.x, pos.z, 10018010309, 1, pos.x, pos.z, hero_pos.y, hero_pos.y, pos.x, pos.z, hero_pos.y)
    end
  end
end

return M
