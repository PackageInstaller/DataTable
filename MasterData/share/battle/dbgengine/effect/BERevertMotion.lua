local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleUnitMonster = require("Battle.DbgEngine.Role.BattleUnitMonster")
local BattleUnitAwaker = require("Battle.DbgEngine.Role.BattleUnitAwaker")
local BERevertMotion, Super = System.NewClass("BERevertMotion", BattleEffectServer)

function BERevertMotion:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERevertMotion:Dispose()
  Super.Dispose(self)
end

function BERevertMotion:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  for _, target in ipairs(targets) do
    if target:is(BattleUnitMonster) or target:is(BattleUnitAwaker) then
      target.data.motion = {}
      self.battleEngine.recordMgr:OnChangeMotion(target)
    end
  end
  return true
end

return BERevertMotion
