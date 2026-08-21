local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local FH = require("Logic/HelpLogic")
local BevActionPlayPerformance = {}

function BevActionPlayPerformance.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionPlayPerformance"
  n.actionName = ""
  n.textDisplayDelayTime = 0
  n.textContent = ""
  n.textStyle = 0
  n.performanceDuration = 0
  n.newIdlePose = ""
  n.actionTiming = 0
  n.run = BevActionPlayPerformance.run
  return n
end

function BevActionPlayPerformance.new()
  return BevActionPlayPerformance.ctor({})
end

function BevActionPlayPerformance.run(node)
  info("BevTree", "BevActionSetBackgroundEffect running..")
  local performanceInfo = {}
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
  local teamId = node.getTeamId(fightData, node.targetTeam)
  local target
  if node.target >= BevConst.AiConditionTarget.Position1 and node.target <= BevConst.AiConditionTarget.Position3 then
    target = Combat.getActorInfo(fightData, teamId, node.target)
  elseif node.target >= BevConst.AiConditionTarget.Self then
    target = FH.getActorByUid(teamInfo, fightData.sequenceActor)
  else
    error("BevTree", "invalid target type for BevActionPlayPerformance")
    return BevConst.RunState.Finished
  end
  if target then
    performanceInfo.target = {
      team = target.team,
      seat = target.seat
    }
    performanceInfo.actionName = node.actionName
    performanceInfo.textDisplayDelayTime = node.textDisplayDelayTime
    performanceInfo.textContent = node.textContent
    performanceInfo.textStyle = node.textStyle
    performanceInfo.performanceDuration = node.performanceDuration
    performanceInfo.newIdlePose = node.newIdlePose
    performanceInfo.actionTiming = node.actionTiming
    BevData.instance.performanceInfoList[#BevData.instance.performanceInfoList + 1] = performanceInfo
    return BevConst.RunState.Finished
  else
    error("BevTree", "BevActionPlayPerformance get nil target")
    return BevConst.RunState.Finished
  end
end

return BevActionPlayPerformance
