local M = Util.create_class()

function M:_init()
end

function M:check_condition(condition_id, show_tips)
  if not condition_id or 0 == condition_id then
    return true
  end
  local condition = ShareRes.create("battle.battle_condition", condition_id)
  assert(condition, "no such battle condition " .. condition_id)
  local func_name
  if 1 == condition.Is_Client then
    local client_type = ShareRes.create("battle.client_battle_condition_type", condition.Type)
    func_name = client_type.Name
  else
    local condition_type = ShareRes.create("battle.battle_condition_type", condition.Type)
    func_name = condition_type.Name
  end
  assert(func_name, "no such condition type " .. condition.Type)
  local ret = M[func_name](condition.Param, condition.Value, condition_id)
  if not ret and show_tips then
    Util.show_message_tip(condition.Desc)
  end
  return ret
end

function M.cond_tower_get_item_cnt(params, value)
  local tower_id = params[1]
  if tower_id > 0 and not M._get_in_tower(tower_id) then
    return false
  end
  local item_id = params[2]
  local target_num = value
  return target_num <= FightBagMgr:get_item_num_by_id(item_id)
end

function M._get_in_tower(tower_id)
  if not TowerMgr then
    return false
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return false
  end
  return tower:get_tower_id() == tower_id
end

function M.cond_has_used_skill_book(params, value)
  local tower_id = params[1]
  if tower_id > 0 and not M._get_in_tower(tower_id) then
    return false
  end
  return BattleSkillBookMgr:get_has_used_book()
end

function M.cond_has_get_treasure(params, value)
  local tower_id = params[1]
  if tower_id > 0 and not M._get_in_tower(tower_id) then
    return false
  end
  return BattleTreasureBoxMgr:get_has_use_treasure()
end

function M.cond_has_pass_room(params, value)
  local tower_id = params[1]
  if not M._get_in_tower(tower_id) then
    return false
  end
  local tower = TowerMgr:get_tower()
  for i = 2, 3 do
    if params[i] > 0 and tower:is_pass_room(params[i]) then
      return true
    end
  end
  return false
end

function M.cond_has_in_room(params, value)
  local tower_id = params[1]
  if not M._get_in_tower(tower_id) then
    return false
  end
  local room_id = params[2]
  local tower = TowerMgr:get_tower()
  return tower:get_room_num() == room_id
end

function M.cond_has_in_tower(params, value)
  local tower_id = params[1]
  return M._get_in_tower(tower_id)
end

function M.cond_open_pass_card(params, value)
  if params[1] > 0 and M.cond_has_in_tower(params, value) == false then
    return false
  end
  return ChallengeRingMgr:select_list_include_door_card()
end

function M.cond_get_ring_emblem(params, value)
  if params[1] > 0 and M.cond_has_in_tower(params, value) == false then
    return false
  end
  return ChallengeRingMgr:is_now_ring_reach_emblem_num(params[2], value)
end

function M.cond_open_card(params, value)
  if params[1] > 0 and M.cond_has_in_tower(params, value) == false then
    return false
  end
  return ChallengeRingMgr:select_list_include_card(params[2])
end

function M.cond_attr_match(params, value, condition_id)
  if not Global.hero then
    return false
  end
  local attr_value = Global.hero.attr_mgr:get_attr(params[1])
  if not attr_value then
    Log.Error("检查属性不存在, 属性ID:", params[1], "条件ID：", condition_id)
    return
  end
  return attr_value >= params[2]
end

function M.cond_cost_item(params, value)
  return FightBagMgr:get_item_num_by_id(params[1]) >= params[2]
end

return M
