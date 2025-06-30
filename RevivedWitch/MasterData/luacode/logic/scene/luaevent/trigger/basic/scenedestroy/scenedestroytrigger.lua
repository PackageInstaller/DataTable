-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/scenedestroy/scenedestroytrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local SceneDestroyTrigger = class("SceneDestroyTrigger", TriggerBase)
SceneDestroyTrigger.Ctor = function(self, triggertype, id, eventid, sceneID)
  -- function num : 0_0 , upvalues : SceneDestroyTrigger
  ((SceneDestroyTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._sceneId = sceneID
end

SceneDestroyTrigger.OnCheck = function(self, destroySceneId)
  -- function num : 0_1
  return false
end

return SceneDestroyTrigger

