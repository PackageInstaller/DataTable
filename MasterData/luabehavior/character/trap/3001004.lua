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
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  local skills = {
    fireball_ready = {
      300100401,
      3,
      0,
      0,
      4.5
    },
    fireball = {
      300100402,
      0,
      0
    }
  }
  monstBase._init(monster, skills)
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.fireball_ready(_ENV.fireball))
    _ENV.wander(_ENV.wanderStand)
  end
  local states = monster.states
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.time = 2
end

return monster
