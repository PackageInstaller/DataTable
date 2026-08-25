local bc = require("Battle.BattleConst")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BERoleDie, Super = System.NewClass("BERoleDie", BattleEffectServer)

function BERoleDie:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERoleDie:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BERoleDie:DoEffect()
  Super.DoEffect(self)
  local role = self.battleEngine:GetObj(self.effectConfig.roleUid)
  if not role then
    return false
  end
  if role:GetProperty(bc.BattleProperty.hp) > 0 then
    return true
  end
  local isIntro = self.battleEngine:GetData("isIntro")
  local cost = self.battleEngine:GetData("respawnCost")
  if self.battleEngine:IsPVE() and role.camp == bc.BattleCamp.Camp1 then
    if cost < role.data.lives then
      self.battleEngine.recordMgr:OnConfirm(self.uid, bc.ConfirmType.Respawn, role.data.lives)
      local data = {
        effectUid = self.uid,
        isReliveChoose = true
      }
      self.battleEngine.effectMgr:Yield(BattleCommand.lg_Confirm, data)
      return bc.YIELD_FLAG
    elseif isIntro and role.data.lives <= 1 then
      role:Respawn()
      self.battleEngine:ActiveBattleEnd(bc.BattleCamp.Camp1)
      self.battleEngine.isNeedCheckEnd = true
      return true
    else
      self.battleEngine.recordMgr:OnConfirm(self.uid, bc.ConfirmType.Respawn, role.data.lives)
      local data = {
        effectUid = self.uid,
        isReliveChoose = true
      }
      self.battleEngine.effectMgr:Yield(BattleCommand.lg_Confirm, data)
      return bc.YIELD_FLAG
    end
  end
  self:DoRoleDie()
  return true
end

function BERoleDie:OnConfirm(msgData)
  if msgData.effectUid ~= self.uid then
    return false
  end
  local role = self.battleEngine:GetObj(self.effectConfig.roleUid)
  if not role then
    return false
  end
  if msgData.confirm == true and role.data.lives > self.battleEngine:GetData("respawnCost") then
    local effectMgr = self.battleEngine.effectMgr
    effectMgr:Resume()
    role:Respawn()
    local instantRecordMgr = self.battleEngine.instantRecordMgr
    if instantRecordMgr then
      instantRecordMgr:OnSyncLives(role.data.lives)
    end
    self.battleEngine:CreateEventEffect(BattleLogicEvent.ConfirmRespawn, {})
  else
    self:DoRoleDie()
  end
  do return self.AfterEffect end
  return self.AfterEffect, self, self.battleEngine.CreateEventEffect, self.battleEngine, BattleLogicEvent.ConfirmRespawn, {}
end

function BERoleDie:DoRoleDie()
  local role = self.battleEngine:GetObj(self.effectConfig.roleUid)
  local deadConfig = {
    castRoleUid = self.effectConfig.castRoleUid,
    sourceCardUid = self.effectConfig.sourceCardUid,
    cmdServerUid = self.effectConfig.fromCmdServerUid
  }
  role:RoleDie(deadConfig)
end

return BERoleDie
