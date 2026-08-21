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
      2010370601,
      5,
      1,
      0,
      1,
      -60,
      60
    },
    skill02 = {
      2010370602,
      8,
      2,
      0,
      1,
      -45,
      45
    },
    skill03 = {
      2010370603,
      12,
      8,
      3,
      10,
      -30,
      30
    },
    counterskill03 = {
      2010370601,
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
end

return monster
