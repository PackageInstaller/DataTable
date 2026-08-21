local M = Util.create_class()
local target_list = {}
local magic_dot_id = {
  61705091,
  61705092,
  61705093,
  61705094,
  61705095
}
local magic_level = 0
local team_hero_list = {}
local time = 0
local interval_time = 0
local mastery_check_fuc = {
  [6170501] = function(self)
    magic_level = magic_level + 1
  end,
  [6170502] = function(self)
    magic_level = magic_level + 1
  end,
  [6170503] = function(self)
    magic_level = magic_level + 1
  end,
  [6170504] = function(self)
    magic_level = magic_level + 1
  end,
  [6170505] = function(self)
    magic_level = magic_level + 1
  end,
  [6170506] = function(self)
    magic_level = magic_level + 1
  end,
  [6170507] = function(self)
    magic_level = magic_level + 1
  end,
  [6170508] = function(self)
    magic_level = magic_level + 1
  end
}

function M:magic_numbs()
  magic_level = 0
  for key, value in pairs(mastery_check_fuc) do
    if check_magic(self.npc, key) then
      value(self)
    end
  end
  if magic_level >= 8 and get_come_on_hero() == self.npc then
    cast_magic(self.npc, get_god_npc(), 61705096, 1)
  end
end

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_start()
  self:magic_numbs()
end

function M:on_room_change(npc)
  self:magic_numbs()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 607000052 == skill_id and get_come_on_hero() == self.npc then
    cast_missile(self.npc, self.npc, nil, nil, 60700005101, 1, nil, nil)
    target_list = search_npc(self.npc, 4, 5.5, nil, true, true)
    if target_list[1] then
      for k, v in pairs(target_list) do
        local target = v
        for k, v in pairs(magic_dot_id) do
          cast_magic(self.npc, target, v, 1)
        end
      end
    end
  end
end

function M:on_element_aborn_start(npc, element)
  if magic_level >= 4 and get_come_on_hero() == self.npc then
    local element_type = {
      1999990,
      1999991,
      1999992,
      1999993,
      1999994
    }
    table.remove(element_type, element - 1)
    local random = math.random(1, 4)
    cast_magic(self.npc, npc, element_type[random], 1)
  end
end

function M:on_frame()
end

return M
