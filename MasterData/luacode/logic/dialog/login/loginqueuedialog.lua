local LoginQueueDialog = class("LoginQueueDialog", Dialog)
LoginQueueDialog.AssetBundleName = "ui/layouts.login"
LoginQueueDialog.AssetName = "LoginLineUp"

function LoginQueueDialog:Ctor(...)
  LoginQueueDialog.super.Ctor(self, ...)
  self._groupName = "BrokenLine"
end

function LoginQueueDialog:OnCreate()
  self._ranking = self:GetChild("Num1")
  self._totalLength = self:GetChild("Num2")
  self._restTime = self:GetChild("Num3")
  self._cancleBtn = self:GetChild("CancelBtn")
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnCancleBtnClick, self)
end

function LoginQueueDialog:OnDestroy()
end

function LoginQueueDialog:SetData(protocol)
  if protocol.order ~= -1 then
    self._ranking:SetText(protocol.order)
  else
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1220).msgTextID)
    self._ranking:SetText(str)
  end
  self._totalLength:SetText(protocol.queuelength)
  local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1221).msgTextID)
  self._restTime:SetText(protocol.minutes .. str)
end

function LoginQueueDialog:OnCancleBtnClick()
  NekoData.BehaviorManager.BM_Login:CancleLoginQueue()
  self:Destroy()
end

return LoginQueueDialog
