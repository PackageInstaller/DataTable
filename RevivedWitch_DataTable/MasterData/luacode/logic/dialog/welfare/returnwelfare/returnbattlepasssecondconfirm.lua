-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnbattlepasssecondconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ReturnBattlePassSecondConfirm = class("ReturnBattlePassSecondConfirm", Dialog)
ReturnBattlePassSecondConfirm.AssetBundleName = "ui/layouts.baseshop"
ReturnBattlePassSecondConfirm.AssetName = "BattlePassSecondConfirm"
ReturnBattlePassSecondConfirm.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnBattlePassSecondConfirm
  ((ReturnBattlePassSecondConfirm.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ReturnBattlePassSecondConfirm.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Num")
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelButton = self:GetChild("CancelButton")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmButtonClick, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ReturnBattlePassSecondConfirm.OnDestroy = function(self)
  -- function num : 0_2
end

ReturnBattlePassSecondConfirm.SetData = function(self, showText, moneyItem, levelPrice)
  -- function num : 0_3
  self._levelPrice = levelPrice
  ;
  (self._text):SetText(showText)
  ;
  (self._num):SetText(levelPrice)
  ;
  (self._icon):SetSprite((moneyItem:GetIcon()).assetBundle, (moneyItem:GetIcon()).assetName)
end

ReturnBattlePassSecondConfirm.OnConfirmButtonClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local hasDiamond = ((NekoData.BehaviorManager).BM_Currency):GetDiamond()
  if self._levelPrice <= hasDiamond then
    local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.cpaytobuyreturnpasslevel")
    if cmd then
      cmd:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_4_0 , upvalues : _ENV
    local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
    if dialog then
      (DialogManager.DestroySingletonDialog)("shop.shopmaindialog")
    end
    ;
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
      self:Destroy()
    end
  end
end

ReturnBattlePassSecondConfirm.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return ReturnBattlePassSecondConfirm

