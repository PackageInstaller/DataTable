local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = -1,
    maxDis = 10,
    minTime = 1,
    maxTime = 3,
    type = "walk"
  }
  local skills = {
    Bite_A = {
      2010490106,
      5,
      3,
      0,
      1.5,
      -90,
      90
    },
    Bite_B = {
      2010490101,
      0,
      0,
      0,
      2
    },
    tailattack_A = {
      2010490102,
      8,
      3,
      0,
      2.5,
      -60,
      60
    },
    tailattack_B = {
      2010490102,
      4,
      1,
      0,
      1.5,
      -60,
      60
    },
    jumpout_A = {
      2010490103,
      4,
      1,
      0,
      2.5,
      -90,
      90
    },
    jumpout_B = {
      2010490103,
      10,
      1,
      0,
      2,
      -90,
      90
    },
    spitting_A = {
      2010490104,
      8,
      3,
      2,
      10,
      -60,
      60
    },
    spitting_B = {
      2010490104,
      12,
      5,
      1,
      10,
      -60,
      60
    },
    show = {
      2010490105,
      0,
      0,
      0,
      99
    }
  }
  local nodes = {"stand", "Bite"}
  local actMoves = {
    "MoveToTarget"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  local god = get_god_npc()
  if not check_magic(god, 3001064000) then
    cast_magic(npc, god, 3001064000, 1)
  end
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Bite, _ENV.attack, _ENV.wander)
    _ENV.freeAtk(_ENV.jumpout_A)
    _ENV.rangedAtk(_ENV.spitting_A)
    _ENV.meleeAtk(_ENV.tailattack_A, _ENV.Bite_A)
    _ENV.Bite(_ENV.MoveToTarget, _ENV.Bite_B)
    _ENV.backward(_ENV.stand)
  end
  do
    local stand = monster.states.stand
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
      lookat_npc(stand.monster.npc, stand.monster.target)
    end
  end
  do
    local jumpout_A = monster.states.jumpout_A
    local Bite = monster.states.Bite
    local MoveToTarget = monster.states.MoveToTarget
    local Bite_B = monster.states.Bite_B
    monster.states.attack.interval = 1.5
    jumpout_A.num = 0
    
    function Bite.isReady(Bite)
      return false
    end
    
    function Bite.start(Bite)
      Bite.isReady = Const.FALSE_FUN
    end
    
    function Bite.finTrans(Bite)
      return monster.states.wander
    end
    
    function MoveToTarget.start(MoveToTarget)
      if not check_magic(monster.npc, 20104101001) then
        cast_magic(monster.npc, monster.npc, 20104101001, 1)
      end
      cast_magic(monster.npc, monster.npc, 201049010104, 1)
      moveto_npc(monster.npc, monster.target)
      switch_move_type(monster.npc, 1)
    end
    
    function MoveToTarget.tickTrans(MoveToTarget)
      if Bite_B.isReady(Bite_B) then
        return Bite_B
      end
    end
    
    function Bite_B.finish(Bite_B)
      Bite.isReady = Const.FALSE_FUN
      monster.states.spitting_A.timer = get_npc_time(monster.npc) + 4
      monster.tree:transState(monster.states.jumpout_A, true)
    end
    
    function jumpout_A.finTrans()
      return monster.states.wander
    end
    
    function jumpout_A.moveScale()
      return monster.Movescale(monster)
    end
  end
  do
    local wander = monster.states.wander
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      if not monster.target then
        return states.noTarget
      end
      if states.Bite.isReady(states.Bite) then
        return states.Bite
      end
      if states.jumpout_A.isReady(states.jumpout_A) then
        if states.tailattack_A.isReady(states.tailattack_A) then
          return states.tailattack_A
        else
          return states.jumpout_A
        end
      end
      if states.attack then
        return monster.tree:chooseChildAction(states.attack)
      end
    end
  end
  do
    local Bite_A = monster.states.Bite_A
    local spitting_A = monster.states.spitting_A
    local Bite = monster.states.Bite
    
    function spitting_A.tickTrans(spitting_A)
      if Bite.isReady(Bite) then
        return Bite
      end
    end
    
    function Bite_A.tickTrans()
      if check_magic(monster.npc, 201049010108) then
        abort_skill(monster.npc)
        return monster.states.wander
      end
    end
  end
  do
    local gotTarget = monster.states.gotTarget
    local idle = monster.states.idle
    
    function gotTarget.tick(gotTarget)
      if monster.target and get_magic_num(monster.target, 3001064002) > 4 then
        monster.states.Bite.isReady = Const.TURE_FUN
      end
    end
    
    function idle.finish(idle)
      idle.monster.search.minDis = 8
      idle.monster.search.maxDis = 99
    end
  end
end

function monster.on_target_self_skill_hit(monster, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 2010490104 == skill_id then
    monster.states.Bite.isReady = Const.TURE_FUN
  end
  if 300106301 == skill_id then
    cast_magic(monster.npc, monster.npc, 201051010207, 1)
  end
end

function monster.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  monster.base.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  if 2010490103 == skill_id then
    abort_magic_by_id(monster.npc, 201049010104, 5)
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_sync_var("qian_dark") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

function monster.Movescale(monster)
  local dis = get_npc_distance(monster.npc, 3, 3, false)
  if dis < 3.5 then
    return dis / 5
  else
    return 1
  end
end

return monster
