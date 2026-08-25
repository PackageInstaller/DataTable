local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeMoney, Super = System.NewClass("BEChangeMoney", BattleEffectServer)

function BEChangeMoney:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeMoney:Dispose()
  Super.Dispose(self)
end

function BEChangeMoney:DoEffect()
  Super.DoEffect(self)
  local value = self.params[1] or 0
  local floatText = #self.params > 1 and self.params[2] or 1
  self.battleEngine:ChangeMoney(value)
  local totalValue = self.battleEngine:GetCurMoney()
  self.battleEngine.recordMgr:OnMoneyChange(value, totalValue, floatText)
  self.battleEngine:CreateEventEffect(BattleLogicEvent.ChangeMoney, {value = value})
  return true
end

return BEChangeMoney
