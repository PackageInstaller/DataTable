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
  monster.born = 2010140103
  monster.testmissile = nil
  monster.can_Henshin = true
  local skills = {
    ATK1 = {
      2010140101,
      7,
      3,
      2,
      5,
      -60,
      60
    },
    ATK2 = {
      2010140102,
      5,
      1.5,
      0,
      2,
      -60,
      60
    },
    counterAtk1 = {
      2010140101,
      0,
      0,
      0,
      5,
      nil,
      nil,
      nil,
      0,
      1
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.ATK2)
    _ENV.rangedAtk(_ENV.ATK1)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.ATK1.cd = 3
  monster.states.ATK2.cd = 2
  monster.wander.maxDis = 2.5
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
  local _ENV = monster.states
  _ENV.rangedCounter(_ENV.counterAtk1)
end

return monster
