local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local CNpcHandBookCfg = BeanManager.GetTableByName("handbook.cnpcconfig_handbook")
local HandBookController = class("HandBookController", SceneController)

function HandBookController:Init()
  HandBookController.super.Init(self)
end

function HandBookController:OnDestroy()
  HandBookController.super.OnDestroy(self)
end

function HandBookController:SetCameraAnimatorState(state)
  self._sceneRef:GetCinemachiesAnimator():SetInteger("state", state)
end

function HandBookController:GetCamera()
  return self._sceneRef._camera
end

function HandBookController:SetUnLockNode()
  local lockedRoleList = NekoData.BehaviorManager.BM_HandBook:GetLockedRoleList()
  local lockedRoleMap = {}
  for _, id in ipairs(lockedRoleList) do
    lockedRoleMap[id] = true
  end
  for i = 0, self._sceneRef._nodeList.Length - 1 do
    if self._sceneRef._nodeList[i].IntData ~= 0 then
      local isNpcLock = not NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(self._sceneRef._nodeList[i].IntData, HandBookTypeEnum.NPC)
      local isRoleLock = false
      local recoder = CNpcHandBookCfg:GetRecorder(self._sceneRef._nodeList[i].IntData)
      if recoder == nil then
        LogErrorFormat("BM_HandBook", "cnpcconfig_handbook not exist npcis:%s", npcid)
        isRoleLock = true
      elseif recoder.roleID ~= -1 then
        isRoleLock = not NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(recoder.roleID) or not not NekoData.BehaviorManager.BM_HandBook:IsLockedRole(recoder.roleID)
      else
        isRoleLock = true
      end
      if isNpcLock and isRoleLock then
        self._sceneRef._nodeList[i].gameObject.transform:Find("Sprite").gameObject:SetActive(false)
        self._sceneRef._nodeList[i].gameObject.transform:Find("Lock").gameObject:SetActive(true)
        self._sceneRef._nodeList[i].StringData = "Lock"
      else
        self._sceneRef._nodeList[i].gameObject.transform:Find("Sprite").gameObject:SetActive(true)
        self._sceneRef._nodeList[i].gameObject.transform:Find("Lock").gameObject:SetActive(false)
        if not isNpcLock and not isRoleLock then
          self._sceneRef._nodeList[i].StringData = "AllUnLock"
        elseif not isNpcLock then
          self._sceneRef._nodeList[i].StringData = "NpcUnLock"
        elseif not isRoleLock then
          self._sceneRef._nodeList[i].StringData = "RoleUnLock"
        end
      end
    elseif self._sceneRef._nodeList[i].IntData2 ~= 0 then
      local isRoleLock = not NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(self._sceneRef._nodeList[i].IntData2)
      local isNpcLock = false
      local npcid
      for k, v in ipairs(CNpcHandBookCfg:GetAllIds()) do
        local recoder = CNpcHandBookCfg:GetRecorder(v)
        if recoder.roleID == self._sceneRef._nodeList[i].IntData2 then
          npcid = v
        end
      end
      if npcid then
        isNpcLock = not NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(npcid, HandBookTypeEnum.NPC)
      else
        isNpcLock = true
      end
      if lockedRoleMap[self._sceneRef._nodeList[i].IntData2] and isNpcLock then
        self._sceneRef._nodeList[i].gameObject:SetActive(false)
        self._sceneRef._nodeList[i].StringData = "Lock"
      elseif isRoleLock and isNpcLock then
        self._sceneRef._nodeList[i].gameObject.transform:Find("Sprite").gameObject:SetActive(false)
        self._sceneRef._nodeList[i].gameObject.transform:Find("Lock").gameObject:SetActive(true)
        self._sceneRef._nodeList[i].StringData = "Lock"
      else
        self._sceneRef._nodeList[i].gameObject.transform:Find("Sprite").gameObject:SetActive(true)
        self._sceneRef._nodeList[i].gameObject.transform:Find("Lock").gameObject:SetActive(false)
        if not isNpcLock and not isRoleLock then
          self._sceneRef._nodeList[i].StringData = "AllUnLock"
        elseif not isNpcLock then
          self._sceneRef._nodeList[i].StringData = "NpcUnLock"
        elseif not isRoleLock then
          self._sceneRef._nodeList[i].StringData = "RoleUnLock"
        end
      end
    end
  end
end

function HandBookController:SetGroupAnimatorStateById(id, state)
  local groupAnimator = self._sceneRef._groupAnimatorDic[id]
  groupAnimator:SetInteger("state", state)
end

function HandBookController:PlayBackgroundTimeline(world)
  local object = self._sceneRef._backgroundTimelineObjects[world]
  if object then
    object:Play()
  else
    LogInfoFormat("PlayBackgroundTimeline", "no timelineobject with id: %s.", world)
  end
end

function HandBookController:PlayBackgroundToMainTimeline(world)
  local object = self._sceneRef._backgroundToMainTimelineObjects[world]
  if object then
    object:Play()
  else
    LogInfoFormat("PlayBackgroundToMainTimeline", "no timelineobject with id: %s.", world)
  end
end

return HandBookController
