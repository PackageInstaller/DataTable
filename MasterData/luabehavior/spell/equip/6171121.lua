local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local fanji_times = 0

function M:on_start()
  self.level = get_ability_level(10012) or 1
  if self.level and self.level > 1 then
    self.fanji_times_max = 15
  else
    self.fanji_times_max = 20
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(10012) or 1
  if self.level and self.level > 1 then
    self.fanji_times_max = 15
  else
    self.fanji_times_max = 20
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if kind < 2 or kind > 4 then
    return
  end
  if magic_id == rogueMgr.fanji then
    fanji_times = fanji_times + 1
    if fanji_times >= self.fanji_times_max then
      cast_missile_new(self.npc, self.npc, nil, nil, 61711910403)
      cast_missile_new(self.npc, self.npc, nil, nil, 61711910404)
      if get_magic_num(self.npc, 61711212) < 5 then
        tool:castMagicToTeam(61711212)
      end
      fanji_times = 0
    end
  end
end

function M:on_room_pass(room_id)
  tool:abortMagicToTeam(61711212)
end

function M:_init(npc)
end

return M
