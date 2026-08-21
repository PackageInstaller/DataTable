local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local time_sphere = get_god_npc()
local is_ready = false

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= get_god_npc() then
    return
  end
  if 6 == skill_type then
    is_ready = true
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= get_come_on_hero() and npc ~= get_scene_hero_by_poskey(21) and npc ~= get_scene_hero_by_poskey(22) then
    return
  end
  if check_magic(target, 6170691001) and true == is_ready then
    self.count = self.count + 1
    if self.count >= 10 then
      cast_missile3(get_come_on_hero(), get_come_on_hero(), nil, nil, 61706910601)
      is_ready = false
      self.count = 0
    end
  end
end

function M:_init(npc)
  self.count = 0
end

return M
