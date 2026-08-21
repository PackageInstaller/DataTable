local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local ability = 60003
local level = 1
local magic_list = {
  61705031,
  61705032,
  61705033,
  61705034,
  61705035
}

function M:_init(npc)
end

function M:on_start()
end

function M:on_npc_born(npc)
  if 1 ~= get_role_kind(npc) and get_come_on_hero() == self.npc then
    for k, v in pairs(magic_list) do
      cast_magic(self.npc, npc, v, level)
    end
  end
end

return M
