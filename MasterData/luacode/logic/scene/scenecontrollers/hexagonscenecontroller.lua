local HexagonalBlock = require("logic.manager.experimental.types.hexagonalblock")
local CHexagonScene = BeanManager.GetTableByName("activity.chexagonscene")
local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local CHexagonLandShape = BeanManager.GetTableByName("activity.chexagonlandshape")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local CSceneLightConfig = BeanManager.GetTableByName("scene.cscenelightconfig")
local SceneInfoTable = BeanManager.GetTableByName("scene.csceneinfostatic")
local CHhexagonFunction = BeanManager.GetTableByName("activity.chexagonfunction")
local YardSceneCamera = CS.PixelNeko.P1.Camera.YardSceneCamera
local DragSceneConfig = CS.PixelNeko.P1.Config.DragSceneConfig
local LightStaticFunctions = CS.PixelNeko.Lua.LightStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local SetDayNightLight = CS.PixelNeko.P1.Render.DayNightSwitch.SetDayNightLight
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local GameObject = CS.UnityEngine.GameObject
local MaterialStaticFunctions = CS.PixelNeko.Lua.MaterialStaticFunctions
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local SideLength = 0.4
local HexagonSceneController = class("HexagonSceneController", SceneController)

function HexagonSceneController:Ctor(sceneRef)
  HexagonSceneController.super.Ctor(self, sceneRef)
  self._rippleEffects = {}
  self._mapData = {}
end

function HexagonSceneController:Init()
  HexagonSceneController.super.Init(self)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID)
  self._dragSceneConfig = DragSceneConfig.GetDragSceneConfig(self._sceneRef._mainCamera.gameObject)
  self._minX = self._dragSceneConfig.MinX
  self._maxX = self._dragSceneConfig.MaxX
  self._minZ = self._dragSceneConfig.MinY
  self._maxZ = self._dragSceneConfig.MaxY
  self._sceneRecorder = CHexagonScene:GetRecorder(9001)
  local origin = string.split(self._sceneRecorder.coordinate, ",")
  self._origin = {
    x = tonumber(origin[1]),
    y = tonumber(origin[2])
  }
  self._xOffset = SideLength * math.cos(math.rad(30))
  self._yOffset = SideLength * math.sin(math.rad(30))
  self._xUnit = SideLength * math.cos(math.rad(30)) * 2
  self._yUnit = SideLength * 2 - SideLength * math.sin(math.rad(30))
  local usefulArea = string.split(self._sceneRecorder.usefulArea, ";")
  local mapRange = string.split(self._sceneRecorder.range, ";")
  local leftDown = string.split(mapRange[1], ",")
  local rightUp = string.split(mapRange[2], ",")
  self._mapRange = {
    xmin = -99,
    xmax = 99,
    ymin = -99,
    ymax = 99
  }
  self._mapData = {}
  for x = self._mapRange.xmin, self._mapRange.xmax do
    self._mapData[x] = {}
    for y = self._mapRange.ymin, self._mapRange.ymax do
      self._mapData[x][y] = 0
    end
  end
  local constructions = self._bm:GetConstructions()
  self._blocks = {}
  self._eventsIconData = {}
  for i, v in ipairs(constructions) do
    local block = HexagonalBlock.Create(v.ID)
    block:Init(v)
    block:SetCoordinateInformation({
      origin = self._origin,
      xOffset = self._xOffset,
      yOffset = self._yOffset,
      xUnit = self._xUnit,
      yUnit = self._yUnit
    })
    block:CreatGameObjectInstantiate(self._sceneRef._blockParent)
    self._blocks[v.ID] = block
    local coordinates = block:GetCoordinates()
    for i, coordinate in ipairs(coordinates) do
      self._mapData[coordinate.x][coordinate.y] = v.ID
    end
    if 0 < #v.event then
      local temp = {
        Id = v.event[1],
        worldPos = block:GetEventIconWorldPos(),
        canLevelUp = v.canlvup == 1,
        blockId = v.ID
      }
      table.insert(self._eventsIconData, temp)
      if not self._mainLineBlockID then
        local recorder = CHhexagonFunction:GetRecorder(v.event[1])
        if recorder.type == 1 or recorder.type == 2 then
          self._mainLineBlockID = v.ID
        end
      end
    end
  end
  self:CreatWaterRippleEffect()
  self._interactDialog = DialogManager.CreateSingletonDialog("activity.swimsuit.interactdialog")
  self._interactDialog:Init(self)
  self._dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitmaindialog")
  self._dialog:Init(self)
  self._dialog:UpdateConstructionEvent()
  self._sceneCamera = YardSceneCamera.GetYardSceneCamera(self._sceneRef._mainCamera.gameObject)
  if self._sceneCamera then
    self._sceneCamera:SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  self:SetDayNightInfo()
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateConstructionEvent, Common.n_SUpdateConstructionEvent, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSummerActivityEvent, Common.n_SummerActivityCancelBlockSelect, nil)
end

