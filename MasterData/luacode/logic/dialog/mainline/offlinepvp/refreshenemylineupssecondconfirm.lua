local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CArenaRefreshMatchCost = BeanManager.GetTableByName("dungeonselect.carenarefreshmatchcost")
local Item = require("logic.manager.experimental.types.item")
local RefreshEnemyLineupsSecondConfirm = class("RefreshEnemyLineupsSecondConfirm", Dialog)
RefreshEnemyLineupsSecondConfirm.AssetBundleName = "ui/layouts.offlinepvp"
RefreshEnemyLineupsSecondConfirm.AssetName = "OffLinePVPSecondConfirm2"

function RefreshEnemyLineupsSecondConfirm:Ctor(...)
  RefreshEnemyLineupsSecondConfirm.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function RefreshEnemyLineupsSecondConfirm:OnCreate()
  self._time = self:GetChild("Panel/Refresh/Time")
  self._title = self:GetChild("Panel/Text")
  self._coinIcon = self:GetChild("Panel/Num/Icon")
  self._coinNum = self:GetChild("Panel/Num/Text")
  self._cancelBtn = self:GetChild("Panel/CancelButton")
  self._confirmButton = self:GetChild("Panel/ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

function RefreshEnemyLineupsSecondConfirm:OnDestroy()
end

function RefreshEnemyLineupsSecondConfirm:Init(times)
  local recorder = CArenaRefreshMatchCost:GetRecorder(1)
  local limit = recorder.limit
  if times <= 0 then
    self._confirmButton:SetInteractable(false)
  end
  local str = TextManager.GetText(CStringRes:GetRecorder(1378).msgTextID)
  self._title:SetText(str)
  self._time:SetText(times)
  local cost = limit - times + 1
  cost = recorder.refreshCost[cost] or 0
  local str = tostring(cost)
  if 0 < cost then
    str = "-" .. str
  end
  self._coinNum:SetText(str)
  local item = Item.Create(DataCommon.PVPCoin)
  self._coinIcon:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  local totleMoney = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.PVPCoin)
  if cost > totleMoney then
    self._notEnough = true
  end
end

function RefreshEnemyLineupsSecondConfirm:OnConfirmBtnClick()
  if self._notEnough then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100256)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.battle.crefreshenemylineups")
  if csend then
    csend:Send()
  end
  self:Destroy()
end

function RefreshEnemyLineupsSecondConfirm:OnBackBtnClicked()
  self:Destroy()
end

return RefreshEnemyLineupsSecondConfirm
