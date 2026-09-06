local BranchLineStageDotCell = class("BranchLineStageDotCell", Dialog)
BranchLineStageDotCell.AssetBundleName = "ui/layouts.sidestory"
BranchLineStageDotCell.AssetName = "SideStoryMainDot"

function BranchLineStageDotCell:Ctor(...)
  BranchLineStageDotCell.super.Ctor(self, ...)
  self._data = {}
end

function BranchLineStageDotCell:OnCreate()
  self._lock = self:GetChild("MainLock")
  self._unLock = self:GetChild("MainUnlock")
  self._select = self:GetChild("MainSelect")
end

function BranchLineStageDotCell:OnDestroy()
end

function BranchLineStageDotCell:RefreshCell(data)
  self._lock:SetActive(data.lock)
  self._unLock:SetActive(not data.lock and not data.select)
  self._select:SetActive(not data.lock and data.select)
end

return BranchLineStageDotCell
