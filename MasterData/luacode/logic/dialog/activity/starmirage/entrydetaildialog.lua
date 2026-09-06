local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local EntryDetailDialog = class("EntryDetailDialog", Dialog)
EntryDetailDialog.AssetBundleName = "ui/layouts.activitystar"
EntryDetailDialog.AssetName = "ActivityStarBossBuff"

function EntryDetailDialog:Ctor(...)
  EntryDetailDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function EntryDetailDialog:OnCreate()
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._back = self:GetChild("BackImage")
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function EntryDetailDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EntryDetailDialog:Init(entryList)
  self._entryList = entryList
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function EntryDetailDialog:NumberOfCell(frame, index)
  return #self._entryList
end

function EntryDetailDialog:CellAtIndex(frame, index)
  return "activity.starmirage.entrydetailcell"
end

function EntryDetailDialog:DataAtIndex(frame, index)
  return self._entryList[index]
end

function EntryDetailDialog:ShouldLengthChange()
  return true
end

function EntryDetailDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function EntryDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

return EntryDetailDialog
