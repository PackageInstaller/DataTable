local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local FH = require("Logic/HelpLogic")
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local BevConditionCheckSkill = {}

function BevConditionCheckSkill.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckSkill"
  n.skillType = 0
  n.isAttackOrSupport = true
  n.compareOperation = 0
  n.attackTargetsCountExp = ""
  n.run = BevConditionCheckSkill.run
  return n
end

function BevConditionCheckSkill.new()
  return BevConditionCheckSkill.ctor({})
end

function BevConditionCheckSkill.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
  local attackType = ""
  local attackTargetsCount = 0
  local attacker = FH.getActorByUid(teamInfo, fightData.sequenceActor)
  if attacker then
    if node.skillType == BevConst.SkillType.Skill1 then
      local actorCombo = PB.get("ActorCombo", attacker.actorInfo.id, 1, 0)
      if actorCombo then
        attackType = actorCombo.attackType
        attackTargetsCount = actorCombo.attackTargetsCount
      else
        error("BevTree", "Cannot getActorCombo info by actorId: " .. attacker.actorInfo.id)
      end
    elseif node.skillType == BevConst.SkillType.Skill2 then
      local actorCombo = PB.get("ActorCombo", attacker.actorInfo.id, 2, 0)
      if actorCombo then
        attackType = actorCombo.attackType
        attackTargetsCount = actorCombo.attackTargetsCount
      else
        error("BevTree", "Cannot getActorCombo info by actorId: " .. attacker.actorInfo.id)
      end
    elseif node.skillType == BevConst.SkillType.SkillSuper then
      local actorCombo = PB.get("ActorCombo", attacker.actorInfo.id, 0, 1)
      if actorCombo then
        attackType = actorCombo.attackType
        attackTargetsCount = actorCombo.attackTargetsCount
      else
        error("BevTree", "Cannot getActorCombo info by actorId: " .. attacker.actorInfo.id)
      end
    elseif node.skillType == BevConst.SkillType.SkillAssist then
      local attackerAssist
      for k, v in pairs(fightData.activeActorList) do
        if v ~= fightData.sequenceActor then
          attackerAssist = FH.getActorByUid(teamInfo, v)
          break
        end
      end
      if attackerAssist then
        local actorCombo = PB.get("ActorCombo", attackerAssist.actorInfo.id, 1, 0)
        if actorCombo then
          attackType = actorCombo.attackType
          attackTargetsCount = actorCombo.attackTargetsCount
        else
          error("BevTree", "Cannot getActorCombo info by actorId: " .. attackerAssist.actorInfo.id)
        end
      end
    elseif node.skillType == BevConst.SkillType.SkillLink then
      local cardsInfoOfActor = Combat.GetCardsInfoOfActor(teamInfo.cardsInHand)
      local cards = cardsInfoOfActor[attacker.uniqueID]
      local linkCards = cards.linkCard
      if 0 < #linkCards then
        local actorLink = PB.get("ActorLink", linkCards[1].linkID)
        if Combat.IsTimeOpen(actorLink.openTime) then
          if actorLink then
            attackType = actorLink.attackType
            attackTargetsCount = actorLink.attackTargetsCount
          else
            error("BevTree", "Cannot getActorLink info by actorId: " .. attacker.actorInfo.id)
          end
        end
      end
    end
  end
  local attackTypeMatched = false
  if attackType == nil or attackType == "" then
    error("BevTree", "attackType is nil")
  else
    local attackTypeStrs = U.SplitStr(attackType, ",")
    for i = 1, #attackTypeStrs do
      if tonumber(attackTypeStrs[i]) == 1 then
        if node.isAttackOrSupport then
          attackTypeMatched = true
        end
      elseif tonumber(attackTypeStrs[i]) == 2 and not node.isAttackOrSupport then
        attackTypeMatched = true
      end
    end
  end
  if attackTypeMatched then
    local value = node.eval(node.attackTargetsCountExp)
    local result = node.compareValue(node.compareOperation, attackTargetsCount, value)
    if result then
      return BevConst.RunState.Finished
    else
      return BevConst.RunState.Failed
    end
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckSkill
