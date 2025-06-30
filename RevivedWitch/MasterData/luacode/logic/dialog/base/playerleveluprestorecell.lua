-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/playerleveluprestorecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local PlayerLevelUpRestoreCell = class("PlayerLevelUpRestoreCell", Dialog)
PlayerLevelUpRestoreCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpRestoreCell.AssetName = "MagicLevelUpRestore"
PlayerLevelUpRestoreCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayerLevelUpRestoreCell
  ((PlayerLevelUpRestoreCell.super).Ctor)(self, ...)
end

PlayerLevelUpRestoreCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Txt2")
end

PlayerLevelUpRestoreCell.OnDestroy = function(self)
  -- function num : 0_2
end

PlayerLevelUpRestoreCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._txt):SetText(data.value)
end

return PlayerLevelUpRestoreCell

