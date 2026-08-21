local behaviorBase = import("common.base.behavior_base")
local monsterBase = Util.create_child_mt(behaviorBase)
local tool = import("common.monster_tool")
local roleTool = import("common.role_tool")
local skillBase = import("character.base.base_monster_skill")
local doAfterMgrBase = import("character.base.base_doAfterManager")
local treeBase = import("character.base.base_monster_stateTree")
local actMoveBase = import("character.base.base_monster_actionMove")
local DAMAGE_SKILL_TYPE = Const.DAMAGE_SKILL_TYPE
local MISSILE_TYPE_TAG = Config.MISSILE_TYPE_TAG
local Mathx = require("base.mathx")
monsterBase.roleBase = import("character.base.role_base")
monsterBase.debugSwitch = import("common.debug_config").monster
monsterBase.tool = tool
monsterBase.roleTool = roleTool
monsterBase.redSkill_counter_type = {
  [DAMAGE_SKILL_TYPE.ATTACK] = true,
  [DAMAGE_SKILL_TYPE.HEAVY] = true,
  [DAMAGE_SKILL_TYPE.STANDARD] = true,
  [DAMAGE_SKILL_TYPE.ENHANCE] = true,
  [DAMAGE_SKILL_TYPE.BRANCH] = true,
  [DAMAGE_SKILL_TYPE.CHARGE] = true
}
monsterBase.evade_config = {
  threshold = 100,
  decayRate = 10,
  armor_increase = Const.MONSTER_EVADE.ARMOR_INCREASE,
  red_flash = Const.MONSTER_EVADE.RED_FLASH,
  hero_back = Const.MONSTER_EVADE.HERO_BACK,
  monster_back = Const.MONSTER_EVADE.MONSTER_BACK,
  camera_pull = Const.MONSTER_EVADE.CAMERA_PULL,
  clear_slomo = Const.MONSTER_EVADE.CLEAR_SLOMO,
  slomo_hero = Const.MONSTER_EVADE.SLOMO_HERO,
  slomo_monster = Const.MONSTER_EVADE.SLOMO_MONSTER,
  camera_shake = Const.MONSTER_EVADE.CAMERA_SHAKE,
  input_protect_timer = Const.MONSTER_EVADE.INPUT_PROTECT_TIMER,
  hero_invul = Const.MONSTER_EVADE.HERO_INVUL
}
monsterBase.base_search_weight = {
  ignore_distance = false,
  be_hit = 1,
  weight = 0
}
monsterBase.xRayNpcList = {}

function monsterBase.insertFun(monster, funName, newFun)
  monster.tool.insert(monster, funName, newFun)
end

function monsterBase.removeFun(monster, funName, newFun)
  monster.tool.remove(monster, funName, newFun)
end

function monsterBase.has_clean_shot(monster)
  local monsterPos = monster.npc:get_pos_vec3()
  local targetPos = monster.target:get_pos_vec3()
  local dist = Mathx.distance(monsterPos.x, monsterPos.y, monsterPos.z, targetPos.x, targetPos.y, targetPos.z)
  local is_hit = Util.raycast2_block(monsterPos.x, monsterPos.y, monsterPos.z, targetPos.x - monsterPos.x, targetPos.y - monsterPos.y, targetPos.z - monsterPos.z, dist - monster.npc.radius - monster.target.radius - 0.2)
  return not is_hit
end

function monsterBase.enter_evade_slomo(monster, need_role_slomo)
  monster.is_evade_slomo = true
  local config = monster.evade_config
  local states = monster.states
  local groupCounter = states.groupCounter
  local monsterNpc = monster.npc
  local role = groupCounter.counter_role
  local roleNpc = role.npc
  if need_role_slomo then
    cast_magic(monsterNpc, roleNpc, config.clear_slomo)
    cast_magic(monsterNpc, roleNpc, config.camera_pull)
    cast_magic(monsterNpc, roleNpc, config.camera_shake)
  end
  cast_magic(monsterNpc, monsterNpc, config.input_protect_timer)
  role:enable_input_protect(true, Const.INPUT_PROTECT_TYPE.BLOCK_INPUT)
  cast_magic(monsterNpc, roleNpc, config.slomo_hero)
  cast_magic(monsterNpc, monsterNpc, config.slomo_monster)
  cast_magic(monsterNpc, roleNpc, config.hero_invul)
end

function monsterBase.quit_evade_slomo(monster)
  if not monster.is_evade_slomo then
    return
  end
  monster.is_evade_slomo = false
  local config = monster.evade_config
  local states = monster.states
  local groupCounter = states.groupCounter
  local monsterNpc = monster.npc
  local role = groupCounter.counter_role
  local roleNpc = role.npc
  abort_magic_by_id(monsterNpc, config.clear_slomo)
  abort_magic_by_id(roleNpc, config.clear_slomo)
  abort_magic_by_id(roleNpc, config.slomo_hero)
  abort_magic_by_id(monsterNpc, config.slomo_monster)
  abort_magic_by_id(monsterNpc, config.input_protect_timer)
  role:disable_input_protect()
  abort_magic_by_id(roleNpc, config.hero_invul)
  abort_magic_by_id(roleNpc, config.hero_back)
end

function monsterBase.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function monsterBase.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster:update_hate(caster)
  if missile then
    return monster:try_red_skill_counter(missile, nil, damage_sign)
  end
end

function monsterBase.update_hate(monster, caster)
  local monsterNpc = monster.npc
  local oldTarget = monster.target
  if not (caster and caster ~= oldTarget and caster ~= get_god_npc() and (not caster.magic_mgr or not check_magic(caster, Const.LOCK_MASK)) and caster:can_update()) or monsterNpc.uuid == caster.uuid or monsterNpc:get_camp() == caster:get_camp() or not caster:is_can_searched() then
    return
  end
  local new_info = monster:get_search_info(caster)
  if not new_info.ignore_distance then
    local new_tar_dist = get_npc_distance(monsterNpc, 1, caster, true)
    local old_tar_dist = get_npc_distance(monsterNpc, 1, oldTarget, true)
    local minDis = monster.search.minDis
    local maxDis = monster.search.maxDis
    if not minDis or not maxDis then
      return
    end
    if new_tar_dist > maxDis then
      return
    end
    if old_tar_dist < minDis and new_tar_dist > minDis then
      return
    end
  end
  if not oldTarget then
    monster:setTarget(caster)
    return
  end
  local old_info = monster:get_search_info(oldTarget)
  local old_weight = old_info.weight
  local new_weight = new_info.weight
  local offset = new_info.be_hit
  if caster:is_hero_or_player() and caster:check_in_ground() then
    offset = 0
  end
  if old_weight <= new_weight + offset then
    monster:setTarget(caster)
  end
end

function monsterBase.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster:update_evade_value(missile)
  monster:try_evade(missile)
end

function monsterBase.update_evade_value(monster, missile)
  if not missile then
    return
  end
  local states = monster.states
  local evade = states.evade
  local misCfg = missile.missile_cfg
  if misCfg.MissileTypeTag ~= MISSILE_TYPE_TAG.MELEE and misCfg.MissileTypeTag ~= MISSILE_TYPE_TAG.RANGE then
    return
  end
  if not evade then
    return
  end
  if not states.active:isRunning() and not states.stunGround:isRunning() then
    return
  end
  local hitType = missile.missile_cfg.Type
  local typeDiff
  if hitType <= 2 then
    typeDiff = 1
  elseif hitType <= 4 then
    typeDiff = 2
  else
    typeDiff = 3
  end
  local value = evade.value + math.random() * 15 + 5 * typeDiff
  local config = monster.evade_config
  evade.value = math.min(value, config.threshold)
