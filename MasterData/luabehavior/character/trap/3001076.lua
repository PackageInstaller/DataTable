local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  self.point_count = math.floor(get_sync_var("point_count"))
  self.gap_time = math.max(7.5, get_sync_var("gap_time"))
  self.increase_time = get_sync_var("increase_time")
  self.max_target_num = get_sync_var("max_target_num")
  self.max_time = get_sync_var("max_time")
  self.control = 1
  self.start_target_num = get_sync_var("start_target_num")
  self.current_target_num = self.start_target_num
  self.random_list = {}
  self.over = false
  self.start_time = get_npc_time(npc)
  self.last_increase = get_npc_time(npc)
  self.last_refresh = get_npc_time(npc)
  self.target_id = 3001075
  if get_sync_var("trap_type") and get_sync_var("trap_type") == "reborn" then
    self.target_id = 3001069
  end
  self.normal_level = 1
  self.group_id = get_npc_group_id(npc)
  self.trap_list = {}
  self:create_init_trap(self.start_target_num)
  self.random_counter = 1
end

function M:create_init_trap(target_num)
  local random_list = {}
  local first_pos = {}
  if get_cur_room_id() == 1071101 then
    first_pos = {14, 15}
  else
    for l = 1, self.start_target_num do
      table.insert(first_pos, l)
    end
  end
  math.randomseed(tostring(os.time()):reverse():sub(1, 7))
  for i = 1, target_num do
    local same = true
    local p
    while same do
      same = false
      p = first_pos[math.random(#first_pos)]
      for j = 1, i - 1 do
        if p == random_list[j] then
          same = true
          break
        end
      end
    end
    table.insert(random_list, p)
  end
  for k = 1, #random_list do
    local m = add_npc_by_pos_key(2, self.target_id, "T" .. tostring(random_list[k]), math.random(-2, 2) * math.random(), math.random(-2, 2) * math.random(), "T" .. tostring(random_list[k]), math.random(-2, 2) * math.random(), math.random(-2, 2) * math.random(), 2, self.normal_level)
    table.insert(self.trap_list, m)
  end
end

function M:on_frame()
  if self.over then
    return
  end
  self:end_check()
  self:skill_main_logic()
end

function M:random_target_up(target_num)
  local random_list = {}
  for i = 1, target_num do
    local same = true
    local p
    while same do
      same = false
      math.randomseed(tostring(os.time() * self.random_counter):reverse():sub(1, 7))
      self.random_counter = self.random_counter + 1
      p = math.random(self.point_count)
      for j = 1, i - 1 do
        if p == random_list[j] then
          same = true
          break
        end
      end
    end
    table.insert(random_list, p)
  end
  return random_list
end

function M:end_check()
  if get_npc_time(self.npc) >= self.start_time + self.max_time then
    self.control = -1
    self.over = true
    for i = 1, #self.trap_list do
      remove_npc(self.trap_list[i])
    end
    self.trap_list = {}
  end
end

function M:skill_main_logic()
  if self.over then
    return
  end
  if get_npc_time(self.npc) >= self.last_refresh + self.gap_time then
    self.last_refresh = get_npc_time(self.npc)
    self.random_list = self:random_target_up(self.current_target_num)
    for i = 1, #self.random_list do
      local m = add_npc_by_pos_key(2, self.target_id, "T" .. tostring(self.random_list[i]), math.random(-2, 2) * math.random(), math.random(-2, 2) * math.random(), "T" .. tostring(self.random_list[i]), math.random(-2, 2) * math.random(), math.random(-2, 2) * math.random(), 2, self.normal_level)
      table.insert(self.trap_list, m)
    end
  end
  if get_npc_time(self.npc) >= self.last_increase + self.increase_time then
    self.last_increase = get_npc_time(self.npc)
    if self.current_target_num < self.max_target_num then
      self.current_target_num = self.current_target_num + 1
    end
  end
end

function M:on_npc_removed(npc)
  if npc == self.npc then
    for i = 1, #self.trap_list do
      remove_npc(self.trap_list[i])
    end
  end
end

function M:on_room_pass(room_id)
  self.over = true
end

return M
