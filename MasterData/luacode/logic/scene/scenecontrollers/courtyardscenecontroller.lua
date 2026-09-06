local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local ZoomSceneConfig = CS.PixelNeko.P1.Config.ZoomSceneConfig
local BoxColiderConfig = CS.PixelNeko.P1.Config.BoxColiderConfig
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local BoxColiderStaticFunctions = CS.PixelNeko.Lua.BoxColiderStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local YardSceneCamera = CS.PixelNeko.P1.Camera.YardSceneCamera
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local YardSceneHelper = CS.PixelNeko.P1.Scene.YardSceneHelper
local YardCharacter = require("logic.manager.experimental.types.yardcharacter")
local Light = require("logic.manager.experimental.types.light")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")
local HideDialogIBtnGuide = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(113).Value) == 0
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local CharacterSize_z = 0.1
local CourtyardSceneController = class("CourtyardSceneController", SceneController)

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 16 or guideId == 55 or guideId == 56 or guideId == 58 or guideId == 59 then
    if notification.userInfo.guideStatus == "Start" then
      local dialog = DialogManager.GetDialog("courtyard.interactdialog")
      if dialog then
        dialog:SetDragEnable(false)
      end
    else
      local dialog = DialogManager.GetDialog("courtyard.interactdialog")
      if dialog then
        dialog:SetDragEnable(true)
      end
    end
  end
end

local function GetLightPointIndex(self)
  local index
  while table.nums(self._lights) < self._lightMaxNum do
    if not self._lightPoints[1] then
      index = 1
      break
    else
      index = math.random(2, self._lightMaxNum)
      if not self._lightPoints[index] then
        break
      end
    end
  end
  return index
end

function CourtyardSceneController:Ctor(sceneRef)
  CourtyardSceneController.super.Ctor(self, sceneRef)
  self._yardCharacters = {}
  self._lights = {}
  self._lightEffectGameObjects = {}
  self._lightPoints = {}
  self._bmBuildings = {}
  self._bmBuildings[DataCommon.MagicTree] = NekoData.BehaviorManager.BM_MagicTree
  self._bmBuildings[DataCommon.Explore] = NekoData.BehaviorManager.BM_Explore
  self._bmBuildings[DataCommon.Firefly] = NekoData.BehaviorManager.BM_Firefly
  self._bmBuildings[DataCommon.Alchemy] = NekoData.BehaviorManager.BM_Alchemy
  self._bmBuildings[DataCommon.Cabin] = NekoData.BehaviorManager.BM_Cabin
  self._bmBuildings[DataCommon.TrainCamp] = NekoData.BehaviorManager.BM_TrainCamp
  self._bmBuildings[DataCommon.YardMusic] = NekoData.BehaviorManager.BM_YardMusic
  self._yardSceneCamera = nil
  self._canSetWorkState = true
  self._state = 0
  if not HideDialogIBtnGuide then
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(DataCommon.LocalTips.GuideOpenInstructionDialog_Magictree)
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(DataCommon.LocalTips.GuideOpenInstructionDialog_Cabin)
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(DataCommon.LocalTips.GuideOpenInstructionDialog_TrainCamp)
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(DataCommon.LocalTips.GuideOpenInstructionDialog_Alchemy)
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(DataCommon.LocalTips.GuideOpenInstructionDialog_Explore)
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(DataCommon.LocalTips.GuideOpenInstructionDialog_Firefly)
  end
end

