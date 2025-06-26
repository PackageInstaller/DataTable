-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/topdownref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TopDownRef = class("TopDownRef", SceneRef)
TopDownRef.Init = function(self)
  -- function num : 0_0 , upvalues : TopDownRef, _ENV
  ((TopDownRef.super).Init)(self)
  local transform = (self._rootGameObject).transform
  self.actor = {object = (transform:Find("Actor")).gameObject, animator = ((transform:Find("Actor")).gameObject):GetComponent("Animator")}
  self.builder = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Builder")
  self:CollectEnemies()
end

TopDownRef.GetSceneControllerName = function(self)
  -- function num : 0_1
  return "logic.scene.firstscenetopdown.topdowncontroller"
end

TopDownRef.CollectEnemies = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.enemies = {}
  local enemy_root = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Enemy")
  if not enemy_root then
    return 
  end
  local objects = (((((CS.PixelNeko).P1).Scene).TrapHelper).GetObjectsWithID)(enemy_root)
  local recorder = (BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")
  for object,id in pairs(objects) do
    local record = recorder:GetRecorder(id)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.enemies)[#self.enemies + 1] = {cfgid = id, object = object, cfg = record}
  end
end

return TopDownRef

