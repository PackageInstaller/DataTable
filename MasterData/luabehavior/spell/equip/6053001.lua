local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, target)
  if check_magic(target, 1999030) and math.random(1, 10) <= 3 and get_npc_time(owner) >= self.time then
    cast_magic(owner, target, 60530011, 1)
    self.time = get_npc_time(owner) + 0.25
    return
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 0 ~= hit_type and npc == get_come_on_hero() and check_magic(hit_target, 1999030) then
    self:creat_magic(npc, hit_target)
  end
end

function M:on_frame()
end

return M
