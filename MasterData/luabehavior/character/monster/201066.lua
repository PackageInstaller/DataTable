local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.born = 2010150103
  local skills = {}
  local actMoves = {"idle2"}
  monstBase._init(monster, skills, actMoves, nil)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.idle2)
  end
  
  function monster.states.idle2.start(idle2)
    stop_move(idle2.monster.npc)
  end
end

return monster
