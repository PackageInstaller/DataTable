local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 1,
    minTime = 1,
    maxTime = 3,
    type = "walk"
  }
  monster.search = {minDis = 100, maxDis = 100}
  local skills = {
    Execution_start = {2010530301},
    Execution_move = {2010530302},
    Execution_hit = {2010530305},
    pursue_interim = {2010530306},
    jumphit = {2010530304},
    jumphit_B = {2010530304},
    Starfall_A1 = {2010530307},
    Starfall_A2 = {2010530308},
    Starfall_B1 = {2010530307},
    Starfall_B2 = {2010530308},
    Combo = {
      2010530309,
      12,
      2,
      0,
      3,
      -60,
      60
    },
    Dash_turn = {
      2010530101,
      0,
      0,
      0.5,
      2,
      -60,
      60,
      -2
    },
    Dash_front = {
      2010530103,
      0,
      0,
      2,
      8,
      -60,
      60,
      -2
    },
    Dash_back = {
      2010530104,
      0,
      0,
      0,
      0.5,
      -60,
      60,
      -2
    },
    Dash_turnback = {
      2010530107,
      8,
      0,
      0,
      6,
      90,
      -160,
      -2
    },
    Dash_jumphit = {
      2010530312,
      0,
      0,
      0,
      5
    },
    Dash_StepAtk = {
      2010530313,
      0,
      0,
      0,
      4,
      -60,
      60
    },
    Idle_jumphit = {
      2010530314,
      8,
      0,
      0,
      4
    },
    Jumphit_turnhit = {
      2010530315,
      8,
      0,
      0,
      5
    },
    Jumphit_turnhit2 = {
      2010530315,
      10,
      0,
      0,
      5
    },
    Sprint_fast = {
      2010530112,
      12,
      10,
      3.5,
      99,
      -90,
      90
    },
    Sprint_slow = {
      2010530301,
      0,
      2,
      6,
      99,
      -90,
      90
    },
    Sprint_move = {
      2010530302,
      0,
      0,
      0,
      99
    },
    Sprint_atk = {
      2010530303,
      0,
      0,
      0,
      99,
      nil,
      nil,
      2
    },
    Starfall_C1 = {
      2010530307,
      15,
      10,
      3.5,
      99,
      -90,
      90
    },
    Starfall_C2 = {2010530308},
    Counter_back = {
      2010530118,
      0,
      0,
      0,
      2,
      -60,
      60,
      -2
    },
    reExecution_start = {2010530301},
    reExecution_move = {2010530302},
    reExecution_hit = {2010530305}
  }
  set_stun_animation_group_id(monster.npc, 1)
  local nodes = {
    "Execution",
    "stateA",
    "StartfallA",
    "Sprint",
    "stateB",
    "StartfallB",
    "Dash_atk",
    "Dash",
    "Sprint",
    "StartfallC",
    "Heavy",
    "reExecution"
  }
  local actMoves = {"Stop"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.stateA)
    _ENV.wander(_ENV.Stop)
    _ENV.Execution(_ENV.pursue_interim(_ENV.Execution_start(_ENV.Execution_move(_ENV.Execution_hit))))
    _ENV.reExecution(_ENV.reExecution_start(_ENV.reExecution_move(_ENV.reExecution_hit)))
    _ENV.stateA(_ENV.jumphit, _ENV.Execution, _ENV.StartfallA, _ENV.StartfallB, _ENV.reExecution_start)
    _ENV.StartfallA(_ENV.Starfall_A2)
    _ENV.StartfallB(_ENV.Starfall_B1(_ENV.Starfall_B2))
  end
  monster.states.dead.delay = {fx = 2.5, remove = 2.9}
  monster.states.attack.interval = 1
  monster.stunTime = 2
  
  function monster.states.stateA.isReady()
    return false
  end
  
  monster.Ai_State = 1
  monster.End = false
  char_visible(false)
  set_ui_object_visible("fight", "Main", true)
  set_ui_object_visible("fight", "JoystickContent", true)
  set_keyframe_enable(monster.npc, 201053010507, false, true)
  set_keyframe_enable(monster.npc, 201053010509, false, true)
  set_keyframe_enable(monster.npc, 201053010511, false, true)
  set_keyframe_enable(monster.npc, 201053010512, false, true)
  set_keyframe_enable(monster.npc, 201053010513, false, true)
  set_keyframe_enable(monster.npc, 201053010514, false, true)
  set_keyframe_enable(monster.npc, 201053010515, false, true)
  set_keyframe_enable(monster.npc, 201053010516, false, true)
  set_keyframe_enable(monster.npc, 201053010517, false, true)
  set_keyframe_enable(monster.npc, 201053010518, false, true)
  set_keyframe_enable(monster.npc, 201053010208, false, true)
  set_keyframe_enable(monster.npc, 201053010210, false, true)
  set_keyframe_enable(monster.npc, 201053010807, false, true)
  set_keyframe_enable(monster.npc, 201053010810, false, true)
  set_keyframe_enable(monster.npc, 201053010812, false, true)
  set_keyframe_enable(monster.npc, 201053010813, false, true)
  set_keyframe_enable(monster.npc, 201053010814, false, true)
  set_keyframe_enable(monster.npc, 201053010815, false, true)
  set_keyframe_enable(monster.npc, 201053010816, false, true)
  set_keyframe_enable(monster.npc, 201053010817, false, true)
  set_keyframe_enable(monster.npc, 201053010818, false, true)
  set_keyframe_enable(monster.npc, 201053010819, false, true)
  do
    local Execution_move = monster.states.Execution_move
    local Execution_start = monster.states.Execution_start
    local Execution = monster.states.Execution
    local pursue_interim = monster.states.pursue_interim
    local Execution_hit = monster.states.Execution_hit
    local reExecution_start = monster.states.reExecution_start
    local reExecution_move = monster.states.reExecution_move
    local reExecution_hit = monster.states.reExecution_hit
    
    function Execution_move.tick(Execution_move)
      local DistanceToPlayer = get_npc_distance(monster.npc, 1, monster.target, false)
      if DistanceToPlayer <= 5 then
        Execution_move:derive()
      end
    end
    
    function Execution_start.start(Execution_start)
      Execution_start.base.start(Execution_start)
      if 1 ~= monster.Ai_State then
        set_ui_object_visible("fight", "Main", true)
      end
      set_stun_animation_group_id(monster.npc, 2)
    end
    
    function Execution.finish(Execution)
      set_stun_animation_group_id(monster.npc, 1)
    end
    
    function pursue_interim.finish(pursue_interim)
      pursue_interim.base.finish(pursue_interim)
      set_camera(1070902, true)
    end
    
    function Execution_hit.finTrans()
      return Execution_hit.monster.states.wander
    end
    
    function reExecution_start.start(reExecution_start)
      reExecution_start.base.start(reExecution_start)
      set_ui_object_visible("fight", "Main", true)
      set_ui_object_visible("fight", "JoystickContent", true)
      set_stun_animation_group_id(monster.npc, 2)
    end
    
    function reExecution_move.tick(reExecution_move)
      local DistanceToPlayer = get_npc_distance(monster.npc, 1, monster.target, false)
      if DistanceToPlayer <= 5 then
        reExecution_move:derive()
      end
    end
    
    function reExecution_hit.finTrans(reExecution_hit)
      set_stun_animation_group_id(monster.npc, 1)
      return reExecution_hit.monster.states.wander
    end
  end
  do
    local Starfall_A2 = monster.states.Starfall_A2
    local born = monster.states.born
    
    function born.start(born)
      monster:searchTarget()
      start_stroy(5071704)
      if 1 == monster.tool.Execution and 1 == monster.Ai_State then
        set_npc_pos(monster.npc, "A1")
        lookat_npc(monster.npc, get_come_on_hero(), true)
        lookat_npc(get_come_on_hero(), monster.npc, true)
        set_keyframe_enable(monster.npc, 201053030510, false, true)
      elseif 2 == monster.tool.Execution then
        monster.Ai_State = 2
        local posX, posY, posZ = get_area_pos("A4")
        set_npc_pos(monster.npc, "A2")
        lookat_position(monster.npc, posX, posZ, true)
      else
        set_npc_pos(monster.npc, "A3")
        local posX, posY, posZ = get_area_pos("A1")
        lookat_position(monster.npc, posX, posZ, true)
      end
      born.base.start(born)
    end
    
    function born.finTrans()
      monster.target = get_come_on_hero()
      if 1 == monster.tool.Execution and 1 == monster.Ai_State then
        return monster.states.reExecution_start
      elseif 2 == monster.tool.Execution and 2 == monster.Ai_State then
        return monster.states.Starfall_B1
      else
        return monster.states.Starfall_A2
      end
    end
    
    function Starfall_A2.tarPos()
      return monster.MoveTpPos(monster, "A1")
    end
    
    function Starfall_A2.moveScale()
      local Scale = {}
      for i = 1, 50 do
        Scale[i] = 0
      end
      for i = 1, 10 do
        Scale[i] = 0.65
      end
      return Scale
    end
    
    function Starfall_A2.finish()
      Starfall_A2.base.finish(Starfall_A2)
      set_keyframe_enable(monster.npc, 201053030816, false, true)
      set_keyframe_enable(monster.npc, 201053030817, false, true)
      set_keyframe_enable(monster.npc, 201053030818, false, true)
    end
  end
  do
    local Starfall_B1 = monster.states.Starfall_B1
    local Starfall_B2 = monster.states.Starfall_B2
    monster.proportion = 0
    
    function Starfall_B1.start(Starfall_B1)
      local posX, posY, posZ = get_area_pos("A4")
      set_npc_status(monster.npc, 4, true)
      set_npc_pos(monster.npc, "A1")
      lookat_position(monster.npc, posX, posZ, true)
      local self = Starfall_B1.monster
      Starfall_B1.isCastOver = false
      local skill = Starfall_B1.skill
      Starfall_B1.curSk = skill
      skill.state = Starfall_B1
      abort_skill(self.npc, true)
      skill.isCastOver = false
      skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
      start_stroy(5071708)
      cast_skill(self.npc, nil, 2010530307, posX, posZ)
    end
    
    function Starfall_B2.moveScale(Starfall_B2)
      local Scale = {}
      for i = 1, 50 do
        Scale[i] = 0.1
      end
      for i = 1, 10 do
        Scale[i] = monster.proportion / 1.08
      end
      return Scale
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      cast_magic(monster.npc, monster.npc, 201053011607)
      cast_magic(monster.npc, monster.npc, 201053010109)
      set_show_betargeted_arrow(get_come_on_hero(), false)
      set_can_searched(monster.npc, false)
      faint.base.start(faint)
      cast_magic(monster.npc, monster.npc, 1999241)
    end
  end
  do
    local Starfall_B2 = monster.states.Starfall_B2
    local attack = monster.states.attack
    local Combo = monster.states.Combo
    attack.interval = 2
    
    function Starfall_B2.start(Starfall_B2)
      set_keyframe_enable(monster.npc, 201053030818, false, false)
      Starfall_B2.base.start(Starfall_B2)
      
      local function delay()
        set_sync_var("fight", true)
      end
      
      monster:doAfter(delay, 1)
    end
    
    function Starfall_B2.finTrans(Starfall_B2)
      do
        local _ENV = monster.states
        _ENV.wander(_ENV.wanderMove, _ENV.wanderStand)
        attack(_ENV.stateB, _ENV.freeCounter)
        _ENV.freeCounter(_ENV.Counter_back)
        _ENV.stateB(_ENV.Sprint, Combo, _ENV.Heavy, _ENV.Dash, _ENV.Dash_atk)
        _ENV.Dash_atk(_ENV.Dash_jumphit(_ENV.Jumphit_turnhit2), _ENV.Dash_StepAtk)
        _ENV.Dash(_ENV.Dash_turnback, _ENV.Dash_front, _ENV.Dash_turn)
        _ENV.Sprint(_ENV.Sprint_slow(_ENV.Sprint_move(_ENV.Sprint_atk)))
        _ENV.Heavy(_ENV.Idle_jumphit(_ENV.Jumphit_turnhit))
      end
      monster.states.attack.timer = get_npc_time(monster.npc) + 2
      return monster.states.wander
    end
    
    function Combo.moveScale()
      return 0.6
    end
  end
  do
    local Dash = monster.states.Dash
    local Dash_atk = monster.states.Dash_atk
    local Dash_back_states = monster.states.Dash_back
    local Dash_back = monster.skills.Dash_back
    local Dash_turnback = monster.skills.Dash_turnback
    local Dash_front = monster.skills.Dash_front
    local Dash_turn = monster.skills.Dash_turn
    local Counter_back = monster.skills.Counter_back
    Dash.timer = 5 + 3 * math.random()
    
    function Dash_atk.isReady()
      return false
    end
    
    function Counter_back.onCastTime()
      monster.choose_Child(monster)
    end
    
    function Dash_turnback.onCastTime()
      monster.choose_Child(monster)
    end
    
    function Dash_front.onCastTime()
      monster.choose_Child(monster)
    end
    
    function Dash_turn.onCastTime()
      monster.choose_Child(monster)
    end
    
    function Dash.isReady()
      return Dash.timer < get_npc_time(monster.npc)
    end
    
    function Dash.finish(Dash)
      local cd = 4
      if 2 == get_sync_var("Stone_state") then
        cd = 2
      else
        cd = 4 + 2 * math.random()
      end
      Dash.timer = get_npc_time(monster.npc) + cd
    end
  end
  do
    local Sprint_atk = monster.states.Sprint_atk
    local Sprint_move = monster.states.Sprint_move
    
    function Sprint_atk.moveScale()
      return monster.calculate_moveScale(monster)
    end
    
    function Sprint_move.tick(Sprint_move)
      local AngleToPlayer = get_target_angel(Sprint_move.monster.npc, Sprint_move.monster.target, true)
      local DistanceToPlayer = get_npc_distance(monster.npc, 1, monster.target, false)
      if DistanceToPlayer <= 6.5 or AngleToPlayer < -60 or AngleToPlayer > 60 then
        Sprint_move:derive()
      end
    end
  end
  do
    local Stop = monster.states.Stop
    
    function Stop.isReady()
      return true
    end
    
    function Stop.start(Stop)
      stop_move(monster.npc)
    end
  end
