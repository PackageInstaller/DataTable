local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 2,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local counter_move = {
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    10,
    10,
    10,
    1,
    1
  }
  local skills = {
    skill01 = {
      2010370101,
      5,
      0,
      0,
      1,
      -60,
      60
    },
    skill02 = {
      2010370102,
      8,
      0,
      0,
      1,
      -45,
      45
    },
    skill03 = {
      2010370103,
      4,
      0,
      1,
      10,
      -45,
      45
    },
    counterskill03 = {
      2010370101,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      5,
      counter_move
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill02, _ENV.skill01)
    _ENV.rangedAtk(_ENV.skill03)
    _ENV.meleeCounter(_ENV.counterskill03)
  end
  do
    local skill02 = monster.states.skill02
    local skill03 = monster.states.skill03
    
    function skill02.isReady(skill)
      return check_magic(skill.monster.npc, 20104101002) and skill.base.isReady(skill02)
    end
    
    function skill03.isReady(skill)
      return check_magic(skill.monster.npc, 20104101002) and skill.base.isReady(skill03)
    end
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill02.cd = 4
  monster.states.skill03.cd = 4
  monster.states.skill01.cd = 2
  monster.states.attack.interval = 1
end

return monster
