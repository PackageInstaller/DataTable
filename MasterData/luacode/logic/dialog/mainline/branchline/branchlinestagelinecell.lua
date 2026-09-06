local BranchLineStageLineCell = class("BranchLineStageLineCell", Dialog)
BranchLineStageLineCell.AssetBundleName = "ui/layouts.sidestory"
BranchLineStageLineCell.AssetName = "SideStoryMainLine"

function BranchLineStageLineCell:Ctor(...)
  BranchLineStageLineCell.super.Ctor(self, ...)
  self._data = {}
end

function BranchLineStageLineCell:OnCreate()
  self._lock = self:GetChild("SmallLock")
  self._unLock = self:GetChild("SmallUnlock")
end

function BranchLineStageLineCell:OnDestroy()
end

function BranchLineStageLineCell:RefreshCell(data)
  self._lock:SetActive(data.lock)
  self._unLock:SetActive(not data.lock)
end

return BranchLineStageLineCell
