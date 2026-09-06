local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
local NewPassiveSkillTipsDialog = class("NewPassiveSkillTipsDialog", Dialog)
NewPassiveSkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPassiveSkillTipsDialog.AssetName = "TalentDetail"

function NewPassiveSkillTipsDialog:Ctor(...)
  NewPassiveSkillTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
  self._roleKey = nil
end

function NewPassiveSkillTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, true, false, true)
  LuaNotificationCenter.AddObserver(self, self.OnRoleBreakUp, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backRectX, self._backRectY = self._back:GetRectSize()
  self._frameRectX, self._frameRectY = self._field:GetRectSize()
  self._backWidth, self._backHeight = self._back:GetDeltaSize()
  self._fieldWidth, self._fieldHeight = self._field:GetDeltaSize()
  self._backAnchoredx, self._backAnchoredy = self._back:GetAnchoredPosition()
  self._fieldAnchoredx, self._fieldAnchoredy = self._field:GetAnchoredPosition()
end

function NewPassiveSkillTipsDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function NewPassiveSkillTipsDialog:Init(data, isOtherUser)
  self._data = {}
  if isOtherUser then
    for i, v in ipairs(data) do
      local temp = {}
      temp.id = v.id
      temp.unlock = v.lock == 1
      table.insert(self._data, temp)
    end
    for i, v in ipairs(self._data) do
      v.count = #self._data
      v.index = i
    end
  else
    self._roleKey = data:GetRoleId()
    for i, v in ipairs(data:GetPassiveSkillList()) do
      local temp = {}
      temp.id = v.id
      temp.unlock = v.lock == 1
      table.insert(self._data, temp)
    end
    for i, v in ipairs(self._data) do
      v.count = #self._data
      v.index = i
    end
  end
  self._frame:ReloadAllCell()
  local delta = self._frame:GetTotalLength() - self._frameRectY
  if 0 < delta then
    self._back:SetDeltaSize(self._backWidth, self._backHeight + delta)
    self._field:SetDeltaSize(self._fieldWidth, self._fieldHeight + delta)
    local cellScreenPosition = self._back:GetLocalPointInUiRootPanel()
    local cell_height = self._backRectY + delta
    local posY = 0
    if cellScreenPosition.y + cell_height / 2 > UIRootOffsetMax.y then
      posY = cellScreenPosition.y + cell_height / 2 - UIRootOffsetMax.y
    end
    self._back:SetAnchoredPosition(self._backAnchoredx, self._backAnchoredy - posY)
    self._field:SetAnchoredPosition(self._fieldAnchoredx, self._fieldAnchoredy - posY)
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function NewPassiveSkillTipsDialog:NumberOfCell(frame, index)
  return #self._data
end

function NewPassiveSkillTipsDialog:CellAtIndex(frame, index)
  return "character.newpassiveskilltipscell"
end

function NewPassiveSkillTipsDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function NewPassiveSkillTipsDialog:OnRoleBreakUp(notification)
  if notification.userInfo.name == "sroleupdatebreaklv" and notification.userInfo.key == self._roleKey then
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(notification.userInfo.key)
    self:Init(role)
  end
end

function NewPassiveSkillTipsDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function NewPassiveSkillTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function NewPassiveSkillTipsDialog:ShouldLengthChange(frame)
  return true
end

return NewPassiveSkillTipsDialog
