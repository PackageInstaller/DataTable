-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushpanelstagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BossRushPanelStageCell = class("BossRushPanelStageCell", Dialog)
BossRushPanelStageCell.AssetBundleName = "ui/layouts.mainline"
BossRushPanelStageCell.AssetName = "BossRushPanelCellStageCell"
BossRushPanelStageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushPanelStageCell
  ((BossRushPanelStageCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

BossRushPanelStageCell.OnCreate = function(self)
  -- function num : 0_1
  self._noPass = self:GetChild("No")
  self._pass = self:GetChild("Yes")
end

BossRushPanelStageCell.OnDestroy = function(self)
  -- function num : 0_2
end

BossRushPanelStageCell.RefreshCell = function(self)
  -- function num : 0_3
  (self._pass):SetActive((self._cellData).pass)
  ;
  (self._noPass):SetActive(not (self._cellData).pass)
end

return BossRushPanelStageCell

