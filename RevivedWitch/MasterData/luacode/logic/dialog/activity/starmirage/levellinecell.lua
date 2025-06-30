-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/levellinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelLineCell = class("LevelLineCell", Dialog)
LevelLineCell.AssetBundleName = "ui/layouts.activitystar"
LevelLineCell.AssetName = "ActivityStarCellLine"
LevelLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelLineCell
  ((LevelLineCell.super).Ctor)(self, ...)
end

LevelLineCell.OnCreate = function(self)
  -- function num : 0_1
end

LevelLineCell.OnDestroy = function(self)
  -- function num : 0_2
end

return LevelLineCell

