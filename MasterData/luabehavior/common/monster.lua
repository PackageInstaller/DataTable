local M = {}
local datas = {}
local camp_weights = {
  ["近攻"] = {},
  ["远攻"] = {},
  ["近攻数"] = {2, 3},
  ["远攻数"] = {0}
}
local camp_numbs_elit_fix = {
  ["近攻数修正"] = {0},
  ["远攻数修正"] = {0}
}
local camp_time = {
  0,
  5,
  0
}
local camp_time_switch = 0
local counteratk_time = 0

function M.set_value(tbl, key, value, clear_command)
  local data = datas[tbl]
  if clear_command then
    if key then
      data[key] = nil
    else
      datas[tbl] = nil
    end
  else
    if not data then
      data = {}
      datas[tbl] = data
    end
    data[key] = value
  end
end

function M.get_value(tbl, key)
  local data = datas[tbl]
  if data then
    return data[key]
  end
end

function M.reset_on_enter_room()
  M.set_value("正在攻击的近战怪物数量", nil, nil, true)
  M.set_value("正在攻击的远程怪物数量", nil, nil, true)
  M.set_value("群组攻击影响时间", nil, nil, true)
end

function M:test_majotime_sd()
  if not check_magic(self.npc, 1999203) then
    local char_list = search_npc(self.npc, 4, 100, 1999202, 1, true)
    local now_time = get_time()
    for _, v in pairs(char_list) do
      if v and now_time >= self.majotime_timer then
        cast_magic(self.npc, self.npc, 1999203, 1)
        self.mojotime_set = false
      end
    end
  end
end

function M:tiktok_timer_func(delay_time, do_func)
  self.tiktok_timer_set = delay_time + get_npc_time(self.npc)
  self.tiktok_func = {}
  self.tiktok_func[do_func] = true
end

function M:tiktok_timer_frame()
  if self.tiktok_timer_set then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.tiktok_timer_set then
      for i, v in pairs(self.tiktok_func) do
        if true == v then
          self.tiktok_timer_set = nil
          self.tiktok_func[i] = nil
          i()
          break
        end
      end
    end
  end
end

function M:monster_on_frame()
  if self.mojotime_set == true then
    M.test_majotime_sd(self)
  end
  if 1 == get_sync_var("in_daze") then
    self.monster_scene_state = false
  end
  if get_sync_var("close_counterattack") then
    self.hurt_system = 1
  end
  if is_pass_room() then
    M.set_value("正在攻击的近战怪物数量", nil, nil, true)
    M.set_value("正在攻击的远程怪物数量", nil, nil, true)
    M.set_value("群组攻击影响时间", nil, nil, true)
  end
  if self.counter_val_decay_timer and self.counter_val_decay_timer > 0 then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.counter_val_decay_timer + 3 then
      self.counter_atk_val = self.counter_atk_val - (math.random() * 20 + 15)
      if self.counter_atk_val < 0 then
        self.counter_atk_val = 0
      end
      self.counter_val_decay_timer = self.counter_val_decay_timer + 0.5
    end
  end
  M.tiktok_timer_frame(self)
  M.remove_timer(self)
end

function M:camp_mons_dispersion(monster_type, max_dis)
  local near_alley = search_npc(self.npc, 2, 2, nil, false, true)
  local dir_check = 0
  if 1 == monster_type then
    for _, v in pairs(near_alley) do
      if v then
        local angle = get_target_angel(self.npc, v, true)
        if (angle <= 45 or angle >= -45) and check_npc_distance(self.npc, v, max_dis, false) then
          dir_check = 1
        end
        break
      end
    end
    if 1 == dir_check then
      local ran = math.random(3, 4)
      switch_move_type(self.npc, ran)
      moveto_npc(self.npc, self.target)
      return
    end
  else
    for _, v in pairs(near_alley) do
      if v then
        local angle = get_target_angel(self.npc, v, true)
        if angle <= 180 and angle >= 0 and check_npc_distance(self.npc, v, max_dis, false) then
          dir_check = 1
        end
        break
      end
    end
    if 1 == dir_check then
      local ran = math.random(3, 4)
      switch_move_type(self.npc, ran)
      moveto_npc(self.npc, self.target)
      return
    end
  end
end

