local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BECopyCard, Super = System.NewClass("BECopyCard", BattleEffectServer)

function BECopyCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BECopyCard:Dispose()
  Super.Dispose(self)
end

function BECopyCard:CopyState(originCard, newCards, copyType, onlyExistState)
  if not newCards or next(newCards) == nil then
    return
  end
  local originStateList = self.battleEngine.stateMgr:GetStateListByOwnerUid(originCard.uid)
  for _, orgState in ipairs(originStateList) do
    if orgState.isDeleted then
    else
      local sourceType = orgState.source[1] and orgState.source[1].sourceType
      if onlyExistState and "ExistState" ~= sourceType then
      else
        local state = self.battleEngine.stateMgr:GetState(newCards[1], orgState.stateId)
        if copyType == bc.CardCopyType.NoEnchant and "Enchant" == sourceType then
        elseif not state or state.data.layer < orgState.data.layer then
          local effectType = bc.BattleEffectType.BEAddState
          local params = {
            orgState.stateId,
            state and orgState.data.layer - state.data.layer or orgState.data.layer
          }
          for _, param in ipairs(orgState.stateParams) do
            table.insert(params, param)
          end
          local effectConfig = {
            effectType = effectType,
            targets = newCards,
            params = params,
            cmdServer = self.cmdServer,
            source = table.deepclone(orgState.source),
            noDirectCmd = true
          }
          self.battleEngine.effectMgr:CreateEffect(effectConfig)
        end
      end
    end
  end
end

function BECopyCard:DoEffect()
  Super.DoEffect(self)
  local deckExp, cardPos, copyType, num = table.unpack(self.params or {})
  local deckName = deckExp and deckExp.cardDeck
  if not deckName or not bc.CardDeck[deckName] then
    self.battleEngine:Warn("创建卡牌到不支持的牌堆 " .. (deckName or "nil"))
    return false
  end
  copyType = copyType or bc.CardCopyType.Normal
  local cards = {}
  for _, target in ipairs(self.targets) do
    local originCard = target
    if originCard:is(BattleCardServer) then
      local cardId = target.configData.ID
      local list = {}
      for _ = 1, num or 1 do
        local cardInfo = {
          tid = cardId,
          level = originCard.level
        }
        table.insert(list, cardInfo)
      end
      local runes = {}
      if copyType == bc.CardCopyType.Normal then
        runes = table.deepclone(originCard.data.runes)
      end
      local addConfig = {
        targetPos = cardPos,
        enternal = nil,
        show = nil,
        cardArgs = originCard.createCardArgs,
        runes = runes,
        castRoleUid = self.cmdServer.castRoleUid,
        camp = deckExp:GetCamp(),
        owner = originCard.specialOwner,
        performSkillId = originCard.data.performSkillId
      }
      local newCards = self.battleEngine.cardMgr:AddNewCard(list, deckName, addConfig)
      if copyType == bc.CardCopyType.CopyOrigin then
        self:CopyState(originCard, newCards, copyType, true)
      else
        self:CopyState(originCard, newCards, copyType, false)
      end
      for _, card in ipairs(newCards) do
        table.insert(cards, card)
      end
    end
  end
  self.targets = cards
  return true
end

return BECopyCard
