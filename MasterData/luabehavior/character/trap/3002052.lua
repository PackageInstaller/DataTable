local monster = Util.create_class()

function monster:_init(npc)
  monster.npc = npc
  set_npc_status(npc, 3, true)
  set_npc_status(npc, 4, true)
  cast_magic(npc, npc, 1080420101, 1)
  monster.search = {}
  enable_shadow(npc, false)
  monster.create_gap_time = get_sync_var("create_gap_time")
  monster.point_gap_time = get_sync_var("point_gap_time")
  monster.start_enemy_amout = get_sync_var("start_enemy_amout")
  monster.max_enemy_amount = get_sync_var("max_enemy_amount")
  monster.end_time = get_sync_var("end_time")
  monster.born_point_amount = 13
  monster.born_points = {}
  monster.born_points_used = {}
  monster.last_create_time = 0
  monster.init_over = false
  monster.enemyOnScene = {}
  monster.enemy_id_group = {
    [1] = {
      id = 3002053,
      weight = get_sync_var("weight_bird"),
      max_amount = get_sync_var("amount_bird"),
      current_amount = 0
    },
    [2] = {
      id = 3002054,
      weight = get_sync_var("weight_mosquito"),
      max_amount = get_sync_var("amount_mosquito"),
      current_amount = 0
    }
  }
  monster.enemy_id_group_forbi = {}
  for i = 1, monster.born_point_amount do
    local born_point = {
      pos = "M" .. i,
      last_used_time = 0
    }
    table.insert(monster.born_points, born_point)
  end
  for i = 1, monster.start_enemy_amout do
    monster:initEnemy()
  end
  monster.init_over = true
  monster.start_time = get_npc_time(npc)
end

function monster:set_birth()
  local playerPos = get_npc_pos(get_come_on_hero())
  local centrePos = {
    x = 0,
    y = playerPos.y,
    z = 336.5
  }
  monster.birthPos = {
    x = 0,
    y = 0,
    z = 336.5
  }
  monster.birthDir = {
    x = 0,
    y = 0,
    z = 336.5
  }
  local angleElapse = 0
  local rangeElapse = 5
  local pnValue
  local tempPos = {
    x = 0,
    y = playerPos.y,
    z = 336.5
  }
  math.randomseed(os.time())
  repeat
    if math.random() * 2 - 0.5 > 0 then
      pnValue = 1
    else
      pnValue = -1
    end
    angleElapse = math.random(0, 61) * math.random(0, 4) * pnValue
    rangeElapse = 5 + math.random() * 3
    tempPos = get_npc_offset_position(get_come_on_hero(), centrePos, angleElapse, rangeElapse)
  until tempPos.x * tempPos.x + (tempPos.z - 336.5) ^ 2 <= 342.25
  monster.birthPos.x = tempPos.x
  monster.birthPos.y = playerPos.y
  monster.birthPos.z = tempPos.z
  monster.birthDir.x = math.random(-185, 185) / 10
  monster.birthDir.y = 0
  monster.birthDir.z = math.random(318, 355)
end

