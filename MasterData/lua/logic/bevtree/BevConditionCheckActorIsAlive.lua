local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local PB = require("Common/PbHelper")
local BevConditionCheckActorIsAlive = {}

function BevConditionCheckActorIsAlive.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckActorIsAlive"
  n.team = BevConst.AiTeamType.SelfTeam
  n.target = BevConst.AiConditionTarget.Position1
  n.alive = true
  n.run = BevConditionCheckActorIsAlive.run
  return n
end

function BevConditionCheckActorIsAlive.new()
  return BevConditionCheckActorIsAlive.ctor({})
end

local curHp = 0

function BevConditionCheckActorIsAlive.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamId = node.getTeamId(fightData, node.team)
  if node.target ~= BevConst.AiConditionTarget.AllActors then
    curHp = Combat.getActorDynamicAttr(fightData, teamId, node.target, PB.enum.AttrType.Hp)
  else
    for i = BevConst.AiConditionTarget.Position1, BevConst.AiConditionTarget.Position3 do
      local actorHp = Combat.getActorDynamicAttr(fightData, teamId, i, PB.enum.AttrType.Hp)
      if actorHp <= 0 then
        curHp = actorHp
        break
      end
    end
  end
  local result = 0 < curHp
  if not node.alive then
    result = not result
  end
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckActorIsAlive
