local ChrisRePlot = BeanManager.GetTableByName("dungeonselect.cchrisreplot")
local TableFrame = require("framework.ui.frame.table.tableframe")
local TypeEnum = {Main = 1, Brunch = 2}
local RemindDialog = class("RemindDialog", Dialog)
RemindDialog.AssetBundleName = "ui/layouts.activitychristmas"
RemindDialog.AssetName = "ActivityChristmasRemind"

function RemindDialog:Ctor(...)
  RemindDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {
    [TypeEnum.Main] = {},
    [TypeEnum.Brunch] = {}
  }
end

function RemindDialog:OnCreate()
  self._backBtn = self:GetChild("CloseBtn")
  self._title = self:GetChild("Back/Title")
  self._mainTxt = self:GetChild("Back/TitleTrunk")
  self._branchTxt = self:GetChild("Back/TitleBrunch")
  self._title:SetText(TextManager.GetText(1901216))
  self._mainTxt:SetText(TextManager.GetText(1901399))
  self._branchTxt:SetText(TextManager.GetText(1901400))
  self._contentPanel = self:GetChild("Back/Frame/Limit")
  self._mainPanel = self:GetChild("Back/Frame/Limit/FrameTrunk")
  self._branchPanel = self:GetChild("Back/Frame/Limit/FrameBranch")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._mainFrame = TableFrame.Create(self._mainPanel, self, false, false, false)
  self._branchFrame = TableFrame.Create(self._branchPanel, self, false, false, false)
  self._width, self._height = self._contentPanel:GetRectSize()
  self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX, self._offsetMaxY = self._contentPanel:GetAnchorAndOffset()
  self._main_width, self._main_height = self._mainPanel:GetRectSize()
  self._main_anchorMinX, self._main_anchorMinY, self._main_anchorMaxX, self._main_anchorMaxY, self._main_offsetMinX, self._main_offsetMinY, self._main_offsetMaxX, self._main_offsetMaxY = self._mainPanel:GetAnchorAndOffset()
  self._branch_width, self._branch_height = self._branchPanel:GetRectSize()
  self._branch_anchorMinX, self._branch_anchorMinY, self._branch_anchorMaxX, self._branch_anchorMaxY, self._branch_offsetMinX, self._branch_offsetMinY, self._branch_offsetMaxX, self._branch_offsetMaxY = self._branchPanel:GetAnchorAndOffset()
  self:Init()
end

function RemindDialog:OnDestroy()
  self._mainFrame:Destroy()
  self._branchFrame:Destroy()
end

function RemindDialog:Init()
  local allIds = ChrisRePlot:GetAllIds()
  for i = 1, #allIds do
    local record = ChrisRePlot:GetRecorder(allIds[i])
    if record.type == TypeEnum.Main then
      table.insert(self._data[TypeEnum.Main], {record = record})
    else
      table.insert(self._data[TypeEnum.Brunch], {record = record})
    end
  end
  self._mainFrame:ReloadAllCell()
  self._branchFrame:ReloadAllCell()
  local totalLength_main = self._mainFrame:GetTotalLength()
  local totalLength_branch = self._branchFrame:GetTotalLength()
  local len = totalLength_main
  if totalLength_main < totalLength_branch then
    len = totalLength_branch
  end
  self._mainPanel:SetAnchorAndOffset(self._main_anchorMinX, self._main_anchorMinY, self._main_anchorMaxX, self._main_anchorMaxY, self._main_offsetMinX, self._main_offsetMinY, self._main_offsetMaxX + (totalLength_main - self._main_width), self._main_offsetMaxY)
  self._branchPanel:SetAnchorAndOffset(self._branch_anchorMinX, self._branch_anchorMinY, self._branch_anchorMaxX, self._branch_anchorMaxY, self._branch_offsetMinX, self._branch_offsetMinY, self._branch_offsetMaxX + (totalLength_branch - self._branch_width), self._branch_offsetMaxY)
  self._contentPanel:SetAnchorAndOffset(self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX + (len - self._width), self._offsetMaxY)
  self._mainFrame:ReloadAllCell()
  self._branchFrame:ReloadAllCell()
end

function RemindDialog:NumberOfCell(frame)
  if frame == self._mainFrame then
    return #self._data[TypeEnum.Main]
  else
    return #self._data[TypeEnum.Brunch]
  end
end

function RemindDialog:CellAtIndex()
  return "activity.christmas.remindcell"
end

function RemindDialog:DataAtIndex(frame, index)
  if frame == self._mainFrame then
    return self._data[TypeEnum.Main][index]
  else
    return self._data[TypeEnum.Brunch][index]
  end
end

function RemindDialog:ShouldLengthChange()
  return true
end

function RemindDialog:OnBackBtnClicked()
  self:Destroy()
end

return RemindDialog
