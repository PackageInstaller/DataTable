local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BELaunchJump, Super = System.NewClass("BELaunchJump", BattleEffectServer)

function BELaunchJump:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BELaunchJump:Dispose()
  Super.Dispose(self)
end

function BELaunchJump:DoEffect()
  Super.DoEffect(self)
  local executeCmdId = self.params[1]
  local exeTimes = self.params[2] or 1
  if not executeCmdId or not self.cmdServer then
    return false
  end
  local caster = self.battleEngine:GetObj(self.cmdServer.castRoleUid)
  local noCondExtraBout = 0
  local extraJumpTimes = 0
  if caster:IsRoleType(bc.RoleType.Awaker) then
    noCondExtraBout = caster:GetProperty(bc.AwakerProperty.noCond_extraBout) or 0
    extraJumpTimes = caster:GetProperty(bc.AwakerProperty.extra_jump_time) or 0
  end
  for _ = 1, exeTimes do
    self:TriggerChildCmd(executeCmdId)
    self:__FireLaunchJump()
  end
  if extraJumpTimes > 0 then
    self:TriggerChildCmd(executeCmdId)
  end
  local data = {
    effectType = self.effectConfig.effectType
  }
  self.battleEngine.recordMgr:OnDoEffect(data)
  local roleUid = self.cmdServer.castRoleUid
  self.battleEngine.recordMgr:OnFloatingText(roleUid, "Float_Tip_DimensionJump", bc.FloatingTextType.PositiveTextAndIcon)
  return true
end

function BELaunchJump:TriggerChildCmd(executeCmdId)
  local childCmdServer = self.cmdServer:CreateChildCmdServer()
  local effectList = childCmdServer:GenerateEffectList(executeCmdId)
  for _, effectObj in ipairs(effectList) do
    effectObj:PreTrigger(self.cmdServer.triggerData)
  end
end

function BELaunchJump:__FireLaunchJump()
  if not self:IsTriggerBST() then
    return
  end
  local castRoleUid = self.cmdServer.castRoleUid
  local castCardUid = self.cmdServer.cardUid
  local isExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  local eventData = {
    castRoleUid = castRoleUid,
    castCardUid = castCardUid,
    isExtraBout = isExtraBout
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.LaunchJump, eventData)
end

return BELaunchJump
