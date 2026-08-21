local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.teletportposx = 0
  monster.teletportposz = 0
  monster.wander = {
    minDis = 0,
    maxDis = 999,
    minTime = 3.5,
    maxTime = 3.5
  }
  monster.posneed = nil
  monster.knifepos = {}
  monster.linepos = {}
  monster.knife = nil
  monster.GuajiTimer = 2
  monster.GuajiInterval = 1
  monster.ShouldCastDash = false
  monster.needskillX, monster.needskillY, monster.needskillZ = get_area_pos("ForSleeping")
  monster.sleeppoint = {
    x = monster.needskillX,
    y = monster.needskillY,
    z = monster.needskillZ
  }
  monster.M1X, monster.M1Y, monster.M1Z = get_area_pos("M1")
  monster.M1 = {
    x = monster.M1X,
    y = monster.M1Y,
    z = monster.M1Z
  }
  monster.shouldsleep = false
  monster.Sanbutimer = 0
  monster.Sanbutimerinterval = 2
  monster.CompanyPre = false
  monster.tipstimer = 0
  monster.tipsinterval = 8
  local skills = {
    DashSlash = {
      30010050401,
      5,
      0,
      6,
      999,
      -30,
      30
    },
    JumpSlashStart = {
      30010050402,
      10,
      0,
      0,
      999
    },
    JumpSlashMiddle = {
      30010050403,
      0,
      0
    },
    JumpSlashEnd = {
      30010050404,
      0,
      0
    },
    BackThrow = {
      30010050405,
      5,
      0,
      0,
      8,
      -30,
      30
    },
    TP = {
      30010050406,
      0,
      0
    },
    KickThrow = {
      30010050407,
      4,
      0,
      0,
      4,
      -30,
      30
    },
    JumpThrow = {
      30010050408,
      7,
      0,
      0,
      3,
      -30,
      30
    },
    SpinSlash1 = {
      30010050411,
      10,
      0,
      0,
      999,
      -30,
      30
    },
    JumpHit = {
      30010050412,
      5,
      0,
      2,
      999,
      -30,
      30
    },
    SpinSlash2 = {
      30010050415,
      0,
      0,
      0,
      999
    },
    SpinSlash3 = {
      30010050416,
      0,
      0,
      0,
      999
    },
    evade_skill = {
      30010050417,
      8,
      0
    },
    JumpSlashMiddleToEnd = {
      30010050418,
      0,
      0
    },
    companyskill1 = {
      30010050438,
      0,
      0,
      0,
      999
    },
    companyskill2 = {
      30010050439,
      0,
      0,
      0,
      999
    },
    companyskill3 = {
      30010050440,
      0,
      0,
      0,
      999
    },
    DashSlash2 = {
      30010050421,
      10,
      0,
      6,
      999,
      -30,
      30
    },
    SpinSlash11 = {
      30010050425,
      0,
      0,
      0,
      999
    },
    JumpSlashStart1 = {
      30010050424,
      0,
      0,
      0,
      999
    },
    JumpSlashMiddleToEnd1 = {
      30010050441,
      0,
      0,
      0,
      999
    },
    JumpSlashStart2 = {
      30010050442,
      0,
      0,
      0,
      999
    },
    TP3 = {
      30010050406,
      0,
      0
    },
    BackThrow1 = {
      30010050405,
      5,
      0,
      0,
      8,
      -30,
      30
    }
  }
  local nodes = {
    "close1",
    "middle1",
    "far1",
    "attackforphase2",
    "AllDistance",
    "attackforphase1",
    "companyskill",
    "sleep",
    "Gongji",
    "ChangDi",
    "GroupAtkForTwinBoss",
    "CloseAtk",
    "FarAtk",
    "TP2"
  }
  local actMoves = {
    "Guaji",
    "Guaji2",
    "Sanbu"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  cast_magic(monster.npc, monster.npc, 30010050414)
  cast_magic(monster.npc, monster.npc, 1999243)
  do
    local _ENV = states
    _ENV.gotTarget(_ENV.sleep, _ENV.Sanbu, _ENV.attack, _ENV.wander, _ENV.TP)
    _ENV.evade(_ENV.evade_skill)
    _ENV.sleep(_ENV.TP3(_ENV.Guaji, _ENV.Gongji, _ENV.ChangDi))
    _ENV.Gongji(_ENV.JumpSlashStart1)
    _ENV.ChangDi(_ENV.JumpSlashStart2)
    _ENV.attack(_ENV.freeAtk, _ENV.GroupAtkForTwinBoss)
    _ENV.GroupAtkForTwinBoss(_ENV.CloseAtk, _ENV.FarAtk)
    _ENV.freeAtk(_ENV.companyskill)
    _ENV.companyskill(_ENV.TP2(_ENV.Guaji2))
    _ENV.CloseAtk(_ENV.DashSlash, _ENV.JumpHit, _ENV.JumpThrow, _ENV.KickThrow, _ENV.BackThrow)
    _ENV.FarAtk(_ENV.JumpSlashStart, _ENV.SpinSlash1, _ENV.BackThrow1)
  end
  states.TP2.skill = skills.TP
  states.TP3.skill = skills.TP
  states.BackThrow1.skill = skills.BackThrow
  monster.group.atkSlots.melee.max = 1
  monster.tool.WushiIsMainAttacker = false
  monster.timeinbattlebool = false
  monster.mainattackertimer = 0
  monster.mainattackertimerinterval = 10
  monster.mainattacktimebool = true
  monster.BearNpc = nil
  monster.SetAllowCastCompanySkill1 = true
  monster.EnterToGuaji2 = false
  monster.tool.attackcount = 0
  monster.tool.BearAlive = false
  monster.tool.rest = false
  monster.ShouldEnterRest = false
  monster.afterbeardie = true
  
  function monster.states.active.tick(active)
    if monster.BearNpc == nil and nil ~= search_npc(monster.npc, 2, 99, nil, false, false, 20204705) then
      monster.BearNpc = search_npc(monster.npc, 2, 99, nil, false, false, 20204705)
      monster.tool.BearAlive = true
    end
    if monster.tool.BearAlive == true then
      if monster.tool.WushiIsMainAttacker == false and true == monster.mainattacktimebool then
        monster.mainattacktimebool = false
        monster.mainattackertimer = get_npc_time(active.monster.npc)
      end
      if get_npc_time(active.monster.npc) > monster.mainattackertimer + monster.mainattackertimerinterval then
        if true == monster.tool.WushiIsMainAttacker then
          monster.tool.WushiIsMainAttacker = false
          monster.mainattackertimer = get_npc_time(active.monster.npc)
          return
        end
        if monster.tool.WushiIsMainAttacker == false then
          monster.tool.WushiIsMainAttacker = true
          monster.mainattackertimer = get_npc_time(active.monster.npc)
          return
        end
      end
    end
    if monster.tool.attackcount >= 10 and monster.tool.BearAlive == true then
      monster.tool.attackcount = 0
      monster.tool.rest = true
    end
    if true == monster.tool.rest and false == monster.ShouldEnterRest then
      monster.ShouldEnterRest = true
    end
    if monster.tool.BearAlive == false and monster.tool.WushiIsMainAttacker == false then
      monster.tool.WushiIsMainAttacker = true
    end
    if monster.tool.BearAlive == false and true == monster.CompanyPre then
      monster.CompanyPre = false
    end
    if monster.tool.BearAlive == false and true == monster.afterbeardie then
      monster.afterbeardie = false
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
  end
  
  function states.dead.isReady(dead)
    if dead.monster.tool.BearAlive == true then
      return false
    elseif dead.monster.tool.BearAlive == false then
      return true
    end
  end
  
  function states.Sanbu.isReady(Sanbu)
    if monster.ShouldEnterRest == false then
      return false
    else
      return true
    end
  end
  
  function states.Sanbu.start(Sanbu)
    Sanbu.monster.Sanbutimer = get_npc_time(Sanbu.monster.npc)
    switch_move_type(Sanbu.monster.npc, 3)
    moveto_npc(monster.npc, get_come_on_hero())
  end
  
  function states.Sanbu.tick(Sanbu)
    if get_npc_distance(Sanbu.monster.npc, 3, 2, true) <= 3 then
      switch_move_type(Sanbu.monster.npc, 4)
      moveto_npc(monster.npc, get_come_on_hero())
      return
    end
    if get_npc_distance(Sanbu.monster.npc, 3, 4, true) <= 3 then
      switch_move_type(Sanbu.monster.npc, 3)
      moveto_npc(monster.npc, get_come_on_hero())
      return
    end
  end
  
  function states.Sanbu.tickTrans(Sanbu)
    if get_npc_time(Sanbu.monster.npc) >= Sanbu.monster.Sanbutimer + Sanbu.monster.Sanbutimerinterval then
      monster.ShouldEnterRest = false
      return Sanbu.monster.states.gotTarget
    end
  end
  
  do
    local wanderMove = states.wanderMove
    local surround = states.surround
    local moveRight = states.moveRight
    local wander = states.wander
    wanderMove(surround)
    
    function wander.tickTrans(wander)
      if wander.monster.shouldsleep == true then
        return wander.monster.states.sleep
      end
      return monster.tree:chooseChildAction(wander.monster.states.attack)
    end
  end
  
  function monster.states.companyskill.isReady(companyskill)
    return false
  end
  
  function monster.states.Guaji2.start(Guaji2)
    Guaji2.base.start(Guaji2)
    abort_skill(Guaji2.monster.npc, true)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050203, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 2020470502, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, Const.LOCK_MASK, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050401, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050402, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050403, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050409, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050405, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050406, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050407, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050408, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050410, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050411, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050412, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050413, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 30010050201, 1)
    cast_magic(Guaji2.monster.npc, Guaji2.monster.npc, 2020470536, 1)
    enable_shadow(Guaji2.monster.npc, false)
    stop_move(Guaji2.monster.npc)
    Guaji2.monster.GuajiTimer = get_npc_time(Guaji2.monster.npc)
    set_npc_hp_visible(Guaji2.monster.npc, false)
  end
  
  function monster.states.sleep.isReady(sleep)
    if sleep.monster.shouldsleep == false then
      return false
    elseif sleep.monster.shouldsleep == true then
      return true
    end
  end
  
  function monster.states.TP3.start(TP3)
    TP3.base.start(TP3)
  end
  
  function monster.states.SpinSlash1.finish(SpinSlash1)
    SpinSlash1.base.finish(SpinSlash1)
    abort_magic_by_id(monster.npc, 2020470103, 1)
    abort_magic_by_id(monster.npc, 2020470104, 1)
  end
  
  function monster.states.SpinSlash11.finish(SpinSlash11)
    SpinSlash11.base.finish(SpinSlash11)
    abort_magic_by_id(monster.npc, 2020470103, 1)
    abort_magic_by_id(monster.npc, 2020470104, 1)
  end
  
  function monster.states.Guaji.start(Guaji)
    stop_move(Guaji.monster.npc)
    Guaji.monster.GuajiTimer = get_npc_time(Guaji.monster.npc)
    set_npc_hp_visible(Guaji.monster.npc, false)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 2020470502, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, Const.LOCK_MASK, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050401, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050402, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050403, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050409, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050405, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050406, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050407, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050408, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050410, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050411, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050412, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050413, 1)
    enable_shadow(Guaji.monster.npc, false)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 30010050201, 1)
    cast_magic(Guaji.monster.npc, Guaji.monster.npc, 2020470536, 1)
  end
  
  function monster.states.Guaji.tickTrans(Guaji)
    if Guaji.monster.tool.BearAlive == false then
      abort_magic_by_id(monster.npc, 2030430147, 1)
      Guaji.monster.shouldsleep = false
      remove_scene_effect("Fx_M201047_Fog")
      flash_to_pos(Guaji.monster.npc, Guaji.monster.M1.x, Guaji.monster.M1.z)
      abort_magic_by_id(Guaji.monster.npc, 2020470502, 1)
      abort_magic_by_id(Guaji.monster.npc, Const.LOCK_MASK, 1)
      enable_shadow(Guaji.monster.npc, true)
      abort_magic_by_id(Guaji.monster.npc, 30010050401, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050403, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050409, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050405, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050406, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050407, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050408, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050410, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050411, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050412, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050402, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050413, 1)
      abort_magic_by_id(Guaji.monster.npc, 30010050203, 1)
      abort_magic_by_id(Guaji.monster.npc, 2020470536, 1)
      set_npc_hp_visible(Guaji.monster.npc, true)
      return Guaji.monster.states.wander
    end
    if get_npc_time(monster.npc) >= monster.GuajiTimer + monster.GuajiInterval then
      return Guaji.monster.states.Gongji
    end
    local player = get_come_on_hero()
  end
  
  function monster.states.ChangDi.finTrans(ChangDi)
    return ChangDi.monster.states.Guaji
  end
  
  function monster.states.Gongji.finTrans(Gongji)
    return Gongji.monster.states.Guaji
  end
  
  states.stun.EnterTime = 0
  states.stun.HitInterval = 3
  
  function states.stun.start(stun)
    stun.EnterTime = get_npc_time(states.stun.monster.npc)
    cast_magic(monster.npc, monster.npc, 30010050204)
  end
  
  states.stun.faint = states.faint
  
  function states.stun.tickTrans(stun)
    if stun.faint:isReady() then
      return stun.faint
    end
    if get_npc_time(states.stun.monster.npc) >= states.stun.EnterTime + states.stun.HitInterval then
      return stun.monster.states.TP
    end
  end
  
  function states.faint.start(faint)
    faint.base.start(faint)
    if check_magic(monster.npc, 30010050203) then
      abort_magic_by_id(monster.npc, 30010050203, 99)
    end
  end
  
  function states.TP.finish(TP)
    abort_magic_by_id(monster.npc, 30010050203, 1)
  end
  
  function states.TP.finTrans(TP)
    return states.gotTarget
  end
  
  do
    local JumpSlashStart1 = monster.skills.JumpSlashStart1
    local JumpSlashMiddle = monster.skills.JumpSlashMiddle
    local JumpSlashEnd = monster.skills.JumpSlashEnd
    local JumpSlashMiddleToEnd1 = monster.skills.JumpSlashMiddleToEnd1
    JumpSlashStart1(JumpSlashMiddleToEnd1(JumpSlashEnd))
    local JumpSlashStart2 = monster.skills.JumpSlashStart2
    local JumpSlashMiddle = monster.skills.JumpSlashMiddle
    local JumpSlashEnd = monster.skills.JumpSlashEnd
    local JumpSlashMiddleToEnd1 = monster.skills.JumpSlashMiddleToEnd1
    JumpSlashStart2(JumpSlashMiddleToEnd1)
    
    function JumpSlashMiddleToEnd1.onBegin(JumpSlashMiddleToEnd1)
      local monster = JumpSlashMiddleToEnd1.monster
      abort_magic_by_id(monster.npc, 30010050401, 1)
      abort_magic_by_id(monster.npc, 30010050403, 1)
      abort_magic_by_id(monster.npc, 30010050409, 1)
      abort_magic_by_id(monster.npc, 30010050405, 1)
      abort_magic_by_id(monster.npc, 30010050406, 1)
      abort_magic_by_id(monster.npc, 30010050407, 1)
      abort_magic_by_id(monster.npc, 30010050408, 1)
      abort_magic_by_id(monster.npc, 30010050410, 1)
      abort_magic_by_id(monster.npc, 30010050411, 1)
      abort_magic_by_id(monster.npc, 30010050412, 1)
      abort_magic_by_id(monster.npc, 30010050402, 1)
      abort_magic_by_id(monster.npc, 30010050413, 1)
      abort_magic_by_id(monster.npc, 2020470536, 1)
      JumpSlashMiddleToEnd1.base.onBegin(JumpSlashMiddleToEnd1)
    end
  end
  do
    local JumpSlashStart = monster.skills.JumpSlashStart
    local JumpSlashMiddle = monster.skills.JumpSlashMiddle
    local JumpSlashEnd = monster.skills.JumpSlashEnd
    local JumpSlashMiddleToEnd = monster.skills.JumpSlashMiddleToEnd
    JumpSlashStart(JumpSlashMiddleToEnd(JumpSlashEnd))
  end
  
  function monster.states.attack.isReady(attack)
    if attack.monster.shouldsleep == true then
      return false
    else
      return true
    end
  end
  
  function states.attack.start(attack)
    attack.base.start(attack)
    monster.tool.attackcount = monster.tool.attackcount + 1
  end
  
  function states.attack.finish(attack)
    if monster.CompanyPre == true then
      monster.BearNpc:get_behavior():GetWushiCompanyIsReady(monster)
    end
  end
  
  function monster.states.attack.finTrans(attack)
    return attack.monster.states.gotTarget
  end
  
  states.attack.interval = 0
  states.GroupAtkForTwinBoss.timer = 0
  states.GroupAtkForTwinBoss.interval = 2
  
  function states.GroupAtkForTwinBoss.finish(GroupAtkForTwinBoss)
    GroupAtkForTwinBoss.timer = get_npc_time(GroupAtkForTwinBoss.monster.npc) + GroupAtkForTwinBoss.interval
    GroupAtkForTwinBoss.base.finish(GroupAtkForTwinBoss)
  end
  
  function states.GroupAtkForTwinBoss.isReady(GroupAtkForTwinBoss)
    if GroupAtkForTwinBoss.monster.CompanyPre == true then
      return false
    else
      return true
    end
  end
  
  function states.CloseAtk.isReady(CloseAtk)
    if monster.tool.WushiIsMainAttacker == true then
      return true
    elseif monster.tool.WushiIsMainAttacker == false then
      return false
    end
  end
  
  function states.FarAtk.isReady(FarAtk)
    if monster.tool.WushiIsMainAttacker == true then
      return false
    elseif monster.tool.WushiIsMainAttacker == false then
      return true
    end
  end
