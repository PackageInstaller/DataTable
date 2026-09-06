local UIManager = CS.PixelNeko.UI.UIManager
local GachaShareSingleDialog = class("GachaShareSingleDialog", Dialog)
GachaShareSingleDialog.AssetBundleName = "ui/layouts.share"
GachaShareSingleDialog.AssetName = "GachaShareOne"

function GachaShareSingleDialog:Ctor(...)
  GachaShareSingleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GachaShareSingleDialog:OnCreate()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  self._imgPanel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Image")
  self._imgWhiteMargin = self:GetChild("Panel/WhiteBack")
  self._share = self:GetChild("ShareBtn")
  self._back = self:GetChild("BackBtn")
  self._share:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackClick, self)
  local shareBtnRectX, ShareBtnRectY = self._share:GetRectSize()
  local leftAndRightMargin = shareBtnRectX / 2
  self._share:SetAnchorAndOffset(0.5, 0, 0.5, 0, -leftAndRightMargin, 0, leftAndRightMargin, ShareBtnRectY)
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

function GachaShareSingleDialog:OnDestroy()
  if self._texture then
    CS.UnityEngine.Object.Destroy(self._texture)
    self._texture = nil
  end
  LuaNotificationCenter.PostNotification(Common.n_ShareSingleDialogClosed, self, nil)
end

function GachaShareSingleDialog:SetData(texture)
  self._texture = texture
  self:Refresh()
end

function GachaShareSingleDialog:Refresh()
  if self._texture then
    CS.PixelNeko.Tools.ExternalImageLoaderHelper.LoadTexture(self._img:GetUIObject(), self._texture)
  end
end

function GachaShareSingleDialog:OnShareClick(args)
  if self._texture then
    CS.PixelNeko.Tools.ScreenShotHelper.WriteAndShare(os.time() .. ".png", self._texture)
  end
  NekoData.BehaviorManager.BM_Gacha:RequestShareAward()
  DialogManager.GetDialog("gacha.gachagetcarddialog"):RefreshShare(0)
end

function GachaShareSingleDialog:OnBackClick()
  self:Destroy()
end

function GachaShareSingleDialog:NumberOfCell(frame, index)
  return #self._itemList
end

function GachaShareSingleDialog:CellAtIndex(frame, index)
  return "gacha.gachagetcarditemcell"
end

function GachaShareSingleDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

return GachaShareSingleDialog
