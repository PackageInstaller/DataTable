-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprefreshcointips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local UIManager = ((CS.PixelNeko).UI).UIManager
local ShopRefreshCoinTips = class("ShopRefreshCoinTips", Dialog)
ShopRefreshCoinTips.AssetBundleName = "ui/layouts.baseshop"
ShopRefreshCoinTips.AssetName = "ShopRefreshSecondConfirm"
ShopRefreshCoinTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRefreshCoinTips
  ((ShopRefreshCoinTips.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShopRefreshCoinTips.OnCreate = function(self)
  -- function num : 0_1
  self._leftNum = self:GetChild("BackImage/Text3")
  self._image = self:GetChild("BackImage/Num/Icon")
  self._cost = self:GetChild("BackImage/Num/Num2")
  self._have = self:GetChild("BackImage/Num/Num1")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._cancelBtn = self:GetChild("BackImage/CancelButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ShopRefreshCoinTips.OnDestroy = function(self)
  -- function num : 0_2
end

ShopRefreshCoinTips.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV, Item
  local moneyType = ((NekoData.BehaviorManager).BM_Shop):GetShopRefreshCointCurrencyType()
  local item = (Item.Create)(moneyType)
  local imageRecord = item:GetIcon()
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local left = ((NekoData.BehaviorManager).BM_Shop):GetShopRefreshCointLeftChange()
  ;
  (self._leftNum):SetText(left)
  self._totalMoney = 0
  if moneyType == 35001 then
    self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetDiamond()
  else
    if moneyType == 35002 then
      self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
    else
      if moneyType == 35003 then
        self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
      else
        if moneyType == 35017 then
          self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetAgCoin()
        else
          if moneyType == 35009 then
            self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetFriendShip()
          else
            if moneyType == 35010 then
              self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetEther()
            else
              if moneyType == 35011 then
                self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetWhiteCoin()
              else
                if moneyType == 35012 then
                  self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetGoldCoin()
                else
                  if moneyType == 35018 then
                    self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetFurnitureCion()
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  ;
  (self._have):SetText(self._totalMoney)
  local cost = ((NekoData.BehaviorManager).BM_Shop):GetShopRefreshCointNextTimeCost()
  ;
  (self._cost):SetText("-" .. cost)
  if self._totalMoney < cost or left <= 0 then
    (self._confirmBtn):SetInteractable(false)
  else
    ;
    (self._confirmBtn):SetInteractable(true)
  end
end

ShopRefreshCoinTips.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.crefreshfriendshop")
  if protocol then
    protocol.shopType = 9
    protocol:Send()
  end
  self:Destroy()
end

ShopRefreshCoinTips.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

ShopRefreshCoinTips.OnDialogClicked = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:Destroy()
  end
end

return ShopRefreshCoinTips

