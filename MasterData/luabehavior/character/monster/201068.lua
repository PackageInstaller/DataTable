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
  monster.born = 2010150103
  local skills = {
    ATK1 = {
      2010150102,
      7,
      3,
      0,
      4,
      -45,
      45
    },
    ATK2 = {
      2010150101,
      5,
      1.5,
      0,
      2,
      -45,
      45
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.ATK1, _ENV.ATK2)
  end
end

return monster
