local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, atk_target)
  if check_magic(atk_target, 1999040) then
    cast_magic(owner, owner, 606100821, 1)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == get_come_on_hero() then
    self:creat_magic(npc, hit_target)
  end
end

function M:on_frame()
end

return M
