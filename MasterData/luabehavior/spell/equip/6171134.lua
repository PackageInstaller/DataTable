local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.init_time = get_npc_time(self.npc)
  self.cd = 0
  self.level = get_ability_level(10020) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10020) or 1
end

function M:after_heal(npc, target, magic_id, heal_val)
  if get_come_on_hero() ~= self.npc or check_npc_die(self.npc) then
    return
  end
  local hero1 = get_scene_hero_by_poskey(21)
  local hero2 = get_scene_hero_by_poskey(22)
  if (target == hero1 or target == hero2) and get_npc_time(self.npc) > self.init_time + self.cd then
    cast_magic(self.npc, self.npc, 61711341, self.level)
    self.init_time = get_npc_time(self.npc)
    self.cd = 20
  end
end

function M:_init(npc)
end

return M
