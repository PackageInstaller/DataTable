local MonthLoginTipsDialog = class("MonthLoginTipsDialog", Dialog)
MonthLoginTipsDialog.AssetBundleName = "ui/layouts.welfare"
MonthLoginTipsDialog.AssetName = "MonthLoginTips"

function MonthLoginTipsDialog:Ctor(...)
  MonthLoginTipsDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function MonthLoginTipsDialog:OnCreate()
  self._shopBuy = self:GetChild("Btn1")
  self._taskGet = self:GetChild("Btn2")
  self._closeBtn = self:GetChild("ConfirmButton")
  self._shopBuy:Subscribe_PointerClickEvent(self.OnShopBuyClicked, self)
  self._taskGet:Subscribe_PointerClickEvent(self.OnTaskGetClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
end

function MonthLoginTipsDialog:OnDestroy()
end

function MonthLoginTipsDialog:OnShopBuyClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
  self:OnBackPressed()
end

function MonthLoginTipsDialog:OnTaskGetClicked()
  self:OnBackPressed()
end

function MonthLoginTipsDialog:OnCloseBtnClicked()
  self:OnBackPressed()
end

function MonthLoginTipsDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

return MonthLoginTipsDialog
