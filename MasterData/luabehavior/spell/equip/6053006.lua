local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.monster_list = {}
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if not check_magic(hit_target, 1999030) then
    return
  end
  self.monster_list = search_npc(self.npc, 4, 8, nil, 0, true)
  if self.monster_list == nil then
    return
  end
  if 1 == get_skill_cfg(skill_id).SkillType then
    for i, v in pairs(self.monster_list) do
      if v ~= hit_target then
        cast_magic(self.npc, v, 60530061, 1)
        cast_missile(hit_target, v, nil, nil, 10019014001, 1)
      end
    end
  end
end

function M:on_frame()
end

return M