function M:wander_main_logic(min_dis, max_dis, wander_interval)
  if not self.monster_scene_state then
    return
  end
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 1 == self.control then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  local now_time = get_npc_time(self.npc)
  if now_time < self.wander_timer then
    return
  end
  wander_interval = wander_interval or 1
  if 1 == self.monster_type then
    local group_id = get_npc_group_id(self.npc)
    if group_id and M.get_value("正在攻击的近战怪物数量", -1) and M.get_value("正在攻击的近战怪物数量", -1) >= 2 then
      M.camp_mons_dispersion(self, self.monster_type, max_dis)
      self.wander_timer = now_time + wander_interval
      self.wander_state = 4
      return
    end
    if 99 == self.control and check_npc_distance(self.npc, self.target, min_dis, false) then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
      self.wander_timer = now_time + wander_interval
      self.wander_state = 1
    elseif check_npc_distance(self.npc, self.target, max_dis, true) then
      local ran = math.random(1, 3)
      if 1 == ran then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      elseif 2 == ran then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      else
        switch_move_type(self.npc, 4)
        moveto_npc(self.npc, self.target)
      end
      self.wander_timer = now_time + wander_interval
      if 2 ~= self.wander_state then
        self.wander_state = 2
      end
    elseif not check_npc_distance(self.npc, self.target, max_dis, true) then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
      self.wander_timer = now_time + wander_interval
      self.wander_state = 3
    end
  elseif 2 == self.monster_type then
    local group_id = get_npc_group_id(self.npc)
    if group_id and M.get_value("正在攻击的远程怪物数量", -1) and M.get_value("正在攻击的远程怪物数量", -1) >= 2 then
      M.camp_mons_dispersion(self, self.monster_type, max_dis)
      self.wander_timer = now_time + wander_interval
      self.wander_state = 4
      return
    end
    if check_npc_distance(self.npc, self.target, min_dis, true) and 1 ~= self.wander_state then
      local ran = math.random(1, 3)
      if 1 == ran then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      elseif 2 == ran then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      else
        switch_move_type(self.npc, 4)
        moveto_npc(self.npc, self.target)
      end
      self.wander_timer = now_time + wander_interval
      self.wander_state = 1
    elseif check_npc_distance(self.npc, self.target, max_dis, true) then
      local ran = math.random(1, 3)
      if 1 == ran then
        stop_move(self.npc)
        lookat_npc(self.npc, self.target, 0)
      elseif 2 == ran then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      else
        switch_move_type(self.npc, 4)
        moveto_npc(self.npc, self.target)
      end
      self.wander_timer = now_time + wander_interval
      if 2 ~= self.wander_state then
        self.wander_state = 2
      end
    elseif not check_npc_distance(self.npc, self.target, max_dis, false) and 3 ~= self.wander_state then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
      self.wander_state = 3
    end
  end
end

function M:skill_cast_condition(skill_instant, now_time, group_id, monster_type, check_nums, CD_delay_time)
  if not self.monster_scene_state then
    return true
  end
  if not self.target or not self.npc then
    return true
  end
  if skill_instant then
    if now_time <= skill_instant[3] then
      return true
    end
    if check_npc_distance(self.npc, self.target, skill_instant[5], true) and not check_npc_distance(self.npc, self.target, skill_instant[4], false) then
    else
      return true
    end
  end
  if group_id then
    if not M.get_value("群组攻击影响时间", group_id) then
      M.set_value("群组攻击影响时间", group_id, 0)
    end
    if not M.get_value("正在攻击的近战怪物数量", group_id) then
      M.set_value("正在攻击的近战怪物数量", group_id, 0)
    end
    if not M.get_value("正在攻击的远程怪物数量", group_id) then
      M.set_value("正在攻击的远程怪物数量", group_id, 0)
    end
    if now_time <= M.get_value("群组攻击影响时间", group_id) then
      return true
    end
    
    local function group_do(var_name)
      if M.get_value(var_name, group_id) >= check_nums - 1 then
        for _, v in pairs(self.camp_skill_list) do
          v[3] = v[3] + CD_delay_time
        end
        M.set_value("群组攻击影响时间", group_id, now_time + CD_delay_time)
        return true
      end
    end
    
    local alley_near = search_npc(self.npc, 2, 15, nil, false, true)
    local alley_nums = #alley_near
    if 1 == monster_type then
      group_do("正在攻击的近战怪物数量")
    elseif 2 == monster_type then
      if alley_nums <= 3 then
        check_nums = check_nums + 1
      end
      group_do("正在攻击的远程怪物数量")
    end
  end
end

function M:skill_main_condition()
  if not self.monster_scene_state then
    return true
  end
  if not self.target then
    return true
  end
  if is_cast_skill_time(self.npc, nil, 1) then
    return true
  end
  local now_time = get_npc_time(self.npc)
  if self.stun_info.set == true then
    if now_time >= self.stun_info.time then
      self.control = 0
      self.stun_info.set = false
    else
      return true
    end
  end
  if check_npc_status(self.npc, 2) then
    return true
  end
  if 0 ~= self.control then
    return true
  end
end

