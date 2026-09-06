local CVideoPath = BeanManager.GetTableByName("ui.cvideopath")
local PlayPVDialog = class("PlayPVDialog", Dialog)
PlayPVDialog.AssetBundleName = "ui/layouts.advertise"
PlayPVDialog.AssetName = "AdvertisePV"

function PlayPVDialog:Ctor(...)
  PlayPVDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function PlayPVDialog:OnCreate()
  self._skipButton = self:GetChild("SkipBtn")
  self._videoPanel = self:GetChild("Video")
  self._skipButton:Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  LuaAudioManager.PauseBGM(1)
  self._videoPanel:SetFileById(1)
  self._videoPanel:SetLoop(false)
  self._videoPanel:Subscribe_VideoPlayEndEvent(self.OnVideoEnd, self)
  self._videoPanel:Prepare()
  self._videoPanel:PlayVideo()
end

function PlayPVDialog:OnSkipBtnClick()
  self._videoPanel:StopVideo()
  self:OnVideoEnd()
end

function PlayPVDialog:OnVideoEnd()
  DialogManager.DestroySingletonDialog("playpvdialog")
  if not self._showType then
    GlobalGameFSM:SetBoolean("toPalyPV", false)
    GlobalGameFSM:SetString("toLogin", "Init")
  end
  LuaAudioManager.ResumeBGM(1)
end

function PlayPVDialog:SetType(type)
  self._showType = type
end

return PlayPVDialog
