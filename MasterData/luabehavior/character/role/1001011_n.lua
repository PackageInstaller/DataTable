local roleBase = import("character.base.role_base")
local Ming = Util.create_child_mt(roleBase)

function Ming._init(role, npc)
  role.npc = npc
  local misIds = {
    misSkill02 = 10010110902,
    misSkill02_2 = 10010112101,
    misLinkQte = {10010113701, 10010113501},
    misSoulLine = {
      10010110801,
      10010110802,
      10010110803
    },
    misFireAround = {
      10010114102,
      10010114103,
      10010114201,
      10010114202
    },
    misUltHit = 10010118102,
    misUltCamera = 10010118108
  }
  local magicIds = {}
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local destinies = role.destinies
  local traces = role.traces
  role.now_time = 0
  role.soul_missile_lv = get_skill_lv(role.npc, 100101109) or 0
  cast_magic(role.npc, role.npc, 101116, 1)
  role.soulLineTarget = {}
  local soulMissileId = {
    [1] = 10010110801,
    [2] = 10010110802,
    [3] = {
      10010110803,
      10010110804,
      10010110805,
      10010110806
    }
  }
  local soulMissile = {}
  role.soulLineDeliverTarget = nil
  role.soulLineDeliverTime = 0
  role.soulLineDeliverDamage = nil
  role.soulLindDeliverFix = 1011209
  local skill02Hit = true
  local skill02Indicator = false
  role.fireAroundMissile = {}
  role.fireAroundLoopTime = 0
  role.fireAroundLoopTimeMax = 0
  role.fireAroundTimeFix = 0
  role.fireAroundKeepLv = 0
  role.fireAroundStates = false
  role.fireAroundHitStates = {false, false}
  role.fireAroundHitTime = 0
  role.fireAroundHitTarget = {}
  role.fireAroundMagicTime = 0
  role.ultHit = true
  local traces_magic = {}
  local traces = role.traces
  traces[1011281] = 1
  traces[1011282] = 2
  traces[1011283] = 3
  traces[1011284] = 4
  traces[1011285] = 5
  local destinies = role.destinies
  destinies[1011181] = 1
  destinies[1011182] = 2
  destinies[1011183] = 3
  destinies[1011184] = 4
  destinies[1011185] = 5
  role.destiniesMagic = {
    Lv1 = 1011201,
    Lv2 = 1011202,
    Lv3 = 1011204,
    Lv4 = 1011205,
    Lv5 = {
      1011206,
      1011207,
      1011208
    }
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1011200
  role.spWeaponMagic = {1011210, 1011211}
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function skill03_2(misFireAround, misInst, owner, posX, posZ)
      cast_missile(role.npc, nil, posX, posZ, misIds.misFireAround[3], role.soul_missile_lv)
      
      cast_missile(role.npc, nil, posX, posZ, misIds.misFireAround[4], role.soul_missile_lv)
    end
    
    tool.insert(misLogics.misFireAround[1], "onEnd", skill03_2)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.fireAroundTimeFix = 5
  end
  traces[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function distanceChange(misSoulLine, misInst, owner, posX, posZ)
      for k, v in pairs(role.soulLineTarget) do
        if v and k > 1 and k <= 4 then
          local pos = get_npc_pos(v)
          
          cast_missile(role.soulLineTarget[k - 1], role.soulLineTarget[k], nil, nil, 10010110810, 1)
          cast_missile(role.soulLineTarget[k], role.soulLineTarget[k - 1], nil, nil, 10010110810, 1)
        end
      end
    end
    
    tool.insert(misLogics.misSoulLine[2], "onBegin", distanceChange)
  end
  traces[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.soulLindDeliverFix = role.destiniesMagic.Lv1
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function resistanceUp(misSoulLine, misInst, owner, posX, posZ)
      local team_hero_list = {
        get_scene_hero_by_poskey(21),
        
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for k, v in pairs(team_hero_list) do
        cast_magic(v, v, role.destiniesMagic.Lv2, 1)
      end
    end
    
    local function resistanceDown(misSoulLine, misInst, owner, posX, posZ)
      local team_hero_list = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for k, v in pairs(team_hero_list) do
        abort_magic_by_id(v, role.destiniesMagic.Lv2)
      end
    end
    
    tool.insert(misLogics.misFireAround[2], "onBegin", resistanceUp)
    tool.insert(misLogics.misFireAround[2], "onEnd", resistanceDown)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function defenseDle(misFireAround, misInst, casterNpc, hitTarget, hitType, skill)
      cast_magic(role.npc, hitTarget, role.destiniesMagic.Lv3, 1)
    end
    
    tool.insert(misLogics.misFireAround[1], "onHit", defenseDle)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1011107 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv4, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1011122 == magic_id and role.traceLv >= 2 and role.fireAroundKeepLv >= 1 then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5[role.fireAroundKeepLv], 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function spWeaponMagicUp(misSoulLine, misInst, owner, posX, posZ)
      cast_magic(role.npc, role.npc, role.spWeaponMagic[1], role.spWeapon.lv)
      
      role.tool:castMagicToTeam(role.spWeaponMagic[2], role.spWeapon.lv)
    end
    
    local function spWeaponMagicDown(misSoulLine, misInst, owner, posX, posZ)
      abort_magic_by_id(role.npc, role.spWeaponMagic[1])
      tool:abortMagicToTeam(role.spWeaponMagic[2])
    end
    
    tool.insert(misLogics.misFireAround[2], "onBegin", spWeaponMagicUp)
    tool.insert(misLogics.misFireAround[2], "onEnd", spWeaponMagicDown)
  end
  
  function SoulMissileLsitSave(missile)
    table.insert(soulMissile, missile)
  end
  
  function SoulMissileListRemove(missile)
    for k, v in pairs(soulMissile) do
      if missile == v then
        table.remove(soulMissile, k)
      end
    end
  end
  
  function SoulMissileRemove()
    for k, v in pairs(soulMissile) do
      stop_missile(v)
    end
  end
  
  misLogics.misSoulLine[1].onBegin = function(missile_cfg, missile, owner, pos_x, pos_z)
    SoulMissileLsitSave(missile)
    local sk1 = role.btns.sk1
    local skill02_2 = role.icons.skill02_2Start
    sk1:setIcon(skill02_2)
  end
  misLogics.misSoulLine[1].onEnd = function(missile_cfg, missile, owner, pos_x, pos_z)
    SoulMissileListRemove(missile)
    if role:isRampage() then
      return
    end
    local sk1 = role.btns.sk1
    local skill02_1 = role.icons.skill02_1
    sk1:setIcon(skill02_1)
  end
  misLogics.misSoulLine[2].onBegin = function(missile_cfg, missile, owner, pos_x, pos_z)
    SoulMissileLsitSave(missile)
  end
  misLogics.misSoulLine[2].onEnd = function(missile_cfg, missile, owner, pos_x, pos_z)
    role.soulLineTarget = {}
    SoulMissileListRemove(missile)
  end
  misLogics.misSoulLine[3].onBegin = function(missile_cfg, missile, owner, pos_x, pos_z)
    SoulMissileLsitSave(missile)
  end
  misLogics.misSoulLine[3].onEnd = function(missile_cfg, missile, owner, pos_x, pos_z)
    role.soulLineTarget = {}
    SoulMissileListRemove(missile)
  end
  
  function skills.skill02_1.onBegin(skill02_2)
    skill02Hit = true
    SoulMissileRemove()
  end
  
  function misLogics.misSkill02.onHit(misSkill02, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
    if skill02Hit and 5 ~= get_role_kind(hitTarget) then
      skill02Hit = false
      role.soulLineTarget = {}
      role.soulLineTarget[1] = hitTarget
      local pos = get_npc_pos(role.soulLineTarget[1])
      cast_missile(role.npc, role.soulLineTarget[1], pos.x, pos.z, soulMissileId[1], role.soul_missile_lv)
    end
  end
  
  function skills.skill02_2Start.onBegin(skill02_2Start)
    skill02_2Start.hasIndi = skill02_2Start.role.indiMgr:isActive()
    skill02_2Start.base.onBegin(skill02_2Start)
  end
  
  function skills.skill02_2Start.onEnd(skill02_2Start)
    skill02_2Start.base.onEnd(skill02_2Start)
    skill02Hit = true
    local indiMgr = skill02_2Start.role.indiMgr
    local pos_button = {x = nil, z = nil}
    pos_button.x, pos_button.z = get_indicator_pos(19)
    local tarpos
    if pos_button.x ~= nil and nil ~= pos_button.z then
      tarpos = get_position_offset_position(pos_button, get_npc_pos(role.npc), 0, 1)
    end
    local targetList, skill02_2Target
    if not skill02_2Start.hasIndi then
      targetList = search_npc(role.npc, 4, 20, nil, false, true)
      local targetPosList = {}
      if targetList[2] then
        for k, v in ipairs(targetList) do
          if v ~= role.soulLineTarget[1] then
            local list = {
              v,
              get_npc_distance(role.npc, 1, v, true)
            }
            table.insert(targetPosList, list)
          end
        end
        table.sort(targetPosList, function(a, b)
          return a[2] < b[2]
        end)
        skill02_2Target = targetPosList[1][1]
      else
        skill02_2Target = targetList[1]
      end
    end
    if skill02_2Target then
      tarpos = get_npc_offset_position(skill02_2Target, get_npc_pos(role.npc), 180, 0.5)
      local is_pos, setPos = get_nearest_walkable_pos(get_npc_pos(role.npc), tarpos, 0.5)
      role:tp(setPos, 7, tarpos)
    else
      flash_to_pos(role.npc, pos_button.x, pos_button.z)
    end
  end
  
  function misLogics.misSkill02_2.onHit(misSkill02_2, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
    if skill02Hit and not part_npc and 5 ~= get_role_kind(hitTarget) and hitTarget ~= role.soulLineTarget[1] then
      skill02Hit = false
      SoulMissileRemove()
      role.soulLineTarget[2] = hitTarget
      if role.soulLineTarget[1] and not check_npc_die(role.soulLineTarget[1]) then
        local pos = get_npc_pos(role.soulLineTarget[1])
        cast_missile(role.soulLineTarget[1], role.soulLineTarget[2], pos.x, pos.z, soulMissileId[2], role.soul_missile_lv)
      end
    end
  end
  
  function icons.skill03.updateEnhance(skill03)
    skill03.isEnhance = skill03.isEnable
  end
  
  function skills.skill03.onBegin(skill03)
    skill03.base.onBegin(skill03)
    if role.fireAroundStates then
      role.fireAroundLoopTime = 0
    end
    role.skill03Logic(role)
  end
  
  function role.skill03Logic(role)
    role.now_time = get_npc_time(role.npc)
    if role.fireAroundStates and (role.now_time >= role.fireAroundLoopTime or role.now_time >= role.fireAroundLoopTimeMax) then
      role.fireAroundStates = false
      remove_missile(role.fireAroundMissile[1], true)
      remove_missile(role.fireAroundMissile[2], true)
      role.fireAroundMissile = {}
      local keeptime = role.fireAroundLoopTimeMax - role.fireAroundLoopTime
      if role.destinyLv >= 5 and role.traceLv >= 2 then
        if keeptime >= 4 then
          role.fireAroundKeepLv = 1
        elseif keeptime < 4 and keeptime > 2 then
          role.fireAroundKeepLv = 2
        elseif keeptime <= 2 then
          role.fireAroundKeepLv = 3
        end
      end
    end
    if role.fireAroundHitStates[1] and role.now_time >= role.fireAroundHitTime then
      role.fireAroundHitStates = {false, false}
      for k, v in pairs(role.soulLineTarget) do
        role.fireAroundHitTarget[k] = v
      end
    end
    if role.fireAroundHitStates[1] and role.fireAroundHitStates[2] then
      role.fireAroundLoopTime = role.fireAroundLoopTime + 0.5
      role.fireAroundHitStates = {false, false}
      for k, v in pairs(role.soulLineTarget) do
        role.fireAroundHitTarget[k] = v
      end
      role.fireAroundMagicTime = role.now_time + 0.1
    end
  end
  
  misLogics.misFireAround[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    table.insert(role.fireAroundMissile, misInst)
    for k, v in pairs(role.soulLineTarget) do
      role.fireAroundHitTarget[k] = v
    end
    role.fireAroundLoopTime = role.now_time + 10
    role.fireAroundLoopTimeMax = role.fireAroundLoopTime + role.fireAroundTimeFix
    role.fireAroundStates = true
    if role:isRampage() then
      local sk2 = role.btns.sk2
      local skill03 = role.icons.skill03End
      sk2:setIcon(skill03)
    end
  end
  misLogics.misFireAround[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    table.insert(role.fireAroundMissile, misInst)
  end
  misLogics.misFireAround[1].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    cast_magic(role.npc, role.npc, 101154, 1)
    local sk2 = role.btns.sk2
    local skill03 = role.icons.skill03
    sk2:setIcon(skill03)
  end
  
  function skills.skill03End.onBegin(skill)
    local pos = get_npc_pos(role.npc)
    cast_missile(role.npc, nil, pos.x, pos.z, misIds.misFireAround[3], role.soul_missile_lv)
    cast_missile(role.npc, nil, pos.x, pos.z, misIds.misFireAround[4], role.soul_missile_lv)
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 3
    else
      return 0
    end
  end
  
  function misLogics.misUltCamera.onBegin(misUltCamera, misInst, casterNpc, hitTarget, hitType, skill)
    role:change_follow_target(1, misInst, {
      10,
      10,
      {
        x = 0,
        y = 0,
        z = 0
      },
      0,
      0,
      0.1
    })
  end
  
  function misLogics.misUltCamera.onEnd(misUltCamera, misInst, casterNpc, hitTarget, hitType, skill)
    role:change_follow_target(4)
    change_focus_follow_speed(3)
  end
  
  function skills.exQteEnd.onBegin(exQteEnd)
    exQteEnd.base.onBegin(exQteEnd)
    SoulMissileRemove()
  end
  
  function skills.skill02ExEnd.onBegin(skill02_2Start)
    SoulMissileRemove()
    local posTarget, posSet
    if role.target and not check_npc_die(role.target) then
      posTarget = get_npc_pos(role.target)
      posSet = get_npc_offset_position(role.target, get_npc_pos(role.npc), 0, 1)
    else
      posSet = get_npc_offset_position(role.npc, nil, 0, 3)
    end
    flash_to_pos(role.npc, posSet.x, posSet.z)
  end
  
  do
    local function linkQteTargetSave(misUltHit, misInst, casterNpc, hitTarget, hitType, skill)
      if not role.soulLineTarget[4] then
        table.insert(role.soulLineTarget, hitTarget)
      end
    end
    
    misLogics.misLinkQte[1].onHit = linkQteTargetSave
    misLogics.misLinkQte[2].onHit = linkQteTargetSave
    
    local function linkQteSoulLine(missile_cfg, missile, owner, pos_x, pos_z)
      for k, v in pairs(role.soulLineTarget) do
        if v and k > 1 and k <= 4 and role.soulLineTarget[k - 1] ~= role.soulLineTarget[k] then
          local pos = get_npc_pos(v)
          cast_missile(role.soulLineTarget[k - 1], role.soulLineTarget[k], pos_x, pos_z, soulMissileId[3][1], role.soul_missile_lv)
        end
      end
    end
    
    misLogics.misLinkQte[1].onEnd = linkQteSoulLine
    misLogics.misLinkQte[2].onEnd = linkQteSoulLine
  end
  
  function skills.born.onBegin(born)
    born.base.onBegin(born)
    abort_magic_by_id(role.npc, 101116)
  end
end

function Ming.on_skill_hit(role, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if role.fireAroundStates and missile_cfg.Id == 10010114102 and role.fireAroundHitTarget[1] and role.now_time >= role.fireAroundMagicTime then
    for k, v in pairs(role.fireAroundHitTarget) do
      if hit_target == v then
        table.remove(role.fireAroundHitTarget, k)
        if not role.fireAroundHitStates[1] then
          role.fireAroundHitStates[1] = true
          role.fireAroundHitTime = role.now_time + 0.5
          break
        end
        role.fireAroundHitStates[2] = true
        break
      end
    end
  end
end

function Ming.before_damage(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  role.base.before_damage(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if role.soulLineTarget[2] and role.now_time >= role.soulLineDeliverTime then
    for k, v in pairs(role.soulLineTarget) do
      if v == target and role.now_time >= role.soulLineDeliverTime then
        role.soulLineDeliverTarget = v
        role.soulLineDeliverTime = role.now_time + 0.2
        for k, v in pairs(role.soulLineTarget) do
          if role.soulLineDeliverTarget and v ~= role.soulLineDeliverTarget then
            role.soulLineDeliverDamage = magic_id
            cast_magic(role.npc, v, magic_id, magic_level)
            cast_missile(role.npc, v, nil, nil, 10010110807, 1, nil, nil)
          end
        end
        role.soulLineDeliverDamage = nil
        role.soulLineDeliverTarget = nil
      end
    end
  end
  if magic_id == role.soulLineDeliverDamage and target ~= role.soulLineDeliverTarget then
    cast_magic(role.npc, role.npc, role.soulLindDeliverFix, 0)
  end
end

function Ming.onRampageStart(role, stage)
  local sk1 = role.btns.sk1
  local skill02 = role.icons.skill02ExStart
  sk1:setIcon(skill02)
end

function Ming.onRampageEnd(role, stage)
  local sk1 = role.btns.sk1
  local skill02 = role.icons.skill02_1
  local sk2 = role.btns.sk2
  local skill03 = role.icons.skill03
  sk1:setIcon(skill02)
  sk2:setIcon(skill03)
  cast_magic(role.npc, role.npc, 1011155, 1)
end

function Ming.on_frame_background(role)
  role.base.on_frame_background(role)
  role.skill03Logic(role)
end

function Ming.on_frame(role)
  role.base.on_frame(role)
  role.skill03Logic(role)
end

return Ming
