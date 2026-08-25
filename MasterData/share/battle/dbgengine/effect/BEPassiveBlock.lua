local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEPassiveBlock, Super = System.NewClass("BEPassiveBlock", BattleEffectServer)

function BEPassiveBlock:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEPassiveBlock:Dispose()
  Super.Dispose(self)
end

function BEPassiveBlock:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  if not targets then
    return false
  end
  self.totalEffectTimes = math.ceil(self.params[2] or 1)
  self.totalEffectTimes = math.max(1, self.totalEffectTimes)
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self, self.totalEffectTimes
end

function BEPassiveBlock:__DoMultiEffect()
  local targets = self.targets
  local baseBlock = self.params[1]
  baseBlock = self:CalFinalVal(baseBlock)
  local ignoreMax = 0 ~= (self.params[3] or 0)
  local reason = bc.PropertyChangeReason.BlockGain
  for _, target in ipairs(targets) do
    if target:IsDead() then
    else
      local extraData = self:GetPropertyChangeSource(reason, baseBlock)
      extraData.ignoreMax = ignoreMax
      target:GainBlock(baseBlock, baseBlock, extraData)
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEPassiveBlock
