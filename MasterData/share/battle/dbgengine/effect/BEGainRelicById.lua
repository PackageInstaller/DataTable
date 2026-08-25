local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEGainRelicById, Super = System.NewClass("BEGainRelicById", BattleEffectServer)

function BEGainRelicById:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEGainRelicById:DoEffect()
  Super.DoEffect(self)
  local tid = self.params[1]
  self.battleEngine:InfoS("BEGainRelicById {tid}", tid)
  if not tid then
    self.battleEngine:InfoS("BEGainRelicById not {tid}", tid)
    return
  end
  local relic = self.battleEngine.relicMgr:AddRelic(self.cmdServer, tid)
  if not relic then
    self.battleEngine:InfoS("BEGainRelicById {tid} not relic", tid)
    return
  end
  return true
end

return BEGainRelicById
