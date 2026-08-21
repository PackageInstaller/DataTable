-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/entrydetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local EntryDetailDialog = class("EntryDetailDialog", Dialog)
EntryDetailDialog.AssetBundleName = "ui/layouts.activitystar"
EntryDetailDialog.AssetName = "ActivityStarBossBuff"
EntryDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EntryDetailDialog
  ((EntryDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

EntryDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._back = self:GetChild("BackImage")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

EntryDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

EntryDetailDialog.Init = function(self, entryList)
  -- function num : 0_3
  self._entryList = entryList
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

EntryDetailDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._entryList
end

EntryDetailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "activity.starmirage.entrydetailcell"
end

EntryDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._entryList)[index]
end

EntryDetailDialog.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

EntryDetailDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

EntryDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return EntryDetailDialog

