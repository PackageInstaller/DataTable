-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopgiftpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopGiftPage = class("ShopGiftPage", Dialog)
ShopGiftPage.AssetBundleName = "ui/layouts.baseshop"
ShopGiftPage.AssetName = "GiftShop"
local BottomToTop = 3
ShopGiftPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGiftPage
  ((ShopGiftPage.super).Ctor)(self, ...)
end

ShopGiftPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, TableFrame, _ENV
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._cellArea = self:GetChild("CellFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 4)
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true, true)
  local dialog = (DialogManager.GetDialog)("base.basemainui")
  if dialog then
    dialog:HideShopGiftIcon()
  end
end

ShopGiftPage.OnDestroy = function(self)
  -- function num : 0_2
  (self._groupBtnFrame):Destroy()
  ;
  (self._cellFrame):Destroy()
end

ShopGiftPage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, DM_RedDot
  self._groupBtnShowData = data.groupInfo
  ;
  (table.sort)(self._groupBtnShowData)
  ;
  (self._groupBtnFrame):ReloadAllCell()
  self._goodInfoData = {}
  local soldoutList = {}
  local soldList = {}
  for i,v in ipairs(data.goodInfo) do
    if v.goodRemain == 0 then
      (table.insert)(soldoutList, v)
    else
      ;
      (table.insert)(soldList, v)
    end
  end
  ;
  (table.sort)(soldoutList, function(a, b)
    -- function num : 0_3_0
    if a.sortId >= b.sortId then
      do return a.sortId == b.sortId end
      do return a.goodId < b.goodId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ;
  (table.sort)(soldList, function(a, b)
    -- function num : 0_3_1
    if a.sortId >= b.sortId then
      do return a.sortId == b.sortId end
      do return a.goodId < b.goodId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  for i,v in ipairs(soldList) do
    (table.insert)(self._goodInfoData, v)
  end
  for i,v in ipairs(soldoutList) do
    (table.insert)(self._goodInfoData, v)
  end
  self._itemRedDotNodes = (((DM_RedDot.nodeChildShop)[(self._delegate)._selectShopID]).childNode).ItemData
  ;
  (DM_RedDot.ClearNodeChild)(self._itemRedDotNodes)
  for _,value in pairs(self._goodInfoData) do
    local tempNode = (DM_RedDot.CreateNewNodeToTree)(value.goodId, self._itemRedDotNodes)
    tempNode.haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)(tempNode)
    local tempChildNode = (DM_RedDot.CreateNewNodeToTree)("hasFreeGoodNotBuy", tempNode)
    tempChildNode.haveRedDot = value.discountPrice == 0 and value.goodRemain ~= 0
  end
  if (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[(self._delegate)._selectShopID]).nodeName) then
    (DM_RedDot.SetIDNotOpenFirst)(((DM_RedDot.nodeChildShop)[(self._delegate)._selectShopID]).nodeName)
    if (self._delegate)._selectShopID == 20 then
      (DM_RedDot.NowIsNewMonth)()
    elseif (self._delegate)._selectShopID == 46 then
      (DM_RedDot.NowIsNewWeek)()
    end
    for _,value in pairs((self._itemRedDotNodes).childNode) do
      (DM_RedDot.SetNodeRead)(value, true)
    end
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
  ;
  (self._cellFrame):ReloadAllCell()
  self._totalLength = (self._cellFrame):GetTotalLength()
  self._showLength = select(2, (self._cellArea):GetRectSize())
  ;
  (self._scrollBar):SetActive(self._showLength < self._totalLength)
  ;
  (self._cellFrame):SetSlide(self._showLength < self._totalLength)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

ShopGiftPage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  if self._showLength and self._totalLength then
    (self._scrollBar):SetScrollSize(self._showLength / self._totalLength)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

ShopGiftPage.OnGroupBtnClicked = function(self, id)
  -- function num : 0_5
  (self._delegate):OnGroupBtnClicked(id)
end

ShopGiftPage.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._groupBtnFrame then
    return #self._groupBtnShowData
  else
    return #self._goodInfoData
  end
end

ShopGiftPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.shopgiftcellnew"
  end
end

ShopGiftPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._groupBtnFrame then
    return (self._groupBtnShowData)[index]
  else
    return {iteminfo = (self._goodInfoData)[index], itemRedDotNodes = self._itemRedDotNodes}
  end
end

ShopGiftPage.OnEvent = function(self, eventName, arg)
  -- function num : 0_9
  if eventName == "ChangedSelected" then
    (self._groupBtnFrame):FireEvent("ChangedSelected", arg)
  else
    if eventName == "RedPointInfo" and ((self._delegate)._selectShopID == 5 or (self._delegate)._selectShopID == 20 or (self._delegate)._selectShopID == 37 or (self._delegate)._selectShopID == 46) then
      (self._groupBtnFrame):FireEvent("RedPointInfo", arg)
      ;
      (self._cellFrame):FireEvent("RedPointInfo", arg)
    end
  end
end

ShopGiftPage.PlayTabShowAnimation = function(self)
  -- function num : 0_10
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

return ShopGiftPage

