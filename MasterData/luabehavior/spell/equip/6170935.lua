local M = Util.create_class()
local tool = import("common.tool")

function M:after_heal_self(npc, magic_id, heal_val)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if not check_magic(self.npc, 61709351) then
    cast_magic(self.npc, self.npc, 61709351, self.level)
  end
end

function M:after_shield_target(npc, magic_id, shield_value)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if not check_magic(self.npc, 61709351) then
    cast_magic(self.npc, self.npc, 61709351, self.level)
  end
end

function M:on_fate_book_battle_start()
  self.level = get_ability_level(30021) or 1
end

function M:on_start()
  self.level = get_ability_level(30021) or 1
end

function M:_init(npc)
end

return M
