local monsterSkill = {}
monsterSkill.__index = monsterSkill
local baseTryList = Util.create_class()

function baseTryList.choose(list)
  for _, obj in ipairs(list) do
    if obj:isReady() then
      return obj
    end
  end
end

function monsterSkill.insertFun(skill, funName, newFun)
  skill.tool.insert(skill, funName, newFun)
end

function monsterSkill.removeFun(skill, funName, newFun)
  skill.tool.remove(skill, funName, newFun)
end

function monsterSkill.new(base, monster, cfg)
  local result = setmetatable({}, base)
  result.base = base
  result.monster = monster
  result.tool = monster.tool
  if type(cfg) == "number" then
    cfg = ShareRes.create("skill.skill", cfg)
  end
  result.cfg = cfg
  result.id = cfg.Id
  result.name = cfg.Name
  result.animName = cfg.Animation
  result.derives = {
    auto = Util.create_child_mt(baseTryList),
    manual = Util.create_child_mt(baseTryList)
  }
  result.state = nil
  result.cd = cfg.CdChargePerCost
  result.timer = 0
  result.befTime = cfg.BeforeTime
  result.castTime = cfg.CastTime
  result.afterTime = cfg.AfterTime
  result.isCastOver = false
  return result
end

function monsterSkill.animMotion(skill, startFrame, endFrame)
  local monster = skill.monster
  local anim_motion_cfg = monster.npc.motion_cfg[skill.animName]
  if not anim_motion_cfg then
    monster:debugOutput("animation motion cfg lost, ", skill.id, skill.animName)
    return 0
  end
  local offsetZ = anim_motion_cfg.OffsetZ
  startFrame = startFrame or 1
  endFrame = endFrame or #offsetZ
  return offsetZ[endFrame] - offsetZ[startFrame]
end

function monsterSkill.animLength(skill)
  local monster = skill.monster
  local anim_motion_cfg = monster.npc.motion_cfg[skill.animName]
  if not anim_motion_cfg then
    monster:debugOutput("animation motion cfg lost, ", skill.id, skill.animName)
    return 0
  end
  return #anim_motion_cfg.OffsetZ
end

function monsterSkill.__call(...)
  local derives = {
    ...
  }
  local self = table.remove(derives, 1)
  self.derives.auto = setmetatable(derives, baseTryList)
  return self
end

function monsterSkill.isReady(skill)
  if get_npc_time(skill.monster.npc) < skill.timer then
    return false
  end
  return true
end

function monsterSkill.startFrame(skill, state)
  state = state or skill.state
  if state and 1 == state.skillCount then
    return state:startFrame()
  else
    return 0
  end
end

function monsterSkill.moveScale(skill, state)
  state = state or skill.state
  if state and 1 == state.skillCount then
    return state:moveScale()
  else
    return 1
  end
end

function monsterSkill.start(skill, state)
  if state then
    skill.state = state
    state.curSk = skill
    state.skillCount = state.skillCount + 1
  else
    Util.debug_output("skills." .. skill.name .. ".start() is called without state")
  end
  local monster = skill.monster
  abort_skill(monster.npc)
  skill.timer = get_npc_time(monster.npc) + skill.cd
  skill.isCastOver = false
  skill.isDerived = false
  local moveScale = skill:moveScale()
  monster:set_move_scale(skill.animName, moveScale)
  local target
  if skill.target then
    target = skill:target()
  else
    target = monster.target
  end
  local tarPos = skill.tarPos and skill:tarPos()
  local posx, posz
  if tarPos then
    posx, posz = tarPos.x, tarPos.z
  end
  local startFrame = skill:startFrame(state)
  cast_skill(monster.npc, target, skill.id, posx, posz, nil, startFrame)
  set_skill_end_to_idle(monster.npc, true)
end

function monsterSkill.onBegin(skill)
end

function monsterSkill.tick(skill)
end

function monsterSkill.onCastTime(skill)
  skill.isCastOver = true
  if not skill.state then
    return
  end
  if skill.isDerived then
    return
  end
  if skill.afterTime > 0.01 and not skill.state.isCastOver then
    skill.state:onCastTime()
  end
end

function monsterSkill.onBreak(skill)
end

function monsterSkill.derive(skill, deriveTar)
  local monster = skill.monster
  if monster.state ~= skill.state then
    monster:debugOutput(skill.name .. ":derive() is called out of state, monster.skAct is " .. monster.state.name .. ", skill.skAct is " .. skill.state.name)
    return
  end
  if not deriveTar then
    deriveTar = skill.derives.manual:choose()
  elseif deriveTar.choose then
    deriveTar = deriveTar:choose()
  end
  if deriveTar then
    skill.isDerived = true
    set_skill_end_to_idle(skill.monster.npc, false)
    deriveTar:start(skill.state)
  end
  return deriveTar
end

function monsterSkill.deriveAuto(skill)
  local monster = skill.monster
  if monster.state ~= skill.state then
    monster:debugOutput(skill.name .. ":derive() is called out of state, monster.skAct is " .. monster.state.name .. ", skill.skAct is " .. skill.state.name)
    return
  end
  local deriveTar = skill.derives.auto:choose()
  if deriveTar then
    skill.isDerived = true
    deriveTar:start(skill.state)
  end
end

function monsterSkill.deriveManual(skill)
  local monster = skill.monster
  if monster.state ~= skill.state then
    monster:debugOutput(skill.name .. ":derive() is called out of state, monster.skAct is " .. monster.state.name .. ", skill.skAct is " .. skill.state.name)
    return
  end
  local deriveTar = skill.derives.manual:choose()
  if deriveTar then
    skill.isDerived = true
    deriveTar:start(skill.state)
  end
end

function monsterSkill.onBefEnd(skill)
  local deriveTar = skill.derives.auto:choose()
  skill.deriveTar = deriveTar
  if deriveTar then
    set_skill_end_to_idle(skill.monster.npc, false)
  end
end

function monsterSkill.onEnd(skill)
  local deriveTar = skill.deriveTar
  if deriveTar then
    skill:derive(deriveTar)
  else
    local state = skill.state
    if state then
      state:onEnd()
    end
  end
end

return monsterSkill
