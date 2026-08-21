local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  local skills = {
    laser = {315010301, 0},
    broken = {315010102, 0},
    broken_forever = {315010103, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  cast_magic(npc, npc, 399001, 0)
  cast_magic(npc, npc, 4032905, 1)
  abort_magic_by_id(monster.npc, 399933)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.laser, _ENV.broken, _ENV.broken_forever, _ENV.wander)
    _ENV.wander(_ENV.wanderStand(_ENV.standIdle))
    _ENV.attack(_ENV.laser)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.broken, _ENV.broken_forever, _ENV.wander)
    _ENV.wander(_ENV.wanderStand(_ENV.standIdle))
  end
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.timer = 0
  states.standIdle.time = 10
  
  function states.standIdle.start(standIdle)
    standIdle.timer = get_npc_time(monster.npc) + standIdle.time
  end
  
  function states.standIdle.tick(standIdle)
    lookat_npc(monster.npc, monster.target, false)
    standIdle.base.tick(standIdle)
  end
  
  function states.broken.isReady()
    return false
  end
  
  function states.broken.start(broken)
    monster:setTarget()
    
    function monster.states.broken.isReady()
      return false
    end
    
    cast_magic(monster.npc, monster.npc, 399933, 1)
    broken.base.start(broken)
  end
  
  function states.broken.finish()
    abort_magic_by_id(monster.npc, 399933)
  end
  
  function states.broken.finTrans(broken)
    return broken.monster.states.laser
  end
  
  function states.broken_forever.isReady()
    return false
  end
  
  function states.broken_forever.start(broken_forever)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    broken_forever.base.start(broken_forever)
  end
  
  function states.broken_forever.finTrans(broken_forever)
    return broken_forever
  end
  
  function states.laser.finTrans(laser)
    return laser
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type then
    abort_skill(monster.npc)
    
    function monster.states.broken.isReady()
      return true
    end
    
    monster.tree:transState(monster.states.broken, true)
  end
end

function monster.on_room_pass(monster, room_id)
  abort_skill(monster.npc)
  monster.tree:transState(monster.states.broken_forever, true)
  
  function monster.states.wander.tickTrans()
    return
  end
end

return monster
