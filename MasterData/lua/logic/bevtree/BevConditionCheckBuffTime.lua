local BevConst = require("Logic/BevTree/BevConst")
local Combat = require("Logic/Combat")
local BevNode = require("Logic/BevTree/BevNode")
local BevConditionCheckBuffTime = {}
local PB = require("Common/PbHelper")

function BevConditionCheckBuffTime.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckBuffTime"
  n.targetTeam = BevConst.AiTeamType.SelfTeam
  n.target = BevConst.AiConditionTarget.AllActors
  n.buffIdExp = ""
  n.compareOperation = BevConst.CompareOperation.Equal
  n.remainRoundExp = ""
  n.run = BevConditionCheckBuffTime.run
  return n
end

function BevConditionCheckBuffTime.new()
  return BevConditionCheckBuffTime.ctor({})
end

function BevConditionCheckBuffTime.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamId = node.getTeamId(fightData, node.targetTeam)
  local buffList = Combat.getActorBuffList(fightData, teamId, node.target)
  if buffList == nil then
    return BevConst.RunState.Failed
  end
  local buffId = node.eval(node.buffIdExp)
  local foundBuff
  for i = 1, #buffList do
    local buff = buffList[i]
    if buff.state ~= PB.enum.BuffFightState.Delete then
      local buffData = PB.get("BuffData", buff.buffKey.id, buff.buffKey.owner)
      if buffData.id == buffId then
        foundBuff = buff
        break
      end
    end
  end
  if foundBuff == nil then
    return BevConst.RunState.Failed
  end
  local remainRound = node.eval(node.remainRoundExp)
  local result = node.compareValue(node.compareOperation, foundBuff.round, remainRound)
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckBuffTime
