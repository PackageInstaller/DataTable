-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/tasktipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainTaskTip = class("MainTaskTip", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
MainTaskTip.AssetBundleName = "ui/layouts.basetasklist"
MainTaskTip.AssetName = "TaskStoryTips"
MainTaskTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainTaskTip
  ((MainTaskTip.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MainTaskTip.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back/Back")
  self._title = self:GetChild("Back/Title")
  self._frame = self:GetChild("Back/ItemFrame")
  self._desc = self:GetChild("Back/Txt")
  self._helper = (TableFrame.Create)(self._frame, self, false, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._initialAnchorX = (self._frame):GetXPosition()
  _ = (self._frame):GetWidth()
end

MainTaskTip.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._helper then
    (self._helper):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MainTaskTip.SetData = function(self, task)
  -- function num : 0_3
  self._task = task
  ;
  (self._title):SetText((self._task):GetName())
  if not (self._task):GetHintText() then
    (self._desc):SetText((self._task):GetDesc())
    ;
    (self._helper):ReloadAllCell()
    local length = (self._helper):GetTotalLength()
    ;
    (self._frame):SetWidth(0, length)
    ;
    (self._frame):SetXPosition(self._initialAnchorX, self._initialOffsetX - (length - self._initialLength) / 2)
  end
end

MainTaskTip.OnGlobalPointerDown = function(self, args)
  -- function num : 0_4 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

MainTaskTip.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("task.tasktipdialog")
end

MainTaskTip.NumberOfCell = function(self, helper)
  -- function num : 0_6
  return #(self._task):GetAwards()
end

MainTaskTip.CellAtIndex = function(self, helper, index)
  -- function num : 0_7
  return "task.main.maintaskawardcell"
end

MainTaskTip.DataAtIndex = function(self, helper, index)
  -- function num : 0_8
  return ((self._task):GetAwards())[index]
end

return MainTaskTip

