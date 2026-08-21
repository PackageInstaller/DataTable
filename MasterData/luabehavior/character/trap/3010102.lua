local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  set_npc_ignore_sync_area(npc, false)
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
  local skills = {}
  local nodes = {}
  local actMoves = {"move", "stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  local X1 = {
    x = 79,
    y = 0,
    z = -178
  }
  local X2 = {
    x = 92,
    y = 0,
    z = -178
  }
  local X3 = {
    x = 105,
    y = 0,
    z = -178
  }
  local X4 = {
    x = 114,
    y = 0,
    z = -178
  }
  monster.step = 1
  monster.goal = {
    X1,
    X2,
    X3,
    X4
  }
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.stand, _ENV.move)
  end
  
  function states.move.start()
    monster.pos = monster.goal[monster.step]
    if monster.pos ~= nil then
      lookat_position(npc, monster.pos.x, monster.pos.z, true)
      switch_move_type(npc, 1)
      move_to_pos(npc, monster.pos)
    end
  end
  
  function states.move.tickTrans(move)
    if monster.isSamePos(monster, get_npc_pos(monster.npc), monster.goal[monster.step], 0.1) and monster.goal[monster.step] then
      monster.step = monster.step + 1
      return move.monster.states.stand
    end
  end
  
  function states.stand.start()
    stop_move(npc)
  end
end

function monster.on_enter_area(monster, npc, area)
  local areaName = area.Tag
  if npc == get_come_on_hero() and "begin" == areaName then
    monster.tree:transState(monster.states.move)
  end
end

function monster.on_skill_begin(monster, npc, skill_id, skill_type)
  if 301010101 == skill_id then
    monster.tree:transState(monster.states.stand)
    monster.step = monster.step + 1
  end
end

function monster.on_skill_end(monster, npc, skill_id, is_time_out, is_break, behavior_abort)
  if 301010101 == skill_id then
    monster.tree:transState(monster.states.move)
  end
end

function monster.isSamePos(monster, pos1, pos2, tollerance)
  return tollerance >= (pos1.x - pos2.x) * (pos1.x - pos2.x) + (pos1.z - pos2.z) * (pos1.z - pos2.z)
end

return monster
