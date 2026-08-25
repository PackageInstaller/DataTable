local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeTentacleDamage, Super = System.NewClass("BEChangeTentacleDamage", BattleEffectServer)

function BEChangeTentacleDamage:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeTentacleDamage:Dispose()
  Super.Dispose(self)
end

local ChangeType2PropertyName = {
  [1] = bc.BattleProperty.bout_tentacle_dmg,
  [2] = bc.BattleProperty.battle_tentacle_dmg,
  [3] = bc.BattleProperty.tentacle_dmg
}
local SubOrder = {
  bc.BattleProperty.bout_tentacle_dmg,
  bc.BattleProperty.battle_tentacle_dmg,
  bc.BattleProperty.tentacle_dmg
}

function BEChangeTentacleDamage:DoEffect()
  Super.DoEffect(self)
  local value = self.params[1] or 0
  local changeType = self.params[2] or 1
  local propertyName = ChangeType2PropertyName[changeType]
  local player = self.targets[1]
  if not player then
    return false
  end
  if 0 == value then
    return true
  end
  value = math.ceil(value)
  local reason = bc.PropertyChangeReason.AttrModify
  local propertyChangeSource = self:GetPropertyChangeSource(reason)
  
  local function SubTentacleDmg(p, totalSubNum)
    local num = player:GetProperty(p)
    if 0 == num then
      return totalSubNum
    end
    if totalSubNum <= num then
      player:SubProperty(p, totalSubNum, propertyChangeSource)
      return 0
    else
      player:SubProperty(p, num, propertyChangeSource)
      return totalSubNum - num
    end
  end
  
  if value > 0 then
    player:ChangeProperty(propertyName, value, propertyChangeSource)
  else
    local curTotalNum = player:GetProperty(bc.BattleProperty.tentacle_dmg)
    if curTotalNum <= 1 then
      return true
    end
    local subNum = math.abs(value)
    for _, p in ipairs(SubOrder) do
      subNum = SubTentacleDmg(p, subNum)
      if subNum <= 0 then
        break
      end
    end
  end
  return true
end

return BEChangeTentacleDamage
