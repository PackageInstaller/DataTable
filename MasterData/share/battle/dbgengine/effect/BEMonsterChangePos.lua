local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEMonsterChangePos, Super = System.NewClass("BEMonsterChangePos", BattleEffectServer)

function BEMonsterChangePos:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEMonsterChangePos:Dispose()
  Super.Dispose(self)
end

function BEMonsterChangePos:DoEffect()
  Super.DoEffect(self)
  local target = self.targets[1]
  local pos = self.params[1]
  local curMonster = self.battleEngine.roleMgr:GetMonsterByPos(pos)
  if curMonster then
    curMonster:SetBattleFieldPos(target:GetBattleFieldPos())
    self.battleEngine.recordMgr:OnMonsterChangePos(curMonster.uid, curMonster:GetBattleFieldPos())
  end
  target:SetBattleFieldPos(pos)
  self.battleEngine.recordMgr:OnMonsterChangePos(target.uid, target:GetBattleFieldPos())
  return true
end

return BEMonsterChangePos
