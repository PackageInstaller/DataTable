local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
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
lMonster.RANDOW_VAL_102 = {
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
lMonster.RANDOW_VAL_103 = {
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

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self:set_sync_var("cancel_born_skill", true)
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
  self.random_id = math.random(1, 4)
end

function M:on_enter()
  self:enable_god_skill(false)
  self:set_mapview_transmit(false)
  self:set_route_status(17, 9, true)
  self:cast_magic(Global.hero, Global.hero, 4032098, 0)
  if not self.is_paly_timeline then
    self:remove_area("story01", "story")
    self:clear_input()
    self:stop_move(Global.hero)
    self:remove_scene_effect("jiaohu")
    self:play_timeline("timeline_1", 0, 1.5)
    self:set_sceneobj_visible("scene_timeline1_2", true)
    self:cast_magic(Global.hero, Global.hero, 4010212, 0)
    self:timer_call_out("timeline_1", function()
      self:fight_end(true)
      self:actvie_obstacle("AW1", "wall", true)
      self:set_scene_camera(102)
      self:open_all_transmit()
      self:play_story(1011001)
    end, 9)
    self.is_paly_timeline = true
  end
  local x, y = self:get_scene_map_pos_postion("center")
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
    self:set_route_status(17, 9, true)
  else
    self.end_npc = self:add_npc_by_pos_key(1, 3001024, "drop", 0, 0, "drop", 0, 0, 4, 1)
    self:set_can_searched(self.end_npc, false)
    self.end_pos = self:get_npc_pos(self.end_npc)
    self:timer_call_out(nil, function()
      self.end_switch = true
      self:lookat_position(Global.hero, x, y, true)
      self:actvie_obstacle("AW1", "wall", true)
      self:set_scene_camera(102)
    end, 0.5)
  end
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
      if 0 == #self.monster_list and not self:is_pass_room() then
        self:fight_end(true)
        self:end_perform(self.room_type)
        self:timer_call_out(nil, function()
          self:set_scene_camera(102)
        end, 2)
        self:open_all_transmit()
      end
    end
  end
end

function M:on_frame()
end

function M:on_timeline_end(timeline_name)
  self:cast_magic(Global.hero, Global.hero, 4010213, 0)
  if not self:is_pass_room() and "timeline_1" == timeline_name then
    self:timer_call_out_remove("timeline_1")
    self:play_story(1011001)
    self:fight_end(true)
    self:open_all_transmit()
    self:set_route_status(17, 9, true)
  end
end

function M:on_story_end(story_id, step)
  if not self.is_accept_task then
    self:accept_task_group(1001)
    self.is_accept_task = true
  end
  if 1011001 == story_id then
    self:show_finger_scale_guide()
  end
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if not self.is_add_npc and area.Key == "M1" then
    self:remove_area("M1", "point")
    self:set_sceneobj_visible("scene_timeline1_0", true)
    self.is_add_npc = true
  end
  self:judge_all_tp(area)
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

function M:on_leave()
end

return M
