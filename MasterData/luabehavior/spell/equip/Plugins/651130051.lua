local M = Util.create_class()
local tool = import("common.tool")
local team = tool.team.npc

function M:_init()
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651130051)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 4 == element then
    cast_magic(self.npc, self.npc, 651130052, self.level)
    return
  end
  if 1 == element then
    cast_magic(self.npc, self.npc, 651130052, self.level)
  end
end

return M
