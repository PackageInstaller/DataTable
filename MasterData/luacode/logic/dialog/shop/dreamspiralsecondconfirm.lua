local DreamSpiralSecondConfirm = class("DreamSpiralSecondConfirm", Dialog)
DreamSpiralSecondConfirm.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralSecondConfirm.AssetName = "BattlePassSecondConfirm"

function DreamSpiralSecondConfirm:Ctor(...)
  DreamSpiralSecondConfirm.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function DreamSpiralSecondConfirm:OnCreate()
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Num")
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmButtonClick, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function DreamSpiralSecondConfirm:OnDestroy()
end

function DreamSpiralSecondConfirm:SetData(showText, moneyItem, levelPrice)
  self._levelPrice = levelPrice
  self._text:SetText(showText)
  self._num:SetText(levelPrice)
  self._icon:SetSprite(moneyItem:GetIcon().assetBundle, moneyItem:GetIcon().assetName)
end

function DreamSpiralSecondConfirm:OnConfirmButtonClick()
  local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  if hasDiamond >= self._levelPrice then
    local cmd = LuaNetManager.CreateProtocol("protocol.activity.cpaytobuyagcoinlevel")
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
  DialogManager.DestroySingletonDialog("shop.dreamspiralsecondconfirm")
end

function DreamSpiralSecondConfirm:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("shop.dreamspiralsecondconfirm")
end

return DreamSpiralSecondConfirm
