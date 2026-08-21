local M = Util.create_class()

function M:_init()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if not check_magic(hit_target, 1999020) then
    return
  end
  if 1 ~= get_skill_cfg(skill_id).SkillType and 5 ~= get_skill_cfg(skill_id).SkillType and 6 ~= get_skill_cfg(skill_id).SkillType then
    local random_choice = math.random() * 100
    if random_choice <= 10 then
      cast_missile(self.npc, hit_target, nil, nil, 10019010701, 1)
    end
  end
end

return M
