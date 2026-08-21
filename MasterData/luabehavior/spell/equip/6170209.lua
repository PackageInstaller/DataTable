local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local time = 0
local interval_time = 0
local magic_level = 0
local hp_add_time = 0
local hp_add_interval_time = 0
local mastery_check_fuc = {
  [6170201] = function(self)
    magic_level = magic_level + 1
  end,
  [6170202] = function(self)
    magic_level = magic_level + 1
  end,
  [6170203] = function(self)
    magic_level = magic_level + 1
  end,
  [6170204] = function(self)
    magic_level = magic_level + 1
  end,
  [6170205] = function(self)
    magic_level = magic_level + 1
  end,
  [6170206] = function(self)
    magic_level = magic_level + 1
  end,
  [6170207] = function(self)
    magic_level = magic_level + 1
  end,
  [6170208] = function(self)
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
    cast_magic(self.npc, get_god_npc(), 61702093, 1)
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
  if 607000022 == skill_id then
    hp_add_time = time + 5
    if get_come_on_hero() == self.npc then
      cast_missile(self.npc, self.npc, nil, nil, 60700002101, 1, nil, nil)
      for k, v in pairs(team_hero_list) do
        cast_magic(v, v, 61702091, 1)
      end
    end
  end
end

function M:Hp_add()
  time = get_time()
  if magic_level >= 4 and hp_add_time >= time and time >= hp_add_interval_time then
    hp_add_interval_time = time + 1.5
    if get_come_on_hero() == self.npc then
      for k, v in pairs(team_hero_list) do
        cast_magic(v, v, 61702091, 1)
      end
    end
  end
end

function M:on_frame()
  self:Hp_add()
end

return M
