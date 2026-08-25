local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeCardOwner, Super = System.NewClass("BEChangeCardOwner", BattleEffectServer)

function BEChangeCardOwner:DoEffect()
  Super.DoEffect(self)
  if next(self.targets) == nil then
    return false
  end
  local ownerExp = self.params[1]
  if not ownerExp then
    return false
  end
  local targetList = ownerExp:GetTargetList()
  local owner = targetList[1]
  if not owner then
    return false
  end
  for _, changeCard in ipairs(self.targets) do
    local effectType = bc.BattleEffectType.BEFunctionEffect
    local effectConfig = {
      effectType = effectType,
      func = self.ChangeCardOwner,
      funcTarget = self,
      funcArgs = {changeCard, owner},
      targets = self.targets
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end
  return true
end

function BEChangeCardOwner:ChangeCardOwner(changeCard, owner)
  local stateMgr = self.battleEngine.stateMgr
  changeCard.specialOwner = owner
  local state_list = stateMgr:GetStateListByOwnerUid(changeCard.uid)
  for _, state in ipairs(state_list) do
    if not state.isDeleted and state.source[1] and state.source[1].sourceType == "ExistState" then
      state:SubLayer(state.source[1].layer)
    end
  end
  changeCard:InitByConfigId(changeCard.tid, false)
  local stateList = {}
  local new_list = stateMgr:GetStateListByOwnerUid(changeCard.uid)
  for _, state in ipairs(new_list) do
    if not state.isDeleted then
      state:UpdateStateArgs()
    end
    table.insert(stateList, state:Serialize())
  end
  local data = {
    cardUid = changeCard.uid,
    configId = changeCard.data.tid,
    tid = changeCard.data.tid,
    cost = changeCard:GetCurCost(),
    deck = changeCard.deck,
    level = changeCard.level,
    properties = changeCard.property:Serialize(),
    stateList = stateList,
    cardArgs = changeCard.cardArgs,
    runes = changeCard.data.runes,
    descArgs = changeCard.descArgs,
    ownerUid = changeCard.owner.uid,
    isPlayEffect = false
  }
  self.battleEngine.recordMgr:OnChangeCard(data)
end

return BEChangeCardOwner