function monster:initEnemy()
  for key, value in pairs(monster.enemy_id_group_forbi) do
    if monster.enemy_id_group_forbi[key].current_amount < monster.enemy_id_group_forbi[key].max_amount then
      table.insert(monster.enemy_id_group, monster.enemy_id_group_forbi[key])
      table.remove(monster.enemy_id_group_forbi, key)
    end
  end
  local total_weight = 0
  for i = 1, #monster.enemy_id_group do
    total_weight = total_weight + monster.enemy_id_group[i].weight
  end
  local weight_index = 0
  local enemy_index = 1
  local enemy_id = 3002047
  local random_enemy_index = math.random(total_weight)
  while weight_index < random_enemy_index do
    weight_index = weight_index + monster.enemy_id_group[enemy_index].weight
    enemy_id = monster.enemy_id_group[enemy_index].id
    enemy_index = enemy_index + 1
  end
  local randomPos = math.random(#monster.born_points)
  local enemy = add_npc_by_pos_key(2, enemy_id, monster.born_points[randomPos].pos, 0, 0, monster.born_points[randomPos].pos, 0, 0, 2, 1)
  for i = 1, #monster.enemy_id_group do
    if enemy_id == monster.enemy_id_group[i].id then
      monster.enemy_id_group[i].current_amount = monster.enemy_id_group[i].current_amount + 1
      if monster.enemy_id_group[i].current_amount >= monster.enemy_id_group[i].max_amount then
        table.insert(monster.enemy_id_group_forbi, monster.enemy_id_group[i])
        table.remove(monster.enemy_id_group, i)
      end
      break
    end
  end
  table.insert(monster.enemyOnScene, enemy)
  monster.born_points[randomPos].last_used_time = get_npc_time(monster.npc)
  table.insert(monster.born_points_used, monster.born_points[randomPos])
  table.remove(monster.born_points, randomPos)
end

function monster:create_enemy()
  for key in pairs(monster.enemy_id_group_forbi) do
    if monster.enemy_id_group_forbi[key].current_amount < monster.enemy_id_group_forbi[key].max_amount then
      table.insert(monster.enemy_id_group, monster.enemy_id_group_forbi[key])
      table.remove(monster.enemy_id_group_forbi, key)
    end
  end
  local total_weight = 0
  for i = 1, #monster.enemy_id_group do
    total_weight = total_weight + monster.enemy_id_group[i].weight
  end
  local random_enemy_index = math.random(total_weight)
  local weight_index = 0
  local enemy_index = 1
  local enemy_id = 3002053
  while random_enemy_index > weight_index do
    weight_index = weight_index + monster.enemy_id_group[enemy_index].weight
    enemy_id = monster.enemy_id_group[enemy_index].id
    enemy_index = enemy_index + 1
  end
  monster:set_birth()
  local enemy = add_npc(2, enemy_id, monster.birthPos, monster.birthDir, 2, 1)
  for i = 1, #monster.enemy_id_group do
    if enemy_id == monster.enemy_id_group[i].id then
      monster.enemy_id_group[i].current_amount = monster.enemy_id_group[i].current_amount + 1
      if monster.enemy_id_group[i].current_amount >= monster.enemy_id_group[i].max_amount then
        table.insert(monster.enemy_id_group_forbi, monster.enemy_id_group[i])
        table.remove(monster.enemy_id_group, i)
      end
      break
    end
  end
  table.insert(monster.enemyOnScene, enemy)
end

function monster:on_frame()
  if monster.init_over == false then
    return
  end
  local current_time = get_npc_time(monster.npc)
  if current_time > monster.start_time + monster.end_time + 1 then
    for i = #monster.enemyOnScene, 1, -1 do
      create_scene_effect("Fx_Common_Death", monster.enemyOnScene[i]:get_pos_vec3(), 0)
      remove_npc(monster.enemyOnScene[i])
    end
    monster.init_over = false
    return
  end
  if #monster.enemyOnScene >= monster.max_enemy_amount then
    return
  end
  if current_time < monster.last_create_time + monster.create_gap_time then
    return
  end
  if monster.born_points_used ~= nil then
    for i = #monster.born_points_used, 1, -1 do
      if current_time > monster.born_points_used[i].last_used_time + monster.point_gap_time then
        table.insert(monster.born_points, monster.born_points_used[i])
        table.remove(monster.born_points_used, i)
      end
    end
  end
  monster:create_enemy()
  monster.last_create_time = current_time
end

function monster:on_npc_removed(npc)
  for i = 1, #monster.enemyOnScene do
    if npc == monster.enemyOnScene[i] then
      table.remove(monster.enemyOnScene, i)
      break
    end
  end
  for i = 1, #monster.enemy_id_group do
    if npc.id == monster.enemy_id_group[i].id then
      monster.enemy_id_group[i].current_amount = monster.enemy_id_group[i].current_amount - 1
      break
    end
  end
  for i = 1, #monster.enemy_id_group_forbi do
    if npc.id == monster.enemy_id_group_forbi[i].id then
      monster.enemy_id_group_forbi[i].current_amount = monster.enemy_id_group_forbi[i].current_amount - 1
      break
    end
  end
end

return monster
