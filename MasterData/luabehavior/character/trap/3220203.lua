local M = Util.create_class()

function M:_init(npc)
  npc.search = {}
  enable_shadow(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  set_can_searched(npc, false)
  cast_magic(npc, npc, 399001, 1)
  atk = 322020301
  open = 322020302
  if get_sync_var("fire") ~= nil then
    self.fire_max = get_sync_var("fire")
  else
    self.fire_max = 1
  end
  self.fire_times = self.fire_times
end

function M:on_npc_born(npc)
  if npc == self.npc then
    cast_skill(self.npc, nil, open)
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break)
  if skill_id == atk then
    self.fire_times = self.fire_times - 1
    if self.fire_times > 0 then
      cast_skill(self.npc, nil, atk)
    else
      cast_skill(self.npc, nil, open)
    end
  elseif skill_id == open then
    self.fire_times = self.fire_max
    cast_skill(self.npc, nil, atk)
  end
end

return M
