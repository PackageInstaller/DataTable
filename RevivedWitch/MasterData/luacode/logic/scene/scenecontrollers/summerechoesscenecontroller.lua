-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/summerechoesscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SummerEchoesBlock = require("logic.manager.experimental.types.summerechoesblock")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local SceneInfoTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CHexagonScene = (BeanManager.GetTableByName)("activity.chexagonscene")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local YardSceneCamera = (((CS.PixelNeko).P1).Camera).YardSceneCamera
local DragSceneConfig = (((CS.PixelNeko).P1).Config).DragSceneConfig
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local GameObject = (CS.UnityEngine).GameObject
local MaterialStaticFunctions = ((CS.PixelNeko).Lua).MaterialStaticFunctions
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local SideLength = 0.4
local SummerEchoesSceneController = class("SummerEchoesSceneController", SceneController)
SummerEchoesSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_0 , upvalues : SummerEchoesSceneController
  ((SummerEchoesSceneController.super).Ctor)(self, sceneRef)
  self._rippleEffects = {}
  self._mapData = {}
end

SummerEchoesSceneController.Init = function(self)
  -- function num : 0_1 , upvalues : SummerEchoesSceneController, _ENV, DragSceneConfig, CHexagonScene, SideLength, SummerEchoesBlock, CSRFunction, YardSceneCamera
  ((SummerEchoesSceneController.super).Init)(self)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dragSceneConfig = (DragSceneConfig.GetDragSceneConfig)(((self._sceneRef)._mainCamera).gameObject)
  self._minX = (self._dragSceneConfig).MinX
  self._maxX = (self._dragSceneConfig).MaxX
  self._minZ = (self._dragSceneConfig).MinY
  self._maxZ = (self._dragSceneConfig).MaxY
  self._sceneRecorder = CHexagonScene:GetRecorder(46001)
  local origin = (string.split)((self._sceneRecorder).coordinate, ",")
  self._origin = {x = tonumber(origin[1]), y = tonumber(origin[2])}
  self._xOffset = SideLength * (math.cos)((math.rad)(30))
  self._yOffset = SideLength * (math.sin)((math.rad)(30))
  self._xUnit = SideLength * (math.cos)((math.rad)(30)) * 2
  self._yUnit = SideLength * 2 - SideLength * (math.sin)((math.rad)(30))
  self._mapRange = {xmin = -99, xmax = 99, ymin = -99, ymax = 99}
  self._mapData = {}
  for x = (self._mapRange).xmin, (self._mapRange).xmax do
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R6 in 'UnsetPending'

    (self._mapData)[x] = {}
    for y = (self._mapRange).ymin, (self._mapRange).ymax do
      -- DECOMPILER ERROR at PC128: Confused about usage of register: R10 in 'UnsetPending'

      ((self._mapData)[x])[y] = 0
    end
  end
  local constructions = (self._bm):GetConstructions()
  self._blocks = {}
  self._eventsIconData = {}
  for _,v in ipairs(constructions) do
    local block = (SummerEchoesBlock.Create)(v.ID)
    block:Init(v)
    block:SetCoordinateInformation({origin = self._origin, xOffset = self._xOffset, yOffset = self._yOffset, xUnit = self._xUnit, yUnit = self._yUnit})
    block:CreatGameObjectInstantiate((self._sceneRef)._blockParent)
    -- DECOMPILER ERROR at PC167: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._blocks)[v.ID] = block
    local coordinates = block:GetCoordinates()
    for _,coordinate in ipairs(coordinates) do
      -- DECOMPILER ERROR at PC179: Confused about usage of register: R15 in 'UnsetPending'

      ((self._mapData)[coordinate.x])[coordinate.y] = v.ID
    end
    do
      if #v.event > 0 or v.unlockTime > 0 then
        (table.insert)(self._eventsIconData, {Id = (v.event)[1], worldPos = block:GetEventIconWorldPos(), blockId = v.ID, unlockTime = v.unlockTime})
        if not self._mainLineBlockID and (v.event)[1] then
          local recorder = CSRFunction:GetRecorder((v.event)[1])
          if (recorder and recorder.type == 1) or recorder.type == 2 then
            self._mainLineBlockID = v.ID
          end
        end
      end
      do
        -- DECOMPILER ERROR at PC226: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local a = 0
  for _,v in ipairs(constructions) do
    local block = (self._blocks)[v.ID]
    if block._fog then
      a = a + 1
    end
  end
  LogError("fogNum", tostring(a))
  self:CreatWaterRippleEffect()
  self._interactDialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.interactdialog")
  ;
  (self._interactDialog):Init(self)
  self._dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.swimsuitmaindialog")
  ;
  (self._dialog):Init(self)
  ;
  (self._dialog):OnSUpdateEchoEvent()
  self._sceneCamera = (YardSceneCamera.GetYardSceneCamera)(((self._sceneRef)._mainCamera).gameObject)
  if self._sceneCamera then
    (self._sceneCamera):SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
  self:SetDayNightInfo()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateEchoEvent, Common.n_OnSUpdateEchoEvent, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

