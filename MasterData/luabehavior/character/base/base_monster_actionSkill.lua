local monsterActionSkill = {}
monsterActionSkill.__index = monsterActionSkill

function monsterActionSkill.insertFun(act, funName, newFun)
  act.tool.insert(act, funName, newFun)
end

function monsterActionSkill.removeFun(act, funName, newFun)
  act.tool.remove(act, funName, newFun)
end

function monsterActionSkill.new(base, name, monster, skill, cd, timer, minDis, maxDis, startAngle, endAngle, intervalOffset, startFrame, moveScaleZ)
  local result = setmetatable({}, base)
  result.base = base
  result.name = name
  result.monster = monster
  result.tree = monster.tree
  result.tool = monster.tool
  result.cd = cd or 0
  result.timer = timer or 0
  result.minDis = minDis or -1
  result.maxDis = maxDis or math.huge
  result.trans = {
    prio = 1,
    enable = {},
    disable = {}
  }
  if startAngle then
    startAngle = startAngle % 360
    if startAngle >= 180 then
      startAngle = startAngle - 360 or startAngle
    end
  else
    startAngle = -180
  end
  if endAngle then
    endAngle = endAngle % 360
    if endAngle > 180 then
      endAngle = endAngle - 360 or endAngle
    end
  else
    endAngle = 180
  end
  result.startAngle = startAngle
  result.endAngle = endAngle
  result.intervalOffset = intervalOffset or 0
  result.v_start_frame = startFrame or 0
  result.v_move_scale_z = moveScaleZ or 1
  result.type = "action"
  result.parent = nil
  result.nextSibling = nil
  result.skill = skill
  result.children = {}
  result.isCastOver = false
  result.skillCount = 0
  result.isHit = false
  return result
end

function monsterActionSkill.__call(...)
  local actSkills = {
    ...
  }
  local self = table.remove(actSkills, 1)
  self.children = actSkills or self.children
  return self
end

function monsterActionSkill.isReady(act)
  local skill = act.skill
  if not skill or not skill:isReady() then
    return false
  end
  local monster = act.monster
  if get_npc_time(monster.npc) < act.timer then
    return false
  end
  local distance = get_npc_distance(monster.npc, 1, monster.target, true)
  distance = math.max(distance, 0)
  if act.minDis > 0 and distance < act.minDis then
    return false
  end
  if act.maxDis < math.huge and distance > act.maxDis then
    return false
  end
  local startAngle, endAngle = act.startAngle, act.endAngle
  if endAngle - startAngle < 360 then
    local tarAngle = get_target_angel(monster.npc, monster.target, true)
    local tarStartAngle = (startAngle - tarAngle) % 360
    local tarEndAngle = (endAngle - tarAngle) % 360
    if tarStartAngle < tarEndAngle then
      return false
    end
  end
  return true
end

function monsterActionSkill.startFrame(act)
  return act.v_start_frame
end

function monsterActionSkill.moveScale(act)
  return act.v_move_scale_z
end

function monsterActionSkill.start(act)
  act.isHit = false
  act.isCastOver = false
  act.skillCount = 0
  act.skill:start(act)
end

function monsterActionSkill.tick(act)
  if not act.curSk then
    return
  end
  act.curSk:tick()
end

function monsterActionSkill.onCastTime(act)
  if not act.isCastOver then
    act.isCastOver = true
    local derive = act:chooseChild()
    local monster = act.monster
    if derive then
      set_skill_end_to_idle(monster.npc, false)
      monster.tree:derive(derive)
    end
  end
end

function monsterActionSkill.tickTrans()
end

function monsterActionSkill.onEnd(act)
  local monster = act.monster
  if monster.state ~= act then
    return monster:debugOutput("monsterActionSkill.onEnd is called out of act, act is " .. tostring(act.name) .. ", skill is " .. tostring(act.curSk and act.curSk.name) .. ", cur states are " .. monster.tree:curStatesStr())
  end
  local derive = act:chooseChild()
  if not act.isCastOver and derive then
    set_skill_end_to_idle(monster.npc, false)
    monster.tree:derive(derive)
  else
    set_skill_end_to_idle(monster.npc, true)
    monster.tree:finTrans()
  end
end

function monsterActionSkill.derive(act, tarAct)
  tarAct = tarAct or act:chooseChild()
  if not tarAct then
    return
  end
  act.tree:derive(tarAct)
end

function monsterActionSkill.finish(act)
  act.timer = get_npc_time(act.monster.npc) + act.cd
  local attack = act.attack
  attack.intervalOffset = attack.intervalOffset + act.intervalOffset
end

function monsterActionSkill.finTrans()
end

function monsterActionSkill.chooseChild(act)
  local children = act.children
  if not _G.next(children) then
    return nil
  end
  for _, child in ipairs(children) do
    if child:isReady() then
      return child
    end
  end
  return nil
end

function monsterActionSkill.isInTree(act)
  local node = act
  local monster = act.monster
  local i = 1
  while true do
    if not node.parent then
      if node.name == "root" then
        return true
      else
        return false
      end
    end
    node = node.parent
    i = i + 1
    if i >= 100 then
      Util.debug_output("loop overflows", monster.npc.id, monster.npc.uuid, act.name)
      return false
    end
  end
end

function monsterActionSkill.isRunning(act)
  local tree = act.monster.tree
  local states = tree.states
  for _, _state in ipairs(states) do
    if _state == act then
      return true
    end
  end
  return false
end

function monsterActionSkill.chooseChildAction(act)
  return act.tree:chooseChildAction(act)
end

return monsterActionSkill
