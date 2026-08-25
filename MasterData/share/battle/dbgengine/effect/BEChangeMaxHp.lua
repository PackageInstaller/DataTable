local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeMaxHp, Super = System.NewClass("BEChangeMaxHp", BattleEffectServer)

function BEChangeMaxHp:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeMaxHp:Dispose()
  Super.Dispose(self)
end

function BEChangeMaxHp:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local value = math.ceil(self.params[1] or 0)
  local reason = bc.PropertyChangeReason.AttrModify
  local propertyName = bc.BattleProperty.max_hp
  local extraData = self:GetPropertyChangeSource(reason)
  extraData.skipHp = 2 == self.params[2] and true or false
  extraData.skipText = 2 == self.params[3] and true or false
  for _, target in ipairs(targets) do
    target.property:ChangeProperty(propertyName, value, extraData)
  end
  return true
end

return BEChangeMaxHp
