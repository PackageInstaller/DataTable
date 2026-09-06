local ReturnBattlePassSecondConfirm = class("ReturnBattlePassSecondConfirm", Dialog)
ReturnBattlePassSecondConfirm.AssetBundleName = "ui/layouts.baseshop"
ReturnBattlePassSecondConfirm.AssetName = "BattlePassSecondConfirm"

function ReturnBattlePassSecondConfirm:Ctor(...)
  ReturnBattlePassSecondConfirm.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ReturnBattlePassSecondConfirm:OnCreate()
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Num")
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmButtonClick, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ReturnBattlePassSecondConfirm:OnDestroy()
end

function ReturnBattlePassSecondConfirm:SetData(showText, moneyItem, levelPrice)
  self._levelPrice = levelPrice
  self._text:SetText(showText)
  self._num:SetText(levelPrice)
  self._icon:SetSprite(moneyItem:GetIcon().assetBundle, moneyItem:GetIcon().assetName)
end

function ReturnBattlePassSecondConfirm:OnConfirmButtonClick()
  local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  if hasDiamond >= self._levelPrice then
    local cmd = LuaNetManager.CreateProtocol("protocol.activity.cpaytobuyreturnpasslevel")
    if cmd then
      cmd:Send()
    end
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
      local dialog = DialogManager.GetDialog("shop.shopmaindialog")
      if dialog then
        DialogManager.DestroySingletonDialog("shop.shopmaindialog")
      end
      NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
    end, {}, nil, {})
  end
  self:Destroy()
end

function ReturnBattlePassSecondConfirm:OnBackBtnClicked()
  self:Destroy()
end

return ReturnBattlePassSecondConfirm
