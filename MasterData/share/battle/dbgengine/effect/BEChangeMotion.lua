local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleUnitMonster = require("Battle.DbgEngine.Role.BattleUnitMonster")
local BEChangeMotion, Super = System.NewClass("BEChangeMotion", BattleEffectServer)

function BEChangeMotion:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeMotion:Dispose()
  Super.Dispose(self)
end

function BEChangeMotion:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local originMotion = self.params[1]
  local changeMotion = self.params[2]
  for _, target in ipairs(targets) do
    target.data.motion[originMotion] = changeMotion
    self.battleEngine.recordMgr:OnChangeMotion(target)
  end
  return true
end

return BEChangeMotion
