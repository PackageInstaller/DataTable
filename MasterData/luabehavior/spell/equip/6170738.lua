local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.level = get_ability_level(40024) or 1
  if 1 == self.level then
    self.cd = 3
  else
    self.cd = 1.5
  end
  self.curr_time = 0
end

function M:on_room_change(npc)
  self.level = get_ability_level(40024) or 1
  if 1 == self.level then
    self.cd = 3
  else
    self.cd = 1.5
  end
  self.curr_time = 0
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if get_npc_time(self.npc) > self.curr_time + self.cd and true == is_crit and get_magic_num(self.npc, rogueMgr.baojun) < 5 then
    cast_magic(self.npc, self.npc, rogueMgr.baojun)
    self.curr_time = get_npc_time(self.npc)
  end
end

function M:_init(npc)
end

return M
