-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/share/gachashareresultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local GachaShareResultDialog = class("GachaShareResultDialog", Dialog)
GachaShareResultDialog.AssetBundleName = "ui/layouts.share"
GachaShareResultDialog.AssetName = "GachaShareTen"
GachaShareResultDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaShareResultDialog
  ((GachaShareResultDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

GachaShareResultDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, UIManager
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  self._back = self:GetChild("BackBtn")
  self._imgPanel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Image")
  self._imgWhiteMargin = self:GetChild("Panel/WhiteBack")
  self._share = self:GetChild("ShareBtn")
  ;
  (self._share):Subscribe_PointerClickEvent(self.OnShareClick, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local shareBtnRectX, ShareBtnRectY = (self._share):GetRectSize()
  local leftAndRightMargin = shareBtnRectX / 2
  ;
  (self._share):SetAnchorAndOffset(0.5, 0, 0.5, 0, -leftAndRightMargin, 0, leftAndRightMargin, ShareBtnRectY)
  local ratio = (UIManager.GetScreenWHRatio)()
  ;
  (self._imgPanel):SetLocalScale(1, 1, 1)
  ;
  (self._imgPanel):SetPivotPosition(0.5, 0.6)
  local actualWHRatio = ((CS.UnityEngine).Screen).width / ((CS.UnityEngine).Screen).height
  local shouldBeHeight = (UIManager.GetCanvasScalerY)()
  local shouldBeWidth = shouldBeHeight * actualWHRatio
  leftAndRightMargin = shouldBeWidth / 2
  local upAndDownMargin = shouldBeHeight / 2
  ;
  (self._imgPanel):SetAnchorAndOffset(0.5, 0.5, 0.5, 0.5, -(leftAndRightMargin), -upAndDownMargin, leftAndRightMargin, upAndDownMargin)
  ;
  (self._imgPanel):SetLocalScale(0.65, 0.65, 1)
  ;
  (self._imgWhiteMargin):SetLocalScale(1, 1, 1)
  ;
  (self._imgWhiteMargin):SetAnchorAndOffset(0, 0, 1, 1, 0, 0, 0, 0)
end

GachaShareResultDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_ShareResultDialogClosed, self, nil)
end

GachaShareResultDialog.SetData = function(self, cardList, texture)
  -- function num : 0_3
  self._list = cardList
  self._texture = texture
  self:Refresh()
end

GachaShareResultDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._texture then
    ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).LoadTexture)((self._img):GetUIObject(), self._texture)
  end
end

GachaShareResultDialog.OnShareClick = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  if self._texture then
    ((((CS.PixelNeko).Tools).ScreenShotHelper).WriteAndShare)((os.time)() .. ".png", self._texture)
  end
  ;
  ((NekoData.BehaviorManager).BM_Gacha):RequestShareAward()
  ;
  ((DialogManager.GetDialog)("gacha.gacharesultdialog")):RefreshShare(0)
end

GachaShareResultDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return GachaShareResultDialog

