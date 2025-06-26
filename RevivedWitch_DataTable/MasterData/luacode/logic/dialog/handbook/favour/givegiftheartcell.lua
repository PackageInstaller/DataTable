-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/givegiftheartcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GiveGiftHeartCell = class("GiveGiftHeartCell", Dialog)
GiveGiftHeartCell.AssetBundleName = "ui/layouts.tujian"
GiveGiftHeartCell.AssetName = "FavourGiveHeartCell"
GiveGiftHeartCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GiveGiftHeartCell
  ((GiveGiftHeartCell.super).Ctor)(self, ...)
end

GiveGiftHeartCell.OnCreate = function(self)
  -- function num : 0_1
end

GiveGiftHeartCell.OnDestroy = function(self)
  -- function num : 0_2
end

GiveGiftHeartCell.RefreshCell = function(self, data)
  -- function num : 0_3
end

return GiveGiftHeartCell

