-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/playerlevelupfunctioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local PlayerLevelUpFunctionCell = class("PlayerLevelUpFunctionCell", Dialog)
PlayerLevelUpFunctionCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpFunctionCell.AssetName = "MagicLevelUpFunction"
PlayerLevelUpFunctionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayerLevelUpFunctionCell
  ((PlayerLevelUpFunctionCell.super).Ctor)(self, ...)
end

PlayerLevelUpFunctionCell.OnCreate = function(self)
  -- function num : 0_1
  self._unlockTxt = self:GetChild("Txt2")
end

PlayerLevelUpFunctionCell.OnDestroy = function(self)
  -- function num : 0_2
end

PlayerLevelUpFunctionCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local str = (TextManager.GetText)(data.value)
  ;
  (self._unlockTxt):SetText(str)
end

return PlayerLevelUpFunctionCell

