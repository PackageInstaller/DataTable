local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEChangeDrawNum, Super = System.NewClass("BEChangeDrawNum", BattleEffectServer)

function BEChangeDrawNum:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeDrawNum:Dispose()
  Super.Dispose(self)
end

function BEChangeDrawNum:DoEffect()
  Super.DoEffect(self)
  local changeValue = self.params[1]
  local cardMgr = self.battleEngine.cardMgr
  cardMgr:ChangeDrawCardNum(changeValue)
  return true
end

return BEChangeDrawNum
