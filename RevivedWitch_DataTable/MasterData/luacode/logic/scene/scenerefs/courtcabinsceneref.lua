-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/courtcabinsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local CDormFurnitureLevel = (BeanManager.GetTableByName)("courtyard.cdormfurniturelevel")
local CDormFurnitureRange = (BeanManager.GetTableByName)("courtyard.cdormfurniturerange")
local SceneRef = require("logic.scene.scenerefs.sceneref")
local MaxRoomNum = 3
local CourtCabinSceneref = class("CourtCabinSceneref", SceneRef)
CourtCabinSceneref.Init = function(self)
  -- function num : 0_0 , upvalues : CourtCabinSceneref, TransformStaticFunctions, GlobalCameras, MaxRoomNum, CDormFurnitureRange, CDormFurnitureLevel
  ((CourtCabinSceneref.super).Init)(self)
  self._cameraBorder = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraBorder")
  self._mainCamera = (GlobalCameras.GetCamera)("DormMain")
  self._stateDrivenCameraGameObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CM StateDrivenCamera1")
  self._stateDrivenCameraAnimator = (self._stateDrivenCameraGameObject):GetComponent("Animator")
  self._roomScenes = {}
  for i = 1, MaxRoomNum do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

    (self._roomScenes)[i] = {}
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).cameraFollowPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraFollowPoint" .. i)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).room = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i)
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).characterPoints = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/Characters")
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).select = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/Select")
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).lock = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/Lock")
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).cm_vcam = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CM StateDrivenCamera1/CM vcam" .. i)
    local x, y, z = (TransformStaticFunctions.GetPosition)(((self._roomScenes)[i]).cm_vcam)
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).cm_vcam_posY = y
    -- DECOMPILER ERROR at PC106: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).wallObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/Wall")
    -- DECOMPILER ERROR at PC116: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).defaultWall = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/Wall/dorm_wall_01")
    -- DECOMPILER ERROR at PC126: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).defaultFloor = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/Floor/dorm_floor_01")
    -- DECOMPILER ERROR at PC130: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).grids = {}
    local map = ((self._roomScenes)[i]).grids
    local allIds = CDormFurnitureRange:GetAllIds()
    for j = 1, #allIds do
      local recorder = CDormFurnitureRange:GetRecorder(allIds[j])
      map[recorder.id] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/" .. recorder.range)
    end
    -- DECOMPILER ERROR at PC159: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self._roomScenes)[i]).furniturePoints = {}
    map = ((self._roomScenes)[i]).furniturePoints
    allIds = CDormFurnitureLevel:GetAllIds()
    for j = 1, #allIds do
      local recorder = CDormFurnitureLevel:GetRecorder(allIds[j])
      map[recorder.id] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/" .. recorder.name)
    end
  end
end

CourtCabinSceneref.GetMainCamera = function(self)
  -- function num : 0_1
  return self._mainCamera
end

CourtCabinSceneref.GetStateDrivenCameraAnimator = function(self)
  -- function num : 0_2
  return self._stateDrivenCameraAnimator
end

CourtCabinSceneref.GetRoomScenes = function(self)
  -- function num : 0_3
  return self._roomScenes
end

return CourtCabinSceneref

