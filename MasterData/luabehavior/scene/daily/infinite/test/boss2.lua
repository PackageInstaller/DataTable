local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local cast_magic_id = {
  [1] = 4030114
}
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    20107502,
    "M1",
    0,
    0,
    "tp2",
    -1,
    -1,
    4,
    "monster3",
    "mm1"
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
  self:set_sync_var("cancel_born_skill", true)
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(20107501)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(20107501)
    self:add_monster()
    self:curse_time_start()
  end
end

function M:add_monster()
  for _, data in ipairs(lMonster.RANDOW_VAL_1) do
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
  local remain_mon4 = self:get_npc_count_by_kind(4)
  if 0 == remain_mon4 and not self:is_pass_room() then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self:timer_call_out(nil, function()
      self:set_scene_camera(102)
    end, 2)
    self:open_all_transmit()
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
  return {
    ran_id = self.random_id
  }
end

function M:on_load(data)
  self.random_id = data.ran_id
end

return M
