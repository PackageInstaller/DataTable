local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 5,
    minTime = 1.5,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    Kick = {
      nil,
      6,
      2,
      0,
      5,
      -90,
      90
    },
    RunStart = {
      nil,
      20,
      8,
      0,
      15,
      -90,
      90
    },
    RunLoop = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHit = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitDriftLeft = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitDriftRight = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitStopLeft = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitStopRight = {
      nil,
      0,
      0,
      0,
      9999
    },
    RangeAttack = {
      nil,
      15,
      0,
      4,
      9
    },
    DoubleHit = {
      nil,
      5,
      1,
      0,
      6,
      -90,
      90
    },
    DrinkWaterStart = {
      nil,
      0,
      15,
      0,
      9999
    },
    DrinkWaterLoop = {
      nil,
      0,
      0,
      0,
      9999
    },
    DrinkWaterEnd = {
      nil,
      0,
      0,
      0,
      9999
    },
    DrinkWaterBreak = {
      nil,
      0,
      0,
      0,
      9999
    },
    Turnleft = {
      nil,
      0,
      0,
      0,
      9999
    },
    TurnRight = {
      nil,
      0,
      0,
      0,
      9999
    },
    stunStart = {
      nil,
      0,
      0,
      0,
      9999
    },
    stunLoop = {
      nil,
      0,
      0,
      0,
      9999
    },
    stunEnd = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitDrift = {
      nil,
      0,
      0,
      0,
      9999
    },
    DrinkWaterEnd2 = {
      nil,
      0,
      0,
      0,
      9999
    }
  }
  local nodes = {
    "turn",
    "baseMove",
    "drink"
  }
  local actMoves = {
    "stand",
    "moveToWater"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  monster.nightSwitch = true
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Kick, _ENV.DoubleHit)
    _ENV.rangedAtk(_ENV.RunStart(_ENV.RunLoop(_ENV.RunHit)))
    _ENV.RunHit(_ENV.RunHitDrift, _ENV.RunHitDriftLeft, _ENV.RunHitDriftRight, _ENV.RunHitStopLeft, _ENV.RunHitStopRight)
    _ENV.wander(_ENV.turn, _ENV.baseMove)
    _ENV.turn(_ENV.Turnleft, _ENV.TurnRight)
    _ENV.baseMove(_ENV.forward, _ENV.stand)
    _ENV.RunHitDriftLeft(_ENV.RunLoop)
    _ENV.RunHitDriftRight(_ENV.RunLoop)
  end
  do
    local idle = monster.states.idle
    local active = monster.states.active
    local gotTarget = monster.states.gotTarget
    
    function gotTarget.start(gotTarget)
      gotTarget.base.start(gotTarget)
      monster.idleSwitch = false
      set_can_searched(monster.npc, true)
      set_npc_hp_visible(gotTarget.monster.npc, true)
      gotTarget.monster.search.minDis = 8
      gotTarget.monster.search.maxDis = 30
      gotTarget.monster.nightSwitch = false
      if get_cur_room_id() == 104401 or get_cur_room_id() == 104501 then
        gotTarget.monster.search.minDis = 8
        gotTarget.monster.search.maxDis = 99
        gotTarget.monster.nightSwitch = false
      end
    end
  end
  do
    local Kick = monster.states.Kick
    
    function Kick.start(Kick)
      local npc = Kick.monster.npc
      if check_magic(npc, 2030440227) then
        cast_magic(npc, npc, 2030440225, 1)
      else
        cast_magic(npc, npc, 2010440118, 1)
      end
      Kick.base.start(Kick)
    end
  end
  do
    local wander = states.wander
    local forward = states.forward
    local turn = states.turn
    local baseMove = states.baseMove
    local stand = states.stand
    states.turn.turnCount = 0
    
    function wander.tickTrans(wander)
    end
    
    function baseMove.tickTrans(baseMove)
      local monster = baseMove.monster
      local states = monster.states
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if skill then
        return skill
      end
    end
    
    function turn.isReady(turn)
      local AngleToPlayer = get_target_angel(turn.monster.npc, turn.monster.target, true)
      if AngleToPlayer > 30 or AngleToPlayer < -30 then
        return true
      else
        return false
      end
    end
    
    function turn.start(turn)
      turn.turnCount = turn.turnCount + 1
      turn.base.start(turn)
    end
    
    turn.runStart = states.RunStart
    
    function turn.finTrans(turn)
      if turn.turnCount > 2 then
        turn.monster.skills.RunStart.timer = 0
        local runStart = turn.runStart
        runStart.isReadyBackUp = runStart.isReady
        runStart.isReady = Const.TURE_FUN
        return runStart
      else
        return turn.monster.states.wander
      end
    end
    
    function baseMove.isReady(baseMove)
      local AngleToPlayer = get_target_angel(turn.monster.npc, turn.monster.target, true)
      if AngleToPlayer <= 30 and AngleToPlayer >= -30 then
        return true
      end
    end
    
    function forward.isReady(forward)
      local monster = forward.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      return distance > monster.wander.maxDis
    end
    
    function forward.tickTrans(forward)
      local distance = get_npc_distance(forward.monster.npc, 1, forward.monster.target, true)
      if distance < forward.monster.wander.maxDis then
        return forward.monster.states.wander
      end
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
    
    function stand.tickTrans(stand)
      local AngleToPlayer = get_target_angel(stand.monster.npc, stand.monster.target, true)
      if AngleToPlayer > 30 or AngleToPlayer < -30 then
        return stand.monster.states.wander
      end
    end
  end
  do
    local curDashCount = 0
    local maxDashCount = 2
    
    function states.RunStart.start(RunStart)
      RunStart.isReady = RunStart.isReadyBackUp
      RunStart.monster.states.turn.turnCount = 0
      curDashCount = 0
      maxDashCount = 4
      RunStart.base.start(RunStart)
    end
    
    function states.RunLoop.start(RunLoop)
      curDashCount = curDashCount + 1
      RunLoop.base.start(RunLoop)
    end
    
    function states.RunHitDrift.isReady(RunHitDrift)
      local AngleToPlayer = get_target_angel(RunHitDrift.monster.npc, RunHitDrift.monster.target, true)
      if AngleToPlayer < 30 and AngleToPlayer > -30 then
        return true
      end
    end
    
    function states.RunHitDrift.finTrans(RunHitDrift)
      return RunHitDrift.monster.states.wander
    end
    
    function states.RunHitDriftLeft.isReady(RunHitDriftLeft)
      local AngleToPlayer = get_target_angel(RunHitDriftLeft.monster.npc, RunHitDriftLeft.monster.target, true)
      if AngleToPlayer < -30 and AngleToPlayer > -180 and curDashCount < maxDashCount then
        return true
      end
    end
    
    function states.RunHitDriftRight.isReady(RunHitDriftRight)
      local AngleToPlayer = get_target_angel(RunHitDriftRight.monster.npc, RunHitDriftRight.monster.target, true)
      if AngleToPlayer > 30 and AngleToPlayer < 180 and curDashCount < maxDashCount then
        return true
      end
    end
    
    function states.RunHitStopLeft.isReady(RunHitStopLeft)
      local AngleToPlayer = get_target_angel(RunHitStopLeft.monster.npc, RunHitStopLeft.monster.target, true)
      if AngleToPlayer < -30 and AngleToPlayer > -180 and curDashCount == maxDashCount then
        return true
      end
    end
    
    function states.RunHitStopRight.isReady(RunHitStopRight)
      local AngleToPlayer = get_target_angel(RunHitStopRight.monster.npc, RunHitStopRight.monster.target, true)
      if AngleToPlayer > 30 and AngleToPlayer < 180 and curDashCount == maxDashCount then
        return true
      end
    end
  end
  set_hud_config("warning", {
    Prefab = "UI_Hud10",
    Fore = "UIFight/20240227/battle_bg_jjjdd",
    Back = "UIFight/20240227/battle_bg_jjjdt"
  }, 2, 3, 6)
  set_hud_config("warning2", {
    Prefab = "UI_Hud11",
    Fore = "UIFight/20240227/battle_bg_jjjdd",
    Back = "UIFight/20240227/battle_bg_jjjdt"
  }, 2, 3, 6)
  do
    local HudSwitch = true
    monster.crystal = monster.crystal or {}
    monster.idleSwitch = true
    local noTarget = monster.states.noTarget
    local idle = monster.states.idle
    local Memory = monster.crystal
    monster.WarningDis = {
      3,
      9,
      1,
      4
    }
    monster.sneak = true == get_sync_var("qian_night") or true == get_sync_var("qian_dark")
    
    function idle.finish()
      if get_sync_var("qian_night") == true and not check_magic(monster.npc, 40104404) then
        active_hud(monster.npc, "warning", "attachpoint", false, nil)
        active_hud(monster.npc, "warning2", "attachpoint", true, nil)
        cast_magic(monster.npc, monster.npc, 2030430115)
        abort_magic_by_id(monster.npc, 2030430114, 99)
        
        local function delay()
          active_hud(monster.npc, "warning2", "attachpoint", false, nil)
        end
        
        monster:doAfter(delay, 1.5)
      end
      if (get_sync_var("qian_night") == true or true == get_sync_var("qian_dark")) and not check_magic(monster.npc, 40104404) then
        cast_missile3(monster.npc, monster.npc, nil, nil, 30010220103, 1)
      end
    end
    
    function idle.start(idle)
      idle.time = 3
      idle.cd = 8
      abort_skill(monster.npc, false)
      stop_move(idle.monster.npc)
    end
    
    function idle.tick(idle)
      if not monster.sneak then
        return
      end
      if not monster.crystal then
        return
      end
      if not monster.idleSwitch then
        return
      end
      if check_magic(monster.npc, 40104404) then
        return
      end
      if get_sync_var("qian_night") == true then
        local distance = get_npc_distance(monster.npc, 1, get_come_on_hero(), false)
        if get_npc_attr(monster.npc, 3) >= 99 then
          monster.search.minDis = 5
          monster.search.maxDis = 12
        end
        if distance <= monster.WarningDis[2] then
          if not check_magic(monster.npc, 2030430114) then
            cast_magic(monster.npc, monster.npc, 2030430114, 1)
          end
        else
          abort_magic_by_id(monster.npc, 2030430114, 1)
        end
        if distance < monster.WarningDis[1] then
          if not check_magic(monster.npc, 2030430112) then
            lookat_npc(monster.npc, get_come_on_hero(), false)
            cast_magic(monster.npc, monster.npc, 2030430112, 1)
          end
        elseif not check_magic(monster.npc, 2030430113) and get_npc_attr(monster.npc, 3) > 1 then
          cast_magic(monster.npc, monster.npc, 2030430113)
        end
        if get_npc_attr(monster.npc, 3) > 1 and true == HudSwitch then
          HudSwitch = false
          active_hud(monster.npc, "warning", "attachpoint", true, nil)
        elseif get_npc_attr(monster.npc, 3) < 1 and false == HudSwitch then
          HudSwitch = true
          active_hud(monster.npc, "warning", "attachpoint", false, nil)
        end
      end
      if Memory ~= monster.crystal and true == monster.crystal.permission then
        Memory = monster.crystal
        local selfpos = get_npc_pos(monster.npc)
        local tar_pos = get_position_offset_position(monster.crystal.Selfpos, selfpos, math.random() * 90 - 45, 1 * math.random())
        monster:idlemove(tar_pos)
      end
    end
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_npc_group_id(monster.npc) == 10410221 then
    monster.search.minDis = 2
    monster.search.maxDis = 5
  end
  if get_sync_var("qian_night") == true then
    set_can_searched(monster.npc, false)
    monster.search.minDis = monster.WarningDis[3]
    monster.search.maxDis = monster.WarningDis[3]
    cast_magic(monster.npc, monster.npc, 2030430111)
  end
  if true == get_sync_var("qian_dark") then
    monster.search.minDis = monster.WarningDis[4]
    monster.search.maxDis = monster.WarningDis[4]
  end
  if true == get_sync_var("nightSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
  if true == get_sync_var("darkSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 40104404 == magic_id then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

function monster.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  monster.base.on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  local switch = check_npc_distance(monster.npc, get_come_on_hero(), monster.WarningDis[1], true)
  if 2030430112 == magic_id and monster.state.name == "idle" and get_npc_attr(monster.npc, 3) <= 100 and switch then
    cast_magic(monster.npc, monster.npc, magic_id)
  end
  if 2030430113 == magic_id and monster.state.name == "idle" and get_npc_attr(monster.npc, 3) > 0 and not switch then
    cast_magic(monster.npc, monster.npc, magic_id)
  end
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not monster.sneak then
    return
  end
  if monster.state.name == "idle" then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

function monster.idlemove(monster, pos)
  local idle = monster.states.idle
  idle.time = get_npc_time(idle.monster.npc) + idle.cd
  lookat_position(monster.npc, pos.x, pos.z, false)
  
  local function delay()
    cast_magic(monster.npc, monster.npc, 2010440105, 1)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, pos)
  end
  
  monster:doAfter(delay, 0.5)
end

function monster.idleturn(monster, pos)
  local idle = monster.states.idle
  idle.time = get_npc_time(idle.monster.npc) + idle.cd
  lookat_position(monster.npc, pos.x, pos.z, false)
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010220103 and monster.state.name == "idle" then
    local function delay()
      monster.search.minDis = 8
      
      monster.search.maxDis = 30
    end
    
    monster:doAfter(delay, 0.5)
  end
end

return monster
