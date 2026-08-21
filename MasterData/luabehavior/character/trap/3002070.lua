local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_ignore_sync_area(monster.npc, false)
  set_can_searched(monster.npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 300204801, 1)
  cast_missile_new(monster.npc, monster.npc, nil, nil, 30020590101, 1)
  create_scene_effect("fx_common_monster_born", get_npc_pos(npc), 0)
  monster.npc:set_enable_rvo(false)
  monster.value = 2
  monster.angleElapse = 0
  local actSkills = {
    Kick = {
      300207001,
      6,
      2,
      3,
      3.5,
      30,
      330
    },
    Show_B = {300207023},
    RunStart = {300207002},
    RunLoop = {300207003},
    RunHit = {300207004},
    RunHitDrift = {300207020},
    RunHitStopLeft = {300207007},
    RunHitStopRight = {300207008},
    Show_A = {300207022}
  }
  local nodes = {"Run"}
  local actMoves = {"escape"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.meleeAtk(_ENV.Kick)
    _ENV.rangedAtk(_ENV.Run)
    _ENV.wander(_ENV.escape)
    _ENV.Run(_ENV.Show_B(_ENV.RunStart(_ENV.RunLoop(_ENV.RunHit(_ENV.RunHitStopLeft, _ENV.RunHitStopRight, _ENV.RunHitDrift)))))
  end
  monster.escapeTimes = 0
  monster.isRunning = false
  monster.isKicking = false
  monster.arrive = false
  monster.crash = false
  monster.center = {
    x = 0,
    y = get_npc_pos(get_come_on_hero()).y,
    z = 336.5
  }
  do
    local escape = monster.states.escape
    local Kick = monster.states.Kick
    local Run = monster.states.Run
    local faint = monster.states.faint
    local Show_A = monster.states.Show_A
    local wander = states.wander
    escape.changeTime = 0
    
    function escape.start(escape)
      monster.isRunning = false
      monster.isKicking = false
      math.randomseed(os.time())
      monster.angleElapse = math.random(-60, 60)
      monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TEMP_POS)
      local rValue = math.random() * 1 + 2
      escape.changeTime = get_npc_time(monster.npc) + rValue
      monster.escapeTimes = monster.escapeTimes + 1
    end
    
    function escape.tickTrans(escape)
      if states.Kick.isReady() then
        return monster.states.Kick
      elseif get_npc_time(monster.npc) > escape.changeTime then
        return monster.states.escape
      end
      if monster.crash == true then
        monster.crash = false
        return monster.states.escape
      end
    end
  end
  do
    local escape = monster.states.escape
    local Kick = monster.states.Kick
    local Run = monster.states.Run
    local RunStart = monster.states.RunStart
    local faint = monster.states.faint
    local Show_A = monster.states.Show_A
    local Show_B = monster.states.Show_B
    local wander = states.wander
    
    function Run.isReady(Run)
      local AngleToPlayer = get_target_angel(monster.npc, get_come_on_hero(), true)
      if AngleToPlayer < 30 and AngleToPlayer > -30 and check_npc_distance(monster.npc, get_come_on_hero(), 8, false) == false and false == monster.isRunning and false == monster.arrive then
        return true
      else
        return false
      end
    end
    
    function Run.start(Run)
      monster.arrive = false
      monster.isRunning = true
      lookat_npc(monster.npc, get_come_on_hero(), false)
    end
    
    function states.RunHitDrift.finTrans(RunHitDrift)
      remove_missile_by_id(30020701101, monster.npc)
      return Run.monster.states.escape
    end
    
    function states.RunHitStopLeft.finTrans(RunHitStopLeft)
      remove_missile_by_id(30020701101, monster.npc)
      return Run.monster.states.escape
    end
    
    function states.RunHitStopRight.finTrans(RunHitStopLeft)
      remove_missile_by_id(30020701101, monster.npc)
      return Run.monster.states.escape
    end
    
    function states.RunHitStopLeft.isReady(RunHitStopLeft)
      local AngleToPlayer = get_target_angel(RunHitStopLeft.monster.npc, RunHitStopLeft.monster.target, true)
      if AngleToPlayer < -30 and AngleToPlayer > -180 then
        return true
      end
    end
    
    function states.RunHitStopRight.isReady(RunHitStopRight)
      local AngleToPlayer = get_target_angel(RunHitStopRight.monster.npc, RunHitStopRight.monster.target, true)
      if AngleToPlayer > 30 and AngleToPlayer < 180 then
        return true
      end
    end
    
    function faint.finTrans(faint)
      faint.base.finTrans(faint)
      Show_A.timer = 0
      return Show_A
    end
    
    function states.Show_A.finTrans(Show_A)
      return escape
    end
  end
  do
    local escape = monster.states.escape
    local Kick = monster.states.Kick
    local Run = monster.states.Run
    local faint = monster.states.faint
    local Show_A = monster.states.Show_A
    local wander = states.wander
    local CD = 0
    
    function Kick.isReady(Kick)
      local AngleToPlayer = get_target_angel(monster.npc, get_come_on_hero(), true)
      if get_npc_time(monster.npc) > CD and (AngleToPlayer > 30 or AngleToPlayer < -30) and check_npc_distance(monster.npc, get_come_on_hero(), 3.5, false) == true and monster.isKicking == false or true == monster.arrive or 2 == monster.escapeTimes then
        return true
      else
        return false
      end
    end
    
    function Kick.start(Kick)
      monster.arrive = false
      monster.isKicking = true
      monster.escapeTimes = 0
      lookat_npc(monster.npc, get_come_on_hero(), false)
      Kick.base.start(Kick)
    end
    
    function Kick.finTrans(Kick)
      CD = get_npc_time(monster.npc) + 3
      if states.Run.isReady() then
        return monster.states.Run
      else
        return monster.states.escape
      end
    end
  end
  states.dead.delay.remove = 0.5
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 4) == "back" then
    monster.arrive = true
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  listen_missile_collide_obstacle(monster.npc, 30020701101, monster.on_missile_collide_obstacle, monster)
end

