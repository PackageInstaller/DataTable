local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BERemoveRelic, Super = System.NewClass("BERemoveRelic", BattleEffectServer)

function BERemoveRelic:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERemoveRelic:Dispose()
  Super.Dispose(self)
end

function BERemoveRelic:DoEffect()
  Super.DoEffect(self)
  local tid = self.params[1]
  self.battleEngine.relicMgr:RemoveRelic(tid)
  return true
end

return BERemoveRelic
