local WU, DB, REF = require("Common/WindowUtil")(this)
local m_texturePath

function SetupWindow()
  WU.BindButtonEvent(REF.MaskClick, OnMaskClick)
  WU.BindButtonEvent(REF.ButtonDownload, OnDownloadClick)
end

function InitWindow()
  this:RegisterGameEvent("OnScreenshotSuccessEvent", OnScreenshotSuccess)
  this:RegisterGameEvent("OnScreenshotFailureEvent", OnScreenshotFailure)
end

function SetPicture(path)
  REF.TextureBig.UITexture.mainTexturePath = path
end

function OnMaskClick()
  WU.RecycleWindow("PostcardFullScreen")
end

function OnDownloadClick()
  REF.ButtonDownload.gameObject:SetActive(false)
  this:DelayInvokeInSeconds(1, function()
    local m_imagePath = CS.ResourceManager.Instance.SharePath .. "/screencapture.png"
    CS.GameUtility.ScreenCapture(m_imagePath)
    CS.NativeInterface.External_SaveToAlbum(m_imagePath, "OnScreenshotSuccessEvent", "OnScreenshotFailureEvent")
  end)
end

function OnScreenshotSuccess()
  REF.ButtonDownload.gameObject:SetActive(true)
  WU.ShowHintText("Success!")
end

function OnScreenshotFailure()
  REF.ButtonDownload.gameObject:SetActive(true)
  WU.ShowHintText("Try Again!")
end
