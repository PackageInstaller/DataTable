-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/basescenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local DragSceneConfig = (((CS.PixelNeko).P1).Config).DragSceneConfig
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local UIManager = ((CS.PixelNeko).UI).UIManager
local SpriteRendererStaticFunctions = ((CS.PixelNeko).Lua).SpriteRendererStaticFunctions
local StoryTimelineTable = (BeanManager.GetTableByName)("timeline.cstorytimelineconfig")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local BoxColiderStaticFunctions = ((CS.PixelNeko).Lua).BoxColiderStaticFunctions
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local BaseSceneController = class("BaseSceneController", SceneController)
local RedDotManager = require("logic.redpoint.reddotmanager")
local CGuideConditionconfig = (BeanManager.GetTableByName)("guide.cguideconditionconfig")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CNpcShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local ForgerAnimatorType = {[1] = "talk", [2] = "laugh", [3] = "whistle"}
local ShowBaseMainUI = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("base.basemainui")
  if dialog then
    dialog:Show()
  end
  dialog = (DialogManager.GetDialog)("base.basemainmenudialog")
  if dialog then
    dialog:SetActive(true)
  end
end

local HideBaseMainUI = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("base.basemainui")
  if dialog then
    dialog:Hide()
  end
  dialog = (DialogManager.GetDialog)("base.basemainmenudialog")
  if dialog then
    dialog:SetActive(false)
  end
end

local OnAnimationEvent = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_2 , upvalues : HideBaseMainUI, _ENV
  if stringValue ~= "OpenDialog" then
    return 
  end
  HideBaseMainUI(self)
  ;
  ((self._sceneRef):GetCinemachiesAnimator()):SetBool("isOpenedDialog", true)
  ;
  ((self._sceneRef):GetCameraAnimator()):SetBool("isOpenedDialog", true)
  ;
  (self._baseInteractDialog):HideText()
  local dialog = nil
  if self._state == 1 then
    LogInfo("BaseSceneController", "跳转主线副本选择")
    dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
  else
    if self._state == 2 then
      LogInfo("BaseSceneController", "跳转抽卡")
      local csend = (LuaNetManager.CreateProtocol)("protocol.card.crefreshcardui")
      csend:Send()
      if not ((NekoData.BehaviorManager).BM_Game):IsFirstGachaEnd() then
        local csend = (LuaNetManager.CreateProtocol)("protocol.card.cnewdrawcard")
        csend:Send()
      else
        do
          do
            dialog = (DialogManager.CreateSingletonDialog)("gacha.gachamaindialog")
            if self._state == 3 then
              dialog = (DialogManager.CreateSingletonDialog)("task.taskmaindialog")
            else
              if self._state == 5 then
                local csend = (LuaNetManager.CreateProtocol)("protocol.party.copenparty")
                if csend then
                  csend:Send()
                end
              else
                do
                  if self._state == 6 then
                    dialog = (DialogManager.CreateSingletonDialog)("equip.bagdialog")
                  else
                    if self._state == 8 then
                      dialog = (DialogManager.CreateSingletonDialog)("equip.bagdialog")
                    else
                      if self._state == 9 then
                        dialog = (DialogManager.GetDialog)("character.basecharacterlistalldialog")
                        if not dialog then
                          dialog = (DialogManager.CreateSingletonDialog)("character.basecharacterlistalldialog")
                        end
                      else
                        if self._state == 10 then
                          dialog = (DialogManager.CreateSingletonDialog)("tujian.tujiandialog")
                        end
                      end
                    end
                  end
                  if dialog then
                    dialog:Init(self)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local MoveCamera = function(self, xOffset)
  -- function num : 0_3 , upvalues : _ENV
  (self._baseSceneController):MoveCamera(self._farClipPlaneWorldWidth * self._farClipPlaneWidthScale * xScreenOffset / self._farClipPlaneScreenWidth, 0, 0)
end

