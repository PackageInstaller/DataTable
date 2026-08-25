local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeTentacleCount, Super = System.NewClass("BEChangeTentacleCount", BattleEffectServer)

function BEChangeTentacleCount:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeTentacleCount:Dispose()
  Super.Dispose(self)
end

function BEChangeTentacleCount:DoEffect()
  Super.DoEffect(self)
  local value = math.ceil(self.params[1] or 0)
  local changeType = self.params[2] or bc.TentacleChangeType.Bout
  local player = self.targets[1]
  if not player then
    return false
  end
  value = math.ceil(value)
  local extraData = {
    castRoleUid = self.effectConfig.castRoleUid,
    reason = bc.PropertyChangeReason.AttrModify
  }
  if value > 0 then
    local propertyName = bc.ChangeType2PropertyName[changeType]
    player:ChangeProperty(propertyName, value, extraData)
    local maxTentacleCount = player:GetProperty(bc.BattleProperty.max_tentacle_count)
    local tentacleCount = player:GetProperty(bc.BattleProperty.tentacle_count)
    if maxTentacleCount < tentacleCount then
      local subNum = tentacleCount - maxTentacleCount
      extraData.SubOrder = {
        bc.TentacleChangeType.Battle,
        bc.TentacleChangeType.Copy
      }
      local subTypeList = player:SubTentacle(subNum, extraData)
      extraData.SubOrder = nil
      local eventData = {
        castRoleUid = self.effectConfig.castRoleUid
      }
      for _, subType in ipairs(subTypeList) do
        eventData.changeType = subType
        self.battleEngine:CreateEventEffect(BattleLogicEvent.TentacleIsFull, eventData)
      end
    end
    return true
  else
    local curTotalNum = player:GetProperty(bc.BattleProperty.tentacle_count)
    if curTotalNum <= 1 then
      return true
    end
    extraData.SubOrder = {
      bc.TentacleChangeType.Battle,
      bc.TentacleChangeType.Copy
    }
    local subNum = math.abs(value)
    player:SubTentacle(subNum, extraData)
  end
  return true
end

return BEChangeTentacleCount
