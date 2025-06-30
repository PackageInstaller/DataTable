-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/activityshoppage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local ActivityShopPage = class("ActivityShopPage", Dialog)
ActivityShopPage.AssetBundleName = "ui/layouts.baseshop"
ActivityShopPage.AssetName = "ActivityShop"
local BottomToTop = 3
local ROW, COL = 2, 5
ActivityShopPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityShopPage
  ((ActivityShopPage.super).Ctor)(self, ...)
  self._data = nil
  self._cellInfo = {}
  self._groupInfo = {}
  self._equipList = {}
  self._shopId = -1
  self._shopInfo = nil
end

ActivityShopPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._refresh = self:GetChild("Refresh")
  self._refreshText = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true)
end

ActivityShopPage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  ;
  (self._groupBtnFrame):Destroy()
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if self._shopTask then
    (GameTimer.RemoveTask)(self._shopTask)
    self._shopTask = nil
  end
end

ActivityShopPage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, GridFrame, COL, ROW
  self._data = data
  self._cellInfo = (self._data).goodInfo
  if not (self._data).groupInfo then
    self._groupInfo = {}
    local refreshShopTime = nil
    for i,v in ipairs(self._cellInfo) do
      if v.goodId > 1000 then
        (table.insert)(self._equipList, v)
      end
      if v.beginTime and v.endTime and v.beginTime ~= 0 and v.endTime ~= 0 and (not refreshShopTime or v.endTime < refreshShopTime) then
        refreshShopTime = v.endTime
      end
    end
    if self._shopTask then
      (GameTimer.RemoveTask)(self._shopTask)
      self._shopTask = nil
    end
    if refreshShopTime then
      self._shopTask = (GameTimer.AddTask)(refreshShopTime // 1000, -1, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self._shopTask = nil
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    protocol.shopId = self._shopId
    protocol:Send()
  end
, nil, true)
    end
    self._shopId = (self._delegate)._selectShopID
    ;
    (self._refresh):SetActive(false)
    self._shopInfo = ((NekoData.BehaviorManager).BM_Shop):GetShopInfoByID(self._shopId)
    local rec = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1183)).msgTextID
    rec = (TextManager.GetText)(rec)
    local str = (os.date)("%Y-%m-%d", (self._shopInfo).closeTimeShow // 1000) .. " "
    str = str .. (os.date)("%H", (self._shopInfo).closeTimeShow // 1000) .. ":"
    str = str .. (os.date)("%M", (self._shopInfo).closeTimeShow // 1000) .. ":"
    str = str .. (os.date)("%S", (self._shopInfo).closeTimeShow // 1000)
    rec = (string.gsub)(rec, "%$parameter1%$", str)
    ;
    (self._refreshText):SetText(rec)
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    if (self._shopInfo).closeTimeShow ~= 0 then
      self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_1 , upvalues : self
    self:CountDown()
  end
, nil)
    end
    if self._cellFrame then
      (self._cellFrame):Destroy()
    end
    self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, COL, COL * ROW < #self._cellInfo)
    ;
    (self._cellFrame):ReloadAllCell()
    ;
    (self._groupBtnFrame):ReloadAllCell()
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

ActivityShopPage.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._groupBtnFrame then
    return #self._groupInfo
  else
    return #self._cellInfo
  end
end

ActivityShopPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.towershopcell"
  end
end

ActivityShopPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._groupBtnFrame then
    return (self._groupInfo)[index]
  else
    local data = {}
    data.iteminfo = (self._cellInfo)[index]
    return data
  end
end

ActivityShopPage.OnGroupBtnClicked = function(self, id)
  -- function num : 0_7
  (self._delegate):OnGroupBtnClicked(id)
end

ActivityShopPage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local width, height = (self._cellArea):GetRectSize()
  local total = (self._cellFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

ActivityShopPage.OnEvent = function(self, eventName, arg)
  -- function num : 0_9
  if eventName == "BuyGoodRefresh" then
    (self._cellFrame):FireEvent("BuyGoodRefresh", {shopid = arg.shopid, goodInfo = arg.goodInfo})
  else
    if eventName == "ChangedSelected" then
      (self._groupBtnFrame):FireEvent("ChangedSelected", arg)
    end
  end
end

ActivityShopPage.CountDown = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local time = (self._shopInfo).closeTimeShow - ServerGameTimer:GetServerTime()
  if time < 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    if protocol then
      protocol.shopId = self._shopId
      protocol:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

ActivityShopPage.PlayTabShowAnimation = function(self)
  -- function num : 0_11
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

return ActivityShopPage

