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
  local skills = {
    TrebleHit = {
      2020550101,
      15,
      0,
      0,
      6,
      -60,
      60
    },
    Before_hack = {
      2020550102,
      10,
      7,
      0,
      5,
      -60,
      60
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.TrebleHit, _ENV.Before_hack)
  end
  local states = monster.states
end

return monster
