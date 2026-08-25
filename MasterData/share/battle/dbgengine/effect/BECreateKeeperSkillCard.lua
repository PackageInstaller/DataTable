local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BECreateKeeperSkillCard, Super = System.NewClass("BECreateKeeperSkillCard", BattleEffectServer)

function BECreateKeeperSkillCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BECreateKeeperSkillCard:Dispose()
  Super.Dispose(self)
end

function BECreateKeeperSkillCard:DoEffect()
  Super.DoEffect(self)
  local cards = {}
  local deckExp, cardPos, num, isFreeRaw, countAfterRaw, banAfterUseKeeperSkill = table.unpack(self.params or {})
  num = math.ceil(tonumber(num) or 1)
  local isFree = 1 == (tonumber(isFreeRaw) or 0)
  local countAfter = tonumber(countAfterRaw) or 0
  banAfterUseKeeperSkill = banAfterUseKeeperSkill or 0
  local deckName = deckExp and deckExp.cardDeck
  if not deckName or not bc.CardDeck[deckName] then
    self.battleEngine:Warn("BECreateKeeperSkillCard 创建到不支持的牌堆 " .. (deckName or "nil"))
    return false
  end
  if 0 == #self.targets then
    self.battleEngine:DebugS("[BECreateKeeperSkillCard] no_targets")
    return false
  end
  local camp = deckExp:GetCamp()
  local castRoleUid = self.cmdServer.castRoleUid
  for _, target in ipairs(self.targets) do
    local keeperSkillId = (not target.GetID or not target:GetID()) and target.GetData and target:GetData("tid")
    if not keeperSkillId then
      self.battleEngine:WarnS("[BECreateKeeperSkillCard] invalid_keeper_target")
    else
      local list = {}
      for _ = 1, num do
        table.insert(list, {tid = keeperSkillId, level = 1})
      end
      local addConfig = {
        targetPos = cardPos,
        enternal = bc.CardEnternalType.None,
        show = true,
        castRoleUid = castRoleUid,
        camp = camp,
        handKeeperSkillParam = {
          handKeeperFree = isFree,
          handKeeperCountAfter = countAfter,
          randUnlockSourceId = target.data and target.data.randUnlockSourceId,
          isBlankMemory = target.data and target.data.isBlankMemory,
          banAfterUseKeeperSkill = banAfterUseKeeperSkill
        }
      }
      local newCards = self.battleEngine.cardMgr:AddNewCard(list, deckName, addConfig)
      for _, card in ipairs(newCards) do
        table.insert(cards, card)
        self.battleEngine:DebugS("[BECreateKeeperSkillCard] created {cardUid} {tid} {isFree} {countAfter} {deck}", card.uid, card.tid, isFree and 1 or 0, countAfter, deckName)
      end
    end
  end
  self.targets = cards
  return #cards > 0
end

return BECreateKeeperSkillCard
