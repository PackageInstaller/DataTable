local M = Util.create_class()

function M:_init()
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  if not check_magic(npc, 1999010) then
    return
  end
  self:cast_magic_to_team(60510071)
  self:cast_magic_to_team(60510072)
  self:cast_magic_to_team(60510073)
  self:cast_magic_to_team(60510074)
end

function M:cast_magic_to_team(magic_id)
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if teammate1 then
    cast_magic(self.npc, teammate1, magic_id, 0)
  end
  if teammate2 then
    cast_magic(self.npc, teammate2, magic_id, 0)
  end
  cast_magic(self.npc, self.npc, magic_id, 0)
end

return M