function CourtyardSceneController:Init()
  CourtyardSceneController.super.Init(self)
  local musicId = NekoData.BehaviorManager.BM_YardMusic:GetPlayingId()
  if musicId ~= 0 then
    local record = CAudioPlayerCell:GetRecorder(musicId)
    LuaAudioManager.PlayBGM(record.audioID)
  else
    LuaAudioManager.PlayBGM(242)
  end
  for k, v in pairs(self._sceneRef:GetBuildingScenes()) do
    local bm_building = self._bmBuildings[k]
    local level = bm_building:GetLevel()
    if k ~= DataCommon.MagicTree and bm_building and 0 < level then
      AnimationHelper.SetAnimatorInteger2(v, "state", 1)
    end
    if 0 < level then
      local buildingLvRecord = CCourtyardLvUpCfg:GetRecorder(k + level)
      if buildingLvRecord then
        if buildingLvRecord.houseState ~= 0 then
          AnimationHelper.SetAnimatorInteger2(v, "level", buildingLvRecord.houseState)
        end
      else
        LogErrorFormat("CourtyardSceneController", "Can not find record by buildingLevel: %s", k + level)
      end
    end
    StateEventTriggerHelper.AddStateExitListener(v, self.OnAnimationStateExitEvent, self)
  end
  for k, v in pairs(self._bmBuildings) do
    local roleList = v:GetDispatchRoles()
    if 0 < #roleList then
      if not self._yardCharacters[k] then
        self._yardCharacters[k] = {}
      end
      local characterPoint = self._sceneRef:GetCharacterPoints()[k]
      local downColliderObject = TransformStaticFunctions.GetChild(characterPoint, "Bottom")
      local boundsMin = BoxColiderStaticFunctions.GetBoundsMin(downColliderObject)
      local boundsSize = BoxColiderStaticFunctions.GetBoundsSize(downColliderObject)
      local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / v:GetDispatchMaxRoleNum()
      local z = boundsMin.z + CharacterSize_z
      for i, roleKey in ipairs(roleList) do
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
        local yardCharacter = YardCharacter.Create(role:GetId(), "Yard")
        yardCharacter:CreatePlayer(characterPoint)
        yardCharacter:SetClickParam(tostring(k), roleKey)
        yardCharacter:InitZPosition(z)
        z = z + deltaZ
        yardCharacter:LoadBehavior()
        self._yardCharacters[k][roleKey] = yardCharacter
      end
    end
  end
  self._lightMaxNum = #self._sceneRef._glowsPoints
  for i = 1, self._lightMaxNum do
    self._lightPoints[i] = false
  end
  for k, v in pairs(NekoData.BehaviorManager.BM_Firefly:GetSceneLights()) do
    local light = Light.Create(v, k)
    local index = GetLightPointIndex(self)
    if index then
      self._lightPoints[index] = k
      light:CreatePlayer(self._sceneRef._glowsPoints[index])
      light:SetClickParam(k)
      self._lights[k] = light
    else
      LogErrorFormat("CourtyardSceneController", "SceneLights num error：=%s (The maximum quantity is = %s)", table.nums(NekoData.BehaviorManager.BM_Firefly:GetSceneLights()), self._lightMaxNum)
    end
  end
  for k, v in pairs(self._bmBuildings) do
    self:RefreshSceneWorkEffect(k)
  end
  DialogManager.CreateSingletonDialog("guide.blockclickdialog")
  local dialog = DialogManager.CreateSingletonDialog("courtyard.interactdialog")
  if dialog then
    dialog:Init(self)
  end
  dialog = DialogManager.CreateSingletonDialog("courtyard.yardmaindialog")
  if dialog then
    dialog:Init(self)
  end
  if 0 < NekoData.BehaviorManager.BM_YardMusic:GetLevel() then
    DialogManager.CreateSingletonDialog("yardmusic.playingmusicdialog")
  end
  self._defFOV = CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.GetFOV(self._sceneRef:GetCinemachineStart())
  self._zoomSceneConfig = ZoomSceneConfig.GetZoomSceneConfig(self._sceneRef:GetCinemachineStart().gameObject)
  self._minFOV = self._zoomSceneConfig.MinFOV
  self._maxFOV = self._zoomSceneConfig.MaxFOV
  local x, y
  x, y, self._boxColliderZ = BoxColiderStaticFunctions.GetSize(self._sceneRef._cameraBorder)
  self._boxColiderConfig = BoxColiderConfig.GetBoxColiderConfig(self._sceneRef._cameraBorder.gameObject)
  self._minBorder = self._boxColiderConfig.BorderMin
  self._maxBorder = self._boxColiderConfig.BorderMax
  self._yardSceneCamera = YardSceneCamera.GetYardSceneCamera(self._sceneRef:GetMainCamera().gameObject)
  if self._yardSceneCamera then
    self._yardSceneCamera:SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  StateEventTriggerHelper.AddStateEnterListener(self._sceneRef._cinemachinesGameObject, self.OnAnimationEvent, self)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters()
  end, Common.n_RefreshCourtYard, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters(DataCommon.MagicTree)
  end, Common.n_RefreshMagicTreeTask, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters(DataCommon.MagicTree)
  end, Common.n_RefreshMagicTree, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters(DataCommon.Explore)
  end, Common.n_RefreshExploreSlot, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters(DataCommon.Explore)
  end, Common.n_RefreshAllExploreSlots, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters(DataCommon.Firefly)
  end, Common.n_RefreshFirefly, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefreshCharacters(DataCommon.Alchemy)
  end, Common.n_AlchemyRoleChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshBuildingWorkState, Common.n_BuildingWorkStateChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshBuildingScene, Common.n_BuildingUnlock, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshBuildingSceneModel, Common.n_BuildingLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLightAdd, Common.n_LightAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLightRemove, Common.n_LightRemove, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

