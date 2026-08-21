local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_npc_ignore_sync_area(monster.npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 399931, 1)
  cast_magic(npc, npc, 399932, 1)
  set_npc_status(npc, 4, true)
  cast_magic(npc, npc, 1080420101, 1)
  cast_magic(npc, npc, 1080420102, 1)
  local skills = {}
  local actMoves = {"talk", "move_start"}
  local nodes = {"default"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = monster.states
    _ENV.root(_ENV.talk, _ENV.default, _ENV.decisionFailed)
    _ENV.default(_ENV.move_start)
  end
  monster.MID = 0
  if get_cur_room_id() == 1080404 then
    monster.MID = 108041010101
  end
  if get_cur_room_id() == 1080405 then
    monster.MID = 108042010101
  end
  monster.eMID = 0
  if get_cur_room_id() == 1080404 then
    monster.eMID = 108041010102
  end
  if get_cur_room_id() == 1080405 then
    monster.eMID = 108042010102
  end
  cast_missile_new(monster.npc, monster.npc, nil, nil, monster.MID, 1)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, monster.MID, monster.playerHiding, monster)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, monster.MID, monster.playerLeft, monster)
  monster.moveTarget = {}
  monster.currentPosIndex = 1
  monster.posAmout = 0
  for i = 1, 14 do
    local posName = "P" .. i
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
  monster.faceTarget = {}
  monster.currentFaceIndex = 1
  monster.faceAmout = 0
  for j = 1, 14 do
    local faceName = "F" .. j
    local hasFace = pcall(get_area_pos, faceName)
    if hasFace then
      monster.faceAmout = monster.faceAmout + 1
      local faceX, faceY, faceZ = get_area_pos(faceName)
      local currentFace = {
        x = faceX,
        y = faceY,
        z = faceZ
      }
      table.insert(monster.faceTarget, currentFace)
    end
  end
  monster.arrive = true
  monster.playerIn = false
  monster.storyID = nil
  do
    local default = monster.states.default
    local move_start = monster.states.move_start
    local talk = monster.states.talk
    
    function default.isReady()
      return true
    end
    
    function talk.isReady()
      return true
    end
    
    function move_start.isReady()
      return true
    end
    
    talk.endTime = 0
    monster.talkTime = 1
    
    function talk.start(talk)
      set_sync_var("face", monster.currentFaceIndex)
      talk.endTime = get_npc_time(monster.npc) + monster.talkTime
      abort_magic_by_id(monster.npc, 1080420102, 1)
    end
    
    function talk.tick(talk)
      if get_sync_var("gameOver") then
        cast_magic(monster.npc, monster.npc, 1080410701, 1, 1)
      else
        abort_magic_by_id(monster.npc, 1080410701, 1)
      end
      print("talkTick3人组故事ID", monster.storyID, "状态", monster.states)
      if monster.storyID ~= nil and monster.playerIn == true then
        start_stroy(monster.storyID)
        monster.storyID = nil
      end
    end
    
    function talk.tickTrans(talk)
      if get_sync_var("gameFail") then
        stop_move(monster.npc)
        monster.arrive = false
        monster.currentPosIndex = 1
        monster.currentFaceIndex = 1
        monster.storyID = nil
      end
      if get_npc_time(talk.monster.npc) > talk.endTime and get_sync_var("finishStory") then
        call_scene_logic_custom_event("cantHear")
        monster.storyID = nil
        return monster.states.move_start
      end
    end
    
    function move_start.start(move_start)
      cast_magic(npc, npc, 1080420102, 1)
      set_sync_var("move_start", true)
      set_sync_var("target", monster.currentPosIndex)
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
    end
    
    function move_start.tick(move_start)
      print("moveStart3人组故事ID", monster.storyID, "状态", monster.states)
      if get_sync_var("gameOver") then
        cast_magic(monster.npc, monster.npc, 1080410701, 1, 1)
      else
        abort_magic_by_id(monster.npc, 1080410701, 1)
      end
    end
    
    function move_start.tickTrans(move_start)
      if get_sync_var("gameFail") then
        stop_move(monster.npc)
        monster.arrive = false
        monster.currentPosIndex = 1
        monster.currentFaceIndex = 1
        monster.storyID = nil
        return monster.states.talk
      end
      if monster.arrive == true then
        monster.arrive = false
        return monster.states.talk
      end
    end
  end
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 1) == "a" then
    monster.currentPosIndex = tonumber(string.sub(akey, 2, 2))
    monster.currentFaceIndex = tonumber(string.sub(akey, 3, 3))
    monster.arrive = true
  else
    monster.currentPosIndex = monster.currentPosIndex
    monster.currentFaceIndex = monster.currentFaceIndex
  end
  if get_cur_room_id() == 1080404 then
    if string.sub(akey, 1, 3) == "a21" then
      monster.talkTime = 5
      monster.storyID = nil
    end
    if string.sub(akey, 1, 3) == "a32" then
      monster.talkTime = 5
      monster.storyID = nil
    end
    if string.sub(akey, 1, 3) == "a33" then
      monster.talkTime = math.huge
      monster.storyID = 5080604
    end
  end
  if get_cur_room_id() == 1080405 then
    if string.sub(akey, 1, 3) == "a21" then
      monster.talkTime = 5
      monster.storyID = nil
    end
    if string.sub(akey, 1, 3) == "a32" then
      monster.talkTime = 5
      monster.storyID = nil
      set_sync_var("worker", 1)
    end
    if string.sub(akey, 1, 3) == "a43" then
      monster.talkTime = 45
      monster.storyID = 5080607
    end
    if string.sub(akey, 1, 3) == "a54" then
      monster.talkTime = 5
      monster.storyID = nil
    end
    if string.sub(akey, 1, 3) == "a65" then
      monster.talkTime = 5
      monster.storyID = nil
    end
    if string.sub(akey, 1, 3) == "a16" then
      monster.talkTime = 5
      monster.storyID = nil
    end
  end
