local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local vec3 = require("base.vec3")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 3,
    maxDis = 5,
    minTime = 4,
    maxTime = 5,
    type = "walk"
  }
  monster.search = {minDis = 100, maxDis = 999}
  monster.normal_keyframe_list = {
    201026011401,
    201026011402,
    201026011403,
    201026011404,
    201026011405,
    201026011406,
    201026011305,
    201026011306
  }
  monster.hard_keyframe_list = {
    201026011408,
    201026011409,
    201026011410,
    201026011411,
    201026011412,
    201026011413,
    201026011312,
    201026011313,
    201026011314,
    201026011315,
    201026011316,
    201026011317,
    201026011318,
    201026011319,
    201026011320,
    201026014002,
    201026014003,
    201026014004,
    201026014005,
    201026014006,
    201026014007
  }
  if get_tower_id() == 220303 or get_tower_id() == 220304 or get_tower_id() == 220305 then
    monster.hard = true
    print("hard")
    for _, hard_keyframe in ipairs(monster.hard_keyframe_list) do
      set_keyframe_enable(monster.npc, hard_keyframe, true, true)
    end
    for _, normal_keyframe in ipairs(monster.normal_keyframe_list) do
      set_keyframe_enable(monster.npc, normal_keyframe, false, true)
    end
  else
    print("normal")
    monster.hard = false
    for _, hard_keyframe in ipairs(monster.hard_keyframe_list) do
      set_keyframe_enable(monster.npc, hard_keyframe, false, true)
    end
    for _, normal_keyframe in ipairs(monster.normal_keyframe_list) do
      set_keyframe_enable(monster.npc, normal_keyframe, true, true)
    end
  end
  set_keyframe_enable(monster.npc, 201026011510, false, true)
  set_keyframe_enable(monster.npc, 201026010610, false, true)
  local actskills = {
    TrackingMle_A = {
      2010260102,
      40,
      10,
      0,
      8,
      -90,
      90
    },
    laser_A = {
      2010260104,
      50,
      2,
      0,
      9,
      -90,
      90
    },
    array_A = {
      2010260105,
      50,
      8,
      0,
      9,
      -90,
      90
    },
    explosion_A = {
      2010260108,
      35,
      10,
      0,
      8
    },
    jumpA_1 = {
      2010260106,
      5,
      5,
      0,
      12
    },
    jumpA_2 = {2010260122},
    jumpA_3 = {2010260107},
    Wheel_start_A = {
      2010260133,
      10,
      10,
      0,
      999
    },
    Wheel_loop_A = {2010260134},
    Wheel_end_A = {2010260135},
    Wheel_jumpA_1 = {
      2010260106,
      5,
      5,
      0,
      12,
      90,
      -90
    },
    Wheel_jumpA_2 = {2010260122},
    Wheel_jumpA_3 = {2010260107},
    Wheel_laser_A = {
      2010260104,
      0,
      0,
      0,
      5,
      nil,
      nil,
      nil,
      3
    },
    TrackingMle_B_1 = {
      2010260118,
      40,
      0,
      0,
      99
    },
    TrackingMle_B_2 = {2010260119},
    TrackingMle_B_3 = {2010260121},
    laser_B = {
      2010260113,
      50,
      2,
      0,
      9,
      -90,
      90
    },
    array_B = {
      2010260114,
      50,
      8,
      0,
      9,
      -90,
      90
    },
    explosion_B = {
      2010260117,
      35,
      10,
      0,
      8
    },
    jumpB_1 = {
      2010260115,
      5,
      5,
      0,
      12
    },
    jumpB_2 = {2010260123},
    jumpB_3 = {2010260116},
    Henshin_1 = {2010260136},
    Henshin_2 = {2010260131},
    Henshin_3 = {2010260132},
    Henshin_4 = {2010260138},
    Wheel_start_B = {
      2010260139,
      10,
      0,
      0,
      999
    },
    Wheel_loop_B = {2010260140},
    Wheel_end_B = {2010260141},
    Wheel_jumpB_1 = {
      2010260115,
      5,
      5,
      0,
      12,
      90,
      -90
    },
    Wheel_jumpB_2 = {2010260123},
    Wheel_jumpB_3 = {2010260116},
    Wheel_laser_B = {
      2010260113,
      5,
      0,
      0,
      5,
      nil,
      nil,
      nil,
      3
    }
  }
  local nodes = {
    "JumpA",
    "ATK_A",
    "ATK_B",
    "Henshin",
    "JumpB",
    "TrackingMle_B",
    "wheelA",
    "wheelB"
  }
  local actMoves = {}
  monstBase._init(monster, actskills, nil, nodes)
  if monster.hard then
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Henshin, _ENV.attack, _ENV.wander)
    _ENV.freeAtk(_ENV.ATK_A, _ENV.ATK_B)
    _ENV.ATK_A(_ENV.laser_A, _ENV.explosion_A, _ENV.TrackingMle_A, _ENV.array_A, _ENV.wheelA, _ENV.JumpA)
    _ENV.ATK_B(_ENV.laser_B, _ENV.explosion_B, _ENV.TrackingMle_B, _ENV.array_B, _ENV.wheelB, _ENV.JumpB)
    _ENV.JumpA(_ENV.jumpA_1(_ENV.jumpA_2(_ENV.jumpA_3)))
    _ENV.JumpB(_ENV.jumpB_1(_ENV.jumpB_2(_ENV.jumpB_3)))
    _ENV.TrackingMle_B(_ENV.TrackingMle_B_1(_ENV.TrackingMle_B_2(_ENV.TrackingMle_B_3)))
    _ENV.Henshin(_ENV.Henshin_1(_ENV.Henshin_4(_ENV.Henshin_2(_ENV.Henshin_3))))
    _ENV.wheelA(_ENV.Wheel_start_A(_ENV.Wheel_loop_A(_ENV.Wheel_end_A(_ENV.Wheel_jumpA_1(_ENV.Wheel_jumpA_2(_ENV.Wheel_jumpA_3)), _ENV.Wheel_laser_A))))
    _ENV.wheelB(_ENV.Wheel_start_B(_ENV.Wheel_loop_B(_ENV.Wheel_end_B(_ENV.Wheel_jumpB_1(_ENV.Wheel_jumpB_2(_ENV.Wheel_jumpB_3)), _ENV.Wheel_laser_B))))
  else
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Henshin, _ENV.attack, _ENV.wander)
    _ENV.freeAtk(_ENV.ATK_A, _ENV.ATK_B)
    _ENV.ATK_A(_ENV.laser_A, _ENV.explosion_A, _ENV.TrackingMle_A, _ENV.array_A, _ENV.wheelA, _ENV.JumpA)
    _ENV.ATK_B(_ENV.laser_B, _ENV.explosion_B, _ENV.TrackingMle_B, _ENV.array_B, _ENV.wheelB, _ENV.JumpB)
    _ENV.JumpA(_ENV.jumpA_1(_ENV.jumpA_2(_ENV.jumpA_3)))
    _ENV.JumpB(_ENV.jumpB_1(_ENV.jumpB_2(_ENV.jumpB_3)))
    _ENV.TrackingMle_B(_ENV.TrackingMle_B_1(_ENV.TrackingMle_B_2(_ENV.TrackingMle_B_3)))
    _ENV.Henshin(_ENV.Henshin_1(_ENV.Henshin_4(_ENV.Henshin_2(_ENV.Henshin_3))))
    _ENV.wheelA(_ENV.Wheel_start_A(_ENV.Wheel_loop_A(_ENV.Wheel_end_A)))
    _ENV.wheelB(_ENV.Wheel_start_B(_ENV.Wheel_loop_B(_ENV.Wheel_end_B(_ENV.Wheel_jumpB_1(_ENV.Wheel_jumpB_2(_ENV.Wheel_jumpB_3))))))
  end
  do
    local skills = monster.skills
    
    function skills.jumpA_2.onBegin(jumpA_2)
      jumpA_2.base.onBegin(jumpA_2)
      monster.flash(monster)
    end
    
    function skills.jumpB_2.onBegin(jumpB_2)
      jumpB_2.base.onBegin(jumpB_2)
      monster.flash(monster)
    end
    
    function skills.change_move.onBegin(change_move)
      change_move.base.onBegin(change_move)
      monster.flash(monster)
    end
  end
  monster.pan_dammissile = {
    [201026010202] = true,
    [201026010203] = true,
    [201026010204] = true,
    [201026010205] = true,
    [201026010207] = true,
    [201026010208] = true
  }
  monster.bomb_missile = 201026010801
  monster.land_missileA = 201026011201
  monster.land_missileB = 201026011202
  monster.ai_state = 1
  monster.track_misslie_A = {
    [201026010201] = true,
    [201026010202] = true,
    [201026010203] = true,
    [201026010204] = true,
    [201026010205] = true,
    [201026010207] = true,
    [201026010208] = true,
    [201026010209] = true,
    [201026010210] = true,
    [201026010211] = true,
    [201026010212] = true,
    [201026010215] = true,
    [201026010216] = true
  }
  monster.track_misslie_list = {
    201026010201,
    201026010202,
    201026010203,
    201026010204,
    201026010205,
    201026010207,
    201026010208,
    201026010209,
    201026010210,
    201026010211,
    201026010212,
    201026010215,
    201026010216,
    201026012102,
    201026012103,
    201026012104,
    201026012105,
    201026012106,
    201026012107,
    201026012108,
    201026012109,
    201026012110,
    201026012111,
    201026012112,
    201026012113,
    201026014002,
    201026014003,
    201026014004,
    201026014005,
    201026014006,
    201026014007
  }
  monster.track_misslie_B = {
    [201026012102] = true,
    [201026012103] = true,
    [201026012104] = true,
    [201026012105] = true,
    [201026012106] = true,
    [201026012107] = true,
    [201026012108] = true,
    [201026012109] = true,
    [201026012110] = true,
    [201026012111] = true,
    [201026012112] = true,
    [201026012113] = true
  }
  if not monster.hard then
    local attack = monster.states.attack
    local array_A = monster.states.array_A
    local array_B = monster.states.array_B
    local TrackingMle_A = monster.states.TrackingMle_A
    local TrackingMle_B = monster.states.TrackingMle_B
    local TrackingMle_B_1 = monster.states.TrackingMle_B_1
    local TrackingMle_B_3 = monster.states.TrackingMle_B_3
    attack.interval = 2
    
    function TrackingMle_A.start(TrackingMle_A)
      attack.interval = 8
      TrackingMle_A.base.start(TrackingMle_A)
    end
    
    function array_A.finish(array_A)
      array_A.base.finish(array_A)
      attack.interval = 8
    end
    
    function array_B.finish(array_B)
      array_B.base.finish(array_B)
      attack.interval = 4
    end
    
    function TrackingMle_B_1.finish(TrackingMle_B_1)
      TrackingMle_B_1.base.finish(TrackingMle_B_1)
      attack.interval = 3
    end
    
    function attack.start(attack)
      attack.interval = 2
    end
    
    function TrackingMle_B.start(TrackingMle_B)
      TrackingMle_B.num = 0
      TrackingMle_B.random = math.random(1, 2)
    end
    
    function TrackingMle_B_3.isReady(TrackingMle_B_3)
      if TrackingMle_B.num < TrackingMle_B.random then
        return true
      end
    end
    
    function TrackingMle_B_3.start(TrackingMle_B_3)
      TrackingMle_B.num = TrackingMle_B.num + 1
      TrackingMle_B_3.base.start(TrackingMle_B_3)
    end
  end
  do
    local ATK_A = monster.states.ATK_A
    local ATK_B = monster.states.ATK_B
    
    function ATK_A.isReady(ATK_A)
      if 1 == monster.ai_state then
        return true
      end
      return false
    end
    
    function ATK_B.isReady(ATK_B)
      if 2 == monster.ai_state then
        return true
      end
      return false
    end
  end
  do
    local jumpA_1 = monster.states.jumpA_1
    local jumpA_2 = monster.states.jumpA_2
    local jumpA_3 = monster.states.jumpA_3
    local jumpB_1 = monster.states.jumpB_1
    local jumpB_2 = monster.states.jumpB_2
    local jumpB_3 = monster.states.jumpB_3
    
    function jumpA_1.start(jumpA_1)
      jumpA_1.base.start(jumpA_1)
      
      local function Out()
        if is_cast_skill_time(monster.npc, 2010260106, 1) then
          enable_shadow(monster.npc, false)
          set_can_searched(monster.npc, false)
          cast_magic(monster.npc, monster.npc, 100104, 1)
          cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
          cast_magic(monster.npc, monster.npc, 201026010106, 1)
          cast_magic(monster.npc, monster.npc, 201026010111, 1)
          cast_magic(monster.npc, monster.npc, 201026010112, 1)
          cast_magic(monster.npc, monster.npc, 201026010113, 1)
          abort_magic_by_id(monster.npc, 1999215, 5)
        end
      end
      
      monster:doAfter(Out, 1.5)
    end
    
    function jumpA_2.finish(jumpA_2)
      cast_magic(monster.npc, monster.npc, 2010260216, 1)
      
      local function In()
        set_can_searched(monster.npc, true)
        enable_shadow(monster.npc, true)
        abort_magic_by_id(monster.npc, 100104)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK)
        abort_magic_by_id(monster.npc, 201026010111)
        abort_magic_by_id(monster.npc, 201026010112)
        abort_magic_by_id(monster.npc, 201026010113)
        abort_magic_by_id(monster.npc, 201026010106)
        abort_magic_by_id(monster.npc, 201026010142)
        abort_magic_by_id(monster.npc, 201026010144)
      end
      
      monster:doAfter(In, 0.5)
    end
    
    function jumpA_3.start(jumpA_3)
      jumpA_3.base.start(jumpA_3)
      cast_magic(monster.npc, monster.npc, 1999215)
      abort_magic_by_id(monster.npc, 20102301201)
    end
    
    function jumpB_1.start(jumpB_1)
      jumpB_1.base.start(jumpB_1)
      
      local function Out()
        if is_cast_skill_time(monster.npc, 2010260115, 1) then
          enable_shadow(monster.npc, false)
          set_can_searched(monster.npc, false)
          cast_magic(monster.npc, monster.npc, 100104, 1)
          cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
          cast_magic(monster.npc, monster.npc, 201026010106, 1)
          cast_magic(monster.npc, monster.npc, 201026010111, 1)
          cast_magic(monster.npc, monster.npc, 201026010112, 1)
          cast_magic(monster.npc, monster.npc, 201026010113, 1)
          abort_magic_by_id(monster.npc, 1999215, 5)
        end
      end
      
      monster:doAfter(Out, 1.5)
    end
    
    function jumpB_2.finish(jumpB_2)
      cast_magic(monster.npc, monster.npc, 2010260219, 1)
      
      local function In()
        enable_shadow(monster.npc, true)
        set_can_searched(monster.npc, true)
        abort_magic_by_id(monster.npc, 100104)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK)
        abort_magic_by_id(monster.npc, 201026010111)
        abort_magic_by_id(monster.npc, 201026010112)
        abort_magic_by_id(monster.npc, 201026010113)
        abort_magic_by_id(monster.npc, 201026010106)
        abort_magic_by_id(monster.npc, 201026010142)
        abort_magic_by_id(monster.npc, 201026010144)
      end
      
      monster:doAfter(In, 0.5)
    end
    
    function jumpB_3.start(jumpB_3)
      jumpB_3.base.start(jumpB_3)
      cast_magic(monster.npc, monster.npc, 1999215)
      abort_magic_by_id(monster.npc, 20102301201)
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      if check_magic(monster.npc, 2010260218) then
        abort_magic_by_id(monster.npc, 2010260218)
        abort_magic_by_id(monster.npc, 2010260215)
        cast_magic(monster.npc, monster.npc, 2010260217)
      end
      if 1 == monster.ai_state and get_npc_attr(monster.npc, 1) < 1 then
        exit_stun(monster.npc)
        abort_skill(monster.npc, true)
        change_npc_phase_state(monster.npc, 2, false)
        
        function monster.states.Henshin.isReady()
          return true
        end
        
        monster.tree:transState(monster.states.Henshin, true)
      end
    end
  end
  do
    local wheelA = monster.states.wheelA
    local wheelB = monster.states.wheelB
    local Wheel_end_A = monster.states.Wheel_end_A
    local Wheel_end_B = monster.states.Wheel_end_B
    local Wheel_jumpA_1 = monster.states.Wheel_jumpA_1
    local Wheel_jumpA_2 = monster.states.Wheel_jumpA_2
    local Wheel_jumpA_3 = monster.states.Wheel_jumpA_3
    local Wheel_jumpB_1 = monster.states.Wheel_jumpB_1
    local Wheel_jumpB_2 = monster.states.Wheel_jumpB_2
    local Wheel_jumpB_3 = monster.states.Wheel_jumpB_3
    
    function wheelA.start(wheelA)
      wheelA.base.start(wheelA)
      cast_magic(monster.npc, monster.npc, 1999260)
      cast_magic(monster.npc, monster.npc, 1999241)
      set_keyframe_enable(monster.npc, 201026010610, true, true)
    end
    
    function wheelA.finish(wheelA)
      wheelA.base.finish(wheelA)
      abort_magic_by_id(monster.npc, 1999260)
      abort_magic_by_id(monster.npc, 1999241)
      abort_magic_by_id(monster.npc, 1999219)
      set_keyframe_enable(monster.npc, 201026010610, false, true)
    end
    
    function Wheel_jumpA_1.start(Wheel_jumpA_1)
      Wheel_jumpA_1.base.start(Wheel_jumpA_1)
      
      local function Out()
        if is_cast_skill_time(monster.npc, 2010260115, 1) then
          enable_shadow(monster.npc, false)
          set_can_searched(monster.npc, false)
          cast_magic(monster.npc, monster.npc, 100104, 1)
          cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
          cast_magic(monster.npc, monster.npc, 201026010106, 1)
          cast_magic(monster.npc, monster.npc, 201026010111, 1)
          cast_magic(monster.npc, monster.npc, 201026010112, 1)
          cast_magic(monster.npc, monster.npc, 201026010113, 1)
          abort_magic_by_id(monster.npc, 1999215, 5)
        end
      end
      
      monster:doAfter(Out, 1.5)
    end
    
    function Wheel_jumpA_2.finish(Wheel_jumpA_2)
      Wheel_jumpA_2.base.finish(Wheel_jumpA_2)
      cast_magic(monster.npc, monster.npc, 2010260219, 1)
      
      local function In()
        enable_shadow(monster.npc, true)
        set_can_searched(monster.npc, true)
        abort_magic_by_id(monster.npc, 100104)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK)
        abort_magic_by_id(monster.npc, 201026010111)
        abort_magic_by_id(monster.npc, 201026010112)
        abort_magic_by_id(monster.npc, 201026010113)
        abort_magic_by_id(monster.npc, 201026010106)
        abort_magic_by_id(monster.npc, 201026010142)
        abort_magic_by_id(monster.npc, 201026010144)
      end
      
      monster:doAfter(In, 0.5)
    end
    
    function Wheel_jumpA_3.start(Wheel_jumpA_3)
      Wheel_jumpA_3.base.start(Wheel_jumpA_3)
      cast_magic(monster.npc, monster.npc, 1999215)
      abort_magic_by_id(monster.npc, 20102301201)
    end
    
    function Wheel_end_A.start(Wheel_end_A)
      Wheel_end_A.base.start(Wheel_end_A)
      abort_magic_by_id(monster.npc, 1999260)
      abort_magic_by_id(monster.npc, 1999241)
    end
    
    function wheelB.start(wheelB)
      wheelB.base.start(wheelB)
      cast_magic(monster.npc, monster.npc, 1999260)
      cast_magic(monster.npc, monster.npc, 1999241)
      set_keyframe_enable(monster.npc, 201026011510, true, true)
    end
    
    function wheelB.finish(wheelB)
      wheelB.base.finish(wheelB)
      abort_magic_by_id(monster.npc, 1999260)
      abort_magic_by_id(monster.npc, 1999241)
      abort_magic_by_id(monster.npc, 1999219)
      set_keyframe_enable(monster.npc, 201026011510, false, true)
    end
    
    function Wheel_end_B.start(Wheel_end_B)
      Wheel_end_A.base.start(Wheel_end_B)
      abort_magic_by_id(monster.npc, 1999260)
      abort_magic_by_id(monster.npc, 1999241)
    end
    
    function Wheel_jumpB_1.start(Wheel_jumpB_1)
      Wheel_jumpB_1.base.start(Wheel_jumpB_1)
      
      local function Out()
        if is_cast_skill_time(monster.npc, 2010260115, 1) then
          enable_shadow(monster.npc, false)
          set_can_searched(monster.npc, false)
          cast_magic(monster.npc, monster.npc, 100104, 1)
          cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
          cast_magic(monster.npc, monster.npc, 201026010106, 1)
          cast_magic(monster.npc, monster.npc, 201026010111, 1)
          cast_magic(monster.npc, monster.npc, 201026010112, 1)
          cast_magic(monster.npc, monster.npc, 201026010113, 1)
          abort_magic_by_id(monster.npc, 1999215, 5)
        end
      end
      
      monster:doAfter(Out, 1.5)
    end
    
    function Wheel_jumpB_2.finish(Wheel_jumpB_2)
      Wheel_jumpB_2.base.finish(Wheel_jumpB_2)
      cast_magic(monster.npc, monster.npc, 2010260219, 1)
      
      local function In()
        enable_shadow(monster.npc, true)
        set_can_searched(monster.npc, true)
        abort_magic_by_id(monster.npc, 100104)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK)
        abort_magic_by_id(monster.npc, 201026010111)
        abort_magic_by_id(monster.npc, 201026010112)
        abort_magic_by_id(monster.npc, 201026010113)
        abort_magic_by_id(monster.npc, 201026010106)
        abort_magic_by_id(monster.npc, 201026010142)
        abort_magic_by_id(monster.npc, 201026010144)
      end
      
      monster:doAfter(In, 0.5)
    end
    
    function Wheel_jumpB_3.start(Wheel_jumpB_3)
      Wheel_jumpB_3.base.start(Wheel_jumpB_3)
      cast_magic(monster.npc, monster.npc, 1999215)
      abort_magic_by_id(monster.npc, 20102301201)
    end
  end
  do
    local Henshin = monster.states.Henshin
    local Henshin_1 = monster.states.Henshin_1
    local Henshin_2 = monster.states.Henshin_2
    local Henshin_3 = monster.states.Henshin_3
    
    function Henshin.isReady()
      return false
    end
    
    function Henshin.start(Henshin)
      cast_magic(monster.npc, monster.npc, 2010260224, 1)
      cast_magic(monster.npc, monster.npc, 1999241, 1)
      cast_magic(monster.npc, monster.npc, 1999260, 1)
      set_npc_hp_visible(monster.npc, false)
      
      function Henshin.isReady()
        return false
      end
    end
    
    function Henshin.finish(Henshin)
      monster.states.attack.timer = get_npc_time(monster.npc) + 6
      cast_magic(monster.npc, monster.npc, 1999242, 1)
      cast_magic(monster.npc, monster.npc, 1999261, 1)
    end
    
    function Henshin_1.start(Henshin_1)
      exit_stun(monster.npc)
      Henshin_1.base.start(Henshin_1)
      
      local function Out()
        monster.ai_state = 2
        enable_shadow(monster.npc, false)
        set_can_searched(monster.npc, false)
        cast_magic(monster.npc, monster.npc, 100104, 1)
        cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
        cast_magic(monster.npc, monster.npc, 2010260225, 1)
        cast_magic(monster.npc, monster.npc, 2010260226, 1)
        cast_magic(monster.npc, monster.npc, 2010260227, 1)
        abort_magic_by_id(monster.npc, 1999215, 5)
      end
      
      monster:doAfter(Out, 6)
    end
    
    function Henshin_2.start(Henshin_2)
      Henshin_2.base.start(Henshin_2)
      set_npc_controller(monster.npc, 1)
    end
    
    function Henshin_2.finish(Henshin_2)
      cast_magic(monster.npc, monster.npc, 2010260219, 1)
      set_can_searched(monster.npc, true)
      enable_shadow(monster.npc, true)
      abort_magic_by_id(monster.npc, 100104)
      abort_magic_by_id(monster.npc, Const.LOCK_MASK)
      abort_magic_by_id(monster.npc, 2010260224)
      abort_magic_by_id(monster.npc, 2010260225)
      abort_magic_by_id(monster.npc, 2010260226)
      abort_magic_by_id(monster.npc, 2010260227)
      set_npc_hp_visible(monster.npc, true)
      cast_magic(monster.npc, monster.npc, 1999224, 1)
      cast_magic(monster.npc, monster.npc, 1999225, 1)
      cast_magic(monster.npc, monster.npc, 1999330, 1)
      cast_magic(monster.npc, monster.npc, 1999331, 1)
    end
    
    function Henshin_3.start(Henshin_3)
      Henshin_3.base.start(Henshin_3)
      cast_magic(monster.npc, monster.npc, 1999215)
      abort_magic_by_id(monster.npc, 20102301201)
    end
    
    function Henshin_3.finTrans(Henshin_3)
      return monster.states.wander
    end
    
    function monster.states.Henshin_4.start(Henshin_4)
      Henshin_4.base.start(Henshin_4)
      cast_magic(monster.npc, monster.npc, 201026010171)
      local pos_x, pos_y, pos_z = get_area_pos("flash_2")
      local look_pos = {}
      local look_pos_x, look_pos_y, look_pos_z = get_area_pos("M1")
      flash_to_pos(monster.npc, pos_x, pos_z, pos_y)
      lookat_position(monster.npc, look_pos_x, look_pos_z, true)
    end
    
    function monster.states.Henshin_4.finish(Henshin_4)
      Henshin_4.base.finish(Henshin_4)
    end
  end
  do
    local dead = monster.states.dead
    dead.delay = {fx = 3, remove = 3.4}
  end
