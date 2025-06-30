-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/getpuzzledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GetPuzzleDialog = class("GetPuzzleDialog", Dialog)
GetPuzzleDialog.AssetBundleName = "ui/layouts.activitypuzzle"
GetPuzzleDialog.AssetName = "ActivityPuzzleUnlock"
GetPuzzleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GetPuzzleDialog
  ((GetPuzzleDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

GetPuzzleDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Back/Title")
  self._enterNewState = false
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimatorStateExit, self)
end

GetPuzzleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
end

GetPuzzleDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (self._queue)[1]
  if not cfg then
    self:Skip()
    return 
  end
  ;
  (self._text):SetText((TextManager.GetText)(cfg.ContentTextID))
  self._timer = (GameTimer.AddTask)((self._cfg).time, 0, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self._timer = nil
    ;
    (table.remove)(self._queue, 1)
    self:Refresh()
  end
)
end

GetPuzzleDialog.SetData = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  local recorder = (BeanManager.GetTableByName)("popups.cjigsawdialogconfig")
  id = tonumber(id)
  self._queue = {}
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

    if record.dialog_id == id then
      (self._queue)[#self._queue + 1] = record
    end
  end
  ;
  (table.sort)(self._queue, function(lhs, rhs)
    -- function num : 0_4_0
    do return lhs.index < rhs.index end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self._cfg = (self._queue)[1]
  self:Refresh()
end

GetPuzzleDialog.Skip = function(self)
  -- function num : 0_5
  if self._closing then
    return 
  end
  ;
  (self:GetRootWindow()):SetAnimatorTrigger("isClosed")
  self._closing = true
end

GetPuzzleDialog.OnAnimatorStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_6
  if stateName == (self._cfg).End then
    self:Destroy()
  end
end

return GetPuzzleDialog