end

function monsterBase.clear_evade_value(monster)
  local evade = monster.states.evade
  if not evade then
    return
  end
  evade.value = 0
end

function monsterBase.try_evade(monster, missile)
  local evade = monster.states.evade
  local counterAct = evade and evade:chooseChildAction()
  if not counterAct then
    return
  end
  evade.be_hit_missile = missile
  monster:transState(counterAct, true)
end

function monsterBase.on_self_magic_end(monster, target, magic_id)
end

function monsterBase.on_target_self_magic_end(monster, caster, magic_id)
  if magic_id == Const.LOCK_MASK then
    set_can_searched(monster.npc, true)
  end
  if magic_id == Const.RED_SKILL then
    monster.isRedSkill = false
  end
  if monster.is_evade_slomo and magic_id == monster.evade_config.input_protect_timer then
    local groupCounter = monster.states.groupCounter
    local role = groupCounter.counter_role
    role:disable_input_protect()
  end
end

function monsterBase.on_skill_begin(monster, npc, skill_id)
  if monster.is_evade_slomo then
    local groupCounter = monster.states.groupCounter
    local role = npc:get_behavior()
    local skill = role and role.skills and role.skills[skill_id]
    local skAct = skill and skill.skAct
    local castId = skAct and skAct.castId
    if role == groupCounter.counter_role and (skAct ~= groupCounter.counter_role_skAct or castId ~= groupCounter.counter_role_skAct_castId) then
      monster:quit_evade_slomo()
    end
  end
end

monsterBase.on_self_skill_begin = GAME_DEBUG and function(monster, skill_id)
  if monster.debugSwitch.curState then
    monster:logState()
  end
  local skill = monster.skills[skill_id]
  if skill then
    skill:onBegin()
  end
end or function(monster, skill_id)
  local skill = monster.skills[skill_id]
  if skill then
    skill:onBegin()
  end
end

function monsterBase.evade_shift_hero(monster, target)
  local basePos = get_npc_pos(monster.npc)
  local rolePos = target:get_pos_vec3()
  local mrVec = rolePos - basePos
  mrVec:SetNormalize()
  return basePos, mrVec
end

function monsterBase.evade_shift_monster(monster)
  local basePos = get_npc_pos(monster.npc)
  local dir = monster.npc:get_dir_vec():Clone()
  return basePos, -dir
end

function monsterBase.force_shift_magic_init(monster, magic_id, target)
  local evade_config = monster.evade_config
  if magic_id == evade_config.monster_back then
    return monster:evade_shift_monster()
  elseif magic_id == evade_config.hero_back then
    return monster:evade_shift_hero(target)
  end
end

function monsterBase.on_hero_enter_ground_state(monster, npc)
  if npc == monster.target and not monster.targetShowBack then
    monster.targetShowBack = true
  end
  if monster.is_evade_slomo and npc == monster.states.groupCounter.counter_role.npc then
    monster:quit_evade_slomo()
  end
end

function monsterBase.on_hero_showup_or_back(monster, npc, is_showup, by_ult_change)
  if not is_showup and npc == monster.target and not monster.targetShowBack then
    monster.targetShowBack = true
    monster.target = nil
    set_npc_target(monster.npc, nil)
  end
  if not is_showup and monster.is_evade_slomo and npc == monster.states.groupCounter.counter_role.npc then
    monster:quit_evade_slomo()
  end
  if is_showup and monster.targetShowBack then
    monster.targetShowBack = false
    monster.target = npc
    set_npc_target(monster.npc, npc)
  end
end

function monsterBase.isInSectorRing(monster, center, minRadius, maxRadius, dir, cos, angle, height)
  return monster.tool:isInSectorRing(monster.npc:get_pos_vec3(), center, minRadius, maxRadius, dir, cos, angle, height)
end

function monsterBase.now(monster)
  return get_npc_time(monster.npc)
end

function monsterBase.xRay(monster)
  cast_magic(monster.npc, monster.npc, Const.XRAY.MONSTER)
  monster.needXray = true
  monster.base.roleBase:xRay()
  monster.base.xRayNpcList[monster.npc.uuid] = true
end

function monsterBase.disableXray(monster)
  if not monster.needXray then
    return
  end
  local list = monster.base.xRayNpcList
  list[monster.npc.uuid] = nil
  if not next(list) then
    monster.base.roleBase:clearXray()
  end
end

function monsterBase.finTrans(monster)
  return monster.tree:finTrans()
end

function monsterBase.transState(monster, nextState, force)
  return monster.tree:transState(nextState, force)
end

function monsterBase.tryState(monster, nextState)
  local action = nextState:chooseChildAction()
  if not action then
    return false
  end
  monster:transState(action, true)
  return action
end

function monsterBase.doAfter(monster, func, delay, ...)
  monster.doAfterMgr:add(func, delay, false, ...)
end

function monsterBase.get_search_info(monster, npc)
  local map = monster.search_weight_map
  if not map then
    map = get_monster_search_config(monster.npc)
    monster.search_weight_map = map
  end
  local base_search_weight = monster.base_search_weight
  if not map or not npc then
    return base_search_weight
  end
  local result
  if npc:is_hero_or_player() then
    result = map.Hero
    if result then
      return result
    end
  end
  local result = map[get_monster_npc_name(npc)]
  if result then
    return result
  end
  result = map[npc.id]
  if result then
    return result
  end
  return monster.base_search_weight
end

function monsterBase.searchTarget(monster)
  local search = monster.search
  local minDis = search and search.minDis
  local maxDis = search and search.maxDis
  if not minDis or not maxDis then
    return
  end
  local oldTarget = monster.target
  local monsterNpc = monster.npc
  if oldTarget and not check_npc_die(oldTarget) and minDis > get_npc_distance(monster.npc, 1, oldTarget, true) then
    return
  end
  local max_weight = math.mininteger
  local closet_dist = math.maxinteger
  local max_weight_npc, info, cur_weight, cur_dist
  local uuid_map = SceneMgr:get_all_char()
  for _, obj in pairs(uuid_map) do
    info = monster:get_search_info(obj)
    cur_dist = get_npc_distance(monsterNpc, 1, obj, true)
    if not (not obj:is_destroy() and obj.magic_mgr and not check_magic(obj, Const.LOCK_MASK) and obj:can_update() and monsterNpc.uuid ~= obj.uuid and monsterNpc:get_camp() ~= obj:get_camp() and obj:is_can_searched()) or not info.ignore_distance and maxDis < cur_dist then
    else
      cur_weight = info.weight
      if max_weight < cur_weight then
        max_weight = cur_weight
        closet_dist = cur_dist
        max_weight_npc = obj
      elseif cur_weight == max_weight and cur_dist < closet_dist then
        closet_dist = cur_dist
        max_weight_npc = obj
      end
    end
  end
  monster:setTarget(max_weight_npc)
end

function monsterBase.go_mad_isReady(monster)
end

function monsterBase.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100103, 1)
end

function monsterBase.setTarget(monster, target)
  monster.target = target
  set_npc_target(monster.npc, target)
end

function monsterBase.registerGroup(monster)
  local group = monster.group
  if not group then
    return
  end
  group:addNpc(monster.npc)
end

function monsterBase.quitGroup(monster)
  local group = monster.group
  if not group then
    return
  end
  group:removeNpc(monster.npc)
  monster.group = nil
end

function monsterBase.has_melee_atk_slot(monster)
  if not monster.group then
    return
  end
  return monster.group:has_melee_atk_slot(monster)
