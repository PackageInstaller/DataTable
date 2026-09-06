local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopLimitTimePage = class("ShopLimitTimePage", Dialog)
ShopLimitTimePage.AssetBundleName = "ui/layouts.baseshop"
ShopLimitTimePage.AssetName = "TimeLimitShop"
local BottomToTop = 3

function ShopLimitTimePage:Ctor(...)
  ShopLimitTimePage.super.Ctor(self, ...)
end

function ShopLimitTimePage:OnCreate()
  self._btn = self:GetChild("GroupBtn1")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._refreshTime = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true)
end

function ShopLimitTimePage:OnDestroy()
  self._cellFrame:Destroy()
  self._groupBtnFrame:Destroy()
end

function ShopLimitTimePage:RefreshCell(data)
  self._data = data.goodInfo
  self._shopInfo = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(self._delegate._selectShopID)
  if self._delegate._selectShopID == 11 or self._delegate._selectShopID == 12 then
    if not self._cellFrame then
      self._cellFrame = GridFrame.Create(self._cellArea, self, true, 1)
    end
  else
    self._cellFrame = GridFrame.Create(self._cellArea, self, false, 2)
  end
  local rec = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1183).msgTextID
  rec = TextManager.GetText(rec)
  local str = os.date("%Y-%m-%d", self._shopInfo.closeTimeShow // 1000) .. " "
  str = str .. os.date("%H", self._shopInfo.closeTimeShow // 1000) .. ":"
  str = str .. os.date("%M", self._shopInfo.closeTimeShow // 1000) .. ":"
  str = str .. os.date("%S", self._shopInfo.closeTimeShow // 1000)
  rec = string.gsub(rec, "%$parameter1%$", str)
  self._refreshTime:SetText(rec)
  self._btnList = data.groupInfo
  self._cellFrame:ReloadAllCell()
  self._groupBtnFrame:ReloadAllCell()
end

function ShopLimitTimePage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._btnList
  elseif self._delegate._selectShopID == 11 or self._delegate._selectShopID == 12 then
    return 1
  else
    return #self._data
  end
end

function ShopLimitTimePage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  elseif self._delegate._selectShopID == 11 or self._delegate._selectShopID == 12 then
    return "shop.agcoinshop"
  else
    return "shop.shopgeneralcell"
  end
end

function ShopLimitTimePage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._btnList[index]
  elseif self._delegate._selectShopID == 11 or self._delegate._selectShopID == 12 then
    return {}
  else
    local data = {}
    data.iteminfo = self._data[index]
    return data
  end
end

function ShopLimitTimePage:OnGroupBtnClicked(id)
  self._delegate:OnGroupBtnClicked(id)
end

function ShopLimitTimePage:OnCurPosChange(frame, proportion)
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

function ShopLimitTimePage:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    self._cellFrame:FireEvent("BuyGoodRefresh", {
      shopid = arg.shopid,
      goodInfo = arg.goodInfo
    })
  elseif eventName == "ChangedSelected" then
    self._groupBtnFrame:FireEvent("ChangedSelected", arg)
  end
end

function ShopLimitTimePage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

return ShopLimitTimePage
