local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BECopyWorldFinish, Super = System.NewClass("BECopyWorldFinish", BattleEffectServer)

function BECopyWorldFinish:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BECopyWorldFinish:Dispose()
  Super.Dispose(self)
end

function BECopyWorldFinish:DoEffect()
  Super.DoEffect(self)
  self.battleEngine:ActiveBattleEnd(bc.BattleCamp.Camp1, true, false, false)
  self.battleEngine:WorldRpc("Battle", "OnCopyWorldFinish")
  return true
end

return BECopyWorldFinish
