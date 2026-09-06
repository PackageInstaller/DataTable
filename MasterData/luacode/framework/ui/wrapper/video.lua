local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local VideoStaticFunctions = CS.PixelNeko.Lua.UI.VideoStaticFunctions
local VideoBehaviour = CS.PixelNeko.P1.Video.VideoBehaviour
local CVideoPath = BeanManager.GetTableByName("ui.cvideopath")
local Window = require("framework.ui.wrapper.window")
local Video = class("Video", Window)

function Video:Ctor(gameObject)
  Video.super.Ctor(self, gameObject)
end

function Video:PlayVideo()
  LogInfoFormat("Video", "=====PlayVideo")
  VideoStaticFunctions.PlayVideo(self._uiObject)
end

function Video:PlayVideoWithLoading()
  LogInfoFormat("Video", "=====PlayVideoWithLoading 111")
  self:Prepare()
  LogInfoFormat("Video", "=====PlayVideoWithLoading 222")
  DialogManager.CreateSingletonDialog("gacha.gachavideoloadingdialog")
  UIEventTriggerHelper.AddVideoPreparedListener(self._uiObject, function()
    LogInfoFormat("Video", "=====PlayVideoWithLoading callback 111")
    self:PlayVideo()
    LogInfoFormat("Video", "=====PlayVideoWithLoading callback 222")
    DialogManager.DestroySingletonDialog("gacha.gachavideoloadingdialog")
    LogInfoFormat("Video", "=====PlayVideoWithLoading callback 333")
  end, self)
end

function Video:StopVideo()
  VideoStaticFunctions.StopVideo(self._uiObject)
end

function Video:ChangeMoviePath(moviePath)
  VideoStaticFunctions.ChangeMoviePath(self._uiObject, moviePath)
end

function Video:SetFileById(ID)
  local recorder = CVideoPath:GetRecorder(ID)
  if recorder then
    VideoStaticFunctions.SetFile(self._uiObject, recorder.Videopath, recorder.x, recorder.y)
  end
end

function Video:Prepare()
  VideoStaticFunctions.Prepare(self._uiObject)
end

function Video:SetLoop(isLoop)
  VideoStaticFunctions.SetLoop(self._uiObject, isLoop)
end

function Video:SetCuePointCallback(luaTable, callback)
  local videoBehaviour = VideoBehaviour.GetAndAdd(self._uiObject)
  videoBehaviour:SetCuePointCallback(luaTable, callback)
end

function Video:ClearCuePointCallback()
  local videoBehaviour = VideoBehaviour.GetAndAdd(self._uiObject)
  videoBehaviour:ClearCuePointCallback()
end

function Video:SetSpeed(speed)
  VideoStaticFunctions.SetSpeed(self._uiObject, speed)
end

function Video:Subscribe_VideoPlayEndEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddVideoPlayEndListener(self._uiObject, callback, ins)
end

function Video:Unsubscribe_VideoPlayEndEvent(handler)
  UIEventTriggerHelper.RemoveVideoPlayEndListener(self._uiObject, handler)
end

function Video:Subscribe_VideoPreparedEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddVideoPreparedListener(self._uiObject, callback, ins)
end

function Video:Unsubscribe_VideoPreparedEvent(handler)
  UIEventTriggerHelper.RemoveVideoPreparedListener(self._uiObject, handler)
end

return Video
