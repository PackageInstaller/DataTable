local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local CDormFurnitureLevel = BeanManager.GetTableByName("courtyard.cdormfurniturelevel")
local CDormFurnitureRange = BeanManager.GetTableByName("courtyard.cdormfurniturerange")
local SceneRef = require("logic.scene.scenerefs.sceneref")
local MaxRoomNum = 3
local CourtCabinSceneref = class("CourtCabinSceneref", SceneRef)

function CourtCabinSceneref:Init()
  CourtCabinSceneref.super.Init(self)
  self._cameraBorder = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraBorder")
  self._mainCamera = GlobalCameras.GetCamera("DormMain")
  self._stateDrivenCameraGameObject = TransformStaticFunctions.GetChild(self._rootGameObject, "CM StateDrivenCamera1")
  self._stateDrivenCameraAnimator = self._stateDrivenCameraGameObject:GetComponent("Animator")
  self._roomScenes = {}
  for i = 1, MaxRoomNum do
    self._roomScenes[i] = {}
    self._roomScenes[i].cameraFollowPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraFollowPoint" .. i)
    self._roomScenes[i].room = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i)
    self._roomScenes[i].characterPoints = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/Characters")
    self._roomScenes[i].select = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/Select")
    self._roomScenes[i].lock = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/Lock")
    self._roomScenes[i].cm_vcam = TransformStaticFunctions.GetChild(self._rootGameObject, "CM StateDrivenCamera1/CM vcam" .. i)
    local x, y, z = TransformStaticFunctions.GetPosition(self._roomScenes[i].cm_vcam)
    self._roomScenes[i].cm_vcam_posY = y
    self._roomScenes[i].wallObject = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/Wall")
    self._roomScenes[i].defaultWall = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/Wall/dorm_wall_01")
    self._roomScenes[i].defaultFloor = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/Floor/dorm_floor_01")
    self._roomScenes[i].grids = {}
    local map = self._roomScenes[i].grids
    local allIds = CDormFurnitureRange:GetAllIds()
    for j = 1, #allIds do
      local recorder = CDormFurnitureRange:GetRecorder(allIds[j])
      map[recorder.id] = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/" .. recorder.range)
    end
    self._roomScenes[i].furniturePoints = {}
    map = self._roomScenes[i].furniturePoints
    allIds = CDormFurnitureLevel:GetAllIds()
    for j = 1, #allIds do
      local recorder = CDormFurnitureLevel:GetRecorder(allIds[j])
      map[recorder.id] = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/Room_" .. i .. "/RoomObject/" .. recorder.name)
    end
  end
end

function CourtCabinSceneref:GetMainCamera()
  return self._mainCamera
end

function CourtCabinSceneref:GetStateDrivenCameraAnimator()
  return self._stateDrivenCameraAnimator
end

function CourtCabinSceneref:GetRoomScenes()
  return self._roomScenes
end

return CourtCabinSceneref
