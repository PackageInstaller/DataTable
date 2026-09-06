local SummerEchoesBlock = require("logic.manager.experimental.types.summerechoesblock")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local SceneInfoTable = BeanManager.GetTableByName("scene.csceneinfostatic")
local CHexagonScene = BeanManager.GetTableByName("activity.chexagonscene")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local YardSceneCamera = CS.PixelNeko.P1.Camera.YardSceneCamera
local DragSceneConfig = CS.PixelNeko.P1.Config.DragSceneConfig
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local GameObject = CS.UnityEngine.GameObject
local MaterialStaticFunctions = CS.PixelNeko.Lua.MaterialStaticFunctions
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local SideLength = 0.4
local SummerEchoesSceneController = class("SummerEchoesSceneController", SceneController)

function SummerEchoesSceneController:Ctor(sceneRef)
  SummerEchoesSceneController.super.Ctor(self, sceneRef)
  self._rippleEffects = {}
  self._mapData = {}
end

function SummerEchoesSceneController:Init()
  SummerEchoesSceneController.super.Init(self)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dragSceneConfig = DragSceneConfig.GetDragSceneConfig(self._sceneRef._mainCamera.gameObject)
  self._minX = self._dragSceneConfig.MinX
  self._maxX = self._dragSceneConfig.MaxX
  self._minZ = self._dragSceneConfig.MinY
  self._maxZ = self._dragSceneConfig.MaxY
  self._sceneRecorder = CHexagonScene:GetRecorder(46001)
  local origin = string.split(self._sceneRecorder.coordinate, ",")
  self._origin = {
    x = tonumber(origin[1]),
    y = tonumber(origin[2])
  }
  self._xOffset = SideLength * math.cos(math.rad(30))
  self._yOffset = SideLength * math.sin(math.rad(30))
  self._xUnit = SideLength * math.cos(math.rad(30)) * 2
  self._yUnit = SideLength * 2 - SideLength * math.sin(math.rad(30))
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
  for _, v in ipairs(constructions) do
    local block = SummerEchoesBlock.Create(v.ID)
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
    for _, coordinate in ipairs(coordinates) do
      self._mapData[coordinate.x][coordinate.y] = v.ID
    end
    if 0 < #v.event or 0 < v.unlockTime then
      table.insert(self._eventsIconData, {
        Id = v.event[1],
        worldPos = block:GetEventIconWorldPos(),
        blockId = v.ID,
        unlockTime = v.unlockTime
      })
      if not self._mainLineBlockID and v.event[1] then
        local recorder = CSRFunction:GetRecorder(v.event[1])
        if recorder and recorder.type == 1 or recorder.type == 2 then
          self._mainLineBlockID = v.ID
        end
      end
    end
  end
  local a = 0
  for _, v in ipairs(constructions) do
    local block = self._blocks[v.ID]
    if block._fog then
      a = a + 1
    end
  end
  LogError("fogNum", tostring(a))
  self:CreatWaterRippleEffect()
  self._interactDialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.interactdialog")
  self._interactDialog:Init(self)
  self._dialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.swimsuitmaindialog")
  self._dialog:Init(self)
  self._dialog:OnSUpdateEchoEvent()
  self._sceneCamera = YardSceneCamera.GetYardSceneCamera(self._sceneRef._mainCamera.gameObject)
  if self._sceneCamera then
    self._sceneCamera:SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
  self:SetDayNightInfo()
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateEchoEvent, Common.n_OnSUpdateEchoEvent, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

function SummerEchoesSceneController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._sceneCamera then
    self._sceneCamera:SetTransformChangedCallback(nil, self)
  end
  DialogManager.DestroySingletonDialog("activity.swimsuitechoes.swimsuitmaindialog")
  DialogManager.DestroySingletonDialog("activity.swimsuitechoes.interactdialog")
end

function SummerEchoesSceneController:GetMainCamera()
  return self._sceneRef._mainCamera
end

function SummerEchoesSceneController:GetBlocks()
  return self._blocks
end

function SummerEchoesSceneController:GetEventsIconData()
  return self._eventsIconData
end

function SummerEchoesSceneController:MoveCamera(xScreenOffset, zScreenOffset)
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

function SummerEchoesSceneController:SelectBlock(id)
  if self._selectBlockID then
    self._blocks[self._selectBlockID]:SetSelectState(false)
    self._selectBlockID = nil
  end
  self._selectBlockID = id
  self:MoveCameraToBlock(id)
  self._blocks[self._selectBlockID]:SetSelectState(true)
end

function SummerEchoesSceneController:CancleSelectBlock()
  if self._selectBlockID then
    self._blocks[self._selectBlockID]:SetSelectState(false)
    self._selectBlockID = nil
  end
end

function SummerEchoesSceneController:MoveCameraToBlock(ID)
  local pos = self._blocks[ID]:GetCenterPos()
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

function SummerEchoesSceneController:CameraTransformChangedChangedCallback()
  if self._dialog then
    self._dialog:UpdateEventIconPosition()
  end
end

function SummerEchoesSceneController:OnSUpdateEchoEvent()
  local constructions = self._bm:GetConstructions()
  self._eventsIconData = {}
  self._mainLineBlockID = nil
  for _, v in ipairs(constructions) do
    local block = self._blocks[v.ID]
    block:Init(v)
    if #v.event > 0 or 0 < v.unlockTime then
      table.insert(self._eventsIconData, {
        Id = v.event[1],
        worldPos = block:GetEventIconWorldPos(),
        blockId = v.ID,
        unlockTime = v.unlockTime
      })
      if v.event[1] then
        local recorder = CSRFunction:GetRecorder(v.event[1])
        if recorder and recorder.type == 1 or recorder.type == 2 then
          self._mainLineBlockID = v.ID
        end
      end
    end
    block:RefreshFog()
  end
  local a = 0
  local b = 0
  for _, v in ipairs(constructions) do
    local block = self._blocks[v.ID]
    if block._fog then
      a = a + 1
    end
    if v.fog == 0 then
      b = b + 1
    end
  end
  LogError("fogNum", tostring(a) .. "|" .. tostring(b))
  if self._dialog then
    self._dialog:OnSUpdateEchoEvent()
  end
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
end

function SummerEchoesSceneController:GetLoadType()
  return SceneManager.LoadType.SwimSuitEchoes
end

function SummerEchoesSceneController:CreatRipple(self, x, y, leftOrRight)
  local gameObject
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

function SummerEchoesSceneController:CreatWaterRippleEffect()
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

function SummerEchoesSceneController:LogAllBlocksCoordinateInfo()
  local res = "\r\n"
  for k, v in pairs(self._blocks) do
    res = res .. k .. ","
    local coordinate = v:GetCurrentCoordinate()
    res = res .. coordinate.x .. ";" .. coordinate.y .. "\r\n"
  end
  LogError("地块坐标", res)
end

function SummerEchoesSceneController:OnNPCChatEnd()
  self:CancleSelectBlock()
end

function SummerEchoesSceneController:SetDayNightInfo()
  local sceneInfo = SceneInfoTable:GetRecorder(self:GetSceneID())
  LuaAudioManager.PlayBGM(sceneInfo.bgm)
end

return SummerEchoesSceneController
