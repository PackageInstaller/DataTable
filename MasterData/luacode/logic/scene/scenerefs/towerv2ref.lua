local SceneRef = require("logic.scene.scenerefs.sceneref")
local TowerV2Ref = class("TowerRef", SceneRef)
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras

function TowerV2Ref:Init()
  TowerV2Ref.super.Init(self)
  self.actor = {
    object = TransformStaticFunctions.GetChild(self._rootGameObject, "ActorTower")
  }
  self.actor.animator = self.actor.object:GetComponent("Animator")
  self.spawnPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "SpawnPoint")
  self.startPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "StartPoint")
  self.mainCamera = GlobalCameras.GetCamera("DormMain")
  self.clicktimeline = {
    object = TransformStaticFunctions.GetChild(self._rootGameObject, "SelectionTimelineBefore")
  }
  self.clicktimeline.director = self.clicktimeline.object:GetComponent("PlayableDirector")
  self.approachtimeline = {
    object = TransformStaticFunctions.GetChild(self._rootGameObject, "SelectionTimelineAfter")
  }
  self.approachtimeline.director = self.approachtimeline.object:GetComponent("PlayableDirector")
  self.worldtimeline = {
    object = {
      TransformStaticFunctions.GetChild(self._rootGameObject, "TimeTowerTimeline"),
      TransformStaticFunctions.GetChild(self._rootGameObject, "ForestTimeline"),
      TransformStaticFunctions.GetChild(self._rootGameObject, "IceTimeline")
    },
    director = {}
  }
  for i, v in ipairs(self.worldtimeline.object) do
    self.worldtimeline.director[i] = v:GetComponent("PlayableDirector")
  end
  self.background = {
    object = TransformStaticFunctions.GetChild(self._rootGameObject, "Background"),
    node = {},
    nodeOrigPos = {}
  }
  self.background.director = self.background.object:GetComponent("PlayableDirector")
  for i = 1, 3 do
    self.background.node[i] = TransformStaticFunctions.GetChild(self.background.object, "Bg" .. 4 - i)
    self.background.nodeOrigPos[i] = CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(self.background.node[i]))
  end
end

return TowerV2Ref