function CourtyardSceneController:CameraTransformChangedChangedCallback()
  LuaNotificationCenter.PostNotification(Common.n_CameraTransformChanged, CourtyardSceneController, self)
end

function CourtyardSceneController:SetYardFSM()
  self._yardFSM = YardFSM.Create()
  self._yardFSM:Init()
  self._yardFSM:SetStateEnterCallBack(self.OnStateEnter, self)
  self._yardFSM:SetStateExitCallBack(self.OnStateExit, self)
  local sign = NekoData.BehaviorManager.BM_Game:GetFastMenuSignFromCourtyard()
  if sign then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard(nil)
    self:SetCameraAnimatorState(sign)
  end
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
end

function CourtyardSceneController:EnterYard()
  self:OnRefreshCharacters()
end

function CourtyardSceneController:OnRefreshCharacters(buildingId)
  if not buildingId then
    for buildingType, yardCharacters in pairs(self._yardCharacters) do
      for roleKey, yardCharacter in pairs(yardCharacters) do
        yardCharacter:Destroy()
      end
      self._yardCharacters[buildingType] = nil
    end
    for k, v in pairs(self._bmBuildings) do
      local roleList = v:GetDispatchRoles()
      if 0 < #roleList then
        if not self._yardCharacters[k] then
          self._yardCharacters[k] = {}
        end
        local characterPoint = self._sceneRef:GetCharacterPoints()[k]
        local downColliderObject = TransformStaticFunctions.GetChild(characterPoint, "Bottom")
        local boundsMin = BoxColiderStaticFunctions.GetBoundsMin(downColliderObject)
        local boundsSize = BoxColiderStaticFunctions.GetBoundsSize(downColliderObject)
        local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / v:GetDispatchMaxRoleNum()
        local z = boundsMin.z + CharacterSize_z
        for i, roleKey in ipairs(roleList) do
          local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
          local yardCharacter = YardCharacter.Create(role:GetId(), "Yard")
          yardCharacter:CreatePlayer(characterPoint)
          yardCharacter:SetClickParam(tostring(k), roleKey)
          yardCharacter:InitZPosition(z)
          z = z + deltaZ
          yardCharacter:LoadBehavior()
          self._yardCharacters[k][roleKey] = yardCharacter
        end
      end
    end
  else
    local bm_building = self._bmBuildings[buildingId]
    local roleList = bm_building:GetDispatchRoles()
    local yardCharacters = self._yardCharacters[buildingId]
    local num = #roleList
    local tag = false
    if yardCharacters and num ~= table.nums(yardCharacters) or yardCharacters == nil and 0 < num then
      tag = true
    elseif yardCharacters and num == table.nums(yardCharacters) then
      for i, v in ipairs(roleList) do
        if not yardCharacters[v] then
          tag = true
        end
      end
    end
    if tag then
      if yardCharacters then
        for roleKey, yardCharacter in pairs(yardCharacters) do
          yardCharacter:Destroy()
          yardCharacters[roleKey] = nil
        end
      end
      if 0 < num then
        if not self._yardCharacters[buildingId] then
          self._yardCharacters[buildingId] = {}
        end
        local characterPoint = self._sceneRef:GetCharacterPoints()[buildingId]
        local downColliderObject = TransformStaticFunctions.GetChild(characterPoint, "Bottom")
        local boundsMin = BoxColiderStaticFunctions.GetBoundsMin(downColliderObject)
        local boundsSize = BoxColiderStaticFunctions.GetBoundsSize(downColliderObject)
        local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / bm_building:GetDispatchMaxRoleNum()
        local z = boundsMin.z + CharacterSize_z
        for i, roleKey in ipairs(roleList) do
          local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
          local yardCharacter = YardCharacter.Create(role:GetId(), "Yard")
          yardCharacter:CreatePlayer(characterPoint)
          yardCharacter:SetClickParam(tostring(buildingId), roleKey)
          yardCharacter:InitZPosition(z)
          z = z + deltaZ
          yardCharacter:LoadBehavior()
          self._yardCharacters[buildingId][roleKey] = yardCharacter
        end
      end
    end
    if buildingId == DataCommon.Firefly then
      local num = table.nums(self._lights)
      local newNum = table.nums(NekoData.BehaviorManager.BM_Firefly:GetSceneLights())
      if num ~= newNum then
        for i = 1, self._lightMaxNum do
          self._lightPoints[i] = false
        end
        for k, v in pairs(self._lights) do
          self._lights[k]:Destroy()
          self._lights[k] = nil
        end
        for k, v in pairs(NekoData.BehaviorManager.BM_Firefly:GetSceneLights()) do
          local light = Light.Create(v, k)
          local index = GetLightPointIndex(self)
          if index then
            self._lightPoints[index] = k
            light:CreatePlayer(self._sceneRef._glowsPoints[index])
            light:SetClickParam(k)
            self._lights[k] = light
          else
            LogErrorFormat("CourtyardSceneController", "SceneLights num error：=%s (The maximum quantity is = %s)", table.nums(NekoData.BehaviorManager.BM_Firefly:GetSceneLights()), self._lightMaxNum)
          end
        end
      end
    end
  end
