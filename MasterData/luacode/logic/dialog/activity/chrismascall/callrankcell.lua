local CallRankCellHelper = require("logic.dialog.activity.chrismascall.callrankcellhelper")
local CallRankCell = class("CallRankCell", Dialog)
CallRankCell.AssetBundleName = "ui/layouts.activitychristmascall"
CallRankCell.AssetName = "ActivityChristmasCallRankCell"

function CallRankCell:Ctor(...)
  CallRankCell.super.Ctor(self, ...)
end

function CallRankCell:OnCreate()
  self._callRankCellHelper = CallRankCellHelper.Create(self:GetRootWindow())
end

function CallRankCell:OnDestroy()
  if self._callRankCellHelper then
    self._callRankCellHelper:OnDestroy()
  end
end

function CallRankCell:RefreshCell(data)
  if self._callRankCellHelper then
    self._callRankCellHelper:RefreshCell(data)
  end
end

return CallRankCell