function M:counteratk()
  local now_time
  if 0 ~= self.control then
    return
  end
  if not self.monster_scene_state then
    return
  end
  if 0 ~= self.hurt_system then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 10) or check_npc_status(self.npc, 11) then
    return
  end
  if os.time() < counteratk_time then
    return
  end
  if self.hurt_value < 100 then
    return
  end
  if now_time > self.hurt_attack_time then
    self.hurt_attack = math.random(1, 10) + (self.hurt_value - 100) * 0.05
    if self.hurt_attack > 5 then
      abort_skill(self.npc)
      self.hurt_atk_state = true
      cast_skill(self.npc, self.target, skill_counterattack[1])
      self.hurt_value = 40
      counteratk_time = os.time() + 10
      self.hurt_value_time = now_time + 5
    else
      self.hurt_attack_time = now_time + 2
    end
  end
end

function M:counteratk_ironbody(skill)
  cast_skill(self.npc, self.target, skill_counterattack[2])
end

function M:counterattack_value()
  local now_time
  local interval_time = 0.25
  now_time = get_npc_time(self.npc)
  if now_time < self.hurt_value_time then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if now_time >= self.hurt_value_time then
    if 1 == self.hurt_type then
      self.hurt_value = self.hurt_value + 5
      self.hurt_type = 0
      self.hurt_value_time = now_time + interval_time
    elseif 3 == self.hurt_type then
      self.hurt_value = self.hurt_value + 10
      self.hurt_type = 0
      self.hurt_value_time = now_time + interval_time
    elseif 4 == self.hurt_type then
      self.hurt_value = self.hurt_value + 20
      self.hurt_type = 0
      self.hurt_value_time = now_time + interval_time
    end
  end
end

function M:counterattack_hurt_type(npc, skill_type)
  if npc == self.target then
    self.hurt_type = skill_type
  end
end

function M:camp_dead_logic(npc)
  if npc == self.npc and 0 ~= self.camp then
    if 1 == self.monster_type then
      for k, v in pairs(camp_weights["近攻"]) do
        if v[2] == npc then
          v[1] = 0
          table.remove(camp_weights["近攻"], k)
        end
      end
    elseif 2 == self.monster_type then
      for k, v in pairs(camp_weights["远攻"]) do
        if v[2] == npc then
          v[1] = 0
          table.remove(camp_weights["远攻"], k)
        end
      end
    end
  end
end

function M.CountTB(tbData)
  local count = 1
  if tbData then
    for key, value in pairs(tbData) do
      count = count + 1
    end
  end
  return count
end

function M.camp_time_logic(npc)
  if os.time() > camp_time[1] then
    camp_time[1] = os.time() + camp_time[2] + camp_time[3]
    camp_time_switch = M.CountTB(search_npc(npc, 2, 300, nil, 1, true))
    return true
  else
    return false
  end
end

function M:camp_set_value(tbl)
  local camp_weight = {
    get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4),
    self.npc
  }
  local camp_key = 0
  if nil == camp_weights[tbl][1] then
    table.insert(camp_weight, 3, 1)
    table.insert(camp_weights[tbl], camp_weight)
  else
    for k, v in pairs(camp_weights[tbl]) do
      if v[2] == self.npc then
        self.camp_switch = self.camp_switch + 1
        camp_key = k
      else
        camp_key = camp_key + 1
      end
      if self.camp_switch > 0 then
        break
      end
    end
    if self.camp_switch > 0 then
      table.insert(camp_weight, 3, camp_key)
      camp_weights[tbl][camp_key] = camp_weight
    elseif 0 == self.camp_switch then
      table.insert(camp_weight, 3, camp_key)
      table.insert(camp_weights[tbl], camp_weight)
    end
    camp_time_switch = camp_time_switch - 1
  end
end

function M:camp_change(tbl, type)
  if self.camp > 5 then
    return
  end
  if camp_weights[tbl] then
    table.sort(camp_weights[tbl], function(a, b)
      if a[1] > b[1] then
        return true
      elseif a[1] == b[1] then
        if a[3] < b[3] then
          return true
        elseif a[3] == b[3] then
          return false
        else
          return false
        end
      end
    end)
  else
    return
  end
  if camp_weights["近攻"][1] == nil then
    camp_weights["远攻数"][1] = 4
  elseif camp_weights["近攻"][2] == nil then
    self.camp_distance["近攻"][1] = 1.5
    self.camp_distance["近攻"][2] = 3
    camp_weights["远攻数"][1] = 3
  else
    camp_weights["远攻数"][1] = 2
  end
  local camp_numbs_min = camp_weights["近攻数"][1] + camp_numbs_elit_fix["近攻数修正"][1]
  local camp_numbs_max = camp_weights["近攻数"][2] + camp_numbs_elit_fix["近攻数修正"][1]
  local camp_numbs_far = camp_weights["远攻数"][1] + camp_numbs_elit_fix["远攻数修正"][1]
  if 1 == type then
    for k, v in pairs(camp_weights[tbl]) do
      if k >= 1 and k <= camp_numbs_min and v[2] == self.npc then
        self.camp = 1
      end
      if k >= camp_numbs_min + 1 and k <= camp_numbs_max and v[2] == self.npc then
        self.camp = 4
      end
      if k >= camp_numbs_max + 1 and v[2] == self.npc then
        self.camp = 3
      end
    end
  elseif 2 == type then
    for k, v in pairs(camp_weights[tbl]) do
      if k >= 1 and k <= camp_numbs_far and v[2] == self.npc then
        self.camp = 2
      elseif k >= camp_numbs_far + 1 and v[2] == self.npc then
        self.camp = 5
      end
    end
  end
  self.camp_switch = 0
