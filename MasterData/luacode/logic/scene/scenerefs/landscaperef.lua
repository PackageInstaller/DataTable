local SceneRef = require("logic.scene.scenerefs.sceneref")
local LandscapeRef = class("LandscapeRef", SceneRef)

function LandscapeRef:Init()
  LandscapeRef.super.Init(self)
  self.actor = {
    object = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "ActorScroll")
  }
  self.actor.animator = self.actor.object:GetComponent("Animator")
  self.actor.emojiPoint = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self.actor.object, "EmojiPoint")
  self.actor.camerafollow = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self.actor.object, "CameraFollowPoint")
  self.actor.leftStep = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self.actor.object, "StepL")
  self.actor.rightStep = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self.actor.object, "StepR")
  self.actor.light = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self.actor.object, "Point light")
  self.builder = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "Builder")
  self:GetTimelineObjects()
end

function LandscapeRef:GetSceneControllerName()
  return "logic.scene.trapscene.landscapecontroller"
end

function LandscapeRef:GetTimelineObjects()
  self.timelineObjects = {}
  local recorder = BeanManager.GetTableByName("timeline.cscrollscenetimeline")
  for _, i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.sceneID == self:GetSceneID() then
      local object = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, record.timelineObj)
      if not object then
        LogError("timeline", "timeline not found: " .. i .. " @ " .. record.Name)
      end
      self.timelineObjects[i] = object:GetComponent("PlayableDirector")
    end
  end
end

return LandscapeRef
