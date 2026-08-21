local M = Util.create_class()
local npcList = {}
local elementMagic = {
  nil,
  4033630201,
  4033630202,
  4033630203,
  4033630204,
  4033630205
}

function M:_init()
  self.intervalTime = 0
  self.nowTime = 0
  npcList = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
end

function M:on_start()
  for k, v in pairs(npcList) do
    if v then
      v.element = get_active_char_element(v)
    end
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if is_showup and 1 == get_role_kind(npc) and npc.element and elementMagic[npc.element] then
    cast_magic(self.npc, self.npc, elementMagic[npc.element], 1)
  end
end

function M:on_self_npc_hp_zero(attacker, magic_id, missile_id, missile)
  abort_magic_by_id(self.npc, 40336302, 1)
end

return M