function HexagonSceneController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._sceneCamera then
    self._sceneCamera:SetTransformChangedCallback(nil, self)
  end
  DialogManager.DestroySingletonDialog("activity.swimsuit.swimsuitmaindialog")
  DialogManager.DestroySingletonDialog("activity.swimsuit.interactdialog")
end

function HexagonSceneController:GetMainCamera()
  return self._sceneRef._mainCamera
end

function HexagonSceneController:GetBlocks()
  return self._blocks
end

function HexagonSceneController:GetEventsIconData()
  return self._eventsIconData
end

function HexagonSceneController:GetSelectId()
  return self._selectBlockID
end

function HexagonSceneController:MoveCamera(xScreenOffset, zScreenOffset)
  local transform = self._sceneRef._cameraPoint.transform
  if transform.position.x + xScreenOffset < self._minX then
    xScreenOffset = 0
  elseif transform.position.x + xScreenOffset > self._maxX then
    xScreenOffset = 0
  end
  if transform.position.z + zScreenOffset < self._minZ then
    zScreenOffset = 0
  elseif transform.position.z + zScreenOffset > self._maxZ then
    zScreenOffset = 0
  end
  transform:Translate(xScreenOffset, 0, zScreenOffset, CS.UnityEngine.Space.World)
end

function HexagonSceneController:SelectBlock(id)
  if self._selectBlockID then
    self._blocks[self._selectBlockID]:SetSelectState(false)
    self._selectBlockID = nil
  end
  self._selectBlockID = id
  local pos = self._blocks[self._selectBlockID]:GetWorldPos()
  self:MoveCameraToBlock(id)
  self._blocks[self._selectBlockID]:SetSelectState(true)
end

function HexagonSceneController:CancleSelectBlock()
  if self._selectBlockID then
    self._blocks[self._selectBlockID]:SetSelectState(false)
    self._selectBlockID = nil
  end
end

function HexagonSceneController:MoveCameraToBlock(ID)
  local pos = self._blocks[ID]:GetWorldPos()
  if pos.x < self._minX then
    pos.x = self._minX
  elseif pos.x > self._maxX then
    pos.x = self._maxX
  end
  if pos.z < self._minZ then
    pos.z = self._minZ
  elseif pos.z > self._maxZ then
    pos.z = self._maxZ
  end
  self._sceneRef._cameraPoint.transform.position = pos
end

function HexagonSceneController:CameraTransformChangedChangedCallback()
  self._dialog:UpdateEventIconPosition()
end

function HexagonSceneController:SetBorder()
end

function HexagonSceneController:CheckCoordinate(coordinates)
  for i, coordinate in ipairs(coordinates) do
    if not (coordinate.x > self._mapRange.xmin and coordinate.x <= self._mapRange.xmax and coordinate.y > self._mapRange.ymin and coordinate.y <= self._mapRange.ymax) or self._mapData[coordinate.x][coordinate.y] ~= 0 then
      return false
    end
  end
  return true
end

