local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    3001028,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm11"
  },
  [2] = {
    1,
    3001028,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1",
    "mm21"
  },
  [3] = {
    1,
    3001028,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm31"
  },
  [4] = {
    1,
    3001028,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm41"
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    3001030,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm12"
  },
  [2] = {
    1,
    3001030,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1",
    "mm22"
  },
  [3] = {
    1,
    3001030,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm32"
  },
  [4] = {
    1,
    3001030,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm42"
  }
}
lMonster.RANDOW_VAL_103 = {
  [1] = {
    1,
    3001031,
    "tp1",
    0,
    0,
    "tp1",
    -1,
    -1,
    4,
    "monster1",
    "mm13"
  }
}
local check_magic_id = {
  [1] = 399983,
  [2] = 399984,
  [3] = 399985,
  [4] = 399986,
  [5] = 399987,
  [6] = 399988,
  [7] = 399987,
  [8] = 399988,
  [9] = 4031021,
  [10] = 4031022,
  [11] = 3001017003,
  [12] = 4031024
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
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 20
  self.challenge_max_counter = 20
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(9901)
  self:set_sync_var("shot_score", 0)
  self.scoreTime = os.time()
  self:cast_magic(Global.hero, Global.hero, check_magic_id[12], 1)
  if not self.texture_guide then
    self:timer_call_out(nil, function()
      self:start_texture_guide(1211002)
      self.texture_guide = true
    end, 0.5)
  end
end

function M:add_monster()
  self.random_id = math.random(1, 3)
  if self.random_before and self.random_before == self.random_id then
    self.random_id = math.random(1, 3)
  else
    self.random_before = self.random_id
    local list_id = 100 + self.random_id
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
    if 3 == self.random_id then
      self:cast_magic(self.mm13, self.mm13, check_magic_id[1], 1)
      self:create_world_model_on_position("FX_crack", "liexi", "traneffect3", 0.1, "bornpoint")
    else
      self:create_world_model_on_position("FX_crack", "liexi", "traneffect1", 0.1, "bornpoint")
      self:create_world_model_on_position("FX_crack", "liexi", "traneffect2", 0.1, "bornpoint")
      self:cast_magic(self["mm1" .. self.random_id], self["mm1" .. self.random_id], check_magic_id[1], 1)
      self:cast_magic(self["mm2" .. self.random_id], self["mm2" .. self.random_id], check_magic_id[2], 1)
      self:cast_magic(self["mm3" .. self.random_id], self["mm3" .. self.random_id], check_magic_id[3], 1)
      self:cast_magic(self["mm4" .. self.random_id], self["mm4" .. self.random_id], check_magic_id[4], 1)
    end
  end
end

function M:on_texture_guide_finish(group_id)
  if 1211002 == group_id then
    self.texture_guide = 1
  end
end

function M:on_frame()
  local attr100num = self:get_sync_var("attr100num")
  if 1 == self.texture_guide and not self:check_magic(Global.hero, check_magic_id[13]) and attr100num and attr100num > 0 then
    self:set_scene_tips(50120 + tonumber(attr100num), true)
    if attr100num <= 2 then
      self.challenge_max_time = self.challenge_max_time + attr100num * 10
    elseif attr100num > 2 then
      self.challenge_max_time = self.challenge_max_time + 20
    end
    self.texture_guide = 2
  end
  if not self.is_success and not self:is_pass_room() and not self.is_add_npc then
    self:remove_functional_npc(50003)
    self:remove_functional_npc(50002)
    self:remove_functional_npc(20110 + self.floor_num)
    self:remove_functional_npc(20100 + self.floor_num)
    self:add_functional_npc(4, "start", "start", {npc_id = 50003})
    self:add_functional_npc(4, "tp1", "center", {npc_id = 50002})
    self.is_add_npc = true
  end
  if 1 == self.challenge_condition and not self:check_magic(Global.hero, check_magic_id[9]) then
  elseif 0 == self.challenge_condition and self:check_magic(Global.hero, check_magic_id[9]) then
    self:cast_magic(Global.hero, Global.hero, check_magic_id[10], 1)
  end
  local remain_mon2 = self:get_npc_count_by_kind(2)
  if 1 == self.challenge_condition and (self.settlementTime and os.time() - self.settlementTime >= 5 and remain_mon2 <= 2 or 0 == remain_mon2) then
    self:add_monster()
    self.settlementTime = os.time()
    self:cast_magic(Global.hero, Global.hero, check_magic_id[11], 1)
  end
  if 1 == self.challenge_condition then
    self:set_scene_tips(50000, true, {
      cur_cnt = self:get_sync_var("shot_score"),
      total_cnt = self.challenge_max_counter
    })
  end
end

function M:on_npc_show_start(id, type)
  if 50003 == id then
    self:remove_functional_npc(50002)
    self:set_ui_object_visible("fight", "Btn_skill1", false)
    self:set_ui_object_visible("fight", "Btn_skill3", false)
    self:set_ui_object_visible("fight", "Btn_skill4", false)
    self:set_ui_object_visible("fight", "Btn_skill5", false)
    self:set_ui_object_visible("fight", "JoystickContent", false)
    self:stop_move(Global.hero)
    return
  end
  if 50002 == id then
    self:fight_end(true)
    self:remove_functional_npc(40001)
    return
  end
end

function M:on_npc_show_end(id, type)
  if 50003 ~= id then
    return
  end
  self:remove_functional_npc(50002)
  self:set_scene_tips(50000, true, {
    cur_cnt = self:get_sync_var("shot_score"),
    total_cnt = self.challenge_max_counter
  })
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self:set_functional_npc_visible(50003, false)
  self.challenge_condition = 1
  self:add_monster()
  self.settlementTime = os.time()
  self:cast_magic(Global.hero, Global.hero, check_magic_id[9], 1)
  self:start_guide(2022)
  self:set_scene_tips(50011, true)
end

function M:on_time_counter_end(id)
  if 40001 ~= id then
    return
  end
  self.challenge_is_false = true
  self.challenge_condition = 0
  self.is_success = true
  self:force_finish_cur_guide()
  local count = #self.monster_list
  self:set_scene_tips(50000, false)
  self:set_scene_tips(50011, false)
  for i = count, 1, -1 do
    if self.monster_list[i] and self:check_activate(self.monster_list[i]) then
      local monster_pos = self:get_npc_pos(self.monster_list[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      self:remove_npc(self.monster_list[i])
    end
  end
  local shot_score = self:get_sync_var("shot_score")
  if shot_score and shot_score >= 40 and shot_score < 80 then
    self:add_functional_npc(2, "NPC", "tp3", {
      npc_id = 20110 + self.floor_num
    })
    self:set_scene_tips(50004, true)
    self:remove_functional_npc(50003)
  elseif shot_score and shot_score >= 40 then
    self:add_functional_npc(2, "NPC", "tp3", {
      npc_id = 20100 + self.floor_num
    })
    self:set_scene_tips(50005, true)
    self:remove_functional_npc(50003)
  else
    self:timer_call_out(nil, function()
      self:fight_end(true)
    end, 4)
    self:set_scene_tips(50007, true)
  end
end

function M:on_enter_area(npc, area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  return {
    chal_card_win = self.is_success,
    texture_guide = self.texture_guide
  }
end

function M:on_load(data)
  self.is_success = data.chal_card_win
  self.texture_guide = data.texture_guide
end

function M:on_guide_finished(guide_id)
end

function M:on_func_npc_interact_end(func_npc_id)
  if (func_npc_id == 20110 + self.floor_num or func_npc_id == 20100 + self.floor_num) and self.is_success then
    self:fight_end(true)
    self:set_scene_tips(50004, false)
    self:set_scene_tips(50005, false)
  end
end

return M
