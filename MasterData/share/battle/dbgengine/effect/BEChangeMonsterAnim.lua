local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleUnitMonster = require("Battle.DbgEngine.Role.BattleUnitMonster")
local BEChangeMonsterAnim, Super = System.NewClass("BEChangeMonsterAnim", BattleEffectServer)

function BEChangeMonsterAnim:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeMonsterAnim:Dispose()
  Super.Dispose(self)
end

function BEChangeMonsterAnim:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local animIdx = self.params[1]
  for _, target in ipairs(targets) do
    target:SetMonsterAnimIdx(animIdx)
    target.data.motion = {}
    self.battleEngine.recordMgr:OnChangeMotion(target)
    self.battleEngine.recordMgr:OnChangeMonsterAnim(target.uid, animIdx)
  end
  return true
end

return BEChangeMonsterAnim
