local GiveFlowerResultDialog = class("GiveFlowerResultDialog", Dialog)
GiveFlowerResultDialog.AssetBundleName = "ui/layouts.flower"
GiveFlowerResultDialog.AssetName = "FlowerSendResult"

function GiveFlowerResultDialog:Ctor(...)
  GiveFlowerResultDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function GiveFlowerResultDialog:OnCreate()
  self._titleTxt = self:GetChild("Back/Txt1")
  self._giveBtn = self:GetChild("Back/SendButton")
  self._confirmBtn = self:GetChild("Back/ConfirmButton")
  self._giveBtn:Subscribe_PointerClickEvent(self.OnSendBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function GiveFlowerResultDialog:SetData(protocol)
  self._roleID = protocol.targetRoleId
  self._roleName = protocol.roleName
  self._titleTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2271, {
    self._roleName,
    protocol.num
  }))
end

function GiveFlowerResultDialog:OnSendBtnClicked()
  local flowerActInfo = NekoData.BehaviorManager.BM_Activity:GetFlowerActInfo()
  if not flowerActInfo then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
  else
    local flowerNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(flowerActInfo.flowerId)
    if flowerNum == 0 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100522)
    else
      DialogManager.CreateSingletonDialog("activity.flower.giveflowerdialog"):SetData(self._roleID, self._roleName, flowerNum)
    end
    self:Destroy()
  end
end

function GiveFlowerResultDialog:OnConfirmBtnClicked()
  self:Destroy()
end

return GiveFlowerResultDialog
