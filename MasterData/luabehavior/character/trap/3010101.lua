local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local Tool = import("common.role_tool")

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
  local skills = {
    cancanneed = {301010101, 0}
  }
  local nodes = {}
  local actMoves = {"move", "stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  local N1 = {
    x = 80,
    y = 0,
    z = -180
  }
  local N2 = {
    x = 93,
    y = 0,
    z = -180
  }
  local N3 = {
    x = 106,
    y = 0,
    z = -180
  }
  local N4 = {
    x = 116,
    y = 0,
    z = -180
  }
  monster.M1 = {
    x = 70,
    y = 9,
    z = -180
  }
  monster.step = 1
  monster.goal = {
    N1,
    N2,
    N3,
    N4
  }
  monster.goalname = {
    "T1",
    "T2",
    "T3",
    "T4"
  }
  monster.hero1 = get_come_on_hero()
  monster.hero2 = get_scene_hero_by_poskey(21)
  monster.hero3 = get_scene_hero_by_poskey(22)
  monster.far_dialog = false
  monster.close_dialog = false
  monster.warning = 0
  monster.warningtip = 1
  monster.maxwarning = 4
  monster.minwarning = 0
  monster.warndistance = 7
  monster.outdistance = 20
  monster.outtipsdistance = 15
  monster.outtipson = false
  monster.tipon = false
  monster.warningeffect = 3010101015
  monster.herohiding = false
  monster.juqing = {2210201}
  monster.randomjuqing = math.random(1)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.stand, _ENV.move, _ENV.cancanneed)
  end
  
  function states.cancanneed.finTrans(cancanneed)
    return cancanneed.monster.states.move
  end
  
  function states.move.start()
    monster.pos = monster.goal[monster.step]
    if monster.pos ~= nil then
      switch_move_type(npc, 1)
      move_to_pos(npc, monster.pos)
      if not check_magic(npc, monster.warningeffect) then
        cast_magic(monster.npc, monster.npc, monster.warningeffect, 1)
      end
    end
  end
  
  function states.move.tick()
  end
  
  function states.move.tickTrans(move)
    if monster.isSamePos(monster, get_npc_pos(monster.npc), monster.goal[monster.step], 0.5) and monster.goal[monster.step] then
      monster.step = monster.step + 1
      monster.pos = monster.goal[monster.step]
      if monster.goal[monster.step] ~= nil then
        return move.monster.states.cancanneed
      else
        start_stroy(3210206)
        monster.tool:abortMagicToTeam(3010101012)
        play_timeline("TimeLine_310020101", 0, 1.5, nil, true, true)
        remove_npc(npc)
        return move.monster.states.stand
      end
    end
  end
  
  function states.move.finish()
    abort_magic_by_id(monster.npc, monster.warningeffect)
  end
  
  function states.stand.start()
    stop_move(npc)
  end
end

function monster.on_start(monster)
  change_follow_target(1, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = -5,
      z = -1.8
    },
    1,
    0.6
  })
  cast_magic(monster.npc, monster.hero1, 3010101012)
  if monster.hero2 then
    cast_magic(monster.hero2, monster.hero2, 3010101012)
  end
  if monster.hero3 then
    cast_magic(monster.hero3, monster.hero3, 3010101012)
  end
end

function monster.isSamePos(monster, pos1, pos2, tollerance)
  return tollerance >= (pos1.x - pos2.x) * (pos1.x - pos2.x) + (pos1.z - pos2.z) * (pos1.z - pos2.z)
end

function monster.on_enter_area(monster, npc, area)
  local areaName = area.Tag
  if npc == get_come_on_hero() then
    if "begin" == areaName then
      monster.tree:transState(monster.states.move)
      remove_area("Z1", "begin")
    elseif "hide" == areaName then
      monster.herohiding = true
    end
  end
end

function monster.on_leave_area(monster, npc, area)
  local areaName = area.Tag
  if npc == get_come_on_hero() and "hide" == areaName then
    monster.herohiding = false
  end
end

function monster.on_story_finish(monster, story_id)
  if 3210203 == story_id then
  elseif 2210202 == story_id then
    monster.far_dialog = false
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if monster.state.name == "cancanneed" and not monster.herohiding then
    monster.warning = monster.warning + 0.05
  end
  if get_npc_distance(monster.npc, 1, get_come_on_hero(), true) <= monster.warndistance and not monster.herohiding then
    monster.warning = monster.warning + 0.05
  end
  if (not monster.state.name ~= "cancanneed" and get_npc_distance(monster.npc, 1, get_come_on_hero(), true) > monster.warndistance or monster.herohiding == true) and monster.warning > 0.05 then
    monster.warning = monster.warning - 0.05
  end
  if get_npc_distance(monster.npc, 1, get_come_on_hero(), true) > monster.outdistance and monster.goal[monster.step] ~= nil then
    if nil ~= monster.goalname[monster.step - 1] then
      set_npc_pos(get_come_on_hero(), monster.goalname[monster.step - 1])
    else
      set_npc_pos(get_come_on_hero(), "M1")
    end
    if monster.far_dialog == false then
      start_stroy(2210202)
      monster.far_dialog = true
    end
  end
  if monster.warning >= monster.warningtip and false == monster.tipon or get_npc_distance(monster.npc, 1, get_come_on_hero(), true) <= monster.warndistance and false == monster.tipon then
    set_scene_tips(310020101, true)
    if false == monster.close_dialog then
      start_stroy(3210203)
      monster.close_dialog = true
      
      local function delay()
        monster.close_dialog = false
      end
      
      monster:doAfter(delay, 5)
    end
    monster.tipon = true
  end
  if monster.warning < monster.warningtip or monster.herohiding == true then
    set_scene_tips(310020101, false)
    monster.tipon = false
  end
  if monster.warning >= monster.maxwarning then
    start_stroy(monster.juqing[monster.randomjuqing])
    monster.warning = 0
    if nil ~= monster.goalname[monster.step - 1] then
      set_npc_pos(get_come_on_hero(), monster.goalname[monster.step - 1])
    else
      set_npc_pos(get_come_on_hero(), "M1")
    end
  end
end

return monster