end

function monster.on_missile_begin_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id == 3001005041901 or missile_cfg.Id == 3001005020306 or missile_cfg.Id == 3001005021805 or missile_cfg.Id == 3001005044107 or missile_cfg.Id == 3001005041807 then
    if monster.knife ~= nil then
      local param = {
        npc = monster.npc,
        posx = get_missile_pos(monster.knife).x,
        posz = get_missile_pos(monster.knife).z,
        missile_id = 3001005041902,
        missile_level = 1,
        lookat_posx = get_missile_pos(monster.knife).x,
        lookat_posz = get_missile_pos(monster.knife).z,
        lookat_posy = monster.knife.v_born_pos.y,
        born_posx = (pos_x + get_missile_pos(monster.knife).x) / 2,
        born_posz = (pos_z + get_missile_pos(monster.knife).z) / 2
      }
      cast_missile2(param)
      monster:doAfter(function(monster)
        stop_missile(monster.knife)
        stop_missile(missile)
        monster.knife = nil
      end, 0.5)
    else
      monster.knife = missile
    end
  end
end

function monster.isSame(temp, pos_x, pos_z)
  if math.abs(temp.x - pos_x) > 0.01 then
    return false
  end
  if math.abs(temp.z - pos_z) > 0.01 then
    return false
  end
  return true
