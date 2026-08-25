local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BESetAttr, Super = System.NewClass("BESetAttr", BattleEffectServer)

function BESetAttr:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESetAttr:Dispose()
  Super.Dispose(self)
end

function BESetAttr:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local propertyType = self.fixArg
  local value = math.ceil(self.params[1])
  if not value then
    return false
  end
  local reason = bc.PropertyChangeReason.AttrSet
  local extraData = self:GetPropertyChangeSource(reason, value)
  for _, target in ipairs(targets) do
    target:SetProperty(propertyType, value, extraData)
    if target.CheckDeathEvent then
      target:CheckDeathEvent(self.cmdServer.castRoleUid, self.cmdServer.uid)
    end
  end
  return true
end

return BESetAttr