end

function monster.on_start(monster)
  set_npc_hp_bar_type(monster.npc, 0)
  set_can_searched(monster.npc, false)
  monster:xRay()
  set_npc_floating_text_hud_visible(monster.npc, false)
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 201053012112 == magic_id and monster.state.name == "Starfall_A2" then
    set_sync_var("Execution_start", true)
    monster.Execution(monster, "reborn", "A1")
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 201053011601 == magic_id then
    local Hero_pos = get_npc_offset_position(monster.npc, nil, 0, 0.5)
    abort_skill(monster.target, false)
    flash_to_pos(get_come_on_hero(), Hero_pos.x, Hero_pos.z)
    set_can_searched(monster.npc, false)
    cast_magic(monster.npc, monster.target, 201053012102, 1)
  end
  if 201053012104 == magic_id then
    if 1 == monster.Ai_State then
      monster.tool.Execution = 1
      set_sync_var("Execution_hit", true)
    elseif 2 == monster.Ai_State then
      monster.tool.Execution = 2
      set_sync_var("Execution_hit", true)
    end
  end
  if 201053012126 == magic_id and 1 == monster.Ai_State then
    enter_guide(1071101)
    set_ui_object_visible("fight", "Main", true)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 3 == get_sync_var("Stone_state") then
    return
  end
  if 2010530315 == skill_id and missile_cfg.Id == 201053031502 then
    monster.tool.Stone_switch = true
    monster.Execution(monster, "A4", "A5")
  end
  if 2 == get_sync_var("Stone_state") then
    if 2010530309 == skill_id and missile_cfg.Id == 201053030910 and check_npc_status(monster.npc, 10) then
      monster.tool.Stone_switch = true
      monster.Execution(monster, "A4", "A5")
    end
    if 2010530303 == skill_id and missile_cfg.Id == 201053030301 and check_npc_status(monster.npc, 10) then
      monster.tool.Stone_switch = true
      monster.Execution(monster, "A4", "A5")
    end
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  local dead = monster.states.dead
  dead.start = dead.dieByRedSk
  abort_skill(monster.npc, false)
  abort_magic_by_id(monster.npc, Const.RED_SKILL)
  monster:doAfter(monster.on_red_skill_countered_fx, nil, attackerNpc)
  start_stroy(5071705)
  set_sync_var("Execution_End", true)
  cast_magic(monster.npc, monster.npc, 201053010109, 1)
  cast_magic(monster.npc, monster.npc, 201053011608, 1)
  set_ui_object_visible("fight", "Main", true)
  set_ui_object_visible("fight", "JoystickContent", true)
  monster.target = nil
  
  local function delayA()
    set_camera(1071101, true)
  end
  
  local function delayB()
    set_camera(1071301, true)
  end
  
  if 1 == monster.Ai_State then
    enter_stun(monster.npc, false, math.huge)
    monster:doAfter(delayA, 1.65)
  end
  if 2 == monster.Ai_State then
    enter_stun(monster.npc, false, monster.stunTime)
    if monster.stunTime <= 6 then
      monster.stunTime = monster.stunTime + 2
    end
    monster:doAfter(delayB, 1.65)
  end
