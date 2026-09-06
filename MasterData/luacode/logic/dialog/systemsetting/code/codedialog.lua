local CStringres = BeanManager.GetTableByName("message.cstringres")
local CBindingCfg = BeanManager.GetTableByName("setting.cbindingcfg")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CodeDialog = class("CodeDialog", Dialog)
CodeDialog.AssetBundleName = "ui/layouts.setting"
CodeDialog.AssetName = "SettingNumber"

function CodeDialog:Ctor(...)
  CodeDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function CodeDialog:OnCreate()
  self._inputField = self:GetChild("Back/InputField")
  self._inputPlaceHolder = self:GetChild("Back/InputField/_Placeholder")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function CodeDialog:OnDestroy()
end

function CodeDialog:OnBackBtnClicked()
  self:Destroy()
end

function CodeDialog:OnClickConfirmBtn()
  local str = self._inputField:GetText()
  if str == "" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100183)
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.item.cusegiftkey")
    if protocol then
      protocol.giftkey = str
      protocol:Send()
    end
  end
end

return CodeDialog
