local CMessagetipCfg = BeanManager.GetTableByName("message.cmessagetip")
local SwimsuitNextOpenDialog = class("SwimsuitNextOpenDialog", Dialog)
SwimsuitNextOpenDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimsuitNextOpenDialog.AssetName = "ActivitySummerNextOpen"

function SwimsuitNextOpenDialog:Ctor(...)
  SwimsuitNextOpenDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._confirmBtnClickFunc = nil
end

function SwimsuitNextOpenDialog:OnCreate()
  self._text = self:GetChild("Text1")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function SwimsuitNextOpenDialog:OnDestroy()
end

function SwimsuitNextOpenDialog:Init(msgId, parameter, yesfunc)
  local messageStr = TextManager.GetText(msgId)
  if string.find(messageStr, "parameter") then
    for i = 1, table.nums(parameter) do
      messageStr = string.gsub(messageStr, "%$parameter1%$", parameter[i], 1)
    end
  end
  self._text:SetText(messageStr)
  self._confirmBtnClickFunc = yesfunc
end

function SwimsuitNextOpenDialog:OnClickConfirmBtn()
  if self._confirmBtnClickFunc then
    self._confirmBtnClickFunc()
    self._confirmBtnClickFunc = nil
  end
  self:Destroy()
end

return SwimsuitNextOpenDialog
