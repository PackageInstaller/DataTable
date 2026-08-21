local M = Util.create_class()

function M:_init()
  self.magic_set = nil
end

function M:on_start()
  cast_magic(self.npc, self.npc, 4032905, 1)
  self.magictime = os.time()
end

function M:on_frame()
  if os.time() > self.magictime + 1 and get_npc_attr(self.npc, 1) < get_npc_attr(self.npc, 4) then
    cast_magic(self.npc, self.npc, 4032906, 1)
    self.magictime = os.time()
  end
end

return M
