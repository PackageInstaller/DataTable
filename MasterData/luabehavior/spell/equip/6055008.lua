local M = Util.create_class()

function M:_init()
  self.var = nil
end

function M:on_magic_begin(npc, target, magic_id)
  if 1999050 ~= magic_id then
    return
  end
  local search_list = search_npc(self.npc, 4, 30, nil, 1, true)
  for i, v in pairs(search_list) do
    if not check_magic(v, 60550083) and check_magic(v, 1999050) then
      cast_magic(v, v, 60550083, 1)
      cast_magic(self.npc, self.npc, 60550081, 1)
      cast_magic(self.npc, self.npc, 60550082, 1)
      cast_missile(npc, self.npc, nil, nil, 10019015001, 1)
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 1999050 ~= magic_id then
    return
  end
  abort_magic_by_id(self.npc, 60550081, 1)
  abort_magic_by_id(self.npc, 60550082, 1)
  abort_magic_by_id(self.npc, 60550084, 1)
  abort_magic_by_id(self.npc, 60550085, 1)
  abort_magic_by_id(target, 60550083, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and missile_cfg.Id == 10019015001 then
    cast_magic(self.npc, self.npc, 60550084, 1)
    cast_magic(self.npc, self.npc, 60550085, 1)
  end
end

function M:on_npc_removed(npc)
  if not check_magic(npc, 1999050) then
    return
  end
  abort_magic_by_id(self.npc, 60550081, 1)
  abort_magic_by_id(self.npc, 60550082, 1)
  abort_magic_by_id(self.npc, 60550085, 1)
  abort_magic_by_id(npc, 60550083, 1)
end

return M
