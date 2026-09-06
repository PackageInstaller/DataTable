local MsgPopDialog = class("MsgPopDialog", Dialog)
MsgPopDialog.AssetBundleName = "ui/layouts.chat"
MsgPopDialog.AssetName = "ChatNewSmallChat"

function MsgPopDialog:Ctor(...)
  MsgPopDialog.super.Ctor(self, ...)
  self._info = nil
  self._msgCell = {}
  self._curIndex = 0
end

function MsgPopDialog:OnCreate()
  self._mask = self:GetChild("Mask")
end

function MsgPopDialog:OnDestroy()
  for key, dialog in pairs(self._msgCell) do
    dialog:Destroy()
  end
  self._msgCell = {}
end

function MsgPopDialog:GetCurShowCellNum()
  local num = 0
  for key, dialog in pairs(self._msgCell) do
    if not dialog:IsHide() then
      num = num + 1
    end
  end
  return num
end

function MsgPopDialog:GetFirstHideCellIndex()
  for index, dialog in ipairs(self._msgCell) do
    if dialog:IsHide() then
      return index
    end
  end
  return 0
end

function MsgPopDialog:AddPopMsg(data)
  if self._msgCell[self._curIndex] then
    self._msgCell[self._curIndex]:PlayExitAnim()
  end
  if #self._msgCell < 4 and #self._msgCell == self:GetCurShowCellNum() then
    local cell = DialogManager.CreateDialog("chat.msgpopcell", self._mask._uiObject)
    table.insert(self._msgCell, cell)
    self._curIndex = #self._msgCell
  elseif self:GetCurShowCellNum() < #self._msgCell then
    self._curIndex = self:GetFirstHideCellIndex()
  else
    self._curIndex = self._curIndex + 1
    if self._curIndex > 3 then
      self._curIndex = 1
    end
  end
  self._msgCell[self._curIndex]:Refresh(data)
  if not self._task then
    self._task = GameTimer.AddTask(0, 0.5, function()
      self:CheckCloseDiaolg()
    end, nil)
  end
end

function MsgPopDialog:CheckCloseDiaolg()
  if self._task and self:GetCurShowCellNum() == 0 then
    GameTimer.RemoveTask(self._task)
    self._task = nil
    self:Destroy()
  end
end

return MsgPopDialog
