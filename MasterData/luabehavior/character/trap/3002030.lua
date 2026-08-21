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
    atk1 = {300203001, 0},
    atk2 = {300203002, 0},
    atk3 = {300203004, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 0)
  abort_magic_by_id(monster.npc, 399933)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.atk1, _ENV.atk2, _ENV.atk3)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
    _ENV.wander(_ENV.stand)
  end
  monster.phase1_max = 5
  monster.phase2_max = 44
  monster.phase3_max = 4
  monster.phase1 = 0
  monster.phase2 = 0
  monster.phase3 = 0
  monster.phase3_dir = true
  
  function states.stand.start()
    stop_move(npc)
  end
  
  function monster.states.wander.tickTrans()
    return
  end
  
  function states.atk1.start(atk1)
    monster.phase1 = monster.phase1 + 1
    atk1.base.start(atk1)
  end
  
  function states.atk1.finTrans(atk1)
    if monster.phase1 >= monster.phase1_max then
      return atk1.monster.states.atk2
    else
      return atk1
    end
  end
  
  function states.attack.tickTrans()
    return
  end
  
  function states.atk2.start(atk2)
    monster.phase2 = monster.phase2 + 1
    atk2.base.start(atk2)
  end
  
  function states.atk2.finTrans(atk2)
    if monster.phase2 >= monster.phase2_max then
      return atk2.monster.states.atk3
    else
      return atk2
    end
  end
  
  function states.atk3.start(atk3)
    monster.phase3 = monster.phase3 + 1
    if monster.phase3_dir then
      set_npc_target_dir(monster.npc, 0, 1)
      monster.phase3_dir = false
    else
      set_npc_target_dir(monster.npc, 30, 1)
      monster.phase3_dir = true
    end
    atk3.base.start(atk3)
  end
  
  function states.atk3.finTrans(atk3)
    if monster.phase3 >= monster.phase3_max then
      return atk3.monster.states.stand
    else
      return atk3
    end
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
