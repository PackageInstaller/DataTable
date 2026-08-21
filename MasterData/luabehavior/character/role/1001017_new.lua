local vec2 = require("base.vec2")
local vec3 = require("base.vec3")
local roleBase = import("character.base.role_base")
local Nanna = Util.create_child_mt(roleBase)
Nanna.stab_angle_threshold = 75

function Nanna._init(role, npc)
  role.npc = npc
  local misIds = {
    stormForward = 10010172122,
    bladeFallPos1 = 10010174211,
    bladeFallPos2 = 10010174202,
    bladeFallPush = 10010174231,
    bladeFall = 10010174201,
    streakExEnd = 10010173301,
    ultStart = 10010178121,
    ultEnd = 10010178408,
    stabStart = 10010172601,
    stabJump = 10010172701,
    stabPull = 10010172801,
    stabDerive = 10010172614,
    streakExExtraHit = 10010174220,
    dashCollide = {10010171110, 10010171210},
    roundSlashHit = 10010174101,
    wrapAroundHit = {
      10010174205,
      10010174206,
      10010174207,
      10010174208,
      10010174204
    },
    misUltHit = 10010178101
  }
  local magicIds = {
    bladePickMask = 101752,
    bladePickFx = 101751,
    bladeFallingTag = 101750,
    streakExState = 101740,
    streakExDerive = 101754,
    streakExAtkEffect = 101755,
    cdChange = 101736,
    stabDeriveTime = 101739,
    stabDamageFix = 1017201,
    alterWeaponBuff = {1017203},
    stormForwardDamage = 1017133,
    roundSlashDamage = 1017137,
    wrapAroundDamage = {
      1017138,
      1017139,
      1017140
    },
    destiny5DamageFix = 1017205,
    streakExDamageFix = 1017211,
    energyRecover = 101790,
    bladeRecover = 101781,
    skill02TeachStates = 1017300,
    stabDeriveDamage = 1017143,
    destiniesMagic5Id = {
      1017121,
      1017122,
      1017123,
      1017124,
      1017131,
      1017134,
      1017132,
      1017133,
      1017145,
      1017146,
      1017149,
      1017137
    }
  }
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local skill02TeachStates = false
  local streakExStartPos, streakExflashPos
  role.wrapAroundHit1 = misLogics.wrapAroundHit[1]
  role.wrapAroundHit2 = misLogics.wrapAroundHit[2]
  role.wrapAroundHit3 = misLogics.wrapAroundHit[5]
  local traces = role.traces
  traces[1017281] = 1
  traces[1017282] = 2
  traces[1017284] = 4
  local destinies = role.destinies
  destinies[1017181] = 1
  destinies[1017182] = 2
  destinies[1017183] = 3
  destinies[1017184] = 4
  destinies[1017185] = 5
  role.destiniesMagic = {
    Lv5 = {
      damageId = {
        1017121,
        1017122,
        1017123,
        1017124,
        1017131,
        1017134,
        1017132,
        1017133,
        1017145,
        1017146,
        1017149,
        1017137
      },
      upId = {1017205}
    }
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1017200
  set_keyframe_enable_by_tag(role.npc, 100101791, 1, true, true)
  set_keyframe_enable_by_tag(role.npc, 100101791, 2, false, true)
  
  function magics.bladeRecover.onEnd(bladeRecover, casterNpc, target)
    role:set_weapon_attach(true)
  end
  
  misLogics.bladeFall.onHit = role.pickBladeSlash
  misLogics.dashCollide[1].onCollideMis = function(dashCollide, misInst, mis2, misOwner, mis2Owner)
    if mis2Owner ~= misOwner then
      return
    end
    if mis2.missile_id == 10010174202 or mis2.missile_id == 10010174201 then
      if check_magic(role.npc, role.magics.bladeFallingTag.id) then
        role.pickBladeSlash(role.misLogics.bladeFall, mis2, role.npc, role.npc)
      else
        role.pickBlade(role.misLogics.bladeFall, mis2, role.npc, role.npc)
      end
    end
  end
  misLogics.dashCollide[2].onCollideMis = function(dashCollide, misInst, mis2, misOwner, mis2Owner)
    if mis2Owner ~= misOwner then
      return
    end
    if mis2.missile_id == 10010174202 or mis2.missile_id == 10010174201 then
      if check_magic(role.npc, role.magics.bladeFallingTag.id) then
        role.pickBladeSlash(role.misLogics.bladeFall, mis2, role.npc, role.npc)
      else
        role.pickBlade(role.misLogics.bladeFall, mis2, role.npc, role.npc)
      end
    end
  end
  
  function misLogics.bladeFallPos2.onHit(bladeFallPos2, misInst, casterNpc, hitTarget, hitType, skill)
    if hitTarget ~= casterNpc then
      return
    end
    local magics = role.magics
    if check_magic(role.npc, magics.bladePickMask.id) then
      return
    end
    local role = bladeFallPos2.unit
    if check_magic(role.npc, role.magics.bladeFallingTag.id) then
      role.pickBladeSlash(bladeFallPos2, misInst, casterNpc, hitTarget, hitType, skill)
    else
      role.pickBlade(bladeFallPos2, misInst, casterNpc, hitTarget, hitType, skill)
    end
  end
  
  function misLogics.bladeFallPos2.onEnd(misLogic, misInst, owner, posX, posZ)
    if misInst.d_isUsed then
      return
    end
    local role = misLogic.unit
    role:toDualBlade()
    cast_magic(role.npc, role.npc, magicIds.bladeRecover, 1)
    cast_magic(role.npc, role.npc, role.magics.bladePickFx.id, 1)
  end
  
  function skActs.roundSlash.tarPos(roundSlash, event)
    local role = roundSlash.role
    local search = roundSlash.search
    local inputDir = role:inputDir()
    if not inputDir then
      search.maxDis = search.secRadius
      return roundSlash.base.tarPos(roundSlash, event)
    else
      search.maxDis = -1
      local pos = roundSlash.base.tarPos(roundSlash, event)
      local rolePos = get_npc_pos(role.npc)
      local length = (rolePos.x - pos.x) ^ 2 + (rolePos.z - pos.z) ^ 2
      return get_position_offset_position(rolePos, pos, 180, length)
    end
  end
  
  function skills.roundSlash.tarPos()
  end
  
  function skills.roundSlash.onBegin(roundSlash)
    local role = roundSlash.role
    cast_magic(role.npc, role.npc, role.magics.cdChange.id, 1)
    if role.target and check_npc_distance(role.npc, role.target, 4, false) then
      role:change_follow_target(1, role.target, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 25
        },
        1,
        10,
        0.2
      })
      role:keep_focus_pos_by_clear_target()
    end
    role:doAfter(function(role)
      change_focus_follow_speed(10)
      role:change_follow_target(4)
    end, -0.2)
    remove_missile_by_id(10010174205, role.npc)
    remove_missile_by_id(10010174206, role.npc)
    remove_missile_by_id(10010174207, role.npc)
    remove_missile_by_id(10010174208, role.npc)
    remove_missile_by_id(10010174204, role.npc)
    if role:isRampage() then
      role:doAfter(function(role)
        local target = search_npc(role.npc, 4, 20, nil, false, false)
        local posTarget = target and get_npc_pos(target) or role:offsetPos(5)
        local posBorn = get_npc_pos(role.npc)
        cast_missile3(role.npc, nil, posBorn.x, posBorn.z, misIds.stormForward, 0, posTarget.x, posTarget.z)
      end, 0.1)
    else
      role:doAfter(function(role)
        role:set_weapon_attach(true)
      end, -0.5)
    end
  end
  
  function skills.linkQte.castMissle(role)
    local target = search_npc(role.npc, 4, 20, nil, false, false)
    local posTarget = target and get_npc_pos(target) or get_npc_pos(role.npc)
    local posBorn = get_npc_pos(role.npc)
    cast_missile3(role.npc, nil, posBorn.x, posBorn.z, misIds.stormForward, 0, posTarget.x, posTarget.z)
    cast_missile(role.npc, role.npc, nil, nil, role.wrapAroundHit1.id, 0)
    cast_missile(role.npc, role.npc, nil, nil, role.wrapAroundHit2.id, 0)
    cast_missile(role.npc, role.npc, nil, nil, role.wrapAroundHit3.id, 0)
  end
  
  function skills.linkQte.onBegin(roundSlash)
    remove_missile_by_id(10010174205, role.npc)
    remove_missile_by_id(10010174206, role.npc)
    remove_missile_by_id(10010174207, role.npc)
    remove_missile_by_id(10010174208, role.npc)
    remove_missile_by_id(10010174204, role.npc)
    role:doAfter(skills.linkQte.castMissle, 0.1, true)
  end
  
  function misLogics.roundSlashHit.onBegin(misLogic, misInst, owner, posX, posZ)
    cast_missile(role.npc, role.npc, nil, nil, role.wrapAroundHit1.id, 0)
    cast_missile(role.npc, role.npc, nil, nil, role.wrapAroundHit2.id, 0)
    cast_missile(role.npc, role.npc, nil, nil, role.wrapAroundHit3.id, 0)
  end
  
  do
    local function wrapAroundHitMagic(misId, misInst, casterNpc, hitTarget, hitType, skill)
      if check_magic(hitTarget, 101744) then
        cast_missile(role.npc, hitTarget, nil, nil, 10010174210, 0, nil, nil)
        
        cast_magic(role.npc, hitTarget, 101745, 1)
      end
    end
    
    role.misLogics.wrapAroundHit[1].onHit = wrapAroundHitMagic
    role.misLogics.wrapAroundHit[2].onHit = wrapAroundHitMagic
    role.misLogics.wrapAroundHit[3].onHit = wrapAroundHitMagic
    role.misLogics.wrapAroundHit[4].onHit = wrapAroundHitMagic
    
    function skActs.roundSlash.onBreak(roundSlash, tarAct)
      roundSlash.base.onBreak(roundSlash, tarAct)
      abort_magic_by_id(role.npc, 101713)
    end
    
    function skActs.roundSlash.onEnd(roundSlash)
      roundSlash.base.onEnd(roundSlash)
      abort_magic_by_id(role.npc, 101713)
    end
    
    function icons.streak.updateEnable(streak)
      streak.base.updateEnable(streak)
      if streak.isEnable then
        local role = streak.role
        streak.isEnable = not role.isSingleBlade
      end
    end
    
    magics.streakExState.btn = btns.sk2
    magics.streakExState.icon1 = icons.streak
    magics.streakExState.icon2 = icons.streakEx
    
    function magics.streakExState.onBegin(streakExState, casterNpc, target)
      streakExState.btn:setIcon(streakExState.icon2)
    end
    
    function magics.streakExState.onEnd(streakExState, casterNpc, target)
      streakExState.btn:setIcon(streakExState.icon1)
    end
  end
  icons.stab.indi.skAct = skActs.stab
  icons.stab.indi.jump = skills.stabJump
  
  function icons.stab.indi.tarPosInit(indi)
    local act = indi.skAct
    local role = indi.role
    local enemyList = search_npc(role.npc, 4, act.search.maxDis, nil, false, true)
    local bladeFallPos = role:getBladeFallPos()
    local bladePos = bladeFallPos and get_missile_pos(bladeFallPos)
    local rolePos = get_npc_pos(role.npc)
    local tar
    if bladePos then
      local minDeltaAngle = 360
      local range = indi.jump.maxDist
      local minDist = range + 1
      local _, inputDir = get_joystick_target_pos(role.npc)
      local zeroLeft = 0 == inputDir.x and 0 == inputDir.z
      for _, enemy in pairs(enemyList) do
        if not check_magic(enemy, Const.LOCK_MASK) and not check_npc_die(enemy) then
          local enemyPos = get_npc_pos(enemy)
          local enemyBladeVec = enemyPos - bladePos
          enemyBladeVec.y = 0
          local enemyBladeDist = enemyBladeVec:Magnitude()
          if range > enemyBladeDist then
            if zeroLeft then
              if minDist > enemyBladeDist then
                minDist = enemyBladeDist
                tar = enemy
              end
            else
              local roleEnmeyVec = enemyPos - rolePos
              roleEnmeyVec.y = 0
              local deltaAngle = inputDir:Angle(roleEnmeyVec)
              if minDeltaAngle > deltaAngle then
                tar = enemy
                minDeltaAngle = deltaAngle
              end
            end
          end
        end
      end
    end
    if tar then
      role:setTarget(tar)
    else
      indi.base.tarPosInit(indi)
    end
  end
  
  function skills.stabStart.onBegin(stabStart)
    stabStart.base.onBegin(stabStart)
    stabStart.skAct.victim = nil
  end
  
  function misLogics.stabStart.onHit(stabStart, misInst, casterNpc, hitTarget, hitType, skill)
    if misInst.d_isUsed then
      return
    end
    misInst.d_isUsed = true
    skill.skAct.victim = hitTarget
    cast_magic(casterNpc, hitTarget, 101786, 1)
    cast_magic(casterNpc, hitTarget, 101787, 1)
  end
  
  magics.stabDeriveTime.act = skActs.stab
  skActs.stab.angleThreshold = role.stab_angle_threshold
  
  function magics.stabDeriveTime.onBegin(stabDeriveTime, casterNpc, target)
    local role = stabDeriveTime.unit
    local act = stabDeriveTime.act
    local rolePos = get_npc_pos(role.npc)
    local facePos = get_npc_offset_position(role.npc, nil, 0, 1)
    local victimPos = act.victim and get_npc_pos(act.victim)
    local bladeFallPos = role:getBladeFallPos()
    local bladePos = bladeFallPos and get_missile_pos(bladeFallPos)
    local inputPos, inputDir = get_joystick_target_pos(role.npc)
    inputDir.y = 0
    if 0 == inputDir.x and 0 == inputDir.z then
      inputPos = nil
      inputDir = nil
    end
    local isInputRight = false
    if inputDir and victimPos and bladePos then
      local vicBladeVec = bladePos - victimPos
      vicBladeVec.y = 0
      local angle = inputDir:Angle(vicBladeVec)
      if math.abs(angle) < act.angleThreshold then
        isInputRight = true
      end
    end
    if act.ignoreInput then
      isInputRight = true
    end
    local vicInputPos
    if victimPos and inputDir then
      vicInputPos = victimPos + inputDir:Normalize() * (act.victim.radius + 1)
      _, vicInputPos = get_nearest_walkable_pos(rolePos, vicInputPos, 1)
    end
    local tarPos
    if isInputRight then
      tarPos = bladePos
      local bladeFall = role.misInsts.bladeFall
      if bladeFall then
        local movement = bladeFall:get_movement()
        local cur_live_time = bladeFall:get_time()
        local vy = movement.v_start_speed_h + movement.v_gravity * cur_live_time
        local _, curH, _ = bladeFall:get_pos()
        local deltaH = movement.v_end_height - curH
        local deltaDist = movement.v_dist - movement.v_speed * cur_live_time
        local tarTime = 0.85
        local tarSpeed = deltaDist / tarTime
        if tarSpeed > movement.v_speed then
          local newSpeed = deltaDist / tarTime
          local newGravity = 2 * (deltaH - vy * tarTime) / (tarTime * tarTime)
          change_missile_move_params(bladeFall, newSpeed, newGravity)
        end
      end
    elseif vicInputPos then
      tarPos = vicInputPos
    else
      tarPos = rolePos
    end
    local role_tar_vec = rolePos - tarPos
    role_tar_vec.y = 0
    local tarDist = role_tar_vec:Magnitude()
    act.rolePos = rolePos
    act.facePos = facePos
    act.victimPos = victimPos
    act.bladePos = bladePos
    act.inputPos = inputPos
    act.inputDir = inputDir
    act.isInputRight = isInputRight
    act.vicInputPos = vicInputPos
    act.tarDist = tarDist
    role.skills.stabStart:deriveAuto()
  end
  
  function skActs.stab.onBreak(stab, tarAct)
    stab.role:clear_move_scale(stab.curSk.animName)
    stab.base.onBreak(stab, tarAct)
  end
  
  function skActs.stab.onEnd(stab)
    stab.role:clear_move_scale(stab.curSk.animName)
    stab.base.onEnd(stab)
  end
  
  do
    local jumpAnimName = skills.stabJump.cfg.Animation
    skills.stabJump.animName = jumpAnimName
    local jumpOriMotion = ShareRes.create("character.motion.H1001017")[jumpAnimName].OffsetZ
    skills.stabJump.oriMaxDist = math.abs(jumpOriMotion[#jumpOriMotion])
    skills.stabJump.minDist = 3
    skills.stabJump.maxDist = 6
    skills.stabJump.act = skActs.stab
    
    function skills.stabJump.tarPos(stabJump)
      return stabJump.act.bladePos
    end
    
    function skills.stabJump.isReady(stabJump)
      local act = stabJump.act
      if not act.victimPos then
        return false
      end
      if not act.inputDir then
        return false
      end
      if not act.bladePos then
        return false
      end
      if act.tarDist < stabJump.minDist then
        return false
      end
      return true
    end
    
    function skills.stabJump.start(stabJump, act)
      stabJump.isDeriveMisCasted = false
      local role = stabJump.role
      if act.isInputRight or skill02TeachStates then
        lookat_position(role.npc, act.bladePos.x, act.bladePos.z, true)
      elseif act.vicInputPos then
        lookat_position(role.npc, act.vicInputPos.x, act.vicInputPos.z, true)
      end
      local animName = stabJump.animName
      if act.bladePos and act.isInputRight then
        local roleBladeVec = get_npc_pos(role.npc) - act.bladePos
        roleBladeVec.y = 0
        local dist = math.min(roleBladeVec:Magnitude(), stabJump.maxDist)
        local k = dist / stabJump.oriMaxDist
        role:set_move_scale(animName, k)
      else
        role:clear_move_scale(animName)
      end
      stabJump.base.start(stabJump, act)
    end
    
    misLogics.stabJump.skLv = get_skill_lv(role.npc, skills.stabStart.id) or 0
    misLogics.stabPull.skLv = misLogics.stabJump.skLv
    misLogics.stabJump.misDerive = misLogics.stabDerive
    
    local function stabDeriveOnHit(derive, misInst, casterNpc, hitTarget, hitType, skill)
      if misInst.d_isUsed then
        return
      end
      if skill.isDeriveMisCasted then
        return
      end
      if hitTarget ~= skill.skAct.victim then
        return
      end
      local role = derive.unit
      local pos = get_npc_pos(hitTarget)
      cast_missile3(casterNpc, hitTarget, pos.x, pos.z, derive.misDerive.id, derive.skLv)
      misInst.d_isUsed = true
      skill.isDeriveMisCasted = true
    end
    
    misLogics.stabJump.onHit = stabDeriveOnHit
    skills.stabPull.act = skActs.stab
    
    function skills.stabPull.tarPos(stabPull)
      local act = stabPull.act
      if act.victim then
        return act.victim
      end
      return act.victimPos
    end
    
    skills.stabPull.maxDist = 3
    local pullAnimName = skills.stabPull.cfg.Animation
    skills.stabPull.animName = pullAnimName
    local pullOriMotion = ShareRes.create("character.motion.H1001017")[pullAnimName].OffsetZ
    skills.stabPull.oriMaxDist = math.abs(pullOriMotion[#pullOriMotion])
    
    function skills.stabPull.start(stabPull, act)
      stabPull.isDeriveMisCasted = false
      local role = stabPull.role
      local flashPos
      if act.isInputRight then
        flashPos = get_position_offset_position(act.victimPos, act.bladePos, 0, act.victim.radius + 0.5)
        flash_to_pos(role.npc, flashPos.x, flashPos.z)
        lookat_position(role.npc, act.victimPos.x, act.victimPos.z, true)
      elseif act.vicInputPos then
        flashPos = get_position_offset_position(act.victimPos, act.vicInputPos, 0, act.victim.radius + 0.5)
        flash_to_pos(role.npc, flashPos.x, flashPos.z)
        lookat_position(role.npc, act.victimPos.x, act.victimPos.z, true)
      end
      stabPull.base.start(stabPull, act)
      local animName = stabPull.animName
      if act.bladePos and act.isInputRight then
        local roleBladeVec = get_npc_pos(role.npc) - act.bladePos
        roleBladeVec.y = 0
        local dist = math.min(roleBladeVec:Magnitude(), stabPull.maxDist)
        local oriMaxDist = stabPull.oriMaxDist
        local k = dist / oriMaxDist
        role:set_move_scale(animName, k)
      else
        role:clear_move_scale(animName)
      end
    end
    
    misLogics.stabPull.misDerive = misLogics.stabDerive
    misLogics.stabPull.onHit = stabDeriveOnHit
  end
  
  function skActs.storm.onBegin(storm)
    local role = storm.role
    local id = storm.strSks[1].id
    if 1 == math.random(1, 2) then
      set_keyframe_enable_by_tag(role.npc, id, 8, true, false)
      set_keyframe_enable_by_tag(role.npc, id, 9, false, false)
    else
      set_keyframe_enable_by_tag(role.npc, id, 8, false, false)
      set_keyframe_enable_by_tag(role.npc, id, 9, true, false)
    end
    storm.base.onBegin(storm)
  end
  
  misLogics.stormForward.act = skActs.storm
  misLogics.stormForward.bounceRange = 3
  misLogics.stormForward.stabJumpRange = skills.stabJump.maxDist
  misLogics.stormForward.stabRange = skActs.stab.search.maxDis
  
  function misLogics.stormForward.getAngle2(from, to)
    local dot = from:Normalize():Dot(to:Normalize())
    if dot < -1 then
      dot = -1
    end
    if dot > 1 then
      dot = 1
    end
    local absAngle = math.acos(dot)
    local cross2 = from.x * to.z - from.z * to.x
    if cross2 < 0 then
      return absAngle
    else
      return 2 * math.pi - absAngle
    end
  end
  
  function misLogics.stormForward.onHit(stormForward, misInst, casterNpc, hitTarget, hitType, skill)
    if not misInst.d_isUsed then
      misInst.d_isUsed = true
    else
      return
    end
    local role = stormForward.unit
    local act = stormForward.act
    local bounceRange = stormForward.bounceRange
    local stabJumpRange = stormForward.stabJumpRange
    local stabRange = stormForward.stabRange
    act.isBladeSpawned = true
    local rolePos = get_npc_pos(role.npc)
    local oriPos = get_npc_pos(hitTarget)
    local enemyList = search_npc(hitTarget, 3, bounceRange + stabJumpRange, nil, false, true)
    table.insert(enemyList, hitTarget)
    local min_role_enemy_dist_enemy
    local min_role_enemy_dist = math.huge
    local min_delta_angle_enemy
    local min_delta_angle = 360
    local inputDir, faceDir = role:inputDir()
    inputDir = inputDir or faceDir
    for _, enemy in pairs(enemyList) do
      if check_magic(enemy, Const.LOCK_MASK) or check_npc_die(enemy) then
      else
        local enemyPos = get_npc_pos(enemy)
        local oriEnemyVec = enemyPos - oriPos
        oriEnemyVec.y = 0
        if oriEnemyVec:Magnitude() > bounceRange + stabJumpRange then
        else
          local roleEnemyVec = enemyPos - rolePos
          roleEnemyVec.y = 0
          local roleEnemyDist = roleEnemyVec:Magnitude()
          if min_role_enemy_dist > roleEnemyDist then
            min_role_enemy_dist_enemy = enemy
            min_role_enemy_dist = roleEnemyDist
          end
          if stabRange < roleEnemyDist then
          else
            local deltaAngle = inputDir:Angle(roleEnemyVec)
            if min_delta_angle > deltaAngle then
              min_delta_angle = deltaAngle
              min_delta_angle_enemy = enemy
            end
          end
        end
      end
    end
    local bladePos
    local stabTarget = min_delta_angle_enemy or min_role_enemy_dist_enemy or hitTarget
    local stabTargetPos = get_npc_pos(stabTarget) or get_missile_pos(misInst)
    local tarOriVec = oriPos - stabTargetPos
    tarOriVec.y = 0
    local tarOriDist = tarOriVec:Magnitude()
    local oriRoleVec = rolePos - oriPos
    oriRoleVec.y = 0
    local deltaR = math.abs(stabJumpRange - bounceRange)
    if not min_delta_angle_enemy then
      if stabTarget == hitTarget then
        bladePos = get_position_offset_position(stabTargetPos, rolePos, 0, bounceRange)
      elseif tarOriDist < deltaR then
        bladePos = get_position_offset_position(stabTargetPos, rolePos, 0, bounceRange)
      elseif math.abs(tarOriDist - bounceRange - stabJumpRange) < 0.01 then
        bladePos = get_position_offset_position(oriPos, stabTargetPos, 0, bounceRange)
      else
        local a = (tarOriDist ^ 2 + stabJumpRange ^ 2 - bounceRange ^ 2) / (2 * tarOriDist)
        local c = math.sqrt(stabJumpRange ^ 2 - a ^ 2)
        local tarOriVecUnit = tarOriVec:Normalize()
        local cVecUnit = vec3.New(0, 0, 0)
        cVecUnit.x = tarOriVecUnit.z
        cVecUnit.z = -tarOriVecUnit.x
        local D = stabTargetPos + tarOriVecUnit * a
        local E = D + cVecUnit * c
        local F = D - cVecUnit * c
        local roleEvec = rolePos - E
        roleEvec.y = 0
        local roleFvec = rolePos - F
        roleFvec.y = 0
        if roleEvec:sqrMagnitude() < roleFvec:sqrMagnitude() then
          bladePos = E
        else
          bladePos = F
        end
        bladePos.y = oriPos.y
      end
    elseif stabTarget == hitTarget then
      local offsetBasePos = oriPos + inputDir * 10
      local offsetAngle = math.random() * 180 - 90
      bladePos = get_position_offset_position(oriPos, offsetBasePos, offsetAngle, bounceRange)
    elseif tarOriDist < deltaR then
      local offsetBasePos = oriPos + inputDir * 10
      local offsetAngle = math.random() * 180 - 90
      bladePos = get_position_offset_position(oriPos, offsetBasePos, offsetAngle, bounceRange)
    elseif math.abs(tarOriDist - bounceRange - stabJumpRange) < 0.01 then
      bladePos = get_position_offset_position(oriPos, stabTargetPos, 0, bounceRange)
    else
      local a = (tarOriDist ^ 2 + stabJumpRange ^ 2 - bounceRange ^ 2) / (2 * tarOriDist)
      local c = math.sqrt(stabJumpRange ^ 2 - a ^ 2)
      local tarOriVecUnit = tarOriVec:Normalize()
      local cVecUnit = vec3.New(0, 0, 0)
      cVecUnit.x = tarOriVecUnit.z
      cVecUnit.z = -tarOriVecUnit.x
      local D = stabTargetPos + tarOriVecUnit * a
      local E = D + cVecUnit * c
      local oriEVec = E - oriPos
      oriEVec.y = 0
      local oriTarVec = -tarOriVec
      local angleRange = oriEVec:Angle(oriTarVec)
      local offsetAngle = angleRange
      if oriTarVec.x * (inputDir.z * 5) - oriTarVec.z * (inputDir.x * 5) > 0 then
        offsetAngle = -math.random() * angleRange
      else
        offsetAngle = math.random() * angleRange
      end
      bladePos = get_position_offset_position(oriPos, stabTargetPos, offsetAngle, bounceRange)
    end
    local bladePos2 = role:fixPos(bladePos, -60, nil, oriPos)
    role.misLogics.bladeFallPos1.startPos = get_npc_pos(hitTarget)
    local hitTargetKind = get_role_kind(hitTarget)
    if hitTargetKind < 5 then
      cast_missile(role.npc, nil, bladePos2.x, bladePos2.z, role.misLogics.bladeFallPos1.id, 0, nil, nil)
    end
  end
  
  function misLogics.bladeFallPos1.onBegin(bladeFallPos1, misInst, owner, posX, posZ)
    local role = bladeFallPos1.unit
    local act = role.skActs.storm
    role.misInsts.bladeFallPos1 = misInst
    local startPos = bladeFallPos1.startPos
    if not startPos then
      remove_missile(misInst)
    else
      cast_missile(role.npc, misInst, startPos.x, startPos.z, role.misLogics.bladeFall.id, 0, posX, 1, posZ)
    end
  end
  
  function misLogics.bladeFall.onBegin(bladeFall, misInst, owner, posX, posZ)
    local role = bladeFall.unit
    role:toSingleBlade()
    local fallPos = role.misInsts.bladeFall
    if fallPos then
      remove_missile(fallPos)
    end
    role.misInsts.bladeFall = misInst
  end
  
  function misLogics.bladeFall.onEnd(bladeFall, misInst, owner, posX, posZ)
    local role = bladeFall.unit
    local fallPos1 = role.misInsts.bladeFallPos1
    if fallPos1 then
      role.misInsts.fallPos1 = nil
      remove_missile(fallPos1, false)
    end
    if role.misInsts.bladeFall then
      role.misInsts.bladeFall = nil
    end
  end
  
  misLogics.bladeFallPos2.push = misLogics.bladeFallPush
  misLogics.bladeFallPos2.rangeSqr = 6.25
  
  function misLogics.bladeFallPos2.onBegin(bladeFallPos2, misInst, owner, posX, posZ)
    local role = bladeFallPos2.unit
    local fallPos1 = role.misInsts.bladeFallPos1
    if fallPos1 then
      remove_missile(fallPos1)
      role.misInsts.bladeFallPos1 = nil
    end
    role.misInsts.bladeFallPos2 = misInst
    if not is_hero_in_ground(role.npc) then
      return
    end
    local rolePos = get_npc_pos(role.npc)
    if (rolePos.x - posX) ^ 2 + (rolePos.z - posZ) ^ 2 < bladeFallPos2.rangeSqr then
      bladeFallPos2.onHit(bladeFallPos2, misInst, role.npc, role.npc)
    end
  end
  
  function magics.skill02TeachStates.onBegin(stabDeriveTime, casterNpc, target)
    skill02TeachStates = true
  end
  
  function skills.storm.start(storm, event)
    storm.base.start(storm, event)
    storm.isRecovered = false
  end
  
  skills.storm.energyRecover = magics.energyRecover.id
  
  function skills.storm.onKill(storm, caster, target, skInfo)
    if storm.isRecovered then
      return
    end
    storm.isRecovered = true
    cast_magic(caster, caster, storm.energyRecover, 1)
    storm.base.onKill(storm, caster, target, skInfo)
  end
  
  skActs.streakEx.stateMagic = magics.streakExState
  
  function skActs.streakEx.onBegin(streakEx)
    streakEx.base.onBegin(streakEx)
    local role = streakEx.role
    local target = role.target
    abort_magic_by_id(streakEx.role.npc, streakEx.stateMagic.id)
  end
  
  function skills.streakExStart.tarPos(streakExStart)
    local role = streakExStart.role
    local target = role.target
    local tarPos = target and get_npc_pos(target)
    if tarPos then
      streakExStartPos = get_position_offset_position(tarPos, get_npc_pos(role.npc), 0, 1)
    else
      streakExStartPos = get_npc_offset_position(role.npc, nil, 0, 5.5)
    end
    return streakExStartPos
  end
  
  function skills.streakExEnd.tarPos(streakExEnd)
    local role = streakExEnd.role
    local target = role.target
    local tarPos = target and get_npc_pos(target)
    if tarPos then
      streakExflashPos = get_position_offset_position(tarPos, get_npc_pos(role.npc), 180, 3)
    else
      streakExflashPos = get_npc_offset_position(role.npc, nil, 0, 5.5)
    end
    return streakExflashPos
  end
  
  function magics.streakExAtkEffect.onBegin(streakExDerive, casterNpc, target)
    local pos = get_npc_offset_position(role.npc, nil, 180, 0)
    cast_missile3(role.npc, nil, pos.x, pos.z, 10010173302, 0)
  end
  
  magics.streakExDerive.act = skActs.streakEx
  
  function magics.streakExDerive.onBegin(streakExDerive, casterNpc, target)
    local act = streakExDerive.act
    if streakExDerive.unit.skAct == act then
      act.curSk:deriveAuto()
    end
  end
  
  do
    local function setAtkPrio(act)
      if not get_unit_skill_action_cfg(act.role.id, act.name).TransPrio then
        act.trans.prio = 1
        
        act.trans.inertia = 1
      end
    end
    
    local atkActs = {
      skActs.spAtk1,
      skActs.spAtk2,
      skActs.spAtk3
    }
    for i, atkAct in ipairs(atkActs) do
      atkAct.reset = {timer = 0, delay = 0.2}
      
      function atkAct.onCastTime(skAct)
        skAct.reset.timer = get_npc_time(skAct.role.npc) + skAct.reset.delay
        skAct.base.onCastTime(skAct)
      end
      
      setAtkPrio(atkAct)
    end
    for i = 2, #atkActs do
      local atk = atkActs[i]
      atk.preAtk = atkActs[i - 1]
      
      function atk.isReady(skAct)
        if not skAct.base.isReady(skAct) then
          return false
        end
        local role = skAct.role
        local roleAct = role.skAct
        if roleAct == skAct.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
          return true
        else
          return false
        end
      end
    end
    skActs.spAtk1.snap = {
      frameId = 10010170604,
      minDis = 3,
      maxDis = 5
    }
    
    function skActs.spAtk1.onBegin(spAtk1)
      local role = spAtk1.role
      local target = role.target
      local snapOn = true
      local snap = spAtk1.snap
      if not target then
        snapOn = false
      else
        local dist = get_npc_distance(role.npc, 1, target, true)
        if dist < snap.minDis or dist > snap.maxDis then
          snapOn = false
        end
      end
      if not snapOn then
        set_keyframe_enable(role.npc, snap.frameId, false, false)
      end
      spAtk1.base.onBegin(spAtk1)
    end
    
    function skActs.spAtk3.tarPos()
    end
    
    function skills.spAtk3l.isReady(spAtk3l)
      if not spAtk3l.base.isReady(spAtk3l) then
        return false
      end
      local role = spAtk3l.role
      local fallPos = role:getBladeFallPos()
      local hitAngle = 0
      if fallPos then
        hitAngle = get_target_angel(role.npc, fallPos, true)
      end
      if hitAngle > 0 then
        return false
      end
      return true
    end
  end
  
  function skills.ultStart.onBegin(ultStart)
    local role = ultStart.role
    role:toDualBlade()
    role:set_weapon_attach(true)
    local rolePos = vec2.CloneXZ(get_npc_pos(role.npc))
    local tarPos = role.target and vec2.CloneXZ(get_npc_pos(role.target))
    local centerPos = tarPos
    centerPos = centerPos or vec2.CloneXZ(get_npc_offset_position(role.npc, nil, 0, 5))
    local offset = vec2.New(0.707, -0.707) * 3.5
    local centerRole = rolePos - centerPos
    if centerRole:Dot(offset) > 0 then
      offset = -offset
    end
    local flashPos = centerPos + offset
    ultStart.centerPos = centerPos
    ultStart.flashPos = flashPos
    flash_to_pos(role.npc, centerPos.x, centerPos.y)
    lookat_position(role.npc, flashPos.x, flashPos.y, true)
  end
  
  function skills.ultStart.startFrame(ultStart)
    if ultStart.skAct:isUltFast() then
      return 3
    else
      return 0
    end
  end
  
  misLogics.ultStart.skill = skills.ultStart
  
  function misLogics.ultStart.onBegin(ultStart, misInst, owner, posX, posZ)
    local role = ultStart.unit
    abort_skill(role.npc)
    local skill = ultStart.skill
    local flashPos = skill.flashPos
    flash_to_pos(role.npc, flashPos.x, flashPos.y)
    local centerPos = skill.centerPos
    lookat_position(role.npc, centerPos.x, centerPos.y, true)
    skill:deriveAuto()
  end
  
  function skills.finish.onBegin(finish)
    finish.base.onBegin(finish)
    role:set_weapon_attach(true)
  end
  
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function misCollide(dashCollide, misInst, mis2, misOwner, mis2Owner)
      if mis2Owner ~= misOwner then
        return
      end
      if mis2.missile_id == 10010174202 then
        role.pickBladeSlash(role.misLogics.bladeFall, mis2, role.npc, role.npc)
      end
    end
    
    tool.insert(misLogics.dashCollide[1], "onCollideMis", misCollide)
    tool.insert(misLogics.dashCollide[2], "onCollideMis", misCollide)
    misLogics.bladeFallPos2.onHit = role.pickBladeSlash
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.wrapAroundHit1 = misLogics.wrapAroundHit[3]
    role.wrapAroundHit2 = misLogics.wrapAroundHit[4]
    
    local function atkAddition(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1017138 == magic_id then
        cast_missile(role.npc, target, nil, nil, 10010174209, 0)
      end
    end
    
    tool.insert(role, "before_damage", atkAddition)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function toStreakEx(skAct)
      local role = skAct.role
      
      cast_magic(role.npc, role.npc, magics.streakExState.id, 1)
    end
    
    tool.insert(skActs.ult, "onCastTime", toStreakEx)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skActs.stab.damageFix = magics.stabDamageFix
    
    local function stabDamageFix(stab, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicId)
      cast_magic(casterNpc, casterNpc, stab.damageFix.id, 1)
    end
    
    tool.insert(skActs.stab, "befDamage", stabDamageFix)
    magics.stabDeriveDamage.damageFix = magics.stabDamageFix
    
    local function stabDeriveDamageFix(stabDeriveDamage, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicLv)
      cast_magic(casterNpc, casterNpc, stabDeriveDamage.damageFix.id, 1)
    end
    
    tool.insert(magics.stabDeriveDamage, "befDamage", stabDeriveDamageFix)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(stab, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicId)
      cast_magic(role.npc, role.npc, 1017202, 1)
    end
    
    tool.insert(magics.wrapAroundDamage[1], "befDamage", damageFix)
    tool.insert(magics.wrapAroundDamage[2], "befDamage", damageFix)
    tool.insert(magics.wrapAroundDamage[3], "befDamage", damageFix)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function toSingleDamageFix(role)
      if role.isSingleBlade1 then
        return
      end
      role.isSingleBlade1 = true
      cast_magic(role.npc, role.npc, role.magics.alterWeaponBuff[1].id, 1)
    end
    
    tool.insert(role, "toSingleBlade", toSingleDamageFix)
    
    local function toDualDamageFix(role)
      if not role.isSingleBlade1 then
        return
      end
      role.isSingleBlade1 = false
      cast_magic(role.npc, role.npc, role.magics.alterWeaponBuff[1].id, 1)
    end
    
    tool.insert(role, "toDualBlade", toDualDamageFix)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(misUltHit, misInst, casterNpc, hitTarget, hitType, skill)
      cast_magic(role.npc, hitTarget, 1017204, 1)
    end
    
    tool.insert(misLogics.misUltHit, "onHit", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(damage, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicLv)
      cast_magic(casterNpc, casterNpc, role.destiniesMagic.Lv5.upId[1], 1)
    end
    
    tool.insert(magics.destiniesMagic5Id[1], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[2], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[3], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[4], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[5], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[6], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[7], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[8], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[9], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[10], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[11], "befDamage", damageFix)
    tool.insert(magics.destiniesMagic5Id[12], "befDamage", damageFix)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, 100101791, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, 100101791, 2, true, true)
    skills.streakExEnd.extraHit = misLogics.streakExExtraHit
    
    local function extraHit(streakExEnd, casterNpc, hitTarget, hitType, missile)
      if missile.d_isUsed then
        return
      end
      missile.d_isUsed = true
      cast_missile(casterNpc, hitTarget, nil, nil, streakExEnd.extraHit.id, streakExEnd.role.spWeapon.lv, nil)
    end
    
    tool.insert(skills.streakExEnd, "onHit", extraHit)
    skActs.streak.damageFix = magics.streakExDamageFix
    skActs.streakEx.damageFix = magics.streakExDamageFix
    
    local function damageFix(streakEx, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicId)
      cast_magic(casterNpc, casterNpc, streakEx.damageFix.id, streakEx.role.spWeapon.lv)
    end
    
    tool.insert(skActs.streakEx, "befDamage", damageFix)
    tool.insert(skActs.streak, "befDamage", damageFix)
  end
end

function Nanna.getBladeFallPos(role)
  local misInsts = role.misInsts
  local bladeFallPos = misInsts.bladeFallPos1 or misInsts.bladeFallPos2
  return bladeFallPos
end

function Nanna.set_weapon_attach(role, state)
  local attachName = "H1001017_weapon_2"
  if role.spWeapon.lv >= 1 then
    attachName = "H1001017_Weapon_2_2"
  end
  set_weapon_attach_point(role.npc, attachName, state)
end

function Nanna.toDualBlade(role)
  role.isSingleBlade = false
  local misInsts = role.misInsts
  local bladeFall = misInsts.bladeFall
  if bladeFall then
    misInsts.bladeFall = nil
    remove_missile(bladeFall, false)
  end
  local fallPos1 = misInsts.bladeFallPos1
  if fallPos1 then
    misInsts.bladeFallPos1 = nil
    remove_missile(fallPos1, false)
  end
  local fallPos2 = misInsts.bladeFallPos2
  if fallPos2 then
    misInsts.bladeFallPos2 = nil
    remove_missile(fallPos2, false)
  end
  local btns = role.btns
  local icons = role.icons
  btns.sk1:setIcon(icons.storm)
  btns.atk:setIcon(icons.atk)
end

function Nanna.toSingleBlade(role)
  role.isSingleBlade = true
  local btns = role.btns
  local icons = role.icons
  btns.sk1:setIcon(icons.stab)
  btns.atk:setIcon(icons.spAtk)
  role:set_weapon_attach(false)
  cast_magic(role.npc, role.npc, role.magics.bladeFallingTag.id, 1)
end

function Nanna.pickBlade(bladeFall, misInst, casterNpc, hitTarget, hitType, skill)
  if hitTarget ~= casterNpc then
    return
  end
  local role = bladeFall.unit
  misInst.d_isUsed = true
  role:toDualBlade(role)
  local magics = role.magics
  cast_magic(role.npc, role.npc, magics.streakExState.id, 1)
  cast_magic(role.npc, role.npc, magics.bladePickFx.id, 1)
  cast_magic(role.npc, role.npc, magics.bladeRecover.id, 1)
end

function Nanna.pickBladeSlash(bladeFall, misInst, casterNpc, hitTarget, hitType, skill)
  if hitTarget ~= casterNpc then
    return
  end
  local role = bladeFall.unit
  local magics = role.magics
  if check_magic(role.npc, magics.bladePickMask.id) then
    return
  end
  misInst.d_isUsed = true
  role:toDualBlade()
  local magics = role.magics
  cast_magic(role.npc, role.npc, magics.streakExState.id, 1)
  local roundSlash = role.skActs.roundSlash
  roundSlash:tarPos()
  if roundSlash:isReady() then
    roundSlash:start()
  end
end

function Nanna.onRampageStart(role, stage)
  role.skills.storm:ignoreCost()
  role.skills.stabStart:ignoreCost()
  role.skills.streak:ignoreCost()
end

function Nanna.onRampageEnd(role, stage)
  role.skills.storm:restoreCost()
  role.skills.stabStart:restoreCost()
  role.skills.streak:restoreCost()
end

function Nanna.onLinkChange(role, newStage, oldStage)
  if 2 ~= newStage then
    return
  end
end

function Nanna.expand_stab_angle_threshold(role, angle)
  local stab = role.skActs.stab
  stab.angleThreshold = angle
end

function Nanna.recover_stab_angle_threshold(role)
  local stab = role.skActs.stab
  stab.angleThreshold = role.stab_angle_threshold
  stab.ignoreInput = false
end

function Nanna.ignore_stab_angle_threshold(role)
  local stab = role.skActs.stab
  stab.ignoreInput = true
end

function Nanna.force_shift_magic_init(role, magic_id, target)
  if 101703 == magic_id then
    local monsterPos = get_npc_pos(target)
    local basePos = get_npc_offset_position(role.npc, nil, 0, 2.5)
    return basePos
  end
end

function Nanna.on_tp_room_finish(role)
  role.base.on_tp_room_finish(role)
  role:toDualBlade()
  role:set_weapon_attach(true)
end

return Nanna