end

function CourtyardSceneController:OnRefreshBuildingWorkState(notification)
  self:RefreshSceneWorkEffect(notification.userInfo.buildingId)
end

function CourtyardSceneController:RefreshSceneWorkEffect(buildingId)
  local bm_building = self._bmBuildings[buildingId]
  if bm_building and bm_building:GetLevel() > 0 and type(self._canSetWorkState) == "boolean" then
    local tag = false
    if buildingId == DataCommon.MagicTree then
      tag = 0 < bm_building:GetWorkState()
    elseif buildingId == DataCommon.Explore then
      tag = 0 < bm_building:GetWorkState()
    elseif buildingId == DataCommon.Firefly then
      tag = bm_building:GetWorkState() ~= -1
    elseif buildingId == DataCommon.Alchemy or buildingId == DataCommon.Cabin then
      tag = true
    end
    if tag then
      AnimationHelper.SetAnimatorInteger2(self._sceneRef:GetBuildingScenes()[buildingId], "work", 1)
    else
      AnimationHelper.SetAnimatorInteger2(self._sceneRef:GetBuildingScenes()[buildingId], "work", 0)
    end
  end
end

function CourtyardSceneController:OnRefreshBuildingScene(notification)
  LogInfoFormat("CourtyardSceneController", "------ buildingId = %s -------", notification.userInfo.buildingId)
  DialogManager.GetGroup("Modal"):CloseAllDialog()
  local buildingId = notification.userInfo.buildingId
  local buildingScene = self._sceneRef:GetBuildingScenes()[buildingId]
  local bm_building = self._bmBuildings[buildingId]
  if buildingId ~= DataCommon.MagicTree then
    self._canSetWorkState = buildingId
    AnimationHelper.SetAnimatorInteger2(buildingScene, "state", 1)
  end
end

