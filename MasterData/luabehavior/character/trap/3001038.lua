local Base = import("character.base.base_monster")
local M = Util.create_class()
local CommonMonster = import("common.monster")

function M:_init(npc)
  self.wander_timer = get_time()
  
  local function monster_skill_cfg(self, skill_id, cd, count_timer, cast_dis_min, cast_dis_max, next_skill, can_cast, next_skill_no_interrupt)
    local skill_cfg = get_skill_cfg(skill_id)
    return {
      skill_id,
      cd,
      self.wander_timer + count_timer,
      cast_dis_min,
      cast_dis_max,
      skill_cfg.CastTime,
      skill_cfg.AfterTime,
      next_skill,
      can_cast,
      next_skill_no_interrupt
    }
  end
  
  self.skill_fix = monster_skill_cfg(self, 300103801, 0, 0, 0, 30, nil, true, false)
  self.stun = monster_skill_cfg(self, 300103802, 0, 0, 0, 30, nil, true, false)
  self.stand = monster_skill_cfg(self, 300103803, 0, 0, 0, 30, nil, true, false)
  self.fix_point_x, self.fix_point_z = get_scene_map_pos_postion("A1")
  self.end_point_x, self.end_point_z = get_scene_map_pos_postion("C1")
  self.target_pos_now = {
    x = 0,
    y = 0,
    z = 0
  }
  if self.fix_point_x then
    self.target_pos_now.x = self.fix_point_x
    self.target_pos_now.z = self.fix_point_z
  else
    self.target_pos_now.x = self.end_point_x
    self.target_pos_now.z = self.end_point_z
  end
  self.shield_on = false
  self.charge_time = 0
  self.control = 0
  set_hud_config("3001038_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
end

function M:shiled_stun_check()
  local enemy = search_npc(self.npc, 4, 5, 0, 0)
  if not self.shield_on and enemy then
    cast_magic(self.npc, self.npc, 3001038001, 0)
    cast_magic(self.npc, self.npc, 3001038004, 0)
    self.shield_on = true
  elseif self.shield_on and not enemy then
    self.shield_on = false
    abort_magic_by_id(self.npc, 3001038001)
    abort_magic_by_id(self.npc, 3001038004)
  end
  if self.shield_on and not check_magic(self.npc, 3001038001) then
    active_hud(self.npc, "3001038_bar", "attachpoint", false)
    stop_move(self.npc)
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.stun[1])
    set_skill_end_to_idle(self.npc, false)
    self:wander_time(self.stun)
    self.control = 3
    self.shield_on = false
    return true
  end
end

function M:skill_main_logic()
  local nowtime = get_time()
  if check_magic(self.npc, 3001038005) then
    abort_magic_by_id(self.npc, 3001038005)
    cast_missile(self.npc, self.npc, nil, nil, 30010380401, 0)
  end
  if check_magic(self.npc, 3001038007) and 6 ~= self.control then
    self.shield_on = false
    abort_magic_by_id(self.npc, 3001038001)
    active_hud(self.npc, "3001038_bar", "attachpoint", false)
    stop_move(self.npc)
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.stun[1])
    set_skill_end_to_idle(self.npc, false)
    self.wander_timer_skill_makeup = 99999999999
    self.wander_timer = get_time() + self.wander_timer_skill_makeup
    self.control = 6
  end
  if 0 == self.control then
    self:shiled_stun_check()
    if nowtime > self.wander_timer then
      if get_npc_distance(self.npc, 2, self.target_pos_now.x, self.target_pos_now.z, false) >= 1 then
        switch_move_type(self.npc, 1)
        move_to_pos(self.npc, self.target_pos_now)
        if self.target_pos_now.x == self.fix_point_x then
          self.control = 1
        elseif self.target_pos_now.x == self.end_point_x then
          self.control = 5
        end
      elseif self.target_pos_now.x == self.fix_point_x then
        stop_move(self.npc)
        cast_skill(self.npc, nil, self.skill_fix[1], self.target_pos_now.x, self.target_pos_now.z)
        self:wander_time(self.skill_fix)
        self.control = 2
      end
    end
    return true
  elseif 1 == self.control then
    self:shiled_stun_check()
    if get_npc_distance(self.npc, 2, self.target_pos_now.x, self.target_pos_now.z, false) < 1 then
      stop_move(self.npc)
      cast_skill(self.npc, nil, self.skill_fix[1], self.target_pos_now.x, self.target_pos_now.z)
      self:wander_time(self.skill_fix)
      self.control = 2
      active_hud(self.npc, "3001038_bar", "attachpoint", true, "维修")
    end
  elseif 2 == self.control then
    self:shiled_stun_check()
    local npc_time = get_npc_time(self.npc)
    local energy_now = get_npc_attr(self.npc, 3)
    local energy_max = get_npc_attr(self.npc, 6)
    if energy_now >= energy_max then
      active_hud(self.npc, "3001038_bar", "attachpoint", false)
      self.target_pos_now.x = self.end_point_x
      self.target_pos_now.z = self.end_point_z
      self.control = 4
    end
    if energy_now < energy_max and npc_time > self.charge_time then
      cast_magic(self.npc, self.npc, 3001038002, 0)
      self.charge_time = npc_time + 0.05
    end
    return true
  elseif 3 == self.control then
    if nowtime > self.wander_timer then
      cast_skill(self.npc, self.npc, self.stand[1])
      set_skill_end_to_idle(self.npc, true)
      self:wander_time(self.stand)
      self.control = 0
      return true
    else
      return false
    end
  elseif 4 == self.control then
    self:shiled_stun_check()
    abort_skill(self.npc, 1)
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.target_pos_now)
    self.control = 5
  elseif 5 == self.control then
    self:shiled_stun_check()
  elseif 6 == self.control then
    if not check_magic(self.npc, 3001038007) then
      cast_skill(self.npc, self.npc, self.stand[1])
      set_skill_end_to_idle(self.npc, true)
      self:wander_time(self.stand)
      self.control = 0
      return true
    else
      return false
    end
  end
end

function M:wander_time(skill)
  self.wander_timer_skill_makeup = skill[6] + skill[7]
  self.wander_timer = get_time() + self.wander_timer_skill_makeup
end

function M:on_frame()
  self:skill_main_logic()
  if check_magic(self.npc, 3001038008) then
    self.end_point_x, self.end_point_z = get_scene_map_pos_postion("C2")
    if self.fix_point_x then
      self.target_pos_now.x = self.fix_point_x
      self.target_pos_now.z = self.fix_point_z
    else
      self.target_pos_now.x = self.end_point_x
      self.target_pos_now.z = self.end_point_z
    end
    abort_magic_by_id(self.npc, 3001038008)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
