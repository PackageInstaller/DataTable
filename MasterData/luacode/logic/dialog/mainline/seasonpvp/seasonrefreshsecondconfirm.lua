local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CArenaRefreshMatchCost = BeanManager.GetTableByName("dungeonselect.carenarefreshmatchcost")
local Item = require("logic.manager.experimental.types.item")
local SeasonRefreshSecondConfirm = class("SeasonRefreshSecondConfirm", Dialog)
SeasonRefreshSecondConfirm.AssetBundleName = "ui/layouts.offlinepvp"
SeasonRefreshSecondConfirm.AssetName = "OffLinePVPSecondConfirm2"

function SeasonRefreshSecondConfirm:Ctor(...)
  SeasonRefreshSecondConfirm.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SeasonRefreshSecondConfirm:OnCreate()
  self._time = self:GetChild("Panel/Refresh/Time")
  self._title = self:GetChild("Panel/Text")
  self._coinIcon = self:GetChild("Panel/Num/Icon")
  self._coinNum = self:GetChild("Panel/Num/Text")
  self._cancelBtn = self:GetChild("Panel/CancelButton")
  self._confirmButton = self:GetChild("Panel/ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

function SeasonRefreshSecondConfirm:OnDestroy()
end

function SeasonRefreshSecondConfirm:Init(times)
end

function SeasonRefreshSecondConfirm:OnConfirmBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictresetenemy")
  if csend then
    csend:Send()
  end
  self:Destroy()
end

function SeasonRefreshSecondConfirm:OnBackBtnClicked()
  self:Destroy()
end

return SeasonRefreshSecondConfirm
