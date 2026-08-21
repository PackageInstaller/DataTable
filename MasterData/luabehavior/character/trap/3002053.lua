local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_ignore_sync_area(monster.npc, false)
  set_can_searched(monster.npc, true)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 300204801, 1)
  create_scene_effect("fx_common_monster_born", get_npc_pos(npc), 0)
  monster.npc:set_enable_rvo(false)
  monster.all_value = {1, 2}
  monster.value = monster.all_value[1]
  local actSkills = {
    drink_Start = {
      300205301,
      math.huge
    },
    drink_Loop = {300205302},
    drink_End = {300205303},
    Henshin = {300205304}
  }
  local nodes = {"drink"}
  local actMoves = {
    "escape",
    "moveToWater"
  }
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.root(_ENV.escape, _ENV.drink, _ENV.decisionFailed)
    _ENV.drink(_ENV.moveToWater, _ENV.drink_Start(_ENV.drink_Loop(_ENV.drink_End(_ENV.Henshin))))
  end
  math.randomseed(os.time())
  monster.drinkCD = get_npc_time(monster.npc) + math.random() * 4 + 3
  monster.states.drink.distance = false
  monster.states.escape.closetMis = nil
  monster.states.escape.closetPos = nil
  monster.states.escape.minDis = 999999999
  monster.nightSwitch = true
  monster.arrive = false
  monster.center = {
    x = 0,
    y = get_npc_pos(get_come_on_hero()).y,
    z = 336.5
  }
  do
    local escape = monster.states.escape
    escape.changeTime = 0
    
    function escape.start(escape)
      math.randomseed(os.time())
      monster.angleElapse = math.random(0, 60) * math.random(-1, 1)
      if monster.arrive == true then
        monster.TEMP_POS = get_npc_offset_position(monster.npc, monster.center, monster.angleElapse, 100000)
        monster.arrive = false
      else
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
      end
      lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, false)
      move_to_pos(monster.npc, monster.TEMP_POS)
      switch_move_type(monster.npc, 1)
      local rValue = math.random() * 3 + 2
      escape.changeTime = get_npc_time(monster.npc) + rValue
    end
    
    function escape.tick(escape)
      if monster.level < 2 then
        if escape.monster.tool.blueWaters == nil then
          return
        end
        if nil == _G.next(escape.monster.tool.blueWaters) then
          return
        end
        if get_npc_time(monster.npc) <= monster.drinkCD then
          return
        end
        local selfPos = get_npc_pos(escape.monster.npc)
        if nil == selfPos then
          return
        end
        local closetMis = escape.closetMis
        local closetPos = escape.closetPos
        local minDis = escape.minDis
        for _, waterMis in pairs(escape.monster.tool.blueWaters) do
          local misPos = get_missile_pos(waterMis)
          local distSquare = (selfPos.x - misPos.x) * (selfPos.x - misPos.x) + (selfPos.z - misPos.z) * (selfPos.z - misPos.z)
          if waterMis.drinkNum < waterMis.drinkNum_Max and distSquare < minDis * minDis then
            minDis = distSquare ^ 0.5
            closetMis = waterMis
            closetPos = misPos
          end
        end
        if minDis < 20 and escape.monster.tool.blueWaters[closetMis].drinkNum < escape.monster.tool.blueWaters[closetMis].drinkNum_Max then
          escape.monster.states.drink.distance = true
          escape.monster.states.moveToWater.minDis = minDis
          escape.monster.states.moveToWater.closetPos = closetPos
          escape.monster.states.moveToWater.closetMis = closetMis
        else
          escape.monster.states.drink.distance = false
        end
      end
    end
    
    function escape.tickTrans(escape)
      if monster.arrive == true then
        return monster.states.escape
      end
      if get_npc_time(escape.monster.npc) > escape.changeTime then
        return monster.states.escape
      end
      local states = escape.monster.states
      local drink = escape.monster.states.drink
      if drink.isReady(drink) then
        return monster.states.drink
      end
    end
  end
  monster.level = 1
  do
    local drink = monster.states.drink
    local Henshin = monster.states.Henshin
    local drink_End = monster.states.drink_End
    local drink_Loop = monster.states.drink_Loop
    local drink_Start = monster.states.drink_Start
    local escape = monster.states.escape
    
    function drink.isReady(drink)
      if 2 == monster.level then
        return false
      end
      if monster.tool.blueWaters == nil then
        return false
      end
      if nil == _G.next(monster.tool.blueWaters) then
        return false
      end
      if drink_Start.base.isReady(drink_Start) == false then
        return false
      end
      if false == drink.distance then
        return false
      end
      return true
    end
    
    function drink.tick(dashOut)
      print("喝水状态" .. tostring(monster.state.name))
    end
    
    function drink_End.finish(drink_End)
      drink_End.base.finish(drink_End)
      local self = drink_End.monster.npc
      change_npc_prefab(self, 1, false)
      monster.level = 2
      monster.value = monster.all_value[2]
    end
    
    function drink.finish()
      local tool = drink_Start.monster.tool
      local closetMis = drink.monster.states.moveToWater.TarMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum - 1
    end
    
    function drink.finTrans(drink)
      print("喝水状态" .. tostring(monster.state.name))
      return monster.states.escape
    end
  end
  do
    local moveToWater = monster.states.moveToWater
    
    function moveToWater.start(moveToWater)
      cast_magic(monster.npc, monster.npc, 2020470103, 1)
      moveToWater.TarMis = moveToWater.closetMis
      moveToWater.TarPos = moveToWater.closetPos
      moveToWater.randomPos = get_position_offset_position(moveToWater.TarPos, moveToWater.TarPos, math.random(0, 360), 3 * math.random())
      move_to_pos(moveToWater.monster.npc, moveToWater.randomPos)
      switch_move_type(moveToWater.monster.npc, 0)
      local tool = moveToWater.monster.tool
      local closetMis = monster.states.moveToWater.closetMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum + 1
    end
    
    function moveToWater.tickTrans(moveToWater)
      local pos = moveToWater.randomPos
      local closetMis = monster.states.moveToWater.closetMis
      local Dis = moveToWater.monster.tool.blueWaters[closetMis].drinkDis
      if check_npc_distance_to_pos(moveToWater.monster.npc, pos.x, pos.z, Dis, true) then
        return moveToWater.monster.states.drink_Start
      end
      if _G.next(monster.tool.blueWaters) == nil then
        return moveToWater.monster.states.active
      end
    end
    
    function moveToWater.finTrans(moveToWater)
      return moveToWater.monster.states.drinkWater
    end
  end
  states.dead.delay.remove = 0.5
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 4) == "back" then
    monster.arrive = true
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if attacker == get_come_on_hero() and missile_cfg.Id ~= 30020570101 then
    if 1 == monster.level then
      abort_skill(monster.npc, true)
      cast_magic(monster.npc, monster.npc, 300800501, 1)
      cast_magic(monster.npc, monster.npc, 300205302, 1)
    end
    if 2 == monster.level then
      cast_magic(monster.npc, monster.npc, 300204803, 1)
    end
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  if 2 == monster.value then
    cast_magic(monster.npc, monster.npc, 300800502, 1)
  end
  if get_cur_room_id() == 800301 then
    add_task_progress(8003011, monster.value)
    add_task_progress(8003012, monster.value)
    add_task_progress(8003013, monster.value)
  end
  if get_cur_room_id() == 800302 then
    add_task_progress(8003021, monster.value)
    add_task_progress(8003022, monster.value)
    add_task_progress(8003023, monster.value)
  end
  if get_cur_room_id() == 800303 then
    add_task_progress(8003031, monster.value)
    add_task_progress(8003032, monster.value)
    add_task_progress(8003033, monster.value)
  end
  if get_cur_room_id() == 800304 then
    add_task_progress(8003041, monster.value)
    add_task_progress(8003042, monster.value)
    add_task_progress(8003043, monster.value)
  end
  monster.base.on_self_npc_hp_zero(monster)
end

return monster
