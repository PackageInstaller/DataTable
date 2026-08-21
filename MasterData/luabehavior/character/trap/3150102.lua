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
    laser = {315010201, 0},
    laser_ready = {315010202, 0},
    broken = {315010102, 0},
    broken_forever = {315010103, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  cast_magic(npc, npc, 399001, 0)
  abort_magic_by_id(monster.npc, 399933)
  cast_magic(npc, npc, 4032905, 1)
  monster.skillDelay = 0
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.laser_ready(_ENV.laser))
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander, _ENV.broken, _ENV.broken_forever)
    _ENV.wander(_ENV.wanderStand(_ENV.standIdle))
  end
  
  function states.broken.isReady()
    return false
  end
  
  function states.broken.start(broken)
    function monster.states.broken.isReady()
      return false
    end
    
    cast_magic(monster.npc, monster.npc, 399933, 1)
    broken.base.start(broken)
  end
  
  function states.broken.finish(broken)
    local monster = broken.monster
    abort_magic_by_id(monster.npc, 399933)
  end
  
  function states.broken.finTrans(broken)
    return broken.monster.states.laser_ready
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
  if 0 ~= hit_type and string.sub(get_npc_id(attacker), 1, 5) ~= "31501" then
    abort_skill(monster.npc)
    
    function monster.states.broken.isReady()
      return true
    end
    
    monster.tree:transState(monster.states.broken, true)
  end
end

function monster.on_room_pass(monster, room_id)
  if get_cur_room_id() == 3150104 then
    return
  end
  abort_skill(monster.npc)
  monster.tree:transState(monster.states.broken_forever, true)
  
  function monster.states.wander.tickTrans()
    return
  end
end

function monster.on_born_behavior(monster)
  if get_cur_room_id() == 3150102 or get_cur_room_id() == 3150104 then
    monster.tree:transState(monster.states.broken_forever, true)
  end
end

function monster.on_enter_area(monster, npc, area)
  if (get_cur_room_id() == 3150102 or get_cur_room_id() == 3150104) and area.Key == "trapTrigger" and npc == get_come_on_hero() then
    monster.skillDelay = get_sync_var("skillDelay")
    
    local function delay()
      abort_skill(npc)
      abort_magic_by_id(npc, 399933, 1)
      monster.tree:transState(monster.states.laser_ready, true)
    end
    
    monster:doAfter(delay, monster.skillDelay)
  end
end

return monster