local HandleGuideStoryEnd = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local storyId = notification.userInfo
  if storyId and storyId ~= 0 then
    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(41) then
      ((NekoData.BehaviorManager).BM_Guide):FinishGuide(41)
    else
      if self._checkResonanceGuide then
        self._checkResonanceGuide = false
        local dialog = (DialogManager.GetDialog)("base.baseinteractdialog")
        if dialog then
          dialog:ClickChar1Chat()
        end
      end
    end
  end
end

local HandleHandleStage = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, HandleGuideStoryEnd
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  if userInfo.guideID == 31 then
    local stage = (userInfo.stageRefCountTable)[1]
    if stage > 0 then
      self._goGuide = true
      ;
      (LuaNotificationCenter.AddObserver)(self, HandleGuideStoryEnd, Common.n_GuideStoryEnd, nil)
      self._checkResonanceGuide = true
      ;
      (self._baseMainFSM):SetNumber("storyId", 2006)
    end
  end
end

local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV, HandleGuideStoryEnd
  local guideId = (notification.userInfo).guideID
  if guideId == 22 or guideId == 24 or guideId == 40 or guideId == 41 or guideId == 42 or guideId == 43 or guideId == 26 or guideId == 23 or guideId == 47 or guideId == 49 then
    if (notification.userInfo).guideStatus == "Start" then
      local dialog = (DialogManager.GetDialog)("base.baseinteractdialog")
      if dialog then
        dialog:SetDragEnable(false)
      end
      if guideId == 40 then
        (self._baseMainFSM):SetNumber("storyId", 2003)
      else
        if guideId == 41 then
          (LuaNotificationCenter.AddObserver)(self, HandleGuideStoryEnd, Common.n_GuideStoryEnd, nil)
          ;
          (self._baseMainFSM):SetNumber("storyId", 2005)
        else
          if guideId == 42 then
            (self._baseMainFSM):SetNumber("storyId", 2004)
          end
        end
      end
    else
      do
        local dialog = (DialogManager.GetDialog)("base.baseinteractdialog")
        if dialog then
          dialog:SetDragEnable(true)
        end
      end
    end
  end
end

BaseSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_7 , upvalues : BaseSceneController
  ((BaseSceneController.super).Ctor)(self, sceneRef)
  self._minX = nil
  self._maxX = nil
  self._inertiaTime = nil
  self._farClipPlaneWorldWidth = nil
  self._farClipPlaneScreenWidth = nil
  self._farClipPlaneWidthScale = nil
  self._dragSceneConfig = nil
  self._enableDrag = true
  self._timeline = nil
  self._startFSM = true
  self._sceneTextVisibleTable = {}
  self._sceneTextDisvisiableTable = {}
  self._sceneTextTable = {}
  self._baseInteractDialog = nil
  self._baseMainFSM = nil
  self._responseMouseClick = false
end

local DrageSceneConfigChangedCallback = function(self)
  -- function num : 0_8 , upvalues : GlobalCameras
  local camera = (self._sceneRef):GetCamera()
  local farClipPlane = camera.farClipPlane
  local startX, startY, startZ = (GlobalCameras.ViewToWorldPoint)("Main", 0, 0, farClipPlane)
  local endX, endY, endZ = (GlobalCameras.ViewToWorldPoint)("Main", 1, 0, farClipPlane)
  self._farClipPlaneWorldWidth = endX - startX
  startX = (GlobalCameras.viewToScreenPoint)("Main", 0, 0, farClipPlane)
  endX = (GlobalCameras.viewToScreenPoint)("Main", 1, 0, farClipPlane)
  self._farClipPlaneScreenWidth = endX - startX
  self._farClipPlaneWidthScale = (self._dragSceneConfig).SpeedScaleX
  self._minX = (self._dragSceneConfig).MinX
  self._maxX = (self._dragSceneConfig).MaxX
  self._inertiaTime = (self._dragSceneConfig).InertiaTime
end

