local monstBase = import("character.base.monster_base")
local Monst = Util.create_child_mt(monstBase)

function Monst._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010150103
  monster.can_Henshin = true
  local t = monster.create_skill_node_cfg
  local skills = {
    ATK1 = t(2010150102, 7, 3, 0, 4, -45, 45),
    ATK2 = t(2010150101, 5, 1.5, 0, 2, -45, 45),
    counterAtk1 = t(2010150102, 0, 0, 0, 4, nil, nil, nil, 5, 2)
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.ATK1, _ENV.ATK2)
  end
end

function Monst.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.ATK1.cd = 2
  monster.states.ATK2.cd = 2
  monster.wander.maxDis = 2.5
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
  
  function monster.states.ATK1.moveScale()
    return monster.calculate_moveScale(monster)
  end
  
  local _ENV = monster.states
  _ENV.meleeCounter(_ENV.counterAtk1)
end

function Monst.calculate_moveScale(monster)
  local target = monster.target
  local Distance = get_npc_distance(monster.npc, 1, target, false)
  local Scale = Distance / 3
  return Scale
end

return Monst
