local M = Util.create_class()
local target_list = {}
local exist_time = 0
local exist_staty = false
local team_hero_list = {}
local time = 0
local interval_time = 0
local magic_level = 0
local mastery_check_fuc = {
  [6170401] = function(self)
    magic_level = magic_level + 1
  end,
  [6170402] = function(self)
    magic_level = magic_level + 1
  end,
  [6170403] = function(self)
    magic_level = magic_level + 1
  end,
  [6170404] = function(self)
    magic_level = magic_level + 1
  end,
  [6170405] = function(self)
    magic_level = magic_level + 1
  end,
  [6170406] = function(self)
    magic_level = magic_level + 1
  end,
  [6170407] = function(self)
    magic_level = magic_level + 1
  end,
  [6170408] = function(self)
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
    cast_magic(self.npc, get_god_npc(), 61704093, 1)
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
  if 607000042 == skill_id then
    if get_come_on_hero() == self.npc then
      cast_magic(self.npc, self.npc, 61704091, 1)
    end
    exist_staty = true
    exist_time = time + 15
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if exist_staty and get_come_on_hero() == npc and time >= interval_time then
    cast_missile(npc, hit_target, nil, nil, 60700004101, 1, nil, nil)
    interval_time = time + 2
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level)
  if magic_level >= 4 and npc == self.npc and 61704092 == magic_id then
    local hp = get_npc_attr(target, 1) / get_npc_attr(target, 4)
    if hp > 0.5 then
      cast_magic(self.npc, self.npc, 61704101, 1)
    end
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if true == is_showup and npc == self.npc then
    if exist_staty then
      cast_magic(self.npc, self.npc, 61704091, 1)
    end
  elseif false == is_showup and npc == self.npc and check_magic(self.npc, 61704091) then
    abort_magic_by_id(self.npc, 61704091)
  end
end

function M:on_frame()
  time = get_time()
  if exist_staty and time >= exist_time then
    exist_staty = false
    for k, v in pairs(team_hero_list) do
      abort_magic_by_id(v, 61704091)
    end
  end
end

return M