end

function monster.playerHiding(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and target_npc == get_come_on_hero() then
    print("玩家进入圈子")
    cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410801, 1, 1)
    cast_magic(monster.npc, monster.npc, monster.eMID, 1, 1)
    abort_magic_by_id(get_come_on_hero(), 1080410201, 5)
    if 1 == get_magic_num(get_come_on_hero(), 1080410801) then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080402, 1, 1)
      abort_magic_by_id(get_come_on_hero(), 1080410202, 1)
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410501, 1)
      print("进入安全区")
    end
    monster.playerIn = true
  end
end

function monster.playerLeft(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and target_npc == get_come_on_hero() then
    abort_magic_by_id(get_come_on_hero(), 1080410801, 1)
    print("玩家走出圈子")
    abort_magic_by_id(monster.npc, monster.eMID)
    if get_magic_num(get_come_on_hero(), 1080410801) < 1 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410301, 1)
      abort_magic_by_id(get_come_on_hero(), 1080410501, 1)
      abort_magic_by_id(get_come_on_hero(), 1080402, 1)
      print("离开安全区")
    end
    monster.playerIn = false
    call_scene_logic_custom_event("cantHear")
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == monster.MID and 1 == get_role_kind(hit_target) then
    cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410101, 1, 2)
  end
end

function monster.on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if 1080410701 == magic_id then
    remove_missile_by_id(monster.MID, monster.npc, false)
    abort_magic_by_id(monster.npc, monster.eMID)
  end
end

function monster.on_self_magic_end(target, magic_id, magic_level, magic_kind, magic_type)
  if 1080410701 == magic_id then
    cast_missile_new(monster.npc, monster.npc, nil, nil, monster.MID, 1)
  end
end

function monster.on_self_npc_removed(monster)
  remove_missile_by_id(monster.MID, monster.npc, false)
  abort_magic_by_id(monster.npc, monster.eMID)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, monster.MID, monster.npc)
  set_sync_var("face", 0)
end

return monster
