-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/playpvdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVideoPath = (BeanManager.GetTableByName)("ui.cvideopath")
local PlayPVDialog = class("PlayPVDialog", Dialog)
PlayPVDialog.AssetBundleName = "ui/layouts.advertise"
PlayPVDialog.AssetName = "AdvertisePV"
PlayPVDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayPVDialog
  ((PlayPVDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

PlayPVDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._skipButton = self:GetChild("SkipBtn")
  self._videoPanel = self:GetChild("Video")
  ;
  (self._skipButton):Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  ;
  (LuaAudioManager.PauseBGM)(1)
  ;
  (self._videoPanel):SetFileById(1)
  ;
  (self._videoPanel):SetLoop(false)
  ;
  (self._videoPanel):Subscribe_VideoPlayEndEvent(self.OnVideoEnd, self)
  ;
  (self._videoPanel):PlayVideoWithLoading()
end

PlayPVDialog.OnSkipBtnClick = function(self)
  -- function num : 0_2
  (self._videoPanel):StopVideo()
  self:OnVideoEnd()
end

PlayPVDialog.OnVideoEnd = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("playpvdialog")
  if not self._showType then
    GlobalGameFSM:SetBoolean("toPalyPV", false)
    GlobalGameFSM:SetString("toLogin", "Init")
  end
  ;
  (LuaAudioManager.ResumeBGM)(1)
end

PlayPVDialog.SetType = function(self, type)
  -- function num : 0_4
  self._showType = type
end

return PlayPVDialog

