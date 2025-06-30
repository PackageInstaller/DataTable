-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/checkroleskilltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CheckRoleSkillTipsDialog = class("CheckRoleSkillTipsDialog", Dialog)
CheckRoleSkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckRoleSkillTipsDialog.AssetName = "SkillDetail1"
CheckRoleSkillTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CheckRoleSkillTipsDialog
  ((CheckRoleSkillTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

CheckRoleSkillTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backx = (self._back):GetPosition()
  self._backRectX = (self._back):GetRectSize()
  self._frameRectX = (self._field):GetRectSize()
end

CheckRoleSkillTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CheckRoleSkillTipsDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = {}
  for i,v in ipairs(data) do
    local temp = {}
    temp.itemId = v.skillItemId
    temp.skillLevelId = v.skillLevel
    ;
    (table.insert)(self._data, temp)
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  local delta = (self._frame):GetTotalLength() - self._frameRectY
  if delta > 0 then
    (self._back):SetHeight(0, self._backRectY + delta)
    ;
    (self._back):SetPosition(self._backx, self._backox, self._backy, self._backoy - delta)
  end
end

CheckRoleSkillTipsDialog.ShouldLengthChange = function(self)
  -- function num : 0_4
  return true
end

CheckRoleSkillTipsDialog.SetSkillTipsPosition = function(self, cell_width, cell_height, cellScreenPosition)
  -- function num : 0_5
  self._backWidth = (self._back):GetRectSize()
  local newPos = {}
  newPos.x = cellScreenPosition.x + cell_width / 2 - self._backWidth / 2
  newPos.y = cellScreenPosition.y + cell_height / 2 + self._backHeight / 2
  ;
  (self._back):SetAnchoredPosition(newPos.x, newPos.y)
end

CheckRoleSkillTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return #self._data
end

CheckRoleSkillTipsDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "mainline.bossrush.checkotherroleskilltipscell"
end

CheckRoleSkillTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._data)[index]
end

CheckRoleSkillTipsDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_9 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

CheckRoleSkillTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

return CheckRoleSkillTipsDialog

