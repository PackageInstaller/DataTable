local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local DragSceneConfig = CS.PixelNeko.P1.Config.DragSceneConfig
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local UIManager = CS.PixelNeko.UI.UIManager
local SpriteRendererStaticFunctions = CS.PixelNeko.Lua.SpriteRendererStaticFunctions
local StoryTimelineTable = BeanManager.GetTableByName("timeline.cstorytimelineconfig")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local BoxColiderStaticFunctions = CS.PixelNeko.Lua.BoxColiderStaticFunctions
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local BaseSceneController = class("BaseSceneController", SceneController)
local RedDotManager = require("logic.redpoint.reddotmanager")
local CGuideConditionconfig = BeanManager.GetTableByName("guide.cguideconditionconfig")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CNpcShape = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local ForgerAnimatorType = {
  [1] = "talk",
  [2] = "laugh",
  [3] = "whistle"
}

local function ShowBaseMainUI(self)
  local dialog = DialogManager.GetDialog("base.basemainui")
  if dialog then
    dialog:Show()
  end
  dialog = DialogManager.GetDialog("base.basemainmenudialog")
  if dialog then
    dialog:SetActive(true)
  end
end

local function HideBaseMainUI(self)
  local dialog = DialogManager.GetDialog("base.basemainui")
  if dialog then
    dialog:Hide()
  end
  dialog = DialogManager.GetDialog("base.basemainmenudialog")
  if dialog then
    dialog:SetActive(false)
  end
end

local function OnAnimationEvent(self, floatValue, intValue, stringValue, obj, clipName)
  if stringValue ~= "OpenDialog" then
    return
  end
  HideBaseMainUI(self)
  self._sceneRef:GetCinemachiesAnimator():SetBool("isOpenedDialog", true)
  self._sceneRef:GetCameraAnimator():SetBool("isOpenedDialog", true)
  self._baseInteractDialog:HideText()
  local dialog
  if self._state == 1 then
    LogInfo("BaseSceneController", "跳转主线副本选择")
    dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  elseif self._state == 2 then
    LogInfo("BaseSceneController", "跳转抽卡")
    local csend = LuaNetManager.CreateProtocol("protocol.card.crefreshcardui")
    csend:Send()
    if not NekoData.BehaviorManager.BM_Game:IsFirstGachaEnd() then
      local csend = LuaNetManager.CreateProtocol("protocol.card.cnewdrawcard")
      csend:Send()
    else
      dialog = DialogManager.CreateSingletonDialog("gacha.gachamaindialog")
    end
  elseif self._state == 3 then
    dialog = DialogManager.CreateSingletonDialog("task.taskmaindialog")
  elseif self._state == 5 then
    local csend = LuaNetManager.CreateProtocol("protocol.party.copenparty")
    if csend then
      csend:Send()
    end
  elseif self._state == 6 then
    dialog = DialogManager.CreateSingletonDialog("equip.bagdialog")
  elseif self._state == 8 then
    dialog = DialogManager.CreateSingletonDialog("equip.bagdialog")
  elseif self._state == 9 then
    dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
    if not dialog then
      dialog = DialogManager.CreateSingletonDialog("character.basecharacterlistalldialog")
    end
  elseif self._state == 10 then
    dialog = DialogManager.CreateSingletonDialog("tujian.tujiandialog")
  end
  if dialog then
    dialog:Init(self)
  end
end

local function MoveCamera(self, xOffset)
  self._baseSceneController:MoveCamera(self._farClipPlaneWorldWidth * self._farClipPlaneWidthScale * xScreenOffset / self._farClipPlaneScreenWidth, 0, 0)
end

local function HandleGuideStoryEnd(self, notification)
  local storyId = notification.userInfo
  if storyId and storyId ~= 0 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(41) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(41)
    elseif self._checkResonanceGuide then
      self._checkResonanceGuide = false
      local dialog = DialogManager.GetDialog("base.baseinteractdialog")
      if dialog then
        dialog:ClickChar1Chat()
      end
    end
  end
end

local function HandleHandleStage(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 31 then
    local stage = userInfo.stageRefCountTable[1]
    if 0 < stage then
      self._goGuide = true
      LuaNotificationCenter.AddObserver(self, HandleGuideStoryEnd, Common.n_GuideStoryEnd, nil)
      self._checkResonanceGuide = true
      self._baseMainFSM:SetNumber("storyId", 2006)
    end
  end
end

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 22 or guideId == 24 or guideId == 40 or guideId == 41 or guideId == 42 or guideId == 43 or guideId == 26 or guideId == 23 or guideId == 47 or guideId == 49 then
    if notification.userInfo.guideStatus == "Start" then
      local dialog = DialogManager.GetDialog("base.baseinteractdialog")
      if dialog then
        dialog:SetDragEnable(false)
      end
      if guideId == 40 then
        self._baseMainFSM:SetNumber("storyId", 2003)
      elseif guideId == 41 then
        LuaNotificationCenter.AddObserver(self, HandleGuideStoryEnd, Common.n_GuideStoryEnd, nil)
        self._baseMainFSM:SetNumber("storyId", 2005)
      elseif guideId == 42 then
        self._baseMainFSM:SetNumber("storyId", 2004)
      end
    else
      local dialog = DialogManager.GetDialog("base.baseinteractdialog")
      if dialog then
        dialog:SetDragEnable(true)
      end
    end
  end
end

function BaseSceneController:Ctor(sceneRef)
  BaseSceneController.super.Ctor(self, sceneRef)
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

local function DrageSceneConfigChangedCallback(self)
  local camera = self._sceneRef:GetCamera()
  local farClipPlane = camera.farClipPlane
  local startX, startY, startZ = GlobalCameras.ViewToWorldPoint("Main", 0, 0, farClipPlane)
  local endX, endY, endZ = GlobalCameras.ViewToWorldPoint("Main", 1, 0, farClipPlane)
  self._farClipPlaneWorldWidth = endX - startX
  startX, startY = GlobalCameras.viewToScreenPoint("Main", 0, 0, farClipPlane)
  endX, endY = GlobalCameras.viewToScreenPoint("Main", 1, 0, farClipPlane)
  self._farClipPlaneScreenWidth = endX - startX
  self._farClipPlaneWidthScale = self._dragSceneConfig.SpeedScaleX
  self._minX = self._dragSceneConfig.MinX
  self._maxX = self._dragSceneConfig.MaxX
  self._inertiaTime = self._dragSceneConfig.InertiaTime
end

function BaseSceneController:Init()
  BaseSceneController.super.Init(self)
  LuaAudioManager.PlayBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
  local baseInteractDialog = DialogManager.CreateSingletonDialog("base.baseinteractdialog")
  if baseInteractDialog then
    baseInteractDialog:Init(self)
    self._baseInteractDialog = baseInteractDialog
  end
  local dialog = DialogManager.CreateSingletonDialog("base.basemainui")
  if dialog then
    dialog:Init(self)
  end
  RedDotManager.CheckRedDotOnLogin()
  StateEventTriggerHelper.AddAnimationEventListener(self._sceneRef:GetCameraAnimator().gameObject, "CameraFocus", OnAnimationEvent, self)
  local camera = self._sceneRef:GetCamera()
  self._dragSceneConfig = DragSceneConfig.GetDragSceneConfig(camera.gameObject)
  if self._dragSceneConfig ~= nil then
    self._dragSceneConfig:SetConfigChangedCallback(DrageSceneConfigChangedCallback, self)
    DrageSceneConfigChangedCallback(self)
    self._enableDrag = true
  else
    self._enableDrag = false
  end
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, HandleHandleStage, Common.n_HandleStage, nil)
  local stargGuideInfo = {
    [31] = 1
  }
  LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, stargGuideInfo)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSingleDialogClose, Common.n_SingletonDialogDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.SetChar, Common.n_OnSChooseBackGround, nil)
  self:SetChar()
  self:SetBaseCharActive(true)
end

