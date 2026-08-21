local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
  rogueMgr.huisu = 61706141
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if attacker == self.npc then
    local level = get_ability_level(20011) or 1
    if level > 1 then
      tool:castMagicToTeam(rogueMgr.huisu)
    else
      cast_magic(self.npc, self.npc, rogueMgr.huisu)
    end
  end
end

return M
