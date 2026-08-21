local monster = Util.create_class()

function monster:_init(npc)
  self.npc = npc
  self.create_gap_time = get_sync_var("create_gap_time")
  self.point_gap_time = get_sync_var("point_gap_time")
  self.start_enemy_amout = get_sync_var("start_enemy_amout")
  self.max_enemy_amount = get_sync_var("max_enemy_amount")
  self.end_time = get_sync_var("end_time")
  self.born_point_amount = get_sync_var("born_point_amount")
  self.born_points = {}
  self.born_points_used = {}
  self.last_create_time = 0
  self.init_over = false
  self.enemy_list = {}
  self.enemy_id_group = {
    [1] = {
      id = get_sync_var("id_monster1"),
      weight = get_sync_var("weight_monster1"),
      max_amount = get_sync_var("amount_monster1"),
      current_amount = 0
    },
    [2] = {
      id = get_sync_var("id_monster2"),
      weight = get_sync_var("weight_monster2"),
      max_amount = get_sync_var("amount_monster2"),
      current_amount = 0
    }
  }
  self.enemy_id_group_forbi = {}
  for i = 1, self.born_point_amount do
    local born_point = {
      pos = "M" .. i,
      last_used_time = 0
    }
    table.insert(self.born_points, born_point)
  end
  for i = 1, self.start_enemy_amout do
    self:create_enemy()
  end
  self.init_over = true
  self.start_time = get_npc_time(npc)
end

function monster:create_enemy()
  math.randomseed(os.time())
  for key, value in pairs(self.enemy_id_group_forbi) do
    if self.enemy_id_group_forbi[key].current_amount < self.enemy_id_group_forbi[key].max_amount then
      table.insert(self.enemy_id_group, self.enemy_id_group_forbi[key])
      table.remove(self.enemy_id_group_forbi, key)
    end
  end
  local total_weight = 0
  for i = 1, #self.enemy_id_group do
    total_weight = total_weight + self.enemy_id_group[i].weight
  end
  local weight_index = 0
  local enemy_index = 1
  local enemy_id = get_sync_var("weight_monster1")
  local random_enemy_index = math.random(total_weight)
  while weight_index < random_enemy_index do
    print("weight_index", weight_index)
    print("self.enemy_id_group[enemy_index]", self.enemy_id_group[enemy_index])
    print("self.enemy_id_group[enemy_index].weight", self.enemy_id_group[enemy_index].weight)
    weight_index = weight_index + self.enemy_id_group[enemy_index].weight
    enemy_id = self.enemy_id_group[enemy_index].id
    enemy_index = enemy_index + 1
  end
  local randomPos = math.random(#self.born_points)
  local randomTar = math.random(#self.born_points)
  local enemy = add_npc_by_pos_key(2, enemy_id, self.born_points[randomPos].pos, 0, 0, self.born_points[randomTar].pos, 0, 0, 2, 1)
  for i = 1, #self.enemy_id_group do
    if enemy_id == self.enemy_id_group[i].id then
      self.enemy_id_group[i].current_amount = self.enemy_id_group[i].current_amount + 1
      if self.enemy_id_group[i].current_amount >= self.enemy_id_group[i].max_amount then
        table.insert(self.enemy_id_group_forbi, self.enemy_id_group[i])
        table.remove(self.enemy_id_group, i)
      end
      break
    end
  end
  table.insert(self.enemy_list, enemy)
  self.born_points[randomPos].last_used_time = get_npc_time(self.npc)
  table.insert(self.born_points_used, self.born_points[randomPos])
  table.remove(self.born_points, randomPos)
end

function monster:on_frame()
  if self.init_over == false then
    return
  end
  local current_time = get_npc_time(self.npc)
  if current_time > self.start_time + self.end_time + 1 then
    for i = #self.enemy_list, 1, -1 do
      create_scene_effect("Fx_Common_Death", self.enemy_list[i]:get_pos_vec3(), 0)
      remove_npc(self.enemy_list[i])
    end
    self.init_over = false
    return
  end
  if #self.enemy_list >= self.max_enemy_amount then
    return
  end
  if current_time < self.last_create_time + self.create_gap_time then
    return
  end
  if self.born_points_used ~= nil then
    for i = #self.born_points_used, 1, -1 do
      if current_time > self.born_points_used[i].last_used_time + self.point_gap_time then
        table.insert(self.born_points, self.born_points_used[i])
        table.remove(self.born_points_used, i)
      end
    end
  end
  self:create_enemy()
  self.last_create_time = current_time
end

function monster:on_npc_removed(npc)
  for i = 1, #self.enemy_list do
    if npc == self.enemy_list[i] then
      table.remove(self.enemy_list, i)
      break
    end
  end
  for i = 1, #self.enemy_id_group do
    if npc.id == self.enemy_id_group[i].id then
      self.enemy_id_group[i].current_amount = self.enemy_id_group[i].current_amount - 1
      break
    end
  end
  for i = 1, #self.enemy_id_group_forbi do
    if npc.id == self.enemy_id_group_forbi[i].id then
      self.enemy_id_group_forbi[i].current_amount = self.enemy_id_group_forbi[i].current_amount - 1
      break
    end
  end
end

return monster
