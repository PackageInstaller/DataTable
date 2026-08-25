local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEMonsterBubble, Super = System.NewClass("BEMonsterBubble", BattleEffectServer)

function BEMonsterBubble:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEMonsterBubble:Dispose()
  Super.Dispose(self)
end

function BEMonsterBubble:DoEffect()
  Super.DoEffect(self)
  local tipsId = self.params[1]
  local showTime = self.params[2] or 1000
  if not tipsId then
    return false
  end
  local target = self.targets[1]
  if not target or not target:IsRoleType(bc.RoleType.Monster) then
    return false
  end
  if target.roleType ~= bc.RoleType.Monster then
    return false
  end
  self.battleEngine.recordMgr:OnMonsterBubble(target.uid, tipsId, showTime)
  return true
end

return BEMonsterBubble
