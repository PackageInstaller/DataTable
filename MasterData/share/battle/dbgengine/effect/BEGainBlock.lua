local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEGainBlock, Super = System.NewClass("BEGainBlock", BattleEffectServer)

function BEGainBlock:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEGainBlock:GetLayerTypeByIndex(stateIndex)
  local layerTypeConfig = self.paramLayerTypeConfig
  if type(layerTypeConfig) == "table" then
    return layerTypeConfig[stateIndex]
  end
  return layerTypeConfig
end

function BEGainBlock:GetStateLayerBaseValue(layerType, actualBlockGained, realBlock)
  if 2 == layerType then
    return actualBlockGained
  end
  return realBlock
end

function BEGainBlock:DoEffect()
  Super.DoEffect(self)
  self.isAddState = self.fixArg == "State"
  self.totalEffectTimes = self.params[2] or 1
  self.leftEffectTimes = self.totalEffectTimes
  if self.isAddState then
    local stateId, layerRate, layerType = self.params[5], self.params[6], self.params[7]
    local paramStateTarget = self.params[8]
    if paramStateTarget and #paramStateTarget > 0 then
      self.paramStateTarget = paramStateTarget
    else
      self.paramStateTarget = {paramStateTarget}
    end
    if type(stateId) ~= "table" then
      stateId = {stateId}
    end
    if type(layerRate) ~= "table" then
      layerRate = {layerRate}
    end
    self.paramStateIdList = stateId
    self.paramLayerRate = layerRate
    self.paramLayerTypeConfig = layerType
  end
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self, self.params[7], self.params[8], {layerRate}, layerRate
end

function BEGainBlock:__DoMultiEffect()
  local targets = self.targets
  self:GenParams()
  local baseBlock = self.params[1]
  local paraPlusName = self.params[3]
  local ignoreMax = 0 ~= (self.params[4] or 0)
  local reason = bc.PropertyChangeReason.BlockGain
  for _, target in ipairs(targets) do
    if target:IsDead() then
    else
      local realBlock = self.cmdServer:GetRealBlock(baseBlock, target, paraPlusName)
      local preBlock = target:GetProperty(BP.block)
      local extraData = self:GetPropertyChangeSource(reason, realBlock)
      extraData.ignoreMax = ignoreMax
      target:GainBlock(realBlock, baseBlock, extraData)
      local actualBlockGained = target:GetProperty(BP.block) - preBlock
      if self.isAddState then
        for stateIndex, stateId in ipairs(self.paramStateIdList) do
          local stateTarget = {target}
          if stateIndex <= #self.paramStateTarget then
            local stateTargetList = self.paramStateTarget[stateIndex]:GetTargetList()
            if stateTargetList and 0 ~= #stateTargetList then
              stateTarget = stateTargetList
            end
          end
          local layerRate = self.paramLayerRate[stateIndex] or 1
          local layerType = self:GetLayerTypeByIndex(stateIndex)
          local layerBaseValue = self:GetStateLayerBaseValue(layerType, actualBlockGained, realBlock)
          local finalLayer = layerBaseValue * layerRate
          local effectType = bc.BattleEffectType.BEAddState
          local effectConfig = {
            effectType = effectType,
            targets = stateTarget,
            params = {stateId, finalLayer},
            cmdServer = self.cmdServer,
            castRoleUid = self.cmdServer.castRoleUid,
            noDirectCmd = true
          }
          self.battleEngine.effectMgr:CreateEffect(effectConfig)
        end
      end
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

function BEGainBlock:GetShowBlock()
  self:GenParams()
  local baseBlock = self.params[1]
  local showBlock = self.cmdServer:GetRealBlock(baseBlock, nil, self.params[3])
  return showBlock
end

return BEGainBlock
