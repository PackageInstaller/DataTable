local CArenaApConfig = BeanManager.GetTableByName("dungeonselect.carenaapconfig")
local Item = require("logic.manager.experimental.types.item")
local OffLinePVPExchangeKeyConfirm = class("OffLinePVPExchangeKeyConfirm", Dialog)
OffLinePVPExchangeKeyConfirm.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePVPExchangeKeyConfirm.AssetName = "OffLinePVPSecondConfirm1"

function OffLinePVPExchangeKeyConfirm:Ctor(...)
  OffLinePVPExchangeKeyConfirm.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function OffLinePVPExchangeKeyConfirm:OnCreate()
  self._times = self:GetChild("Num/Num")
  self._totleTimes = self:GetChild("Num/NumMax")
  self._coinIcon = self:GetChild("Icon")
  self._coinNum = self:GetChild("Num")
  self._keyIcon = self:GetChild("Icon2")
  self._keyNum = self:GetChild("Num2")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

function OffLinePVPExchangeKeyConfirm:OnDestroy()
end

function OffLinePVPExchangeKeyConfirm:Init(times)
  local recorder = CArenaApConfig:GetRecorder(1)
  local limit = recorder.exchangeTimes
  local times = NekoData.BehaviorManager.BM_Activity:GetKeyExchangeTimes()
  if times <= 0 then
    self._confirmButton:SetInteractable(false)
  end
  self._times:SetText(times)
  self._totleTimes:SetText(limit)
  local cost = limit - times + 1
  self._cost = recorder.exchangeScoreCost[cost]
  self._pvpCoinCount = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.PVPCoin)
  self._coinNum:SetText(self._cost)
  local item = Item.Create(DataCommon.PVPCoin)
  self._coinIcon:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  item = Item.Create(DataCommon.PVPKeys)
  self._keyIcon:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  self._keyNum:SetText(recorder.apCost)
end

function OffLinePVPExchangeKeyConfirm:OnConfirmBtnClick()
  if self._pvpCoinCount < self._cost then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100256)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.battle.caddarenaap")
  if csend then
    csend:Send()
  end
  self:Destroy()
end

function OffLinePVPExchangeKeyConfirm:OnBackBtnClicked()
  self:Destroy()
end

return OffLinePVPExchangeKeyConfirm
