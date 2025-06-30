-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/hexagonscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HexagonalBlock = require("logic.manager.experimental.types.hexagonalblock")
local CHexagonScene = (BeanManager.GetTableByName)("activity.chexagonscene")
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local CHexagonLandShape = (BeanManager.GetTableByName)("activity.chexagonlandshape")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local CSceneLightConfig = (BeanManager.GetTableByName)("scene.cscenelightconfig")
local SceneInfoTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CHhexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local YardSceneCamera = (((CS.PixelNeko).P1).Camera).YardSceneCamera
local DragSceneConfig = (((CS.PixelNeko).P1).Config).DragSceneConfig
local LightStaticFunctions = ((CS.PixelNeko).Lua).LightStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local SetDayNightLight = ((((CS.PixelNeko).P1).Render).DayNightSwitch).SetDayNightLight
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local GameObject = (CS.UnityEngine).GameObject
local MaterialStaticFunctions = ((CS.PixelNeko).Lua).MaterialStaticFunctions
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local SideLength = 0.4
local HexagonSceneController = class("HexagonSceneController", SceneController)
HexagonSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_0 , upvalues : HexagonSceneController
  ((HexagonSceneController.super).Ctor)(self, sceneRef)
  self._rippleEffects = {}
  self._mapData = {}
end

HexagonSceneController.Init = function(self)
  -- function num : 0_1 , upvalues : HexagonSceneController, _ENV, DragSceneConfig, CHexagonScene, SideLength, HexagonalBlock, CHhexagonFunction, YardSceneCamera
  ((HexagonSceneController.super).Init)(self)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)
  self._dragSceneConfig = (DragSceneConfig.GetDragSceneConfig)(((self._sceneRef)._mainCamera).gameObject)
  self._minX = (self._dragSceneConfig).MinX
  self._maxX = (self._dragSceneConfig).MaxX
  self._minZ = (self._dragSceneConfig).MinY
  self._maxZ = (self._dragSceneConfig).MaxY
  self._sceneRecorder = CHexagonScene:GetRecorder(9001)
  local origin = (string.split)((self._sceneRecorder).coordinate, ",")
  self._origin = {x = tonumber(origin[1]), y = tonumber(origin[2])}
  self._xOffset = SideLength * (math.cos)((math.rad)(30))
  self._yOffset = SideLength * (math.sin)((math.rad)(30))
  self._xUnit = SideLength * (math.cos)((math.rad)(30)) * 2
  self._yUnit = SideLength * 2 - SideLength * (math.sin)((math.rad)(30))
  local usefulArea = (string.split)((self._sceneRecorder).usefulArea, ";")
  local mapRange = (string.split)((self._sceneRecorder).range, ";")
  local leftDown = (string.split)(mapRange[1], ",")
  local rightUp = (string.split)(mapRange[2], ",")
  self._mapRange = {xmin = -99, xmax = 99, ymin = -99, ymax = 99}
  self._mapData = {}
  for x = (self._mapRange).xmin, (self._mapRange).xmax do
    -- DECOMPILER ERROR at PC133: Confused about usage of register: R10 in 'UnsetPending'

    (self._mapData)[x] = {}
    for y = (self._mapRange).ymin, (self._mapRange).ymax do
      -- DECOMPILER ERROR at PC142: Confused about usage of register: R14 in 'UnsetPending'

      ((self._mapData)[x])[y] = 0
    end
  end
  local constructions = (self._bm):GetConstructions()
  self._blocks = {}
  self._eventsIconData = {}
  for i,v in ipairs(constructions) do
    local block = (HexagonalBlock.Create)(v.ID)
    block:Init(v)
    block:SetCoordinateInformation({origin = self._origin, xOffset = self._xOffset, yOffset = self._yOffset, xUnit = self._xUnit, yUnit = self._yUnit})
    block:CreatGameObjectInstantiate((self._sceneRef)._blockParent)
    -- DECOMPILER ERROR at PC181: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self._blocks)[v.ID] = block
    local coordinates = block:GetCoordinates()
    for i,coordinate in ipairs(coordinates) do
      -- DECOMPILER ERROR at PC193: Confused about usage of register: R19 in 'UnsetPending'

      ((self._mapData)[coordinate.x])[coordinate.y] = v.ID
    end
    if v.canlvup ~= 1 then
      local temp = {Id = (v.event)[1], worldPos = block:GetEventIconWorldPos(), canLevelUp = #v.event <= 0, blockId = v.ID}
      ;
      (table.insert)(self._eventsIconData, temp)
      do
        if not self._mainLineBlockID then
          local recorder = CHhexagonFunction:GetRecorder((v.event)[1])
          if recorder.type == 1 or recorder.type == 2 then
            self._mainLineBlockID = v.ID
          end
        end
        -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  self:CreatWaterRippleEffect()
  self._interactDialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.interactdialog")
  ;
  (self._interactDialog):Init(self)
  self._dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitmaindialog")
  ;
  (self._dialog):Init(self)
  ;
  (self._dialog):UpdateConstructionEvent()
  self._sceneCamera = (YardSceneCamera.GetYardSceneCamera)(((self._sceneRef)._mainCamera).gameObject)
  if self._sceneCamera then
    (self._sceneCamera):SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  self:SetDayNightInfo()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateConstructionEvent, Common.n_SUpdateConstructionEvent, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSummerActivityEvent, Common.n_SummerActivityCancelBlockSelect, nil)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HexagonSceneController.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._sceneCamera then
    (self._sceneCamera):SetTransformChangedCallback(nil, self)
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.swimsuit.swimsuitmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.swimsuit.interactdialog")
end

