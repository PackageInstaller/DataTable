local M = Util.create_class()
local tool = import("common.tool")
local hero = get_come_on_hero()
local cri_time = 0

function M:_init(npc)
  self.active = false
end

function M:on_start()
  self.level = get_ability_level(60010) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(60010) or 1
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() or 61710192 == magic_id then
    return
  end
  cri_time = get_npc_attr(self.npc, 78)
  if self.level > 1 and cri_time >= 15000 then
    self.active = true
  elseif 1 == self.level and cri_time >= 20000 then
    self.active = true
  end
  if is_crit and check_npc_die(target) then
    local atk_XG_list = search_npc(self.npc, 4, 30, nil, false, true, nil, 2)
    local atk_JY_list = search_npc(self.npc, 4, 30, nil, false, true, nil, 3)
    if nil == atk_XG_list[1] and nil == atk_JY_list[1] then
      return
    end
    local per1, per2 = tool:randByTime(0.1, 0.5)
    if per2 then
      if nil ~= atk_XG_list[1] then
        cast_magic(self.npc, atk_XG_list[1], 61710191, 0)
        self.active = false
      else
        cast_magic(self.npc, atk_JY_list[1], 61710192, 0)
        cast_magic(self.npc, atk_JY_list[1], 61710193, 0)
        self.active = false
      end
    elseif nil ~= atk_JY_list[1] then
      cast_magic(self.npc, atk_JY_list[1], 61710192, 0)
      cast_magic(self.npc, atk_JY_list[1], 61710193, 0)
      self.active = false
    else
      cast_magic(self.npc, atk_XG_list[1], 61710191, 0)
      self.active = false
    end
  end
end

return M