function BaseSceneController:SetChar()
  if self._char then
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._char)
    self._char = nil
  end
  local roleId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundRole
  local skinId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundSkin
  local assetBundleName, assetName
  if roleId == 0 then
    local CPosterGirlNpc = BeanManager.GetTableByName("welfare.cpostergirlnpc")
    local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
    local shapRecorder = CNpcShape:GetRecorder(aiLinNaRecorder.shapeId)
    assetBundleName = shapRecorder.assetBundleName
    assetName = shapRecorder.prefabName
  else
    local fashionData = CSkin:GetRecorder(skinId)
    local shapeId = fashionData.shapeID
    local shapRecorder = CNpcShape:GetRecorder(shapeId)
    assetBundleName = shapRecorder.assetBundleName
    assetName = shapRecorder.prefabName
  end
  self._char = PrefabLoader.LoadAndInstantiatePrefab(assetBundleName, assetName)
  TransformStaticFunctions.SetParent(self._char.transform, self._sceneRef._char_Point.transform)
  self:RefrashCharBubble()
  if roleId ~= 0 then
    TransformStaticFunctions.SetLocalScale(self._sceneRef._char_Point, -1, 1, 1)
  else
    TransformStaticFunctions.SetLocalScale(self._sceneRef._char_Point, 1, 1, 1)
  end
end

function BaseSceneController:RefrashCharBubble()
  self:GetChar001forbaseHeadBubble():SetActive(CS.UnityEngine.PlayerPrefs.HasKey("FirstUnlockSignBoard"))
end

function BaseSceneController:SetBaseMainFSM()
  if LuaUpdateManager.HasLatestAppVersion() then
    local today = tonumber(os.date("%j"))
    if NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.OpenUpdateJumpStoreDialog) ~= today then
      NekoData.BehaviorManager.BM_Game:SetLocalCache(DataCommon.LocalCache.OpenUpdateJumpStoreDialog, today)
      DialogManager.CreateSingletonDialog("login.updatejumpstoredialog")
    end
  end
  self._baseMainFSM = BaseMainFSM.Create()
  self._baseMainFSM:Init()
  self._baseMainFSM:SetStateEnterCallBack(self.OnStateEnter, self)
  self._baseMainFSM:SetStateExitCallBack(self.OnStateExit, self)
  self._baseMainFSM:SetBoolean("toNormal", true)
  if self._startFSM then
    local lastFloorId = NekoData.BehaviorManager.BM_Game:GetLastFloorId()
    local storyMirrorParam = {
      CGuideConditionconfig:GetRecorder(19).parm[1],
      CGuideConditionconfig:GetRecorder(19).parm[2],
      CGuideConditionconfig:GetRecorder(19).parm[3]
    }
    local PopTipsStatusType = {NotGet = 1, Got = 0}
    if NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.mirror_1) ~= 1 and NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(tonumber(storyMirrorParam[2])) == tonumber(storyMirrorParam[3]) then
      if not DialogManager.GetDialog("loadingdialog") then
        self._baseMainFSM:SetNumber("storyId", 2001)
        self._baseMainFSM:SetNumber("startDialogId", 1)
        self._startFSM = false
      end
    elseif NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.GUIDE_2007) == 0 then
      if not DialogManager.GetDialog("loadingdialog") then
        self._baseMainFSM:SetNumber("storyId", 2007)
        self._baseMainFSM:SetNumber("startDialogId", 1)
        self._startFSM = false
      end
    elseif NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.GUIDE_2008) ~= 1 and lastFloorId == tonumber(CVarConfig:GetRecorder(40).Value) then
      if not DialogManager.GetDialog("loadingdialog") then
        self._baseMainFSM:SetNumber("storyId", 2008)
        self._baseMainFSM:SetNumber("startDialogId", 1)
        self._startFSM = false
      end
    elseif NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.GUIDE_2009) == 0 then
      if not DialogManager.GetDialog("loadingdialog") then
        self._baseMainFSM:SetNumber("storyId", 2009)
        self._baseMainFSM:SetNumber("startDialogId", 1)
        self._startFSM = false
      end
    elseif NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.GUIDE_2010) ~= 1 and lastFloorId == tonumber(CVarConfig:GetRecorder(49).Value) then
      if not DialogManager.GetDialog("loadingdialog") then
        self._baseMainFSM:SetNumber("storyId", 2010)
        self._baseMainFSM:SetNumber("startDialogId", 1)
        self._startFSM = false
      end
    elseif NekoData.BehaviorManager.BM_Activity:GetPopTipsStatusWithActivityId(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfareSignAwardActivityId) == PopTipsStatusType.NotGet then
      if not DialogManager.GetDialog("loadingdialog") then
        self._baseMainFSM:SetNumber("storyId", DataCommon.ReturnWelfarePopTips)
        self._startFSM = false
      end
    else
      self._baseMainFSM:SetNumber("startDialogId", 1)
      self._startFSM = false
    end
  end