end

function monsterBase.occupy_melee_atk_slot(monster)
  if not monster.group then
    return
  end
  return monster.group:occupy_melee_atk_slot(monster)
end

function monsterBase.release_melee_atk_slot(monster, slot)
  if not monster.group then
    return
  end
  monster.group:release_melee_atk_slot(monster, slot)
end

function monsterBase.has_ranged_atk_slot(monster)
  if not monster.group then
    return
  end
  return monster.group:has_ranged_atk_slot(monster)
end

function monsterBase.occupy_ranged_atk_slot(monster)
  if not monster.group then
    return
  end
  return monster.group:occupy_ranged_atk_slot(monster)
end

function monsterBase.release_ranged_atk_slot(monster, slot)
  if not monster.group then
    return
  end
  monster.group:release_ranged_atk_slot(monster, slot)
end

function monsterBase.has_counter_atk_slot(monster)
  if not monster.group then
    return
  end
  return monster.group:has_counter_atk_slot(monster)
end

function monsterBase.occupy_counter_atk_slot(monster)
  if not monster.group then
    return
  end
  return monster.group:occupy_counter_atk_slot(monster)
end

function monsterBase.release_counter_atk_slot(monster, slot)
  if not monster.group then
    return
  end
  monster.group:release_counter_atk_slot(monster, slot)
end

function monsterBase.try_red_skill_counter(monster, roleMis, monstMis, damageSkType)
  local skInfo = monster:check_red_skill_counter(roleMis, monstMis, damageSkType)
  if not skInfo then
    return
  end
  local attackerNpc = roleMis.v_owner
  monster:on_red_skill_countered(attackerNpc, monster.npc, roleMis)
  local attackerBehavior = attackerNpc:get_behavior()
  local attackerEvent = attackerBehavior and attackerBehavior.on_red_skill_countered
  if attackerEvent then
    attackerEvent(attackerBehavior, attackerNpc, monster.npc, roleMis)
  end
  return skInfo
end

function monsterBase.check_red_skill_counter(monster, roleMis, monstMis, damageSkType)
  local skActInfo = get_missile_skill_action_info(roleMis)
  local skAct = skActInfo and skActInfo.skAct
  if not skAct then
    return
  end
  if not monster.isRedSkill and (not monstMis or 2 ~= monstMis.missile_cfg.MissileTypeTag) then
    return
  end
  if damageSkType then
    return monster.redSkill_counter_type[damageSkType] and skActInfo
  else
    local misCfg = roleMis.missile_cfg
    local magics = misCfg and misCfg.magic
    if not magics then
      return
    end
    for _, magic_id in ipairs(magics) do
      if 0 == magic_id then
      else
        local magicCfg = ShareRes.get_magic_cfg(magic_id)
        if not magicCfg then
        else
          magicCfg = magicCfg.logic
          if magicCfg.type ~= Config.MagicDefine.MAGIC_TYPE.HurtDamage then
          elseif monster.redSkill_counter_type[magicCfg[1]] then
            return skActInfo
          end
        end
      end
    end
  end
end

function monsterBase.set_move_scale(monster, animName, newScaleZ, newScaleX)
  if not animName then
    Log.Error("anim name is nil, ", debug.traceback())
  end
  local moveScale = monster.moveScale
  local animScale = moveScale[animName] or monster.moveScaleBackUp[animName] or {}
  moveScale[animName] = animScale
  if newScaleZ then
    local oldScaleZ = animScale.z
    if not oldScaleZ then
      oldScaleZ = {}
      local animCfg = monster.npc.act_ctrl
      animCfg = animCfg and animCfg.v_motion_cfg
      animCfg = animCfg and animCfg[animName]
      if not animCfg then
        monster:debugOutput(animName .. " anim not found, ")
        return
      end
      local length = #animCfg.OffsetZ
      for i = 1, length do
        oldScaleZ[i] = 1
      end
      animScale.z = oldScaleZ
    end
    local length = #oldScaleZ
    if type(newScaleZ) == "table" then
      for i = 1, length do
        oldScaleZ[i] = newScaleZ[i] or 1
      end
      oldScaleZ.scale = nil
    elseif type(newScaleZ) == "number" then
      if newScaleZ ~= oldScaleZ.scale then
        for i = 1, length do
          oldScaleZ[i] = newScaleZ
        end
        oldScaleZ.scale = newScaleZ
      end
    else
      monster:debugOutput("input scale Z is in wrong type, ")
    end
  end
  if newScaleX then
    local oldScaleX = animScale.x
    if not oldScaleX then
      oldScaleX = {}
      local animCfg = monster.npc.act_ctrl
      animCfg = animCfg and animCfg.v_motion_cfg
      animCfg = animCfg and animCfg[animName]
      if not animCfg then
        monster:debugOutput(animName .. " anim not found, ")
        return
      end
      local length = #animCfg.OffsetX
      for i = 1, length do
        oldScaleX[i] = 1
      end
      animScale.x = oldScaleX
    end
    local length = #oldScaleX
    if type(newScaleX) == "table" then
      for i = 1, length do
        oldScaleX[i] = newScaleX[i] or 1
      end
      oldScaleX.scale = nil
    elseif type(newScaleX) == "number" then
      if oldScaleX.scale ~= newScaleX then
        for i = 1, length do
          oldScaleX[i] = newScaleX
        end
        oldScaleZ.scale = newScaleX
      end
    else
      monster:debugOutput("input scale X is in wrong type, ")
    end
  end
  set_move_offsets_multi_map(monster.npc, monster.moveScale)
end

function monsterBase.clear_move_scale(monster, animName)
  local moveScale = monster.moveScale
  local moveScaleBackUp = monster.moveScaleBackUp
  if not animName then
    for animName, scaleCfg in pairs(moveScale) do
      moveScale[animName] = nil
      moveScaleBackUp[animName] = scaleCfg
    end
    set_move_offsets_multi_map(monster.npc)
    return
  end
  local animScale = moveScale[animName]
  if not animScale then
    return
  end
  moveScaleBackUp[animName] = animScale
  moveScale[animName] = nil
  set_move_offsets_multi_map(monster.npc, moveScale)
end

function monsterBase.gm_get_skill_actions(monster)
  local list = {}
  local block = {
    "noTarget",
    "idle",
    "debugIdle",
    "dieGround",
    "dieAir",
    "faint",
    "stun",
    "daze",
    "bornSkill",
    "bornIdle",
    "born",
    "passive",
    "hit",
    "dead",
    "forward",
    "surround",
    "backward",
    "surMove",
    "moveFor",
    "moveLeft",
    "moveRight",
    "moveBack"
  }
  local states = monster.states
  for key, state in pairs(states) do
    if type(key) ~= "number" then
      local isBlock = false
      for _, item in pairs(block) do
        if state.name == item then
          isBlock = true
        end
      end
      if not isBlock then
        table.insert(list, state.name)
      end
    end
  end
  table.sort(list)
  return list
end

function monsterBase.gm_cast_skill_action(monster, stateName)
  local state
  if "gm_stopAction" == stateName then
    state = monster.states.debugIdle
  else
    state = monster.states[stateName]
  end
  local isReady = state.isReady
  state.isReady = Const.TURE_FUN
  set_skill_end_to_idle(monster.npc, true)
  abort_skill(monster.npc, true)
  monster.tree:transState(state)
  local resultState = monster.tree:curState()
  resultState = resultState and resultState.name
  state.isReady = isReady
end

