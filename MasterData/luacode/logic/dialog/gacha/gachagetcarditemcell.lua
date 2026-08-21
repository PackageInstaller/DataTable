-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gachagetcarditemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GachaGetCardItemCell = class("GachaGetCardItemCell", Dialog)
GachaGetCardItemCell.AssetBundleName = "ui/layouts.gacha"
GachaGetCardItemCell.AssetName = "GachaGetCardItemCell"
GachaGetCardItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaGetCardItemCell
  ((GachaGetCardItemCell.super).Ctor)(self, ...)
end

GachaGetCardItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Back/Icon")
  self._num = self:GetChild("Back/Num")
end

GachaGetCardItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

GachaGetCardItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  local item = (Item.Create)(data.itemId)
  local image = item:GetIcon()
  ;
  (self._icon):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._num):SetText(data.itemNum)
end

return GachaGetCardItemCell