HexagonSceneController.GetMainCamera = function(self)
  -- function num : 0_3
  return (self._sceneRef)._mainCamera
end

HexagonSceneController.GetBlocks = function(self)
  -- function num : 0_4
  return self._blocks
end

HexagonSceneController.GetEventsIconData = function(self)
  -- function num : 0_5
  return self._eventsIconData
end

HexagonSceneController.GetSelectId = function(self)
  -- function num : 0_6
  return self._selectBlockID
end

HexagonSceneController.MoveCamera = function(self, xScreenOffset, zScreenOffset)
  -- function num : 0_7 , upvalues : _ENV
  local transform = ((self._sceneRef)._cameraPoint).transform
  if (transform.position).x + xScreenOffset < self._minX then
    xScreenOffset = 0
  else
    if self._maxX < (transform.position).x + xScreenOffset then
      xScreenOffset = 0
    end
  end
  if (transform.position).z + zScreenOffset < self._minZ then
    zScreenOffset = 0
  else
    if self._maxZ < (transform.position).z + zScreenOffset then
      zScreenOffset = 0
    end
  end
  transform:Translate(xScreenOffset, 0, zScreenOffset, ((CS.UnityEngine).Space).World)
end

HexagonSceneController.SelectBlock = function(self, id)
  -- function num : 0_8
  if self._selectBlockID then
    ((self._blocks)[self._selectBlockID]):SetSelectState(false)
    self._selectBlockID = nil
  end
  self._selectBlockID = id
  local pos = ((self._blocks)[self._selectBlockID]):GetWorldPos()
  self:MoveCameraToBlock(id)
  ;
  ((self._blocks)[self._selectBlockID]):SetSelectState(true)
end

HexagonSceneController.CancleSelectBlock = function(self)
  -- function num : 0_9
  if self._selectBlockID then
    ((self._blocks)[self._selectBlockID]):SetSelectState(false)
    self._selectBlockID = nil
  end
end

HexagonSceneController.MoveCameraToBlock = function(self, ID)
  -- function num : 0_10
  local pos = ((self._blocks)[ID]):GetWorldPos()
  if pos.x < self._minX then
    pos.x = self._minX
  else
    if self._maxX < pos.x then
      pos.x = self._maxX
    end
  end
  if pos.z < self._minZ then
    pos.z = self._minZ
  else
    if self._maxZ < pos.z then
      pos.z = self._maxZ
    end
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self._sceneRef)._cameraPoint).transform).position = pos
end

HexagonSceneController.CameraTransformChangedChangedCallback = function(self)
  -- function num : 0_11
  (self._dialog):UpdateEventIconPosition()
end

