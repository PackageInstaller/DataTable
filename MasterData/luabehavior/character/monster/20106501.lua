local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local magicIds = {
  HenShin_HP = 1999224,
  HenShin_Toughness = 1999225,
  HenShin_Invisible = 201065010202,
  HenShin_Visible = 201065010203,
  Blade_timer = 201065010107,
  Hide_Invisible = 201065010301
}
local missileIds = {
  redSkillMis = 201065010909,
  shrink_sword = 201065011501,
  Rotating_blade = {
    Deflection_0 = 201065011531,
    Deflection_90 = 201065011532,
    Deflection_180 = 201065011533,
    Deflection_270 = 201065011534
  }
}
local keyframe_id = {}
local camera_id = {default_camera = 20106501}
local CENTER_POINT = {
  x = -108.2126,
  y = 44.3038,
  z = 474.9496
}
local HenshinPos = {
  x = -108.26,
  y = 44.77,
  z = 489.67
}

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local t = monster.create_skill_node_cfg
  local skills = {
    Double_hit1 = t(2010650101),
    Double_hit2 = t(2010650102),
    Spin_hit = t(2010650103, 10, 5, 1, 6, -60, 60),
    jumphit_hit = t(2010650105, 15, 0, 6, 15, -60, 60),
    Breakout = t(2010650106, 10, 5),
    Breakout2 = t(2010650106, nil, 5),
    ReturnPos = t(2010650107, 20, 20),
    Dash_out = t(2010650108, 15, 6, 0, 4, -45, 45),
    Dash_in = t(2010650109),
    slicing_in = t(2010650110),
    slicing_out = t(2010650111),
    mis = t(2010650115),
    Henshin_loop = t(2010650116),
    Henshin_end = t(2010650117),
    Henshin_start = t(2010650118),
    Hide = t(2010650119),
    HideToCounter = t(2010650123, 15, 5),
    ReturnCenter = t(2010650107),
    charge_start = t(2010650120),
    charge_loop = t(2010650121),
    charge_end = t(2010650122)
  }
  local nodes = {
    "HenshinA",
    "slicing",
    "statesA",
    "statesB",
    "Planet",
    "jumphit"
  }
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.ai_state = 1
  monster.TimelineEnd = false
  monster.Stone_timeA = 0
  monster.Stone_timeB = 0
  monster.RoleFaint = false
  monster.Def_cam = 0
  monster.states.attack.interval = 0.5
  monster.Hiderandom = math.random(1, 3)
  monster.evade_config.threshold = 300
  monster.blackHoleGenTimer = nil
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.HenshinA, _ENV.ReturnPos, _ENV.attack, _ENV.wander)
    _ENV.freeAtk(_ENV.statesA)
    _ENV.evade(_ENV.HideToCounter(_ENV.Double_hit1(_ENV.Hide(_ENV.Double_hit2))))
    _ENV.statesA(_ENV.jumphit_hit, _ENV.Dash_out, _ENV.slicing, _ENV.Spin_hit, _ENV.Breakout)
    _ENV.Planet(_ENV.ReturnCenter(_ENV.charge_start(_ENV.charge_loop(_ENV.charge_end))))
    _ENV.ReturnPos(_ENV.Breakout2)
    _ENV.HenshinA(_ENV.Henshin_start(_ENV.Henshin_loop(_ENV.Henshin_end)))
    _ENV.slicing(_ENV.slicing_in, _ENV.slicing_out)
    _ENV.Dash_out(_ENV.Dash_in)
  end
  do
    local _ENV = monster.states
    _ENV.Spin_hit.intervalOffset = 1
    _ENV.jumphit_hit.intervalOffset = 2
    _ENV.Dash_in.intervalOffset = 2
  end
  do
    local jumphit_hit = monster.states.jumphit_hit
    
    function jumphit_hit.moveScale()
      local Scale = {}
      for i = 1, 120 do
        Scale[i] = 1
      end
      for i = 1, 22 do
        Scale[i] = monster:Calculate_scale(15, 1)
      end
      return Scale
    end
  end
  do
    local slicing = monster.states.slicing
    local slicing_in = monster.states.slicing_in
    local slicing_out = monster.states.slicing_out
    slicing.timer = 15
    slicing.cd = 10
    slicing.random = math.random(0, 1)
    
    function slicing.isReady(slicing)
      if get_npc_distance(monster.npc, 1, monster.target, false) < 5 then
        return get_npc_time(monster.npc) > slicing.timer
      end
    end
    
    function slicing.finish(slicing)
      slicing.random = math.random(0, 1)
      slicing.timer = get_npc_time(monster.npc) + slicing.cd
    end
    
    function slicing_in.isReady()
      if 0 == slicing.random then
        return true
      end
      return false
    end
    
    function slicing_out.isReady()
      if 1 == slicing.random then
        return true
      end
      return false
    end
  end
  do
    local ReturnPos = monster.skills.ReturnPos
    local wander = monster.states.wander
    local ReturnPosStates = monster.states.ReturnPos
    ReturnPosStates.timer = 20
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      local ReturnPos = states.ReturnPos
      local tree = monster.tree
      if not monster.target then
        return states.noTarget
      end
      if ReturnPos.base.isReady(ReturnPos) then
        return ReturnPos
      end
      if states.attack then
        return tree:chooseChildAction(states.attack)
      end
    end
    
    function ReturnPosStates.isReady(ReturnPosStates)
      if not check_npc_distance_to_pos(monster.npc, CENTER_POINT.x, CENTER_POINT.z, 12, false) and ReturnPosStates.timer < get_npc_time(monster.npc) then
        return ReturnPosStates.base.isReady(ReturnPosStates)
      end
      return false
    end
    
    function ReturnPosStates.start(ReturnPosStates)
      ReturnPosStates.timer = get_npc_time(monster.npc) + 20
      ReturnPosStates.base.start(ReturnPosStates)
    end
    
    function ReturnPosStates.finTrans()
      return wander
    end
    
    function ReturnPos.target(ReturnPos)
    end
    
    function ReturnPos.tarPos(ReturnPos)
      local distance = get_npc_distance(monster.npc, 2, CENTER_POINT.x, CENTER_POINT.z, false)
      local pos = get_position_offset_position(CENTER_POINT, get_npc_pos(monster.npc), 0, distance + 2)
      return pos
    end
    
    function ReturnPos.moveScale(ReturnPos)
      local scale = monster:Calculate_scale(10.5, 1.1, CENTER_POINT)
      return scale
    end
    
    function monster.states.Breakout2.finTrans(Breakout2)
      return monster.states.wander
    end
  end
  do
    local Dash_in = monster.states.Dash_in
    
    function Dash_in.start(Dash_in)
      lookat_npc(monster.npc, monster.target, true)
      Dash_in.base.start(Dash_in)
    end
  end
  monster.black_hole_missiles = {}
  monster.henshin_time = get_npc_time(monster.npc)
  do
    local HenshinA = monster.states.HenshinA
    local Henshin_start = monster.states.Henshin_start
    local Henshin_loop = monster.states.Henshin_loop
    local Henshin_end = monster.states.Henshin_end
    
    function HenshinA.isReady()
      return false
    end
    
    function HenshinA.start(HenshinA)
      cast_magic(monster.npc, monster.npc, 1999241, 1)
      cast_magic(monster.npc, monster.npc, 1999260, 1)
    end
    
    function HenshinA.finTrans(HenshinA)
      return monster.states.wander
    end
    
    function Henshin_start.tick(Henshin_start)
      local roleNpc = get_come_on_hero()
      local role = roleNpc and roleNpc:get_behavior()
      if not role:isInUlt() then
        Henshin_start:derive()
      end
    end
    
    function Henshin_loop.start(Henshin_loop)
      flash_to_pos(monster.npc, HenshinPos.x, HenshinPos.z, HenshinPos.y, false)
      lookat_position(monster.npc, CENTER_POINT.x, CENTER_POINT.z, true)
      cast_magic(monster.npc, monster.npc, magicIds.HenShin_HP, 1)
      change_follow_target_new(0)
      if get_tough_record_state(monster.npc) then
        cast_magic(monster.npc, monster.npc, magicIds.HenShin_Toughness, 1)
      end
      char_visible(true)
      cast_magic(monster.npc, monster.npc, magicIds.HenShin_Invisible, 1)
      play_timeline("TIMELINE9_1_1_0", 0, 0, nil, false, true, true, false)
      switch_bgm_block("bgm_chapter_ex1_boss", 2)
      set_camera(1, false, true, function(camera_cfg)
        camera_cfg.DefaultDistance = 12
        camera_cfg.DefaultHeight = 5
      end)
      set_camera_focal_by_pos(CENTER_POINT.x, CENTER_POINT.y, CENTER_POINT.z)
      set_scene_tips(20106501, true, {})
      monster.henshin_time = get_npc_time(monster.npc) + 10
      Henshin_loop.base.start(Henshin_loop)
    end
    
    function Henshin_loop.tick(Henshin_loop)
      if monster.TimelineEnd then
        monster:Sword(nil, 0.2)
      end
      do
        local x, y = -108.29, 480.74
        local missile_id = {
          [1] = 201065011561,
          [2] = 201065011562,
          [3] = 201065011563,
          [4] = 201065011564
        }
        monster.now_time = get_npc_time(monster.npc)
        if monster.now_time >= monster.henshin_time then
          monster.henshin_time = monster.now_time + 3
          if not monster.fake_black_holes_initialized then
            monster.fake_black_holes_initialized = true
            monster.black_hole_missiles = {}
            for i = 1, 4 do
              local offset_x, offset_y = 0, 0
              if 2 == i then
                offset_y = -16
              end
              if 3 == i then
                offset_x, offset_y = -8, -8
              end
              if 4 == i then
                offset_x, offset_y = 8, -8
              end
              monster.black_hole_missiles[i] = cast_missile3(monster.npc, nil, x + offset_x, y + offset_y, missile_id[i], 0)
            end
            return
          end
          if not monster.black_hole_duration then
            monster.black_hole_duration = 3
          else
            monster.black_hole_duration = monster.black_hole_duration + 0.8
          end
          if not monster.sequence_index then
            monster.sequence_index = 1
          end
          local index = monster.sequence_index
          if index <= 4 then
            if monster.last_true_black_hole_index then
              remove_missile_by_id(201065011520, monster.npc, true)
              remove_missile_by_id(201065011565, monster.npc, true)
            end
            if monster.black_hole_missiles[index] then
              remove_missile_by_id(missile_id[index], monster.npc, true)
              monster.black_hole_missiles[index] = nil
            end
            local offset_x, offset_y = 0, 0
            if 2 == index then
              offset_y = -16
            end
            if 3 == index then
              offset_x, offset_y = -8, -8
            end
            if 4 == index then
              offset_x, offset_y = 8, -8
            end
            monster.black_hole_missiles[index] = cast_missile3(monster.npc, nil, x + offset_x, y + offset_y, 201065011520, 0)
            monster.last_true_black_hole_index = index
            monster.sequence_index = index + 1
          elseif not monster.final_black_hole_hold_time_set then
            monster.henshin_time = monster.now_time + monster.black_hole_duration + 1
            monster.final_black_hole_hold_time_set = true
          elseif not monster.final_black_hole_cleared then
            if monster.last_true_black_hole_index then
              remove_missile_by_id(201065011520, monster.npc, true)
              monster.black_hole_missiles[monster.last_true_black_hole_index] = nil
              monster.last_true_black_hole_index = nil
            end
            monster.final_black_hole_cleared = true
          end
        end
      end
    end
    
    function Henshin_end.start(Henshin_end)
      Henshin_end.base.start(Henshin_end)
      set_scene_tips(20106501, false, {})
      remove_missile_by_id(201065011520, monster.npc, true)
      remove_missile_by_id(201065011561, monster.npc, true)
      remove_missile_by_id(201065011562, monster.npc, true)
      remove_missile_by_id(201065011563, monster.npc, true)
      remove_missile_by_id(201065011564, monster.npc, true)
      remove_missile_by_id(201065011565, monster.npc, true)
      if get_cur_camera_id() ~= monster.Def_cam then
        set_camera(monster.Def_cam, true)
      end
      remove_missile_by_id(201065011507, monster.npc, true)
      remove_missile_by_id(201065011508, monster.npc, true)
      remove_missile_by_id(201065011509, monster.npc, true)
      remove_missile_by_id(201065011515, monster.npc, true)
      
      local function delay()
        change_follow_target_new(3, monster.npc, {
          5,
          0,
          {
            x = 0,
            y = 0,
            z = 0
          },
          1,
          0.6
        })
      end
      
      monster:doAfter(delay, 1.8)
      cast_magic(monster.npc, monster.npc, 1999242, 1)
      cast_magic(monster.npc, monster.npc, 1999261, 1)
    end
    
    function Henshin_end.finish(Henshin_end)
      Henshin_end.base.finish(Henshin_end)
      monster.states.ReturnPos.timer = get_npc_time(monster.npc) + 20
      monster.ai_state = 3
      if monster.RoleFaint == true then
      end
      cast_magic(monster.npc, monster.npc, magicIds.Blade_timer)
      monster.evade_config.threshold = 100
      do
        local random = monster.Hiderandom
        local Hide = monster.skills.Hide
        local jumphit_hit = monster.skills.jumphit_hit
        local Double_hit1 = monster.skills.Double_hit1
        do
          local evade = monster.states.evade
          local Hide = monster.states.Hide
          evade(Hide)
          Hide()
        end
        Hide(Double_hit1)
        
        function Hide.onEnd(Hide)
          Hide.base.onEnd(Hide)
          random = math.random(1, 3)
          do
            local _ENV = monster.skills
            if 1 == random then
              Hide(_ENV.Double_hit2)
            elseif 2 == random then
              Hide(jumphit_hit)
            else
              Hide(_ENV.Spin_hit)
            end
          end
        end
      end
      do
        local _ENV = monster.states
        _ENV.Spin_hit.cd = 15
        _ENV.jumphit_hit.cd = 20
        _ENV.Dash_out.cd = 20
      end
    end
  end
