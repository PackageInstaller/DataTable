-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/showtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ShowTabCell = class("ShowTabCell", Dialog)
ShowTabCell.AssetBundleName = "ui/layouts.setting"
ShowTabCell.AssetName = "SettingShow"
ShowTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShowTabCell
  ((ShowTabCell.super).Ctor)(self, ...)
end

ShowTabCell.OnCreate = function(self)
  -- function num : 0_1
end

ShowTabCell.OnDestroy = function(self)
  -- function num : 0_2
end

return ShowTabCell