end

function M:camp_main_logic()
  if self.camp > 5 then
    return
  end
  if not self.monster_scene_state then
    return
  end
  local camp_npc = self.npc
  if M.camp_time_logic(camp_npc) or camp_time_switch > 0 then
    if not self.monster_type then
      return
    end
    if 1 == self.monster_type then
      M.camp_set_value(self, "近攻")
      M.camp_change(self, "近攻", 1)
    end
    if self.monster_type >= 2 then
      M.camp_set_value(self, "远攻")
      M.camp_change(self, "远攻", 2)
    end
  end
end

function M:attack_wander_random()
  if clear_force_target() == self.npc and 0 == self.camp_distance_random_melee[2] then
    self.camp_distance_random_melee[1] = get_npc_time(self.npc) + 1
    self.camp_distance_random_melee[2] = 1
  end
  if clear_force_target() == self.npc and get_npc_time(self.npc) >= self.camp_distance_random_melee[1] then
    if not check_npc_distance(self.npc, self.target, 2, false) then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
    elseif 0 == math.random(0, 1) then
      stop_move(self.npc)
      lookat_npc(self.npc, self.target)
    elseif 0 == math.random(0, 1) then
      switch_move_type(self.npc, 3)
      moveto_npc(self.npc, self.target)
    else
      switch_move_type(self.npc, 4)
      moveto_npc(self.npc, self.target)
    end
    abort_magic_by_id(self.npc, 20109991)
    self.camp_distance_random_melee[2] = 0
  end
  self.camp_angle_switch = get_target_angel(self.target, self.npc, true)
  if self.camp_angle_switch >= -90 and self.camp_angle_switch <= 90 then
    if clear_force_target() ~= self.npc then
      if self.camp_distance_random[4] >= 3 then
        if math.random(1, 4) <= 3 then
          self.camp_distance_random[4] = 0
          self.camp_distance_random[2] = self.now_time + 1.5 + math.random(0, 10) * 0.1
        else
          self.camp_distance_random[4] = 0
        end
        return
      end
      if 2 == self.camp_distance_random_melee[3] and 3 ~= self.camp_distance_random[4] then
        self.camp_distance_random[2] = self.now_time + math.random(5, 15) * 0.1
        self.camp_distance_random_melee[3] = 0
        self.camp_distance_random[4] = self.camp_distance_random[4] + 1
        switch_move_type(self.npc, 1)
        moveto_npc(self.npc, self.target)
        return
      end
      if get_npc_time(self.npc) >= self.camp_distance_random[2] then
        self.camp_distance_random[1] = math.random(0, 100) * 0.1
        if self.camp_distance_random[1] >= 0 and self.camp_distance_random[1] < 3 then
          switch_move_type(self.npc, 2)
          moveto_npc(self.npc, self.target)
          self.camp_distance_random_melee[3] = self.camp_distance_random_melee[3] + 1
        elseif self.camp_distance_random[1] < 6.5 then
          switch_move_type(self.npc, 3)
          moveto_npc(self.npc, self.target)
        elseif self.camp_distance_random[1] <= 10 then
          switch_move_type(self.npc, 4)
          moveto_npc(self.npc, self.target)
        end
        abort_magic_by_id(self.npc, 20109991)
        self.camp_distance_random[2] = self.now_time + 0.7 + math.random(0, 10) * 0.1
        self.camp_distance_random[4] = self.camp_distance_random[4] + 1
      end
    end
  elseif -180 < self.camp_angle_switch and self.camp_angle_switch < -90 then
    if get_npc_time(self.npc) >= self.camp_distance_random[2] then
      self.camp_distance_random[2] = self.now_time + 0.25
      abort_magic_by_id(self.npc, 20109991)
      switch_move_type(self.npc, 3)
      moveto_npc(self.npc, self.target)
    end
  elseif self.camp_angle_switch > 90 and self.camp_angle_switch <= 180 and get_npc_time(self.npc) >= self.camp_distance_random[2] then
    self.camp_distance_random[2] = self.now_time + 0.25
    abort_magic_by_id(self.npc, 20109991)
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
  end
