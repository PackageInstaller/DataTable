-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/secondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SecondConfirmTable = (BeanManager.GetTableByName)("message.csecondconfirm")
local SecondConfirmDialog = class("SecondConfirmDialog", Dialog)
SecondConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
SecondConfirmDialog.AssetName = "SecondConfirmA"
SecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SecondConfirmDialog
  ((SecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._messageStacks = {}
  self._currentMessage = nil
  self._cancelBtnClickFunc = nil
  self._cancelBtnClickFuncArgs = nil
  self._confirmBtnClickFunc = nil
  self._confirmBtnClickFuncArgs = nil
  self._confirmId = nil
  self._confirmType = 0
  self._guideEffectHandler = nil
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

SecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._cancelButton = self:GetChild("CancelButton")
  self._cancelButtonText = self:GetChild("CancelButton/_Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButtonText = self:GetChild("ConfirmButton/_Text")
  self._guideEffect = self:GetChild("ConfirmButton/Effect")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

SecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SecondConfirmDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, SecondConfirmTable
  if (table.nums)(self._messageStacks) == 0 then
    (DialogManager.DestroySingletonDialog)("confirmbox.secondconfirmdialog")
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
  local messageStr = (TextManager.GetText)(record.messageTextID)
  if (string.find)(messageStr, "parameter") then
    for i = 1, (table.nums)((self._currentMessage).parameter) do
      messageStr = (string.gsub)(messageStr, "%$parameter" .. i .. "%$", ((self._currentMessage).parameter)[i])
    end
  end
  do
    ;
    (self._text):SetText(messageStr)
    self._confirmType = record.messagetype
    ;
    (self._cancelButtonText):SetText((TextManager.GetText)(record.leftbuttonTextID))
    ;
    (self._confirmButtonText):SetText((TextManager.GetText)(record.rightbuttonTextID))
    self._cancelBtnClickFunc = (self._currentMessage).nofunc
    self._cancelBtnClickFuncArgs = (self._currentMessage).noargs
    self._confirmBtnClickFunc = (self._currentMessage).yesfunc
    self._confirmBtnClickFuncArgs = (self._currentMessage).yesargs
    self._canClickCancleBtn = true
    self._canClickConfirmBtn = true
  end
end

SecondConfirmDialog.PushDialogSetting = function(self, id, parameter, yesfunc, yesargs, nofunc, noargs)
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
      LogErrorFormat("SecondConfirmDialog", "Duplicate with existing ID: %s", repeatId)
    end
    ;
    (table.insert)(self._messageStacks, message)
    self:Refresh()
  end
end

SecondConfirmDialog.LoadData = function(self, data)
  -- function num : 0_5
  self._messageStacks = data
  self:Refresh()
end

SecondConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self._canClickCancleBtn then
    return 
  end
  self._canClickCancleBtn = false
  if self._cancelBtnClickFunc then
    (self._cancelBtnClickFunc)(self._cancelBtnClickFuncArgs)
    self._cancelBtnClickFunc = nil
  end
  self._currentMessage = nil
  ;
  (table.remove)(self._messageStacks, 1)
  self:Refresh()
end

SecondConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self._canClickConfirmBtn then
    return 
  end
  self._canClickConfirmBtn = false
  if self._confirmBtnClickFunc then
    (self._confirmBtnClickFunc)(self._confirmBtnClickFuncArgs)
    self._confirmBtnClickFunc = nil
  end
  self._currentMessage = nil
  ;
  (table.remove)(self._messageStacks, 1)
  self:Refresh()
end

SecondConfirmDialog.GetCurMessageId = function(self)
  -- function num : 0_8
  return self._confirmId
end

return SecondConfirmDialog

