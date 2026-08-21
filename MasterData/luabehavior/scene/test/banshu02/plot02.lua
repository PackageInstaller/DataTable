local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    20106005,
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
    20106005,
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
    20106103,
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
    20106103,
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
    20106005,
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
    20106005,
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
    20101905,
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
    20101905,
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
    20106103,
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
    20106103,
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
    20106005,
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
    20106005,
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
    20106005,
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
    20106005,
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
    20106005,
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
    20106005,
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
    20105403,
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
  },
  [3] = {
    1,
    201010,
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
    201010,
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
  },
  [3] = {
    1,
    201010,
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
    201010,
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
  },
  [3] = {
    1,
    201010,
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
    201010,
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

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    normal_level = self.normal_level,
    rare_level = self.rare_level,
    boss_level = self.boss_level
  }
  self.monster_list = {}
  self.random_id = math.random(1, 4)
  self.wave = 1
end

function M:on_enter()
  self:skip_finish_anim(true)
  if 1 == self.A then
    self:fight_end(true)
  end
  if self.is_interact then
    self:set_sceneobj_visible("scene_timeline0", true)
  end
  self:add_npc_by_pos_key(1, 300100202, "C1", 0, 0, "C3)", 0, 0, 4, 1)
  self:add_npc_by_pos_key(1, 300100202, "C2", 0, 0, "C3)", 0, 0, 4, 1)
  self:cast_magic(Global.hero, Global.hero, 4032098, 0)
  if not self.is_add_npc then
    self:add_functional_npc(2, "A1", "A1", {npc_id = 102149})
    self:add_functional_npc(2, "NPC", "tp3", {npc_id = 101201})
    self:add_functional_npc(4, "NPC1", "tp3", {npc_id = 101202})
    self:add_functional_npc(2, "A3", "A3", {npc_id = 102152})
    self.is_add_npc = true
  end
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(104)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(104)
    self:add_monster()
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
  local list_id = 1
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
        self:stop_move(Global.hero)
        self:clear_input(18)
        self:set_scene_tips(100112, true)
      end
    end
  end
end

function M:on_frame()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if area.Key == "M0" and not self.is_paly_timeline then
    self.is_paly_timeline = true
    self:remove_area("M0")
    self:play_timeline("timeline2_lock", 1.5, 1, nil, false)
    self:timer_call_out(nil, function()
      self:play_story(1012002)
    end, 1.5)
  end
  if area.Key == "M1" then
    self:remove_area("M1")
    self:set_scene_camera(111)
  end
  if area.Key == "M2" then
    self:remove_area("M2")
    self:set_scene_camera(104)
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

function M:on_story_end()
  self:stop_timeline("timeline2_lock")
  self:open_all_transmit()
  self:complete_task(900202)
  self.A = 1
end

function M:on_func_npc_interact_end(func_npc_id)
  if 101202 == func_npc_id then
    self:set_sceneobj_visible("scene_timeline0", true)
    self:remove_functional_npc(101202)
    self.is_interact = true
  end
  if 101201 == func_npc_id then
    self:play_story(1012003)
    self:remove_functional_npc(101201)
  end
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    is_paly_timeline = self.is_paly_timeline,
    is_interact = self.is_interact
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.is_paly_timeline = data.is_paly_timeline
  self.is_interact = data.is_interact
end

return M