end

function M:attack_wander_random2()
  if self.now_time >= self.camp_distance_random[2] then
    self.camp_distance_random[1] = math.random(0, 6)
    if self.camp_distance_random[1] < 1 then
      switch_move_type(self.npc, 4)
      moveto_npc(self.npc, self.target)
    elseif self.camp_distance_random[1] <= 2 then
      switch_move_type(self.npc, 3)
      moveto_npc(self.npc, self.target)
    elseif self.camp_distance_random[1] <= 6 then
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
    end
    abort_magic_by_id(self.npc, 20109991)
    self.camp_distance_random[2] = self.now_time + 0.5 + math.random(0, 10) * 0.1
    self.camp_distance_random[4] = self.camp_distance_random[4] + 1
  end
  if 2 == self.camp_distance_random[4] or 4 == self.camp_distance_random[4] or self.camp_distance_random[4] >= 6 then
    local random_nums = math.random(1, 5)
    if random_nums >= 4 then
      self.camp_distance_random[2] = self.now_time + 3 + math.random(1, 5) * 0.3
      self.camp_distance_random[4] = 0
    else
      self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    end
  end
  abort_magic_by_id(self.npc, 20109991)
end

function M:attack_wander_random3()
  self.camp_angle_switch = get_target_angel(self.target, self.npc, true)
  if -135 <= self.camp_angle_switch and self.camp_angle_switch <= 135 then
    if self.now_time >= self.camp_distance_random[2] then
      self.camp_distance_random[1] = math.random(0, 6)
      if self.camp_distance_random[1] <= 0 then
        switch_move_type(self.npc, 1)
        moveto_npc(self.npc, self.target)
      elseif self.camp_distance_random[1] <= 2 then
        switch_move_type(self.npc, 1)
        moveto_npc(self.npc, self.target)
      elseif self.camp_distance_random[1] <= 4 then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      elseif self.camp_distance_random[1] <= 6 then
        switch_move_type(self.npc, 4)
        moveto_npc(self.npc, self.target)
      end
      self.camp_distance_random[2] = self.now_time + 1.5 + math.random(0, 10) * 0.1
      self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    end
  elseif -180 < self.camp_angle_switch and self.camp_angle_switch < -135 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
    self.camp_distance_random[2] = self.now_time + 1
  elseif 135 < self.camp_angle_switch and self.camp_angle_switch <= 180 then
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
    self.camp_distance_random[2] = self.now_time + 1
  end
  if 3 == self.camp_distance_random[4] or 5 == self.camp_distance_random[4] or self.camp_distance_random[4] >= 7 then
    local random_nums = math.random(1, 5)
    if random_nums >= 5 then
      self.camp_distance_random[2] = self.now_time + 1 + math.random(1, 5) * 0.1
      self.camp_distance_random[4] = 0
    else
      self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    end
  end
  abort_magic_by_id(self.npc, 20109991)
end

function M:attack_wander_random4()
  self.camp_angle_switch = get_target_angel(self.target, self.npc, true)
  if 3 == self.camp_distance_random[4] or 5 == self.camp_distance_random[4] or self.camp_distance_random[4] >= 7 then
    local random_nums = math.random(1, 5)
    if random_nums >= 5 then
      self.camp_distance_random[2] = self.now_time + 1 + math.random(1, 10) * 0.1
      self.camp_distance_random[4] = 0
      stop_move(self.npc)
      lookat_npc(self.npc, self.target, 0)
      return
    else
      self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    end
  end
  if 2 == self.camp_distance_random_melee[3] and 3 ~= self.camp_distance_random[4] then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.camp_distance_random[2] = self.now_time + math.random(0, 10) * 0.1
    self.camp_distance_random_melee[3] = 0
    self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    return
  end
  if self.camp_angle_switch >= 120 or self.camp_angle_switch <= -120 then
    if self.now_time >= self.camp_distance_random[2] then
      self.camp_distance_random[1] = math.random(0, 5)
      if self.camp_distance_random[1] <= 1 then
        switch_move_type(self.npc, 2)
        moveto_npc(self.npc, self.target)
        self.camp_distance_random_melee[3] = self.camp_distance_random_melee[3] + 1
      elseif self.camp_distance_random[1] <= 3 then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      elseif self.camp_distance_random[1] <= 5 then
        switch_move_type(self.npc, 4)
        moveto_npc(self.npc, self.target)
      end
      self.camp_distance_random[2] = self.now_time + 1.5 + math.random(0, 10) * 0.1
      self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    end
  elseif self.camp_angle_switch > 0 and self.camp_angle_switch < 120 then
    if get_npc_time(self.npc) >= self.camp_distance_random[2] then
      self.camp_distance_random[2] = self.now_time + 0.25
      switch_move_type(self.npc, 3)
      moveto_npc(self.npc, self.target)
      self.camp_distance_random[2] = self.now_time
    end
  elseif self.camp_angle_switch > -120 and self.camp_angle_switch <= 0 and get_npc_time(self.npc) >= self.camp_distance_random[2] then
    self.camp_distance_random[2] = self.now_time + 0.25
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
    self.camp_distance_random[2] = self.now_time
  end
  abort_magic_by_id(self.npc, 20109991)
