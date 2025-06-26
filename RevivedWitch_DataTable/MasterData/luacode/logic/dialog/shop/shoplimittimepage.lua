-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoplimittimepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopLimitTimePage = class("ShopLimitTimePage", Dialog)
ShopLimitTimePage.AssetBundleName = "ui/layouts.baseshop"
ShopLimitTimePage.AssetName = "TimeLimitShop"
local BottomToTop = 3
ShopLimitTimePage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopLimitTimePage
  ((ShopLimitTimePage.super).Ctor)(self, ...)
end

ShopLimitTimePage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._btn = self:GetChild("GroupBtn1")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._refreshTime = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true)
end

ShopLimitTimePage.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
  ;
  (self._groupBtnFrame):Destroy()
end

ShopLimitTimePage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, GridFrame
  self._data = data.goodInfo
  self._shopInfo = ((NekoData.BehaviorManager).BM_Shop):GetShopInfoByID((self._delegate)._selectShopID)
  if ((self._delegate)._selectShopID == 11 or (self._delegate)._selectShopID == 12) and not self._cellFrame then
    self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 1)
  end
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, false, 2)
  local rec = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1183)).msgTextID
  rec = (TextManager.GetText)(rec)
  local str = (os.date)("%Y-%m-%d", (self._shopInfo).closeTimeShow // 1000) .. " "
  str = str .. (os.date)("%H", (self._shopInfo).closeTimeShow // 1000) .. ":"
  str = str .. (os.date)("%M", (self._shopInfo).closeTimeShow // 1000) .. ":"
  str = str .. (os.date)("%S", (self._shopInfo).closeTimeShow // 1000)
  rec = (string.gsub)(rec, "%$parameter1%$", str)
  ;
  (self._refreshTime):SetText(rec)
  self._btnList = data.groupInfo
  ;
  (self._cellFrame):ReloadAllCell()
  ;
  (self._groupBtnFrame):ReloadAllCell()
end

ShopLimitTimePage.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._groupBtnFrame then
    return #self._btnList
  else
    if (self._delegate)._selectShopID == 11 or (self._delegate)._selectShopID == 12 then
      return 1
    else
      return #self._data
    end
  end
end

ShopLimitTimePage.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    if (self._delegate)._selectShopID == 11 or (self._delegate)._selectShopID == 12 then
      return "shop.agcoinshop"
    else
      return "shop.shopgeneralcell"
    end
  end
end

ShopLimitTimePage.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._groupBtnFrame then
    return (self._btnList)[index]
  else
    if (self._delegate)._selectShopID == 11 or (self._delegate)._selectShopID == 12 then
      return {}
    else
      local data = {}
      data.iteminfo = (self._data)[index]
      return data
    end
  end
end

ShopLimitTimePage.OnGroupBtnClicked = function(self, id)
  -- function num : 0_7
  (self._delegate):OnGroupBtnClicked(id)
end

ShopLimitTimePage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
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

ShopLimitTimePage.OnEvent = function(self, eventName, arg)
  -- function num : 0_9
  if eventName == "BuyGoodRefresh" then
    (self._cellFrame):FireEvent("BuyGoodRefresh", {shopid = arg.shopid, goodInfo = arg.goodInfo})
  else
    if eventName == "ChangedSelected" then
      (self._groupBtnFrame):FireEvent("ChangedSelected", arg)
    end
  end
end

ShopLimitTimePage.PlayTabShowAnimation = function(self)
  -- function num : 0_10
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

return ShopLimitTimePage

