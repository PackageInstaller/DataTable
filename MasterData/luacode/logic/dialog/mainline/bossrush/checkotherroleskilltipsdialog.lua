local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local CheckOtherRoleSkillTipsDialog = class("CheckOtherRoleSkillTipsDialog", Dialog)
CheckOtherRoleSkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckOtherRoleSkillTipsDialog.AssetName = "SkillDetail"

function CheckOtherRoleSkillTipsDialog:Ctor(...)
  CheckOtherRoleSkillTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function CheckOtherRoleSkillTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, true, false, true)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backx, self._backox, self._backy, self._backoy = self._back:GetPosition()
  self._backRectX, self._backRectY = self._back:GetRectSize()
  self._frameRectX, self._frameRectY = self._field:GetRectSize()
end

function CheckOtherRoleSkillTipsDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function CheckOtherRoleSkillTipsDialog:Init(data)
  self._data = {}
  for i, v in ipairs(data) do
    local temp = {}
    temp.itemId = v.skillItemId
    temp.skillLevelId = v.skillLevel
    table.insert(self._data, temp)
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  local delta = self._frame:GetTotalLength() - self._frameRectY
  if 0 < delta then
    self._back:SetHeight(0, self._backRectY + delta)
    self._back:SetPosition(self._backx, self._backox, self._backy, self._backoy - delta)
  end
end

function CheckOtherRoleSkillTipsDialog:ShouldLengthChange()
  return true
end

function CheckOtherRoleSkillTipsDialog:NumberOfCell(frame, index)
  return #self._data
end

function CheckOtherRoleSkillTipsDialog:CellAtIndex(frame, index)
  return "mainline.bossrush.checkotherroleskilltipscell"
end

function CheckOtherRoleSkillTipsDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function CheckOtherRoleSkillTipsDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:Destroy()
  end
end

return CheckOtherRoleSkillTipsDialog