function monsterBase.dead_remove_timeout_output(monster)
  local statesBeforeDead = monster.debug_statesBeforeDead
  local statesAfterDead = monster.debug_statesAfterDead
  local deadCbCallTime = monster.debug_deadCbCallTime
  local removeTime = monster.debug_removeTime
  local str = ""
  if deadCbCallTime then
    str = str .. "模板中的set_npc_dead回调已被调用，调用时间为：" .. tostring(deadCbCallTime) .. "\n"
  else
    str = str .. "模板中的set_npc_dead回调未被调用，怪物脚本很可能对死亡流程进行了定制化修改\n"
  end
  if removeTime then
    str = str .. "模板中的remove_npc已被调用，调用时间为：" .. tostring(removeTime) .. "\n"
  else
    str = str .. "模板中的remove_npc未被调用，怪物脚本很可能对死亡流程进行了定制化修改\n"
  end
  str = str .. "怪物死亡之前的状态为：" .. tostring(statesBeforeDead) .. "\n"
  str = str .. "怪物死亡之后的状态为：" .. tostring(statesAfterDead) .. "\n"
  return str
end

function monsterBase.missile_skill_action_info(monster, missileId)
  return
end

function monsterBase.activate_role_target_weight_panel(monster, is_enable)
  if is_enable then
    set_npc_hp_visible(monster.npc, false)
  else
    set_npc_hp_visible(monster.npc, true)
    monster:log(" ")
  end
end

function monsterBase.print_role_target_weight_info(monster, maxWeight_custom_npc, maxWeight_hp_npc, maxWeight_density_npc, maxWeight_angle_npc, maxWeight_dist_npc, maxWeight_viscous_npc, dedupWeight_valid, newTarget)
  local monsterNpc = monster.npc
  local str1, str2, str3, str4, str5, str6, str7, str8
  if not maxWeight_dist_npc then
    str1 = " dis         \t"
  else
    local value = monsterNpc.d_role_target_weight_dist
    if monsterNpc == maxWeight_dist_npc then
      str1 = string.format(" dis <b><i><color=red>%-4.0f</color></i></b> \t", value)
    else
      str1 = string.format(" dis <b><i>%-4.0f</i></b> \t", value)
    end
  end
  if not maxWeight_angle_npc then
    str2 = " ang \n"
  else
    local value = monsterNpc.d_role_target_weight_angle
    if monsterNpc == maxWeight_angle_npc then
      str2 = string.format(" ang<b><i><color=red>%.0f</color></i></b> \n", value)
    else
      str2 = string.format(" ang<b><i>%.0f</i></b> \n", value)
    end
  end
  if not maxWeight_density_npc then
    str3 = " den      \t"
  else
    local value = monsterNpc.d_role_target_weight_density
    if monsterNpc == maxWeight_density_npc then
      str3 = string.format(" den<b><i><color=red>%-3.0f</color></i></b> \t", value)
    else
      str3 = string.format(" den<b><i>%-3.0f</i></b> \t", value)
    end
  end
  if monsterNpc == maxWeight_viscous_npc then
    str4 = string.format(" vis <b><i><color=red>%.0f</color></i></b> \n", monsterNpc.d_role_target_weight_viscous)
  else
    str4 = " vis \n"
  end
  if not maxWeight_hp_npc then
    str5 = " hp         \t"
  else
    local value = monsterNpc.d_role_target_weight_hp
    if monsterNpc == maxWeight_hp_npc then
      str5 = string.format(" hp <b><i><color=red>%-4.0f</color></i></b> \t", value)
    else
      str5 = string.format(" hp <b><i>%-4.0f</i></b> \t", value)
    end
  end
  if not maxWeight_custom_npc then
    str6 = " cus \n"
  else
    local value = monsterNpc.d_role_target_weight_custom
    if monsterNpc == maxWeight_custom_npc then
      str6 = string.format(" cus<b><i><color=red>%.0f</color></i></b> \n", value)
    else
      str6 = string.format(" cus<b><i>%.0f</i></b> \n", value)
    end
  end
  if not dedupWeight_valid then
    str7 = " dup         \t"
  else
    local value = monsterNpc.d_role_target_weight_dedup
    str7 = string.format(" dup <b><i>%-4.0f</i></b> \t", value)
  end
  local value = monsterNpc.d_role_target_weight_total
  if monsterNpc == newTarget then
    str8 = string.format(" tot <b><i><color=red>%.2f</color></i></b>", value)
  else
    str8 = string.format(" tot <b><i>%.2f</i></b>", value)
  end
  monster:log(str1 .. str2 .. str3 .. str4 .. str5 .. str6 .. str7 .. str8)
end

function monsterBase.logState(monster)
  local state = monster.state
  local str = " <b>" .. state.name .. "</b> "
  local skill = state.curSk
  if monster.debugSwitch.curState >= 2 and skill then
    str = str .. [[

 ]] .. skill.name .. " "
  end
  if monster.debugSwitch.curState >= 3 and skill then
    str = str .. [[

 ]] .. skill.id .. " "
  end
  monster:log(str)
end

function monsterBase.log(monster, str)
  log_on_npc(monster.npc, str, true)
end

function monsterBase.print_current_states(monster)
  print(monster.tree:curStatesStr())
end

function monsterBase.isActiveStatus(monster)
  return monster.tool.isActiveStatus(monster.npc)
end

function monsterBase.curState(monster)
  return monster.tree:curState()
end

function monsterBase.curStates(monster)
  return monster.tree:curStatesStr()
end

function monsterBase.listenRoleAct(monster, func)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, monster.npc, func, monster)
  monster._is_listening_role_act = true
end

function monsterBase.unlistenRoleAct(monster)
  if not monster._is_listening_role_act then
    return
  end
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, monster.npc, monster)
  monster._is_listening_role_act = false
end

function monsterBase.getGroupNpcNum(monster)
  if not monster.group then
    return 0
  else
    return monster.group:getNpcNum()
  end
end

function monsterBase.getDiffTags(monster)
  local list = monster.diffiTags
  if list then
    return list
  end
  list = get_npc_difficulty_tag(monster.npc)
  list = list and UtilTable.copy_table(list) or {}
  monster.diffiTags = list
  return list
end

function monsterBase.initDifficulties(monster)
  local initFuns = monster.diffInitFuns
  if not initFuns then
    return
  end
  local tags = monster:getDiffTags()
  local fun
  for _, tag in pairs(tags) do
    fun = initFuns[tag]
    if fun then
      fun(monster)
    end
  end
end

function monsterBase.on_born_behavior(monster)
  if monster.bFinishBorn then
    return
  end
  monster:initDifficulties()
  monster:registerGroup()
  if not monster.states.born.isDone then
    monster.tree:start()
  end
  monster.bFinishBorn = true
end

function monsterBase.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
end

function monsterBase.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
end

function monsterBase.on_toughness_change(monster, npc, camp, change_level, enter_stun)
  if monster.npc ~= npc then
    return
  end
  monster:doAfter(monster.toughness_change_fx, nil, change_level)
end

function monsterBase.toughness_change_fx(monster, change_level)
  local roleNpc = get_come_on_hero()
  local type = get_role_kind(monster.npc)
  local fx = Const.MONSTER_BE_HIT
  if 2 == type then
    cast_magic(roleNpc, roleNpc, fx.CAM_SHAKE, 0)
  elseif 3 == type or 4 == type then
    if 0 ~= change_level then
      cast_magic(roleNpc, roleNpc, 1999345, 0)
    else
      cast_magic(roleNpc, roleNpc, 1999346, 0)
    end
    cast_magic(roleNpc, roleNpc, 1999347, 0)
    cast_magic(monster.npc, monster.npc, fx.FX, 0)
    cast_magic(monster.npc, monster.npc, fx.SOUND_REVERB, 0)
  end
