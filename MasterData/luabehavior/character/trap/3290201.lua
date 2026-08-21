local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 4032905, 1)
  local actSkills = {
    stand = {329020101},
    stung = {323010101}
  }
  local actMoves = {"stand", "stung"}
  local nodes = {"nothing", "hitten"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.root(_ENV.nothing, _ENV.hitten, _ENV.decisionFailed)
    _ENV.nothing(_ENV.stand)
    _ENV.hitten(_ENV.stung)
  end
  
  function states.stand.start(stand)
    local monster = stand.monster
    stand.base.start(stand)
  end
  
  function states.stand.finTrans(stand)
    return states.stand
  end
  
  function states.stung.start(stung)
    local monster = stung.monster
    stung.base.start(stung)
  end
  
  states.stung.stand = states.stand
  
  function states.stung.finTrans(stung)
    return stung.stand
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  monster:transState(monster.states.stung, true)
end

return monster
