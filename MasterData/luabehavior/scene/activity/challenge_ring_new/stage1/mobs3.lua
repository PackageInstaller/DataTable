local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    20105401,
    "center",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster2",
    "mm1"
  },
  [2] = {
    1,
    20106102,
    "M1",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106102,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3002005,
    "T51",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt1"
  }
}
lMonster.RANDOW_VAL_2 = {
  [1] = {
    1,
    20105601,
    "center",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster2",
    "mm1"
  },
  [2] = {
    1,
    20106102,
    "M1",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106102,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3002005,
    "T52",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt1"
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.monster_list = {}
  self.random_id = math.random(1, 2)
  self:set_sync_var("cancel_born_skill", true)
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:set_scene_camera(102)
  else
    self:actvie_obstacle("AW13", "wall13", true)
    self:actvie_obstacle("AW23", "wall23", true)
    self:actvie_obstacle("AW33", "wall33", true)
    self:actvie_obstacle("AW43", "wall43", true)
    self:actvie_obstacle("AW11", "wall11", true)
    self:actvie_obstacle("AW12", "wall12", true)
    self:actvie_obstacle("AW21", "wall21", true)
    self:actvie_obstacle("AW22", "wall22", true)
    self:actvie_obstacle("AW31", "wall31", true)
    self:actvie_obstacle("AW32", "wall32", true)
    self:actvie_obstacle("AW41", "wall41", true)
    self:actvie_obstacle("AW42", "wall42", true)
    self:set_scene_camera(102)
    self:add_monster()
    self:curse_time_start()
    self:set_scene_tips(50012, true, {})
  end
end

function M:add_monster()
  local list_id = self.random_id
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 9)
    }
    args[10] = lv
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    local monsterName = data[11]
    self[monsterName] = monster
    self.monster_list[#self.monster_list + 1] = monster
  end
end

function M:on_npc_dead(npc)
  local remain_mon2 = self:get_npc_count_by_kind(2)
  local remain_mon3 = self:get_npc_count_by_kind(3)
  if 0 == remain_mon2 and 0 == remain_mon3 and not self:is_pass_room() then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self:timer_call_out(nil, function()
      self:set_scene_camera(102)
    end, 2)
    if not self:check_npc_status(self.tt1, 5) then
      self:remove_npc(self.tt1)
      self:set_scene_tips(50012, false, {})
    end
  end
  if npc == self.tt1 then
    self:set_scene_tips(50012, false, {})
  end
end

function M:on_frame()
end

function M:on_enter_area(npc, area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  return {
    ran_id = self.random_id
  }
end

function M:on_load(data)
  self.random_id = data.ran_id
end

return M