HexagonSceneController.SetBorder = function(self)
  -- function num : 0_12
end

HexagonSceneController.CheckCoordinate = function(self, coordinates)
  -- function num : 0_13 , upvalues : _ENV
  for i,coordinate in ipairs(coordinates) do
    if (self._mapRange).xmin >= coordinate.x or coordinate.x > (self._mapRange).xmax or (self._mapRange).ymin >= coordinate.y or coordinate.y > (self._mapRange).ymax or ((self._mapData)[coordinate.x])[coordinate.y] ~= 0 then
      return false
    end
  end
  return true
end

HexagonSceneController.MapAddBlock = function(self, coordinates, id)
  -- function num : 0_14 , upvalues : _ENV, GameObjectHelper
  for i,coordinate in ipairs(coordinates) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R8 in 'UnsetPending'

    ((self._mapData)[coordinate.x])[coordinate.y] = id
    if (self._rippleEffects)[coordinate.x - 1] and ((self._rippleEffects)[coordinate.x - 1])[coordinate.y + 1] and (((self._rippleEffects)[coordinate.x - 1])[coordinate.y + 1])[1] then
      (GameObjectHelper.DestroyObject)((((self._rippleEffects)[coordinate.x - 1])[coordinate.y + 1])[1])
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (((self._rippleEffects)[coordinate.x - 1])[coordinate.y + 1])[1] = nil
    end
    if (self._rippleEffects)[coordinate.x] and ((self._rippleEffects)[coordinate.x])[coordinate.y + 1] and (((self._rippleEffects)[coordinate.x])[coordinate.y + 1])[0] then
      (GameObjectHelper.DestroyObject)((((self._rippleEffects)[coordinate.x])[coordinate.y + 1])[0])
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (((self._rippleEffects)[coordinate.x])[coordinate.y + 1])[0] = nil
    end
    if ((self._mapData)[coordinate.x])[coordinate.y - 1] and ((self._mapData)[coordinate.x])[coordinate.y - 1] == 0 then
      self:CreatRipple(self, coordinate.x, coordinate.y, 0)
    end
    if (self._mapData)[coordinate.x + 1] and ((self._mapData)[coordinate.x + 1])[coordinate.y - 1] and ((self._mapData)[coordinate.x + 1])[coordinate.y - 1] == 0 then
      self:CreatRipple(self, coordinate.x, coordinate.y, 1)
    end
  end
end

HexagonSceneController.MapMoveBlock = function(self, coordinatesOld, coordinatesNew, id)
  -- function num : 0_15 , upvalues : _ENV
  for i,coordinate in ipairs(coordinatesOld) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R9 in 'UnsetPending'

    ((self._mapData)[coordinate.x])[coordinate.y] = 0
  end
  for i,coordinate in ipairs(coordinatesNew) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R9 in 'UnsetPending'

    ((self._mapData)[coordinate.x])[coordinate.y] = id
  end
end

HexagonSceneController.MapRemoveBlock = function(self, coordinates)
  -- function num : 0_16 , upvalues : _ENV
  for i,coordinate in ipairs(coordinates) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

    ((self._mapData)[coordinate.x])[coordinate.y] = 0
  end
end

HexagonSceneController.ClearBlockInCoordinates = function(self, coordinates)
  -- function num : 0_17 , upvalues : _ENV, GameObjectHelper
  for i,coordinate in ipairs(coordinates) do
    if (self._mapData)[coordinate.x] and ((self._mapData)[coordinate.x])[coordinate.y] then
      local blockId = ((self._mapData)[coordinate.x])[coordinate.y]
      if blockId > 0 then
        local block = (self._blocks)[blockId]
        if block then
          block:DestroyInstantiate()
          if (self._rippleEffects)[coordinate.x] and ((self._rippleEffects)[coordinate.x])[coordinate.y] then
            if (((self._rippleEffects)[coordinate.x])[coordinate.y])[0] then
              (GameObjectHelper.DestroyObject)((((self._rippleEffects)[coordinate.x])[coordinate.y])[0])
            end
            if (((self._rippleEffects)[coordinate.x])[coordinate.y])[1] then
              (GameObjectHelper.DestroyObject)((((self._rippleEffects)[coordinate.x])[coordinate.y])[1])
            end
            -- DECOMPILER ERROR at PC77: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self._rippleEffects)[coordinate.x])[coordinate.y] = nil
          end
        end
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self._mapData)[coordinate.x])[coordinate.y] = 0
        -- DECOMPILER ERROR at PC84: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._blocks)[blockId] = nil
      end
    end
  end