end

function monster.Calculate_scale(monster, Animation_shift, proportion, TarPointA, TarPointB)
  local Distance
  if TarPointB then
    Distance = 15 - get_npc_distance(monster.npc, 2, TarPointB.x, TarPointB.z, false)
  elseif not TarPointA then
    Distance = get_npc_distance(monster.npc, 1, monster.target, false)
  else
    Distance = get_npc_distance(monster.npc, 2, TarPointA.x, TarPointA.z, false)
  end
  local ratio = Distance / Animation_shift * proportion
  return ratio
end

function monster.on_start(monster)
  change_follow_target_new(3, monster.npc, {
    5,
    10,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6
  })
  monster:xRay()
  enable_shadow(monster.npc, false)
  set_camera(camera_id.default_camera, true, false)
  set_npc_phase_number(monster.npc, 2)
end

function monster.on_keyframe_action(monster, kfId, npcTag, comnTag)
  if "selfpos" == npcTag then
    local Tarpos, is_walkable, pos
    Tarpos = get_position_offset_position(get_npc_pos(get_come_on_hero()), get_npc_pos(monster.npc), 120, 8)
    is_walkable, pos = get_nearest_walkable_pos(get_npc_pos(monster.npc), Tarpos, 1)
    if is_walkable then
      monster.BlinkPos = Tarpos
    else
      monster.BlinkPos = pos
    end
  end
  if "blink" == npcTag then
    local looat_pos = get_npc_pos(monster.target)
    monster:tp(monster.BlinkPos, 20, looat_pos, 0)
  end
  if "NpcUP" == npcTag then
    remove_missile_by_id(201065011523, monster.npc, true)
    monster:UnLock(get_come_on_hero())
  end
  if "TpToCenter" == npcTag then
    monster:tp(CENTER_POINT, 30)
  end
  if 201065010916 == kfId and 3 == monster.ai_state then
    monster:Random_sword()
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201065011501 then
    local function delay()
      change_linetype(missile, 1, {0, 0})
    end
    
    monster:doAfter(delay, 1)
  end
  for key, value in pairs(missileIds.Rotating_blade) do
    if missile_cfg.Id == value then
      table.insert(monster.states.charge_loop.mis, missile)
      print(monster.states.charge_loop.mis)
    end
  end
  if missile_cfg.Id == 201065011546 then
    local function delay()
      change_linetype(missile, 1, {0, 0})
    end
    
    monster:doAfter(delay, 1)
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile, is_break)
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc and m2_cfg.Id == missileIds.redSkillMis then
    monster:try_red_skill_counter(m1, m2)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 201065011522 then
    monster.states.Henshin_loop.tick = Const.NIL_FUN
    local Henshin_loop = monster.states.Henshin_loop
    missile.isHit = true
    cast_missile3(monster.npc, nil, missile.v_born_pos.x, missile.v_born_pos.z, 201065011523, 0)
    monster:Lock(get_come_on_hero())
    remove_missile_by_id(201065011515, monster.npc, true)
    if monster.blackHoleGenTimer then
      monster.blackHoleGenTimer:Cancel()
      monster.blackHoleGenTimer = nil
      remove_missile_by_id(201065011520, monster.npc, true)
    end
    
    local function delay()
      if monster.state == Henshin_loop then
        Henshin_loop:derive()
      end
    end
    
    monster:doAfter(delay, 1.5)
    remove_missile_by_id(201065011561, monster.npc, true)
    remove_missile_by_id(201065011562, monster.npc, true)
    remove_missile_by_id(201065011563, monster.npc, true)
    remove_missile_by_id(201065011564, monster.npc, true)
    remove_missile_by_id(201065011520, monster.npc, true)
  end
