-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/msgpopdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MsgPopDialog = class("MsgPopDialog", Dialog)
MsgPopDialog.AssetBundleName = "ui/layouts.chat"
MsgPopDialog.AssetName = "ChatNewSmallChat"
MsgPopDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MsgPopDialog
  ((MsgPopDialog.super).Ctor)(self, ...)
  self._info = nil
  self._msgCell = {}
  self._curIndex = 0
end

MsgPopDialog.OnCreate = function(self)
  -- function num : 0_1
  self._mask = self:GetChild("Mask")
end

MsgPopDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for key,dialog in pairs(self._msgCell) do
    dialog:Destroy()
  end
  self._msgCell = {}
end

MsgPopDialog.GetCurShowCellNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local num = 0
  for key,dialog in pairs(self._msgCell) do
    if not dialog:IsHide() then
      num = num + 1
    end
  end
  return num
end

MsgPopDialog.GetFirstHideCellIndex = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for index,dialog in ipairs(self._msgCell) do
    if dialog:IsHide() then
      return index
    end
  end
  return 0
end

MsgPopDialog.AddPopMsg = function(self, data)
  -- function num : 0_5 , upvalues : _ENV
  if (self._msgCell)[self._curIndex] then
    ((self._msgCell)[self._curIndex]):PlayExitAnim()
  end
  if #self._msgCell < 4 and #self._msgCell == self:GetCurShowCellNum() then
    local cell = (DialogManager.CreateDialog)("chat.msgpopcell", (self._mask)._uiObject)
    ;
    (table.insert)(self._msgCell, cell)
    self._curIndex = #self._msgCell
  else
    do
      if self:GetCurShowCellNum() < #self._msgCell then
        self._curIndex = self:GetFirstHideCellIndex()
      else
        self._curIndex = self._curIndex + 1
        if self._curIndex > 3 then
          self._curIndex = 1
        end
      end
      ;
      ((self._msgCell)[self._curIndex]):Refresh(data)
      if not self._task then
        self._task = (GameTimer.AddTask)(0, 0.5, function()
    -- function num : 0_5_0 , upvalues : self
    self:CheckCloseDiaolg()
  end
, nil)
      end
    end
  end
end

MsgPopDialog.CheckCloseDiaolg = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._task and self:GetCurShowCellNum() == 0 then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
    self:Destroy()
  end
end

return MsgPopDialog

