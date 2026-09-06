local GMMsgTipFrameDialog = class("GMMsgTipFrameDialog", Dialog)
GMMsgTipFrameDialog.AssetBundleName = "ui/layouts.toast"
GMMsgTipFrameDialog.AssetName = "ToastMain"
local INTERVAL = 0.2
local MAXTIME = 1

function GMMsgTipFrameDialog:Ctor(...)
  GMMsgTipFrameDialog.super.Ctor(self, ...)
  self._groupName = "Message"
  self._msgTipList = {}
  self._taskList = {}
  self._height = 0
  self._width = 0
end

function GMMsgTipFrameDialog:OnCreate()
  self._width, self._height = self:GetRootWindow():GetRectSize()
end

function GMMsgTipFrameDialog:OnDestroy()
  for i, v in ipairs(self._taskList) do
    GameTimer.RemoveTask(v)
    v = nil
  end
  for i, v in ipairs(self._msgTipList) do
    if v.cell then
      v.cell:Destroy()
      v.cell:RootWindowDestroy()
      v.cell = nil
    end
  end
end

function GMMsgTipFrameDialog:OnRefresh()
  if #self._msgTipList == 0 then
    DialogManager.DestroySingletonDialog("messagetip.msgtipframedialog")
    return
  end
  local _, height = self._msgTipList[1].cell:GetRootWindow():GetRectSize()
  local deltaHeight = 0
  local deleteMsgList = {}
  for index = 2, #self._msgTipList do
    local w, h = self._msgTipList[index - 1].cell:GetRootWindow():GetRectSize()
    deltaHeight = deltaHeight + h
    self._msgTipList[index].cell:GetRootWindow():SetYPosition(0, deltaHeight)
    if deltaHeight + h > self._height then
      table.insert(deleteMsgList, index)
    end
  end
  while deleteMsgList[#deleteMsgList] do
    local index = #deleteMsgList
    if self._msgTipList[index] and self._msgTipList[index].cell then
      self._msgTipList[index].cell:Destroy()
      if self._msgTipList[index].cell:GetRootWindow() then
        self._msgTipList[index].cell:RootWindowDestroy()
      end
      self._msgTipList[index].cell = nil
      table.remove(self._msgTipList, index)
    end
    table.remove(deleteMsgList, #deleteMsgList)
  end
end

function GMMsgTipFrameDialog:AddMessageTip(msg)
  local msgCell = {}
  msgCell.cell = DialogManager.CreateDialog("messagetip.msgtipcell", self:GetRootWindow()._uiObject)
  msgCell.cell:Refresh(msg)
  msgCell.str = msg
  local _, height = msgCell.cell:GetRootWindow():GetRectSize()
  msgCell.cell:GetRootWindow():SetYPosition(0, 0)
  table.insert(self._msgTipList, 1, msgCell)
  self._taskList[#self._msgTipList] = GameTimer.AddTask(3, 0, function()
    if #self._msgTipList > 0 and self._msgTipList[#self._msgTipList] and self._msgTipList[#self._msgTipList].cell then
      self._msgTipList[#self._msgTipList].cell:Destroy()
      if self._msgTipList[#self._msgTipList].cell:GetRootWindow() then
        self._msgTipList[#self._msgTipList].cell:RootWindowDestroy()
      end
      self._msgTipList[#self._msgTipList].cell = nil
      table.remove(self._msgTipList, #self._msgTipList)
    end
    if #self._msgTipList <= 0 then
      self:OnRefresh()
    end
  end, nil)
  self:OnRefresh()
end

function GMMsgTipFrameDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return GMMsgTipFrameDialog
