local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEUseDimensionSkill, Super = System.NewClass("BEUseDimensionSkill", BattleEffectServer)

function BEUseDimensionSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEUseDimensionSkill:Dispose()
  Super.Dispose(self)
end

function BEUseDimensionSkill:DoEffect()
  Super.DoEffect(self)
  local role = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  local extraData = {
    castRoleUid = self.uid,
    reason = bc.PropertyChangeReason.AttrModify
  }
  role:AddProperty(BP.bout_dskill_use_times, 1, extraData)
  local skillId = self.effectConfig.skillId
  self.battleEngine.recordMgr:OnUseDimensionSkill(role.uid, skillId)
  role:OnUseDimensionSkill(skillId)
  return true
end

return BEUseDimensionSkill
