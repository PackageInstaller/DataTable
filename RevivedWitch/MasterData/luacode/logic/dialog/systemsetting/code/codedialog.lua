-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/code/codedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CBindingCfg = (BeanManager.GetTableByName)("setting.cbindingcfg")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CodeDialog = class("CodeDialog", Dialog)
CodeDialog.AssetBundleName = "ui/layouts.setting"
CodeDialog.AssetName = "SettingNumber"
CodeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CodeDialog
  ((CodeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

CodeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._inputField = self:GetChild("Back/InputField")
  self._inputPlaceHolder = self:GetChild("Back/InputField/_Placeholder")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

CodeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

CodeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

CodeDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local str = (self._inputField):GetText()
  if str == "" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100183)
  else
    local protocol = (LuaNetManager.CreateProtocol)("protocol.item.cusegiftkey")
    if protocol then
      protocol.giftkey = str
      protocol:Send()
    end
  end
end

return CodeDialog

