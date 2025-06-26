-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlinestagelinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BranchLineStageLineCell = class("BranchLineStageLineCell", Dialog)
BranchLineStageLineCell.AssetBundleName = "ui/layouts.sidestory"
BranchLineStageLineCell.AssetName = "SideStoryMainLine"
BranchLineStageLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineStageLineCell
  ((BranchLineStageLineCell.super).Ctor)(self, ...)
  self._data = {}
end

BranchLineStageLineCell.OnCreate = function(self)
  -- function num : 0_1
  self._lock = self:GetChild("SmallLock")
  self._unLock = self:GetChild("SmallUnlock")
end

BranchLineStageLineCell.OnDestroy = function(self)
  -- function num : 0_2
end

BranchLineStageLineCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._lock):SetActive(data.lock)
  ;
  (self._unLock):SetActive(not data.lock)
end

return BranchLineStageLineCell