end

function monster.on_timeline_end(monster, timeline_name)
  if "TIMELINE9_1_1_0" == timeline_name then
    set_sceneobj_visible_save_state("/Root/SkyBox_/SkyBox_Night", false, false)
    set_sceneobj_visible_save_state("/Root/Change_/Change_Night/FX/scenes_skybox_pre", false, false)
    cast_magic(monster.npc, monster.npc, magicIds.HenShin_Visible, 1)
    char_visible(false)
    cast_missile3(monster.npc, nil, CENTER_POINT.x, CENTER_POINT.z, 201065011508, nil, nil, nil, nil, CENTER_POINT.y)
    cast_missile3(monster.npc, nil, CENTER_POINT.x, CENTER_POINT.z, 201065011507, nil, nil, nil, nil, CENTER_POINT.y)
    cast_missile3(monster.npc, nil, CENTER_POINT.x, CENTER_POINT.z, 201065011509, nil, nil, nil, nil, CENTER_POINT.y)
    cast_missile3(monster.npc, nil, CENTER_POINT.x, CENTER_POINT.z, 201065011515, nil, nil, nil, nil, CENTER_POINT.y)
    monster.TimelineEnd = true
  end
end

function monster.on_self_npc_hp_zero(monster)
  if 1 == monster.ai_state then
    change_npc_phase_state(monster.npc, 2, false)
    monster.ai_state = 2
    monster.Def_cam = get_cur_camera_id()
    exit_stun(monster.npc)
    monster:transState(monster.states.HenshinA, true)
    set_sceneobj_visible_save_state("/Root/Scene/Zone_03/FX/FX_ThunderStorm", false, false)
  end
  if 3 == monster.ai_state then
    change_npc_phase_state(monster.npc, 1, false)
    monster.base.on_self_npc_hp_zero(monster)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 201065010107 == magic_id then
    cast_missile3(monster.npc, monster.target, nil, nil, 201065011501)
    
    local function delay()
      cast_magic(monster.npc, monster.npc, magicIds.Blade_timer)
    end
    
    monster:doAfter(delay, math.random(5, 10))
  end
