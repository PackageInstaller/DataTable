-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/wishcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local WishCell = class("WishCell", Dialog)
WishCell.AssetBundleName = "ui/layouts.activitylogin"
WishCell.AssetName = "ActivityLoginWishCell"
WishCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WishCell
  ((WishCell.super).Ctor)(self, ...)
end

WishCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Select1/_Text")
  self._select = self:GetChild("Select1/Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootClicked, self)
end

WishCell.OnDestroy = function(self)
  -- function num : 0_2
end

WishCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._text):SetText((TextManager.GetText)((self._cellData).textID))
  ;
  (self._select):SetActive((self._cellData).select)
end

WishCell.OnRootClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnOneCellClicked((self._cellData).index)
end

return WishCell