end

function monsterBase.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  monster:clear_evade_value()
  monster.debug_statesBeforeDead = monster.tree:curStatesStr()
  monster.tree:transState(monster.states.dead)
  monster.debug_statesAfterDead = monster.tree:curStatesStr()
end

function monsterBase.on_skill_cast_time(monster, skill_id)
  local skill = monster.skills[skill_id]
  if not skill then
    return
  end
  skill:onCastTime()
end

function monsterBase.on_self_before_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  if not is_time_out then
    return
  end
  local skill = monster.skills[skill_id]
  if skill then
    skill:onBefEnd()
  end
end

function monsterBase.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  local skill = monster.skills[skill_id]
  if skill then
    if is_break and skill.onBreak then
      skill:onBreak()
      return
    end
    skill:onEnd()
  end
end

function monsterBase.on_target_self_element_aborn_start(monster, caster, element, skill_id)
  local now = get_time()
  local tool = monster.tool
  if now < tool.elementAbornCamPullTimer then
    return
  end
  tool.elementAbornCamPullTimer = now + tool.elementAbornCamPullInterval
  monster:doAfter(monster.element_aborn_fx)
end

function monsterBase.element_aborn_fx(monster)
  local roleNpc = get_come_on_hero()
  local type = get_role_kind(monster.npc)
  local fx = Const.MONSTER_BE_HIT
  if 2 == type then
    cast_magic(roleNpc, roleNpc, fx.CAM_SHAKE, 0)
  elseif 3 == type or 4 == type then
    cast_magic(roleNpc, roleNpc, fx.SLOMO_SELF, 0)
    cast_magic(roleNpc, roleNpc, fx.SLOMO_OTHERS, 0)
    cast_magic(roleNpc, roleNpc, fx.CAM_SHAKE, 0)
    cast_magic(monster.npc, monster.npc, fx.FX, 0)
    cast_magic(monster.npc, monster.npc, fx.SOUND_REVERB, 0)
  end
end

function monsterBase.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
end