end

function monster.on_start(monster)
  set_npc_phase_number(monster.npc, 2)
  set_lock_velocity(monster.npc, 2)
  set_npc_joint_active(monster.npc, "PansCollide_1", true)
  change_follow_target(3, monster.npc, {
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
  cast_magic(monster.npc, monster.npc, 201026010125, 1)
  play_effect(monster.npc, "Fx_M201026_rimlight", "Bip001", false)
  monster:xRay()
end

function monster.on_self_npc_hp_zero(monster)
  if 1 == monster.ai_state then
    exit_stun(monster.npc)
    abort_skill(monster.npc, true)
    change_npc_phase_state(monster.npc, 2, false)
    
    function monster.states.Henshin.isReady()
      return true
    end
    
    monster.tree:transState(monster.states.Henshin, true)
  end
  if 2 == monster.ai_state then
    change_npc_phase_state(monster.npc, 1, false)
    monster.base.on_self_npc_hp_zero(monster)
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  for k, v in pairs(monster.track_misslie_list) do
    if v == missile_cfg.Id then
      if monster.hard then
        local function track_end()
          change_linetype(missile, 7, {
            20,
            
            10,
            0
          })
        end
        
        monster:doAfter(track_end, 1)
      else
        local function track_end()
          change_linetype(missile, 7, {
            20,
            
            10,
            0
          })
        end
        
        monster:doAfter(track_end, 1.5)
      end
    end
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  remove_missile_by_id(201026013402, monster.npc)
  remove_missile_by_id(201026014008, monster.npc)
  if monster.hard and 2 == monster.ai_state then
    remove_missile_by_id(201026014002, monster.npc)
    remove_missile_by_id(201026014003, monster.npc)
    remove_missile_by_id(201026014004, monster.npc)
    remove_missile_by_id(201026014005, monster.npc)
    remove_missile_by_id(201026014006, monster.npc)
    remove_missile_by_id(201026014007, monster.npc)
  end
  monster.base.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
end

function monster.flash(monster)
  local hero = get_come_on_hero()
  local pos = get_npc_pos(hero)
  local centerPos = vec3.New(get_area_pos("flash_2"))
  local vec = pos - centerPos
  local norm = vec:Magnitude()
  if norm < 6 then
    vec = vec * 1.4
  end
  pos = vec + centerPos
  flash_to_pos(monster.npc, pos.x, pos.z)
end

return monster
