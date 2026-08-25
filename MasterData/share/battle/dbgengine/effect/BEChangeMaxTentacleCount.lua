local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeMaxTentacleCount, Super = System.NewClass("BEChangeMaxTentacleCount", BattleEffectServer)

function BEChangeMaxTentacleCount:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

local BP = bc.BattleProperty
local ChangeType2PropertyName = {
  [1] = BP.bout_max_tentacle_count,
  [2] = BP.battle_max_tentacle_count,
  [3] = BP.permanent_max_tentacle_count
}
local SubOrder = {
  BP.bout_max_tentacle_count,
  BP.battle_max_tentacle_count,
  BP.permanent_max_tentacle_count
}

function BEChangeMaxTentacleCount:Dispose()
  Super.Dispose(self)
end

function BEChangeMaxTentacleCount:SubMaxTentacle(p, totalSubNum, extraData)
  local player = self.targets[1]
  local num = player:GetProperty(p)
  if 0 == num then
    return totalSubNum
  end
  if totalSubNum <= num then
    player:SubProperty(p, totalSubNum, extraData)
    return 0
  else
    player:SubProperty(p, num, extraData)
    return totalSubNum - num
  end
end

function BEChangeMaxTentacleCount:DoEffect()
  Super.DoEffect(self)
  local value = math.ceil(self.params[1] or 0)
  local changeType = self.params[2] or 1
  local player = self.targets[1]
  if not player then
    return false
  end
  if 0 == value then
    return true
  end
  value = math.ceil(value)
  local reason = bc.PropertyChangeReason.AttrModify
  local extraData = self:GetPropertyChangeSource(reason)
  if value > 0 then
    local propertyName = ChangeType2PropertyName[changeType]
    player:ChangeProperty(propertyName, value, extraData)
    local curNum = player:GetProperty(BP.max_tentacle_count)
    local maxNum = self.battleEngine.battleDT.GetConstant("MaxTentacle") or 16
    if curNum > maxNum then
      local subTentacleNum = curNum - maxNum
      for _, p in ipairs(SubOrder) do
        subTentacleNum = self:SubMaxTentacle(p, subTentacleNum, extraData)
        if subTentacleNum <= 0 then
          break
        end
      end
    end
    return true
  else
    local curTotalNum = player:GetProperty(BP.max_tentacle_count)
    if curTotalNum <= 1 then
      return true
    end
    local subNum = math.abs(value)
    for _, p in ipairs(SubOrder) do
      subNum = self:SubMaxTentacle(p, subNum, extraData)
      if subNum <= 0 then
        break
      end
    end
    local maxTentacleCount = player:GetProperty(BP.max_tentacle_count)
    local tentacleCount = player:GetProperty(BP.tentacle_count)
    if maxTentacleCount < tentacleCount then
      local subTentacleNum = tentacleCount - maxTentacleCount
      player:SubTentacle(subTentacleNum, extraData)
    end
  end
  return true
end

return BEChangeMaxTentacleCount