end

function monster.Lock(monster, target)
  monster.RoleFaint = true
  set_camera(monster.Def_cam, true)
  change_follow_target_new(3, nil, {
    5,
    10,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6,
    [10] = {
      x = CENTER_POINT.x,
      y = CENTER_POINT.y,
      z = CENTER_POINT.z - 10
    }
  })
  cast_missile3(monster.npc, monster.target, nil, nil, 201065011525, 0)
  cast_magic(monster.npc, get_come_on_hero(), magicIds.Hide_Invisible)
  monster.tool.roleFaint(target, 999, 999)
  char_visible(true)
end

function monster.UnLock(monster, target)
  monster.tool.roleFaintFinish(target)
  cast_missile3(monster.npc, monster.target, nil, nil, 201065011526, 0)
  char_visible(false)
end

function monster.Sword(monster, StoneA_cd, StoneB_cd)
  local missile = 201065011503
  local Hero_pos = get_npc_pos(get_come_on_hero())
  local nowTime = get_npc_time(monster.npc)
  if StoneA_cd and nowTime > monster.Stone_timeA then
    local center_x, center_z = CENTER_POINT.x, CENTER_POINT.z
    local scale = 4
    local target_pos_x = Hero_pos.x
    local target_pos_z = Hero_pos.z
    repeat
      local angle = math.random() * 2 * math.pi
      target_pos_x = Hero_pos.x + math.random(-scale, scale) * math.cos(angle)
      target_pos_z = Hero_pos.z + math.random(-scale, scale) * math.sin(angle)
      local Distance_to_center = math.sqrt((target_pos_x - center_x) ^ 2 + (target_pos_z - center_z) ^ 2)
    until Distance_to_center < 25
    cast_missile3(monster.npc, nil, target_pos_x, target_pos_z, missile, 0)
    monster.Stone_timeA = nowTime + StoneA_cd
  end
  if StoneB_cd and nowTime > monster.Stone_timeB then
    local target_pos_x = CENTER_POINT.x
    local target_pos_z = CENTER_POINT.z
    local born_pos_y = Hero_pos.y + 20
    local angle = math.random() * 2 * math.pi
    local radius = math.random(6, 14)
    target_pos_x = target_pos_x + radius * math.cos(angle)
    target_pos_z = target_pos_z + radius * math.sin(angle)
    cast_missile3(monster.npc, nil, target_pos_x, target_pos_z, missile, 0)
    monster.Stone_timeB = nowTime + StoneB_cd
  end
end

function monster.Random_sword(monster)
  local Hero_pos = get_npc_pos(monster.target)
  local scale = 6
  local target_pos_x = Hero_pos.x
  local target_pos_z = Hero_pos.z
  for i = 1, 3 do
    local angle = math.random() * 2 * math.pi
    target_pos_x = Hero_pos.x + math.random(-scale, scale) * math.cos(angle)
    target_pos_z = Hero_pos.z + math.random(-scale, scale) * math.sin(angle)
    cast_missile3(monster.npc, nil, target_pos_x, target_pos_z, 201065011505, 0)
  end
end

return monster
