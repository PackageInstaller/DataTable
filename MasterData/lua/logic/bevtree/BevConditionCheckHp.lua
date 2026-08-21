local BevConst = require("Logic/BevTree/BevConst")
local Combat = require("Logic/Combat")
local BevNode = require("Logic/BevTree/BevNode")
local BevConditionCheckHp = {}
local PB = require("Common/PbHelper")

function BevConditionCheckHp.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckHp"
  n.targetTeam = BevConst.AiTeamType.SelfTeam
  n.target = BevConst.AiConditionTarget.AllActors
  n.compareOperation = BevConst.CompareOperation.Equal
  n.valueType = BevConst.ValueType.Value
  n.expression = ""
  n.run = BevConditionCheckHp.run
  return n
end

function BevConditionCheckHp.new()
  return BevConditionCheckHp.ctor({})
end

function BevConditionCheckHp.run(node)
  local HpType = PB.enum.AttrType.Hp
  local fightData = BevData.instance.fightActiveData
  local teamId = node.getTeamId(fightData, node.targetTeam)
  local lhsHp = 0
  local lhsMax = 0
  if node.target == BevConst.AiConditionTarget.AllActors then
    local hpTotal = 0
    local maxTotal = 0
    for i = BevConst.AiConditionTarget.Position1, BevConst.AiConditionTarget.Position3 do
      hpTotal = hpTotal + Combat.getActorDynamicAttr(fightData, teamId, i, HpType)
      maxTotal = maxTotal + Combat.getActorStaticAttr(fightData, teamId, i, HpType)
    end
    lhsHp = hpTotal
    lhsMax = maxTotal
  else
    lhsHp = Combat.getActorDynamicAttr(fightData, teamId, node.target, HpType)
    lhsMax = Combat.getActorStaticAttr(fightData, teamId, node.target, HpType)
  end
  local result = false
  local value = node.eval(node.expression)
  if node.valueType == BevConst.ValueType.Ratio then
    local lhsRatio = 0
    if 0 < lhsMax then
      lhsRatio = lhsHp / lhsMax
    end
    local rhsRatio = value / 10000
    result = node.compareValue(node.compareOperation, lhsRatio, rhsRatio)
  elseif node.valueType == BevConst.ValueType.Value then
    local lhsValue = lhsHp
    result = node.compareValue(node.compareOperation, lhsValue, value)
  end
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckHp
