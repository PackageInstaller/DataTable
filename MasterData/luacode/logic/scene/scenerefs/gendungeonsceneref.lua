local SceneRef = require("logic.scene.sceneref")
local GenDungeonSceneRef = require("logic.scene.scenerefs.sceneref")

function GenDungeonSceneRef:Init()
  GenDungeonSceneRef.super.Init(self)
  local transform = self._rootGameObject.transform
  self.generator = transform:Find("GameObject").gameObject:GetComponent("DungeonGenerator")
  self.actor = {
    object = transform:Find("Actor").gameObject
  }
end

function GenDungeonSceneRef:GetSceneControllerName()
  return "logic.scene.gendungeonscene.gendungeonscenecontroller"
end

return GenDungeonSceneRef
