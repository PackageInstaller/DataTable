local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEBattleBegin, Super = System.NewClass("BEBattleBegin", BattleEffectServer)

function BEBattleBegin:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEBattleBegin:Dispose()
  Super.Dispose(self)
end

function BEBattleBegin:DoEffect()
  Super.DoEffect(self)
  local battleEngine = self.battleEngine
  battleEngine:LogBattle("======================= 战斗开始后 =======================")
  battleEngine.eventMgr:SendEvent(BattleLogicEvent.BFBattleBegin)
  battleEngine.gameplay:BattleBegin()
  return true
end

return BEBattleBegin
