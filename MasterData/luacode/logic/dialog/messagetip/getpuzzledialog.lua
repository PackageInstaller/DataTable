local GetPuzzleDialog = class("GetPuzzleDialog", Dialog)
GetPuzzleDialog.AssetBundleName = "ui/layouts.activitypuzzle"
GetPuzzleDialog.AssetName = "ActivityPuzzleUnlock"

function GetPuzzleDialog:Ctor(...)
  GetPuzzleDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function GetPuzzleDialog:OnCreate()
  self._text = self:GetChild("Back/Title")
  self._enterNewState = false
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimatorStateExit, self)
end

function GetPuzzleDialog:OnDestroy()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
end

function GetPuzzleDialog:Refresh()
  local cfg = self._queue[1]
  if not cfg then
    self:Skip()
    return
  end
  self._text:SetText(TextManager.GetText(cfg.ContentTextID))
  self._timer = GameTimer.AddTask(self._cfg.time, 0, function()
    self._timer = nil
    table.remove(self._queue, 1)
    self:Refresh()
  end)
end

function GetPuzzleDialog:SetData(id)
  local recorder = BeanManager.GetTableByName("popups.cjigsawdialogconfig")
  id = tonumber(id)
  self._queue = {}
  for _, i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.dialog_id == id then
      self._queue[#self._queue + 1] = record
    end
  end
  table.sort(self._queue, function(lhs, rhs)
    return lhs.index < rhs.index
  end)
  self._cfg = self._queue[1]
  self:Refresh()
end

function GetPuzzleDialog:Skip()
  if self._closing then
    return
  end
  self:GetRootWindow():SetAnimatorTrigger("isClosed")
  self._closing = true
end

function GetPuzzleDialog:OnAnimatorStateExit(handle, stateName, normalizedTime)
  if stateName == self._cfg.End then
    self:Destroy()
  end
end

return GetPuzzleDialog
