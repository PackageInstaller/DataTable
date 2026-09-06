local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.CabinName)
local ChangeCabinNameDialog = class("ChangeCabinNameDialog", Dialog)
ChangeCabinNameDialog.AssetBundleName = "ui/layouts.yard"
ChangeCabinNameDialog.AssetName = "HouseChangeName"

function ChangeCabinNameDialog:Ctor(...)
  ChangeCabinNameDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function ChangeCabinNameDialog:OnCreate()
  self._name = self:GetChild("Back/InputField")
  self._inputTextNum = self:GetChild("Back/Textnew1")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self:GetChild("Back/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1572, {MinWordCount, MaxWordCount}))
  self._name:Subscribe_ValueChangedEvent(self.OnNameUpdate, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self:Init()
end

function ChangeCabinNameDialog:OnDestroy()
end

function ChangeCabinNameDialog:Init()
  self._name:SetText(NekoData.BehaviorManager.BM_Cabin:GetName())
end

function ChangeCabinNameDialog:OnNameUpdate()
  local name = self._name:GetText()
  name = string.trim(name)
  self._changeName = name
  local count = utf8.len(name)
  if count > MaxWordCount then
    self._inputTextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1570, {count, MaxWordCount}))
  else
    self._inputTextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {count, MaxWordCount}))
  end
end

function ChangeCabinNameDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChangeCabinNameDialog:OnConfirmBtnClicked()
  local cchangroomName = LuaNetManager.CreateProtocol("protocol.yard.cchangroomname")
  if cchangroomName then
    cchangroomName.name = self._changeName
    cchangroomName:Send()
  end
end

return ChangeCabinNameDialog
