local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEActiveDeathResist, Super = System.NewClass("BEActiveDeathResist", BattleEffectServer)

function BEActiveDeathResist:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BEActiveDeathResist:DoEffect()
  Super.DoEffect(self)
  local argIndex = self.params[1]
  local argKey = "TempArg" .. argIndex
  local role = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local eventData = {
    castRoleUid = role.uid,
    targetRoleUid = role.uid,
    cmdServerUid = self.cmdServer.uid
  }
  local isDeathResist = role:IsDeathResist()
  local argValue = isDeathResist and 1 or 0
  self.cmdServer:SetMemberValue(argKey, argValue)
  if isDeathResist then
    role:DeathResist(true)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleAfterDeathResist, eventData)
  end
  return true
end

return BEActiveDeathResist
