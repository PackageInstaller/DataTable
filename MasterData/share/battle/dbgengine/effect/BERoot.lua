local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BERoot, Super = System.NewClass("BERoot", BattleEffectServer)

function BERoot:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERoot:Dispose()
  Super.Dispose(self)
end

function BERoot:DoEffect()
  Super.DoEffect(self)
  return true
end

return BERoot
