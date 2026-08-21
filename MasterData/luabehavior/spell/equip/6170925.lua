local M = Util.create_class()
local tool = import("common.tool")

function M:_init(npc)
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if magic_kind and magic_kind[61709] then
    cast_magic(self.npc, self.npc, 61709251, self.level)
  end
end

function M:on_room_change(room_id)
  self.level = get_ability_level(30016) or 1
end

function M:on_start()
  self.level = get_ability_level(30016) or 1
end

return M
