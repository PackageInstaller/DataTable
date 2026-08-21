local roleBase = import("character.base.role_base")
local Florence = Util.create_child_mt(roleBase)
local linkCheck = 0

function Florence._init(role, npc)
  role.npc = npc
  local misIds = {
    ultFocus1 = 10010091506,
    ultFocus2 = 10010091614,
    boomerangFocus = 10010091201
  }
  local magicIds = {
    stanceTry = 1009005,
    stanceStateFx = 10090051,
    stanceStateFx2 = 100900511,
    stanceFlash = 1009022,
    stanceBuff = 1009101,
    stanceBuffFx = 10091011,
    stanceBuffExtra = 1009518,
    PenetrateBuff = 10095181,
    waitWindow = 10090052,
    stanceEnd = 10090911,
    perfectStanceWindowOption = {1009091, 1009512},
    perfectStanceBuffOption = {1009073, 1009513},
    perfectStanceSprite = 1009074,
    perfectStancefinish = 10090731,
    perfectStanceHurtDerate = 1009514,
    trace4Buff = 1009515,
    easyHurtFx = 1009519,
    critRateFix = 1009516,
    critDamageFix = 1009517,
    streakDamageFix = {1009520, 10095201},
    waltzDerive = 1009526,
    trace2Buff = 10091012,
    linkStanceBuff = 10091014
  }
  magicIds.perfectStanceWindow = magicIds.perfectStanceWindowOption[1]
  magicIds.perfectStanceBuff = magicIds.perfectStanceBuffOption[1]
  role.ultHideList = UtilTable.copy_table(role.ultHideList)
  role.ultHideList.JoystickContent = false
  local dashBase = {}
  role.skActBases = {dash = dashBase}
  roleBase._init(role, misIds, magicIds)
  role.isInStance = false
  role.per_missile = 0
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  local destinies = role.destinies
  local spWeapon = role.spWeapon
  local cosId = get_role_fashion_id(npc)
  local cosWeaponId = get_role_weapon_fashion_id(npc)
  if 50010903 == cosWeaponId then
    set_keyframe_enable_by_tag(role.npc, skills.bornLF.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.finish.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.bornLF.id, 2, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.finish.id, 2, false, true)
  else
    set_keyframe_enable_by_tag(role.npc, skills.bornLF.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.finish.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.bornLF.id, 2, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.finish.id, 2, true, true)
  end
  
  function skills.bornLF.isReady(bornLF)
    if not bornLF.base.isReady(bornLF) then
      return false
    end
    print("cosId = ", cosId, "cosWeaponId=", cosWeaponId)
    if 3003009 == cosId then
      return true
    else
      return false
    end
  end
  
  function skActs.born.start(born)
    if 3003009 ~= cosId then
      cast_magic(npc, npc, 10099087, 0)
    else
      cast_magic(npc, npc, 10099088, 0)
    end
    born.base.start(born)
  end
  
  skActs.atk3.counter = skActs.counter
  
  function skActs.atk3.isReady(atk3)
    if not atk3.base.isReady(atk3) then
      return false
    end
    local role = atk3.role
    local roleAct = role.skAct
    if roleAct == atk3.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk3.counter then
      return true
    else
      return false
    end
  end
  
  function magics.waitWindow.onBegin(waitWindow)
    local role = waitWindow.unit
    local roleAct = role.skAct
    roleAct.isWaitWindow = true
    role.inputor:pop()
  end
  
  do
    local function clearWaitWindow(act)
      act.isWaitWindow = false
      
      act.base.onBegin(act)
    end
    
    skActs.boomerang.onBegin = clearWaitWindow
    skActs.insertSword.onBegin = clearWaitWindow
    skActs.streak.onBegin = clearWaitWindow
    
    local function stanceTransCheck(curAct, tarAct)
      local role = curAct.role
      local roleAct = role.skAct
      if roleAct ~= curAct then
        return nil
      end
      local trans = curAct.trans
      local tarName = tarAct.name
      if curAct.isWaitWindow and ("streak" == tarName or "waltz" == tarName or "heavy" == tarName) then
        return true
      end
      if roleAct.isCastOver or roleAct.isOver then
        return true
      end
      if trans.disable[tarName] then
        return false
      end
      if trans.enable[tarName] then
        return true
      end
      return tarAct.trans.prio > trans.inertia
    end
    
    skActs.boomerang.transCheck = stanceTransCheck
    skActs.insertSword.transCheck = stanceTransCheck
    skActs.streak.transCheck = stanceTransCheck
    
    local function stance_in_cast_time(act)
      local role = act.role
      local stance = role.skActs.stance
      if stance:isReady() then
        stance:start()
      end
    end
    
    skActs.boomerang.tryStance = stance_in_cast_time
    skActs.insertSword.tryStance = stance_in_cast_time
    
    local function stance_on_bef_time(act)
      act.role:stanceOn()
      act.base.onBefTime(act)
    end
    
    skActs.boomerang.onBefTime = stance_on_bef_time
    skActs.insertSword.onBefTime = stance_on_bef_time
    
    local function stance_in_afterTime(skAct)
      local role = skAct.role
      local stance = role.skActs.stance
      if stance:isReady() then
        stance:start()
      end
    end
    
    skActs.atk3.tryStance = stance_in_afterTime
    skActs.heavy.tryStance = stance_in_afterTime
    skActs.qte.tryStance = stance_in_afterTime
    skActs.counter.tryStance = stance_in_afterTime
    
    local function stance_in_afterTime_for_dash(dash)
      local role = dash.role
      if not dash.bPerfect and not role.isInStance then
        return
      end
      local stance = dash.stance
      if stance:isReady() then
        stance:start()
      end
    end
    
    dashBase.stance = skActs.stance
    skActs.dashIn.magics.PERFECT.SLOMO_SELF = nil
    skActs.dashOut.magics.PERFECT.SLOMO_SELF = nil
    dashBase.tryStance = stance_in_afterTime_for_dash
  end
  magics.stanceTry.act = skActs.stance
  
  function magics.stanceTry.onBegin(stance, casterNpc, target)
    local role = stance.unit
    local roleAct = role.skAct
    if roleAct.tryStance then
      roleAct:tryStance()
    end
  end
  
  function skActs.stance.isReady(stance)
    if not stance.base.isReady(stance) then
      return false
    end
    if not stance.role:isInControl() then
      return false
    end
    return true
  end
  
  function skActs.stance.tarPos()
    return nil
  end
  
  function skActs.stance.onBegin(stance)
    local role = stance.role
    cast_magic(role.npc, role.npc, role.magics.stanceStateFx2.id)
    role:stanceOn()
    stance.stanceTick = nil
    role:pStanceOn()
    stance.trans.inertia = 2
    stance.base.onBegin(stance)
  end
  
  function skActs.stance.canStay(stance)
    return false, false
  end
  
  magics.stanceFlash.act = skActs.stance
  
  function magics.stanceFlash.onEnd(stanceFlash, castNpc, target)
    local act = stanceFlash.act
    act.trans.inertia = 0
    stanceFlash.unit.inputor:pop()
  end
  
  skActs.stance.isStance = true
  
  function skActs.stance.onBreak(stance, tarAct)
    local role = stance.role
    role:pStanceOff()
    role:abortMagic(magicIds.perfectStanceBuff)
    role:abortMagic(Const.DEFEND.DASH.PERFECT.SLOMO_OTHERS)
    stance.base.onBreak(stance, tarAct)
  end
  
  magics.stanceEnd.act = skActs.stance
  
  function magics.stanceEnd.onBegin(stanceEnd)
    stanceEnd.unit:pStanceOff()
    local act = stanceEnd.act
    act.stanceTick = act.stanceDec
    act:stanceTick()
  end
  
  do
    local baseActs = role.baseActs
    
    local function try_quit_stance_on_begin(baseAct)
      local role = baseAct.role
      if role:isSpBarEmpty() then
        role:stanceOff()
      end
    end
    
    baseActs.wander.onBegin = try_quit_stance_on_begin
    baseActs.hurt.onBegin = try_quit_stance_on_begin
    baseActs.hurtFly.onBegin = try_quit_stance_on_begin
    
    local function decrease_stance_bar_and_quit(act)
      local role = act.role
      if not role.isInStance then
        return
      end
      if not role:isSpBarEmpty() then
        role:decSpBar()
        if role:isSpBarEmpty() then
          role:stanceOff()
        end
      end
    end
    
    for _, baseAct in pairs(baseActs) do
      baseAct.stanceTick = decrease_stance_bar_and_quit
    end
    skActs.atk1.stanceTick = decrease_stance_bar_and_quit
    skActs.atk2.stanceTick = decrease_stance_bar_and_quit
    skActs.faint.stanceTick = decrease_stance_bar_and_quit
    skActs.stance.stanceDec = decrease_stance_bar_and_quit
    
    local function decrease_stance_bar_and_retain(act)
      local role = act.role
      if not role.isInStance then
        return
      end
      if not role:isSpBarEmpty() then
        role:decSpBar()
      end
    end
    
    skActs.atk3.stanceTick = decrease_stance_bar_and_retain
    skActs.heavy.stanceTick = decrease_stance_bar_and_retain
    
    local function decrease_stance_bar_and_retain_for_dash(dash)
      local role = dash.role
      if not role.isInStance then
        return
      end
      if dash.bPerfect then
        return
      end
      if not role:isSpBarEmpty() then
        role:decSpBar()
      end
    end
    
    dashBase.stanceTick = decrease_stance_bar_and_retain_for_dash
    
    local function quit_stance_on_break(act, tarAct)
      local role = act.role
      if role.isInStance and role:isSpBarEmpty() then
        role:stanceOff()
      end
      act.base.onBreak(act, tarAct)
    end
    
    skActs.atk3.onBreak = quit_stance_on_break
    skActs.heavy.onBreak = quit_stance_on_break
    
    function dashBase.onBreak(dash, tarAct)
      local role = dash.role
      if role.isInStance and role:isSpBarEmpty() then
        role:stanceOff()
      end
      dash._dashBase.onBreak(dash, tarAct)
    end
    
    function dashBase.finPdash(dash, nextAct)
      if not dash.bPerfect then
        return
      end
      dash:tryFinPdodge()
      dash:tryFinCounterWin(true)
      dash:tryFinIp(nextAct)
      dash:tryFinMoveIp(nextAct)
      dash:finPfx(nextAct)
      dash:finSlomoSelf()
      if not nextAct or not nextAct.isStance then
        dash:tryFinSlomoOther(nextAct)
      end
    end
  end
  magics.stanceBuff.fx = magics.stanceBuffFx
  
  function magics.stanceBuff.onBegin(stanceBuff, casterNpc, target)
    if not check_magic(casterNpc, stanceBuff.fx.id) then
      cast_magic(casterNpc, casterNpc, stanceBuff.fx.id, 0, 2)
    end
    local lv = get_skill_lv(role.npc, 100100910) or 0
    if 1 == linkCheck then
      cast_magic(casterNpc, casterNpc, magics.linkStanceBuff.id, lv)
    end
  end
  
  function magics.stanceBuff.onEnd(stanceBuff, casterNpc, target)
    if not check_magic(casterNpc, stanceBuff.id) then
      abort_magic_by_id(casterNpc, stanceBuff.fx.id)
    end
  end
  
  if not role.debugSwitch.ignoreUltCost then
    function skActs.ultFast.onBefTime(ultFast)
      if role.destinyLv >= 2 then
        set_keyframe_enable(role.npc, 10010091615, false, false)
        
        set_keyframe_enable(role.npc, 10010091616, false, false)
      else
        set_keyframe_enable(role.npc, 10010091604, false, false)
        set_keyframe_enable(role.npc, 10010091607, false, false)
      end
      cast_magic(role.npc, role.npc, 10099141)
      cast_magic(role.npc, role.npc, 1009914)
      ultFast.base.onBefTime(ultFast)
    end
  end
  do
    local function nilFun()
    end
    
    local function ultDerive(ultSkill)
      local nextSkill = ultSkill.nextSkill
      local act = ultSkill.skAct
      if nextSkill:isReady() then
        nextSkill:start(act)
      elseif not act.isCastOver then
        act:onCastTime()
      end
    end
    
    skills.ult1.nextSkill = skills.ult2
    skills.ult1.onCastTime = ultDerive
    skills.ult1.onBreak = nilFun
    
    function skills.ult1.onBegin(ult1)
      local num = get_magic_num(npc, magics.stanceBuff.id)
      local add_num = 6 - num
      if 0 == add_num then
        cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0)
      else
        cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, add_num)
      end
      ult1.base.onBegin(ult1)
    end
    
    skills.ult2.nextSkill = skills.ult3
    skills.ult2.onCastTime = ultDerive
    skills.ult2.onBreak = nilFun
    
    local function ultTarget(ult)
      local role = ult.role
      role:searchTarget(ult.skAct.search)
      return role.target
    end
    
    skills.ult2.target = ultTarget
    skills.ult3.target = ultTarget
    skills.ult2.bar = role.spBar
    skills.ult2.range = skActs.ult.search
    skills.ult3.range = skActs.ult.search
    
    local function ultOnBegin(ult)
      local num = get_magic_num(npc, magics.stanceBuff.id)
      local add_num = 6 - num
      if 0 == add_num then
        cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0)
      else
        cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, add_num)
      end
      ult.base.onBegin(ult)
    end
    
    skills.ult2.onBegin = ultOnBegin
    
    function skills.ult3.onBegin(ult3)
      local role = ult3.role
      if role.skAct.name == "ult" and role.destinyLv >= 2 then
        set_keyframe_enable(role.npc, 10010091632, false, false)
        set_keyframe_enable(role.npc, 10010091633, false, false)
      elseif role.skAct.name == "ult" and role.destinyLv < 2 then
        set_keyframe_enable(role.npc, 10010091630, false, false)
        set_keyframe_enable(role.npc, 10010091631, false, false)
      end
      local num = get_magic_num(npc, magics.stanceBuff.id)
      local add_num = 6 - num
      if 0 == add_num then
        cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0)
      else
        cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, add_num)
      end
      ult3.base.onBegin(ult3)
    end
    
    skActs.ult.stanceBuff = magics.stanceBuff
    
    function misLogics.ultFocus1.onBegin(ultFocus, ultFocusInst, owner, posX, posZ)
      role:change_follow_target(1, ultFocusInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 150
        },
        0,
        0,
        0.1
      })
    end
    
    function misLogics.ultFocus1.onEnd(ultFocus, ultFocusInst, owner, posX, posZ)
      change_focus_follow_speed(3)
      role:change_follow_target(4)
      
      local function resetFollow()
        change_focus_follow_speed(4)
      end
      
      local role = ultFocus.unit
      role:doAfter(resetFollow, 1.25)
    end
    
    function misLogics.ultFocus2.onBegin(ultFocus, ultFocusInst, owner, posX, posZ)
      role:change_follow_target(1, ultFocusInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 150
        },
        0,
        0,
        0.1
      })
    end
    
    function misLogics.ultFocus2.onEnd(ultFocus, ultFocusInst, owner, posX, posZ)
      change_focus_follow_speed(3)
      role:change_follow_target(4)
      
      local function resetFollow()
        change_focus_follow_speed(4)
      end
      
      local role = ultFocus.unit
      role:doAfter(resetFollow, 1.25)
    end
  end
  
  function misLogics.boomerangFocus.onBegin(boomerangFocus, boomerangFocusInst, owner, posX, posZ)
    role:change_follow_target(1, boomerangFocusInst, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 30
      },
      0,
      0,
      0.1
    })
  end
  
  function misLogics.boomerangFocus.onEnd(boomerangFocus, boomerangFocusInst, owner, posX, posZ)
    local role = boomerangFocus.unit
    if role.skAct.name ~= "boomerang" then
      return
    end
    change_focus_follow_speed(0)
    
    local function resetFollow(role)
      change_focus_follow_speed(2.5)
      role:change_follow_target(4)
    end
    
    role:doAfter(resetFollow, 0.35)
  end
  
  function skActs.boomerang.onEnd(boomerang)
    boomerang.base.onEnd(boomerang)
    change_focus_follow_speed(2.5)
    role:change_follow_target(4)
  end
  
  function skActs.boomerang.onBreak(boomerang, tarAct)
    boomerang.base.onBreak(boomerang, tarAct)
    change_focus_follow_speed(2.5)
    role:change_follow_target(4)
    abort_magic_by_id(boomerang.role.npc, 1009132)
    
    local function recoverWeapon(role)
      cast_magic(role.npc, role.npc, 10090201)
    end
    
    boomerang.role:doAfter(recoverWeapon, -0.1)
    if tarAct and tarAct.name == "streak" then
      remove_missile_by_id(10010091201, nil, true)
    end
  end
  
  function skActs.streak.isReady(streak)
    if not streak.role.isInStance then
      return false
    end
    if not streak.base.isReady(streak) then
      return false
    end
    return true
  end
  
  skActs.streak.count = 0
  
  function skActs.streak.start(streak, event)
    streak.count = streak.count + 1
    streak.trans.enable.streak = nil
    streak.trans.enable.waltz = nil
    local role = streak.role
    local magics = role.magics
    streak.isPerfect = role.isPerfectStance
    streak.base.start(streak, event)
    if streak.isPerfect then
      cast_magic(role.npc, role.npc, magics.perfectStanceSprite.id)
      cast_magic(role.npc, role.npc, magics.perfectStancefinish.id)
    end
    role:stanceOn()
  end
  
  skActs.streak.waltz = skActs.waltz
  skActs.streak.stance = skActs.stance
  
  function skActs.streak.tryStance(streak)
    local role = streak.role
    local enableList = streak.trans.enable
    enableList.streak = streak
    enableList.waltz = streak.waltz
    local popAct = role.inputor:pop()
    enableList.streak = nil
    enableList.waltz = nil
    local stance = streak.stance
    if not popAct and stance:isReady() then
      stance:start()
    end
  end
  
  function skActs.streak.onBefTime(streak)
    streak.base.onBefTime(streak)
    local role = streak.role
    local magics = role.magics
    if 0 == linkCheck then
      cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, 2)
    elseif 1 == linkCheck then
      cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, 6)
    end
  end
  
  skills.streak1.snapFrameId = 10010091726
  skills.streak2.snapFrameId = 10010091826
  do
    local function streakStart(streak, act)
      local role = streak.role
      
      if not role.target or get_npc_distance(role.npc, 1, role.target, true) < 3.5 then
        set_keyframe_enable(role.npc, streak.snapFrameId, false, false)
      end
      streak.base.start(streak, act)
    end
    
    skills.streak1.start = streakStart
    skills.streak2.start = streakStart
    skills.streak1.act = skActs.streak
    
    function skills.streak1.isReady(streak1)
      if not streak1.base.isReady(streak1) then
        return false
      end
      if 0 ~= streak1.act.count % 2 then
        return false
      end
      return true
    end
    
    function skActs.streak.onBreak(streak, tarAct)
      streak.role:pStanceOff()
      streak.base.onBreak(streak, tarAct)
    end
    
    function skActs.streak.onEnd(streak)
      streak.role:pStanceOff()
      streak.base.onEnd(streak)
    end
  end
  
  function skActs.waltz.tryStance(waltz)
    local role = waltz.role
    local stance = role.skActs.stance
    if stance:isReady() then
      stance:start()
    end
  end
  
  function skActs.waltz.isReady(waltz)
    if not waltz.role.isInStance then
      return false
    end
    if not waltz.base.isReady(waltz) then
      return false
    end
    return true
  end
  
  skActs.waltz.sk2 = btns.sk2
  skActs.waltz.waltz2 = icons.waltz2
  
  function skActs.waltz.start(waltz, event)
    role.skills.cleave:ignoreCost()
    local role = waltz.role
    waltz.isPerfect = role.isPerfectStance
    waltz.base.start(waltz, event)
    if waltz.isPerfect then
      cast_magic(role.npc, role.npc, magics.perfectStanceSprite.id)
      cast_magic(role.npc, role.npc, magics.perfectStancefinish.id)
    end
    waltz.base.start(waltz)
    role:stanceOn()
  end
  
  skActs.waltz.icon1 = icons.insertSword
  skActs.waltz.indiMaskTime = 1.5
  
  function skActs.waltz.onBefTime(waltz)
    local role = waltz.role
    local icon1 = waltz.icon1
    icon1.indiBackUp = icon1.indi
    icon1.indi = nil
    waltz.indiMaskTimer = get_npc_time(role.npc) + waltz.indiMaskTime
    cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, 2)
    waltz.base.onBefTime(waltz)
  end
  
  function skActs.waltz.tick(waltz)
    waltz.base.tick(waltz)
    if waltz.isBefOver and get_npc_time(waltz.role.npc) > waltz.indiMaskTimer then
      local icon1 = waltz.icon1
      icon1.indi = icon1.indiBackUp
    end
  end
  
  skActs.waltz.slomo = 1009224
  
  function skActs.waltz.onBreak(waltz, tarAct)
    waltz.role:abortMagic(waltz.slomo)
    if not waltz.isBefOver then
      return
    end
    local icon1 = waltz.icon1
    if not icon1.indi then
      icon1.indi = icon1.indiBackUp
    end
    abort_magic_by_id(npc, magics.stanceBuff.id)
    abort_magic_by_id(npc, 1009518)
    return waltz.base.onBreak(waltz, tarAct)
  end
  
  function skActs.waltz.onEnd(waltz)
    abort_magic_by_id(npc, magics.stanceBuff.id)
    abort_magic_by_id(npc, 1009518)
    waltz.base.onEnd(waltz)
  end
  
  function skActs.cleave.tryStance(cleave)
    local role = cleave.role
    local stance = role.skActs.stance
    if stance:isReady() then
      stance:start()
    end
  end
  
  function skActs.cleave.start(cleave, event)
    role.skills.cleave:restoreCost()
    local btns = role.btns
    local icons = role.icons
    if 0 == linkCheck then
      btns.sk2:setIcon(icons.waltz)
    end
    cast_magic(role.npc, role.npc, magics.stanceBuff.id, 0, 2)
    cleave.base.start(cleave, event)
  end
  
  skActs.cleave.slomo = 1009224
  
  function skActs.cleave.onEnd(cleave)
    abort_magic_by_id(npc, magics.stanceBuff.id)
    abort_magic_by_id(npc, 1009518)
    cleave.base.onEnd(cleave)
  end
  
  function skActs.cleave.onBreak(cleave, tarAct)
    cleave.role:abortMagic(cleave.slomo)
    abort_magic_by_id(npc, magics.stanceBuff.id)
    abort_magic_by_id(npc, 1009518)
    return cleave.base.onBreak(cleave, tarAct)
  end
  
  function skills.waltz1.onBegin(waltz1)
    local num = get_magic_num(npc, magics.stanceBuff.id)
    if 0 ~= num then
      cast_magic(role.npc, role.npc, 10091351, num)
    end
    waltz1.base.onBegin(waltz1)
  end
  
  function skills.cleave.onBegin(cleave)
    local num = get_magic_num(npc, magics.stanceBuff.id)
    if 0 ~= num then
      cast_magic(role.npc, role.npc, 1009135, num)
    end
    cleave.base.onBegin(cleave)
  end
  
  function skActs.linkQte.start(linkQte, event)
    local num = get_magic_num(npc, magics.stanceBuff.id)
    if 0 ~= num then
      cast_magic(role.npc, role.npc, 10091354, num)
    end
    local lv = get_skill_lv(role.npc, 100100910) or 0
    cast_magic(role.npc, role.npc, magics.linkStanceBuff.id, lv, 6)
    linkQte.base.start(linkQte, event)
  end
  
  function skActs.linkQte.onBegin(linkQte)
    role:stanceOn()
    role:addMagic(role.magics.stanceBuff.id, nil, nil, 6)
    local btns = role.btns
    local icons = role.icons
    btns.sk2:setIcon(icons.cleave)
    linkQte.base.onBegin(linkQte)
  end
  
  function skActs.linkQte.tryStance(linkQte)
    local role = linkQte.role
    local stance = role.skActs.stance
    if stance:isReady() then
      stance:start()
    end
  end
  
  function skActs.linkQte.onEnd(linkQte)
    abort_magic_by_id(npc, magics.stanceBuff.id)
    abort_magic_by_id(npc, 1009518)
    linkQte.base.onEnd(linkQte)
  end
  
  function skActs.linkQte.onBreak(linkQte, tarAct)
    abort_magic_by_id(npc, magics.stanceBuff.id)
    abort_magic_by_id(npc, 1009518)
    return linkQte.base.onBreak(linkQte, tarAct)
  end
  
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, skills.ult1.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult2.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult3.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult1.id, 2, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult2.id, 2, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult3.id, 2, false, true)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function extraPointBuff(skill)
      local role = skill.role
      
      local magics = role.magics
      if check_magic(role.npc, magics.perfectStanceWindow.id) then
        cast_magic(role.npc, role.npc, magics.stanceBuff.id)
      end
    end
    
    tool.insert(skActs.streak, "onBegin", extraPointBuff)
    tool.insert(skActs.waltz, "onBegin", extraPointBuff)
    tool.insert(skActs.cleave, "onBegin", extraPointBuff)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function trace2Buff(skill)
      local role = skill.role
      
      local magics = role.magics
      if check_magic(role.npc, magics.perfectStanceWindow.id) then
        cast_magic(role.npc, role.npc, magics.trace2Buff.id)
      end
    end
    
    tool.insert(skActs.streak, "onBegin", trace2Buff)
    tool.insert(skActs.waltz, "onBegin", trace2Buff)
    
    local function trace2Buffabort(skill)
      local role = skill.role
      local magics = role.magics
      abort_magic_by_id(role.npc, magics.trace2Buff.id)
    end
    
    tool.insert(skActs.streak, "onEnd", trace2Buffabort)
    tool.insert(skActs.waltz, "onEnd", trace2Buffabort)
    tool.insert(skActs.streak, "onBreak", trace2Buffabort)
    tool.insert(skActs.waltz, "onBreak", trace2Buffabort)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local lv = get_skill_lv(role.npc, 100100910) or 0
    
    local function BuffAdd(skills)
      cast_magic(npc, npc, magicIds.trace4Buff, lv)
    end
    
    tool.insert(skActs.boomerang, "onBegin", BuffAdd)
    tool.insert(skActs.insertSword, "onBegin", BuffAdd)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function FullBuff(stanceBuff, casterNpc, target)
      local num = get_magic_num(casterNpc, stanceBuff.id)
      
      if 6 == num then
        cast_magic(casterNpc, casterNpc, 10091013, 0)
      end
    end
    
    tool.insert(magics.stanceBuff, "onBegin", FullBuff)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, skills.ult1.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult2.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult3.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult1.id, 2, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult2.id, 2, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.ult3.id, 2, true, true)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id)
      if 1009053 == magic_id or 1009054 == magic_id or 1009055 == magic_id then
        if check_element_ab_state(target, 3) then
          cast_magic(npc, npc, magicIds.streakDamageFix[2], 0)
        else
          cast_magic(npc, npc, magicIds.streakDamageFix[1], 0)
        end
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id)
      if 1009060 == magic_id or 1009061 == magic_id or 10090631 == magic_id or 1009063 == magic_id or 10090632 == magic_id then
        local num = get_magic_num(npc, magicIds.stanceBuff)
        
        if 6 == num then
          cast_magic(npc, npc, 1009527, 0)
        end
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function critFix()
      if role.npc ~= npc then
        return
      end
      local magics = role.magics
      cast_magic(role.npc, role.npc, magics.critRateFix.id)
      cast_magic(role.npc, role.npc, magics.critDamageFix.id)
    end
    
    tool.insert(skActs.streak, "onBegin", critFix)
    tool.insert(skActs.waltz, "onBegin", critFix)
    
    local function critAbort()
      if role.npc ~= npc then
        return
      end
      local magics = role.magics
      if check_magic(role.npc, magics.critRateFix.id) and check_magic(role.npc, magics.critDamageFix.id) then
        abort_magic_by_id(role.npc, magics.critRateFix.id)
        abort_magic_by_id(role.npc, magics.critDamageFix.id)
      end
    end
    
    tool.insert(skActs.streak, "onEnd", critAbort)
    tool.insert(skActs.waltz, "onEnd", critAbort)
    tool.insert(skActs.streak, "onBreak", critAbort)
    tool.insert(skActs.waltz, "onBreak", critAbort)
  end
  magics.stanceBuff.extra = magics.stanceBuffExtra
  set_keyframe_enable_by_tag(role.npc, skills.born.id, 1, false, true)
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, skills.born.id, 1, true, true)
    
    local function extraDamageInc(stanceBuff, casterNpc, target)
      local magicNum = get_magic_num(casterNpc, magics.stanceBuff.id)
      local extraNum = get_magic_num(casterNpc, stanceBuff.extra.id)
      cast_magic(casterNpc, casterNpc, stanceBuff.extra.id, role.spWeapon.lv, magicNum - extraNum)
    end
    
    local function streakPenetrate(streak, casterNpc, hitTarget, hitType, skill, missile)
      if 0 == role.per_missile then
        cast_magic(casterNpc, casterNpc, magicIds.PenetrateBuff, role.spWeapon.lv)
        role.per_missile = missile.missile_id
      elseif role.per_missile == missile.missile_id then
        return
      elseif role.per_missile ~= missile.missile_id then
        cast_magic(casterNpc, casterNpc, magicIds.PenetrateBuff, role.spWeapon.lv)
        role.per_missile = missile.missile_id
      end
    end
    
    local function streakPenetrateDel(streak)
      role.per_missile = 0
    end
    
    tool.insert(skActs.streak, "onHit", streakPenetrate)
    tool.insert(skActs.streak, "onEnd", streakPenetrateDel)
    tool.insert(skActs.streak, "onBreak", streakPenetrateDel)
    tool.insert(magics.stanceBuff, "onBegin", extraDamageInc)
  end
