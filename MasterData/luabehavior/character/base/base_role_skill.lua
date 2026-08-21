local VAR_TYPE = Const.VAR_TYPE
local roleSkill = {}
roleSkill.__index = roleSkill
roleSkill.SKILL_ATTACK_TYPE = Config.SKILL_ATTACK_TYPE

function roleSkill.new(base, role, _cfg)
  local result = setmetatable({}, base)
  result.base = base
  result.role = role
  result.tool = role.tool
  result.inputor = role.inputor
  result.debugSwitch = role.debugSwitch
  result.isIgnoreCost = false
  local cfg = _cfg or {}
  result.cfg = cfg
  result.name = cfg.Name
  result.id = cfg.Id
  result.animName = cfg.Animation
  result.v_start_frame = cfg.StartFrame or 0
  result.cost = {
    battle = cfg.BattleResCost or 0,
    skill = cfg.SkillResCost or 0,
    ult = cfg.UltResCost or 0,
    cd = cfg.CdChargePerCost or 0
  }
  local tool = role.tool
  result.derives = {
    auto = tool:newChooseList(),
    manual = tool:newChooseList()
  }
  result.castId = 0
  result.befTime = cfg.BeforeTime or 0
  result.isBefOver = false
  result.castTime = cfg.CastTime or 0
  result.isCastOver = false
  result.afterTime = cfg.AfterTime or 0
  return result
end

function roleSkill.initCopy(skill, copyBase)
  local skill = skill
  skill.copyBase = copyBase
  if not rawget(copyBase, "__index") then
    copyBase.__index = copyBase.indexForCopy
  end
  setmetatable(skill, copyBase)
end

function roleSkill.doCopy(skill)
  local copyBase = skill.copyBase
  do
    local VAR_TYPE = VAR_TYPE
    local THREAD = VAR_TYPE.THREAD
    local FUNCTION = VAR_TYPE.FUNCTION
    for key, value in pairs(copyBase) do
      if rawget(skill, key) ~= nil then
        return
      end
      local type = type(value)
      if type == FUNCTION then
        return
      elseif type ~= THREAD then
        skill[key] = value
      end
    end
  end
end

function roleSkill.indexForCopy(tbl, key)
  local copyBase = tbl.copyBase
  local typeBase = tbl.base
  local copyBaseField = rawget(copyBase, key)
  if copyBaseField then
    return copyBaseField
  end
  return typeBase[key]
end

function roleSkill.isUlt(skill)
  return skill.cfg.SkillType == skill.SKILL_ATTACK_TYPE.APPEAR
end

function roleSkill.clearCd(skill)
  local npc = skill.role.npc
  local id = skill.id
  set_skill_ignore_expend_detect(npc, id, true)
  set_skill_ignore_expend_detect(npc, id, false)
end

function roleSkill.insertFun(skill, funName, newFun)
  skill.tool.insert(skill, funName, newFun)
end

function roleSkill.removeFun(skill, funName, newFun)
  skill.tool.remove(skill, funName, newFun)
end

function roleSkill.ignoreCost(skill)
  skill.isIgnoreCost = true
  set_skill_ignore_expend_detect(skill.role.npc, skill.id, true)
end

function roleSkill.restoreCost(skill)
  skill.isIgnoreCost = false
  set_skill_ignore_expend_detect(skill.role.npc, skill.id, false)
end

function roleSkill.animLength(skill)
  local role = skill.role
  local anim_motion_cfg = role.npc.motion_cfg[skill.animName]
  if not anim_motion_cfg then
    role:debugOutput("animation motion cfg lost, ", skill.id, skill.animName)
    return 0
  else
    return #anim_motion_cfg.OffsetZ
  end
end

function roleSkill.isReady(skill, skAct)
  if skill.isIgnoreCost then
    return true
  end
  local cost = skill.cost
  local role = skill.role
  local cur = role.attr
  if cur[2] < cost.battle then
    return false
  end
  if cur[74] < cost.skill then
    return false
  end
  if cur[108] < cost.ult then
    return false
  end
  if get_npc_cd_charge(role.npc, skill.id) < cost.cd then
    return false
  end
  return true
end

function roleSkill.tarPos(skill, skAct)
  skAct = skAct or skill.skAct
  if skAct and 1 == skAct.skillCount then
    return skAct.v_tarPos
  end
end

function roleSkill.skInfo(skill)
  local skActInfo = skill.skAct and skill.skAct.info
  if not skActInfo then
    return
  end
  local skillInfo = {}
  for key, value in pairs(skActInfo) do
    skillInfo[key] = value
  end
  return skillInfo
end