end

function BaseSceneController:GetSceneTextGameObjectTable()
  return self._sceneRef._sceneTextGameObjectTable
end

function BaseSceneController:OnDestroy()
  self._baseMainFSM = nil
  BaseSceneController.super.OnDestroy(self)
  LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
    [31] = 1
  })
  LuaNotificationCenter.RemoveObserver(self)
end

local function IsInBlock(self)
end

local function InertiaMoveUpdate(self)
end

local function BlockMoveUpdate(self)
end

function BaseSceneController:Update(deltaTime, unscaleDeltaTime)
  BaseSceneController.super.Update(self, deltaTime, unscaleDeltaTime)
  if self._baseMainFSM then
    self._baseMainFSM:Update()
    require("logic.fsm.basemainfsm." .. string.lower(self._baseMainFSM:GetCurrentState())).Update(self)
  end
  if self._baseMainFSM and not self._baseMainFSM:GetParameter("toAccount") and NekoData.BehaviorManager.BM_Game:GetTip() == 5 and not self._errorReturn then
    self._errorReturn = true
  end
end

function BaseSceneController:OnStateEnter(currentState, lastState)
  require("logic.fsm.basemainfsm." .. string.lower(currentState)).OnEnter(self, lastState)
end

function BaseSceneController:OnStateExit(currentState, nextState)
  require("logic.fsm.basemainfsm." .. string.lower(currentState)).OnExit(self, nextState)
end

function BaseSceneController:GetCamera()
  return self._sceneRef:GetCamera()
end

function BaseSceneController:GetCameraTransform()
  return self._sceneRef:GetCameraTransform()
end

function BaseSceneController:MoveCamera(xScreenOffset)
  if self._enableDrag == false then
    return
  end
  local xDistance = self._farClipPlaneWorldWidth * self._farClipPlaneWidthScale * xScreenOffset / self._farClipPlaneScreenWidth
  local startTransform = self._sceneRef._cameraFollowPoint.transform
  local resultPosX = startTransform.position.x + xDistance
  if resultPosX < self._minX then
    resultPosX = self._minX
  elseif resultPosX > self._maxX then
    resultPosX = self._maxX
  end
  xDistance = resultPosX - startTransform.position.x
  self._sceneRef._cameraFollowPoint.transform:Translate(xDistance, 0, 0, CS.UnityEngine.Space.World)
  return true
end

function BaseSceneController:SetCameraPos(pos)
end

function BaseSceneController:SetCameraAnimatorState(state)
  if state == 0 then
    ShowBaseMainUI(self)
    self._sceneRef:GetCinemachiesAnimator():SetBool("isOpenedDialog", false)
    self._sceneRef:GetCameraAnimator():SetBool("isOpenedDialog", false)
    self._baseInteractDialog:ShowText()
  end
  if state ~= 4 then
    if state == 2 then
      if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha) then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100137)
        return
      end
    elseif state == 3 then
      if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_MainLine) then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100139)
        return
      end
    elseif state == 5 and not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Guild) then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100294)
      return
    end
    self._state = state
    self._sceneRef:GetCinemachiesAnimator():SetInteger("Target", state)
    self._sceneRef:GetCameraAnimator():SetInteger("Target", state)
    self._baseInteractDialog:ShowText()
    self:ResetJumpValue()
  end
end

