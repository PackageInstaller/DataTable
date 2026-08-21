local M = Util.create_class()

function M:_init(npc)
  self.come_on_hero = nil
  self.magic_numbs = 3
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
  if self.magic_numbs > 0 and self.come_on_hero == self.npc and npc.id ~= 1002002 then
    if 2 ~= get_role_kind(npc) then
      return
    end
    local random = math.random(1, 10)
    if random >= 8 then
      cast_missile(npc, self.npc, nil, nil, 10018010101, 1, nil, nil)
      cast_missile(npc, self.npc, nil, nil, 10018010102, 1, nil, nil)
      cast_missile(npc, self.npc, nil, nil, 10018010103, 1, nil, nil)
    end
  end
end

function M:on_frame()
end

function M:disenagement_from_battle()
  if not is_in_challenge() then
    self.blood = 0
  end
  if is_pass_room() then
    self.blood = 0
  end
end

return M
