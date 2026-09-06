local UIManager = CS.PixelNeko.UI.UIManager
local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local UIFitSlideCell = class("UIFitSlideCell", Dialog)
UIFitSlideCell.AssetBundleName = "ui/layouts.setting"
UIFitSlideCell.AssetName = "SettingSystemShow"

function UIFitSlideCell:Ctor(...)
  UIFitSlideCell.super.Ctor(self, ...)
end

function UIFitSlideCell:OnCreate()
  self._slideBar = self:GetChild("HandleScrollbar")
  self._slideBarProgress = self:GetChild("HandleScrollbar/_Sliding Area/Progress")
  self._hand = self:GetChild("HandleScrollbar/_Sliding Area/Handle")
  self._slideBar:Subscribe_ValueChangedEvent(function()
    self:OnScrollbarValueChange()
  end)
  self._hand:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._hand:Subscribe_EndDragEvent(self.OnEndDrag, self)
end

function UIFitSlideCell:OnDestroy()
  NekoData.DataManager.DM_Game:SaveSpecialShapedScreen()
end

function UIFitSlideCell:RefreshCell()
  local value = NekoData.BehaviorManager.BM_Game:GetSpecialShapedScreenValue()
  self._slideBar:SetScrollValue(value / 100)
end

function UIFitSlideCell:OnScrollbarValueChange()
  local rate = self._slideBar:GetScrollValue()
  local pixelValue = math.floor(rate * 1000)
  pixelValue = math.floor(pixelValue / 10)
  NekoData.DataManager.DM_Game:SetSpecialShapedScreenValue(pixelValue)
  UIManager.SetPanelSpecialShapedScreen(pixelValue)
end

function UIFitSlideCell:OnBeginDrag()
  self._delegate._frame:SetSlide(false, true)
end

function UIFitSlideCell:OnEndDrag()
  self._delegate._frame:SetSlide(true, true)
end

return UIFitSlideCell
