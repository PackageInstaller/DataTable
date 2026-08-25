local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEChangeBg, Super = System.NewClass("BEChangeBg", BattleEffectServer)

function BEChangeBg:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeBg:Dispose()
  Super.Dispose(self)
end

function BEChangeBg:DoEffect()
  Super.DoEffect(self)
  local changeId = self.params[1]
  self.battleEngine.recordMgr:OnChangeBg(changeId)
  return true
end

return BEChangeBg