function HexagonSceneController:MapAddBlock(coordinates, id)
  for i, coordinate in ipairs(coordinates) do
    self._mapData[coordinate.x][coordinate.y] = id
    if self._rippleEffects[coordinate.x - 1] and self._rippleEffects[coordinate.x - 1][coordinate.y + 1] and self._rippleEffects[coordinate.x - 1][coordinate.y + 1][1] then
      GameObjectHelper.DestroyObject(self._rippleEffects[coordinate.x - 1][coordinate.y + 1][1])
      self._rippleEffects[coordinate.x - 1][coordinate.y + 1][1] = nil
    end
    if self._rippleEffects[coordinate.x] and self._rippleEffects[coordinate.x][coordinate.y + 1] and self._rippleEffects[coordinate.x][coordinate.y + 1][0] then
      GameObjectHelper.DestroyObject(self._rippleEffects[coordinate.x][coordinate.y + 1][0])
      self._rippleEffects[coordinate.x][coordinate.y + 1][0] = nil
    end
    if self._mapData[coordinate.x][coordinate.y - 1] and self._mapData[coordinate.x][coordinate.y - 1] == 0 then
      self:CreatRipple(self, coordinate.x, coordinate.y, 0)
    end
    if self._mapData[coordinate.x + 1] and self._mapData[coordinate.x + 1][coordinate.y - 1] and self._mapData[coordinate.x + 1][coordinate.y - 1] == 0 then
      self:CreatRipple(self, coordinate.x, coordinate.y, 1)
    end
  end
end

function HexagonSceneController:MapMoveBlock(coordinatesOld, coordinatesNew, id)
  for i, coordinate in ipairs(coordinatesOld) do
    self._mapData[coordinate.x][coordinate.y] = 0
  end
  for i, coordinate in ipairs(coordinatesNew) do
    self._mapData[coordinate.x][coordinate.y] = id
  end
end

function HexagonSceneController:MapRemoveBlock(coordinates)
  for i, coordinate in ipairs(coordinates) do
    self._mapData[coordinate.x][coordinate.y] = 0
  end
end

function HexagonSceneController:ClearBlockInCoordinates(coordinates)
  for i, coordinate in ipairs(coordinates) do
    if self._mapData[coordinate.x] and self._mapData[coordinate.x][coordinate.y] then
      local blockId = self._mapData[coordinate.x][coordinate.y]
      if 0 < blockId then
        local block = self._blocks[blockId]
        if block then
          block:DestroyInstantiate()
          if self._rippleEffects[coordinate.x] and self._rippleEffects[coordinate.x][coordinate.y] then
            if self._rippleEffects[coordinate.x][coordinate.y][0] then
              GameObjectHelper.DestroyObject(self._rippleEffects[coordinate.x][coordinate.y][0])
            end
            if self._rippleEffects[coordinate.x][coordinate.y][1] then
              GameObjectHelper.DestroyObject(self._rippleEffects[coordinate.x][coordinate.y][1])
            end
            self._rippleEffects[coordinate.x][coordinate.y] = nil
          end
        end
        self._mapData[coordinate.x][coordinate.y] = 0
        self._blocks[blockId] = nil
      end
    end
  end
end

function HexagonSceneController:GetBlockDefaultCoordinate(blockId)
  local blockRecorder = CHexagonLand:GetRecorder(blockId)
  local coordinatesCfg = CHexagonLandShape:GetRecorder(blockRecorder.shapeType).landCoordinate
  coordinatesCfg = string.split(coordinatesCfg, ";")
  local offsetCoordinate = {}
  local defaultCoordinates = {}
  local tempCoordinates = {}
  local cameraTransform = self._sceneRef._cameraPoint.transform
  local x = cameraTransform.position.x
  local y = cameraTransform.position.z
  local cameracoordinate = {}
  cameracoordinate.y = (y - self._origin.y - self._yOffset) / self._yUnit
  cameracoordinate.x = (x - self._origin.x - self._xOffset * cameracoordinate.y) / self._xUnit
  cameracoordinate.y = math.floor(cameracoordinate.y + 0.5)
  cameracoordinate.x = math.floor(cameracoordinate.x + 0.5)
  local mapdata = self._mapData
  local maximumCircle = math.max(cameracoordinate.x - self._mapRange.xmin, self._mapRange.xmax - cameracoordinate.x, cameracoordinate.y - self._mapRange.ymin, self._mapRange.ymax - cameracoordinate.y)
  local tempX, tempY
  local flg = false
  for i = 1, maximumCircle do
    for _x = -i, i do
      for _y = -i, i do
        tempX = cameracoordinate.x + _x
        tempY = cameracoordinate.y + _y
        if tempX >= self._mapRange.xmin and tempX <= self._mapRange.xmax and tempY >= self._mapRange.ymin and tempY <= self._mapRange.ymax then
          tempCoordinates = {}
          for i, coordinate in ipairs(coordinatesCfg) do
            offsetCoordinate = string.split(coordinate, ",")
            local temp = {
              x = tonumber(offsetCoordinate[1]) + tempX,
              y = tonumber(offsetCoordinate[2]) + tempY
            }
            table.insert(tempCoordinates, temp)
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

