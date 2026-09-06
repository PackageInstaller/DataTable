local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local AppearanceShopPage = class("AppearanceShopPage", Dialog)
AppearanceShopPage.AssetBundleName = "ui/layouts.baseshop"
AppearanceShopPage.AssetName = "AppearanceShop"
local BottomToTop = 3
local ROW, COL = 2, 4

function AppearanceShopPage:Ctor(...)
  AppearanceShopPage.super.Ctor(self, ...)
  self._data = nil
  self._cellInfo = {}
  self._groupInfo = {}
  self._equipList = {}
  self._shopId = -1
  self._shopInfo = nil
end

function AppearanceShopPage:OnCreate()
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._refresh = self:GetChild("Refresh")
  self._refreshText = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true)
end

function AppearanceShopPage:OnDestroy()
  self._cellFrame:Destroy()
  self._groupBtnFrame:Destroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
end

function AppearanceShopPage:RefreshCell(data)
  self._data = data
  self._cellInfo = self._data.goodInfo
  self._groupInfo = self._data.groupInfo or {}
  local refreshShopTime
  for i, v in ipairs(self._cellInfo) do
    if v.goodId > 1000 then
      table.insert(self._equipList, v)
    end
    if v.beginTime and v.endTime and v.beginTime ~= 0 and v.endTime ~= 0 and (not refreshShopTime or refreshShopTime > v.endTime) then
      refreshShopTime = v.endTime
    end
  end
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
  if refreshShopTime then
    self._shopTask = GameTimer.AddTask(refreshShopTime // 1000, -1, function()
      self._shopTask = nil
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = self._shopId
      protocol:Send()
    end, nil, true)
  end
  self._shopId = self._delegate._selectShopID
  self._itemRedDotNodes = DM_RedDot.nodeChildShop[self._delegate._selectShopID].childNode.ItemData
  self._refresh:SetActive(false)
  self._shopInfo = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(self._shopId)
  local rec = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1183).msgTextID
  rec = TextManager.GetText(rec)
  local str = os.date("%Y-%m-%d", self._shopInfo.closeTimeShow // 1000) .. " "
  str = str .. os.date("%H", self._shopInfo.closeTimeShow // 1000) .. ":"
  str = str .. os.date("%M", self._shopInfo.closeTimeShow // 1000) .. ":"
  str = str .. os.date("%S", self._shopInfo.closeTimeShow // 1000)
  rec = string.gsub(rec, "%$parameter1%$", str)
  self._refreshText:SetText(rec)
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if self._shopInfo.closeTimeShow ~= 0 then
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:CountDown()
    end, nil)
  end
  if self._cellFrame then
    self._cellFrame:Destroy()
  end
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, COL, #self._cellInfo > COL * ROW)
  self._cellFrame:ReloadAllCell()
  self._groupBtnFrame:ReloadAllCell()
end

function AppearanceShopPage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._groupInfo
  else
    return #self._cellInfo
  end
end

function AppearanceShopPage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  elseif self._shopId == 65 then
    return "shop.shopgiftcellnew"
  else
    return "shop.appearanceshopcell"
  end
end

function AppearanceShopPage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._groupInfo[index]
  else
    return {
      iteminfo = self._cellInfo[index],
      itemRedDotNodes = self._itemRedDotNodes
    }
  end
end

function AppearanceShopPage:OnGroupBtnClicked(id)
  self._delegate:OnGroupBtnClicked(id)
end

function AppearanceShopPage:OnCurPosChange(frame, proportion)
  local width, height = self._cellArea:GetRectSize()
  local total = self._cellFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function AppearanceShopPage:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    self._cellFrame:FireEvent("BuyGoodRefresh", {
      shopid = arg.shopid,
      goodInfo = arg.goodInfo
    })
  elseif eventName == "ChangedSelected" then
    self._groupBtnFrame:FireEvent("ChangedSelected", arg)
  end
end

function AppearanceShopPage:CountDown()
  local time = self._shopInfo.closeTimeShow - ServerGameTimer:GetServerTime()
  if time < 0 then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    if protocol then
      protocol.shopId = self._shopId
      protocol:Send()
    end
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function AppearanceShopPage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

return AppearanceShopPage
