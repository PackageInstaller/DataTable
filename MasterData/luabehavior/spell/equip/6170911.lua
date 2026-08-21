local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local current_time = 0

function M:on_room_change(npc)
  self.level = get_ability_level(30009) or 1
  if 1 == self.level then
    self.cd = 12
  else
    self.cd = 8
  end
end

function M:on_start()
  self.level = get_ability_level(30009) or 1
  if 1 == self.level then
    self.cd = 12
  else
    self.cd = 8
  end
  listen_attr_change_mq(self.npc, 1, self.on_hp_change, self)
end

function M:on_fate_book_battle_start()
  rogueMgr:add_water_control_magic(self.npc)
end

function M:on_npc_born(npc)
  rogueMgr:born_add_water_control(self.npc, npc)
end

function M:on_hp_change(npc, attr_tpe, change_value)
  if get_npc_time(self.npc) > current_time + self.cd then
    local pos = {}
    pos = get_npc_pos(get_come_on_hero())
    cast_missile3(self.npc, nil, pos.x, pos.z, 61709910101)
    current_time = get_npc_time(self.npc)
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170911)
  if 0 == num then
    rogueMgr.defence_decrease = false
  end
  unlisten_attr_change_mq(self.npc, 1, self)
end

function M:_init(npc)
  rogueMgr.defence_decrease = true
end

return M
