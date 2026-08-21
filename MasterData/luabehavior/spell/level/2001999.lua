local M = Util.create_class()

function M:_init()
  self.kill_count = 0
end

function M:on_before_npc_hp_zero(npc)
  if self.kill_count == nil then
    return
  end
  if get_role_kind(npc) >= 2 and get_role_kind(npc) <= 4 then
    self.kill_count = self.kill_count + 1
  end
  if self.kill_count >= 40 then
    set_sync_var("add_elite", true)
    self.kill_count = nil
    abort_magic_by_id(get_god_npc(), 2001999, 1)
  end
end

return M
