-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/checkotherroleskilltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CheckOtherRoleSkillTipsDialog = class("CheckOtherRoleSkillTipsDialog", Dialog)
CheckOtherRoleSkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckOtherRoleSkillTipsDialog.AssetName = "SkillDetail"
CheckOtherRoleSkillTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CheckOtherRoleSkillTipsDialog
  ((CheckOtherRoleSkillTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

CheckOtherRoleSkillTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backx = (self._back):GetPosition()
  self._backRectX = (self._back):GetRectSize()
  self._frameRectX = (self._field):GetRectSize()
end

CheckOtherRoleSkillTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CheckOtherRoleSkillTipsDialog.Init = function(self, data)
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

CheckOtherRoleSkillTipsDialog.ShouldLengthChange = function(self)
  -- function num : 0_4
  return true
end

CheckOtherRoleSkillTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_5
  return #self._data
end

CheckOtherRoleSkillTipsDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.bossrush.checkotherroleskilltipscell"
end

CheckOtherRoleSkillTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

CheckOtherRoleSkillTipsDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:Destroy()
  end
end

return CheckOtherRoleSkillTipsDialog

