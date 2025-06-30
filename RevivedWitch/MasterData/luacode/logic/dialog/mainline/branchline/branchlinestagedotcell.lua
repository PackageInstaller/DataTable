-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlinestagedotcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BranchLineStageDotCell = class("BranchLineStageDotCell", Dialog)
BranchLineStageDotCell.AssetBundleName = "ui/layouts.sidestory"
BranchLineStageDotCell.AssetName = "SideStoryMainDot"
BranchLineStageDotCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineStageDotCell
  ((BranchLineStageDotCell.super).Ctor)(self, ...)
  self._data = {}
end

BranchLineStageDotCell.OnCreate = function(self)
  -- function num : 0_1
  self._lock = self:GetChild("MainLock")
  self._unLock = self:GetChild("MainUnlock")
  self._select = self:GetChild("MainSelect")
end

BranchLineStageDotCell.OnDestroy = function(self)
  -- function num : 0_2
end

BranchLineStageDotCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._lock):SetActive(data.lock)
  ;
  (self._unLock):SetActive((not data.lock and not data.select))
  ;
  (self._select):SetActive((not data.lock and data.select))
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return BranchLineStageDotCell