end

function monster.before_damage(monster, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if target == monster.npc and (1 == change_level or 2 == change_level or 3 == change_level or 4 == change_level or 5 == change_level or 0 == change_level) then
    abort_magic_by_id(monster.npc, 30010050203, 1)
    cast_magic(monster.npc, monster.npc, 30010050204)
  end
end

function monster.on_target_self_element_aborn_start(monster, caster, element, skill_id)
  monster.base.on_target_self_element_aborn_start(monster, caster, element, skill_id)
  if nil ~= skill_id then
    abort_magic_by_id(monster.npc, 30010050203, 1)
    cast_magic(monster.npc, monster.npc, 30010050204)
  end
end

function monster.teleport(monster, r)
  local states = monster.states
  local randompoint = math.random(0, 360)
  local target_pos = get_npc_pos(get_come_on_hero())
  monster.teletportposx = target_pos.x + r * math.cos(randompoint)
  monster.teletportposz = target_pos.z + r * math.sin(randompoint)
  local posX = target_pos.x + r * math.cos(randompoint)
  local posZ = target_pos.z + r * math.sin(randompoint)
  return posX, posZ
end

function monster.teleport1(monster, r)
  local states = monster.states
  local randompoint = math.random(0, 360)
  monster.teletportposx = monster.centerposX + r * math.cos(randompoint)
  monster.teletportposz = monster.centerposZ + r * math.sin(randompoint)
  local posX = monster.centerposX + r * math.cos(randompoint)
  local posZ = monster.centerposZ + r * math.sin(randompoint)
  return posX, posZ
end

function monster.on_target_self_magic_begin(monster, caster, magic_id)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id)
  local states = monster.states
  if 30010050201 == magic_id then
    if monster.tree:curState() == states.JumpSlashStart then
      monster.teleport_target = monster.target
      monster:teleport(1)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
    end
    if monster.tree:curState() == states.JumpSlashStart1 then
      monster.teleport_target = monster.target
      monster:teleport(1)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
    end
    if monster.tree:curState() == states.JumpSlashStart2 then
      monster.teleport_target = monster.target
      monster:teleport(1)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
    end
    if monster.tree:curState() == states.TP then
      monster.teleport_target = monster.target
      monster:teleport(7)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz)
      lookat_npc(monster.npc, get_come_on_hero(), true)
      if monster.tool.WushiIsMainAttacker == true then
        monster.tool.WushiIsMainAttacker = false
        monster.mainattackertimer = get_npc_time(monster.npc)
      end
    end
    if monster.tree:curState() == states.TP2 then
      flash_to_pos(monster.npc, monster.sleeppoint.x, monster.sleeppoint.z)
    end
    if monster.tree:curState() == states.TP3 then
      flash_to_pos(monster.npc, monster.sleeppoint.x, monster.sleeppoint.z)
    end
    if monster.tree:curState() == states.Guaji then
      flash_to_pos(monster.npc, monster.sleeppoint.x, monster.sleeppoint.z)
    end
  end
  if 30010050204 == magic_id then
    abort_magic_by_id(monster.npc, 30010050203, 1)
  end
