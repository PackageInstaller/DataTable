local M = Util.create_class()
local Cd_time = 0
local Cd = 5
local target_list = {}
local ability = 20008
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and missile_cfg.Id == 60700001103 then
    table.insert(target_list, hit_target)
    if level > 1 then
      cast_magic(self.npc, hit_target, 61701083, level)
    end
  end
end

return M
