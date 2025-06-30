-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/disconnectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMessagetipCfg = (BeanManager.GetTableByName)("message.cmessagetip")
local DisconnectDialog = class("DisconnectDialog", Dialog)
DisconnectDialog.AssetBundleName = "ui/layouts.loading"
DisconnectDialog.AssetName = "ReconnectionSecondConfirm"
DisconnectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DisconnectDialog
  ((DisconnectDialog.super).Ctor)(self, ...)
  self._groupName = "BrokenLine"
  self._confirmBtnClickFunc = nil
end

DisconnectDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

DisconnectDialog.OnDestroy = function(self)
  -- function num : 0_2
end

DisconnectDialog.Init = function(self, msgId, parameter, yesfunc)
  -- function num : 0_3 , upvalues : CMessagetipCfg, _ENV
  local msgRecord = CMessagetipCfg:GetRecorder(msgId)
  local messageStr = (TextManager.GetText)(msgRecord.msgTextID)
  if (string.find)(messageStr, "parameter") then
    for i = 1, (table.nums)(parameter) do
      messageStr = (string.gsub)(messageStr, "%$parameter1%$", parameter[i], 1)
    end
  end
  do
    ;
    (self._text):SetText(messageStr)
    self._confirmBtnClickFunc = yesfunc
  end
end

DisconnectDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4
  if self._confirmBtnClickFunc then
    (self._confirmBtnClickFunc)()
    self._confirmBtnClickFunc = nil
  end
  self:Destroy()
end

return DisconnectDialog

