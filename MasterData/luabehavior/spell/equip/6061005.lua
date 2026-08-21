local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, atk_target)
  if check_magic(atk_target, 1999010) then
    cast_magic(owner, owner, 60610052, 1)
    cast_magic(owner, owner, 60610053, 1)
    cast_magic(owner, owner, 60610054, 1)
  end
  if check_magic(atk_target, 1999020) then
    cast_magic(owner, owner, 60610051, 1)
    cast_magic(owner, owner, 60610053, 1)
    cast_magic(owner, owner, 60610054, 1)
  end
  if check_magic(atk_target, 1999030) then
    cast_magic(owner, owner, 60610051, 1)
    cast_magic(owner, owner, 60610052, 1)
    cast_magic(owner, owner, 60610054, 1)
  end
  if check_magic(atk_target, 1999040) then
    cast_magic(owner, owner, 60610051, 1)
    cast_magic(owner, owner, 60610052, 1)
    cast_magic(owner, owner, 60610053, 1)
  end
  if check_magic(atk_target, 1999050) then
    cast_magic(owner, owner, 60610051, 1)
    cast_magic(owner, owner, 60610052, 1)
    cast_magic(owner, owner, 60610053, 1)
    cast_magic(owner, owner, 60610054, 1)
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
