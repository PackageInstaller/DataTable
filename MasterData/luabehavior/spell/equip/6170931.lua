local M = Util.create_class()
M.cd = 10
M.next_time = -1
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:listen_perfect_dash()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.insert(role, "onPdashSlomo", self.add_water)
end

function M.add_water(role)
  local godNpc = get_god_npc()
  local current_time = get_npc_time(godNpc)
  if current_time > M.next_time then
    local pos = {}
    pos = get_npc_pos(get_come_on_hero())
    cast_missile3(role.npc, nil, pos.x, pos.z, 61709910101)
    M.next_time = current_time + M.cd
  end
end

function M:on_start()
  rogueMgr.level_water = true
  self:listen_perfect_dash()
end

function M:on_fate_book_battle_start()
  rogueMgr:add_water_control_magic(self.npc)
  self:listen_perfect_dash()
end

function M:on_npc_born(npc)
  rogueMgr:born_add_water_control(self.npc, npc)
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170931)
  if 0 == num then
    rogueMgr.level_water = false
  end
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.remove(role, "onPdashSlomo", self.add_water)
end

return M
