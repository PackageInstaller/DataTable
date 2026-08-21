local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    20102104,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    20106107,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106107,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    20106107,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    20106107,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    1
  }
}
lMonster.RANDOW_VAL_103 = {
  [1] = {
    1,
    201010,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201010,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    201009,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    201009,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    1
  }
}
lMonster.RANDOW_VAL_104 = {
  [1] = {
    1,
    201009,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201009,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    201009,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    201009,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    1
  }
}
local Monster_plus = {}
Monster_plus.RANDOW_VAL_101 = {
  [1] = {
    1,
    20106004,
    "M8",
    0,
    0,
    "M8",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106004,
    "M9",
    0,
    0,
    "M9",
    -1,
    -1,
    4,
    1
  }
}
Monster_plus.RANDOW_VAL_102 = {
  [1] = {
    1,
    20106004,
    "M8",
    0,
    0,
    "M8",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106004,
    "M9",
    0,
    0,
    "M9",
    -1,
    -1,
    4,
    1
  }
}
Monster_plus.RANDOW_VAL_103 = {
  [1] = {
    1,
    20106004,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106004,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  }
}
Monster_plus.RANDOW_VAL_104 = {
  [1] = {
    1,
    20106004,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106004,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
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
  self.random_id = 2
  self.wave = 1
  self.plat1_move = 0
  self.plat2_move = 0
end

function M:on_enter()
  self:cast_magic(Global.hero, Global.hero, 4032098, 0)
  self:set_route_status(15, 14, false)
  self:set_route_status(15, 16, true)
  self:set_plat_active("plat1", true)
  self:set_plat_active("plat2", true)
  self:add_npc_by_pos_key(1, 3001002, "tr1", 0, 0, "tr1_1", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001002, "tr2", 0, 0, "tr2_1", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M6", 0, 0, "M6", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M7", 0, 0, "M7", 0, 0, 4, 1)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self.settleTime = os.time()
  self.settleTime2 = os.time()
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(107)
    self:add_monster()
  end
end

function M:plat1_wander()
  if 0 == self.plat1_move and self.settleTime and os.time() - self.settleTime >= 5 then
    self:move_plat_to_pos("plat1", "2", 5)
    self.plat1_move = 1
    self.settleTime = os.time()
  elseif 1 == self.plat1_move and self.settleTime and os.time() - self.settleTime >= 5 then
    self:move_plat_to_pos("plat1", "1", 5)
    self.plat1_move = 0
    self.settleTime = os.time()
  end
end

function M:plat2_wander()
  if 0 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 5 then
    self:move_plat_to_pos("plat2", "4", 5)
    self.plat2_move = 1
    self.settleTime2 = os.time()
  elseif 1 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 5 then
    self:move_plat_to_pos("plat2", "3", 5)
    self.plat2_move = 0
    self.settleTime2 = os.time()
  end
end

function M:add_monster()
  local list_id = 100 + self.random_id
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    self.monster_list[#self.monster_list + 1] = monster
  end
end

function M:add_monster2()
  local list_id = 100 + self.random_id
  for _, data in ipairs(Monster_plus["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster2 = self:add_npc_by_pos_key(_tunpack(args))
    self.monster_list[#self.monster_list + 1] = monster2
  end
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
      if 2 == #self.monster_list and not self:is_pass_room() and 1 == self.wave then
        self.wave = 2
        self:add_monster2()
      end
      if 0 == #self.monster_list and not self:is_pass_room() then
        self:fight_end(true)
        self:end_perform(self.room_type)
        self:timer_call_out(nil, function()
          self:set_scene_camera(102)
        end, 0.5)
        self:open_all_transmit()
      end
    end
  end
end

function M:on_frame()
  self:plat1_wander()
  self:plat2_wander()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
end

return M
