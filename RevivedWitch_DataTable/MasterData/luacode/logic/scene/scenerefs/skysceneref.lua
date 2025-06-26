-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/skysceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local SkySceneRef = class("SkySceneRef", SceneRef)
local CSkySceneTimelineTable = (BeanManager.GetTableByName)("scene.cskyscenetimeline")
SkySceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : SkySceneRef
  ((SkySceneRef.super).Init)(self)
  local transform = (self._rootGameObject).transform
  self.actor = {object = (transform:Find("ActorW3")).gameObject}
  self._timelineDirectorList = {}
end

SkySceneRef.SetTimeLineDirectorList = function(self, directorList)
  -- function num : 0_1
  self._timelineDirectorList = directorList
end

SkySceneRef.GetTimeLineDirectorList = function(self, index)
  -- function num : 0_2
  return (self._timelineDirectorList)[index]
end

SkySceneRef.GetSceneControllerName = function(self)
  -- function num : 0_3
  return "logic.scene.skyscenecontroller"
end

return SkySceneRef

