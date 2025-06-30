-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushlockcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BossRushPanelLockCell = class("BossRushPanelLockCell", Dialog)
BossRushPanelLockCell.AssetBundleName = "ui/layouts.mainline"
BossRushPanelLockCell.AssetName = "BossRushPanelCellLocked"
BossRushPanelLockCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushPanelLockCell
  ((BossRushPanelLockCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

BossRushPanelLockCell.OnCreate = function(self)
  -- function num : 0_1
end

BossRushPanelLockCell.OnDestroy = function(self)
  -- function num : 0_2
end

BossRushPanelLockCell.RefreshCell = function(self)
  -- function num : 0_3
end

return BossRushPanelLockCell

