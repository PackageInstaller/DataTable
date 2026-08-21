local M = Util.create_class()
local tool = import("common.tool")
local team = tool.team.npc

function M:_init()
end

function M:before_shield_self(target, magic_id, shield_value)
  for _, value in pairs(team) do
    if self.npc ~= value then
      cast_magic(self.npc, value, 651130033, self.level, 1)
      cast_magic(self.npc, value, 651130034, self.level, 1)
    end
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651130031)
end

return M
