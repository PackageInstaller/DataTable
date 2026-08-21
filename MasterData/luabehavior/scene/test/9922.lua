local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
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
    "monster1"
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
    "monster1"
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
    "monster1"
  },
  [4] = {
    1,
    201019,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1"
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    201013,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1"
  },
  [2] = {
    1,
    201013,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1"
  },
  [3] = {
    1,
    201013,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1"
  },
  [4] = {
    1,
    201012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1"
  }
}
lMonster.RANDOW_VAL_103 = {
  [1] = {
    1,
    201023,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1"
  },
  [2] = {
    1,
    201019,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1"
  },
  [3] = {
    1,
    201019,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1"
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
    "monster1"
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
    "monster1"
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
    "monster1"
  },
  [4] = {
    1,
    201019,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1"
  }
}
local trap_list = {
  [1] = {
    1,
    3201001,
    "tr1",
    0,
    0,
    "tr1",
    -1,
    -1,
    4,
    0
  },
  [2] = {
    1,
    3201001,
    "tr2",
    0,
    0,
    "tr2",
    -1,
    -1,
    4,
    0
  },
  [3] = {
    1,
    3201001,
    "tr3",
    0,
    0,
    "tr3",
    -1,
    -1,
    4,
    0
  },
  [4] = {
    1,
    3201001,
    "tr4",
    0,
    0,
    "tr4",
    -1,
    -1,
    4,
    0
  },
  [5] = {
    1,
    3201001,
    "tr5",
    0,
    0,
    "tr5",
    -1,
    -1,
    4,
    0
  },
  [6] = {
    1,
    3201001,
    "tr6",
    0,
    0,
    "tr6",
    -1,
    -1,
    4,
    0
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
  self.random_id = 1
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:add_trap()
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(9901)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(9902)
    self:add_monster()
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
    self.monster_list[#self.monster_list + 1] = monster
  end
end

function M:add_trap()
  self:add_npc_by_pos_key(1, 3201001, "T1", 0, 0, "T1", 0, 0, 4, 0)
  self:add_npc_by_pos_key(1, 3201001, "T2", 0, 0, "T2", 0, 0, 4, 0)
  self:add_npc_by_pos_key(1, 3201001, "T3", 0, 0, "T3", 0, 0, 4, 0)
  self:add_npc_by_pos_key(1, 3201001, "T4", 0, 0, "T4", 0, 0, 4, 0)
  self:add_npc_by_pos_key(1, 3201001, "T5", 0, 0, "T5", 0, 0, 4, 0)
  self:add_npc_by_pos_key(1, 3201001, "T6", 0, 0, "T6", 0, 0, 4, 0)
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
      if 0 == #self.monster_list and 3 ~= self.random_id then
        self.random_id = self.random_id + 1
        self:add_monster()
      elseif 0 == #self.monster_list and self.random_id >= 3 and not self:is_pass_room() then
        self:fight_end(true)
        self:end_perform(self.room_type)
        self:timer_call_out(nil, function()
          self:set_scene_camera(9901)
        end, 2)
        self:open_all_transmit()
        if not self.is_add_npc then
          self:add_functional_npc(1, "NPC", "tp1")
          self.is_add_npc = true
        end
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
