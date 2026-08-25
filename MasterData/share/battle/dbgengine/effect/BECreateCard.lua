local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BECreateCard, Super = System.NewClass("BECreateCard", BattleEffectServer)

function BECreateCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BECreateCard:Dispose()
  Super.Dispose(self)
end

function BECreateCard:DoEffect()
  Super.DoEffect(self)
  local cards = {}
  local deckExp, cardPos, num, enternal, isShow, cardArg1, cardArg2, cardArg3, cardArg4, cardArg5, cardArg6, cardArg7, cardArg8, cardArg9, cardArg10 = table.unpack(self.params or {})
  num = math.ceil(tonumber(num) or 1)
  local deckName = deckExp and deckExp.cardDeck
  if not deckName or not bc.CardDeck[deckName] then
    self.battleEngine:Warn("创建卡牌到不支持的牌堆 " .. (deckName or "nil"))
    return false
  end
  for _, target in ipairs(self.targets) do
    local cardId = target.configData.ID
    local cardArgs = {
      cardArg1,
      cardArg2,
      cardArg3,
      cardArg4,
      cardArg5,
      cardArg6,
      cardArg7,
      cardArg8,
      cardArg9,
      cardArg10
    }
    if not cardArg1 and not cardArg2 and not cardArg3 then
      cardArgs = target.createCardArgs
    end
    local show = not isShow or 1 == isShow
    local list = {}
    for _ = 1, num or 1 do
      local cardInfo = {
        tid = cardId,
        level = target.level
      }
      table.insert(list, cardInfo)
    end
    local addConfig = {
      targetPos = cardPos,
      enternal = enternal or bc.CardEnternalType.None,
      show = show,
      cardArgs = cardArgs,
      castRoleUid = self.cmdServer.castRoleUid,
      camp = deckExp:GetCamp(),
      owner = target.specialOwner,
      performSkillId = target.data.performSkillId,
      cardTypes = target.data.cardTypes
    }
    local newCards = self.battleEngine.cardMgr:AddNewCard(list, deckName, addConfig)
    for _, card in ipairs(newCards) do
      table.insert(cards, card)
    end
  end
  self.targets = cards
  return true
end

return BECreateCard
