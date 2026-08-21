local M = Util.create_class()

function M:_init(npc)
  self.timer = 1
  self.trigger_time = get_time() + self.timer
end

function M:on_frame()
  local nowtime = get_time()
  if nowtime > self.trigger_time then
    if search_npc(self.npc, 2, 15, 0, 0) then
      abort_magic_by_id(self.npc, 6040071, 0)
      abort_magic_by_id(self.npc, 6040072, 0)
    else
      cast_magic(self.npc, self.npc, 6040071, 0)
      if not check_magic(self.npc, 6040072) then
        cast_magic(self.npc, self.npc, 6040072, 0)
      end
    end
    self.trigger_time = nowtime + self.timer
  end
end

return M
