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
  local skills = {
    skill01 = {
      2010280501,
      3,
      1,
      0,
      5
    }
  }
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nil)
  monster.states.attack.interval = 0.2
  replace_ragdoll_power_profile(monster.npc, 0)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.skill01)
    _ENV.wander(_ENV.stand)
  end
  do
    local stand = monster.states.stand
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
      lookat_npc(stand.monster.npc, stand.monster.target)
    end
  end
end

return monster
