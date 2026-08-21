local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 1.5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    redSkill = {
      2010290901,
      5,
      2,
      0,
      2,
      -60,
      60
    }
  }
  monstBase._init(monster, skills, nil, nil)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.redSkill)
  end
end

return monster
