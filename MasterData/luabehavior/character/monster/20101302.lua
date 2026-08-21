local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 8,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010130116
  local skills = {
    Atk1 = {
      2010130101,
      5,
      1,
      0,
      3,
      -45,
      45
    },
    Atk2 = {
      2010130202,
      0,
      0,
      0,
      8
    }
  }
  local nodes = {
    "ATK",
    "Call_son",
    "Shield"
  }
  monstBase._init(monster, skills, nil, nil, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.ATK)
    _ENV.ATK(_ENV.Atk1(_ENV.Atk2))
  end
end

function monster.on_start(monster)
  monster:xRay()
  monster.base.on_start(monster)
end

return monster
