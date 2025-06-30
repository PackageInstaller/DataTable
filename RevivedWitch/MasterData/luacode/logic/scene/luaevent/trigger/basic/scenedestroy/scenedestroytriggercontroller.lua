-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/scenedestroy/scenedestroytriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local SceneDestroyTriggerController = class("SceneDestroyTriggerController", TriggerControllerBase)
local SceneDestroyTrigger = require("logic.scene.luaevent.trigger.basic.scenedestroy.scenedestroytrigger")
SceneDestroyTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SceneDestroyTriggerController
  ((SceneDestroyTriggerController.super).Ctor)(self, ...)
end

SceneDestroyTriggerController.CreateTriggerInstance = function(self, id, eventid, sceneId)
  -- function num : 0_1 , upvalues : SceneDestroyTrigger
  return (SceneDestroyTrigger.Create)("scenedestroy", id, eventid, sceneId)
end

SceneDestroyTriggerController.OnSceneDestroy = function(self, sceneId)
  -- function num : 0_2 , upvalues : _ENV
  for _,trigger in ipairs(self._triggers) do
    trigger:Check(sceneId)
  end
end

return SceneDestroyTriggerController

