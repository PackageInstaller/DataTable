local M = Util.create_class()
local tool = import("common.tool")
local current_time = 0
local CD = 1

function M:on_room_change(npc)
  self.level = get_ability_level(30011) or 1
end

function M:on_start()
  self.level = get_ability_level(30011) or 1
end

function M:_init(npc)
end

function M:after_heal_self(npc, magic_id, heal_val)
  if 1 == self.level and not check_magic(self.npc, 61709131) then
    cast_magic(self.npc, self.npc, 61709131)
    cast_magic(self.npc, self.npc, 61709132)
  elseif not check_magic(self.npc, 61709133) then
    cast_magic(self.npc, self.npc, 61709133)
    cast_magic(self.npc, self.npc, 61709134)
  end
end

return M
