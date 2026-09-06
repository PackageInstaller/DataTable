local GridFrame = require("framework.ui.frame.grid.gridframe")
local ShopCharResolvePage = class("ShopCharResolvePage", Dialog)
ShopCharResolvePage.AssetBundleName = "ui/layouts.baseshop"
ShopCharResolvePage.AssetName = "CharResolveShop"
local BottomToTop = 3

function ShopCharResolvePage:Ctor(...)
  ShopCharResolvePage.super.Ctor(self, ...)
end

function ShopCharResolvePage:OnCreate()
  self._whiteBtn = self:GetChild("GroupBtn1")
  self._goldBtn = self:GetChild("GroupBtn2")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._refreshText = self:GetChild("Refresh/Time")
  self._refreshBoard = self:GetChild("Refresh")
  self._cellArea = self:GetChild("CellFrame")
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, 4)
  self._whiteBtn:Subscribe_PointerClickEvent(self.OnWhiteBtnClicked, self)
  self._goldBtn:Subscribe_PointerClickEvent(self.OnGoldBtnClicked, self)
  self._whiteBtn:SetSelected(true)
end

function ShopCharResolvePage:OnDestroy()
  self._cellFrame:Destroy()
end

function ShopCharResolvePage:RefreshCell(data)
  self._data = data.goodInfo
  self._shopInfo = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(self._delegate._selectShopID)
  if tonumber(self._shopInfo.closeTimeShow) == 0 then
    self._refreshBoard:SetActive(false)
  else
    self._refreshBoard:SetActive(true)
    self._refreshText:SetText(self._shopInfo.closeTimeShow)
  end
  self._cellFrame:ReloadAllCell()
end

function ShopCharResolvePage:NumberOfCell(frame)
  return #self._data
end

function ShopCharResolvePage:CellAtIndex(frame, index)
  return "shop.shopgeneralcell"
end

function ShopCharResolvePage:DataAtIndex(frame, index)
  local data = {}
  data.iteminfo = self._data[index]
  return data
end

function ShopCharResolvePage:OnCurPosChange(frame, proportion)
  local width, height = self._cellArea:GetRectSize()
  local total = self._cellFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function ShopCharResolvePage:OnWhiteBtnClicked()
  if self._delegate._selectShopID == 7 then
    return
  end
  self._whiteBtn:SetSelected(true)
  self._goldBtn:SetSelected(false)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = 7
    protocol:Send()
  end
end

function ShopCharResolvePage:OnGoldBtnClicked()
  if self._delegate._selectShopID == 8 then
    return
  end
  self._whiteBtn:SetSelected(false)
  self._goldBtn:SetSelected(true)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = 8
    protocol:Send()
  end
end

function ShopCharResolvePage:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    self._cellFrame:FireEvent("BuyGoodRefresh", {
      shopid = arg.shopid,
      goodInfo = arg.goodInfo
    })
  end
end

return ShopCharResolvePage
