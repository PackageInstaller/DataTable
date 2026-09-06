local TableFrame = require("framework.ui.frame.table.tableframe")
local TrainAccountDialog = class("TrainAccountDialog", Dialog)
TrainAccountDialog.AssetBundleName = "ui/layouts.yard"
TrainAccountDialog.AssetName = "TrainFinish"

function TrainAccountDialog:Ctor(...)
  TrainAccountDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function TrainAccountDialog:OnCreate()
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, false, false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function TrainAccountDialog:OnDestroy()
  self._frame:Destroy()
end

function TrainAccountDialog:SetData(data)
  table.insert(self._data, {
    type = data.protocol.resultType,
    award = data.protocol.result,
    roleId = data.roleId
  })
  self._frame:ReloadAllCell()
  local width, height = self._panel:GetRectSize()
  local cellPanelWidth = width / 3 * #self._data
  self._panel:SetDeltaSize(cellPanelWidth, height)
  self._frame:ReloadAllCell()
end

function TrainAccountDialog:NumberOfCell(frame)
  return 1
end

function TrainAccountDialog:CellAtIndex(frame, index)
  return "traincamp.trainaccountcell"
end

function TrainAccountDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function TrainAccountDialog:OnBackBtnClicked()
  self:Destroy()
end

return TrainAccountDialog