function HexagonSceneController:OnSUpdateSummerConstruction(notification)
  local protocol = notification.userInfo
  local block
  if protocol.result == 0 then
    LogError("SUpdateSummerConstruction", "result = false")
    return
  end
  if protocol.construction.level == 1 then
    block = HexagonalBlock.Create(protocol.construction.ID)
    block:Init(protocol.construction)
    block:SetCoordinateInformation({
      origin = self._origin,
      xOffset = self._xOffset,
      yOffset = self._yOffset,
      xUnit = self._xUnit,
      yUnit = self._yUnit
    })
    block:CreatGameObjectInstantiate(self._sceneRef._blockParent)
    local coordinates = block:GetCoordinates()
    self:ClearBlockInCoordinates(coordinates)
    self:MapAddBlock(coordinates, protocol.construction.ID)
    block:PlayBuildAnimation()
    self._blocks[protocol.construction.ID] = block
    if 0 < #protocol.construction.event then
      local temp = {
        Id = protocol.construction.event[1],
        worldPos = block:GetEventIconWorldPos(),
        canLevelUp = protocol.construction.canlvup == 1,
        blockId = protocol.construction.ID
      }
      table.insert(self._eventsIconData, temp)
      self._dialog:UpdateConstructionEvent()
    end
  else
    block = self._blocks[protocol.construction.ID]
    block:OnLevelUp(protocol.construction.level)
  end
  if block and 0 < #protocol.construction.event then
    self:MoveCameraToBlock(block:GetId())
  end
end

function HexagonSceneController:OnSUpdateConstructionEvent(notification)
  local constructions = self._bm:GetConstructions()
  self._eventsIconData = {}
  self._mainLineBlockID = nil
  for i, v in ipairs(constructions) do
    local block = self._blocks[v.ID]
    if #v.event > 0 then
      local temp = {
        Id = v.event[1],
        worldPos = block:GetEventIconWorldPos(),
        canLevelUp = v.canlvup == 1,
        blockId = v.ID
      }
      table.insert(self._eventsIconData, temp)
      local recorder = CHhexagonFunction:GetRecorder(v.event[1])
      if recorder.type == 1 or recorder.type == 2 then
        self._mainLineBlockID = v.ID
      end
    end
  end
  self._dialog:UpdateConstructionEvent()
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
end

function HexagonSceneController:OnSMoveSummerConstruction(notification)
  local protocol = notification.userInfo
  local block = self._blocks[protocol.construction]
  if block then
    if protocol.result == 0 then
      if block then
        block:CancelMove()
      end
    elseif protocol.vertical == 999 then
      self:MapRemoveBlock(block:GetCoordinates())
      block:DestroyInstantiate()
      self:FinishSelect()
      self._blocks[protocol.construction] = nil
    else
      self:MapMoveBlock(block:GetCoordinates(), block:GetTempCoordinates(), block:GetId())
      block:SubmitMove()
      self:FinishSelect()
    end
  elseif protocol.result == 1 then
    block = HexagonalBlock.Create(protocol.ID)
    block:Init(protocol)
    block:SetCoordinateInformation({
      origin = self._origin,
      xOffset = self._xOffset,
      yOffset = self._yOffset,
      xUnit = self._xUnit,
      yUnit = self._yUnit
    })
    block:CreatGameObjectInstantiate(self._sceneRef._blockParent)
    block:PlayBuildAnimation()
    self._blocks[protocol.construction] = block
    local coordinates = block:GetCoordinates()
    self:MapAddBlock(coordinates, protocol.construction)
    if 0 < #protocol.construction.event then
      local temp = {
        Id = protocol.construction.event[1],
        worldPos = block:GetEventIconWorldPos(),
        canLevelUp = protocol.construction.canlvup == 1,
        blockId = protocol.construction.ID
      }
      table.insert(self._eventsIconData, temp)
      self._dialog:UpdateConstructionEvent()
    end
  end
  if block then
    self:MoveCameraToBlock(block:GetId())
  end
end

function HexagonSceneController:OnSummerActivityEvent()
  self:CancleSelectBlock()
end