end

HexagonSceneController.GetBlockDefaultCoordinate = function(self, blockId)
  -- function num : 0_18 , upvalues : CHexagonLand, CHexagonLandShape, _ENV
  local blockRecorder = CHexagonLand:GetRecorder(blockId)
  local coordinatesCfg = (CHexagonLandShape:GetRecorder(blockRecorder.shapeType)).landCoordinate
  coordinatesCfg = (string.split)(coordinatesCfg, ";")
  local offsetCoordinate = {}
  local defaultCoordinates = {}
  local tempCoordinates = {}
  local cameraTransform = ((self._sceneRef)._cameraPoint).transform
  local x = (cameraTransform.position).x
  local y = (cameraTransform.position).z
  local cameracoordinate = {}
  cameracoordinate.y = (y - (self._origin).y - self._yOffset) / self._yUnit
  cameracoordinate.x = (x - (self._origin).x - self._xOffset * cameracoordinate.y) / self._xUnit
  cameracoordinate.y = (math.floor)(cameracoordinate.y + 0.5)
  cameracoordinate.x = (math.floor)(cameracoordinate.x + 0.5)
  local mapdata = self._mapData
  local maximumCircle = ((math.max)(cameracoordinate.x - (self._mapRange).xmin, (self._mapRange).xmax - cameracoordinate.x, cameracoordinate.y - (self._mapRange).ymin, (self._mapRange).ymax - cameracoordinate.y))
  local tempX, tempY = nil, nil
  local flg = false
  for i = 1, maximumCircle do
    for _x = -i, i do
      for _y = -i, i do
        tempX = cameracoordinate.x + _x
        tempY = cameracoordinate.y + _y
        if (self._mapRange).xmin <= tempX and tempX <= (self._mapRange).xmax and (self._mapRange).ymin <= tempY and tempY <= (self._mapRange).ymax then
          tempCoordinates = {}
          for i,coordinate in ipairs(coordinatesCfg) do
            offsetCoordinate = (string.split)(coordinate, ",")
            local temp = {x = tonumber(offsetCoordinate[1]) + (tempX), y = tonumber(offsetCoordinate[2]) + (tempY)}
            ;
            (table.insert)(tempCoordinates, temp)
          end
          if self:CheckCoordinate(tempCoordinates) then
            defaultCoordinates.x = tempX
            defaultCoordinates.y = tempY
            flg = true
            break
          end
        end
      end
    end
  end
  if flg then
    return defaultCoordinates
  else
    return nil
  end
end

