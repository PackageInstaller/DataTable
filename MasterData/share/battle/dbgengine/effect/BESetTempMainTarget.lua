local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BESetTempMainTarget, Super = System.NewClass("BESetTempMainTarget", BattleEffectServer)

function BESetTempMainTarget:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESetTempMainTarget:Dispose()
  Super.Dispose(self)
end

function BESetTempMainTarget:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  if not targets or 0 == #targets then
    self.cmdServer:SetMemberValue("TempMainTarget", nil)
    return true
  end
  local mainTarget = targets[1]
  self.cmdServer:SetMemberValue("TempMainTarget", mainTarget)
  return true
end

return BESetTempMainTarget
