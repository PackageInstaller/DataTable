-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/forceupdatedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMessagetipCfg = (BeanManager.GetTableByName)("message.cmessagetip")
local ForceUpdateDialog = class("ForceUpdateDialog", Dialog)
ForceUpdateDialog.AssetBundleName = "ui/layouts.loading"
ForceUpdateDialog.AssetName = "ReconnectionSecondConfirm"
ForceUpdateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ForceUpdateDialog
  ((ForceUpdateDialog.super).Ctor)(self, ...)
  self._groupName = "ClickEffect"
end

ForceUpdateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButtonText = self:GetChild("ConfirmButton/_Text")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  self:Init(100422)
  ;
  (self._confirmButtonText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1654))
end

ForceUpdateDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ForceUpdateDialog.Init = function(self, msgId)
  -- function num : 0_3 , upvalues : CMessagetipCfg, _ENV
  local msgRecord = CMessagetipCfg:GetRecorder(msgId)
  local messageStr = (TextManager.GetText)(msgRecord.msgTextID)
  ;
  (self._text):SetText(messageStr)
end

ForceUpdateDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Game):JumpToTheStore(2)
  if SdkManager.IsOverseas then
    LogInfo("ForceUpdateDialog", "ApplicationQuit")
    ;
    (((CS.UnityEngine).Application).Quit)()
  end
end

return ForceUpdateDialog