HexagonSceneController.OnSUpdateSummerConstruction = function(self, notification)
  -- function num : 0_19 , upvalues : _ENV, HexagonalBlock
  local protocol = notification.userInfo
  local block = nil
  if protocol.result == 0 then
    LogError("SUpdateSummerConstruction", "result = false")
    return 
  end
  if (protocol.construction).level == 1 then
    block = (HexagonalBlock.Create)((protocol.construction).ID)
    block:Init(protocol.construction)
    block:SetCoordinateInformation({origin = self._origin, xOffset = self._xOffset, yOffset = self._yOffset, xUnit = self._xUnit, yUnit = self._yUnit})
    block:CreatGameObjectInstantiate((self._sceneRef)._blockParent)
    local coordinates = block:GetCoordinates()
    self:ClearBlockInCoordinates(coordinates)
    self:MapAddBlock(coordinates, (protocol.construction).ID)
    block:PlayBuildAnimation()
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._blocks)[(protocol.construction).ID] = block
    if (protocol.construction).canlvup ~= 1 then
      do
        local temp = {Id = ((protocol.construction).event)[1], worldPos = block:GetEventIconWorldPos(), canLevelUp = #(protocol.construction).event <= 0, blockId = (protocol.construction).ID}
        ;
        (table.insert)(self._eventsIconData, temp)
        ;
        (self._dialog):UpdateConstructionEvent()
        block = (self._blocks)[(protocol.construction).ID]
        block:OnLevelUp((protocol.construction).level)
        if block and #(protocol.construction).event > 0 then
          self:MoveCameraToBlock(block:GetId())
        end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

HexagonSceneController.OnSUpdateConstructionEvent = function(self, notification)
  -- function num : 0_20 , upvalues : _ENV, CHhexagonFunction
  local constructions = (self._bm):GetConstructions()
  self._eventsIconData = {}
  self._mainLineBlockID = nil
  for i,v in ipairs(constructions) do
    local block = (self._blocks)[v.ID]
    if v.canlvup ~= 1 then
      local temp = {Id = (v.event)[1], worldPos = block:GetEventIconWorldPos(), canLevelUp = #v.event <= 0, blockId = v.ID}
      ;
      (table.insert)(self._eventsIconData, temp)
      do
        local recorder = CHhexagonFunction:GetRecorder((v.event)[1])
        if recorder.type == 1 or recorder.type == 2 then
          self._mainLineBlockID = v.ID
        end
        -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (self._dialog):UpdateConstructionEvent()
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HexagonSceneController.OnSMoveSummerConstruction = function(self, notification)
  -- function num : 0_21 , upvalues : HexagonalBlock, _ENV
  local protocol = notification.userInfo
  local block = (self._blocks)[protocol.construction]
  -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

  if block and protocol.result == 0 and block then
    block:CancelMove()
  end
  if protocol.vertical == 999 then
    self:MapRemoveBlock(block:GetCoordinates())
    block:DestroyInstantiate()
    self:FinishSelect()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._blocks)[protocol.construction] = nil
  else
    self:MapMoveBlock(block:GetCoordinates(), block:GetTempCoordinates(), block:GetId())
    block:SubmitMove()
    self:FinishSelect()
  end
  if protocol.result == 1 then
    block = (HexagonalBlock.Create)(protocol.ID)
    block:Init(protocol)
    block:SetCoordinateInformation({origin = self._origin, xOffset = self._xOffset, yOffset = self._yOffset, xUnit = self._xUnit, yUnit = self._yUnit})
    block:CreatGameObjectInstantiate((self._sceneRef)._blockParent)
    block:PlayBuildAnimation()
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._blocks)[protocol.construction] = block
    local coordinates = block:GetCoordinates()
    self:MapAddBlock(coordinates, protocol.construction)
    if (protocol.construction).canlvup ~= 1 then
      do
        local temp = {Id = ((protocol.construction).event)[1], worldPos = block:GetEventIconWorldPos(), canLevelUp = #(protocol.construction).event <= 0, blockId = (protocol.construction).ID}
        ;
        (table.insert)(self._eventsIconData, temp)
        ;
        (self._dialog):UpdateConstructionEvent()
        if block then
          self:MoveCameraToBlock(block:GetId())
        end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
end

HexagonSceneController.OnSummerActivityEvent = function(self)
  -- function num : 0_22
  self:CancleSelectBlock()
end

HexagonSceneController.FinishSelect = function(self)
  -- function num : 0_23
  (self._dialog):FinishSelect()
  ;
  (self._interactDialog):FinishSelect()
  self:SetSelectBlock(0)
end

HexagonSceneController.GetLoadType = function(self)
  -- function num : 0_24 , upvalues : _ENV
  return (SceneManager.LoadType).SwimSuit
end

HexagonSceneController.SetDayNightInfo = function(self)
  -- function num : 0_25 , upvalues : _ENV, CSceneLightConfig, SceneInfoTable, TimelineManager, SetDayNightLight
  local isDayTime = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):IsDayTime()
  ;
  ((self._sceneRef)._dayLight):SetActive(isDayTime)
  ;
  ((self._sceneRef)._nightLight):SetActive(not isDayTime)
  ;
  ((self._sceneRef)._waterPlaneDay):SetActive(isDayTime)
  ;
  ((self._sceneRef)._waterPlaneNight):SetActive(not isDayTime)
  local timelineObject = (self._sceneRef)._timeLineGameObject
  local sceneLightColor = CSceneLightConfig:GetRecorder(self:GetSceneID())
  local sceneInfo = SceneInfoTable:GetRecorder(self:GetSceneID())
  if isDayTime then
    (TimelineManager.BindTimeline)(timelineObject, {["Cinemachine Track"] = ((self._sceneRef)._mainCamera).gameObject, ["Activation Track"] = (self._sceneRef)._sence_TX_yun_Day})
  else
    ;
    (TimelineManager.BindTimeline)(timelineObject, {["Cinemachine Track"] = ((self._sceneRef)._mainCamera).gameObject, ["Activation Track"] = (self._sceneRef)._sence_TX_yun_Night})
  end
  if sceneLightColor ~= nil then
    if isDayTime then
      (LuaAudioManager.PlayBGM)(sceneInfo.bgm)
      ;
      (SetDayNightLight.SetAmbientLight)(sceneLightColor.colorDay)
      ;
      (TimelineManager.BindTimeline)(timelineObject, {["Cinemachine Track"] = ((self._sceneRef)._mainCamera).gameObject, ["Activation Track"] = (self._sceneRef)._sence_TX_yun_Day})
    else
      ;
      (LuaAudioManager.PlayBGM)(sceneInfo.bgmNight)
      ;
      (SetDayNightLight.SetAmbientLight)(sceneLightColor.colorNight)
      ;
      (TimelineManager.BindTimeline)(timelineObject, {["Cinemachine Track"] = ((self._sceneRef)._mainCamera).gameObject, ["Activation Track"] = (self._sceneRef)._sence_TX_yun_Night})
    end
  end
  ;
  (TimelineManager.Play)(timelineObject, (((CS.UnityEngine).Playables).DirectorUpdateMode).Manual)
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
end

