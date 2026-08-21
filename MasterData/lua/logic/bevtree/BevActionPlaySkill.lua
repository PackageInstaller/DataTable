local BevConst = require("Logic/BevTree/BevConst")
local BevData = require("Logic/BevTree/BevData")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local BevActionPlaySkill = {}

function BevActionPlaySkill.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionPlaySkill"
  n.skillType = 0
  n.returnFailIfFailToPlayDueToLock = false
  n.run = BevActionPlaySkill.run
  return n
end

function BevActionPlaySkill.new()
  return BevActionPlaySkill.ctor({})
end

function BevActionPlaySkill.run(node)
  info("BevTree", "BevActionPlaySkill running..")
  BevData.instance.cardsPlayed = {}
  BevData.instance.skillType = 0
  BevData.instance.superSkillType = 0
  BevData.instance.linkId = 0
  local cardPlaySucceed = false
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
  local cardsInfoOfActor = Combat.GetCardsInfoOfActor(teamInfo.allCardList)
  local hasLockedActors = false
  local validActors = Combat.getActiveActors(fightData, function(actor)
    if actor.lock then
      hasLockedActors = true
    end
    return not actor.lock
  end)
  local candidateCards = {}
  for _, validActor in pairs(validActors) do
    if not cardPlaySucceed then
      local cards = cardsInfoOfActor[validActor.uniqueID]
      if not validActor.isAssist then
        local cards = cards.commonCard
        if 0 < #cards then
          local commonSkills = {
            BevConst.SkillType.Skill1,
            BevConst.SkillType.Skill2,
            BevConst.SkillType.Skill3,
            BevConst.SkillType.Skill4,
            BevConst.SkillType.Skill5,
            BevConst.SkillType.Skill6,
            BevConst.SkillType.Skill7,
            BevConst.SkillType.Skill8,
            BevConst.SkillType.Skill9
          }
          for i, v in ipairs(commonSkills) do
            if node.skillType == commonSkills[i] then
              local card = cards[1]
              table.insert(BevData.instance.cardsPlayed, card)
              BevData.instance.skillType = i
              cardPlaySucceed = true
              break
            end
          end
        end
      end
      if node.skillType == BevConst.SkillType.SkillSuper then
        if not validActor.isAssist then
          local cards = cards.sCard
          if 0 < #cards then
            local card = cards[1]
            table.insert(BevData.instance.cardsPlayed, card)
            BevData.instance.superSkillType = 1
            cardPlaySucceed = true
          end
        end
      elseif node.skillType == BevConst.SkillType.SkillAssist then
        if validActor.isAssist then
          local cards = cards.commonCard
          if 0 < #cards then
            local card = cards[1]
            table.insert(BevData.instance.cardsPlayed, card)
            BevData.instance.skillType = 1
            cardPlaySucceed = true
          end
        end
      elseif node.skillType == BevConst.SkillType.SkillLink and not validActor.isAssist then
        local cards = cards.linkCard
        if 0 < #cards then
          local card = cards[1]
          table.insert(BevData.instance.cardsPlayed, card)
          BevData.instance.linkId = card.linkID
          cardPlaySucceed = true
        end
      end
    end
  end
  if cardPlaySucceed then
    return BevConst.RunState.Finished
  elseif hasLockedActors then
    info("BevTree", "BevActionPlaySkill failed to cast any skill due to the actors are locked!")
    if node.returnFailIfFailToPlayDueToLock then
      return BevConst.RunState.Failed
    else
      return BevConst.RunState.Finished
    end
  else
    warning("BevTree", "BevActionPlaySkill failed to cast any skill!")
    return BevConst.RunState.Failed
  end
end

return BevActionPlaySkill
