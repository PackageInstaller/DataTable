local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEPassiveUltiEnergy, Super = System.NewClass("BEPassiveUltiEnergy", BattleEffectServer)

function BEPassiveUltiEnergy:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEPassiveUltiEnergy:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local baseUltiEnergy = math.ceil(self.params[1])
  local times = math.ceil(self.params[2] or 1)
  local reason = bc.PropertyChangeReason.AttrModify
  for _, target in ipairs(targets) do
    if not target.GainUltiEnergy then
      self.battleEngine:Error("获得狂气失败，目标不是唤醒体。指令ID：" .. self.cmdServer.cmdId)
    else
      for _ = 1, times do
        local extraData = self:GetPropertyChangeSource(reason, baseUltiEnergy)
        target:GainUltiEnergy(baseUltiEnergy, extraData)
      end
    end
  end
  return true
end

return BEPassiveUltiEnergy