function BaseSceneController:SetStateNotShowUI(state)
  self._sceneRef:GetCinemachiesAnimator():SetBool("isOpenedDialog", false)
  self._sceneRef:GetCameraAnimator():SetBool("isOpenedDialog", false)
end

function BaseSceneController:OnTriggerBehaviourPlay(doubleValue, longValue, stringValue, objectValue)
  if stringValue == "StartNPCChat" then
    CS.PixelNeko.P1.TimeLine.TimelineManager.Pause(self._timeline)
    self._npcChatId = longValue
    DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(longValue, false, tonumber(doubleValue))
  end
end

function BaseSceneController:OnNPCChatEnd(notification)
  if notification.userInfo == self._npcChatId then
    self._npcChatId = 0
    CS.PixelNeko.P1.TimeLine.TimelineManager.Resume(self._timeline)
  end
end

function BaseSceneController:CreateTimeline(storyId)
  self._timeline = CS.PixelNeko.P1.TimeLine.TimelineManager.CreateTimeLineSync(StoryTimelineTable:GetRecorder(storyId).AssetBundle, StoryTimelineTable:GetRecorder(storyId).AssetName, self._sceneRef._story)
  CS.PixelNeko.P1.TimeLine.EventTriggerHelper.AddTriggerBehaviourPlayListener(self._timeline, self.OnTriggerBehaviourPlay, self)
end

function BaseSceneController:SetJumpValue(jumpValue)
  self._sceneRef:GetCinemachiesAnimator():SetInteger("JumpValue", jumpValue)
end

function BaseSceneController:ResetJumpValue()
  self._sceneRef:GetCinemachiesAnimator():SetInteger("JumpValue", 0)
end

function BaseSceneController:GetChar001forbase()
  return self._sceneRef._char_001forbase
end

function BaseSceneController:GetChar013forbase()
  return self._sceneRef._char_013forbase
end

function BaseSceneController:GetChar001forbaseHeadBubble()
  return self._sceneRef._char_001forbase_head_bubble
end

function BaseSceneController:SetBaseCharActive(flag)
  self:GetChar001forbase():SetActive(flag)
  if flag and NekoData.BehaviorManager.BM_Guide:HasFinished(15) then
    self:GetChar013forbase():SetActive(true)
  else
    self:GetChar013forbase():SetActive(false)
  end
end

function BaseSceneController:OnSingleDialogClose()
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function BaseSceneController:GetBuildingSizeAndPos(nodePath)
  if nodePath then
    local nodeObject = TransformStaticFunctions.GetChild(self._sceneRef._rootGameObject, nodePath)
    local posMin = BoxColiderStaticFunctions.GetBoundsMin(nodeObject)
    local minScreenPos_x, minScreenPos_y = UIManager.WorldToScreenPointInMargin("Main", posMin.x, posMin.y, posMin.z)
    local minLocalPos_x, minLocalPos_y = UIManager.ScreenPointToLocalPointInRectangle(nil, minScreenPos_x, minScreenPos_y)
    local posMax = BoxColiderStaticFunctions.GetBoundsMax(nodeObject)
    local maxScreenPos_x, maxScreenPos_y = UIManager.WorldToScreenPointInMargin("Main", posMax.x, posMax.y, posMax.z)
    local maxLocalPos_x, maxLocalPos_y = UIManager.ScreenPointToLocalPointInRectangle(nil, maxScreenPos_x, maxScreenPos_y)
    local width = math.abs(maxLocalPos_x - minLocalPos_x)
    local height = math.abs(maxLocalPos_y - minLocalPos_y)
    local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(nil, UIManager.WorldToScreenPointInMargin("Main", BoxColiderStaticFunctions.GetBoundsCenter(nodeObject)))
    return {
      width = width,
      height = height,
      posX = posX,
      posY = posY
    }
  end
end

function BaseSceneController:ForgerPlayAnimation()
  local len = #ForgerAnimatorType
  local key = math.random(1, len)
  self:GetChar013forbase():GetComponent("Animator"):SetTrigger(ForgerAnimatorType[key])
end

return BaseSceneController
