local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 999,
    minTime = 5,
    maxTime = 5,
    type = "walk"
  }
  monster.turnCount = 0
  monster.hitcheck = false
  monster.runhitcheck = false
  monster.ShouldRoar1 = false
  monster.RunCheckMissile = nil
  monster.runhitcheck1 = false
  monster.onlyenteronce = true
  monster.needskillX, monster.needskillY, monster.needskillZ = get_area_pos("M2")
  monster.CompanySkillplace = {
    x = monster.needskillX,
    y = monster.needskillY,
    z = monster.needskillZ
  }
  monster.centerX, monster.centerY, monster.centerZ = get_area_pos("center")
  monster.centerplace = {
    x = monster.centerX,
    y = monster.centerY,
    z = monster.centerZ
  }
  monster.SetAllowCastCompanySkill3 = true
  monster.Allowattackforphase2 = false
  monster.BearIsPreparingCompany = false
  monster.WuShiCompanyIsReady = false
  monster.BearAllowCastCompany = false
  local skills = {
    Runstart = {
      2020470101,
      4,
      0,
      4,
      999
    },
    RunLoop = {
      2020470102,
      0,
      0
    },
    RunEnd = {
      2020470103,
      0,
      0
    },
    RunPunch = {
      2020470104,
      0,
      0,
      0,
      4,
      -35,
      35
    },
    DoubleHit = {
      2020470105,
      12,
      0,
      0,
      4
    },
    BigSmash = {
      2020470106,
      8,
      0,
      0,
      4,
      -40,
      40
    },
    TurnPunch = {
      2020470107,
      10,
      0,
      0,
      4,
      -180,
      -90
    },
    ThrowStone = {
      2020470108,
      7,
      4,
      9,
      999,
      -45,
      45
    },
    frontPush = {
      2020470109,
      7,
      0,
      0,
      10,
      -40,
      40
    },
    RiseGround = {
      2020470110,
      7,
      0,
      0,
      6,
      -40,
      40
    },
    AssSmash = {
      2020470112,
      7,
      0,
      0,
      4,
      135,
      225
    },
    Rage = {
      2020470113,
      3,
      0
    },
    HeavyHit = {
      2020470114,
      0,
      0,
      0,
      4,
      -40,
      40
    },
    Roar = {
      2020470115,
      0,
      0,
      0,
      999
    },
    TurnLeft = {
      2020470116,
      0,
      0,
      0,
      999,
      -180,
      -30
    },
    TurnRight = {
      2020470117,
      0,
      0,
      0,
      999,
      30,
      180
    },
    companyskill1 = {
      2020470136,
      60,
      10,
      0,
      9,
      -40,
      40
    },
    companyskill2 = {
      2020470137,
      30,
      10,
      0,
      6
    },
    companyskill3 = {
      2020470138,
      30,
      10,
      0,
      6
    },
    DoubleHit1 = {
      2020470118,
      10,
      0,
      0,
      5,
      -40,
      40
    },
    AssSmash2 = {
      2020470119,
      5,
      0,
      0,
      999,
      135,
      225
    },
    Runstart1 = {
      2020470120,
      0,
      0,
      0,
      999
    },
    TurnPunch2 = {
      2020470121,
      5,
      0,
      0,
      999,
      -250,
      -40
    },
    Runstart2 = {
      2020470122,
      5,
      0,
      4,
      999
    },
    HeavyHit1 = {
      2020470123,
      0,
      0,
      0,
      5,
      -40,
      40
    },
    BigSmash1 = {
      2020470124,
      5,
      0,
      0,
      999,
      -45,
      45
    },
    frontPush1 = {
      2020470125,
      8,
      0,
      0,
      8,
      -35,
      35
    },
    RiseGround1 = {
      2020470128,
      5,
      0,
      0,
      8,
      -35,
      35
    },
    ThrowStone1 = {
      2020470129,
      5,
      0,
      4,
      999,
      -45,
      45
    },
    AssSmash1 = {
      2020470119,
      5,
      0,
      0,
      999,
      135,
      225
    },
    TurnPunch1 = {
      2020470121,
      5,
      0,
      0,
      999,
      -250,
      -40
    }
  }
  local nodes = {
    "attackforphase1",
    "attackforphase2",
    "turn",
    "close",
    "veryfar",
    "close1",
    "far1",
    "companyskill",
    "HalflifeRage",
    "GroupAtkForTwinBoss",
    "CloseAtk",
    "FarAtk",
    "companyskillready",
    "ForTwoBoss"
  }
  local actMoves = {"RunToPos", "RunToPos1"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.attack.interval = 0
    _ENV.gotTarget(_ENV.Roar, _ENV.AssSmash1, _ENV.TurnPunch1, _ENV.turn, _ENV.attack)
    _ENV.attack(_ENV.freeAtk)
    _ENV.freeAtk(_ENV.ForTwoBoss, _ENV.HalflifeRage, _ENV.attackforphase2, _ENV.attackforphase1)
    _ENV.attackforphase1(_ENV.CloseAtk, _ENV.FarAtk)
    _ENV.CloseAtk(_ENV.DoubleHit, _ENV.frontPush, _ENV.HeavyHit, _ENV.RiseGround, _ENV.AssSmash)
    _ENV.FarAtk(_ENV.ThrowStone, _ENV.Runstart)
    _ENV.ForTwoBoss(_ENV.companyskill)
    _ENV.companyskill(_ENV.companyskillready(_ENV.companyskill1, _ENV.companyskill2, _ENV.companyskill3))
    _ENV.HalflifeRage(_ENV.Rage)
    _ENV.turn(_ENV.TurnLeft, _ENV.TurnRight)
    _ENV.TurnLeft(_ENV.TurnLeft, _ENV.TurnRight)
    _ENV.TurnRight(_ENV.TurnLeft, _ENV.TurnRight)
    _ENV.attackforphase2(_ENV.close1(_ENV.DoubleHit1, _ENV.frontPush1, _ENV.RiseGround1, _ENV.HeavyHit1), _ENV.far1(_ENV.ThrowStone1, _ENV.Runstart1))
  end
  monster.WushiNpc = nil
  monster.states.dead.delay = {fx = 1.6, remove = 3}
  
  function monster.states.active.tick(active)
    if monster.WushiNpc == nil and nil ~= search_npc(monster.npc, 2, 10, nil, false, false, 300100504) then
      monster.WushiNpc = search_npc(monster.npc, 2, 10, nil, false, false, 300100504)
      if monster.WushiNpc then
        listen_attr_change_mq(monster.npc, 1, monster.state_inspection, monster)
        listen_attr_change_mq(monster.WushiNpc, 1, monster.state_inspection, monster)
      end
    end
  end
  
  function monster.states.ForTwoBoss.isReady(ForTwoBoss)
    if monster.Allowattackforphase2 == true then
      return false
    else
      return true
    end
  end
  
  function monster.states.companyskill.isReady(companyskill)
    if monster.tree:chooseChildAction(companyskill.monster.states.companyskillready) then
      if monster.WuShiCompanyIsReady == true then
        if get_npc_distance(monster.npc, 3, 1, true) <= 5 then
          monster.WushiNpc:get_behavior():CompanySkillReturnFalse(monster)
          monster.WuShiCompanyIsReady = false
          return false
        else
          return true
        end
      elseif monster.WuShiCompanyIsReady == false then
        monster.WushiNpc:get_behavior():WushiPrepareForCompany(monster)
        return false
      end
    end
  end
  
  function monster.states.companyskill1.start(companyskill1)
    companyskill1.base.start(companyskill1)
    set_keyframe_enable(monster.npc, 202047013631, false, false)
    set_keyframe_enable(monster.npc, 202047013632, false, false)
    set_keyframe_enable(monster.npc, 202047013633, false, false)
  end
  
  function monster.states.companyskillready.start(companyskillready)
    local player = get_come_on_hero()
    companyskillready.base.start(companyskillready)
    monster.WushiNpc:get_behavior():WushiGoToGuaji(monster)
    monster.WuShiCompanyIsReady = false
    monster.WushiNpc:get_behavior():CompanySkillReturnFalse(monster)
    lookat_npc(companyskillready.monster.npc, player, false)
    cast_magic(monster.npc, monster.WushiNpc, 30010050203, 1)
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
  end
  
  function monster.states.companyskillready.finish(companyskillready)
    companyskillready.base.finish(companyskillready)
    abort_magic_by_id(companyskillready.monster.npc, 30010050226, 1)
    monster.WushiNpc:get_behavior():WushiStopGuaji(monster)
    change_follow_target(4)
  end
  
  function monster.states.companyskill3.tick(companyskill3)
    local frame = companyskill3.monster.npc.skill_mgr:get_skill(2020470138).v_frame
    local player = get_come_on_hero()
    if 79 == frame and get_target_angel(companyskill3.monster.npc, player, true) < 0 then
      set_keyframe_enable(companyskill3.monster.npc, 202047013811, false, false)
    end
  end
  
  function monster.states.HalflifeRage.isReady(HalflifeRage)
    if monster.tool.HalflifeRage == true then
      return true
    else
      return false
    end
  end
  
  function monster.states.RunToPos1.start(RunToPos1)
    switch_move_type(RunToPos1.monster.npc, 1)
    move_to_pos(RunToPos1.monster.npc, RunToPos1.monster.CompanySkillplace)
  end
  
  function monster.states.RunToPos1.tickTrans(RunToPos1)
    if check_npc_distance_to_pos(RunToPos1.monster.npc, monster.needskillX, monster.needskillZ, 1.5, true) then
      return RunToPos1.monster.states.Rage
    end
  end
  
  function monster.states.Rage.start(Rage)
    local player = get_come_on_hero()
    lookat_npc(Rage.monster.npc, player, false)
    Rage.base.start(Rage)
    create_scene_effect("Fx_M201047_Fog", monster.centerplace, 99999999, "Fx_M201047_Fog")
    abort_magic_by_id(monster.npc, 2030430147, 1)
    switch_bgm_block("bgm_chapter5_Boss", 2)
    monster.Allowattackforphase2 = true
    monster.tool.HalflifeRage = false
  end
  
  function monster.states.attackforphase2.isReady(attackforphase2)
    if monster.Allowattackforphase2 == true then
      return true
    else
      return false
    end
  end
  
  function monster.states.attackforphase1.isReady(attackforphase2)
    if monster.Allowattackforphase2 == true then
      return false
    else
      return true
    end
  end
  
  function states.AssSmash1.finTrans(AssSmash1)
    return AssSmash1.monster.states.gotTarget
  end
  
  function states.Roar.finTrans(Roar)
    return Roar.monster.states.gotTarget
  end
  
  function states.Roar.isReady(Roar)
    if Roar.monster.WushiNpc ~= nil then
      local HpMax = get_npc_attr(Roar.monster.npc, 4)
      local CurretHP = get_npc_attr(Roar.monster.npc, 1)
      local WushiHpMax = get_npc_attr(Roar.monster.WushiNpc, 4)
      local WushiCurretHP = get_npc_attr(Roar.monster.WushiNpc, 1)
      if CurretHP >= HpMax * 0.25 and monster.tool.rest == true and WushiCurretHP >= WushiHpMax * 0.25 and monster.tool.rest == true then
        return true
      else
        return false
      end
    end
  end
  
  function states.Roar.start(Roar)
    Roar.base.start(Roar)
    monster.tool.rest = false
  end
  
  function states.TurnPunch1.isReady(TurnPunch1)
    if get_npc_distance(TurnPunch1.monster.npc, 3, nil, true) >= 2 then
      TurnPunch1.base.isReady(TurnPunch1)
    end
  end
  
  function states.TurnPunch1.finTrans(TurnPunch1)
    return TurnPunch1.monster.states.gotTarget
  end
  
  do
    local Runstart = monster.skills.Runstart
    local RunLoop = monster.skills.RunLoop
    local RunEnd = monster.skills.RunEnd
    local RunPunch = monster.skills.RunPunch
    Runstart(RunLoop(RunPunch, RunEnd))
    
    function skills.RunPunch.isReady(RunPunch)
      if monster.runhitcheck1 == true then
        monster.runhitcheck1 = false
        return false
      end
      return true
    end
    
    function skills.RunLoop.onEnd(RunLoop)
      cast_magic(monster.npc, monster.npc, 2020470102, 1)
      RunLoop.base.onEnd(RunLoop)
    end
    
    function skills.RunLoop.onBegin(RunLoop)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470103, 1)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470104, 1)
    end
    
    function skills.RunPunch.onEnd(RunPunch)
      RunPunch.base.onEnd(RunPunch)
      abort_magic_by_id(monster.npc, 2020470103, 1)
      abort_magic_by_id(monster.npc, 2020470104, 1)
    end
    
    function skills.RunEnd.onEnd(RunEnd)
      RunEnd.base.onEnd(RunEnd)
      abort_magic_by_id(monster.npc, 2020470103, 1)
      abort_magic_by_id(monster.npc, 2020470104, 1)
    end
    
    function skills.RunLoop.tick(RunLoop)
      RunLoop.base.tick(RunLoop)
      if monster.runhitcheck == true then
        monster.runhitcheck = false
        monster.runhitcheck1 = true
        if monster.RunCheckMissile ~= nil then
          stop_missile(monster.RunCheckMissile)
        end
        monster:doAfter(function(monster)
          RunLoop:deriveAuto()
        end, 1)
      end
    end
    
    local Runstart1 = monster.skills.Runstart1
    local RunLoop = monster.skills.RunLoop
    local RunEnd = monster.skills.RunEnd
    local RunPunch = monster.skills.RunPunch
    Runstart1(RunLoop(RunPunch, RunEnd))
  end
  
  function states.attack.start(attack)
    attack.base.start(attack)
    monster.tool.attackcount = monster.tool.attackcount + 1
  end
  
  function states.attack.finTrans(attack)
    return attack.monster.states.gotTarget
  end
  
  function states.turn.finTrans(turn)
    return turn.monster.states.gotTarget
  end
