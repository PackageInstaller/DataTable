-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopcharresolvepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ShopCharResolvePage = class("ShopCharResolvePage", Dialog)
ShopCharResolvePage.AssetBundleName = "ui/layouts.baseshop"
ShopCharResolvePage.AssetName = "CharResolveShop"
local BottomToTop = 3
ShopCharResolvePage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopCharResolvePage
  ((ShopCharResolvePage.super).Ctor)(self, ...)
end

ShopCharResolvePage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame
  self._whiteBtn = self:GetChild("GroupBtn1")
  self._goldBtn = self:GetChild("GroupBtn2")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._refreshText = self:GetChild("Refresh/Time")
  self._refreshBoard = self:GetChild("Refresh")
  self._cellArea = self:GetChild("CellFrame")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 4)
  ;
  (self._whiteBtn):Subscribe_PointerClickEvent(self.OnWhiteBtnClicked, self)
  ;
  (self._goldBtn):Subscribe_PointerClickEvent(self.OnGoldBtnClicked, self)
  ;
  (self._whiteBtn):SetSelected(true)
end

ShopCharResolvePage.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

ShopCharResolvePage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data.goodInfo
  self._shopInfo = ((NekoData.BehaviorManager).BM_Shop):GetShopInfoByID((self._delegate)._selectShopID)
  if tonumber((self._shopInfo).closeTimeShow) == 0 then
    (self._refreshBoard):SetActive(false)
  else
    ;
    (self._refreshBoard):SetActive(true)
    ;
    (self._refreshText):SetText((self._shopInfo).closeTimeShow)
  end
  ;
  (self._cellFrame):ReloadAllCell()
end

ShopCharResolvePage.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

ShopCharResolvePage.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.shopgeneralcell"
end

ShopCharResolvePage.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local data = {}
  data.iteminfo = (self._data)[index]
  return data
end

ShopCharResolvePage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_7
  local width, height = (self._cellArea):GetRectSize()
  local total = (self._cellFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

ShopCharResolvePage.OnWhiteBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (self._delegate)._selectShopID == 7 then
    return 
  end
  ;
  (self._whiteBtn):SetSelected(true)
  ;
  (self._goldBtn):SetSelected(false)
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = 7
    protocol:Send()
  end
end

ShopCharResolvePage.OnGoldBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self._delegate)._selectShopID == 8 then
    return 
  end
  ;
  (self._whiteBtn):SetSelected(false)
  ;
  (self._goldBtn):SetSelected(true)
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = 8
    protocol:Send()
  end
end

ShopCharResolvePage.OnEvent = function(self, eventName, arg)
  -- function num : 0_10
  if eventName == "BuyGoodRefresh" then
    (self._cellFrame):FireEvent("BuyGoodRefresh", {shopid = arg.shopid, goodInfo = arg.goodInfo})
  end
end

return ShopCharResolvePage

