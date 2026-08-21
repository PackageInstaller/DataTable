local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("common.monster_config", "common")

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.challenge_level = self:get_tower_monster_level("MonLevel4")
  self.room_type = self:get_room_type()
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 30
  self.challenge_is_false = false
  self.is_success = nil
  self:set_sync_var("cancel_born_skill", true)
end

function M:on_enter()
  self:set_scene_camera(102)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_ui_object_visible("fight", "Main", true)
  if not self:is_pass_room() then
    self:remove_world_model("tppoint1")
  end
  self:end_perform(self.room_type)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
end

function M:on_frame()
  if not self.is_success and not self:is_pass_room() and not self.is_add_npc then
    self:remove_functional_npc(40001)
    self:remove_functional_npc(50002)
    self:remove_functional_npc(20100 + self.floor_num)
    self:add_functional_npc(4, "center", "center", {npc_id = 40001})
    self:add_functional_npc(4, "tp1", "center", {npc_id = 50002})
    self.is_add_npc = true
  end
end

function M:on_npc_show_start(id, type)
  if 40001 == id then
    self:remove_functional_npc(50002)
    return
  end
  if 50002 == id then
    self:fight_end(true)
    self:remove_functional_npc(40001)
    return
  end
end

function M:on_npc_show_end(id, type)
  if 40001 ~= id then
    return
  end
  self:set_scene_camera(102)
  self:remove_functional_npc(50002)
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self:set_functional_npc_visible(40001, false)
  self.challenge_condition = 1
  self.monster = {}
  self.monster[1] = self:add_npc_by_pos_key(1, 20101904, "center", 2, 2, "center", 0, 0, 4, self.challenge_level)
  self.monster[2] = self:add_npc_by_pos_key(1, 20101904, "center", 2, -2, "center", 0, 0, 4, self.challenge_level)
  self.monster[3] = self:add_npc_by_pos_key(1, 20101904, "center", -2, 2, "center", 0, 0, 4, self.challenge_level)
  self.monster[4] = self:add_npc_by_pos_key(1, 20101904, "center", -2, -2, "center", 0, 0, 4, self.challenge_level)
  self:cast_magic(self.monster[1], self.monster[1], 4031012, 1)
  self:cast_magic(self.monster[2], self.monster[2], 4031012, 1)
  self:cast_magic(self.monster[3], self.monster[3], 4031012, 1)
  self:cast_magic(self.monster[4], self.monster[4], 4031012, 1)
end

function M:on_npc_dead(npc)
  if not npc:is_npc() then
    return
  end
  if self.challenge_max_time - self.m_oSceneCounter:GetTimeCounter(40001):GetTime() > 0 and not self.challenge_is_false then
    local count = #self.monster
    for i = count, 1, -1 do
      local monster = self.monster[i]
      if monster == npc then
        table.remove(self.monster, i)
      end
    end
    for i = count, 1, -1 do
      if self.monster[i] then
        return
      end
    end
  else
    return
  end
  self:set_scene_camera(102)
  self:set_scene_tips(40011, true)
  self:remove_functional_npc(40001)
  self:add_functional_npc(2, "center", "center", {
    npc_id = 20120 + self.floor_num
  })
  self.is_success = true
  self.m_oSceneCounter:GetTimeCounter(40001):Stop()
end

function M:on_time_counter_end(id)
  if 40001 ~= id then
    return
  end
  self.challenge_is_false = true
  local count = #self.monster
  for i = count, 1, -1 do
    if self.monster[i] and self:check_activate(self.monster[i]) then
      local monster_pos = self:get_npc_pos(self.monster[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      self:remove_npc(self.monster[i])
    end
  end
  self:set_scene_camera(102)
  self:set_scene_tips(40012, true)
  self:timer_call_out(nil, function()
    self:fight_end(true)
    self:set_scene_tips(40012, false)
  end, 4)
  self:remove_functional_npc(40001)
end

function M:on_all_hero_die()
  self.m_oSceneCounter:GetTimeCounter(40001):Stop()
  self.challenge_is_false = true
  local count = #self.monster
  for i = count, 1, -1 do
    if self.monster[i] then
      local monster_pos = self:get_npc_pos(self.monster[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      Log.Info(Global.hero, "remove_npc 2:" .. i)
      self:remove_npc(self.monster[i])
    end
  end
  self:set_scene_camera(102)
  self:set_scene_tips(40012, true)
  self:timer_call_out(nil, function()
    self:fight_end(true)
    self:set_scene_tips(40012, false)
  end, 4)
  self:remove_functional_npc(40001)
end

function M:on_enter_area(npc, area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  return {
    chal_card_win = self.is_success
  }
end

function M:on_load(data)
  self.is_success = data.chal_card_win
end

function M:on_func_npc_interact_end(func_npc_id)
  if func_npc_id == 20100 + self.floor_num and self.is_success then
    self:fight_end(true)
    self:set_scene_tips(40011, false)
  end
end

return M
