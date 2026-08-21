local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local cast_magic_id = {
  [1] = 4031034
}
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    20105401,
    "A2",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster2",
    "mm1"
  },
  [2] = {
    1,
    20104405,
    "M1",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20104405,
    "M2",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    20104405,
    "A4",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  },
  [5] = {
    1,
    20104505,
    "drop",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt4"
  },
  [6] = {
    1,
    3002010,
    "M3",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt1"
  },
  [7] = {
    1,
    3002007,
    "M4",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt2"
  }
}
lMonster.RANDOW_VAL_2 = {
  [1] = {
    1,
    20105601,
    "center",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster2",
    "mm1"
  },
  [2] = {
    1,
    20104505,
    "A1",
    0,
    0,
    "A1",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20104505,
    "A3",
    0,
    0,
    "A3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    20104405,
    "A2",
    0,
    0,
    "A2",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  },
  [5] = {
    1,
    20104405,
    "A4",
    0,
    0,
    "A4",
    -1,
    -1,
    4,
    "monster1",
    "mm5"
  },
  [6] = {
    1,
    3002009,
    "M3",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt1"
  },
  [7] = {
    1,
    3002007,
    "M4",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "tt2"
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = 70
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level,
    monster4 = 100
  }
  self.monster_list = {}
  self.random_id = math.random(1, 2)
  self:set_sync_var("cancel_born_skill", true)
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:add_monster()
    self:curse_time_start()
    self:set_scene_tips(50013, true, {})
  end
  self:set_sync_var("archer_stop", true)
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
  for index = 1, 1 do
    self:cast_magic(self.mm1, self.mm1, cast_magic_id[index], 1)
  end
end

function M:on_npc_dead(npc)
  local remain_mon2 = self:get_npc_count_by_kind(2)
  local remain_mon3 = self:get_npc_count_by_kind(3)
  local remain_mon5 = self:get_npc_count_by_kind(5)
  if 0 == remain_mon2 and 0 == remain_mon3 and not self:is_pass_room() then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self:timer_call_out(nil, function()
      self:set_scene_camera(102)
    end, 2)
    for index = 1, 4 do
      if self["tt" .. index] and not self:check_npc_status(self["tt" .. index], 5) then
        self:remove_npc(self["tt" .. index])
        self:set_scene_tips(50013, false, {})
      end
    end
  end
  if 0 == remain_mon5 then
    self:set_scene_tips(50013, false, {})
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
