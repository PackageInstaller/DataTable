local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEUseSilverKeyAwake, Super = System.NewClass("BEUseSilverKeyAwake", BattleEffectServer)

function BEUseSilverKeyAwake:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEUseSilverKeyAwake:Dispose()
  Super.Dispose(self)
end

function BEUseSilverKeyAwake:DoEffect()
  Super.DoEffect(self)
  local role = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  role.data.silverKeyAwakeTimes = (role.data.silverKeyAwakeTimes or 0) + 1
  self.battleEngine.recordMgr:OnSilverKeyAwakeTimesChange(role.uid, role.data.silverKeyAwakeTimes)
  local skillId = role:GetSilverKeyAwakeSkill()
  self.battleEngine.recordMgr:OnUseSilverKeyAwake(role.uid, skillId)
  return true
end

return BEUseSilverKeyAwake
