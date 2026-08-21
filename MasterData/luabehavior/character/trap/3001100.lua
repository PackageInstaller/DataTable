local monster = Util.create_class()
local clueMgr = import("character.trap.3001099_1")

function monster:_init(npc)
  self.npc = npc
  set_can_searched(self.npc, false)
  clueMgr:add_clue(self.npc)
end

function monster:on_remove()
  clueMgr:remove_clue(self.npc)
end

return monster
