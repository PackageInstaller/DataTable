local M = Util.create_class()
local tool = import("common.tool")

function M:on_start()
  cast_magic(self.npc, self.npc, 6170812)
  cast_magic(self.npc, self.npc, 6170813)
  cast_magic(self.npc, self.npc, 6170821)
  cast_magic(self.npc, self.npc, 6170822)
  cast_magic(self.npc, self.npc, 6170823)
  cast_magic(self.npc, self.npc, 6170831)
  cast_magic(self.npc, self.npc, 6170834)
  cast_magic(self.npc, self.npc, 6170835)
  cast_magic(self.npc, self.npc, 6170836)
end

function M:_init(npc)
end

return M