SummerEchoesSceneController.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._sceneCamera then
    (self._sceneCamera):SetTransformChangedCallback(nil, self)
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.swimsuitechoes.swimsuitmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.swimsuitechoes.interactdialog")
end

SummerEchoesSceneController.GetMainCamera = function(self)
  -- function num : 0_3
  return (self._sceneRef)._mainCamera
end

SummerEchoesSceneController.GetBlocks = function(self)
  -- function num : 0_4
  return self._blocks
end

SummerEchoesSceneController.GetEventsIconData = function(self)
  -- function num : 0_5
  return self._eventsIconData
end

SummerEchoesSceneController.MoveCamera = function(self, xScreenOffset, zScreenOffset)
  -- function num : 0_6 , upvalues : _ENV
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

SummerEchoesSceneController.SelectBlock = function(self, id)
  -- function num : 0_7
  if self._selectBlockID then
    ((self._blocks)[self._selectBlockID]):SetSelectState(false)
    self._selectBlockID = nil
  end
  self._selectBlockID = id
  self:MoveCameraToBlock(id)
  ;
  ((self._blocks)[self._selectBlockID]):SetSelectState(true)
end

SummerEchoesSceneController.CancleSelectBlock = function(self)
  -- function num : 0_8
  if self._selectBlockID then
    ((self._blocks)[self._selectBlockID]):SetSelectState(false)
    self._selectBlockID = nil
  end
end

SummerEchoesSceneController.MoveCameraToBlock = function(self, ID)
  -- function num : 0_9
  local pos = ((self._blocks)[ID]):GetCenterPos()
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

SummerEchoesSceneController.CameraTransformChangedChangedCallback = function(self)
  -- function num : 0_10
  if self._dialog then
    (self._dialog):UpdateEventIconPosition()
  end
end

SummerEchoesSceneController.OnSUpdateEchoEvent = function(self)
  -- function num : 0_11 , upvalues : _ENV, CSRFunction
  local constructions = (self._bm):GetConstructions()
  self._eventsIconData = {}
  self._mainLineBlockID = nil
  for _,v in ipairs(constructions) do
    local block = (self._blocks)[v.ID]
    block:Init(v)
    if #v.event > 0 or v.unlockTime > 0 then
      (table.insert)(self._eventsIconData, {Id = (v.event)[1], worldPos = block:GetEventIconWorldPos(), blockId = v.ID, unlockTime = v.unlockTime})
      if (v.event)[1] then
        local recorder = CSRFunction:GetRecorder((v.event)[1])
        if (recorder and recorder.type == 1) or recorder.type == 2 then
          self._mainLineBlockID = v.ID
        end
      end
    end
    do
      do
        block:RefreshFog()
        -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local a = 0
  local b = 0
  for _,v in ipairs(constructions) do
    local block = (self._blocks)[v.ID]
    if block._fog then
      a = a + 1
    end
    if v.fog == 0 then
      b = b + 1
    end
  end
  LogError("fogNum", tostring(a) .. "|" .. tostring(b))
  if self._dialog then
    (self._dialog):OnSUpdateEchoEvent()
  end
  if self._mainLineBlockID then
    self:MoveCameraToBlock(self._mainLineBlockID)
  end
end

SummerEchoesSceneController.GetLoadType = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (SceneManager.LoadType).SwimSuitEchoes
end

SummerEchoesSceneController.CreatRipple = function(self, self, x, y, leftOrRight)
  -- function num : 0_13 , upvalues : PrefabLoader, TransformStaticFunctions
  local gameObject = nil
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
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

  if not (self._rippleEffects)[x] then
    (self._rippleEffects)[x] = {}
  end
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

  if not ((self._rippleEffects)[x])[y] then
    ((self._rippleEffects)[x])[y] = {}
  end
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (((self._rippleEffects)[x])[y])[leftOrRight] = gameObject
end

SummerEchoesSceneController.CreatWaterRippleEffect = function(self)
  -- function num : 0_14 , upvalues : _ENV
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

SummerEchoesSceneController.LogAllBlocksCoordinateInfo = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local res = "\r\n"
  for k,v in pairs(self._blocks) do
    res = res .. k .. ","
    local coordinate = v:GetCurrentCoordinate()
    res = res .. coordinate.x .. ";" .. coordinate.y .. "\r\n"
  end
  LogError("地块坐标", res)
end

SummerEchoesSceneController.OnNPCChatEnd = function(self)
  -- function num : 0_16
  self:CancleSelectBlock()
end

SummerEchoesSceneController.SetDayNightInfo = function(self)
  -- function num : 0_17 , upvalues : SceneInfoTable, _ENV
  local sceneInfo = SceneInfoTable:GetRecorder(self:GetSceneID())
  ;
  (LuaAudioManager.PlayBGM)(sceneInfo.bgm)
end

return SummerEchoesSceneController

