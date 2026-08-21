local M = Util.create_class()

function M:_init(npc)
end

function M:on_magic_begin(npc, target, magic_id)
  if target == self.npc and 3001039001 == magic_id then
    set_sync_var("tips2", true)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if target == self.npc and 3001039001 == magic_id then
    set_sync_var("tips2", false)
  end
end

return M
