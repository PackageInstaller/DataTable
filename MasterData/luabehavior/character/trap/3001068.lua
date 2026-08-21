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
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  local skills = {
    boom_expand = {300106801, 0},
    boom_delay = {300106802, 0},
    boom = {300106803, 0},
    boom2 = {300106803, 0},
    check = {300106804, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.check, _ENV.boom_expand(_ENV.boom), _ENV.boom_delay(_ENV.boom2))
    _ENV.wander(_ENV.wanderStand)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
  end
  
  function states.check.start(check)
    check.base.start(check)
    abort_magic_by_id(monster.npc, 399933)
  end
  
  function states.check.finTrans(check)
    return check
  end
  
  function states.boom_expand.start(boom_expand)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    boom_expand.base.start(boom_expand)
  end
  
  function states.boom.isReady()
    return true
  end
  
  function states.boom.finTrans(boom)
    return boom.monster.states.standIdle
  end
  
  function states.boom_delay.start(boom_delay)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    boom_delay.base.start(boom_delay)
  end
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.time = 2
  states.wander.tick = nil
  
  function states.standIdle.finTrans(standIdle)
    return standIdle.monster.states.standIdle
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 300106804 == skill_id and 5 ~= get_role_kind(hit_target) and 6 ~= get_role_kind(hit_target) and not check_magic(hit_target, 30010660103) then
    monster.tree:transState(monster.states.boom_expand, true)
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 1 == get_role_kind(target) then
    cast_magic(monster.npc, target, 40104409, 1)
  end
  if get_cur_room_id() == 104501 or get_cur_room_id() == 104401 then
    cast_magic(monster.npc, monster.npc, 40104414, 1)
    if 1 == get_role_kind(target) then
      cast_magic(monster.npc, target, 40104415, 1)
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type then
    monster.tree:transState(monster.states.boom_delay, true)
  end
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