function CourtyardSceneController:OnRefreshBuildingSceneModel(notification)
  local buildingId = notification.userInfo.buildingId
  local buildingScene = self._sceneRef:GetBuildingScenes()[buildingId]
  local bm_building = self._bmBuildings[buildingId]
  local level = bm_building:GetLevel()
  if 0 < level then
    local buildingLvRecord = CCourtyardLvUpCfg:GetRecorder(buildingId + level)
    if buildingLvRecord then
      if buildingLvRecord.houseState ~= 0 then
        AnimationHelper.SetAnimatorInteger2(buildingScene, "level", buildingLvRecord.houseState)
      end
    else
      LogErrorFormat("CourtyardSceneController", "Can not find record by buildingLevel: %s", buildingId + level)
    end
  end
end

function CourtyardSceneController:OnLightAdd(notification)
  local protocol = notification.userInfo
  local key = protocol.light.key
  if not self._lights[key] then
    local light = Light.Create(protocol.light.itemId, key)
    local index = GetLightPointIndex(self)
    if index then
      self._lightPoints[index] = key
      light:CreatePlayer(self._sceneRef._glowsPoints[index])
      light:SetClickParam(key)
      self._lights[key] = light
    else
      LogErrorFormat("CourtyardSceneController", "SceneLights num error：=%s (The maximum quantity is = %s)", table.nums(NekoData.BehaviorManager.BM_Firefly:GetSceneLights()), self._lightMaxNum)
    end
  end
end

function CourtyardSceneController:OnLightRemove(notification)
  local protocol = notification.userInfo
  if self._lights[protocol.light.key] then
    self._lights[protocol.light.key]:Destroy()
    local assetBundleName, assetName = EffectUtil.GetAssetBundleNameAndAssetName(1030)
    local gameObject = YardSceneHelper.CreateEffect(assetBundleName, assetName, self._sceneRef._magicTreeCollectLightEffect)
    table.insert(self._lightEffectGameObjects, gameObject)
    self._lights[protocol.light.key] = nil
    for k, v in pairs(self._lightPoints) do
      if v == protocol.light.key then
        self._lightPoints[k] = nil
        break
      end
    end
  end
end

function CourtyardSceneController:OnDestroy()
  for buildingType, yardCharacters in pairs(self._yardCharacters) do
    for roleKey, yardCharacter in pairs(yardCharacters) do
      yardCharacter:Destroy()
    end
  end
  for k, v in pairs(self._lights) do
    self._lights[k]:Destroy()
    self._lights[k] = nil
  end
  if self._yardSceneCamera then
    self._yardSceneCamera:SetTransformChangedCallback(nil, self)
  end
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("courtyard.yardmaindialog")
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  DialogManager.DestroySingletonDialog("yardmusic.playingmusicdialog")
  DialogManager.DestroySingletonDialog("yardmusic.yardmusicdialog")
end

function CourtyardSceneController:OnAnimationEvent(handle, stateName, normalizedTime)
  self._stateName = stateName
  if stateName ~= "Open" and stateName ~= "TreeOpen" then
    return
  end
  self._sceneRef:GetCinemachiesAnimator():SetBool("isOpenedDialog", true)
  self._sceneRef:GetMainCameraAnimator():SetBool("isOpenedDialog", true)
  local dialog
  if self._state == 0 then
  elseif self._state == 1 then
    LogInfo("CourtyardSceneController", "跳转魔法树")
    dialog = DialogManager.CreateSingletonDialog("magictree.magictreedialog")
  elseif self._state == 2 then
    LogInfo("CourtyardSceneController", "跳转探索")
    dialog = DialogManager.CreateSingletonDialog("explore.exploredialog")
  elseif self._state == 3 then
    LogInfo("CourtyardSceneController", "跳转炼金所")
    dialog = DialogManager.CreateSingletonDialog("courtyard.interactmodaldialog")
    dialog:Init(self)
    dialog = DialogManager.CreateSingletonDialog("alchemy.alchemydialog")
  elseif self._state == 5 then
    LogInfo("CourtyardSceneController", "跳转萤火灯台")
    dialog = DialogManager.CreateSingletonDialog("firefly.fireflydialog")
  end
  if dialog then
    dialog:Init(self)
  end
end