function HexagonSceneController:FinishSelect()
  self._dialog:FinishSelect()
  self._interactDialog:FinishSelect()
  self:SetSelectBlock(0)
end

function HexagonSceneController:GetLoadType()
  return SceneManager.LoadType.SwimSuit
end

function HexagonSceneController:SetDayNightInfo()
  local isDayTime = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):IsDayTime()
  self._sceneRef._dayLight:SetActive(isDayTime)
  self._sceneRef._nightLight:SetActive(not isDayTime)
  self._sceneRef._waterPlaneDay:SetActive(isDayTime)
  self._sceneRef._waterPlaneNight:SetActive(not isDayTime)
  local timelineObject = self._sceneRef._timeLineGameObject
  local sceneLightColor = CSceneLightConfig:GetRecorder(self:GetSceneID())
  local sceneInfo = SceneInfoTable:GetRecorder(self:GetSceneID())
  if isDayTime then
    TimelineManager.BindTimeline(timelineObject, {
      ["Cinemachine Track"] = self._sceneRef._mainCamera.gameObject,
      ["Activation Track"] = self._sceneRef._sence_TX_yun_Day
    })
  else
    TimelineManager.BindTimeline(timelineObject, {
      ["Cinemachine Track"] = self._sceneRef._mainCamera.gameObject,
      ["Activation Track"] = self._sceneRef._sence_TX_yun_Night
    })
  end
  if sceneLightColor ~= nil then
    if isDayTime then
      LuaAudioManager.PlayBGM(sceneInfo.bgm)
      SetDayNightLight.SetAmbientLight(sceneLightColor.colorDay)
      TimelineManager.BindTimeline(timelineObject, {
        ["Cinemachine Track"] = self._sceneRef._mainCamera.gameObject,
        ["Activation Track"] = self._sceneRef._sence_TX_yun_Day
      })
    else
      LuaAudioManager.PlayBGM(sceneInfo.bgmNight)
      SetDayNightLight.SetAmbientLight(sceneLightColor.colorNight)
      TimelineManager.BindTimeline(timelineObject, {
        ["Cinemachine Track"] = self._sceneRef._mainCamera.gameObject,
        ["Activation Track"] = self._sceneRef._sence_TX_yun_Night
      })
    end
  end
  TimelineManager.Play(timelineObject, CS.UnityEngine.Playables.DirectorUpdateMode.Manual)
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
end

function HexagonSceneController:LogAllBlocksCoordinateInfo()
  local res = "\r\n"
  for k, v in pairs(self._blocks) do
    res = res .. k .. ","
    local coordinate = v:GetCurrentCoordinate()
    res = res .. coordinate.x .. ";" .. coordinate.y .. "\r\n"
  end
  LogError("地块坐标", res)
end

function HexagonSceneController:CreatRipple(self, x, y, leftOrRight)
  local assetBundle, prefabName, gameObject
  if leftOrRight == 0 then
    gameObject = PrefabLoader.LoadAndInstantiatePrefab(self._sceneRecorder.EffectWay1, self._sceneRecorder.EffectName1)
  else
    gameObject = PrefabLoader.LoadAndInstantiatePrefab(self._sceneRecorder.EffectWay2, self._sceneRecorder.EffectNanme2)
  end
  TransformStaticFunctions.SetParent(gameObject.transform, self._sceneRef._blockParent.transform)
  local _x = self._origin.x + x * self._xUnit + self._xOffset * y
  local _y = self._origin.y + y * self._yUnit + self._yOffset
  TransformStaticFunctions.SetPosition(gameObject, _x, 0, _y)
  if not self._rippleEffects[x] then
    self._rippleEffects[x] = {}
  end
  if not self._rippleEffects[x][y] then
    self._rippleEffects[x][y] = {}
  end
  self._rippleEffects[x][y][leftOrRight] = gameObject
end

function HexagonSceneController:CreatWaterRippleEffect()
  for x, yData in pairs(self._mapData) do
    for y, v in pairs(yData) do
      if 0 < v then
        if self._mapData[x][y - 1] and self._mapData[x][y - 1] == 0 then
          self:CreatRipple(self, x, y, 0)
        end
        if self._mapData[x + 1] and self._mapData[x + 1][y - 1] and self._mapData[x + 1][y - 1] == 0 then
          self:CreatRipple(self, x, y, 1)
        end
      end
    end
  end
end

return HexagonSceneController
