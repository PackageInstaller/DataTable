-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/video.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local VideoStaticFunctions = (((CS.PixelNeko).Lua).UI).VideoStaticFunctions
local VideoBehaviour = (((CS.PixelNeko).P1).Video).VideoBehaviour
local CVideoPath = (BeanManager.GetTableByName)("ui.cvideopath")
local Window = require("framework.ui.wrapper.window")
local Video = class("Video", Window)
Video.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Video
  ((Video.super).Ctor)(self, gameObject)
end

Video.PlayVideo = function(self)
  -- function num : 0_1 , upvalues : VideoStaticFunctions
  (VideoStaticFunctions.PlayVideo)(self._uiObject)
end

Video.PlayVideoWithLoading = function(self)
  -- function num : 0_2 , upvalues : _ENV, UIEventTriggerHelper
  self:Prepare()
  ;
  (DialogManager.CreateSingletonDialog)("gacha.gachavideoloadingdialog")
  ;
  (UIEventTriggerHelper.AddVideoPreparedListener)(self._uiObject, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    self:PlayVideo()
    ;
    (DialogManager.DestroySingletonDialog)("gacha.gachavideoloadingdialog")
  end
, self)
end

Video.StopVideo = function(self)
  -- function num : 0_3 , upvalues : VideoStaticFunctions
  (VideoStaticFunctions.StopVideo)(self._uiObject)
end

Video.ChangeMoviePath = function(self, moviePath)
  -- function num : 0_4 , upvalues : VideoStaticFunctions
  (VideoStaticFunctions.ChangeMoviePath)(self._uiObject, moviePath)
end

Video.SetFileById = function(self, ID)
  -- function num : 0_5 , upvalues : CVideoPath, VideoStaticFunctions
  local recorder = CVideoPath:GetRecorder(ID)
  ;
  (VideoStaticFunctions.SetFile)(self._uiObject, recorder.Videopath, recorder.x, recorder.y)
end

Video.Prepare = function(self)
  -- function num : 0_6 , upvalues : VideoStaticFunctions
  (VideoStaticFunctions.Prepare)(self._uiObject)
end

Video.SetLoop = function(self, isLoop)
  -- function num : 0_7 , upvalues : VideoStaticFunctions
  (VideoStaticFunctions.SetLoop)(self._uiObject, isLoop)
end

Video.SetCuePointCallback = function(self, luaTable, callback)
  -- function num : 0_8 , upvalues : VideoBehaviour
  local videoBehaviour = (VideoBehaviour.GetAndAdd)(self._uiObject)
  videoBehaviour:SetCuePointCallback(luaTable, callback)
end

Video.ClearCuePointCallback = function(self)
  -- function num : 0_9 , upvalues : VideoBehaviour
  local videoBehaviour = (VideoBehaviour.GetAndAdd)(self._uiObject)
  videoBehaviour:ClearCuePointCallback()
end

Video.SetSpeed = function(self, speed)
  -- function num : 0_10 , upvalues : VideoStaticFunctions
  (VideoStaticFunctions.SetSpeed)(self._uiObject, speed)
end

Video.Subscribe_VideoPlayEndEvent = function(self, callback, ins)
  -- function num : 0_11 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddVideoPlayEndListener)(self._uiObject, callback, ins)
end

Video.Unsubscribe_VideoPlayEndEvent = function(self, handler)
  -- function num : 0_12 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveVideoPlayEndListener)(self._uiObject, handler)
end

Video.Subscribe_VideoPreparedEvent = function(self, callback, ins)
  -- function num : 0_13 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddVideoPreparedListener)(self._uiObject, callback, ins)
end

Video.Unsubscribe_VideoPreparedEvent = function(self, handler)
  -- function num : 0_14 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveVideoPreparedListener)(self._uiObject, handler)
end

return Video

