local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.born = 2010080101
  local skills = {}
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.stand)
  end
  
  function monster.states.stand.start(stand)
    stop_move(stand.monster.npc)
  end
  
  do
    local dead = monster.states.dead
    dead.delay = {fx = 1.2, remove = 2}
  end
end

return monster
