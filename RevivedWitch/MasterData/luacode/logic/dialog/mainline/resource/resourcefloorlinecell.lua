-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/resourcefloorlinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResourceFloorLineCell = class("ResourceFloorLineCell", Dialog)
ResourceFloorLineCell.AssetBundleName = "ui/layouts.mainline"
ResourceFloorLineCell.AssetName = "ResourceSelectCellLine"
ResourceFloorLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResourceFloorLineCell
  ((ResourceFloorLineCell.super).Ctor)(self, ...)
end

ResourceFloorLineCell.OnCreate = function(self)
  -- function num : 0_1
end

ResourceFloorLineCell.OnDestroy = function(self)
  -- function num : 0_2
end

ResourceFloorLineCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
end

ResourceFloorLineCell.SetPosition = function(self, ax, x, ay, y)
  -- function num : 0_4
  (self:GetRootWindow()):SetPosition(ax, x, ay, y)
end

ResourceFloorLineCell.SetZRotation = function(self, bx, by, ex, ey)
  -- function num : 0_5
  (self:GetRootWindow()):SetZRotation(bx, by, ex, ey)
end

ResourceFloorLineCell.SetWidth = function(self, width)
  -- function num : 0_6
  (self:GetRootWindow()):SetWidth(0, width)
end

return ResourceFloorLineCell