end

function monster.MoveTpPos(monster, num)
  local posx, posy, posz = get_area_pos(num)
  local pos = {
    x = posx,
    y = posy,
    z = posz
  }
  return pos
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  monster.base.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201053030702 then
    monster.weapon_pos = get_npc_pos(monster.npc, "M201053_2")
    monster.missile_pos = get_missile_pos(missile)
    local self_weapon = get_npc_distance(monster.npc, 2, monster.weapon_pos.x, monster.weapon_pos.z, false)
    local self_missile = get_npc_distance(monster.npc, 2, monster.missile_pos.x, monster.missile_pos.z, false)
    monster.proportion = self_missile / self_weapon
  end
  if missile_cfg.Id == 201053030501 then
    char_visible(true)
    start_stroy(5071509)
    set_ui_object_visible("fight", "Main", false)
    set_ui_object_visible("fight", "JoystickContent", false)
  end
end

function monster.Execution(monster, Hero_pos, monster_pos)
  monster:transState(monster.states.pursue_interim, true)
  abort_skill(get_come_on_hero(), true)
  cast_missile(monster.npc, get_come_on_hero(), nil, nil, 201053012101)
  set_npc_pos(get_come_on_hero(), Hero_pos)
  set_npc_pos(monster.npc, monster_pos)
  cast_magic(monster.npc, monster.npc, 201053010115, 1)
  cast_magic(monster.npc, monster.npc, 201053010116, 1)
  cast_magic(monster.npc, monster.npc, 201053010117, 1)
  set_can_searched(monster.npc, true)
  lookat_npc(monster.npc, get_come_on_hero(), true)
  lookat_npc(get_come_on_hero(), monster.npc, true)
  set_camera(1070901, true)
  set_ui_object_visible("fight", "Main", false)
  set_ui_object_visible("fight", "JoystickContent", false)
  
  local function delay()
    cast_magic(monster.npc, get_come_on_hero(), 201053012117, 1)
  end
  
  monster:doAfter(delay, 1.5)
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if 1 == get_sync_var("Stone_state") and 1 == monster.Ai_State then
    monster.Ai_State = 2
    monster.target = get_come_on_hero()
    exit_stun(monster.npc)
    set_keyframe_enable(monster.npc, 201053030510, false, true)
    set_keyframe_enable(monster.npc, 201053030816, false, true)
    set_keyframe_enable(monster.npc, 201053030706, false, true)
    monster:transState(monster.states.Starfall_B1, true)
  end
  if 2 == get_sync_var("Stone_state") then
    monster.states.attack.interval = 1
  end
  if 3 == get_sync_var("Stone_state") and monster.End == false then
    cast_magic(monster.npc, monster.npc, 201053011607)
    cast_magic(monster.npc, monster.npc, 201053010109)
    cast_magic(monster.npc, monster.npc, 201053010012)
    enter_stun(monster.npc, false, monster.stunTime)
    monster.End = true
  end
