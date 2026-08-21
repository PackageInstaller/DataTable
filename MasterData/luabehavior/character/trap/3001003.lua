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
  monster.search = {}
  local skills = {
    boom_alarm = {300100301, 0},
    boom = {300100302, 0}
  }
  monstBase._init(monster, skills)
  enable_shadow(npc, false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 4032905, 1)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.boom_alarm(_ENV.boom))
    _ENV.wander(_ENV.wanderStand)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
  end
  local states = monster.states
  
  function states.standIdle.isReady()
    return true
  end
  
  function states.wander.isReady()
    return true
  end
  
  states.standIdle.time = 2
  
  function states.boom_alarm.start(boom_alarm)
    cast_magic(npc, npc, 399931, 1)
    cast_magic(npc, npc, 399932, 1)
    cast_magic(npc, npc, 399933, 1)
    set_can_searched(npc, false)
    
    function states.boom_alarm.isReady()
      return false
    end
    
    boom_alarm.base.start(boom_alarm)
  end
  
  function states.boom_alarm.finTrans(boom_alarm)
    return boom_alarm.monster.states.boom
  end
  
  function states.boom_alarm.isReady()
    return false
  end
  
  function states.boom.finish(boom)
  end
  
  function states.boom.start(boom)
    cast_magic(npc, npc, 3001022003, 1)
    
    local function delay()
      abort_magic_by_id(npc, 399931)
      abort_magic_by_id(npc, 399932)
      abort_magic_by_id(npc, 399933)
      cast_magic(npc, npc, 3001022004, 1)
      set_can_searched(npc, true)
    end
    
    monster:doAfter(delay, 16.3)
    boom.base.start(boom)
  end
  
  function states.boom.finTrans(boom)
    return boom.monster.states.wander
  end
  
  function states.boom.isReady()
    return true
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  function monster.states.boom_alarm.isReady()
    return true
  end
  
  monster.tree:transState(monster.states.boom_alarm, true)
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
