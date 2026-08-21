local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
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

function monster.on_start(monster)
  monster:xRay()
  monster.LHand_npc = create_part_npc(20105403, monster.npc, "L_part", 1, 2)
  monster.RHand_npc = create_part_npc(20105403, monster.npc, "R_part", 2, 2)
  enable_part_damage(monster.npc, 1, true)
  enable_part_damage(monster.npc, 2, true)
end

return monster
