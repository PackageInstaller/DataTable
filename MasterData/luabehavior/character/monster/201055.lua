local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 20105501
  local skills = {
    skill01 = {
      20105502,
      0,
      0
    }
  }
  local nodes = {}
  local actMoves = {
    "MoveToTarget",
    "Stop"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  monster.BoomTimer = 0
  monster.Type = false
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.MoveToTarget, _ENV.skill01)
    _ENV.wander(_ENV.Stop)
  end
  do
    local Stop = monster.states.Stop
    
    function Stop.isReady()
      return true
    end
    
    function Stop.start(Stop)
      stop_move(monster.npc)
    end
  end
  do
    local skill01 = monster.states.skill01
    local MoveToTarget = monster.states.MoveToTarget
    skill01.isReady = Const.FALSE_FUN
    
    function MoveToTarget.start(MoveToTarget)
      monster.BoomTimer = get_npc_time(monster.npc) + 6
      local monster = MoveToTarget.monster
      if not check_magic(monster.npc, 201055007) then
        cast_magic(monster.npc, monster.npc, 201055007, 1)
      end
      switch_move_type(monster.npc, 0)
      moveto_npc(monster.npc, monster.target)
    end
    
    function MoveToTarget.tick(MoveToTarget)
      if not monster.target then
        monster.tree:transState(skill01, true)
      elseif check_npc_distance(monster.npc, monster.target, 2, false) or get_npc_time(monster.npc) > monster.BoomTimer then
        monster.tree:transState(skill01, true)
      end
    end
    
    function skill01.start(skill01)
      skill01.monster.Type = true
      skill01.base.start(skill01)
    end
  end
end

function monster.on_start(monster)
  cast_magic(monster.npc, monster.npc, 201055009, 1)
  cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
  cast_magic(monster.npc, monster.npc, 201055003, 1)
  cast_magic(monster.npc, monster.npc, 201055004, 1)
end

function monster.on_self_npc_hp_zero(monster)
  if monster.Type == false then
    monster.tree:transState(monster.states.skill01, true)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 201055001 == magic_id then
    set_npc_dead(monster.npc, nil, true)
    remove_npc(monster.npc)
  end
end

return monster
