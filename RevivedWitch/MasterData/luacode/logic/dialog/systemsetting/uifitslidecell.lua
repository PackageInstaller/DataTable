-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/uifitslidecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local UIFitSlideCell = class("UIFitSlideCell", Dialog)
UIFitSlideCell.AssetBundleName = "ui/layouts.setting"
UIFitSlideCell.AssetName = "SettingSystemShow"
UIFitSlideCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UIFitSlideCell
  ((UIFitSlideCell.super).Ctor)(self, ...)
end

UIFitSlideCell.OnCreate = function(self)
  -- function num : 0_1
  self._slideBar = self:GetChild("HandleScrollbar")
  self._slideBarProgress = self:GetChild("HandleScrollbar/_Sliding Area/Progress")
  self._hand = self:GetChild("HandleScrollbar/_Sliding Area/Handle")
  ;
  (self._slideBar):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnScrollbarValueChange()
  end
)
  ;
  (self._hand):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  ;
  (self._hand):Subscribe_EndDragEvent(self.OnEndDrag, self)
end

UIFitSlideCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((NekoData.DataManager).DM_Game):SaveSpecialShapedScreen()
end

UIFitSlideCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local value = ((NekoData.BehaviorManager).BM_Game):GetSpecialShapedScreenValue()
  ;
  (self._slideBar):SetScrollValue(value / 100)
end

UIFitSlideCell.OnScrollbarValueChange = function(self)
  -- function num : 0_4 , upvalues : _ENV, UIManager
  local rate = (self._slideBar):GetScrollValue()
  local pixelValue = (math.floor)(rate * 1000)
  pixelValue = (math.floor)(pixelValue / 10)
  ;
  ((NekoData.DataManager).DM_Game):SetSpecialShapedScreenValue(pixelValue)
  ;
  (UIManager.SetPanelSpecialShapedScreen)(pixelValue)
end

UIFitSlideCell.OnBeginDrag = function(self)
  -- function num : 0_5
  ((self._delegate)._frame):SetSlide(false, true)
end

UIFitSlideCell.OnEndDrag = function(self)
  -- function num : 0_6
  ((self._delegate)._frame):SetSlide(true, true)
end

return UIFitSlideCell

