local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65056401) then
    cast_magic(self.npc, self.hero_one, 65056401, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65056401) then
    cast_magic(self.npc, self.hero_two, 65056401, 0)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  npc_id = get_npc_id(hit_target)
  if npc_id ~= 201203 and npc_id ~= 20120301 and npc_id ~= 20120302 then
    return
  else
    cast_magic(self.npc, self.npc, 65056402, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 65056402, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 65056402, 0)
    end
  end
end

function M:on_frame()
end

return M