function monsterBase.on_target_self_magic_begin(monster, caster, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == Const.LOCK_MASK then
    local monsterNpc = monster.npc
    local enemies = search_npc(monsterNpc, 4, 50, nil, false, true)
    for _, enemy in pairs(enemies) do
      local behavior = enemy:get_behavior()
      if behavior and behavior.target == monsterNpc then
        behavior.target = nil
        set_npc_target(enemy, nil)
      end
    end
    local roleTool = monster.roleTool
    if roleTool.target == monsterNpc then
      roleTool:setTarget()
    end
    set_can_searched(monster.npc, false)
    local lockOn = Const.LOCK_ON_TAG
    abort_magic_by_id(monster.npc, lockOn)
  end
  if magic_id == Const.RED_SKILL then
    monster.isRedSkill = true
  end
end

function monsterBase.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
end

function monsterBase.on_frame(monster, dt)
  if not monster.npc then
    return
  end
  monster.doAfterMgr:update()
  monster.tree:tick()
end

function monsterBase.on_start(monster)
  return monster.behaviorBase.on_start(monster)
end

function monsterBase.on_remove(monster)
  monster:disableXray()
  monster:unlistenRoleAct()
  monster.behaviorBase.on_remove(monster)
  monsterBase.instList = nil
end

function monsterBase.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  abort_magic_by_id(monster.npc, Const.RED_SKILL)
  abort_skill(monster.npc, false)
  lookat_npc(monster.npc, attackerNpc, true)
  monster:doAfter(monster.on_red_skill_countered_fx, nil, attackerNpc, missile)
end

function monsterBase.on_red_skill_countered_fx(monster, attackerNpc, missile)
  attackerNpc = attackerNpc or get_come_on_hero()
  local npc = monster.npc
  cast_magic(npc, npc, Const.MONSTER_BE_HIT.SOUND_REVERB, 0)
  enter_stun(monster.npc, false, 2.5)
  if 0 == get_missile_kill_role_count(npc, missile) then
    cast_magic(attackerNpc, npc, 1999220)
  end
  local monster_kind = get_role_kind(monster.npc)
  if 4 ~= monster_kind then
    cast_magic(attackerNpc, attackerNpc, 1999351)
  else
    cast_magic(attackerNpc, attackerNpc, 1999352)
  end
  cast_magic(attackerNpc, npc, 1999242)
  cast_magic(attackerNpc, npc, 1999261)
  cast_magic(attackerNpc, npc, 1999219)
  cast_magic(attackerNpc, npc, 1999221)
  cast_magic(attackerNpc, npc, 1999222)
  cast_magic(attackerNpc, npc, 1999285)
  cast_magic(attackerNpc, npc, 1999347)
end

function monsterBase.create_skill_node_cfg(skill, cd, initCd, minDis, maxDis, startAngle, endAngle, atkCdOffset, startFrame, moveScaleZ)
  return {
    skill,
    cd,
    initCd,
    minDis,
    maxDis,
    startAngle,
    endAngle,
    atkCdOffset,
    startFrame,
    moveScaleZ
  }
end

function monsterBase._init(monster, actSkills, actMoves, nodes, magicIds, missileIds)
  monster.base = monsterBase
  monster.doAfterMgr = doAfterMgrBase:new(monster)
  monster.debugSwitch = UtilTable.copy_table(monster.base.debugSwitch)
  monster.hitRecord = {}
  monster.moveScale = {}
  monster.moveScaleBackUp = {}
  monster.search_weight_map = get_monster_search_config(monster.npc)
  monster.id = monster.npc.id
  monster.state = nil
  monster.preState = nil
  local kind = get_role_kind(monster.npc)
  monster.searchInterval = 8
  monster.searchFrame = Global.frame_id
  monster.evade_config = UtilTable.fill_table(monster.base.evade_config, monster.evade_config)
  monster.is_evade_slomo = false
  monster.isRedSkill = false
  if 4 == kind then
    monster.searchInterval = 0
  elseif 3 == kind then
    monster.searchInterval = 4
  elseif 2 == kind then
    monster.searchFrame = monster.tool:getSearchStartFrame() % 8 + monster.searchFrame
  end
  monster.group = tool:getGroup(monster)
  monster.target = nil
  monster.wander = monster.wander or {
    minDis = 1,
    maxDis = 5,
    minTime = 1,
    maxTime = 1.5,
    type = "walk"
  }
  monster.search = monster.search or {minDis = 3, maxDis = 30}
  monster.doAfters = {}
  monster.born = monster.born or 0.5
  if not monster.redSkillCounterMis then
    if 3 == kind or 4 == kind then
      monster.redSkillCounterMis = Const.RED_SKILL_COUNTER_MIS
    elseif 2 == kind then
      monster.redSkillCounterMis = Const.RED_SKILL_COUNTER_MIS
    end
  end
  monster.tree = treeBase:new(monster)
  tool.genSkills(monster)
  do
    local baseNodes = {
      "root",
      "active",
      "born",
      "passive",
      "gotTarget",
      "noTarget",
      "hit",
      "dead",
      "attack",
      "groupAtk",
      "freeAtk",
      "meleeAtk",
      "rangedAtk",
      "evade",
      "freeCounter",
      "groupCounter",
      "meleeCounter",
      "rangedCounter",
      "wander",
      "wanderMove",
      "wanderStand",
      "forward",
      "surround",
      "backward",
      "surMove",
      "stun"
    }
    local baseActMoves = {
      "debugIdle",
      "bornIdle",
      "standIdle",
      "idle",
      "faint",
      "stunGround",
      "stunAir",
      "moveFor",
      "moveLeft",
      "moveRight",
      "moveBack",
      "daze",
      "decisionFailed"
    }
    local baseActSkills = {
      bornSkill = {},
      dieGround = {},
      dieAir = {}
    }
    tool.genStates(monster, baseNodes, baseActMoves, baseActSkills)
  end
  tool.genStates(monster, nodes, actMoves, actSkills)
  if missileIds then
    tool.genMisLogics(monster, missileIds)
  end
  if magicIds then
    tool:genMagics(monster, magicIds)
  end
  monster.diffInitFuns = {}
  do
    local _ENV = monster.states
    _ENV.root(_ENV.born, _ENV.debugIdle, _ENV.evade, _ENV.active, _ENV.passive, _ENV.decisionFailed)
    _ENV.active(_ENV.daze, _ENV.gotTarget, _ENV.noTarget)
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.attack(_ENV.freeAtk, _ENV.groupAtk(_ENV.rangedAtk, _ENV.meleeAtk))
    _ENV.evade(_ENV.freeCounter, _ENV.groupCounter(_ENV.meleeCounter, _ENV.rangedCounter))
    _ENV.wander(_ENV.wanderMove, _ENV.wanderStand)
    _ENV.wanderMove(_ENV.forward(_ENV.moveFor), _ENV.surround(_ENV.surMove(_ENV.moveLeft, _ENV.moveRight)), _ENV.backward(_ENV.moveBack))
    _ENV.wanderStand(_ENV.standIdle)
    _ENV.noTarget(_ENV.idle)
    _ENV.passive(_ENV.hit(_ENV.faint, _ENV.stun), _ENV.dead(_ENV.dieAir, _ENV.dieGround))
    _ENV.stun(_ENV.stunAir, _ENV.stunGround)
  end
  local tree = monster.tree
  local states = monster.states
  if not monster.group then
    local _ENV = monster.states
    _ENV.attack(_ENV.freeAtk)
  end
  states.born.isBorn = false
  
  function states.born.isReady(born)
    return not born.isDone
  end
  
  function states.born.start(born)
    born.isDone = true
    local monster = born.monster
    cast_magic(monster.npc, monster.npc, 399929)
  end
  
  states.born.active = states.active
  
  function states.born.finTrans(born)
    return born.active
  end
  
  states.born.passive = states.passive
  
  function states.born.tickTrans(born)
    local passive = born.passive
    if passive:isReady() then
      return passive
    end
  end
  
  do
    local param = monster.born
    if type(param) ~= "number" then
    end
    if monster.born > 1000 then
      states.born(states.bornSkill)
      local bornSk = skillBase:new(monster, param)
      
      function bornSk.isReady()
        return true
      end
      
      monster.skills[param] = bornSk
      monster.skills.born = bornSk
      states.bornSkill.skill = bornSk
      
      function states.bornSkill.isReady()
        return true
      end
    else
      states.born(states.bornIdle)
      
      function states.bornIdle.start(bornIdle)
        local monster = bornIdle.monster
        bornIdle.timer = get_npc_time(monster.npc) + monster.born
        stop_move(monster.npc)
      end
      
      function states.bornIdle.tick(bornIdle)
        local monster = bornIdle.monster
        if get_npc_time(monster.npc) > bornIdle.timer then
          monster.tree:finTrans()
        end
      end
    end
  end
  
  function states.debugIdle.isReady()
    return false
  end
  
  function states.debugIdle.start(debugIdle)
    stop_move(debugIdle.monster.npc)
  end
  
  function states.daze.isReady(daze)
    return 1 == get_sync_var("in_daze")
  end
  
  function states.daze.start(daze)
    stop_move(daze.monster.npc)
  end
  
  states.daze.active = states.active
  
  function states.daze.tickTrans(daze)
    if not daze:isReady() then
      return daze.active
    end
  end
  
  function states.root.finish(root)
    local monster = root.monster
    monster:debugOutput("root.finish is called")
    monster.tree:printDebugInfo(tree)
  end
  
  do
    local active = states.active
    
    function active.isReady(self_node)
      return monster:isActiveStatus()
    end
    
    active.evade = states.evade
    
    function active.tick(active)
      active.base.tick(active)
      local evade = active.evade
      local evade_config = evade.config
      local value = evade.value - evade_config.decayRate * 0.05
      evade.value = math.max(0, value)
    end
    
    active.passive = states.passive
    
    function active.tickTrans(active)
      local monster = active.monster
      if not monster:isActiveStatus() then
        return active.passive
      end
    end
    
    local passive = states.passive
    
    function passive.isReady(passive)
      return not passive.monster:isActiveStatus()
    end
    
    passive.active = states.active
    
    function passive.tickTrans(passive)
      local monster = passive.monster
      if monster:isActiveStatus() then
        return passive.active
      end
    end
  end
  states.faint.passive = states.passive
  
  function states.faint.tickTrans(faint)
    if not faint:isReady() then
      return faint.passive
    end
  end
  
  function states.faint.isReady(faint)
    return check_npc_status(faint.monster.npc, 14)
  end
  
  function states.faint.start(faint)
    faint.monster:clear_evade_value()
    faint.base.start(faint)
  end
  
  states.stun.faint = states.faint
  
  function states.stun.tickTrans(stun)
    if stun.faint:isReady() then
      return stun.faint
    end
  end
  
  function states.stunAir.isReady(stunAir)
    local status = get_npc_status(stunAir.monster.npc)
    return 10 == status or 11 == status
  end
  
  function states.stunAir.start(stunAir)
    stunAir.monster:clear_evade_value()
    stunAir.base.start(stunAir)
  end
  
  function states.stunGround.isReady(stunGround)
    return true
  end
  
  states.stunGround.stunAir = states.stunAir
  
  function states.stunGround.tickTrans(stunGround)
    local stunAir = stunGround.stunAir
    if stunAir:isReady() then
      return stunAir
    end
  end
  
  states.evade.value = 0
  states.evade.config = monster.evade_config
  
  function states.evade.isReady(evade)
    if not evade.base.isReady(evade) then
      return false
    end
    if evade.value < evade.config.threshold then
      return false
    end
    local monster = evade.monster
    if monster.target ~= get_come_on_hero() then
      return false
    end
    local role = monster.target:get_behavior()
    local roleAct = role and role.skAct
    if roleAct and roleAct.canEvade and not roleAct:canEvade() then
      return false
    end
    local states = monster.states
    if not states.stun:isRunning() and not states.wander:isRunning() then
      return false
    end
    return true
  end
  
  function states.evade.start(evade)
    local monster = evade.monster
    local monsterNpc = monster.npc
    cast_magic(monsterNpc, monsterNpc, evade.config.armor_increase)
    monster:clear_evade_value()
    evade.base.start(evade)
  end
  
  states.evade.passive = states.passive
  
  function states.evade.tickTrans(evade)
    if not evade.monster:isActiveStatus() then
      return evade.passive
    end
  end
  
  function states.evade.finish(evade)
    local monster = evade.monster
    local monsterNpc = monster.npc
    abort_magic_by_id(monsterNpc, evade.config.armor_increase)
  end
  
  states.evade.wander = states.wander
  
  function states.evade.finTrans(evade)
    return evade.wander
  end
  
  states.groupCounter.slot = nil
  
  function states.groupCounter.isReady(groupCounter)
    if not groupCounter.base.isReady(groupCounter) then
      return false
    end
    if monster.target ~= get_come_on_hero() then
      return
    end
    if not monster:has_counter_atk_slot() then
      return false
    end
    if not monster:has_clean_shot() then
      return
    end
    return true
  end
  
  states.groupCounter.evade = states.evade
  states.groupCounter.monster_skAct_moveScale_backUp = {}
  states.groupCounter.zero_move_scale = {}
  states.groupCounter.counter_role = nil
  states.groupCounter.counter_role_skAct = nil
  states.groupCounter.counter_role_skAct_castId = nil
  
  function states.groupCounter.start(groupCounter)
    local monster = groupCounter.monster
    local config = monster.evade_config
    local monsterNpc = monster.npc
    local target = monster.target
    lookat_npc(monsterNpc, target, true)
    local monsterAction = groupCounter:chooseChildAction()
    local monsterSkill = monsterAction and monsterAction.skill
    if monsterSkill then
      local oriScale = monsterAction.v_move_scale_z
      groupCounter.monster_skAct = monsterAction
      groupCounter.monster_skAct_moveScale_backUp = oriScale
      local zeroScale = groupCounter.zero_move_scale
      local length = monsterSkill:startFrame() + 4
      local animLength = monsterSkill:animLength()
      if type(oriScale) == "number" then
        for i = 1, animLength do
          zeroScale[i] = i <= length and 0 or oriScale
        end
      else
        for i = 1, animLength do
          zeroScale[i] = i <= length and 0 or oriScale[i]
        end
      end
      monsterAction.v_move_scale_z = zeroScale
    end
    cast_magic(monsterNpc, monsterNpc, config.clear_slomo)
    cast_magic(monsterNpc, monsterNpc, config.monster_back)
    cast_magic(monsterNpc, monsterNpc, config.red_flash)
    local counterRole = target:get_behavior()
    groupCounter.counter_role = counterRole
    groupCounter.counter_role_skAct = counterRole.skAct
    groupCounter.counter_role_skAct_castId = counterRole.skAct and counterRole.skAct.castId
    groupCounter.slot = monster:occupy_counter_atk_slot()
    groupCounter.base.start(groupCounter)
  end
  
  states.groupCounter.attack = states.attack
  
  function states.groupCounter.finish(groupCounter)
    monster:release_counter_atk_slot(groupCounter.slot)
    local monsterSkAct = groupCounter.monster_skAct
    if monsterSkAct then
      monsterSkAct.v_move_scale_z = groupCounter.monster_skAct_moveScale_backUp
    end
    groupCounter.slot = nil
    local attack = groupCounter.attack
    local newAtkTimer = get_npc_time(attack.monster.npc) + attack.interval + attack.intervalOffset
    attack.timer = math.max(attack.timer, newAtkTimer)
    groupCounter.base.finish(groupCounter)
  end
  
  function states.meleeCounter.isReady(meleeCounter)
    if not meleeCounter.base.isReady(meleeCounter) then
      return false
    end
    local is_clear_shot = true
    if not is_clear_shot then
      return false
    end
    return true
  end
  
  states.meleeCounter.evade = states.evade
  
  function states.meleeCounter.start(meleeCounter)
    local monster = meleeCounter.monster
    local counterRole = monster.target and monster.target:get_behavior()
    local missile = meleeCounter.evade.be_hit_missile
    local skActInfo = missile and get_missile_skill_action_info(missile)
    local be_hit_missile_type = missile and missile.missile_cfg.MissileTypeTag
    local be_hit_role_skAct = skActInfo and skActInfo.skAct
    local be_hit_role_skAct_castId = skActInfo and skActInfo.castId
    local need_role_back = counterRole and be_hit_missile_type == MISSILE_TYPE_TAG.MELEE and be_hit_role_skAct == counterRole.skAct and be_hit_role_skAct_castId == counterRole.skAct.castId
    monster:enter_evade_slomo(need_role_back)
  end
  
  function states.decisionFailed.start(decisionFailed)
    local monster = decisionFailed.monster
    Util.debug_output(monster.npc.id, monster.npc.uuid, "行为树进入决策失败节点")
  end
  
  states.decisionFailed.active = states.active
  
  function states.decisionFailed.tickTrans(decisionFailed)
    return decisionFailed.active
  end
  
  do
    local dead = states.dead
    
    function dead.isReady(self_node)
      local monster = self_node.monster
      local hp = get_npc_attr(monster.npc, 1)
      return hp < 0.1
    end
    
    if 4 == get_role_kind(monster.npc) then
      dead.delay = {fx = 0, remove = 1}
    elseif 3 == get_role_kind(monster.npc) then
      dead.delay = {fx = 0, remove = 0.8}
    else
      dead.delay = {fx = 0, remove = 0.5}
    end
    dead.timer = {fx = 0, remove = 0}
    
    function dead.startTickRemove(monster)
      monster.debug_deadCbCallTime = get_time()
      if monster.npc then
        local states = monster.states
        states.dead.tick = states.dead.tickRemove
      end
    end
    
    function dead.dieNormal(dead)
      local monster = dead.monster
      local now = get_time()
      dead.timer.fx = now + dead.delay.fx
      dead.timer.remove = now + dead.delay.remove
      enable_shadow(monster.npc, false)
      time_scale_immune(monster.npc, true)
      set_skill_end_to_idle(monster.npc, false)
      abort_skill(monster.npc, false)
      if 2 == get_role_kind(monster.npc) or 3 == get_role_kind(monster.npc) then
        set_npc_hp_visible(monster.npc, false)
      end
      set_npc_dead(monster.npc, nil, false, dead.startTickRemove)
      monster:quitGroup()
      monster:addMagics(Const.INVULNERABLE, Const.IGNORE_OTHER_COLLISION, Const.IGNORE_SELF_COLLISION)
      
      function monster.states.passive.tickTrans()
      end
    end
    
    dead.start = dead.dieNormal
    dead.isDeadSet = false
    dead.isFxCasted = false
    dead.isRemoved = false
    
    function dead.tick(dead)
      local monster = dead.monster
      local now = get_time()
      local timer = dead.timer
      if not dead.isFxCasted and now >= timer.fx then
        local magicMeltOut = Const.DEAD_MELT_OUT
        cast_magic(monster.npc, monster.npc, magicMeltOut, 0)
        dead.isFxCasted = true
      end
    end
    
    function dead.tickRemove(dead)
      local monster = dead.monster
      local now = get_time()
      local timer = dead.timer
      if not dead.isFxCasted and now >= timer.fx then
        local magicMeltOut = Const.DEAD_MELT_OUT
        cast_magic(monster.npc, monster.npc, magicMeltOut, 0)
        dead.isFxCasted = true
      end
      if not dead.isRemoved and now >= timer.remove then
        remove_npc(monster.npc)
        monster.debug_removeTime = get_time()
        dead.isRemoved = true
      end
    end
    
    local nilFun = Const.NIL_FUN
    local dieAir = states.dieAir
    
    function dieAir.isReady(self_node)
      local monster = self_node.monster
      local status = get_npc_status(monster.npc)
      return 10 == status or 11 == status
    end
    
    dieAir.start = nilFun
    dieAir.tick = nilFun
    local dieGround = states.dieGround
    
    function dieGround.isReady(self_node)
      return true
    end
    
    dieGround.start = nilFun
    dieGround.tick = nilFun
  end
  do
    local gotTarget = states.gotTarget
    
    function gotTarget.isReady(gotTarget)
      local monster = gotTarget.monster
      monster:searchTarget()
      return gotTarget.monster.target
    end
    
    local noTarget = states.noTarget
    
    function noTarget.isReady(noTarget)
      return not noTarget.monster.target
    end
    
    function noTarget.tick(noTarget)
      local monster = noTarget.monster
      local curFrame = Global.frame_id
      if curFrame >= monster.searchFrame then
        monster:searchTarget()
        monster.searchFrame = curFrame + monster.searchInterval
      end
    end
    
    function noTarget.tickTrans(noTarget)
      local monster = noTarget.monster
      if monster.target then
        return monster.states.gotTarget
      end
    end
  end
  
  function states.idle.start(self_node)
    stop_move(self_node.monster.npc)
  end
  
  states.idle.noTarget = states.noTarget
  
  function states.idle.finTrans(idle)
    return idle.noTarget
  end
  
  states.attack.timer = 0
  states.attack.interval = 2
  states.attack.intervalOffset = 0
  do
    local kind = get_role_kind(monster.npc)
    if 2 == kind then
      if monster.group then
        states.attack.interval = monster.group.atkSlots.melee.slotCd
      else
        states.attack.interval = 5
      end
    end
    
    function states.attack.start(attack)
      attack.intervalOffset = 0
      attack.base.start(attack)
    end
    
    function states.attack.finish(attack)
      attack.timer = get_npc_time(attack.monster.npc) + attack.interval + attack.intervalOffset
      attack.base.finish(attack)
    end
    
    function states.attack.isReady(attack)
      if not attack.base.isReady(attack) then
        return false
      end
      if get_npc_time(attack.monster.npc) < attack.timer then
        return false
      end
      return true
    end
    
    states.attack.wander = states.wander
    
    function states.attack.finTrans(attack)
      return attack.wander
    end
  end
  states.meleeAtk.slot = nil
  
  function states.meleeAtk.isReady(meleeAtk)
    if not meleeAtk.base.isReady(meleeAtk) then
      return false
    end
    if not monster:has_melee_atk_slot() then
      return false
    end
    return true
  end
  
  function states.meleeAtk.start(meleeAtk)
    meleeAtk.slot = monster:occupy_melee_atk_slot()
    meleeAtk.base.start(meleeAtk)
  end
  
  function states.meleeAtk.finish(meleeAtk)
    monster:release_melee_atk_slot(meleeAtk.slot)
    meleeAtk.slot = nil
    meleeAtk.base.finish(meleeAtk)
  end
  
  states.rangedAtk.slot = nil
  
  function states.rangedAtk.isReady(rangedAtk)
    if not rangedAtk.base.isReady(rangedAtk) then
      return false
    end
    if not monster:has_ranged_atk_slot() then
      return false
    end
    return true
  end
  
  function states.rangedAtk.start(rangedAtk)
    rangedAtk.slot = monster:occupy_ranged_atk_slot()
    rangedAtk.base.start(rangedAtk)
  end
  
  function states.rangedAtk.finish(rangedAtk)
    monster:release_ranged_atk_slot(rangedAtk.slot)
    rangedAtk.slot = nil
    rangedAtk.base.finish(rangedAtk)
  end
  
  function states.wander.isReady(wander)
    return wander.monster.target
  end
  
  function states.wander.tick(wander)
    local monster = wander.monster
    local curFrame = Global.frame_id
    if curFrame >= monster.searchFrame then
      monster:searchTarget()
      monster.searchFrame = curFrame + monster.searchInterval
    end
  end
  
  function states.wander.tickTrans(wander)
    local monster = wander.monster
    local states = monster.states
    if not monster.target then
      return states.noTarget
    end
    if states.attack then
      return tree:chooseChildAction(states.attack)
    end
  end
  
  function states.wander.finTrans(wander)
    return wander
  end
  
  states.wanderMove.stand = states.wanderStand
  
  function states.wanderMove.tickTrans(wanderMove)
    if not check_npc_status(wanderMove.monster.npc, 9) then
      return wanderMove
    end
  end
  
  function states.standIdle.isReady(standIdle)
    return check_npc_status(standIdle.monster.npc, 0)
  end
  
  states.standIdle.time = 0
  
  function states.standIdle.start(standIdle)
    local monster = standIdle.monster
    stop_move(monster.npc)
    standIdle.timer = get_npc_time(monster.npc) + standIdle.time
  end
  
  states.standIdle.wander = states.wander
  
  function states.standIdle.tickTrans(standIdle)
    if get_npc_time(standIdle.monster.npc) > standIdle.timer then
      return standIdle.wander
    end
  end
  
  do
    local forward = states.forward
    
    function forward.isReady(self_node)
      local monster = self_node.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      return distance > monster.wander.maxDis
    end
    
    local surround = states.surround
    
    function surround.isReady(self_node)
      local monster = self_node.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      return distance > monster.wander.minDis and distance <= monster.wander.maxDis
    end
    
    local backward = states.backward
    
    function backward.isReady(self_node)
      local monster = self_node.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      return distance <= monster.wander.minDis
    end
  end
  do
    local function initTimers(node)
      local monster = node.monster
      
      local now = get_npc_time(monster.npc)
      node.timers = {
        endTime = now + node.maxTime,
        checkTime = now + node.minTime
      }
    end
    
    local function check(curNode, conditionNode)
      local monster = curNode.monster
      local now = get_npc_time(monster.npc)
      local timers = curNode.timers
      if now > timers.endTime then
        monster.tree:finTrans()
        return
      end
      if now > timers.checkTime then
        timers.checkTime = now + curNode.minTime
        if not conditionNode:isReady() then
          return monster.states.wander
        end
      end
    end
    
    local moveFor = states.moveFor
    moveFor.minTime = monster.wander.minTime
    moveFor.maxTime = monster.wander.maxTime
    moveFor.method = "walk" == monster.wander.type and 1 or 0
    moveFor.timers = {endTime = 0, checkTime = 0}
    
    function moveFor.start(self_node)
      actMoveBase.start(self_node, self_node.method)
      initTimers(self_node)
    end
    
    function moveFor.tickTrans(self_node)
      local states = self_node.monster.states
      local forward = states.forward
      return check(self_node, forward)
    end
    
    local surMove = states.surMove
    surMove.minTime = monster.wander.minTime
    surMove.maxTime = monster.wander.maxTime
    surMove.timers = {endTime = 0, checkTime = 0}
    
    function surMove.tickTrans(self_node)
      local states = self_node.monster.states
      local surround = states.surround
      return check(self_node, surround)
    end
    
    local moveLeft = states.moveLeft
    
    function moveLeft.isReady(self_node)
      return tool.randByTime(self_node.monster, 0.5)
    end
    
    function moveLeft.start(self_node)
      actMoveBase.start(self_node, 3)
      local states = self_node.monster.states
      initTimers(states.surMove)
    end
    
    local moveRight = states.moveRight
    
    function moveRight.start(self_node)
      actMoveBase.start(self_node, 4)
      local states = self_node.monster.states
      initTimers(states.surMove)
    end
    
    local moveBack = states.moveBack
    moveBack.minTime = monster.wander.minTime
    moveBack.maxTime = monster.wander.maxTime
    moveBack.timers = {endTime = 0, checkTime = 0}
    
    function moveBack.start(self_node)
      actMoveBase.start(self_node, 2)
      initTimers(self_node)
    end
    
    function moveBack.tickTrans(self_node)
      local states = self_node.monster.states
      local backward = states.backward
      return check(self_node, backward)
    end
  end
end

do return monsterBase end
do
  local monster = {}
  
  function monster._init(monster, npc, fileId, npcScope, globalScope)
  end
  
  function monsterBase.on_self_skill_begin(monster, skill_id, skill_type, skill_cfg)
  end
end