function CourtyardSceneController:OnAnimationStateExitEvent(handler, stateName, normalizedTime)
  if stateName == "Open" then
    local buildingId = self._canSetWorkState
    self._canSetWorkState = true
    self:RefreshSceneWorkEffect(buildingId)
  end
end

function CourtyardSceneController:MoveCamera(xScreenOffset, yScreenOffset)
  local transform = self._sceneRef._cameraFollowPoint.transform
  transform:Translate(xScreenOffset, yScreenOffset, 0, CS.UnityEngine.Space.World)
end

function CourtyardSceneController:GetMainCamera()
  return self._sceneRef:GetMainCamera()
end

function CourtyardSceneController:SetCameraAnimatorState(state)
  if self._state ~= state then
    if state < 6 and self._yardFSM:GetParameter("sceneId") ~= 0 or 6 <= state and (self._state ~= 0 or DialogManager.GetDialog("yardmusic.yardmusicdialog")) then
      return
    end
    local lastState = self._state
    if state == 0 then
      DialogManager.DestroySingletonDialog("courtyard.interactmodaldialog")
      self._state = state
    elseif state == 1 then
      self._state = state
    elseif state == 2 then
      if 0 < NekoData.BehaviorManager.BM_Explore:GetLevel() then
        self._state = state
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
          CCourtyardLvUpCfg:GetRecorder(DataCommon.Explore + 1).openCondition
        })
      end
    elseif state == 3 then
      if 0 < NekoData.BehaviorManager.BM_Alchemy:GetLevel() then
        self._state = state
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
          CCourtyardLvUpCfg:GetRecorder(DataCommon.Alchemy + 1).openCondition
        })
      end
    elseif state == 4 then
      if 0 < NekoData.BehaviorManager.BM_YardMusic:GetLevel() then
        LogInfo("CourtyardSceneController", "跳转音乐播放器")
        DialogManager.CreateSingletonDialog("yardmusic.yardmusicdialog")
        local jsonStr = JSON.encode({eventName = "event", id = "18"})
        ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
          CCourtyardLvUpCfg:GetRecorder(DataCommon.YardMusic + 1).openCondition
        })
      end
    elseif state == 5 then
      if 0 < NekoData.BehaviorManager.BM_Firefly:GetLevel() then
        self._state = state
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
          CCourtyardLvUpCfg:GetRecorder(DataCommon.Firefly + 1).openCondition
        })
      end
    elseif state == 6 then
      if 0 < NekoData.BehaviorManager.BM_Cabin:GetLevel() then
        LogInfo("CourtyardSceneController", "跳转魔女小屋")
        self._yardFSM:SetNumber("sceneId", 30008)
        local jsonStr = JSON.encode({eventName = "event", id = "19"})
        ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
          CCourtyardLvUpCfg:GetRecorder(DataCommon.Cabin + 1).openCondition
        })
      end
    elseif state == 7 then
      if 0 < NekoData.BehaviorManager.BM_TrainCamp:GetLevel() then
        LogInfo("CourtyardSceneController", "跳转训练所")
        self._yardFSM:SetNumber("sceneId", 30013)
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
          CCourtyardLvUpCfg:GetRecorder(DataCommon.TrainCamp + 1).openCondition
        })
      end
    end
    if self._state ~= lastState then
      if self._state == 0 then
        self._sceneRef:GetCinemachiesAnimator():SetBool("isOpenedDialog", false)
        self._sceneRef:GetMainCameraAnimator():SetBool("isOpenedDialog", false)
      end
      self._sceneRef:GetCinemachiesAnimator():SetInteger("Target", state)
      self._sceneRef:GetMainCameraAnimator():SetInteger("Target", state)
    end
  end
end

function CourtyardSceneController:BeginZoomScene(scale)
  self:MoveCamera(0, 0)
  self._lastFOV = CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.GetFOV(self._sceneRef:GetCinemachineStart())
end