function monster.on_missile_collide_obstacle(monster, owner, obstacle_type, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id ~= 30020701101 then
    return
  end
  abort_skill(monster.npc, false)
  print("obstacle的stun", missile_cfg.Id)
  remove_missile_by_id(30020701101, monster.npc)
  enter_stun(monster.npc, false, 0.1)
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010220103 and monster.state.name == "idle" then
    local function delay()
      monster.search.minDis = 8
      
      monster.search.maxDis = 30
    end
    
    monster:doAfter(delay, 0.5)
  end
  if missile_cfg.Id == 30020590101 and monster.state.name == "escape" then
    monster.crash = false
    monster:transState(monster.states.escape, true)
  end
  if 2 == get_role_kind(attacker) and missile_cfg.Id == 30020701101 then
    print("受子弹击", missile_cfg.Id)
    abort_skill(monster.npc, false)
    remove_missile_by_id(30020701101, monster.npc)
    enter_stun(monster.npc, false, 0.5)
  end
  if missile_cfg.Id == 10010042101 then
    cast_magic(monster.npc, monster.npc, 300205301, 1)
  elseif missile_cfg.Id == 30010670301 then
    cast_magic(monster.npc, monster.npc, 300205302, 1)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  if get_npc_id(hit_target) == 3002071 then
    abort_skill(monster.npc, false)
    enter_stun(monster.npc, false, 0.5)
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  if 300205301 == magic_id then
    cast_magic(monster.npc, monster.npc, 300206907, 1)
    if get_cur_room_id() == 800601 then
      add_task_progress(8006011, 1)
      add_task_progress(8006012, 1)
    end
    if get_cur_room_id() == 800602 then
      add_task_progress(8006021, 1)
      add_task_progress(8006022, 1)
    end
    if get_cur_room_id() == 800603 then
      add_task_progress(8006031, 1)
      add_task_progress(8006032, 1)
    end
    if get_cur_room_id() == 800604 then
      add_task_progress(8006041, 1)
      add_task_progress(8006042, 1)
    end
  end
  monster.base.on_self_npc_hp_zero(monster)
end

return monster
