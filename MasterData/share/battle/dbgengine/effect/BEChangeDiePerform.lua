local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEChangeDiePerform, Super = System.NewClass("BEChangeDiePerform", BattleEffectServer)

function BEChangeDiePerform:DoEffect()
  Super.DoEffect(self)
  local performKey = self.params[1]
  if not performKey then
    return
  end
  local perform = self.battleEngine.battleDT.GetConstant(performKey)
  for _, target in ipairs(self.targets) do
    self.battleEngine.instantRecordMgr:OnChangeDiePerform(target.uid, performKey)
  end
  return true
end

return BEChangeDiePerform