end

function Florence.on_born_behavior(role)
  local hasAnim = role.base.on_born_behavior(role)
  if not hasAnim then
    role:addMagic(10099087)
  end
end

function Florence.onRampageStart(role, stage)
  linkCheck = 1
end

function Florence.onRampageEnd(role, stage)
  local magics = role.magics
  linkCheck = 0
  abort_magic_by_id(role.npc, magics.linkStanceBuff.id)
end

function Florence.onLinkChange(role, newStage, oldStage)
end

function Florence.on_keyframe_action(role, kfId, npcTag, comnTag)
  if "turn" == npcTag then
    local tarPos, target = role:searchTarget(role.skAct.search)
    set_skill_target(role.npc, role.skAct.curSk.id, target, tarPos)
  end
end

function Florence.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc ~= role.npc then
    return
  end
  if is_showup then
    if role.qte then
      role:stanceOff()
    end
    abort_magic_by_id(role.npc, role.magics.stanceBuff.id)
    abort_magic_by_id(role.npc, role.magics.stanceBuff.extra.id)
    abort_magic_by_id(role.npc, role.magics.stanceTry.id)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

function Florence.stanceOff(role, sk1MaskTime, sk2MaskTime)
  if 1 == linkCheck then
    return
  end
  local btns = role.btns
  local icons = role.icons
  btns.sk1:setIcon(icons.boomerang, sk1MaskTime)
  btns.sk2:setIcon(icons.insertSword, sk2MaskTime)
  if not role:isSpBarEmpty() then
    cast_magic(role.npc, role.npc, Const.ATTR.CLEAR74, get_npc_attr(role.npc, 75))
  end
  role.isInStance = false
  abort_magic_by_id(role.npc, role.magics.stanceStateFx.id)
