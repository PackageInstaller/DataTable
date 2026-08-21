local M = Util.create_class()
local team_hero_list = {}
local ability = 50001
local level = 1
local ultTime = false
local timesphere = get_god_npc()
local CD = 0
local current_time = 0

function M:_init(npc)
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 5 == skill_type then
    ultTime = true
  end
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc and get_npc_time(self.npc) > CD + current_time and ultTime then
    cast_skill(timesphere, timesphere, 300103904)
    current_time = get_npc_time(self.npc)
    CD = 30
    ultTime = false
  end
end

return M