end

function M:camp_check_distance(type)
  if not self.target then
    return
  end
  if check_npc_distance(self.npc, self.target, self.camp_distance[type][1], true) then
    self.camp_distance_switch = 1
  end
  if not check_npc_distance(self.npc, self.target, self.camp_distance[type][1], true) and check_npc_distance(self.npc, self.target, self.camp_distance[type][2], true) then
    self.camp_distance_switch = 2
  end
  if not check_npc_distance(self.npc, self.target, self.camp_distance[type][2], true) then
    self.camp_distance_switch = 3
  end
end

function M:attack_wander_logic(skill01, skill02)
  self.now_time = get_npc_time(self.npc)
  if not self.target then
    if 0 == self.relaxation_switch then
      self.relaxation_switch = 1
      self.relaxation_time = self.now_time
    end
    if self.now_time - self.relaxation_time > 1 then
      stop_move(self.npc)
    end
    return
  else
    self.relaxation_switch = 0
  end
  if check_npc_status(self.npc, 2) then
    stop_move(self.npc)
    abort_skill(self.npc)
    self.skill_set = 0
    return
  end
  if self.game_time <= 2 then
    self.game_time = get_npc_time(self.target)
    stop_move(self.npc)
    return
  end
  if self.now_time <= 2 then
    stop_move(self.npc)
    return
  end
  if 0 ~= self.control then
    return
  end
  if not self.monster_scene_state then
    return
  end
  if self.camp > 5 then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 1 == self.camp then
    M.camp_check_distance(self, "近攻")
    if 1 == self.skill_set and self.now_time >= skill01[3] then
    elseif 2 == self.skill_set and self.now_time >= skill02[3] then
    elseif 1 == self.camp_distance_switch then
      abort_magic_by_id(self.npc, 20109991)
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
    elseif 3 == self.camp_distance_switch then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
    elseif 2 == self.camp_distance_switch then
      M.attack_wander_random(self)
    end
  end
  if 2 == self.camp then
    M.camp_check_distance(self, "远攻")
    if 1 == self.skill_set and self.now_time >= skill01[3] then
    elseif 2 == self.skill_set and self.now_time >= skill02[3] then
    elseif 1 == self.camp_distance_switch then
      abort_magic_by_id(self.npc, 20109991)
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
    elseif 3 == self.camp_distance_switch then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
    elseif 2 == self.camp_distance_switch then
      M.attack_wander_random2(self)
    end
  end
  if 3 == self.camp then
    self.skill_set = 0
    M.camp_check_distance(self, "围观")
    if 1 == self.camp_distance_switch then
      abort_magic_by_id(self.npc, 20109991)
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
    elseif 3 == self.camp_distance_switch then
      switch_move_type(self.npc, 1)
      if not check_npc_status(self.npc, 9) then
        moveto_npc(self.npc, self.target)
      end
    elseif 2 == self.camp_distance_switch then
      M.attack_wander_random3(self)
    end
  end
  if 4 == self.camp then
    M.camp_check_distance(self, "机会")
    if 1 == self.skill_set and self.now_time >= skill01[3] then
    elseif 2 == self.skill_set and self.now_time >= skill02[3] then
    elseif 1 == self.camp_distance_switch then
      abort_magic_by_id(self.npc, 20109991)
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
    elseif 3 == self.camp_distance_switch then
      switch_move_type(self.npc, 1)
    elseif 2 == self.camp_distance_switch then
      M.attack_wander_random4(self)
    end
  end
  if 5 == self.camp then
    self.skill_set = 0
    M.camp_check_distance(self, "围观")
    if 1 == self.camp_distance_switch then
      abort_magic_by_id(self.npc, 20109991)
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
    elseif 3 == self.camp_distance_switch then
      if 1 == self.monster_type then
        switch_move_type(self.npc, 1)
        moveto_npc(self.npc, self.target)
      else
        M.attack_wander_random2(self)
      end
    elseif 2 == self.camp_distance_switch then
      M.attack_wander_random2(self)
    end
  end
end

