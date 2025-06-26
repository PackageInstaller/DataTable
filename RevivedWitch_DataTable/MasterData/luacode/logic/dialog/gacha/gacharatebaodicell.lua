-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharatebaodicell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GachaRateBaoDiCell = class("GachaRateBaoDiCell", Dialog)
GachaRateBaoDiCell.AssetBundleName = "ui/layouts.gacha"
GachaRateBaoDiCell.AssetName = "GachaRateBaoDi"
GachaRateBaoDiCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaRateBaoDiCell
  ((GachaRateBaoDiCell.super).Ctor)(self, ...)
end

GachaRateBaoDiCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._txt = self:GetChild("Text")
  self._rootWindow_anchorY = (self:GetRootWindow()):GetHeight()
  self._sizeDelta_width = (self._txt):GetRectSize()
  self._txt_anchorMinX = (self._txt):GetAnchorAndOffset()
end

GachaRateBaoDiCell.OnDestroy = function(self)
  -- function num : 0_2
end

GachaRateBaoDiCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._title):SetText((TextManager.GetText)(data.title))
  ;
  (self._txt):SetText(data.describe)
  local _, textHeight = (self._txt):GetPreferredSize()
  local delta = textHeight - self._sizeDelta_height
  ;
  (self._txt):SetAnchorAndOffset(self._txt_anchorMinX, self._txt_anchorMinY, self._txt_anchorMaxX, self._txt_anchorMaxY, self._txt_offsetMinX, self._txt_offsetMinY - delta, self._txt_offsetMaxX, self._txt_offsetMaxY)
  ;
  (self:GetRootWindow()):SetHeight(self._rootWindow_anchorY, self._rootWindow_offsetY + delta)
end

return GachaRateBaoDiCell