function roleSkill.start(skill, skAct)
  local role = skill.role
  if skAct then
    local skill = skill
    skill.skAct = skAct
    skAct.curSk = skill
    skAct.skillCount = skAct.skillCount + 1
  else
    role:debugOutput("skills." .. skill.name .. ".start() is called without skAct")
  end
  skill._time = get_time()
  skill.isBefOver = false
  skill.isCastOver = false
  skill.deriveTar = nil
  skill.isDerived = false
  skill.castId = skill.castId + 1
  abort_skill(role.npc)
  local tarPos, bIgnoreDefaultTarget
  if skill.tarPos then
    tarPos, bIgnoreDefaultTarget = skill:tarPos(skAct)
  end
  local posx, posz
  if tarPos then
    posx, posz = tarPos.x, tarPos.z
  end
  local target
  if skill.target then
    target = skill:target()
  elseif not bIgnoreDefaultTarget then
    target = role.target
  end
  local skInfo = skill:skInfo()
  local startFrame = skill.startFrame and skill:startFrame() or skill.v_start_frame
  if skill.debugSwitch.castSkillPos then
    local x, y, z = 0, 0, 0
    local targetPos = target and target:get_pos_vec3()
    if targetPos then
      x, y, z = targetPos.x, targetPos.y, targetPos.z
    end
    if posx and posz then
      x, z = posx, posz
    end
    role:debugCubeA(x, y, z, "CastSkillPos")
  end
  cast_skill(role.npc, target, skill.id, posx, posz, skInfo, startFrame)
  set_skill_end_to_idle(skill.role.npc, true)
end

function roleSkill.tick(skill)
end

function roleSkill.onBegin(skill)
end

function roleSkill.onBefTime(skill)
  skill.isBefOver = true
  local skAct = skill.skAct
  if not skAct then
    return
  end
  if not skAct.isBefOver and (skill.castTime > 0.01 or skill.afterTime > 0.01) then
    skAct:onBefTime()
  end
end

function roleSkill.onHit(skill, casterNpc, hitTarget, hitType, missile, part_npc)
end

function roleSkill.onCastTime(skill)
  skill.isCastOver = true
  local skAct = skill.skAct
  if not skAct then
    return
  end
  if skill.isDerived then
    return
  end
  if skill.afterTime > 0.01 and not skAct.isCastOver then
    skill.skAct:onCastTime()
  end
end

function roleSkill.befDamage(skill, casterNpc, hitTarget, damageSign, damageType, targetCamp, changeLevel, magicLevel, misInst, magicId)
end

function roleSkill.onKill(skill, caster, target, skInfo)
end

function roleSkill.onBreak(skill)
end

function roleSkill.derive(skill, deriveTar)
  local role = skill.role
  local skAct = skill.skAct
  if role.skAct ~= skAct then
    role:debugOutput(skill.name .. ":derive() is called out of skAct, role.skAct is " .. role.skAct.name .. ", skill.skAct is " .. skAct.name)
    return
  end
  if not deriveTar then
    deriveTar = skill.derives.manual:choose(skAct)
  elseif deriveTar.choose then
    deriveTar = deriveTar:choose(skAct)
  end
  if deriveTar then
    skill.isDerived = true
    set_skill_end_to_idle(skill.role.npc, false)
    deriveTar:start(skAct)
  end
  return deriveTar
end

function roleSkill.deriveAuto(skill)
  local role = skill.role
  local skAct = skill.skAct
  if role.skAct ~= skAct then
    role:debugOutput(skill.name .. ":derive() is called out of skAct, role.skAct is " .. role.skAct.name .. ", skill.skAct is " .. skAct.name)
    return
  end
  local deriveTar = skill.derives.auto:choose(skAct)
  if deriveTar then
    skill.isDerived = true
    deriveTar:start(skAct)
  end
end

function roleSkill.deriveManual(skill)
  local role = skill.role
  local skAct = skill.skAct
  if role.skAct ~= skAct then
    role:debugOutput(skill.name .. ":derive() is called out of skAct, role.skAct is " .. role.skAct.name .. ", skill.skAct is " .. skAct.name)
    return
  end
  local deriveTar = skill.derives.manual:choose(skAct)
  if deriveTar then
    skill.isDerived = true
    deriveTar:start(skAct)
  end
end

function roleSkill.onBefEnd(skill)
  local deriveTar = skill.derives.auto:choose(skill.skAct)
  if deriveTar then
    local skill = skill
    skill.deriveTar = deriveTar
    set_skill_end_to_idle(skill.role.npc, false)
  end
end

function roleSkill.onEnd(skill)
  local deriveTar = skill.deriveTar
  if deriveTar then
    skill:derive(deriveTar)
  else
    local skAct = skill.skAct
    if skAct then
      skAct:onEnd()
    end
  end
end

function roleSkill.isRunning(skill)
  local skAct = skill.skAct
  if not skAct then
    return false
  end
  if not skAct:isRunning() then
    return false
  end
  return skAct.curSk == skill
end

function roleSkill.getSearchCfg(skill)
  local skAct = skill.skAct
  return skAct and skAct.search
end

function roleSkill.setAtkTar(skill, newTarget)
  skill.atkTarget = newTarget
  local role = skill.role
  set_skill_target(role.npc, skill.id, newTarget)
  if not skill:isRunning() then
    return
  end
  local skAct = skill.skAct
  skAct.atkTarget = newTarget
  role.atkTarget = newTarget
end

function roleSkill.searchTar(skill, oriPos, btn, param)
  return skill.role:searchNpc(skill:getSearchCfg(), oriPos, btn, param)
end

function roleSkill.updateAtkTar(skill, config, oriPos, btn, param)
  local target, tarPos = skill.role:searchNpc(config or skill:getSearchCfg(), oriPos, btn, param)
  skill:setAtkTar(target)
  return target, tarPos
end

do return roleSkill end

function roleSkill.target(skill)
  return skill.role.target
end

function roleSkill.startFrame(skill)
end
