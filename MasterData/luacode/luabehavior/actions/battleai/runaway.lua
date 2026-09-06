local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local RunAway = class("RunAway", Task)

function RunAway:Ctor(context, animationname)
  RunAway.super.Ctor(self)
  self._context = context
  self._battleWorld = self._context._battleworld
  self._entity = nil
  for i, e in ipairs(self._battleWorld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._animationName = animationname
  self._utility = BattleECS.Utility.Utility
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
  self._physicsUtility = BattleECS.Utility.PhysicsUtility
end

function RunAway:OnStart()
end

function RunAway:OnUpdate(deltaTime)
  local TypeComponent = BattleECS.Components.TypeComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local SummonDataComponent = BattleECS.Components.SummonDataComponent
  local BuffComponent = BattleECS.Components.BuffComponent
  if not self._animationName or self._animationName == "" then
    self._animationName = "RunAway"
  end
  self._utility.SetEntityHpComponentHpStage(self._entity, "escape")
  if self._entity:GetComponent(TypeComponent)._summonName == "buff" then
    local fatherEntity
    for i, e in ipairs(self._battleWorld._entitys) do
      if e._entityId == self._entity:GetComponent(TypeComponent)._summonFatherEntityid then
        fatherEntity = e
        break
      end
    end
    if fatherEntity then
      local fatherSummonData = fatherEntity:GetComponent(SummonDataComponent)._summonBuffData
      for i = #fatherSummonData, 1, -1 do
        local data = fatherSummonData[i]
        if data.summonEntityId == self._entity._entityId then
          local buffComponent = fatherEntity:GetComponent(BuffComponent)
          if buffComponent then
            for i = #buffComponent._buffList, 1, -1 do
              local v = buffComponent._buffList[i]
              if v.buffId == data.buffId then
                v.buffObj:Destroy()
                table.remove(buffComponent._buffList, i)
                break
              end
            end
          end
          table.remove(fatherSummonData, i)
        end
      end
    end
  end
  BattleECS.Utility.BuffUtility.ClearDeadEntityBuff(self._entity)
  local ifIgnorePriority = {No = 0, Yes = 1}
  self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(self._entity, self._animationName, ifIgnorePriority.No, self._battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sroledead")
  protocol.entityId = self._entity._entityId
  protocol.damageFrom = self._entity._entityId
  protocol.damageNum = 0
  protocol.isrunaway = 1
  LogInfo("角色逃跑.....", self._entity._entityId .. " " .. tostring(self._entity:GetComponent(TypeComponent)._roleID))
  self._battleWorld:InsertViewProtocolData(protocol)
  self._physicsUtility.SetEntityPhyscisComponentAwake(self._entity, false)
  self._entity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
  return TaskStatus.Success
end

function RunAway:OnEnd()
end

return RunAway
