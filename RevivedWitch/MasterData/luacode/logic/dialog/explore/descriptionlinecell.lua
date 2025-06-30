-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/descriptionlinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DescriptionLineCell = class("DescriptionLineCell", Dialog)
DescriptionLineCell.AssetBundleName = "ui/layouts.yard"
DescriptionLineCell.AssetName = "YardExploreDetailFrame"
DescriptionLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DescriptionLineCell
  ((DescriptionLineCell.super).Ctor)(self, ...)
end

DescriptionLineCell.OnCreate = function(self)
  -- function num : 0_1
end

DescriptionLineCell.OnDestroy = function(self)
  -- function num : 0_2
end

DescriptionLineCell.RefreshCell = function(self, data)
  -- function num : 0_3
end

return DescriptionLineCell

