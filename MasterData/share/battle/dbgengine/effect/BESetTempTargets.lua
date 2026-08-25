local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BESetTempTargets, Super = System.NewClass("BESetTempTargets", BattleEffectServer)

function BESetTempTargets:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESetTempTargets:Dispose()
  Super.Dispose(self)
end

function BESetTempTargets:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local argIndex = self.params[1]
  if not argIndex or type(argIndex) ~= "number" then
    return false
  end
  argIndex = math.ceil(argIndex)
  local argKey = "TempTarget" .. argIndex
  self.cmdServer:SetMemberValue(argKey, targets)
  return true
end

return BESetTempTargets
