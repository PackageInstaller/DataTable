local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:effect_aborn_magic(npc, target, element)
  if npc ~= self.npc then
    return
  end
  cast_magic(self.npc, target, 6031043, 1)
  cast_magic(self.npc, target, 6031044, 1)
  cast_magic(self.npc, target, 6031045, 1)
  cast_magic(self.npc, target, 6031046, 1)
  cast_magic(self.npc, target, 6031047, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg)
  if npc ~= self.npc then
    return
  end
  if check_magic(hit_target, 6031043) then
    abort_magic_by_id(hit_target, 6031043)
    abort_magic_by_id(hit_target, 6031044)
    abort_magic_by_id(hit_target, 6031045)
    abort_magic_by_id(hit_target, 6031046)
    abort_magic_by_id(hit_target, 6031047)
  end
end

return M
