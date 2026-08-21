local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010120115
  local skills = {
    skill01 = {
      2010120101,
      5,
      0,
      0,
      3,
      -60,
      60
    },
    skill02 = {
      2010120102,
      0,
      0,
      0,
      99
    },
    skill03 = {
      2010120103,
      0,
      0,
      0,
      4,
      -60,
      60
    },
    skill04 = {
      2010120104,
      10,
      5 + 8 * math.random(),
      1,
      8,
      -60,
      60
    },
    skill05 = {
      2010120105,
      24,
      25,
      0,
      6
    },
    skill06 = {
      2010120117,
      0,
      0,
      0,
      99
    },
    skill07 = {
      2010120107,
      0,
      0,
      0,
      99
    },
    skill08 = {
      2010120112,
      99,
      0,
      0,
      99
    },
    skill09 = {
      2010120113,
      5,
      0,
      0,
      3,
      -60,
      60
    }
  }
  local nodes = {
    "ATK",
    "Smash",
    "Rotate",
    "Broke",
    "ATK2"
  }
  monstBase._init(monster, skills, nil, nodes)
  monster.states.attack.interval = 3
  monster.broken = false
  monster.destroy = false
  monster.attacking = false
  monster.hit = 0
  monster.Rotate_counter = 0
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Broke, _ENV.attack, _ENV.wander)
    _ENV.rangedAtk(_ENV.Rotate, _ENV.Smash)
    _ENV.meleeAtk(_ENV.ATK, _ENV.ATK2)
    _ENV.Rotate(_ENV.skill05(_ENV.skill06(_ENV.skill07)))
    _ENV.ATK(_ENV.skill01(_ENV.skill02(_ENV.skill03)))
    _ENV.ATK2(_ENV.skill09)
    _ENV.Smash(_ENV.skill04)
    _ENV.Broke(_ENV.skill08)
  end
  do
    local active = monster.states.active
    local skill02 = monster.states.skill02
    local skill03 = monster.states.skill03
    
    function skill02.moveScale()
      return 1.4
    end
    
    function skill03.moveScale()
      return 1.4
    end
    
    function active.start(active)
      cast_magic(active.monster.npc, active.monster.npc, 500100103, 1)
      active.monster:xRay()
    end
  end
  do
    local skill01 = monster.states.skill01
    local skill02 = monster.states.skill02
    local skill03 = monster.states.skill03
    
    function skill01.finish(skill01)
      skill01.base.finish(skill01)
      skill01.monster.Rotate_counter = skill01.monster.Rotate_counter + 1
    end
    
    function skill02.finish(skill)
      skill02.base.finish(skill02)
      skill.monster.Rotate_counter = skill.monster.Rotate_counter + 1
    end
    
    function skill03.finish(skill03)
      skill03.base.finish(skill03)
      skill03.monster.Rotate_counter = skill03.monster.Rotate_counter + 1
    end
  end
  do
    local Broke = monster.states.Broke
    local ATK2 = monster.states.ATK2
    local ATK = monster.states.ATK
    local Rotate = monster.states.Rotate
    local skill08 = monster.states.skill08
    Broke.isReady = Const.FALSE_FUN
    ATK2.isReady = Const.FALSE_FUN
    
    function Broke.finish(Broke)
      Broke.isReady = Const.FALSE_FUN
      ATK2.isReady = Const.TURE_FUN
      ATK.isReady = Const.FALSE_FUN
      Rotate.isReady = Const.FALSE_FUN
      cast_magic(monster.npc, monster.npc, 1999234, 1)
      cast_magic(monster.npc, monster.npc, 1999238, 1)
      cast_magic(monster.npc, monster.npc, 1999242, 1)
    end
    
    function skill08.finTrans(skill08)
      return monster.states.wander
    end
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  monster.base.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 1999219 == magic_id then
    abort_magic_by_id(monster.npc, 20101201038)
  end
end

function monster.on_red_skill_countered_fx(monster, attackerNpc, missile)
  local monster_kind = get_role_kind(monster.npc)
  if 4 ~= monster_kind then
    cast_magic(attackerNpc, attackerNpc, 1999351)
  else
    cast_magic(attackerNpc, attackerNpc, 1999352)
  end
  abort_magic_by_id(monster.npc, 20101201038, 99)
  cast_magic(attackerNpc, monster.npc, 1999242)
  cast_magic(attackerNpc, monster.npc, 1999261)
  cast_magic(attackerNpc, monster.npc, 1999219)
  cast_magic(attackerNpc, monster.npc, 1999221)
  cast_magic(attackerNpc, monster.npc, 1999222)
  cast_magic(attackerNpc, monster.npc, 1999285)
  cast_magic(attackerNpc, monster.npc, 1999347)
  cast_magic(attackerNpc, attackerNpc, 20102501924, 1)
  local isKilled = get_missile_kill_role_count(monster.npc, missile) > 0
  if not isKilled then
    abort_skill(monster.npc, false)
    local states = monster.states
    local ATK2 = states.ATK2
    local ATK = states.ATK
    local Rotate = states.Rotate
    local Broke = states.Broke
    ATK2.isReady = Const.TURE_FUN
    ATK.isReady = Const.FALSE_FUN
    Rotate.isReady = Const.FALSE_FUN
    Broke.isReady = Const.TURE_FUN
    monster.tree:transState(monster.states.Broke)
  end
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.skill05.cd = 10
  monster.states.attack.interval = 1
  local _ENV = monster.states
  _ENV.freeAtk(_ENV.Rotate)
  _ENV.rangedAtk(_ENV.Smash)
end

return monster
