-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitnextopendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMessagetipCfg = (BeanManager.GetTableByName)("message.cmessagetip")
local SwimsuitNextOpenDialog = class("SwimsuitNextOpenDialog", Dialog)
SwimsuitNextOpenDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimsuitNextOpenDialog.AssetName = "ActivitySummerNextOpen"
SwimsuitNextOpenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimsuitNextOpenDialog
  ((SwimsuitNextOpenDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._confirmBtnClickFunc = nil
end

SwimsuitNextOpenDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text1")
  self._confirmButton = self:GetChild("ConfirmButton")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

SwimsuitNextOpenDialog.OnDestroy = function(self)
  -- function num : 0_2
end

SwimsuitNextOpenDialog.Init = function(self, msgId, parameter, yesfunc)
  -- function num : 0_3 , upvalues : _ENV
  local messageStr = (TextManager.GetText)(msgId)
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

SwimsuitNextOpenDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4
  if self._confirmBtnClickFunc then
    (self._confirmBtnClickFunc)()
    self._confirmBtnClickFunc = nil
  end
  self:Destroy()
end

return SwimsuitNextOpenDialog

