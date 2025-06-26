-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/refreshenemylineupssecondconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CArenaRefreshMatchCost = (BeanManager.GetTableByName)("dungeonselect.carenarefreshmatchcost")
local Item = require("logic.manager.experimental.types.item")
local RefreshEnemyLineupsSecondConfirm = class("RefreshEnemyLineupsSecondConfirm", Dialog)
RefreshEnemyLineupsSecondConfirm.AssetBundleName = "ui/layouts.offlinepvp"
RefreshEnemyLineupsSecondConfirm.AssetName = "OffLinePVPSecondConfirm2"
RefreshEnemyLineupsSecondConfirm.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RefreshEnemyLineupsSecondConfirm
  ((RefreshEnemyLineupsSecondConfirm.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

RefreshEnemyLineupsSecondConfirm.OnCreate = function(self)
  -- function num : 0_1
  self._time = self:GetChild("Panel/Refresh/Time")
  self._title = self:GetChild("Panel/Text")
  self._coinIcon = self:GetChild("Panel/Num/Icon")
  self._coinNum = self:GetChild("Panel/Num/Text")
  self._cancelBtn = self:GetChild("Panel/CancelButton")
  self._confirmButton = self:GetChild("Panel/ConfirmButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

RefreshEnemyLineupsSecondConfirm.OnDestroy = function(self)
  -- function num : 0_2
end

RefreshEnemyLineupsSecondConfirm.Init = function(self, times)
  -- function num : 0_3 , upvalues : CArenaRefreshMatchCost, _ENV, CStringRes, Item
  local recorder = CArenaRefreshMatchCost:GetRecorder(1)
  local limit = recorder.limit
  if times <= 0 then
    (self._confirmButton):SetInteractable(false)
  end
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1378)).msgTextID)
  ;
  (self._title):SetText(str)
  ;
  (self._time):SetText(times)
  local cost = limit - times + 1
  cost = (recorder.refreshCost)[cost] or 0
  local str = tostring(cost)
  if cost > 0 then
    str = "-" .. str
  end
  ;
  (self._coinNum):SetText(str)
  local item = (Item.Create)(DataCommon.PVPCoin)
  ;
  (self._coinIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
  local totleMoney = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.PVPCoin)
  if totleMoney < cost then
    self._notEnough = true
  end
end

RefreshEnemyLineupsSecondConfirm.OnConfirmBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._notEnough then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100256)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.crefreshenemylineups")
  if csend then
    csend:Send()
  end
  self:Destroy()
end

RefreshEnemyLineupsSecondConfirm.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return RefreshEnemyLineupsSecondConfirm