BaseSceneController.Init = function(self)
  -- function num : 0_9 , upvalues : BaseSceneController, _ENV, RedDotManager, StateEventTriggerHelper, OnAnimationEvent, DragSceneConfig, DrageSceneConfigChangedCallback, HandleHandleStage, HandleGuideStatusChanged
  ((BaseSceneController.super).Init)(self)
  ;
  (LuaAudioManager.PlayBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
  local baseInteractDialog = (DialogManager.CreateSingletonDialog)("base.baseinteractdialog")
  if baseInteractDialog then
    baseInteractDialog:Init(self)
    self._baseInteractDialog = baseInteractDialog
  end
  local dialog = (DialogManager.CreateSingletonDialog)("base.basemainui")
  if dialog then
    dialog:Init(self)
  end
  ;
  (RedDotManager.CheckRedDotOnLogin)()
  ;
  (StateEventTriggerHelper.AddAnimationEventListener)(((self._sceneRef):GetCameraAnimator()).gameObject, "CameraFocus", OnAnimationEvent, self)
  local camera = (self._sceneRef):GetCamera()
  self._dragSceneConfig = (DragSceneConfig.GetDragSceneConfig)(camera.gameObject)
  if self._dragSceneConfig ~= nil then
    (self._dragSceneConfig):SetConfigChangedCallback(DrageSceneConfigChangedCallback, self)
    DrageSceneConfigChangedCallback(self)
    self._enableDrag = true
  else
    self._enableDrag = false
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleHandleStage, Common.n_HandleStage, nil)
  local stargGuideInfo = {[31] = 1}
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StartGuideStage, self, stargGuideInfo)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSingleDialogClose, Common.n_SingletonDialogDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetChar, Common.n_OnSChooseBackGround, nil)
  self:SetChar()
  self:SetBaseCharActive(true)
end

BaseSceneController.SetChar = function(self)
  -- function num : 0_10 , upvalues : _ENV, CNpcShape, CSkin, PrefabLoader, TransformStaticFunctions
  if self._char then
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._char)
    self._char = nil
  end
  local roleId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).backgroundRole
  local skinId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).backgroundSkin
  local assetBundleName, assetName = nil, nil
  if roleId == 0 then
    local CPosterGirlNpc = (BeanManager.GetTableByName)("welfare.cpostergirlnpc")
    local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
    local shapRecorder = CNpcShape:GetRecorder(aiLinNaRecorder.shapeId)
    assetBundleName = shapRecorder.assetBundleName
    assetName = shapRecorder.prefabName
  else
    do
      local fashionData = CSkin:GetRecorder(skinId)
      local shapeId = fashionData.shapeID
      do
        local shapRecorder = CNpcShape:GetRecorder(shapeId)
        assetBundleName = shapRecorder.assetBundleName
        assetName = shapRecorder.prefabName
        self._char = (PrefabLoader.LoadAndInstantiatePrefab)(assetBundleName, assetName)
        ;
        (TransformStaticFunctions.SetParent)((self._char).transform, ((self._sceneRef)._char_Point).transform)
        self:RefrashCharBubble()
        if roleId ~= 0 then
          (TransformStaticFunctions.SetLocalScale)((self._sceneRef)._char_Point, -1, 1, 1)
        else
          ;
          (TransformStaticFunctions.SetLocalScale)((self._sceneRef)._char_Point, 1, 1, 1)
        end
      end
    end
  end
end

BaseSceneController.RefrashCharBubble = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (self:GetChar001forbaseHeadBubble()):SetActive((((CS.UnityEngine).PlayerPrefs).HasKey)("FirstUnlockSignBoard"))
end

