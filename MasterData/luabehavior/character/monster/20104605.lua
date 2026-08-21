local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3.5,
    minTime = 0.5,
    maxTime = 1,
    type = "walk"
  }
  local skills = {
    tripleHit = {
      2010460114,
      5,
      5 * math.random(),
      0,
      2.5,
      -45,
      45
    },
    doubleHit = {
      2010460102,
      20,
      math.random(5, 10),
      0,
      0.5,
      -45,
      45
    },
    dashOut = {
      2010460103,
      20,
      10 * math.random(),
      0,
      1.5,
      -45,
      45,
      -4
    },
    dashIn = {
      2010460104,
      5,
      3,
      1,
      8,
      -45,
      45
    },
    skill2 = {
      2010460106,
      20 + 15 * math.random(),
      math.random(5, 15),
      0,
      8,
      -60,
      60
    },
    wind = {2010460106},
    counter_skill1 = {
      2010460104,
      0,
      0,
      0,
      8,
      nil,
      nil,
      nil,
      10,
      1
    }
  }
  local nodes = {
    "drink",
    "specialATK",
    "Smoke"
  }
  local actMoves = {"Follow", "Cleaning"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  monster.Smoke_pos = {}
  monster.Smoke_num = 0
  do
    local _ENV = monster.states
    _ENV.active(_ENV.Smoke, _ENV.gotTarget, _ENV.noTarget)
    _ENV.freeAtk(_ENV.skill2, _ENV.dashIn, _ENV.doubleHit, _ENV.dashOut, _ENV.tripleHit)
    _ENV.freeCounter(_ENV.counter_skill1)
    _ENV.noTarget(_ENV.idle, _ENV.Follow)
    _ENV.Smoke(_ENV.Cleaning, _ENV.wind)
  end
  set_keyframe_enable(monster.npc, 201046010408, false, true)
  set_keyframe_enable(monster.npc, 201046010409, false, true)
  do
    local doubleHit = states.doubleHit
    local skill2 = states.skill2
    local skill1 = states.skill1
    
    function doubleHit.finTrans(doubleHit)
      local turn = math.random()
      local npc = doubleHit.monster.npc
      local target = doubleHit.monster.target
      local distance = get_npc_distance(npc, 1, target, true)
      if turn < 0.666 and distance <= 3 then
        doubleHit.monster.skills.dashOut.timer = 0
        return doubleHit.monster.states.dashOut
      elseif turn < 0.666 and distance > 3 then
        doubleHit.monster.skills.dashIn.timer = 0
        return doubleHit.monster.states.dashIn
      elseif turn > 0.666 then
        return doubleHit.monster.states.wander
      end
    end
    
    function monster.states.dashOut.finTrans(dashOut)
      local Trans = math.random()
      if Trans < 0.2 then
        return dashOut.monster.states.wander
      else
        return dashOut.monster.states.skill2
      end
    end
    
    function skills.dashOut.onEnd(dashOut)
      local monster = dashOut.monster
      local wander = monster.wander
      wander.minDis = 0.5
      wander.maxDis = 10
      
      local function resetwander(monster)
        wander.minDis = 0.5
        wander.mxaDis = 3.5
      end
      
      monster:doAfter(resetwander, 2)
      dashOut.base.onEnd(dashOut)
    end
  end
  do
    local Follow = monster.states.Follow
    local idle = monster.states.idle
    local noTarget = monster.states.noTarget
    idle.CD = 0.5
    
    function noTarget.start(noTarget)
      noTarget.base.start(noTarget)
      idle.CD = 1
    end
    
    function Follow.start(Follow)
      idle.CD = 0.5
      lookat_npc(monster.npc, get_come_on_hero(), false)
      switch_move_type(monster.npc, 1)
      moveto_npc(monster.npc, get_come_on_hero())
    end
    
    function Follow.tick()
      if get_npc_distance(monster.npc, 1, get_come_on_hero(), true) > 5 then
        switch_move_type(monster.npc, 0)
      end
    end
    
    function Follow.tickTrans(Follow)
      if check_npc_distance(monster.npc, get_come_on_hero(), 3, true) then
        return idle
      end
    end
    
    function Follow.finTrans(Follow)
      return Follow.states.noTarget
    end
    
    function idle.start(idle)
      stop_move(idle.monster.npc)
      idle.Transtime = get_npc_time(idle.monster.npc) + idle.CD
    end
    
    function idle.tickTrans(idle)
      lookat_npc(monster.npc, get_come_on_hero(), false)
      if get_npc_time(idle.monster.npc) > idle.Transtime and not check_npc_distance(monster.npc, get_come_on_hero(), 4, true) then
        return Follow
      end
    end
  end
  do
    local noTarget = monster.states.noTarget
    local Cleaning = monster.states.Cleaning
    local wind = monster.states.wind
    local Smoke = monster.states.Smoke
    
    function noTarget.tickTrans(noTarget)
      local monster = noTarget.monster
      if monster.target then
        return monster.states.gotTarget
      end
      if monster.Smoke_pos.bool == true and check_npc_distance_to_pos(monster.npc, monster.Smoke_pos.x, monster.Smoke_pos.z, 8, true) then
        return Smoke
      end
    end
    
    function Smoke.isReady(Smoke)
      return monster.Smoke_pos.bool
    end
    
    function Cleaning.start(Cleaning)
      local pos = {
        x = monster.Smoke_pos.x,
        z = monster.Smoke_pos.z
      }
      lookat_position(monster.npc, pos.x, pos.z, false)
      switch_move_type(monster.npc, 0)
      move_to_pos(monster.npc, pos)
    end
    
    function Cleaning.tickTrans(Cleaning)
      local distance = get_npc_distance(monster.npc, 2, monster.Smoke_pos.x, monster.Smoke_pos.z, false)
      if distance < 6 then
        return wind
      end
    end
    
    function wind.finTrans(wind)
      return monster.states.Follow
    end
    
    function wind.Tarpos()
      local pos = {
        x = monster.Smoke_pos.x,
        z = monster.Smoke_pos.z
      }
      return pos
    end
    
    function wind.start(wind)
      wind.base.start(wind)
      local Smoke = monster.Smoke_pos.target
      monster.Smoke_pos.bool = false
      
      local function delayA()
        abort_skill(Smoke)
      end
      
      local function delayB()
        remove_npc(Smoke)
        if 0 == monster.Smoke_num then
          set_sync_var("cleaned1", true)
        elseif 1 == monster.Smoke_num then
          set_sync_var("cleaned2", true)
        elseif 2 == monster.Smoke_num then
          set_sync_var("cleaned3", true)
        end
        monster.Smoke_num = monster.Smoke_num + 1
      end
      
      monster:doAfter(delayA, 1)
      monster:doAfter(delayB, 2)
    end
  end
end

return monster
