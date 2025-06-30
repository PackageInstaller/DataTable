-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/delayedsecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SecondConfirmTable = (BeanManager.GetTableByName)("message.csecondconfirm")
local DelayedSecondConfirmDialog = class("DelayedSecondConfirmDialog", Dialog)
DelayedSecondConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
DelayedSecondConfirmDialog.AssetName = "SecondConfirmB"
DelayedSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DelayedSecondConfirmDialog
  ((DelayedSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._messageStacks = {}
  self._currentMessage = nil
  self._cancelBtnClickFunc = nil
  self._cancelBtnClickFuncArgs = nil
  self._confirmBtnClickFunc = nil
  self._confirmBtnClickFuncArgs = nil
  self._confirmId = nil
  self._confirmType = 0
  self._delayTime = nil
  self._confirmBtnTag = false
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

DelayedSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._cancelButton = self:GetChild("CancelButton")
  self._cancelButtonText = self:GetChild("CancelButton/_Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButtonText = self:GetChild("ConfirmButton/_Text")
  self._countDown = self:GetChild("CountDown")
  self._time = self:GetChild("Time")
  self._second = self:GetChild("Second")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

DelayedSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

DelayedSecondConfirmDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, SecondConfirmTable
  if (table.nums)(self._messageStacks) == 0 then
    (DialogManager.DestroySingletonDialog)("confirmbox.delayedsecondconfirmdialog")
    if self._task then
      (GameTimer.RemoveTask)(self._task)
    end
    return 
  end
  self._currentMessage = (self._messageStacks)[1]
  self._confirmId = (self._currentMessage).id
  local record = SecondConfirmTable:GetRecorder(self._confirmId)
  if not record then
    LogErrorFormat("SecondConfirmDialog", "SecondConfirm not exit! id : %s", self._confirmId)
    ;
    (table.remove)(self._messageStacks, 1)
    self:Refresh()
    return 
  end
  ;
  (self._text):SetText((TextManager.GetText)(record.messageTextID))
  self._confirmType = record.messagetype
  ;
  (self._cancelButtonText):SetText((TextManager.GetText)(record.leftbuttonTextID))
  ;
  (self._confirmButtonText):SetText((TextManager.GetText)(record.rightbuttonTextID))
  self._delayTime = record.count
  ;
  (self._time):SetText(self._delayTime)
  self._confirmBtnTag = false
  ;
  (self._confirmButton):SetInteractable(false)
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  self._task = (GameTimer.AddTask)(1, 1, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self._delayTime = self._delayTime - 1
    ;
    (self._time):SetText(self._delayTime)
    if self._delayTime == 0 and self._task then
      (GameTimer.RemoveTask)(self._task)
      self._confirmBtnTag = true
      ;
      (self._confirmButton):SetInteractable(true)
      ;
      (self._time):SetActive(false)
      ;
      (self._countDown):SetActive(false)
      ;
      (self._second):SetActive(false)
    end
  end
, nil)
  self._cancelBtnClickFunc = (self._currentMessage).nofunc
  self._cancelBtnClickFuncArgs = (self._currentMessage).noargs
  self._confirmBtnClickFunc = (self._currentMessage).yesfunc
  self._confirmBtnClickFuncArgs = (self._currentMessage).yesargs
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

DelayedSecondConfirmDialog.PushDialogSetting = function(self, id, parameter, yesfunc, yesargs, nofunc, noargs)
  -- function num : 0_4 , upvalues : _ENV
  local message = {}
  message.id = id
  message.parameter = parameter
  message.yesfunc = yesfunc
  message.yesargs = yesargs
  message.nofunc = nofunc
  message.noargs = noargs
  local repeatId = nil
  for i,v in ipairs(self._messageStacks) do
    if v.id == id then
      repeatId = id
      break
    end
  end
  do
    if repeatId then
      LogErrorFormat("DelayedSecondConfirmDialog", "Duplicate with existing ID: %s", repeatId)
    end
    ;
    (table.insert)(self._messageStacks, 1, message)
    self:Refresh()
  end
end

DelayedSecondConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self._canClickCancleBtn then
    return 
  end
  self._canClickCancleBtn = false
  if self._cancelBtnClickFunc then
    (self._cancelBtnClickFunc)(self._cancelBtnClickFuncArgs)
  end
  self._currentMessage = nil
  ;
  (table.remove)(self._messageStacks, 1)
  self:Refresh()
end

DelayedSecondConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self._canClickConfirmBtn then
    return 
  end
  self._canClickConfirmBtn = false
  if self._confirmBtnTag then
    if self._confirmBtnClickFunc then
      (self._confirmBtnClickFunc)(self._confirmBtnClickFuncArgs)
    end
    self._currentMessage = nil
    ;
    (table.remove)(self._messageStacks, 1)
    self:Refresh()
  end
end

return DelayedSecondConfirmDialog