end

function monster.choose_Child(monster)
  local Dash = monster.states.Dash
  if monster.states.Dash_jumphit:isReady() and math.random() < 0.5 then
    monster.tree:derive(monster.states.Dash_jumphit, true)
    return
  else
    monster.tree:derive(monster.states.Dash_StepAtk, true)
  end
end

function monster.calculate_moveScale(monster)
  local target = monster.target
  local Distance = get_npc_distance(monster.npc, 1, target, false)
  local Scale = Distance / 9
  return Scale
end

function monster.on_red_skill_countered_fx(monster, attackerNpc, missile)
  attackerNpc = attackerNpc or get_come_on_hero()
  local monster_kind = get_role_kind(monster.npc)
  if 4 ~= monster_kind then
    cast_magic(attackerNpc, attackerNpc, 1999351)
  else
    cast_magic(attackerNpc, attackerNpc, 1999352)
  end
  lookat_npc(monster.npc, attackerNpc, true)
  cast_magic(monster.npc, monster.npc, Const.MONSTER_BE_HIT.SOUND_REVERB, 0)
  cast_magic(attackerNpc, monster.npc, 1999242)
  cast_magic(attackerNpc, monster.npc, 1999219)
  cast_magic(attackerNpc, monster.npc, 201053012115)
  cast_magic(attackerNpc, monster.npc, 1999222)
  cast_magic(attackerNpc, monster.npc, 1999261)
  cast_magic(attackerNpc, monster.npc, 201053012113)
  cast_magic(attackerNpc, monster.npc, 201053012114)
  set_ui_object_visible("fight", "Main", true)
  set_ui_object_visible("fight", "JoystickContent", true)
end

return monster
