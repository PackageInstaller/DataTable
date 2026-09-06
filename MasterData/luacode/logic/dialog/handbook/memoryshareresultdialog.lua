local ShareSingleDialog = class("ShareSingleDialog", Dialog)
ShareSingleDialog.AssetBundleName = "ui/layouts.tujianpuzzle"
ShareSingleDialog.AssetName = "TuJianPuzzleShow"

function ShareSingleDialog:Ctor(...)
  ShareSingleDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShareSingleDialog:OnCreate()
  self._img = self:GetChild("BackImage/Puzzle")
  self._share = self:GetChild("BackImage/DownloadBtn")
  self._back = self:GetChild("BackImage/CloseBtn")
  self._share:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ShareSingleDialog:OnDestroy()
  if self._texture then
    CS.UnityEngine.Object.Destroy(self._texture)
    self._texture = nil
  end
end

function ShareSingleDialog:SetData(texture)
  self._texture = texture
  self:Refresh()
end

function ShareSingleDialog:Refresh()
  if self._texture then
    CS.PixelNeko.Tools.ExternalImageLoaderHelper.LoadTexture(self._img:GetUIObject(), self._texture)
  end
end

function ShareSingleDialog:OnShareClick(args)
  if self._texture then
    CS.PixelNeko.Tools.ScreenShotHelper.WriteAndShare(os.time() .. ".png", self._texture)
  end
  self:Destroy()
end

function ShareSingleDialog:OnBackBtnClicked()
  self:Destroy()
end

return ShareSingleDialog
