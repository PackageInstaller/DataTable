local ShareDialog = class("ShareDialog", Dialog)
ShareDialog.AssetBundleName = "ui/layouts.activitylogin"
ShareDialog.AssetName = "ActivityLoginShareShot"

function ShareDialog:Ctor(...)
  ShareDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShareDialog:OnCreate()
  self._image = self:GetChild("Panel/Image")
  self._shareBtn = self:GetChild("ShareBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  self._shareBtnText = self:GetChild("ShareBtn/_Text")
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:SetData()
end

function ShareDialog:OnDestroy()
  if self._texture then
    CS.UnityEngine.Object.Destroy(self._texture)
    self._texture = nil
  end
end

function ShareDialog:SetData(texture)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._shareBtnText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2096))
  self._texture = texture
  if self._texture then
    CS.PixelNeko.Tools.ExternalImageLoaderHelper.LoadTexture(self._image:GetUIObject(), self._texture)
  end
end

function ShareDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShareDialog:OnShareClick()
  if self._texture then
    CS.PixelNeko.Tools.ScreenShotHelper.WriteAndShare(os.time() .. ".png", self._texture)
  end
  if self._bm:GetShareRecord() == 0 then
    self._bm:SendCBirthShare()
  end
end

return ShareDialog
