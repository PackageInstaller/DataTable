local CStringres = BeanManager.GetTableByName("message.cstringres")
local ShareResultDialog = class("ShareResultDialog", Dialog)
ShareResultDialog.AssetBundleName = "ui/layouts.welfare"
ShareResultDialog.AssetName = "ActivityShareWelfareMain"

function ShareResultDialog:Ctor(...)
  ShareResultDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShareResultDialog:OnCreate()
  self._shareBtnTxt = self:GetChild("Back/Btn/Text")
  self._image = self:GetChild("Back/BackImage")
  self._shareBtn = self:GetChild("Back/Btn")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ShareResultDialog:OnDestroy()
  if self._texture then
    CS.UnityEngine.Object.Destroy(self._texture)
    self._texture = nil
  end
end

function ShareResultDialog:SetData(texture)
  self._dm = NekoData.DataManager.DM_AnniversaryShare
  self._bm = NekoData.BehaviorManager.BM_AnniversaryShare
  self._shareBtnTxt:SetText(TextManager.GetText(CStringres:GetRecorder(2042).msgTextID))
  self._texture = texture
  if self._texture then
    CS.PixelNeko.Tools.ExternalImageLoaderHelper.LoadTexture(self._image:GetUIObject(), self._texture)
  end
end

function ShareResultDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShareResultDialog:OnShareClick()
  if self._texture then
    CS.PixelNeko.Tools.ScreenShotHelper.WriteAndShare(os.time() .. ".png", self._texture)
  end
  self._bm:SendCAnniversaryShare()
  self:Destroy()
end

return ShareResultDialog
