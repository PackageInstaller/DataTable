-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/gendungeonsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.sceneref")
local GenDungeonSceneRef = require("logic.scene.scenerefs.sceneref")
GenDungeonSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : GenDungeonSceneRef
  ((GenDungeonSceneRef.super).Init)(self)
  local transform = (self._rootGameObject).transform
  self.generator = ((transform:Find("GameObject")).gameObject):GetComponent("DungeonGenerator")
  self.actor = {object = (transform:Find("Actor")).gameObject}
end

GenDungeonSceneRef.GetSceneControllerName = function(self)
  -- function num : 0_1
  return "logic.scene.gendungeonscene.gendungeonscenecontroller"
end

return GenDungeonSceneRef

