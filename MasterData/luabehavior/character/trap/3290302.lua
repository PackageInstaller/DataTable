local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  set_npc_ignore_sync_area(npc, false)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  monster.moveTrigger = false
  monster.moveTarget = {}
  monster.currentPosIndex = 1
  monster.posAmout = 0
  monster.test = 0
  monster.pointAmount = 14
  for i = 1, monster.pointAmount do
    local posName = "T" .. i
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
  for j = 1, monster.pointAmount do
    monster.areaName = "c" .. j
  end
  for i = 1, monster.pointAmount do
    if check_npc_distance_to_pos(monster.npc, monster.moveTarget[i].x, monster.moveTarget[i].z, 2, false) then
      monster.currentPosIndex = i
    end
  end
  local actSkills = {
    stung = {329030101}
  }
  local actMoves = {"wait", "move_start"}
  local nodes = {"default", "hitten"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  cast_missile_new(monster.npc, monster.npc, nil, nil, 32903010202, 1)
  do
    local _ENV = states
    _ENV.root(_ENV.wait, _ENV.default, _ENV.hitten, _ENV.decisionFailed)
    _ENV.default(_ENV.move_start)
    _ENV.hitten(_ENV.stung)
  end
  do
    local default = monster.states.default
    local move_start = monster.states.move_start
    local wait = monster.states.wait
    
    function default.isReady()
      return true
    end
    
    function wait.isReady()
      return true
    end
    
    function move_start.isReady()
      return true
    end
    
    function wait.start(wait)
      stop_move(monster.npc)
    end
    
    function wait.tickTrans(wait)
      if get_sync_var("moveTrigger") then
        return monster.states.move_start
      end
    end
    
    function move_start.start(move_start)
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
    end
  end
  
  function states.stung.finTrans(stung)
    cast_missile_new(monster.npc, monster.npc, nil, nil, 32903010202, 1)
    return states.default
  end
end

function monster.on_self_enter_area(monster, areaName)
  local ckey = areaName.Key
  if string.sub(ckey, 1, 1) == "c" then
    monster.currentPosIndex = tonumber(string.sub(ckey, 2, 3))
  else
    monster.currentPosIndex = monster.currentPosIndex
  end
  switch_move_type(monster.npc, 1)
  move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 32903010202 and check_npc_distance(monster.npc, get_come_on_hero(), 2, false) then
    monster:transState(monster.states.hitten, true)
    lookat_npc(monster.npc, get_come_on_hero(), true)
    math.randomseed(os.time())
    call_scene_logic_custom_event("stopStory")
    start_stroy(3229400 + math.random(1, 3))
  end
end

return monster