BaseSceneController.SetBaseMainFSM = function(self)
  -- function num : 0_12 , upvalues : _ENV, CGuideConditionconfig, GuideType, CVarConfig
  do
    if (LuaUpdateManager.HasLatestAppVersion)() then
      local today = tonumber((os.date)("%j"))
      if ((NekoData.BehaviorManager).BM_Game):GetLocalCache((DataCommon.LocalCache).OpenUpdateJumpStoreDialog) ~= today then
        ((NekoData.BehaviorManager).BM_Game):SetLocalCache((DataCommon.LocalCache).OpenUpdateJumpStoreDialog, today)
        ;
        (DialogManager.CreateSingletonDialog)("login.updatejumpstoredialog")
      end
    end
    self._baseMainFSM = (BaseMainFSM.Create)()
    ;
    (self._baseMainFSM):Init()
    ;
    (self._baseMainFSM):SetStateEnterCallBack(self.OnStateEnter, self)
    ;
    (self._baseMainFSM):SetStateExitCallBack(self.OnStateExit, self)
    ;
    (self._baseMainFSM):SetBoolean("toNormal", true)
    if self._startFSM then
      local lastFloorId = ((NekoData.BehaviorManager).BM_Game):GetLastFloorId()
      local storyMirrorParam = {((CGuideConditionconfig:GetRecorder(19)).parm)[1], ((CGuideConditionconfig:GetRecorder(19)).parm)[2], ((CGuideConditionconfig:GetRecorder(19)).parm)[3]}
      local PopTipsStatusType = {NotGet = 1, Got = 0}
      if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.mirror_1) ~= 1 and ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(tonumber(storyMirrorParam[2])) == tonumber(storyMirrorParam[3]) and not (DialogManager.GetDialog)("loadingdialog") then
        (self._baseMainFSM):SetNumber("storyId", 2001)
        ;
        (self._baseMainFSM):SetNumber("startDialogId", 1)
        self._startFSM = false
      end
    end
    if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.GUIDE_2007) == 0 and not (DialogManager.GetDialog)("loadingdialog") then
      (self._baseMainFSM):SetNumber("storyId", 2007)
      ;
      (self._baseMainFSM):SetNumber("startDialogId", 1)
      self._startFSM = false
    end
    if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.GUIDE_2008) ~= 1 and lastFloorId == tonumber((CVarConfig:GetRecorder(40)).Value) and not (DialogManager.GetDialog)("loadingdialog") then
      (self._baseMainFSM):SetNumber("storyId", 2008)
      ;
      (self._baseMainFSM):SetNumber("startDialogId", 1)
      self._startFSM = false
    end
    if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.GUIDE_2009) == 0 and not (DialogManager.GetDialog)("loadingdialog") then
      (self._baseMainFSM):SetNumber("storyId", 2009)
      ;
      (self._baseMainFSM):SetNumber("startDialogId", 1)
      self._startFSM = false
    end
    if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.GUIDE_2010) ~= 1 and lastFloorId == tonumber((CVarConfig:GetRecorder(49)).Value) and not (DialogManager.GetDialog)("loadingdialog") then
      (self._baseMainFSM):SetNumber("storyId", 2010)
      ;
      (self._baseMainFSM):SetNumber("startDialogId", 1)
      self._startFSM = false
    end
    if ((NekoData.BehaviorManager).BM_Activity):GetPopTipsStatusWithActivityId((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfareSignAwardActivityId) == PopTipsStatusType.NotGet and not (DialogManager.GetDialog)("loadingdialog") then
      (self._baseMainFSM):SetNumber("storyId", DataCommon.ReturnWelfarePopTips)
      self._startFSM = false
    end
    ;
    (self._baseMainFSM):SetNumber("startDialogId", 1)
    self._startFSM = false
  end
end

BaseSceneController.GetSceneTextGameObjectTable = function(self)
  -- function num : 0_13
  return (self._sceneRef)._sceneTextGameObjectTable
end

BaseSceneController.OnDestroy = function(self)
  -- function num : 0_14 , upvalues : BaseSceneController, _ENV
  self._baseMainFSM = nil
  ;
  ((BaseSceneController.super).OnDestroy)(self)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StopGuideStage, self, {[31] = 1})
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

local IsInBlock = function(self)
  -- function num : 0_15
end

local InertiaMoveUpdate = function(self)
  -- function num : 0_16
