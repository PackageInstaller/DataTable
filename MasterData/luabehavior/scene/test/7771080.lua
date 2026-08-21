local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")
local _tunpack = table.unpack

function M:_init(...)
  Base._init(self, ...)
  self.monsternum = 0
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.trap_list = {}
  self.is_add_npc = 0
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.tp_control1 = 0
  self.tp_control2 = 0
end

function M:on_enter()
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall1", true)
    self:set_scene_camera(9901)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:open_all_transmit()
  elseif not self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall1", true)
    self:set_scene_camera(9902)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    local random = math.random(1, 2)
    if 1 == random then
      self.RANDOW_VAL = {
        [1] = {
          1,
          201006,
          "M1",
          0,
          0,
          "M1",
          -1,
          -1,
          4,
          self.normal_level
        },
        [2] = {
          1,
          201015,
          "M2",
          0,
          0,
          "M2",
          -1,
          -1,
          4,
          self.normal_level
        },
        [3] = {
          1,
          201006,
          "M3",
          0,
          0,
          "M3",
          -1,
          -1,
          4,
          self.normal_level
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
          self.normal_level
        }
      }
    elseif 2 == random then
      self.RANDOW_VAL = {
        [1] = {
          1,
          201006,
          "M1",
          0,
          0,
          "M1",
          -1,
          -1,
          4,
          self.normal_level
        },
        [2] = {
          1,
          201015,
          "M2",
          0,
          0,
          "M2",
          -1,
          -1,
          4,
          self.normal_level
        },
        [3] = {
          1,
          201006,
          "M3",
          0,
          0,
          "M3",
          -1,
          -1,
          4,
          self.normal_level
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
          self.normal_level
        }
      }
    end
    for index = 1, 4 do
      local data = self.RANDOW_VAL[index]
      local monster = self:add_monster(_tunpack(data, 1, 10))
      if 2 == index or 4 == index then
        self:cast_magic(monster, monster, 4010150, 0)
      end
    end
    self.TRAP_MONSTER = {
      [1] = {
        1,
        3001006,
        "D1",
        0,
        0,
        "P1",
        0,
        0,
        4,
        self.rare_level
      },
      [2] = {
        1,
        3001006,
        "D2",
        0,
        0,
        "P2",
        0,
        0,
        4,
        self.rare_level
      },
      [3] = {
        1,
        3001007,
        "C1",
        0,
        0,
        "C1",
        0,
        0,
        4,
        self.rare_level
      },
      [4] = {
        1,
        3001007,
        "C2",
        0,
        0,
        "C2",
        0,
        0,
        4,
        self.rare_level
      },
      [5] = {
        1,
        3001007,
        "C3",
        0,
        0,
        "C3",
        0,
        0,
        4,
        self.rare_level
      },
      [6] = {
        1,
        3001007,
        "C4",
        0,
        0,
        "C4",
        0,
        0,
        4,
        self.rare_level
      }
    }
    for index = 1, 6 do
      local data = self.TRAP_MONSTER[index]
      self:add_trap(data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10])
    end
  end
end

function M:add_monster(...)
  local monster = self:add_npc_by_pos_key(...)
  table.insert(self.monster_list, monster)
  return monster
end

function M:add_trap(...)
  local trap = self:add_npc_by_pos_key(...)
  table.insert(self.trap_list, trap)
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
    end
  end
  if 0 == #self.monster_list and not self:is_pass_room() and 0 == self.monsternum then
    self.monsternum = 1
    self:fight_end(true)
    self:end_perform(self.room_type)
    self:set_scene_camera(9901)
    self:open_all_transmit()
    if 0 == self.is_add_npc then
      self:add_functional_npc(1, "NPC", "tp3")
      self.is_add_npc = 1
    end
  end
end

function M:on_frame()
end

function M:on_hero_dead()
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
