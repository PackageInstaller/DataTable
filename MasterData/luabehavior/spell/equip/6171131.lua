local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  local level = get_ability_level(10017) or 1
  if level and level > 1 then
    self.layer = 2
  else
    self.layer = 1
  end
end

function M:on_room_change(npc)
  local level = get_ability_level(10017) or 1
  if level and level > 1 then
    self.layer = 2
  else
    self.layer = 1
  end
end

function M:after_shield_target(target, magic_id, shield_value)
  if get_magic_num(self.npc, rogueMgr.shoushi) < 5 then
    for i = 1, self.layer do
      cast_magic(self.npc, self.npc, rogueMgr.shoushi)
    end
  elseif 5 == get_magic_num(self.npc, rogueMgr.shoushi) and get_npc_time(self.npc) > self.cast_time + self.cd then
    cast_magic(self.npc, self.npc, rogueMgr.shoushi)
    self.cast_time = get_npc_time(self.npc)
    self.cd = 5
  end
end

function M:_init(npc)
  self.cast_time = 0
  self.cd = 0
end

return M
