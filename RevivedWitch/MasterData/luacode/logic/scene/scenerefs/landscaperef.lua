-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/landscaperef.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local LandscapeRef = class("LandscapeRef", SceneRef)
LandscapeRef.Init = function(self)
  -- function num : 0_0 , upvalues : LandscapeRef, _ENV
  ((LandscapeRef.super).Init)(self)
  self.actor = {object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "ActorScroll")}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).animator = ((self.actor).object):GetComponent("Animator")
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).emojiPoint = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "EmojiPoint")
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).camerafollow = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "CameraFollowPoint")
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).leftStep = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "StepL")
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).rightStep = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "StepR")
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).light = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "Point light")
  self.builder = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Builder")
  self:GetTimelineObjects()
end

LandscapeRef.GetSceneControllerName = function(self)
  -- function num : 0_1
  return "logic.scene.trapscene.landscapecontroller"
end

LandscapeRef.GetTimelineObjects = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timelineObjects = {}
  local recorder = (BeanManager.GetTableByName)("timeline.cscrollscenetimeline")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.sceneID == self:GetSceneID() then
      local object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, record.timelineObj)
      if not object then
        LogError("timeline", "timeline not found: " .. i .. " @ " .. record.Name)
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.timelineObjects)[i] = object:GetComponent("PlayableDirector")
    end
  end
end

return LandscapeRef