function M:elite_monster_magic()
  if self.camp then
    return
  end
  if check_magic(self.npc, 201045701) then
    self.skill01[2] = 5
    self.skill02[2] = 5
    camp_time[1] = os.time() + 30
    self.camp = 1
  end
end

function M:elit_monster_magic_do(magic_id, type, elit_id)
  if 1 == type then
    for k, v in pairs(search_npc(self.npc, 2, 300, nil, 1, true)) do
      cast_magic(self.npc, v, magic_id, 1)
    end
  elseif 11 == type then
    for k, v in pairs(camp_weights["近攻"]) do
      if 1 == k then
        local now_time = os.time() + 1.5
        cast_magic(self.npc, v[2], magic_id, 1)
        cast_missile(self.npc, v[2], nil, nil, 2010440303, 1, nil, nil, nil, nil)
      end
    end
  end
end

function M:attack_elit_1(skill01, skill02)
  if 10 == self.camp then
  else
    return
  end
  M.camp_check_distance(self, "远攻")
  if 1 == self.skill_set and self.now_time >= self.skill01[3] then
  elseif 2 == self.skill_set and self.now_time >= self.skill02[3] then
  elseif 1 == self.camp_distance_switch then
    abort_magic_by_id(self.npc, 20109991)
    switch_move_type(self.npc, 2)
    moveto_npc(self.npc, self.target)
  elseif 3 == self.camp_distance_switch then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  elseif 2 == self.camp_distance_switch then
    M.attack_wander_random2(self)
  end
end

function M:skill_change_logic()
  self.now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if self.game_time <= 2 then
    self.game_time = get_npc_time(self.target)
    stop_move(self.npc)
    return
  end
  if self.now_time <= 2 then
    stop_move(self.npc)
    return
  end
  if 0 ~= self.control then
    return
  end
  if not self.monster_scene_state then
    return
  end
  if check_npc_status(self.npc, 2) then
    self.skill_set = 0
    return
  end
  if 3 == self.camp or 5 == self.camp then
    return
  end
  if 0 == self.skill_set and 0 == self.control and self.now_time >= self.skill_set_time and self.monster_scene_state then
    self.skill_set_random = math.random() + math.random(10, 20)
    self.skill_set = nil
    if self.skill_set_random >= 14 then
      self.skill_set = 1
    else
      self.skill_set = 2
    end
  end
end

function M:random_wandering(daze_time)
  if 0 ~= self.is_wander then
    return
  end
  local Temp_pos = {}
  local to_pos
  local rolling = math.random(1, 80)
  Temp_pos.x = self.pos.x + 1
  Temp_pos.z = self.pos.z + 1
  local p1 = get_position_offset_position(self.pos, Temp_pos, 300, 1)
  local p2 = get_position_offset_position(self.pos, Temp_pos, 60, 1)
  local p3 = get_position_offset_position(self.pos, Temp_pos, 200, 1)
  local p4 = get_position_offset_position(self.pos, Temp_pos, 120, 1)
  if rolling <= 20 then
    to_pos = p1
  elseif rolling > 20 and rolling <= 40 then
    to_pos = p2
  elseif rolling > 40 and rolling <= 60 then
    to_pos = p3
  else
    to_pos = p4
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1
    return
  end
  if check_npc_status(self.npc, 0) and 1 == self.random_type then
    self.random_type = 2
    self.random_wander_time = get_npc_time(self.npc) + daze_time
  elseif check_npc_status(self.npc, 0) and 2 == self.random_type and get_npc_time(self.npc) > self.random_wander_time then
    self.random_type = 0
  end
  if 0 == self.random_type then
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, to_pos)
    lookat_position(self.npc, to_pos.x, to_pos.z, false)
    self.random_type = 1
  end
end

function M:born_animation(skill_id)
  if not self.born_tag then
    if skill_id then
      cast_skill(self.npc, nil, skill_id, nil, nil)
    end
    self.born_tag = true
  end
end

function M:search_target(maxdis, searchdis)
  local npc_time_now = get_npc_time(self.npc)
  if self.target and check_npc_die(self.target) or not self.target then
    if not self.npc then
      return
    end
    local target_list = {}
    target_list = search_npc(self.npc, 4, maxdis, nil, false, true)
    local target
    local is_have_target = false
    if target_list and target_list[1] then
      for _, v in pairs(target_list) do
        if v and not check_magic(v, Const.LOCK_MASK) then
          target = v
          self.target = v
          set_npc_target(self.npc, self.target)
          self.is_wander = nil
          is_have_target = true
          break
        end
      end
    end
    if not is_have_target then
      self.target = nil
      if self.is_wander == nil then
        self.pos = get_npc_pos(self.npc)
        self.is_wander = 0
      end
    end
  elseif not check_npc_distance(self.npc, self.target, searchdis, true) then
    if not self.npc then
      return
    end
    local target_list = {}
    target_list = search_npc(self.npc, 4, maxdis, nil, false, true)
    if target_list and target_list[1] then
      for _, v in pairs(target_list) do
        if v and not check_magic(v, Const.LOCK_MASK) and v ~= self.target then
          self.target = v
          set_npc_target(self.npc, self.target)
          self.is_wander = nil
        end
      end
    end
  end
