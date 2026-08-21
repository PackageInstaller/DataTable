local M = Util.create_class()

function M:_init()
  self.magic_1_timer = 0
  self.magic_2_timer = 0
end

function M:on_skill_begin(npc, skill_id)
  if check_magic(self.npc, 6021001) then
    abort_magic_by_id(self.npc, 6021017)
  end
  if check_magic(self.npc, 6021017) then
    abort_magic_by_id(self.npc, 6021001)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if npc ~= self.npc then
    return
  end
  if 1 == get_skill_cfg(skill_id).SkillType and get_npc_time(self.npc) > self.magic_1_timer then
    cast_magic(self.npc, self.npc, 6021001, 1)
    self.magic_1_timer = get_npc_time(self.npc) + 4
  end
  if 2 == get_skill_cfg(skill_id).SkillType and get_npc_time(self.npc) > self.magic_2_timer then
    cast_magic(self.npc, self.npc, 6021017, 1)
    self.magic_2_timer = get_npc_time(self.npc) + 4
  end
end

return M