end

local BlockMoveUpdate = function(self)
  -- function num : 0_17
end

BaseSceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_18 , upvalues : BaseSceneController, _ENV
  ((BaseSceneController.super).Update)(self, deltaTime, unscaleDeltaTime)
  if self._baseMainFSM then
    (self._baseMainFSM):Update()
    ;
    ((require("logic.fsm.basemainfsm." .. (string.lower)((self._baseMainFSM):GetCurrentState()))).Update)(self)
  end
  if self._baseMainFSM and not (self._baseMainFSM):GetParameter("toAccount") and ((NekoData.BehaviorManager).BM_Game):GetTip() == 5 and not self._errorReturn then
    self._errorReturn = true
  end
end

BaseSceneController.OnStateEnter = function(self, currentState, lastState)
  -- function num : 0_19 , upvalues : _ENV
  ((require("logic.fsm.basemainfsm." .. (string.lower)(currentState))).OnEnter)(self, lastState)
end

BaseSceneController.OnStateExit = function(self, currentState, nextState)
  -- function num : 0_20 , upvalues : _ENV
  ((require("logic.fsm.basemainfsm." .. (string.lower)(currentState))).OnExit)(self, nextState)
end

BaseSceneController.GetCamera = function(self)
  -- function num : 0_21
  return (self._sceneRef):GetCamera()
end

BaseSceneController.GetCameraTransform = function(self)
  -- function num : 0_22
  return (self._sceneRef):GetCameraTransform()
end

BaseSceneController.MoveCamera = function(self, xScreenOffset)
  -- function num : 0_23 , upvalues : _ENV
  if self._enableDrag == false then
    return 
  end
  local xDistance = self._farClipPlaneWorldWidth * self._farClipPlaneWidthScale * xScreenOffset / self._farClipPlaneScreenWidth
  local startTransform = ((self._sceneRef)._cameraFollowPoint).transform
  local resultPosX = (startTransform.position).x + xDistance
  if resultPosX < self._minX then
    resultPosX = self._minX
  else
    if self._maxX < resultPosX then
      resultPosX = self._maxX
    end
  end
  xDistance = resultPosX - (startTransform.position).x
  ;
  (((self._sceneRef)._cameraFollowPoint).transform):Translate(xDistance, 0, 0, ((CS.UnityEngine).Space).World)
  return true
end

BaseSceneController.SetCameraPos = function(self, pos)
  -- function num : 0_24
end

BaseSceneController.SetCameraAnimatorState = function(self, state)
  -- function num : 0_25 , upvalues : ShowBaseMainUI, _ENV
  if state == 0 then
    ShowBaseMainUI(self)
    ;
    ((self._sceneRef):GetCinemachiesAnimator()):SetBool("isOpenedDialog", false)
    ;
    ((self._sceneRef):GetCameraAnimator()):SetBool("isOpenedDialog", false)
    ;
    (self._baseInteractDialog):ShowText()
  end
  if state ~= 4 then
    if state == 2 and not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Gacha) then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100137)
      return 
    end
    if state == 3 and not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_MainLine) then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100139)
      return 
    end
    if state == 5 and not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Guild) then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100294)
      return 
    end
    self._state = state
    ;
    ((self._sceneRef):GetCinemachiesAnimator()):SetInteger("Target", state)
    ;
    ((self._sceneRef):GetCameraAnimator()):SetInteger("Target", state)
    ;
    (self._baseInteractDialog):ShowText()
    self:ResetJumpValue()
  end
end

BaseSceneController.SetStateNotShowUI = function(self, state)
  -- function num : 0_26
  ((self._sceneRef):GetCinemachiesAnimator()):SetBool("isOpenedDialog", false)
  ;
  ((self._sceneRef):GetCameraAnimator()):SetBool("isOpenedDialog", false)
end

BaseSceneController.OnTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_27 , upvalues : _ENV
  if stringValue == "StartNPCChat" then
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
    self._npcChatId = longValue
    ;
    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(longValue, false, tonumber(doubleValue))
  end
