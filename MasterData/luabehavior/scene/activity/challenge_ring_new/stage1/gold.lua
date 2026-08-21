local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    3002011,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    3002011,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    3002011,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3002012,
    "center",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  }
}
local cast_magic_id = {
  [1] = 3002006005,
  [2] = 3002006004
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
  self.wz_SceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 30
  self.challenge_max_counter = 20
  self.score = 0
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(102)
  self.scoreTime = os.time()
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
  for index = 1, 2 do
    self:cast_magic(self.mm1, self.mm1, cast_magic_id[index], 1)
    self:cast_magic(self.mm2, self.mm2, cast_magic_id[index], 1)
    self:cast_magic(self.mm3, self.mm3, cast_magic_id[index], 1)
  end
end

function M:on_frame()
  if not self.is_success and not self:is_pass_room() and not self.is_add_npc then
    self:remove_functional_npc(50006)
    self:remove_functional_npc(20110 + self.floor_num)
    self:remove_functional_npc(20100 + self.floor_num)
    self:add_functional_npc(4, "center", "center", {npc_id = 50006})
    self.is_add_npc = true
  end
  local remain_mon2 = self:get_npc_count_by_kind(2)
  if 1 == self.challenge_condition and (self.settlementTime and os.time() - self.settlementTime >= 5 and remain_mon2 <= 2 or 0 == remain_mon2) then
    self:add_monster()
    self.settlementTime = os.time()
  end
end

function M:on_npc_show_end(id, type)
  if 50006 ~= id then
    return
  end
  self.wz_SceneCounter:AddNormalCounter(50204, self.challenge_max_counter, 1)
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self.challenge_condition = 1
  self:add_monster()
  self:curse_time_start()
  self.settlementTime = os.time()
  self:set_scene_tips(50205, true)
  self:set_scene_tips(50208, true)
end

function M:on_npc_dead(npc)
  if npc == Global.hero then
    return
  end
  local normalCounter = self.wz_SceneCounter:GetNormalCounter(50204)
  if npc == self.mm4 then
    normalCounter:AddCnt()
    normalCounter:AddCnt()
    self.score = self.score + 2
  else
    normalCounter:AddCnt()
    self.score = self.score + 1
  end
end

function M:on_time_counter_end(id)
  if 40001 ~= id then
    return
  end
  self.challenge_is_false = true
  self.challenge_condition = 0
  self.is_success = true
  self:set_scene_tips(50205, false)
  self:set_scene_tips(50204, false)
  self:set_scene_tips(50208, false)
  local count = #self.monster_list
  for i = count, 1, -1 do
    if self.monster_list[i] and self:check_activate(self.monster_list[i]) then
      local monster_pos = self:get_npc_pos(self.monster_list[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      self:remove_npc(self.monster_list[i])
    end
  end
  if self.score and self.score >= 10 and self.score < 20 then
    self:add_functional_npc(2, "NPC", "tp3", {
      npc_id = 20110 + self.floor_num
    })
    self:set_scene_tips(50206, true)
  elseif self.score and self.score >= 20 then
    self:add_functional_npc(2, "NPC", "tp3", {
      npc_id = 20100 + self.floor_num
    })
    self:set_scene_tips(50207, true)
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
    self:set_scene_tips(50206, false)
    self:set_scene_tips(50207, false)
  end
end

return M
