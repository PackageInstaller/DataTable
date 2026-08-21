local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    201021,
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
    201010,
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
    201010,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    201021,
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
    201047,
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
    201047,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_201 = {
  [1] = {
    1,
    201021,
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
    201014,
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
    201014,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_202 = {
  [1] = {
    1,
    201021,
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
    201047,
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
    201047,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_301 = {
  [1] = {
    1,
    201021,
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
    201014,
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
    201014,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_302 = {
  [1] = {
    1,
    201021,
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
    201012,
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
    201012,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_401 = {
  [1] = {
    1,
    201021,
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
    201016,
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
    201016,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_402 = {
  [1] = {
    1,
    201021,
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
    201033,
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
    201033,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_501 = {
  [1] = {
    1,
    201021,
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
    201033,
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
    201033,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_502 = {
  [1] = {
    1,
    201021,
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
    201028,
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
    201028,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
local cast_magic_id = {
  [1] = 4031007,
  [2] = 4031009,
  [3] = 4031006
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
  self.is_cast_magic = nil
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
    self:set_scene_tips(102011, true)
  end
end

function M:add_monster()
  local list_id = self.floor_num * 100 + self.random_id
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
  end
  if not self.is_cast_magic and not self:is_pass_room() and not self:check_npc_status(self.mm1, 5) and self:check_npc_status(self.mm2, 5) and self:check_npc_status(self.mm3, 5) then
    self:cast_magic(Global.hero, Global.hero, cast_magic_id[1], 1)
    self.is_cast_magic = 1
    self:set_sync_var("ring_mob1", 1)
  end
end

function M:on_frame()
  if 1 == self.is_cast_magic and not self:check_magic(Global.hero, cast_magic_id[1]) and self:get_sync_var("ring_mob1") <= 2 then
    self:cast_magic(Global.hero, Global.hero, cast_magic_id[1], 1)
  elseif 0 == self.is_cast_magic then
    self:set_sync_var("ring_mob1", 4)
  end
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
