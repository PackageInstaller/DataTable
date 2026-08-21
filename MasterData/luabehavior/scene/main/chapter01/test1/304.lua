local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
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
  },
  [3] = {
    1,
    20106004,
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
    20106004,
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
lMonster.RANDOW_VAL_2 = {
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
    201015,
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
    201015,
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
lMonster.RANDOW_VAL_3 = {
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
lMonster.RANDOW_VAL_4 = {
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
Monster_plus.RANDOW_VAL_1 = {
  [1] = {
    1,
    20106107,
    "M6",
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
    "M7",
    0,
    0,
    "M8",
    -1,
    -1,
    4,
    1
  },
  [3] = {
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
  }
}
Monster_plus.RANDOW_VAL_2 = {
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
  }
}
Monster_plus.RANDOW_VAL_3 = {
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
  }
}
Monster_plus.RANDOW_VAL_4 = {
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
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.Counter = SceneCounter.NewObj(self)
  self.max_time = 360
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
  self.random_id = 1
  self.wave = 1
end

function M:on_enter()
  self:set_route_status(13, 5, false)
  self:set_route_status(13, 14, true)
  self:cast_magic(Global.hero, Global.hero, 4032098, 0)
  if not self.is_add_npc then
    self:play_timeline("timeline1_2", 0, 0.5, nil, false)
    self.is_add_npc = true
  elseif self.is_add_npc and not self:is_pass_room() then
    self:add_monster()
    self:set_scene_tips(100104, true)
  end
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:add_npc_by_pos_key(1, 3001003, "M6", 0, 0, "M6", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M7", 0, 0, "M6", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M8", 0, 0, "M6", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M9", 0, 0, "M6", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M10", 0, 0, "M6", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 3001003, "M11", 0, 0, "M6", 0, 0, 4, 1)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
  end
end

function M:add_monster()
  local list_id = self.random_id
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
  local list_id = self.random_id
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
      if 0 == #self.monster_list and not self:is_pass_room() and 1 == self.wave then
        self.wave = 2
        self:timer_call_out(nil, function()
          self:add_monster2()
        end, 0.5)
      elseif 0 == #self.monster_list and 2 == self.wave and not self:is_pass_room() then
        self:fight_end(true)
        self:end_perform(self.room_type)
        self:open_all_transmit()
      end
    end
  end
end

function M:on_story_end()
  self:start_texture_guide(10112)
end

function M:on_frame()
end

function M:on_story_end(story_id, step)
  if 1011004 == story_id then
    self:add_monster()
    self:set_scene_tips(100104, true)
    self:complete_task(100102)
  end
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if not self.is_paly_timeline and area.Key == "story02" and self:is_pass_room() then
    self:remove_area("story02", "story")
    self:clear_input()
    self:stop_move(Global.hero)
    self:play_story(1011003)
    self.is_paly_timeline = true
  end
  self:judge_all_tp(area)
end

function M:on_timeline_end(timeline_name)
  self:play_story(1011004)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    is_paly_timeline = self.is_paly_timeline
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.is_paly_timeline = data.is_paly_timeline
end

return M