end

BaseSceneController.OnNPCChatEnd = function(self, notification)
  -- function num : 0_28 , upvalues : _ENV
  if notification.userInfo == self._npcChatId then
    self._npcChatId = 0
    ;
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
  end
end

BaseSceneController.CreateTimeline = function(self, storyId)
  -- function num : 0_29 , upvalues : _ENV, StoryTimelineTable
  self._timeline = (((((CS.PixelNeko).P1).TimeLine).TimelineManager).CreateTimeLineSync)((StoryTimelineTable:GetRecorder(storyId)).AssetBundle, (StoryTimelineTable:GetRecorder(storyId)).AssetName, (self._sceneRef)._story)
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)(self._timeline, self.OnTriggerBehaviourPlay, self)
end

BaseSceneController.SetJumpValue = function(self, jumpValue)
  -- function num : 0_30
  ((self._sceneRef):GetCinemachiesAnimator()):SetInteger("JumpValue", jumpValue)
end

BaseSceneController.ResetJumpValue = function(self)
  -- function num : 0_31
  ((self._sceneRef):GetCinemachiesAnimator()):SetInteger("JumpValue", 0)
end

BaseSceneController.GetChar001forbase = function(self)
  -- function num : 0_32
  return (self._sceneRef)._char_001forbase
end

BaseSceneController.GetChar013forbase = function(self)
  -- function num : 0_33
  return (self._sceneRef)._char_013forbase
end

BaseSceneController.GetChar001forbaseHeadBubble = function(self)
  -- function num : 0_34
  return (self._sceneRef)._char_001forbase_head_bubble
end

BaseSceneController.SetBaseCharActive = function(self, flag)
  -- function num : 0_35 , upvalues : _ENV
  (self:GetChar001forbase()):SetActive(flag)
  if flag and ((NekoData.BehaviorManager).BM_Guide):HasFinished(15) then
    (self:GetChar013forbase()):SetActive(true)
  else
    ;
    (self:GetChar013forbase()):SetActive(false)
  end
end

BaseSceneController.OnSingleDialogClose = function(self)
  -- function num : 0_36 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

BaseSceneController.GetBuildingSizeAndPos = function(self, nodePath)
  -- function num : 0_37 , upvalues : TransformStaticFunctions, BoxColiderStaticFunctions, UIManager, _ENV
  if nodePath then
    local nodeObject = (TransformStaticFunctions.GetChild)((self._sceneRef)._rootGameObject, nodePath)
    local posMin = (BoxColiderStaticFunctions.GetBoundsMin)(nodeObject)
    local minScreenPos_x, minScreenPos_y = (UIManager.WorldToScreenPointInMargin)("Main", posMin.x, posMin.y, posMin.z)
    local minLocalPos_x, minLocalPos_y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, minScreenPos_x, minScreenPos_y)
    local posMax = (BoxColiderStaticFunctions.GetBoundsMax)(nodeObject)
    local maxScreenPos_x, maxScreenPos_y = (UIManager.WorldToScreenPointInMargin)("Main", posMax.x, posMax.y, posMax.z)
    local maxLocalPos_x, maxLocalPos_y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, maxScreenPos_x, maxScreenPos_y)
    local width = (math.abs)(maxLocalPos_x - minLocalPos_x)
    local height = (math.abs)(maxLocalPos_y - minLocalPos_y)
    local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("Main", (BoxColiderStaticFunctions.GetBoundsCenter)(nodeObject)))
    return {width = width, height = height, posX = posX, posY = posY}
  end
end

BaseSceneController.ForgerPlayAnimation = function(self)
  -- function num : 0_38 , upvalues : ForgerAnimatorType, _ENV
  local len = #ForgerAnimatorType
  local key = (math.random)(1, len)
  ;
  ((self:GetChar013forbase()):GetComponent("Animator")):SetTrigger(ForgerAnimatorType[key])
end

return BaseSceneController

