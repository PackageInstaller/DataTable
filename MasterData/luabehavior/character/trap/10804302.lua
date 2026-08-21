local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 4032905, 1)
  local skills = {}
  local actMoves = {"talk", "walk"}
  local nodes = {"default"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.root(_ENV.talk, _ENV.default, _ENV.decisionFailed)
    _ENV.default(_ENV.walk)
  end
  monster.moveTarget = {}
  monster.currentPosIndex = 1
  monster.posAmout = 0
  for i = 1, 14 do
    local posName
    if get_npc_id(monster.npc) == 10804302 then
      posName = "d" .. i
    end
    if get_npc_id(monster.npc) == 10804303 then
      posName = "e" .. i
    end
    local hasPos = pcall(get_area_pos, posName)
    if hasPos then
      monster.posAmout = monster.posAmout + 1
      local posX, posY, posZ = get_area_pos(posName)
      local currentPos = {
        x = posX,
        y = posY,
        z = posZ
      }
      table.insert(monster.moveTarget, currentPos)
    end
  end
  monster.relax = {}
  monster.check = {}
  monster.relax.x, monster.relax.y, monster.relax.z = get_area_pos("relax")
  monster.check.x, monster.check.y, monster.check.z = get_area_pos("F2")
  monster.faceTarget = {}
  monster.currentFaceIndex = 2
  table.insert(monster.faceTarget, monster.check)
  table.insert(monster.faceTarget, monster.relax)
  do
    local default = monster.states.default
    local walk = monster.states.walk
    local talk = monster.states.talk
    
    function default.isReady()
      return true
    end
    
    function talk.isReady()
      return true
    end
    
    function walk.isReady()
      return true
    end
    
    talk.lookTime = 0
    
    function talk.start(talk)
      remove_missile_by_id(108042020101, monster.npc, false)
      abort_magic_by_id(monster.npc, 399931, 1)
      abort_magic_by_id(monster.npc, 108042020101, 1)
      math.randomseed(os.time())
      local elapse = 0.13 + 0.2 * math.random() * 1
      talk.lookTime = get_npc_time(monster.npc) + elapse
      set_sync_var("move_start2", false)
    end
    
    function talk.tickTrans(talk)
      if get_npc_time(talk.monster.npc) > talk.lookTime and get_sync_var("worker") ~= nil then
        lookat_position(monster.npc, monster.faceTarget[monster.currentFaceIndex].x, monster.faceTarget[monster.currentFaceIndex].z, false)
      end
      if get_sync_var("move_start2") then
        return monster.states.walk
      end
    end
    
    function walk.start(walk)
      cast_magic(npc, npc, 399931, 1)
      cast_missile_new(npc, npc, nil, nil, 108042020101, 1)
      cast_magic(npc, npc, 1080420102, 1)
      monster.currentPosIndex = get_sync_var("worker")
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
      monster.currentFaceIndex = monster.currentPosIndex
    end
    
    function walk.tickTrans(walk)
      if check_npc_distance_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex].x, monster.moveTarget[monster.currentPosIndex].z, 1, true) then
        return monster.states.talk
      end
    end
  end
end

return monster