end

function monster.WushiStartSleeping(monster)
  monster.shouldsleep = true
end

function monster.CalculateCameraFoucusPoint(monster)
  local playerpoint = get_npc_pos(get_come_on_hero())
  local selfpoint = get_npc_pos(monster.npc)
  monster.pointneedx = selfpoint.x - playerpoint.x
  monster.pointneedz = selfpoint.z - playerpoint.z
  return monster.pointneedx, monster.pointneedz
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 30010050205 == magic_id then
    cast_magic(monster.npc, monster.npc, 30010050207, 1)
    cast_magic(monster.npc, monster.npc, 30010050208, 1)
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  switch_bgm_block("bgm_chapter5_Boss", 3)
  set_sync_var("bear", true)
  monster.base.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
end

function monster.WushiPrepareForCompany(Wushi)
  Wushi.CompanyPre = true
  if check_npc_status(Wushi.npc, 1) == false then
    Wushi.BearNpc:get_behavior():GetWushiCompanyIsReady(monster)
  end
end

function monster.CompanySkillReturnFalse(Wushi)
  Wushi.CompanyPre = false
end

function monster.WushiGoToGuaji(Wushi)
  Wushi.tree:transState(Wushi.states.TP2)
end

function monster.WushiStopGuaji(Wushi)
  local playerpos = get_npc_pos(get_come_on_hero())
  Wushi.posneed = get_npc_offset_position(Wushi.BearNpc, playerpos, 70, 3)
  flash_to_pos(Wushi.npc, Wushi.posneed.x, Wushi.posneed.z)
  abort_magic_by_id(Wushi.npc, 30010050203, 1)
  abort_magic_by_id(Wushi.npc, 2020470502, 1)
  abort_magic_by_id(Wushi.npc, Const.LOCK_MASK, 1)
  abort_magic_by_id(Wushi.npc, 30010050401, 1)
  abort_magic_by_id(Wushi.npc, 30010050403, 1)
  abort_magic_by_id(Wushi.npc, 30010050409, 1)
  abort_magic_by_id(Wushi.npc, 30010050405, 1)
  abort_magic_by_id(Wushi.npc, 30010050406, 1)
  abort_magic_by_id(Wushi.npc, 30010050407, 1)
  abort_magic_by_id(Wushi.npc, 30010050408, 1)
  abort_magic_by_id(Wushi.npc, 30010050410, 1)
  abort_magic_by_id(Wushi.npc, 30010050411, 1)
  abort_magic_by_id(Wushi.npc, 30010050412, 1)
  abort_magic_by_id(Wushi.npc, 30010050402, 1)
  abort_magic_by_id(Wushi.npc, 30010050413, 1)
  abort_magic_by_id(Wushi.npc, 2020470536, 1)
  Wushi.EnterToGuaji2 = false
  Wushi.CompanyPre = false
  set_npc_hp_visible(Wushi.npc, true)
  Wushi.tree:transState(Wushi.states.gotTarget)
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  monster.base.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  if check_magic(monster.npc, 30010050203) then
    abort_magic_by_id(monster.npc, 30010050203, 99)
  end
end

return monster