end

function Florence.stanceOn(role)
  local btns = role.btns
  local icons = role.icons
  btns.sk1:setIcon(icons.streak)
  if 0 == linkCheck then
    btns.sk2:setIcon(icons.waltz)
  elseif 1 == linkCheck then
    btns.sk2:setIcon(icons.cleave)
  end
  if not role.isInStance then
    cast_magic(role.npc, role.npc, role.magics.stanceStateFx.id)
  end
  role.isInStance = true
  role.is_stance_retained_by_dash = false
  cast_magic(role.npc, role.npc, Const.ATTR.FILL74, 0)
end

function Florence.pStanceOn(role)
  role.isPerfectStance = true
end

function Florence.pStanceOff(role)
  role.isPerfectStance = false
end

function Florence.isSpBarEmpty(role)
  return get_npc_attr(role.npc, 74) < 0.1
end

function Florence.decSpBar(role)
  if 1 == linkCheck then
    return
  end
  cast_magic(role.npc, role.npc, 10090361)
end

function Florence.stanceTick(role)
  local skAct = role.skAct
  if skAct and skAct.stanceTick then
    skAct:stanceTick()
  end
end

function Florence.on_frame(role)
  role.base.on_frame(role)
  role:stanceTick()
end

function Florence.on_frame_background(role)
  role.base.on_frame_background(role)
  role:stanceTick()
end

function Florence.on_frame_ground(role)
  role.base.on_frame_ground(role)
  role:stanceTick()
end

function Florence.onPdashSlomo(role, dash)
  role:stanceOn()
  return role.base.onPdashSlomo(role, dash)
end

function Florence.toMelt(role, inputId)
  role.base.toMelt(role, inputId)
  role:abortMagic(role.magics.stanceStateFx.id)
end

return Florence
