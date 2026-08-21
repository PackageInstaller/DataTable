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
    atk1 = {300203102, 0},
    atk2 = {300203103, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 0)
  abort_magic_by_id(monster.npc, 399933)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.atk1, _ENV.atk2)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
    _ENV.wander(_ENV.stand)
  end
  
  function states.stand.start()
    stop_move(npc)
  end
  
  function monster.states.wander.tickTrans()
    return
  end
  
  function states.atk1.finTrans(atk1)
    return atk1
  end
  
  function states.atk1.tickTrans(atk1)
    if get_sync_var("phase_change") == true then
      set_sync_var("phase_change", false)
      return atk1.monster.states.atk2
    end
  end
  
  function states.atk2.tickTrans(atk2)
    if get_sync_var("phase_change") == true then
      set_sync_var("phase_change", false)
      return atk2.monster.states.stand
    end
  end
  
  function states.atk2.finTrans(atk2)
    return atk2
  end
end

function monster.on_room_pass(monster, room_id)
  abort_skill(monster.npc)
  monster.tree:transState(monster.states.stand, true)
  
  function monster.states.wander.tickTrans()
    return
  end
end

return monster