HexagonSceneController.LogAllBlocksCoordinateInfo = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local res = "\r\n"
  for k,v in pairs(self._blocks) do
    res = res .. k .. ","
    local coordinate = v:GetCurrentCoordinate()
    res = res .. coordinate.x .. ";" .. coordinate.y .. "\r\n"
  end
  LogError("地块坐标", res)
end

HexagonSceneController.CreatRipple = function(self, self, x, y, leftOrRight)
  -- function num : 0_27 , upvalues : PrefabLoader, TransformStaticFunctions
  local assetBundle, prefabName, gameObject = nil, nil, nil
  if leftOrRight == 0 then
    gameObject = (PrefabLoader.LoadAndInstantiatePrefab)((self._sceneRecorder).EffectWay1, (self._sceneRecorder).EffectName1)
  else
    gameObject = (PrefabLoader.LoadAndInstantiatePrefab)((self._sceneRecorder).EffectWay2, (self._sceneRecorder).EffectNanme2)
  end
  ;
  (TransformStaticFunctions.SetParent)(gameObject.transform, ((self._sceneRef)._blockParent).transform)
  local _x = (self._origin).x + x * self._xUnit + self._xOffset * y
  local _y = (self._origin).y + y * self._yUnit + self._yOffset
  ;
  (TransformStaticFunctions.SetPosition)(gameObject, _x, 0, _y)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

  if not (self._rippleEffects)[x] then
    (self._rippleEffects)[x] = {}
  end
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R10 in 'UnsetPending'

  if not ((self._rippleEffects)[x])[y] then
    ((self._rippleEffects)[x])[y] = {}
  end
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (((self._rippleEffects)[x])[y])[leftOrRight] = gameObject
end

HexagonSceneController.CreatWaterRippleEffect = function(self)
  -- function num : 0_28 , upvalues : _ENV
  for x,yData in pairs(self._mapData) do
    for y,v in pairs(yData) do
      if v > 0 then
        if ((self._mapData)[x])[y - 1] and ((self._mapData)[x])[y - 1] == 0 then
          self:CreatRipple(self, x, y, 0)
        end
        if (self._mapData)[x + 1] and ((self._mapData)[x + 1])[y - 1] and ((self._mapData)[x + 1])[y - 1] == 0 then
          self:CreatRipple(self, x, y, 1)
        end
      end
    end
  end
end

return HexagonSceneController

