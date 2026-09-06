local UIManager = CS.PixelNeko.UI.UIManager
local BannerId = 6
local ShareShotDialog = class("ShareShotDialog", Dialog)
ShareShotDialog.AssetBundleName = "ui/layouts.invite"
ShareShotDialog.AssetName = "InviteShareShot"

function ShareShotDialog:Ctor(...)
  ShareShotDialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function ShareShotDialog:OnCreate()
  self._imgPanel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Image")
  self._imgWhiteMargin = self:GetChild("Panel/WhiteBack")
  self._share = self:GetChild("ShareBtn")
  self._back = self:GetChild("CloseBtn")
  self._share:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
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

function ShareShotDialog:OnDestroy()
  if self._texture then
    CS.UnityEngine.Object.Destroy(self._texture)
    self._texture = nil
  end
end

function ShareShotDialog:SetData(texture, shared)
  self._texture = texture
  self._shared = shared
  self:Refresh()
end

function ShareShotDialog:Refresh()
  if self._texture then
    CS.PixelNeko.Tools.ExternalImageLoaderHelper.LoadTexture(self._img:GetUIObject(), self._texture)
  end
end

function ShareShotDialog:OnShareClick(args)
  if self._texture then
    CS.PixelNeko.Tools.ScreenShotHelper.WriteAndShare(os.time() .. ".png", self._texture)
  end
  if not self._shared then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cinviteweekshare")
    protocol:Send()
  end
end

function ShareShotDialog:OnBackBtnClicked()
  self:Destroy()
end

return ShareShotDialog
