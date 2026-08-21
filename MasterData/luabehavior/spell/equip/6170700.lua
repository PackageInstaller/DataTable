local M = Util.create_class()
local tool = import("common.tool")

function M:on_start()
  cast_magic(self.npc, self.npc, 6170703)
  cast_magic(self.npc, self.npc, 6170712)
  cast_magic(self.npc, self.npc, 6170713)
  cast_magic(self.npc, self.npc, 6170721)
  cast_magic(self.npc, self.npc, 6170732)
end

function M:_init(npc)
end

return M
