local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 3,
    type = "walk"
  }
  monster.randomCD = 2
  monster.RandomCD = 2
  monster.stroy = true
  local r = monster.randomCD
  local R = monster.RandomCD
  local skills = {
    Dash_turn = {
      2010530101,
      0,
      0,
      1.5,
      3,
      -60,
      60
    },
    Dash_front = {
      2010530103,
      0,
      0,
      3,
      8,
      -60,
      60
    },
    Dash_back = {
      2010530104,
      0,
      0,
      0,
      1.5,
      -60,
      60
    },
    Dash_turnback = {
      2010530107,
      8,
      0,
      0,
      6,
      90,
      -160
    },
    Dash_jumphit = {
      2010530105,
      15 + r,
      0,
      0,
      4,
      nil,
      nil,
      0.5
    },
    Dash_StepAtk = {
      2010530102,
      18 + r,
      0,
      0,
      3,
      -60,
      60,
      1.5
    },
    Idle_jumphit = {
      2010530108,
      15 + r,
      3,
      0,
      4,
      nil,
      nil,
      0.5
    },
    Jumphit_turnhit = {
      2010530106,
      0,
      0,
      0,
      3.5
    },
    Jumphit_turnhit2 = {
      2010530106,
      0,
      0,
      0,
      3.5
    },
    Starfall_start = {
      2010530109,
      20 + R,
      20,
      0,
      99
    },
    Starfall_end = {
      2010530110,
      0,
      0,
      0,
      99,
      nil,
      nil,
      1.5
    },
    Starfall_evade = {
      2010530117,
      0,
      0,
      0,
      99
    },
    Sprint_slow = {
      2010530111,
      30 + R,
      2,
      6,
      99,
      -90,
      90
    },
    Sprint_move = {
      2010530113,
      0,
      0,
      0,
      99
    },
    Sprint_atk = {
      2010530114,
      0,
      0,
      0,
      99,
      nil,
      nil,
      2
    },
    Sprint_fast = {
      2010530112,
      20 + R,
      10,
      3.5,
      99,
      -90,
      90
    },
    Sprint_F_move = {
      2010530113,
      0,
      0,
      0,
      99
    },
    Sprint_F_atk = {
      2010530114,
      0,
      0,
      0,
      99,
      nil,
      nil,
      3
    },
    Combo = {
      2010530115,
      8 + r,
      2,
      0,
      3,
      -60,
      60
    },
    Combo_atk = {
      2010530114,
      0,
      0,
      5,
      99
    },
    pursue_move = {
      2010530119,
      0,
      0,
      0,
      99
    },
    pursue_hit = {
      2010530120,
      0,
      0,
      0,
      99
    },
    pursue_interim = {
      2010530121,
      0,
      0
    },
    Counter_back = {
      2010530118,
      0,
      0,
      0,
      2,
      -60,
      60,
      -2
    }
  }
  set_stun_animation_group_id(monster.npc, 1)
  local nodes = {
    "Sprint",
    "Star",
    "Dash_atk",
    "Dash",
    "pursue",
    "Heavy",
    "SprintFast"
  }
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Star, _ENV.SprintFast, _ENV.Sprint, _ENV.Dash, _ENV.Combo, _ENV.Heavy, _ENV.Dash_atk)
    _ENV.Combo(_ENV.Combo_atk)
    _ENV.Dash_atk(_ENV.Dash_jumphit(_ENV.Jumphit_turnhit2), _ENV.Dash_StepAtk)
    _ENV.Dash(_ENV.Dash_turnback, _ENV.Dash_back, _ENV.Dash_front, _ENV.Dash_turn)
    _ENV.Heavy(_ENV.Idle_jumphit(_ENV.Jumphit_turnhit))
    _ENV.Star(_ENV.Starfall_evade, _ENV.Starfall_start(_ENV.Starfall_end))
    _ENV.Sprint(_ENV.Sprint_slow(_ENV.Sprint_move(_ENV.Sprint_atk)))
    _ENV.SprintFast(_ENV.Sprint_fast(_ENV.Sprint_F_move(_ENV.Sprint_F_atk)))
    _ENV.pursue(_ENV.pursue_move(_ENV.pursue_hit))
    _ENV.freeCounter(_ENV.Counter_back)
  end
  monster.states.dead.delay = {fx = 2.5, remove = 2.9}
  monster.defaultcam = get_cur_camera_id()
  monster.states.attack.interval = 1
  do
    local Combo_atk = monster.states.Combo_atk
    local Sprint_atk = monster.states.Sprint_atk
    
    function Combo_atk.moveScale()
      return monster.calculate_moveScale(monster)
    end
    
    function Sprint_atk.moveScale()
      return monster.calculate_moveScale(monster)
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
    
    function Dash_back_states.start(Dash_back_states)
      local Sprint_fast = monster.states.Sprint_fast
      local target = monster.target
      Dash_back_states.base.start(Dash_back_states)
      if Sprint_fast.timer - get_npc_time(monster.npc) < 4 and get_npc_distance(monster.npc, 1, target, false) > 2 then
        function Dash_back_states.finish()
          Dash_back_states.base.finish(Dash_back_states)
          
          monster:transState(monster.states.Sprint_fast, true)
        end
        
        function Dash_back.onCastTime()
        end
      else
        function Dash_back.onCastTime()
          monster.choose_Child(monster)
        end
        
        function Dash_back_states.finish(Dash_back_states)
          Dash_back_states.base.finish(Dash_back_states)
        end
      end
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
      local cd = 4 + 3 * math.random()
      Dash.timer = get_npc_time(monster.npc) + cd
    end
  end
  do
    local Starfall_end = monster.states.Starfall_end
    local Star = monster.states.Star
    local Starfall_start = monster.states.Starfall_start
    local Starfall_evade = monster.states.Starfall_evade
    local num = true
    monster.proportion = 0
    monster.missile_pos = 0
    
    function Starfall_end.moveScale()
      local Scale = {}
      for i = 1, 50 do
        Scale[i] = 0.2
      end
      for i = 1, 10 do
        Scale[i] = monster.proportion
      end
      return Scale
    end
    
    function Starfall_end.start(Starfall_end)
      local SprintFast = monster.states.SprintFast
      local Sprint = monster.states.Sprint
      
      function SprintFast.isReady()
        return true
      end
      
      function Sprint.isReady()
        return true
      end
      
      lookat_position(monster.npc, monster.missile_pos.x, monster.missile_pos.z, true)
      Starfall_end.base.start(Starfall_end)
    end
    
    function Star.isReady()
      if true == num then
        monster.states.attack.timer = 0
        num = false
      end
      local target = monster.target
      if get_npc_distance(monster.npc, 1, target, true) < 4 then
        Star(Starfall_evade(Starfall_start(Starfall_end)))
      else
        Star(Starfall_start(Starfall_end))
      end
      return Starfall_start.timer < get_npc_time(monster.npc)
    end
    
    function Starfall_start.onBreak()
      cast_magic(monster.npc, monster.npc, 201053010105, 1)
    end
    
    function Starfall_end.onBreak()
      cast_magic(monster.npc, monster.npc, 201053010105, 1)
    end
  end
  do
    local Sprint_move = monster.states.Sprint_move
    local Sprint_F_move = monster.states.Sprint_F_move
    local SprintFast = monster.states.SprintFast
    
    function SprintFast.isReady()
      return false
    end
    
    function Sprint_move.tick(Sprint_move)
      local AngleToPlayer = get_target_angel(Sprint_move.monster.npc, Sprint_move.monster.target, true)
      local DistanceToPlayer = get_npc_distance(monster.npc, 1, monster.target, false)
      if DistanceToPlayer <= 6.5 or AngleToPlayer < -60 or AngleToPlayer > 60 then
        Sprint_move:derive()
      end
    end
    
    function Sprint_F_move.tick(Sprint_F_move)
      local AngleToPlayer = get_target_angel(Sprint_F_move.monster.npc, Sprint_F_move.monster.target, true)
      local DistanceToPlayer = get_npc_distance(monster.npc, 1, monster.target, false)
      if DistanceToPlayer <= 6.5 or AngleToPlayer < -60 or AngleToPlayer > 60 then
        Sprint_F_move:derive()
      end
    end
  end
  do
    local pursue_move = monster.states.pursue_move
    local pursue_hit = monster.states.pursue_hit
    
    function pursue_move.tick(pursue_move)
      local DistanceToPlayer = get_npc_distance(monster.npc, 1, monster.target, false)
      if DistanceToPlayer <= 5 then
        pursue_move:derive()
      end
    end
  end
  do
    local Dash_jumphit = monster.states.Dash_jumphit
    local Idle_jumphit = monster.states.Idle_jumphit
    local Counter_back = monster.states.Counter_back
    
    function Dash_jumphit.finish(Dash_jumphit)
      Dash_jumphit.base.finish(Dash_jumphit)
      Idle_jumphit.timer = get_npc_time(monster.npc) + 8
    end
    
    function Idle_jumphit.finish(Idle_jumphit)
      Idle_jumphit.base.finish(Idle_jumphit)
      Dash_jumphit.timer = get_npc_time(monster.npc) + 8
    end
    
    function Counter_back.finish(Counter_back)
      Counter_back.base.finish(Counter_back)
      monster.states.Dash.timer = get_npc_time(monster.npc) + 5
    end
  end
  do
    local pursue_interim = monster.states.pursue_interim
    
    function pursue_interim.finish(pursue_interim)
      pursue_interim.base.finish(pursue_interim)
      set_camera(1070902, true)
    end
  end