end

function M:remove_timer()
  if self.dead_fx_timer and get_time() > self.dead_fx_timer then
    if self.npc.id == 201049 then
      create_scene_effect("Fx_H101008_skill1_counter_1", self.npc:get_pos_vec3(), 0)
    else
      cast_magic(self.npc, self.npc, Const.DEAD_MELT_OUT, 0)
    end
    self.dead_fx_timer = nil
  end
  if self.remove_switch and get_time() > self.remove_timer then
    remove_npc(self.npc)
  end
end

function M:Break()
  if not self.stun then
    return
  end
  stop_move(self.npc)
  if get_npc_time(self.npc) > self.camera_time then
    change_follow_target(0)
  end
  local now_time = get_npc_time(self.npc)
  if 2 == self.stun_type then
    if now_time > self.break_time and is_really_enter_stun(self.npc) then
      self.stun = true
      cast_magic(self.npc, self.npc, 201063020, 1)
    end
  elseif 1 == self.stun_type and now_time > self.break_time and check_npc_status(self.npc, 14) then
    self.stun = true
    cast_magic(self.npc, self.npc, 201063020, 1)
  end
  if stun_is_end(self.npc) then
    self.stun_type = 0
    self.stun = false
  end
end

function M:Hit_wall()
  if not self.target then
    return
  end
  if not self.npc then
    return
  end
  if check_npc_distance(self.npc, self.target, 1.5, true) then
    self.control = 0
    self.hit_wall_timer = get_npc_time(self.npc) + 1.5
    return
  end
  if get_npc_distance(self.npc, 3, 1, false) <= 0.5 or get_npc_distance(self.npc, 3, 3, false) <= 0.5 then
    self.hitwall = true
    self.control = 99
  end
  if 0 == get_npc_distance(self.npc, 3, 3) or 0 == get_npc_distance(self.npc, 3, 1) then
    return
  end
  if 99 ~= self.control then
    return
  end
  if not is_path_possible(self.npc, self.target) then
    return
  end
  if check_npc_status(self.npc, 2) then
    stop_move(self.npc)
    self.hit_wall_timer = get_npc_time(self.npc) + 1
    self.hitwall = true
    return
  end
  if self.hitwall and get_npc_time(self.npc) >= self.hit_wall_timer then
    self.hitwall_pos = get_npc_offset_position(self.npc, get_npc_pos(self.target), 30, 5)
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.hitwall_pos)
    self.hit_wall_timer = get_npc_time(self.npc) + 0.5
    self.hitwall = false
  end
  if 3 == check_navigate(self.npc) then
    self.control = 0
    return
  end
  if not self.hitwall and (self.hitwall_pos.x or self.hitwall_pos.z) and check_npc_distance_to_pos(self.npc, self.hitwall_pos.x, self.hitwall_pos.z, 1, true) then
    self.control = 0
    self.hit_wall_timer = get_npc_time(self.npc) + 0.5
  end
end

function M:platform_move()
  if not self.target then
    return
  end
  local path_possible = is_path_possible(self.npc, self.target)
  if path_possible and 10 == self.control then
    self.control = 0
  elseif not path_possible then
    self.control = 10
    stop_move(self.npc)
  end
end

function M:check_wall_dis()
  if not self.target then
    return
  end
end

function M:block_hit_stun()
  local now_time = get_npc_time(self.npc)
  if check_magic(self.npc, 1999101) then
    self.block = 1
    abort_magic_by_id(self.npc, 1999101, 1)
  end
  if 1 == self.block and now_time >= self.block_time then
    abort_skill(self.npc)
    enter_stun(self.npc, false)
    self.block = 0
    self.block_time = now_time + 2
    self.block_hit = now_time + self.block_hit1
  end
  if not (now_time >= self.block_hit) or is_really_enter_stun(self.npc) then
  end
  if check_magic(self.npc, 1999102) then
    self.block = 2
    abort_magic_by_id(self.npc, 1999102, 1)
  end
  if 2 == self.block and now_time >= self.block_time then
    abort_skill(self.npc)
    enter_stun(self.npc, false)
    self.block = 0
    self.block_time = now_time + 4
    self.block_hit = now_time + self.block_hit2
  end
  if not (now_time >= self.block_hit) or is_really_enter_stun(self.npc) then
  end
end

return M