function CourtyardSceneController:ZoomScene(scale)
  local curFOV = self._lastFOV / scale
  if curFOV < self._minFOV then
    curFOV = self._minFOV
    BoxColiderStaticFunctions.SetSize(self._sceneRef._cameraBorder, self._maxBorder.x, self._maxBorder.y, self._boxColliderZ)
  elseif curFOV > self._maxFOV then
    curFOV = self._maxFOV
    BoxColiderStaticFunctions.SetSize(self._sceneRef._cameraBorder, self._minBorder.x, self._minBorder.y, self._boxColliderZ)
  else
    self._borderBoxColiderSizeTween:reset()
    self._borderBoxColiderSizeTween:update(curFOV - self._minFOV)
    BoxColiderStaticFunctions.SetSize(self._sceneRef._cameraBorder, self._borderBoxColiderSizeTween.subject.x, self._borderBoxColiderSizeTween.subject.y, self._boxColliderZ)
  end
  CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.SetFOV(self._sceneRef:GetCinemachineStart(), curFOV)
end

function CourtyardSceneController:GetBuildingSizeAndPos(buildingId)
  local buildingObject = self._sceneRef:GetBuildingScenes()[buildingId]
  local posMin = BoxColiderStaticFunctions.GetBoundsMin(buildingObject)
  local minScreenPos_x, minScreenPos_y = UIManager.WorldToScreenPointInMargin("Main", posMin.x, posMin.y, posMin.z)
  local minLocalPos_x, minLocalPos_y = UIManager.ScreenPointToLocalPointInRectangle(nil, minScreenPos_x, minScreenPos_y)
  local posMax = BoxColiderStaticFunctions.GetBoundsMax(buildingObject)
  local maxScreenPos_x, maxScreenPos_y = UIManager.WorldToScreenPointInMargin("Main", posMax.x, posMax.y, posMax.z)
  local maxLocalPos_x, maxLocalPos_y = UIManager.ScreenPointToLocalPointInRectangle(nil, maxScreenPos_x, maxScreenPos_y)
  local width = math.abs(maxLocalPos_x - minLocalPos_x)
  local height = math.abs(maxLocalPos_y - minLocalPos_y)
  local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(nil, UIManager.WorldToScreenPointInMargin("Main", BoxColiderStaticFunctions.GetBoundsCenter(buildingObject)))
  return {
    width = width,
    height = height,
    posX = posX,
    posY = posY
  }
end

function CourtyardSceneController:GetSizeAndPos(lightObject_1)
  local posMin = BoxColiderStaticFunctions.GetBoundsMin(lightObject_1)
  local minScreenPos_x, minScreenPos_y = UIManager.WorldToScreenPointInMargin("Main", posMin.x, posMin.y, posMin.z)
  local minLocalPos_x, minLocalPos_y = UIManager.ScreenPointToLocalPointInRectangle(nil, minScreenPos_x, minScreenPos_y)
  local posMax = BoxColiderStaticFunctions.GetBoundsMax(lightObject_1)
  local maxScreenPos_x, maxScreenPos_y = UIManager.WorldToScreenPointInMargin("Main", posMax.x, posMax.y, posMax.z)
  local maxLocalPos_x, maxLocalPos_y = UIManager.ScreenPointToLocalPointInRectangle(nil, maxScreenPos_x, maxScreenPos_y)
  local width = math.abs(maxLocalPos_x - minLocalPos_x)
  local height = math.abs(maxLocalPos_y - minLocalPos_y)
  local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(nil, UIManager.WorldToScreenPointInMargin("Main", BoxColiderStaticFunctions.GetBoundsCenter(lightObject_1)))
  return {
    width = width,
    height = height,
    posX = posX,
    posY = posY
  }
end

function CourtyardSceneController:Update(deltaTime, unscaleDeltaTime)
  CourtyardSceneController.super.Update(self, deltaTime, unscaleDeltaTime)
  if self._yardFSM then
    self._yardFSM:Update()
    require("logic.fsm.yardfsm." .. string.lower(self._yardFSM:GetCurrentState())).Update(self)
  end
end

function CourtyardSceneController:OnStateEnter(currentState, lastState)
  require("logic.fsm.yardfsm." .. string.lower(currentState)).OnEnter(self, lastState)
end

function CourtyardSceneController:OnStateExit(currentState, nextState)
  require("logic.fsm.yardfsm." .. string.lower(currentState)).OnExit(self, nextState)
end

return CourtyardSceneController
