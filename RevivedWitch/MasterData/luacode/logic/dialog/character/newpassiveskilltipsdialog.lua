-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newpassiveskilltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
local NewPassiveSkillTipsDialog = class("NewPassiveSkillTipsDialog", Dialog)
NewPassiveSkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPassiveSkillTipsDialog.AssetName = "TalentDetail"
NewPassiveSkillTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewPassiveSkillTipsDialog
  ((NewPassiveSkillTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
  self._roleKey = nil
end

NewPassiveSkillTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleBreakUp, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backRectX = (self._back):GetRectSize()
  self._frameRectX = (self._field):GetRectSize()
  self._backWidth = (self._back):GetDeltaSize()
  self._fieldWidth = (self._field):GetDeltaSize()
  self._backAnchoredx = (self._back):GetAnchoredPosition()
  self._fieldAnchoredx = (self._field):GetAnchoredPosition()
end

NewPassiveSkillTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

NewPassiveSkillTipsDialog.Init = function(self, data, isOtherUser)
  -- function num : 0_3 , upvalues : _ENV, UIRootOffsetMax
  self._data = {}
  if isOtherUser then
    for i,v in ipairs(data) do
      local temp = {}
      temp.id = v.id
      temp.unlock = v.lock == 1
      ;
      (table.insert)(self._data, temp)
    end
    for i,v in ipairs(self._data) do
      v.count = #self._data
      v.index = i
    end
  else
    self._roleKey = data:GetRoleId()
    for i,v in ipairs(data:GetPassiveSkillList()) do
      local temp = {}
      temp.id = v.id
      temp.unlock = v.lock == 1
      ;
      (table.insert)(self._data, temp)
    end
    for i,v in ipairs(self._data) do
      v.count = #self._data
      v.index = i
    end
  end
  ;
  (self._frame):ReloadAllCell()
  local delta = (self._frame):GetTotalLength() - self._frameRectY
  if delta > 0 then
    (self._back):SetDeltaSize(self._backWidth, self._backHeight + delta)
    ;
    (self._field):SetDeltaSize(self._fieldWidth, self._fieldHeight + delta)
    local cellScreenPosition = (self._back):GetLocalPointInUiRootPanel()
    local cell_height = self._backRectY + delta
    local posY = 0
    if UIRootOffsetMax.y < cellScreenPosition.y + cell_height / 2 then
      posY = cellScreenPosition.y + cell_height / 2 - UIRootOffsetMax.y
    end
    ;
    (self._back):SetAnchoredPosition(self._backAnchoredx, self._backAnchoredy - (posY))
    ;
    (self._field):SetAnchoredPosition(self._fieldAnchoredx, self._fieldAnchoredy - (posY))
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

NewPassiveSkillTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._data
end

NewPassiveSkillTipsDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "character.newpassiveskilltipscell"
end

NewPassiveSkillTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

NewPassiveSkillTipsDialog.OnRoleBreakUp = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  if (notification.userInfo).name == "sroleupdatebreaklv" and (notification.userInfo).key == self._roleKey then
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((notification.userInfo).key)
    self:Init(role)
  end
end

NewPassiveSkillTipsDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

NewPassiveSkillTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

NewPassiveSkillTipsDialog.ShouldLengthChange = function(self, frame)
  -- function num : 0_10
  return true
end

return NewPassiveSkillTipsDialog

