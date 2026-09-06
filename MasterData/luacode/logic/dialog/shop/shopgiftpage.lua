local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopGiftPage = class("ShopGiftPage", Dialog)
ShopGiftPage.AssetBundleName = "ui/layouts.baseshop"
ShopGiftPage.AssetName = "GiftShop"
local BottomToTop = 3

function ShopGiftPage:Ctor(...)
  ShopGiftPage.super.Ctor(self, ...)
end

function ShopGiftPage:OnCreate()
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._cellArea = self:GetChild("CellFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, 4)
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true, true)
  local dialog = DialogManager.GetDialog("base.basemainui")
  if dialog then
    dialog:HideShopGiftIcon()
  end
end

function ShopGiftPage:OnDestroy()
  self._groupBtnFrame:Destroy()
  self._cellFrame:Destroy()
end

function ShopGiftPage:RefreshCell(data)
  self._groupBtnShowData = data.groupInfo
  table.sort(self._groupBtnShowData)
  self._groupBtnFrame:ReloadAllCell()
  self._goodInfoData = {}
  local soldoutList = {}
  local soldList = {}
  for i, v in ipairs(data.goodInfo) do
    if v.goodRemain == 0 then
      table.insert(soldoutList, v)
    else
      table.insert(soldList, v)
    end
  end
  table.sort(soldoutList, function(a, b)
    if a.sortId ~= b.sortId then
      return a.sortId < b.sortId
    else
      return a.goodId < b.goodId
    end
  end)
  table.sort(soldList, function(a, b)
    if a.sortId ~= b.sortId then
      return a.sortId < b.sortId
    else
      return a.goodId < b.goodId
    end
  end)
  for i, v in ipairs(soldList) do
    table.insert(self._goodInfoData, v)
  end
  for i, v in ipairs(soldoutList) do
    table.insert(self._goodInfoData, v)
  end
  self._itemRedDotNodes = DM_RedDot.nodeChildShop[self._delegate._selectShopID].childNode.ItemData
  DM_RedDot.ClearNodeChild(self._itemRedDotNodes)
  for _, value in pairs(self._goodInfoData) do
    local tempNode = DM_RedDot.CreateNewNodeToTree(value.goodId, self._itemRedDotNodes)
    tempNode.haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(tempNode)
    local tempChildNode = DM_RedDot.CreateNewNodeToTree("hasFreeGoodNotBuy", tempNode)
    tempChildNode.haveRedDot = value.discountPrice == 0 and value.goodRemain ~= 0
  end
  if DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[self._delegate._selectShopID].nodeName) then
    DM_RedDot.SetIDNotOpenFirst(DM_RedDot.nodeChildShop[self._delegate._selectShopID].nodeName)
    if self._delegate._selectShopID == 20 then
      DM_RedDot.NowIsNewMonth()
    elseif self._delegate._selectShopID == 46 then
      DM_RedDot.NowIsNewWeek()
    end
    for _, value in pairs(self._itemRedDotNodes.childNode) do
      DM_RedDot.SetNodeRead(value, true)
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
  self._cellFrame:ReloadAllCell()
  self._totalLength = self._cellFrame:GetTotalLength()
  self._showLength = select(2, self._cellArea:GetRectSize())
  self._scrollBar:SetActive(self._showLength < self._totalLength)
  self._cellFrame:SetSlide(self._showLength < self._totalLength)
end

function ShopGiftPage:OnCurPosChange(frame, proportion)
  if self._showLength and self._totalLength then
    self._scrollBar:SetScrollSize(self._showLength / self._totalLength)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function ShopGiftPage:OnGroupBtnClicked(id)
  self._delegate:OnGroupBtnClicked(id)
end

function ShopGiftPage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._groupBtnShowData
  else
    return #self._goodInfoData
  end
end

function ShopGiftPage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.shopgiftcellnew"
  end
end

function ShopGiftPage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._groupBtnShowData[index]
  else
    return {
      iteminfo = self._goodInfoData[index],
      itemRedDotNodes = self._itemRedDotNodes
    }
  end
end

function ShopGiftPage:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._groupBtnFrame:FireEvent("ChangedSelected", arg)
  elseif eventName == "RedPointInfo" and (self._delegate._selectShopID == 5 or self._delegate._selectShopID == 20 or self._delegate._selectShopID == 37 or self._delegate._selectShopID == 46) then
    self._groupBtnFrame:FireEvent("RedPointInfo", arg)
    self._cellFrame:FireEvent("RedPointInfo", arg)
  end
end

function ShopGiftPage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

return ShopGiftPage
