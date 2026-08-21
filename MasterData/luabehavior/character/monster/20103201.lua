local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    Atk1 = {
      2010320101,
      5,
      1,
      0,
      4,
      -60,
      60
    },
    Atk2 = {
      2010320102,
      8,
      3,
      1,
      7,
      -60,
      60
    },
    counterAtk2 = {
      2010320102,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      3,
      0.6
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Atk1)
    _ENV.rangedAtk(_ENV.Atk2)
    _ENV.meleeCounter(_ENV.counterAtk2)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.Atk1.cd = 2
  monster.states.Atk2.cd = 4
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

return monster
