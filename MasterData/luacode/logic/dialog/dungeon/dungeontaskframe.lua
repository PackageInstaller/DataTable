local DungeonTaskFrame = class("DungeonTaskFrame", Dialog)
DungeonTaskFrame.AssetBundleName = "ui/layouts.dungeon"
DungeonTaskFrame.AssetName = "DungeonMenuTask1"
local TableFrame = require("framework.ui.frame.table.tableframe")
local tm = NekoData.BehaviorManager.BM_Task

function DungeonTaskFrame:Ctor(...)
  DungeonTaskFrame.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function DungeonTaskFrame:OnCreate()
  self._title = self:GetChild("Subtitle/Text")
  self._frame = self:GetChild("CellPanel")
  self._initialFrameAnchorX, self._initialFrameOffsetX = self._frame:GetHeight()
  self._initialAnchorX, self._initialOffsetX = self:GetRootWindow():GetHeight()
  self._anchoredX, self._anchoredY = self._frame:GetAnchoredPosition()
end

function DungeonTaskFrame:OnDestroy()
  if self._helper then
    self._helper:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function DungeonTaskFrame:RefreshCell()
  self._helper = self._helper or TableFrame.Create(self._frame, self, true, false, true)
  self._tasks = self._cellData.data
  self._helper:ReloadAllCell()
  self._title:SetText(BeanManager.GetTableByName("mission.cmissiontypeconfig"):GetRecorder(self._cellData.id).type)
  local length = self._helper:GetTotalLength()
  self._frame:SetHeight(self._initialFrameAnchorX, length)
  self._frame:SetAnchoredPosition(self._anchoredX, self._anchoredY)
  self:GetRootWindow():SetHeight(self._initialAnchorX, self._initialOffsetX + (length - self._initialFrameOffsetX))
  self._helper:ReloadAllCell()
end

function DungeonTaskFrame:NumberOfCell()
  return #self._tasks
end

function DungeonTaskFrame:CellAtIndex()
  return "dungeon.dungeontaskcell"
end

function DungeonTaskFrame:DataAtIndex(helper, index)
  return self._tasks[index]
end

function DungeonTaskFrame:ShouldLengthChange()
  return true
end

function DungeonTaskFrame:ShouldShowProgress()
  if self._cellData.progress == nil then
    return true
  end
  return self._cellData.progress
end

return DungeonTaskFrame
