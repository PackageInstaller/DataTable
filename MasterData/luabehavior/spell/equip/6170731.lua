local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:after_damage_self()
  if not check_npc_die(self.npc) and get_magic_num(self.npc, rogueMgr.kuangnu) < 8 then
    if self.level > 1 then
      cast_magic(self.npc, self.npc, rogueMgr.kuangnu)
    end
    cast_magic(self.npc, self.npc, rogueMgr.kuangnu)
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(40017) or 1
end

function M:on_start()
  self.level = get_ability_level(40017) or 1
end

function M:_init(npc)
end

return M
