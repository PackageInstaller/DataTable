local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local TEMP_POS = {}

function M:_init()
  Base._init(self)
  self.skill01 = {
    20102502,
    2,
    1,
    1,
    99,
    get_skill_cfg(20102502).CastTime,
    get_skill_cfg(20102502).AfterTime,
    self.skill02
  }
  self.target = nil
  self.control = 1
  self.hit_count = 0
  self.hit_timer = 0
  self.hit_set = 0
  self.born_skill = 20102503
end

function M:wander_1st_step()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 1 ~= self.control then
    return
  end
  TEMP_POS.x, TEMP_POS.z = get_scene_map_pos_postion("M1")
  if 1 == self.control then
    lookat_position(self.npc, TEMP_POS.x, TEMP_POS.z, 1)
    move_to_pos(self.npc, TEMP_POS)
    if check_npc_distance_to_pos(self.npc, TEMP_POS.x, TEMP_POS.z, 1, true) then
      self.control = 2
    end
  end
end

function M:wander_2nd_step()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 2 ~= self.control then
    return
  end
  TEMP_POS.x, TEMP_POS.z = get_scene_map_pos_postion("M2")
  if 2 == self.control then
    lookat_position(self.npc, TEMP_POS.x, TEMP_POS.z, 1)
    move_to_pos(self.npc, TEMP_POS)
    if check_npc_distance_to_pos(self.npc, TEMP_POS.x, TEMP_POS.z, 1, true) then
      self.control = 3
    end
  end
end

function M:wander_3rd_step()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 3 ~= self.control then
    return
  end
  TEMP_POS.x, TEMP_POS.z = get_scene_map_pos_postion("M3")
  if 3 == self.control then
    lookat_position(self.npc, TEMP_POS.x, TEMP_POS.z, 1)
    move_to_pos(self.npc, TEMP_POS)
    if check_npc_distance_to_pos(self.npc, TEMP_POS.x, TEMP_POS.z, 1, true) then
      self.control = 4
    end
  end
end

function M:wander_4th_step()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 4 ~= self.control then
    return
  end
  TEMP_POS.x, TEMP_POS.z = get_scene_map_pos_postion("M4")
  if 4 == self.control then
    lookat_position(self.npc, TEMP_POS.x, TEMP_POS.z, 1)
    move_to_pos(self.npc, TEMP_POS)
    if check_npc_distance_to_pos(self.npc, TEMP_POS.x, TEMP_POS.z, 1, true) then
      self.control = 5
    end
  end
end

function M:wander_5th_step()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 5 ~= self.control then
    return
  end
  TEMP_POS.x, TEMP_POS.z = get_scene_map_pos_postion("M5")
  if 5 == self.control then
    lookat_position(self.npc, TEMP_POS.x, TEMP_POS.z, 1)
    move_to_pos(self.npc, TEMP_POS)
    if check_npc_distance_to_pos(self.npc, TEMP_POS.x, TEMP_POS.z, 1, true) then
      self.control = 1
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    return
  end
  if hit_target == self.npc and 0 == self.hit_set and check_npc_status(self.npc, 2) then
    print("//////////")
    self.hit_count = self.hit_count + 1
    if self.hit_count >= 1 then
      self.hit_timer = get_npc_time(self.npc) + 1.5
    end
    self.hit_set = 1
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 2 == self.hit_set and skill_id == self.skill01[1] then
    self.hit_set = 0
  end
end

function M:hit_count_check()
  local now_time = get_npc_time(self.npc)
  if (now_time >= self.hit_timer or self.hit_count >= 6) and 1 == self.hit_set then
    abort_skill(self.npc, true)
    
    local function point_random(state)
      local random = math.random(2, 5)
      if 1 ~= state then
        if random == state then
          self.control = 1
        else
          self.control = random
        end
      elseif 1 == state then
        self.control = random
      end
      local point = "M" .. random
      TEMP_POS.x, TEMP_POS.z = get_scene_map_pos_postion(point)
      cast_skill(self.npc, nil, self.skill01[1], TEMP_POS.x, TEMP_POS.z)
    end
    
    if 1 == self.control then
      point_random(1)
    elseif 2 == self.control then
      point_random(2)
    elseif 3 == self.control then
      point_random(3)
    elseif 4 == self.control then
      point_random(4)
    elseif 5 == self.control then
      point_random(5)
    end
    self.hit_count = 0
    self.hit_set = 2
    self.hit_timer = 999999
  end
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  self:wander_1st_step()
  self:wander_2nd_step()
  self:wander_3rd_step()
  self:wander_4th_step()
  self:wander_5th_step()
  self:hit_count_check()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
