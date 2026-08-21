local monster = Util.create_class()
local CommonRole = import("common.role")
local clueMgr = import("character.trap.3001099_1")
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 5
}
local skill_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 0
}
local skill_id_fast = 300109901
local skill_id_slow = 300109903
local missile_id_list = {
  30010990201,
  30010990202,
  30010990203,
  30010990204,
  30010990205,
  30010990206,
  30010990207
}
local near_distance = 3
local far_distance = 8

function monster:_init(npc)
  self.npc = get_god_npc()
  self.button_effect_delay = 0.25
  self.is_button_pressed = false
  self.has_show_effect = false
  self.delayed_time = 0
  self.skill_cd_fast = get_skill_cfg(skill_id_fast).CdChargePerCost
  self.skill_cd_slow = get_skill_cfg(skill_id_slow).CdChargePerCost
  self.last_rec_pos = {}
  self.target_list = {}
  self.current_ring = 0
  self.is_in_battle = false
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function monster:on_input(input_id)
  if 60 ~= input_id then
    return
  end
  if self.is_in_battle then
    if get_npc_cd_charge(self.npc, skill_id_slow) < self.skill_cd_slow then
      cast_magic(self.npc, self.npc, 100158, 1)
      return
    end
  elseif get_npc_cd_charge(self.npc, skill_id_fast) < self.skill_cd_fast then
    cast_magic(self.npc, self.npc, 100158, 1)
    return
  end
  self.is_button_pressed = true
  self.has_show_effect = false
  self.delayed_time = get_npc_time(self.npc) + self.button_effect_delay
end

function monster:on_touch_up(output_id, iscancel)
  if 60 ~= output_id or iscancel then
    return
  end
  if self.is_button_pressed == false then
    return
  end
  self.is_button_pressed = false
  set_indicator_active(60, false)
  CommonRole.indicator_slowdown_off(self)
  cast_skill(self.npc, self.npc, skill_id_slow)
  cast_skill(self.npc, self.npc, skill_id_fast)
  if self.is_in_battle then
    return
  end
  self:room_check()
  self.last_rec_pos = get_npc_pos(self.npc)
  local missile_id = missile_id_list[5]
  if get_sync_var("is_clue_invisible") then
    local closestDistance = 999
    local closestTarget = self.npc
    for key, value in pairs(clueMgr.invisible_clue_list) do
      local distanceToTarget = get_npc_distance(self.npc, 1, value, false)
      if closestDistance >= distanceToTarget then
        closestDistance = distanceToTarget
        closestTarget = value
      end
    end
    if check_npc_distance(self.npc, closestTarget, near_distance, false) then
      if closestTarget.id == 3001106 then
        call_scene_logic_custom_event("create_clue_M1")
      elseif closestTarget.id == 3001107 then
        call_scene_logic_custom_event("create_clue_M2")
      elseif closestTarget.id == 3001108 then
        call_scene_logic_custom_event("create_clue_M3")
      elseif closestTarget.id == 3001109 then
        call_scene_logic_custom_event("create_clue_M4")
      end
    end
  else
    for key, value in pairs(clueMgr.clue_list) do
      local facePos = get_npc_pos(value)
      local targetVec3 = get_npc_offset_position(self.npc, facePos, 0, 2)
      if value.id == 3001105 then
        missile_id = missile_id_list[4]
      elseif check_npc_distance(self.npc, value, near_distance, false) then
        missile_id = missile_id_list[1]
      elseif check_npc_distance(self.npc, value, far_distance, false) then
        missile_id = missile_id_list[2]
      else
        missile_id = missile_id_list[3]
      end
      local target = {
        id = missile_id,
        x = targetVec3.x,
        y = targetVec3.y,
        z = targetVec3.z
      }
      table.insert(self.target_list, target)
    end
  end
end

function monster:on_frame()
  self:check_area_effect()
  self:battle_check()
  self:area_check()
end

function monster:room_check()
  self.room_id = get_cur_room_id()
  if self.room_id == 110201 then
    call_scene_logic_custom_event("create_clue")
  elseif self.room_id == 110301 then
    call_scene_logic_custom_event("create_clue")
  end
end

function monster:area_check()
  if get_sync_var("is_clue_invisible") ~= true then
    if 0 ~= self.current_ring then
      remove_missile_by_id(self.current_ring, self.npc, true)
      self.current_ring = 0
    end
    return
  end
  if self.is_in_battle then
    return
  end
  local missile_id = 0
  local closestDistance = 999
  local closestTarget = self.npc
  for key, value in pairs(clueMgr.invisible_clue_list) do
    local distanceToTarget = get_npc_distance(self.npc, 1, value, false)
    if closestDistance >= distanceToTarget then
      closestDistance = distanceToTarget
      closestTarget = value
    end
  end
  if check_npc_distance(self.npc, closestTarget, near_distance, false) then
    missile_id = missile_id_list[5]
  elseif check_npc_distance(self.npc, closestTarget, far_distance, false) then
    missile_id = missile_id_list[6]
  else
    missile_id = missile_id_list[7]
  end
  if self.current_ring ~= missile_id then
    if 0 ~= self.current_ring then
      remove_missile_by_id(self.current_ring, self.npc, true)
    end
    cast_missile3(self.npc, nil, nil, nil, missile_id)
    self.current_ring = missile_id
  end
end

function monster:battle_check()
  local player = get_come_on_hero()
  local role = player:get_behavior()
  if not role then
    return
  end
  self.is_in_battle = role:isInBattle()
  if self.is_in_battle then
    replace_tower_skill(3)
  else
    replace_tower_skill(1)
  end
end

function monster:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if 300109901 ~= skill_id then
    return
  end
  for i = #self.target_list, 1, -1 do
    cast_missile3(self.npc, nil, self.target_list[i].x, self.target_list[i].z, self.target_list[i].id, 1, nil, nil, nil, self.target_list[i].y, self.last_rec_pos.x, self.last_rec_pos.z, self.last_rec_pos.y)
    table.remove(self.target_list, i)
  end
end

function monster:check_area_effect()
  if self.is_button_pressed == false then
    return
  end
  if self.has_show_effect == true then
    return
  end
  if get_npc_time(self.npc) < self.delayed_time then
    return
  end
  self.has_show_effect = true
  update_skill_indicator(60, skill_area, skill_indi_cfg, 0)
  set_indicator_active(60, true, true)
  CommonRole.indicator_slowdown_on(self)
end

return monster
