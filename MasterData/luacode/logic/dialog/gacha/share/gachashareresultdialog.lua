local UIManager = CS.PixelNeko.UI.UIManager
local GachaShareResultDialog = class("GachaShareResultDialog", Dialog)
GachaShareResultDialog.AssetBundleName = "ui/layouts.share"
GachaShareResultDialog.AssetName = "GachaShareTen"

function GachaShareResultDialog:Ctor(...)
  GachaShareResultDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GachaShareResultDialog:OnCreate()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  self._back = self:GetChild("BackBtn")
  self._imgPanel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Image")
  self._imgWhiteMargin = self:GetChild("Panel/WhiteBack")
  self._share = self:GetChild("ShareBtn")
  self._share:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local shareBtnRectX, ShareBtnRectY = self._share:GetRectSize()
  local leftAndRightMargin = shareBtnRectX / 2
  self._share:SetAnchorAndOffset(0.5, 0, 0.5, 0, -leftAndRightMargin, 0, leftAndRightMargin, ShareBtnRectY)
  self._share:SetActive(false)
  local ratio = UIManager.GetScreenWHRatio()
  self._imgPanel:SetLocalScale(1, 1, 1)
  self._imgPanel:SetPivotPosition(0.5, 0.6)
  local actualWHRatio = CS.UnityEngine.Screen.width / CS.UnityEngine.Screen.height
  local shouldBeHeight = UIManager.GetCanvasScalerY()
  local shouldBeWidth = shouldBeHeight * actualWHRatio
  leftAndRightMargin = shouldBeWidth / 2
  local upAndDownMargin = shouldBeHeight / 2
  self._imgPanel:SetAnchorAndOffset(0.5, 0.5, 0.5, 0.5, -leftAndRightMargin, -upAndDownMargin, leftAndRightMargin, upAndDownMargin)
  self._imgPanel:SetLocalScale(0.65, 0.65, 1)
  self._imgWhiteMargin:SetLocalScale(1, 1, 1)
  self._imgWhiteMargin:SetAnchorAndOffset(0, 0, 1, 1, 0, 0, 0, 0)
end

function GachaShareResultDialog:OnDestroy()
  LuaNotificationCenter.PostNotification(Common.n_ShareResultDialogClosed, self, nil)
end

function GachaShareResultDialog:SetData(cardList, texture)
  self._list = cardList
  self._texture = texture
  self:Refresh()
end

function GachaShareResultDialog:Refresh()
  if self._texture then
    CS.PixelNeko.Tools.ExternalImageLoaderHelper.LoadTexture(self._img:GetUIObject(), self._texture)
  end
end

function GachaShareResultDialog:OnShareClick(args)
end

function GachaShareResultDialog:OnBackBtnClicked()
  self:Destroy()
end

return GachaShareResultDialog
