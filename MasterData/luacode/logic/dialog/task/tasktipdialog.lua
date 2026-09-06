local MainTaskTip = class("MainTaskTip", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
MainTaskTip.AssetBundleName = "ui/layouts.basetasklist"
MainTaskTip.AssetName = "TaskStoryTips"

function MainTaskTip:Ctor(...)
  MainTaskTip.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MainTaskTip:OnCreate()
  self._back = self:GetChild("Back/Back")
  self._title = self:GetChild("Back/Title")
  self._frame = self:GetChild("Back/ItemFrame")
  self._desc = self:GetChild("Back/Txt")
  self._helper = TableFrame.Create(self._frame, self, false, false)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._initialAnchorX, self._initialOffsetX = self._frame:GetXPosition()
  _, self._initialLength = self._frame:GetWidth()
end

function MainTaskTip:OnDestroy()
  if self._helper then
    self._helper:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function MainTaskTip:SetData(task)
  self._task = task
  self._title:SetText(self._task:GetName())
  self._desc:SetText(self._task:GetHintText() or self._task:GetDesc())
  self._helper:ReloadAllCell()
  local length = self._helper:GetTotalLength()
  self._frame:SetWidth(0, length)
  self._frame:SetXPosition(self._initialAnchorX, self._initialOffsetX - (length - self._initialLength) / 2)
end

function MainTaskTip:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function MainTaskTip:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("task.tasktipdialog")
end

function MainTaskTip:NumberOfCell(helper)
  return #self._task:GetAwards()
end

function MainTaskTip:CellAtIndex(helper, index)
  return "task.main.maintaskawardcell"
end

function MainTaskTip:DataAtIndex(helper, index)
  return self._task:GetAwards()[index]
end

return MainTaskTip