end

function monster.on_magic_begin(monster, npc, target, magic_id)
  if npc ~= monster.npc then
    return
  end
end

function monster.on_before_npc_hp_zero(monster, npc)
  if npc ~= monster.npc then
    return
  end
  monster.tool.BearAlive = false
  monster.tool.WushiIsMainAttacker = true
  set_npc_hp_bar_type(monster.npc, 0)
  monster:doAfter(function()
    set_npc_hp_bar_type(monster.WushiNpc, 4)
  end, -1)
  abort_magic_by_id(monster.WushiNpc, 20103401067, 1)
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  monster.base.before_damage_target(monster, target, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  if 2020470116 == magic_id then
    monster.tool.roleFaintFinish(target)
  end
  if 2020470116 == magic_id then
    monster.tool.roleFaintFinish(target)
  end
end

function monster.on_toughness_change(npc, camp, change_level)
  if npc == monster.npc and (1 == change_level or 2 == change_level or 3 == change_level or 4 == change_level or 5 == change_level or 0 == change_level) then
    monster.tool.WushiIsMainAttacker = true
    monster.mainattackertimer = get_npc_time(active.monster.npc)
  end
end

function monster.GetWushiCompanyIsReady(monster)
  monster.WuShiCompanyIsReady = true
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 202047013604 then
    monster.tool.roleFaint(hit_target, 1.27)
  end
  if missile_cfg.Id == 202047013619 then
    set_keyframe_enable(monster.npc, 202047013631, true, false)
    set_keyframe_enable(monster.npc, 202047013632, true, false)
    set_keyframe_enable(monster.npc, 202047013633, true, false)
  end
  if missile_cfg.Id == 202047013703 then
    monster.tool.roleFaint(hit_target, 3)
  end
  if missile_cfg.Id == 202047013803 then
    monster.tool.roleFaint(hit_target, 2.8)
  end
  if 1 == get_role_kind(hit_target) and missile_cfg.Id == 202047010210 and monster.runhitcheck == false then
    local RunLoop = monster.skills[skill_id]
    RunLoop:deriveAuto()
  end
end

function monster.on_start(monster)
  monster:xRay()
  switch_bgm_block("bgm_chapter5_Boss", 0)
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc and m2_cfg.Id ~= 10010233501 and m2_cfg.Id ~= 10010233502 then
    local magics = m1_cfg.magic
    local magicId = magics and magics[1]
    local magicCfg = magicId and ShareRes.get_magic_cfg(magicId)
    if nil ~= magics and nil ~= magicId and nil ~= magicCfg and 2 == magicCfg.logic[1] then
      cast_magic(monster.npc, player, 2020470109, 1)
      cast_magic(monster.npc, player, 201025030806, 1)
      create_scene_effect("Fx_M201047_water_hit_3", get_missile_pos(m2), 5, nil, get_npc_pos(monster.npc))
      rebound_missile(m2, player, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z, 10, false, false, true)
      cast_magic(monster.npc, player, 201025030809, 1)
      cast_magic(monster.npc, player, 201025030810, 1)
      cast_magic(monster.npc, player, 2020470145, 1)
    end
  end
  if m1_owner == monster.npc and m2_owner == player and m1_cfg.Id ~= 10010233501 and m1_cfg.Id ~= 10010233502 then
    local magics = m2_cfg.magic
    local magicId = magics and magics[1]
    local magicCfg = magicId and ShareRes.get_magic_cfg(magicId)
    if nil ~= magics and nil ~= magicId and nil ~= magicCfg and 2 == magicCfg.logic[1] then
      cast_magic(monster.npc, player, 2020470109, 1)
      cast_magic(monster.npc, player, 201025030806, 1)
      create_scene_effect("Fx_M201047_water_hit_3", get_missile_pos(m2), 5, nil, get_npc_pos(monster.npc))
      rebound_missile(m1, player, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z, 10, false, false, true)
      cast_magic(monster.npc, player, 201025030809, 1)
      cast_magic(monster.npc, player, 201025030810, 1)
      cast_magic(monster.npc, player, 2020470145, 1)
    end
  end
end

function monster.state_inspection(monster, npc, attr_type, change_value)
  if monster.SetAllowCastCompanySkill3 == true and get_npc_attr(npc, 1) <= get_npc_attr(npc, 4) * 0.5 then
    monster.tool.HalflifeRage = true
    monster.SetAllowCastCompanySkill3 = false
    if false == check_magic(monster.npc, 2020470130) then
      cast_magic(monster.npc, monster.npc, 2020470130, 1)
    end
    monster.WushiNpc:get_behavior():WushiStartSleeping(monster)
    exit_stun(monster.npc)
    exit_stun(monster.WushiNpc)
    set_npc_hp_bar_type(monster.WushiNpc, 0)
    cast_magic(monster.WushiNpc, monster.WushiNpc, 1999330, 1)
    cast_magic(monster.WushiNpc, monster.WushiNpc, 1999331, 1)
    cast_magic(monster.WushiNpc, monster.WushiNpc, 20103401067, 1)
  end
end

return monster