end

function monster.on_start(monster)
  change_follow_target_new(3, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6
  })
  monster:xRay()
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201053010903 then
    monster.weapon_pos = get_npc_pos(monster.npc, "M201053_2")
    monster.missile_pos = get_missile_pos(missile)
    local self_missile = get_npc_distance(monster.npc, 2, monster.missile_pos.x, monster.missile_pos.z, false) * 0.9
    monster.proportion = self_missile / 16.25
  end
  if missile_cfg.Id == 201053010907 then
    monster.StartMis = missile
    
    local function delay()
      change_linetype(monster.StartMis, 1, {0, 0})
      monster.warningPos = {
        x = monster.StartMis.v_position.x,
        z = monster.StartMis.v_position.z
      }
    end
    
    monster:doAfter(delay, 0.8)
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

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 2010530102 == skill_id and missile_cfg.Id == 201053010211 then
    remove_missile_by_id(201053010208, monster.npc, true)
  end
  if 2010530114 == skill_id and missile_cfg.Id == 201053011416 then
    remove_missile_by_id(201053011414, monster.npc, true)
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201053010212 then
    remove_missile_by_id(201053010210)
  end
  if missile_cfg.Id == 201053011417 then
    remove_missile_by_id(201053011415)
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 201053011601 == magic_id then
    cast_magic(monster.npc, monster.target, 201053012102, 1)
  end
  if 201053010902 == magic_id then
    cast_missile3(monster.npc, nil, monster.warningPos.x, monster.warningPos.z, 201053010902, 1)
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  monster.frameTimer = get_npc_time(monster.npc)
  if monster.stroy == true and get_npc_attr(monster.npc, 1) / get_npc_attr(monster.npc, 4) < 0.5 then
    monster.stroy = false
    start_stroy(5071903)
  end
end

function monster.calculate_moveScale(monster)
  local target = monster.target
  local Distance = get_npc_distance(monster.npc, 1, target, false)
  local Scale = Distance / 9
  return Scale
end

function monster.on_self_skill_begin(monster, skill_id, skill_type)
  monster.base.on_self_skill_begin(monster, skill_id, skill_type)
  monster.randomCD = 1 + 3 * math.random(-1, 1)
  monster.RandomCD = 1 + 8 * math.random(-1, 1)
end

return monster
