local BevConst = require("Logic/BevTree/BevConst")
local BevData = require("Logic/BevTree/BevData")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local BevActionPlayBestSkill = {}

function BevActionPlayBestSkill.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionPlayBestSkill"
  n.canUseSuperSkill = true
  n.canUseLink = true
  n.canUseAssistSkill = true
  n.canUseSkill2 = true
  n.canUseSkill1 = true
  n.returnFailIfFailToPlayDueToLock = false
  n.canUseSkill3_9 = true
  n.run = BevActionPlayBestSkill.run
  return n
end

function BevActionPlayBestSkill.new()
  return BevActionPlayBestSkill.ctor({})
end

function BevActionPlayBestSkill.run(node)
  info("BevTree", "BevActionPlayBestSkill running..")
  BevData.instance.cardsPlayed = {}
  BevData.instance.skillType = 0
  BevData.instance.superSkillType = 0
  BevData.instance.linkId = 0
  local currentTeam = BevData.instance.currentTeam
  local cardPlaySucceed = false
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, currentTeam)
  local energyVal = FH.getCurEnergy(teamInfo, fightData.dungeonType, fightData.sequenceActor)
  local teamMp = energyVal[1]
  local teamSp = energyVal[2]
  local cardsInfoOfActor = Combat.GetCardsInfoOfActor(teamInfo.cardsInHand)
  local hasLockedActors = false
  local validActors = Combat.getActiveActors(fightData, function(actor)
    if actor.lock then
      hasLockedActors = true
    end
    return not actor.lock
  end)
  if not cardPlaySucceed and node.canUseSuperSkill then
    local candidateCards = {}
    for _, validActor in pairs(validActors) do
      if not validActor.isAssist then
        local cards = cardsInfoOfActor[validActor.uniqueID]
        local sCards = cards.sCard
        if 0 < #sCards then
          local card = sCards[1]
          if 0 < card.useCount then
            local actorCombo = PB.get("ActorCombo", card.actorID, 0, 1)
            if actorCombo then
              if teamSp >= actorCombo.costSp then
                table.insert(candidateCards, card)
              end
            else
              error("BevTree", "cannot find ActorCombo entry by actorId: " .. card.actorID)
            end
          end
        end
      end
    end
    if 0 < #candidateCards then
      local playCard = candidateCards[FH.getTeamRandom(currentTeam, 1, #candidateCards)]
      table.insert(BevData.instance.cardsPlayed, playCard)
      BevData.instance.superSkillType = 1
      cardPlaySucceed = true
    end
  end
  if not cardPlaySucceed and node.canUseLink then
    local candidateCards = {}
    for _, validActor in pairs(validActors) do
      if not validActor.isAssist then
        local cards = cardsInfoOfActor[validActor.uniqueID]
        local linkCards = cards.linkCard
        if 0 < #linkCards then
          local card = linkCards[1]
          if 0 < card.useCount then
            local actorLink = PB.get("ActorLink", card.linkID)
            if actorLink then
              if Combat.IsTimeOpen(actorLink.openTime) then
                local real_mp, real_sp = Combat.GetSkillRealCost(validActor, 0, 0, card.linkID, actorLink.costMp, actorLink.costSp)
                if teamMp >= real_mp and teamSp >= real_sp then
                  table.insert(candidateCards, card)
                end
              end
            else
              error("BevTree", "cannot find ActorLink entry by linkId: " .. card.linkID)
            end
          end
        end
      end
    end
    if 0 < #candidateCards then
      local playCard = candidateCards[FH.getTeamRandom(currentTeam, 1, #candidateCards)]
      table.insert(BevData.instance.cardsPlayed, playCard)
      BevData.instance.linkId = playCard.linkID
      cardPlaySucceed = true
    end
  end
  if not cardPlaySucceed then
    local otherSkills = {
      BevConst.SkillType.Skill1,
      BevConst.SkillType.Skill2,
      BevConst.SkillType.Skill3,
      BevConst.SkillType.Skill4,
      BevConst.SkillType.Skill5,
      BevConst.SkillType.Skill6,
      BevConst.SkillType.Skill7,
      BevConst.SkillType.Skill8,
      BevConst.SkillType.Skill9,
      BevConst.SkillType.SkillAssist
    }
    local candidateCards = {}
    for i, v in ipairs(otherSkills) do
      local playCommonSkillSwitchOn = true
      local playAssistSkillSwitchOn = node.canUseAssistSkill
      if otherSkills[i] == BevConst.SkillType.Skill1 then
        playCommonSkillSwitchOn = node.canUseSkill1
      elseif otherSkills[i] == BevConst.SkillType.Skill2 then
        playCommonSkillSwitchOn = node.canUseSkill2
      elseif otherSkills[i] == BevConst.SkillType.SkillAssist then
        playCommonSkillSwitchOn = node.canUseAssistSkill
      else
        playCommonSkillSwitchOn = node.canUseSkill3_9
      end
      if playCommonSkillSwitchOn or playAssistSkillSwitchOn then
        for _, validActor in pairs(validActors) do
          if not (not playCommonSkillSwitchOn or validActor.isAssist) or playAssistSkillSwitchOn and validActor.isAssist then
            local cards = cardsInfoOfActor[validActor.uniqueID]
            local commonCards = cards.commonCard
            if 0 < #commonCards then
              local card = commonCards[1]
              local skillType = fif(validActor.isAssist, 1, i)
              local actorCombo = PB.get("ActorCombo", card.actorID, skillType, 0)
              if actorCombo then
                local real_mp, read_sp = Combat.GetSkillRealCost(validActor, skillType, 0, 0, actorCombo.costMp, actorCombo.costSp)
                if teamMp >= real_mp and teamSp >= read_sp then
                  table.insert(candidateCards, {card, skillType})
                end
              end
            end
          end
        end
      end
    end
    if 0 < #candidateCards then
      local playCardInfo = candidateCards[FH.getTeamRandom(currentTeam, 1, #candidateCards)]
      table.insert(BevData.instance.cardsPlayed, playCardInfo[1])
      BevData.instance.skillType = playCardInfo[2]
      cardPlaySucceed = true
    end
  end
  if cardPlaySucceed then
    return BevConst.RunState.Finished
  elseif hasLockedActors then
    info("BevTree", "BevActionPlayBestSkill failed to cast any skill due to the actors are locked!")
    if node.returnFailIfFailToPlayDueToLock then
      return BevConst.RunState.Failed
    else
      return BevConst.RunState.Finished
    end
  else
    warning("BevTree", "BevActionPlayBestSkill failed to cast any skill!")
    return BevConst.RunState.Failed
  end
end

return BevActionPlayBestSkill
