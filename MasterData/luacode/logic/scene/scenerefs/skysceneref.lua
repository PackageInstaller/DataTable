local SceneRef = require("logic.scene.scenerefs.sceneref")
local SkySceneRef = class("SkySceneRef", SceneRef)
local CSkySceneTimelineTable = BeanManager.GetTableByName("scene.cskyscenetimeline")

function SkySceneRef:Init()
  SkySceneRef.super.Init(self)
  local transform = self._rootGameObject.transform
  self.actor = {
    object = transform:Find("ActorW3").gameObject
  }
  self._timelineDirectorList = {}
end

function SkySceneRef:SetTimeLineDirectorList(directorList)
  self._timelineDirectorList = directorList
end

function SkySceneRef:GetTimeLineDirectorList(index)
  return self._timelineDirectorList[index]
end

function SkySceneRef:GetSceneControllerName()
  return "logic.scene.skyscenecontroller"
end

return SkySceneRef
