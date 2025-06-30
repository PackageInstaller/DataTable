-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/agcoinshopcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Collection = (LuaNetManager.CreateBean)("protocol.activity.collection")
local Item = require("logic.manager.experimental.types.item")
local AgCoinShopCell = class("AgCoinShopCell", Dialog)
AgCoinShopCell.AssetBundleName = "ui/layouts.baseshop"
AgCoinShopCell.AssetName = "CoinShopCell"
AgCoinShopCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AgCoinShopCell
  ((AgCoinShopCell.super).Ctor)(self, ...)
end

AgCoinShopCell.OnCreate = function(self)
  -- function num : 0_1
  self._topProgress = self:GetChild("LineTop")
  self._midProgress = self:GetChild("LineMid")
  self._bottomProgress = self:GetChild("LineDown")
  self._coinNum = self:GetChild("Txt")
  self._normalItemIcon = self:GetChild("ItemNormal/Image")
  self._normalItemNum = self:GetChild("ItemNormal/Num")
  self._normalLock = self:GetChild("ItemNormal/Lock")
  self._normalGetText = self:GetChild("ItemNormal/GetTxt")
  self._normalGetIcon = self:GetChild("ItemNormal/Checkmark")
  self._normalGrey = self:GetChild("ItemNormal/Grey")
  self._highItemIcon = self:GetChild("ItemHigh/Image")
  self._highItemNum = self:GetChild("ItemHigh/Num")
  self._highLock = self:GetChild("ItemHigh/Lock")
  self._highGetText = self:GetChild("ItemHigh/GetTxt")
  self._highGetIcon = self:GetChild("ItemHigh/Checkmark")
  self._highGrey = self:GetChild("ItemHigh/Grey")
  ;
  (self._normalItemIcon):Subscribe_PointerClickEvent(self.OnNormalItemClick, self)
  ;
  (self._highItemIcon):Subscribe_PointerClickEvent(self.OnHighItemClick, self)
  ;
  (self._normalGetText):Subscribe_PointerClickEvent(self.OnNormalItemGet, self)
  ;
  (self._highGetText):Subscribe_PointerClickEvent(self.OnHighItemGet, self)
end

AgCoinShopCell.OnDestroy = function(self)
  -- function num : 0_2
end

AgCoinShopCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, Collection
  local curCoin = ((NekoData.BehaviorManager).BM_Currency):GetAgCoin()
  local manager = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID))
  local progress = nil
  if data.index == 1 then
    progress = self._topProgress
    ;
    (self._topProgress):SetActive(true)
    ;
    (self._bottomProgress):SetActive(false)
    ;
    (self._midProgress):SetActive(false)
  else
    if manager:IsLastCoinNode(data.index) then
      progress = self._bottomProgress
      ;
      (self._topProgress):SetActive(false)
      ;
      (self._bottomProgress):SetActive(true)
      ;
      (self._midProgress):SetActive(false)
    else
      progress = self._midProgress
      ;
      (self._topProgress):SetActive(false)
      ;
      (self._bottomProgress):SetActive(false)
      ;
      (self._midProgress):SetActive(true)
    end
  end
  if data.coinNum <= curCoin then
    progress:SetFillAmount(1)
  else
    if (data.index - 1) * manager:GetCoinNodeSpacing() <= curCoin then
      local delta = curCoin - (data.index - 1) * manager:GetCoinNodeSpacing()
      local pro = delta / manager:GetCoinNodeSpacing()
      progress:SetFillAmount(pro)
    else
      do
        progress:SetFillAmount(0)
        ;
        (self._coinNum):SetText(data.coinNum)
        local item = (Item.Create)(data.commonItemId)
        ;
        (self._normalItemIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
        ;
        (self._normalItemNum):SetText(data.commonItemNum)
        ;
        (self._normalLock):SetActive(data.commonState == Collection.LOCK)
        ;
        (self._normalGetText):SetActive(data.commonState == Collection.UN_RECEIVE)
        ;
        (self._normalGetIcon):SetActive(data.commonState == Collection.RECEIVE)
        ;
        (self._normalGrey):SetActive(data.commonState == Collection.RECEIVE)
        item = (Item.Create)(data.highItemId)
        ;
        (self._highItemIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
        ;
        (self._highItemNum):SetText(data.highItemNum)
        ;
        (self._highLock):SetActive(data.highState ~= Collection.LOCK and manager:IsHighColltionLock())
        ;
        (self._highGetText):SetActive((data.highState == Collection.UN_RECEIVE and not manager:IsHighColltionLock()))
        ;
        (self._highGetIcon):SetActive((data.highState == Collection.RECEIVE and not manager:IsHighColltionLock()))
        ;
        (self._highGrey):SetActive(data.highState ~= Collection.RECEIVE and manager:IsHighColltionLock())
        -- DECOMPILER ERROR: 12 unprocessed JMP targets
      end
    end
  end
end

AgCoinShopCell.OnNormalItemClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  local tipsDialog = nil
  local width, height = (self._normalItemIcon):GetRectSize()
  tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    local data = {}
    data.item = (Item.Create)((self._cellData).commonItemId)
    tipsDialog:Init(data)
    tipsDialog:SetTipsPosition(width, height, (self._normalItemIcon):GetLocalPointInUiRootPanel())
  end
end

AgCoinShopCell.OnHighItemClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item
  local tipsDialog = nil
  local width, height = (self._highItemIcon):GetRectSize()
  tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    local data = {}
    data.item = (Item.Create)((self._cellData).highItemId)
    tipsDialog:Init(data)
    tipsDialog:SetTipsPosition(width, height, (self._highItemIcon):GetLocalPointInUiRootPanel())
  end
end

AgCoinShopCell.OnNormalItemGet = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivecollection")
  protocol.coinNum = (self._cellData).coinNum
  protocol.CollectionType = protocol.COMMON
  protocol:Send()
end

AgCoinShopCell.OnHighItemGet = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivecollection")
  protocol.coinNum = (self._cellData).coinNum
  protocol.CollectionType = protocol.HIGH
  protocol:Send()
end

return AgCoinShopCell

