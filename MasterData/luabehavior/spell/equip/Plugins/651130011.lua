local M = Util.create_class()
local tool = import("common.tool")

function M:_init()
  self.teammate1 = get_come_on_hero()
  self.teammate2 = get_scene_hero_by_poskey(22)
  self.teammate3 = get_scene_hero_by_poskey(21)
end

function M:on_start()
  self.energy_full = get_npc_attr(self.npc, 2)
  print(self.energy_full)
  if self.teammate1 ~= nil then
    self.hero1_energy_full = get_npc_attr(self.teammate1, 5)
  end
  if nil ~= self.teammate2 then
    self.hero2_energy_full = get_npc_attr(self.teammate2, 5)
  end
  if nil ~= self.teammate3 then
    self.hero3_energy_full = get_npc_attr(self.teammate3, 5)
  end
  listen_attr_change_mq(self.npc, 2, self.on_jingli_change, self)
  self.level = get_develop_level(self.npc, 6, 651130011)
end

function M:on_jingli_change(npc, attr_type, change_value)
  if change_value > 0 and get_npc_attr(self.npc, 2) == self.energy_full then
    if self.teammate1 and get_npc_attr(self.teammate1, 2) ~= self.hero1_energy_full and not check_magic(self.teammate1, 651130012) then
      cast_magic(self.npc, self.teammate1, 651130012, self.level)
    end
    if self.teammate2 and get_npc_attr(self.teammate2, 2) ~= self.hero2_energy_full and not check_magic(self.teammate2, 651130012) then
      cast_magic(self.npc, self.teammate2, 651130012, self.level)
    end
    if self.teammate3 and get_npc_attr(self.teammate3, 2) ~= self.hero3_energy_full and not check_magic(self.teammate3, 651130012) then
      cast_magic(self.npc, self.teammate3, 651130012, self.level)
    end
  end
  if change_value < 0 then
    local bool, num = tool:checkMagicToTeam(651130012)
    if num > 0 then
      tool:abortMagicToTeam(651130012)
    end
  end
end

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  local bool, num = tool:checkMagicToTeam(651130012)
  if num > 0 then
    tool:abortMagicToTeam(651130012)
  end
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 2, self)
end

return M
