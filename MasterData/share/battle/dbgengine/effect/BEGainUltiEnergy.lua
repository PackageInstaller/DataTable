local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEGainUltiEnergy, Super = System.NewClass("BEGainUltiEnergy", BattleEffectServer)

function BEGainUltiEnergy:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEGainUltiEnergy:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local baseUltiEnergy = math.ceil(self.params[1])
  local times = math.ceil(self.params[2] or 1)
  local showText = self.params[3] or 1
  showText = 1 == showText
  local reason = bc.PropertyChangeReason.AttrModify
  for _, target in ipairs(targets) do
    for _ = 1, times do
      local ultiEnergy = self.cmdServer:GetRealUltiEnergy(baseUltiEnergy, target)
      local extraData = self:GetPropertyChangeSource(reason, ultiEnergy)
      extraData.showText = showText
      target:GainUltiEnergy(ultiEnergy, extraData)
    end
  end
  return true
end

return BEGainUltiEnergy
