-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/handbookcontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local CNpcHandBookCfg = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local HandBookController = class("HandBookController", SceneController)
HandBookController.Init = function(self)
  -- function num : 0_0 , upvalues : HandBookController
  ((HandBookController.super).Init)(self)
end

HandBookController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : HandBookController
  ((HandBookController.super).OnDestroy)(self)
end

HandBookController.SetCameraAnimatorState = function(self, state)
  -- function num : 0_2
  ((self._sceneRef):GetCinemachiesAnimator()):SetInteger("state", state)
end

HandBookController.GetCamera = function(self)
  -- function num : 0_3
  return (self._sceneRef)._camera
end

HandBookController.SetUnLockNode = function(self)
  -- function num : 0_4 , upvalues : _ENV, HandBookTypeEnum, CNpcHandBookCfg
  local lockedRoleList = ((NekoData.BehaviorManager).BM_HandBook):GetLockedRoleList()
  local lockedRoleMap = {}
  for _,id in ipairs(lockedRoleList) do
    lockedRoleMap[id] = true
  end
  for i = 0, ((self._sceneRef)._nodeList).Length - 1 do
    if (((self._sceneRef)._nodeList)[i]).IntData ~= 0 then
      local isNpcLock = not ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock((((self._sceneRef)._nodeList)[i]).IntData, HandBookTypeEnum.NPC)
      local isRoleLock = false
      local recoder = CNpcHandBookCfg:GetRecorder((((self._sceneRef)._nodeList)[i]).IntData)
      if recoder == nil then
        LogErrorFormat("BM_HandBook", "cnpcconfig_handbook not exist npcis:%s", npcid)
        isRoleLock = true
      else
        if recoder.roleID ~= -1 then
          if ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(recoder.roleID) then
            do
              isRoleLock = not not ((NekoData.BehaviorManager).BM_HandBook):IsLockedRole(recoder.roleID)
              isRoleLock = false
              isRoleLock = true
              if isNpcLock and isRoleLock then
                (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Sprite")).gameObject):SetActive(false)
                ;
                (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Lock")).gameObject):SetActive(true)
                -- DECOMPILER ERROR at PC109: Confused about usage of register: R10 in 'UnsetPending'

                ;
                (((self._sceneRef)._nodeList)[i]).StringData = "Lock"
              else
                (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Sprite")).gameObject):SetActive(true)
                ;
                (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Lock")).gameObject):SetActive(false)
                -- DECOMPILER ERROR at PC142: Confused about usage of register: R10 in 'UnsetPending'

                if not isNpcLock and not isRoleLock then
                  (((self._sceneRef)._nodeList)[i]).StringData = "AllUnLock"
                else
                  -- DECOMPILER ERROR at PC149: Confused about usage of register: R10 in 'UnsetPending'

                  if not isNpcLock then
                    (((self._sceneRef)._nodeList)[i]).StringData = "NpcUnLock"
                  else
                    -- DECOMPILER ERROR at PC156: Confused about usage of register: R10 in 'UnsetPending'

                    if not isRoleLock then
                      (((self._sceneRef)._nodeList)[i]).StringData = "RoleUnLock"
                    end
                  end
                end
              end
              if (((self._sceneRef)._nodeList)[i]).IntData2 ~= 0 then
                local isRoleLock = not ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock((((self._sceneRef)._nodeList)[i]).IntData2)
                local isNpcLock = false
                local npcid = nil
                for k,v in ipairs(CNpcHandBookCfg:GetAllIds()) do
                  local recoder = CNpcHandBookCfg:GetRecorder(v)
                  if recoder.roleID == (((self._sceneRef)._nodeList)[i]).IntData2 then
                    npcid = v
                  end
                end
                if npcid then
                  isNpcLock = not ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(npcid, HandBookTypeEnum.NPC)
                else
                  isNpcLock = true
                end
                if lockedRoleMap[(((self._sceneRef)._nodeList)[i]).IntData2] and isNpcLock then
                  ((((self._sceneRef)._nodeList)[i]).gameObject):SetActive(false)
                  -- DECOMPILER ERROR at PC227: Confused about usage of register: R10 in 'UnsetPending'

                  ;
                  (((self._sceneRef)._nodeList)[i]).StringData = "Lock"
                elseif isRoleLock and isNpcLock then
                  (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Sprite")).gameObject):SetActive(false)
                  ;
                  (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Lock")).gameObject):SetActive(true)
                  -- DECOMPILER ERROR at PC260: Confused about usage of register: R10 in 'UnsetPending'

                  ;
                  (((self._sceneRef)._nodeList)[i]).StringData = "Lock"
                else
                  (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Sprite")).gameObject):SetActive(true)
                  ;
                  (((((((self._sceneRef)._nodeList)[i]).gameObject).transform):Find("Lock")).gameObject):SetActive(false)
                  -- DECOMPILER ERROR at PC293: Confused about usage of register: R10 in 'UnsetPending'

                  if not isNpcLock and not isRoleLock then
                    (((self._sceneRef)._nodeList)[i]).StringData = "AllUnLock"
                  else
                    -- DECOMPILER ERROR at PC300: Confused about usage of register: R10 in 'UnsetPending'

                    if not isNpcLock then
                      (((self._sceneRef)._nodeList)[i]).StringData = "NpcUnLock"
                    else
                      -- DECOMPILER ERROR at PC307: Confused about usage of register: R10 in 'UnsetPending'

                      if not isRoleLock then
                        (((self._sceneRef)._nodeList)[i]).StringData = "RoleUnLock"
                      end
                    end
                  end
                end
              end
              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

HandBookController.SetGroupAnimatorStateById = function(self, id, state)
  -- function num : 0_5
  local groupAnimator = ((self._sceneRef)._groupAnimatorDic)[id]
  groupAnimator:SetInteger("state", state)
end

HandBookController.PlayBackgroundTimeline = function(self, world)
  -- function num : 0_6 , upvalues : _ENV
  local object = ((self._sceneRef)._backgroundTimelineObjects)[world]
  if object then
    object:Play()
  else
    LogInfoFormat("PlayBackgroundTimeline", "no timelineobject with id: %s.", world)
  end
end

HandBookController.PlayBackgroundToMainTimeline = function(self, world)
  -- function num : 0_7 , upvalues : _ENV
  local object = ((self._sceneRef)._backgroundToMainTimelineObjects)[world]
  if object then
    object:Play()
  else
    LogInfoFormat("PlayBackgroundToMainTimeline", "no timelineobject with id: %s.", world)
  end
end

return HandBookController

