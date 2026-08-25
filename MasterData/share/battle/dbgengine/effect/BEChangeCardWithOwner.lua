local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeCardWithOwner, Super = System.NewClass("BEChangeCardWithOwner", BattleEffectServer)

function BEChangeCardWithOwner:DoEffect()
  Super.DoEffect(self)
  if next(self.targets) == nil then
    return false
  end
  local cardListExp, ownerExp, changeType, playEffect, runeKeepType, revertType = table.unpack(self.params or {})
  local targetCard = cardListExp.cardList[1]
  if not targetCard then
    return false
  end
  local targetList = ownerExp:GetTargetList()
  local owner = targetList[1]
  if not owner then
    return false
  end
  local changeArgs = {
    changeType = changeType,
    isPlayEffect = nil == playEffect or 1 == playEffect,
    runeKeepType = runeKeepType or bc.RuneKeepType.None,
    revertType = revertType or bc.RevertType.SavedOrigin,
    specialOwner = owner,
    performSkillId = 0
  }
  for _, changeCard in ipairs(self.targets) do
    if targetCard.uid == changeCard.uid then
    elseif changeCard:GetProperty(bc.BattleProperty.Forcedretention) > 0 then
    else
      local eventData = {
        cardUid = changeCard.uid
      }
      self.battleEngine:CreateEventEffect(BattleLogicEvent.CardChangeByCmdBefore, table.clone(eventData))
      local effectType = bc.BattleEffectType.BEFunctionEffect
      local effectConfig = {
        effectType = effectType,
        func = self.ChangeCard,
        funcTarget = self,
        funcArgs = {
          changeCard,
          targetCard,
          changeArgs
        },
        targets = self.targets
      }
      self.battleEngine.effectMgr:CreateEffect(effectConfig)
    end
  end
  return true
end

function BEChangeCardWithOwner:ChangeCard(changeCard, targetCard, changeArgs)
  changeCard:ChangeConfigByCmd(targetCard, changeArgs)
end

return BEChangeCardWithOwner
