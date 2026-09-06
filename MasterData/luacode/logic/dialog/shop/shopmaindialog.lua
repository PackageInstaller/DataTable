local CShopTypeShow = BeanManager.GetTableByName("recharge.cshoptypeshow")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.baseshop"
ShopMainDialog.AssetName = "Shop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._shopGoodInfo = {}
  self._typeGroupData = {}
  self._activeShopList = {}
  self._selectShopID = 0
  self._gameTimerTimeCount = 0
  self._gameTimer = nil
  self._clothState = "always"
  self._changeCurPos = true
  self._jumpMonthCardFlag = false
  self._tlgTimerTaskIDs = {}
end

function ShopMainDialog:OnCreate()
  self._groupBtnArea = self:GetChild("Back/GroupBtnFrame")
  self._rightPageArea = self:GetChild("Back/RightPanel")
  self._topGroup = self:GetChild("TopGroup")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, false, false)
  self._rightPageFrame = TableFrame.Create(self._rightPageArea, self, false, false, true)
  self._topGroupFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopInfo, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTopGroundFrame, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRemainTime, Common.n_MonthCardRefreshTime, nil)
  LuaNotificationCenter.AddObserver(self, self.ShopRedPoint, Common.n_ShopRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.ShopRedPoint, Common.n_ChargeAccumulationAddPoints, nil)
  LuaNotificationCenter.AddObserver(self, self.ShopRedPoint, Common.n_ChargeAccumulationReceiveReward, nil)
  LuaNotificationCenter.AddObserver(self, self.ShopRedPoint, Common.n_RefreshSkinCollectAwardStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChargeAccmulationReceiveReawrd, Common.n_ChargeAccumultionRewardDialogWillDestroy, nil)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function ShopMainDialog:OnDestroy()
  local discountShopCardNode = DM_RedDot.nodeChildShop[50].childNode.ItemData.childNode.FirstDiscountShopCardReddot
  if discountShopCardNode then
    DM_RedDot.SetNodeRead(discountShopCardNode)
    LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
  end
  for _, value in pairs(DM_RedDot.nodeChildShop) do
    if not DM_RedDot.GetIDOpenFirst(value.nodeName) then
      local nodeResult = DM_RedDot.GetNodeResult(value)
      if nodeResult == true then
        DM_RedDot.SetNodeUnread(value, true)
      else
        DM_RedDot.SetNodeRead(value, true)
      end
    end
    local itemDataNode = value.childNode.ItemData
    if itemDataNode then
      for key, _ in pairs(itemDataNode.childNode) do
        itemDataNode.childNode[key] = nil
      end
    end
  end
  LuaNotificationCenter.RemoveObserver(self)
  self._rightPageFrame:Destroy()
  self._groupBtnFrame:Destroy()
  self._topGroupFrame:Destroy()
  if self._gameTimer then
    GameTimer.RemoveTask(self._gameTimer)
    self._gameTimer = nil
  end
  self:RemoveDLGTimerTaskIDs()
  local jsonStr = JSON.encode({eventName = "event", id = "17"})
  ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
end

function ShopMainDialog:SetHomePage(protocol)
  local data = {
    dailyGitfInfo = protocol.dailyGitfInfo,
    monthCardInfo = protocol.monthCardInfo
  }
  self._homePageInfo = data
  self._rightPageFrame:FireEvent("Home", self._homePageInfo)
  local tmpMonthCardInfo
  if data.monthCardInfo then
    for _, value in pairs(data.monthCardInfo) do
      if value.goodType == 13 and value.endTime > 0 then
        tmpMonthCardInfo = value
        break
      end
    end
  end
  if tmpMonthCardInfo then
    local tempKey = table.concat({
      NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid,
      "FirstDiscountShopCardDialogShow"
    })
    local firstDiscountShopCardDialogShow = CS.UnityEngine.PlayerPrefs.GetInt(tempKey, 0)
    if firstDiscountShopCardDialogShow == 0 then
      CS.UnityEngine.PlayerPrefs.SetInt(tempKey, 1)
      local dialog = DialogManager.CreateSingletonDialog("shop.monthcarddiscountdialog")
      if dialog then
        dialog:SetData(data.monthCardInfo[1])
      end
      DM_RedDot.CreateNewNodeToTree("FirstDiscountShopCardReddot", DM_RedDot.nodeChildShop[50].childNode.ItemData, true)
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
  end
end

function ShopMainDialog:SetData(data)
  self._gameTimerTimeCount = 0
  self._typeGroupData = {}
  for _, v in pairs(data) do
    local info = CShopTypeConfig:GetRecorder(v)
    if info then
      if info.ShopType < 100 then
        if not self._typeGroupData[info.ShopType] then
          self._typeGroupData[info.ShopType] = {}
          table.insert(self._typeGroupData[info.ShopType], v)
        else
          local ishas = false
          for _, id in pairs(self._typeGroupData[info.ShopType]) do
            if id == v then
              ishas = true
              break
            end
          end
          if not ishas then
            table.insert(self._typeGroupData[info.ShopType], v)
          end
        end
      else
        info = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(v)
        if info and info.openTime == 0 then
          table.insert(self._activeShopList, v)
        end
      end
    end
  end
  self._hasOpenTimeShopList = NekoData.BehaviorManager.BM_Shop:GetHasOpenTimeShopIDList()
  self._hasCloseTimeShopList = NekoData.BehaviorManager.BM_Shop:GetHasCloseTimeShopIDList()
  self._hasRefreshTimeShopList = NekoData.BehaviorManager.BM_Shop:GetHasRefreshTimeShopIDList()
  if 0 < table.nums(self._hasOpenTimeShopList) then
    if self._gameTimer then
      GameTimer.RemoveTask(self._gameTimer)
      self._gameTimer = nil
    end
    self._gameTimer = GameTimer.AddTask(0, 1, function()
      self._gameTimerTimeCount = self._gameTimerTimeCount + 1
      for _, v in pairs(self._hasOpenTimeShopList) do
        if self._gameTimerTimeCount * 1000 >= v.openTime then
          local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
          if protocol then
            protocol:Send()
            return
          end
        end
      end
      if table.nums(self._hasCloseTimeShopList) > 0 then
        for _, v in pairs(self._hasCloseTimeShopList) do
          if v.openTime == 0 and self._gameTimerTimeCount * 1000 >= v.closeTime then
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
            if protocol then
              protocol:Send()
              return
            end
          end
        end
      end
      if 0 < table.nums(self._hasRefreshTimeShopList) then
        for _, v in pairs(self._hasRefreshTimeShopList) do
          if self._gameTimerTimeCount * 1000 >= v.closeTime and self._selectShopID == v.shopId then
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
            if protocol then
              protocol.shopId = self._selectShopID
              protocol:Send()
              return
            end
          end
        end
      end
    end, nil)
  end
  if table.nums(self._hasCloseTimeShopList) > 0 and not self._gameTimer then
    self._gameTimer = GameTimer.AddTask(0, 1, function()
      self._gameTimerTimeCount = self._gameTimerTimeCount + 1
      for _, v in pairs(self._hasCloseTimeShopList) do
        if v.openTime == 0 and self._gameTimerTimeCount * 1000 >= v.closeTime then
          local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
          if protocol then
            protocol:Send()
            return
          end
        end
      end
      if 0 < table.nums(self._hasRefreshTimeShopList) then
        for _, v in pairs(self._hasRefreshTimeShopList) do
          if self._gameTimerTimeCount * 1000 >= v.closeTime and self._selectShopID == v.shopId then
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
            if protocol then
              protocol.shopId = self._selectShopID
              protocol:Send()
              return
            end
          end
        end
      end
    end, nil)
  end
  if table.nums(self._hasRefreshTimeShopList) > 0 and not self._gameTimer then
    self._gameTimer = GameTimer.AddTask(0, 1, function()
      self._gameTimerTimeCount = self._gameTimerTimeCount + 1
      if table.nums(self._hasRefreshTimeShopList) > 0 then
        for _, v in pairs(self._hasRefreshTimeShopList) do
          if self._gameTimerTimeCount * 1000 >= v.closeTime and self._selectShopID == v.shopId then
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
            if protocol then
              protocol.shopId = self._selectShopID
              protocol:Send()
              return
            end
          end
        end
      end
    end, nil)
  end
  if table.nums(self._typeGroupData) > 0 then
    self._shopIDTypeList = {}
    for k, v in pairs(self._typeGroupData) do
      table.insert(self._shopIDTypeList, k)
    end
    table.sort(self._shopIDTypeList, function(a, b)
      return CShopTypeShow:GetRecorder(a).Sort < CShopTypeShow:GetRecorder(b).Sort
    end)
    self._groupBtnFrame:ReloadAllCell()
    self:ShopRedPoint()
    local shopid = NekoData.BehaviorManager.BM_Shop:GetClientOpenShopID()
    if shopid then
      self:OnGroupBtnClicked(shopid)
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(nil)
    else
      self:OnGroupBtnClicked(self._typeGroupData[self._shopIDTypeList[1]][1])
      local jsonStr = JSON.encode({eventName = "event", id = "11"})
      ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
    end
  end
end

function ShopMainDialog:ShopRedPoint()
  self._groupBtnFrame:FireEvent("RedPointInfo")
  self._rightPageFrame:FireEvent("RedPointInfo")
end

function ShopMainDialog:RefreshShopInfo(protocol)
  local shopType = CShopTypeConfig:GetRecorder(protocol.userInfo.shopId).ShopType
  if shopType == 8 then
    return
  end
  if protocol and protocol.userInfo and protocol.userInfo.result and protocol.userInfo.shopId == self._selectShopID then
    if protocol.name == Common.n_BuyShopGood then
      local map = {}
      for _, v in ipairs(protocol.userInfo.refresh) do
        map[v.goodId] = v
      end
      self._rightPageFrame:FireEvent("BuyGoodRefresh", {
        shopid = protocol.userInfo.shopId,
        goodInfo = map
      })
    else
      self._rightPageFrame:FireEvent("BuyGoodRefresh", {
        shopid = protocol.userInfo.shopId,
        goodInfo = protocol.userInfo.refresh
      })
    end
    return
  end
  if self._selectShopID and self._selectShopID == protocol.userInfo.shopId and protocol.userInfo.shopId ~= 9 then
    self._changeCurPos = false
  end
  local lastSelectShopTypeID = self._selectShopTypeID
  self._selectShopID = protocol.userInfo.shopId
  self._selectShopTypeID = CShopTypeConfig:GetRecorder(self._selectShopID).ShopType
  if self._selectShopTypeID >= 100 then
    self._groupBtnFrame:FireEvent("ChangedSelected", 0)
  else
    self._groupBtnFrame:FireEvent("ChangedSelected", self._selectShopTypeID)
  end
  self._shopGoodInfo = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(self._selectShopID)
  if self._selectShopID == 46 then
    local hasFreeeGood = false
    for _, good in ipairs(self._shopGoodInfo) do
      if good.discountPrice == 0 and good.goodRemain ~= 0 then
        hasFreeeGood = true
      end
    end
    local weekGoodShop = NekoData.DataManager.DM_RedDot.nodeChildShop[46]
    local weekGoodShopResult = NekoData.DataManager.DM_RedDot.GetNodeResult(weekGoodShop)
    if weekGoodShopResult ~= hasFreeeGood then
      if hasFreeeGood then
        NekoData.DataManager.DM_RedDot.SetNodeUnread(weekGoodShop, true)
      else
        NekoData.DataManager.DM_RedDot.SetNodeRead(weekGoodShop, true)
      end
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
  end
  self:RemoveDLGTimerTaskIDs()
  if self._selectShopID == 5 or self._selectShopID == 20 or self._selectShopID == 46 then
    for _, value1 in pairs(self._shopGoodInfo) do
      if 0 < value1.endTime then
        table.insert(self._tlgTimerTaskIDs, ServerGameTimer.AddTask(value1.endTime // 1000, -1, function()
          for key2, value2 in pairs(self._shopGoodInfo) do
            if value2.goodId == value1.goodId then
              table.remove(self._shopGoodInfo, key2)
              if self._selectShopID == 5 or self._selectShopID == 20 or self._selectShopID == 46 then
                self._rightPageFrame:ReloadAllCell()
                if not lastSelectShopTypeID or lastSelectShopTypeID ~= self._selectShopTypeID then
                  local logicCell = self._rightPageFrame:GetLogicCell(1)
                  if logicCell._cell.PlayTabShowAnimation then
                    logicCell._cell:PlayTabShowAnimation()
                  end
                end
              end
            end
          end
        end))
      end
    end
  end
  self._rightPageFrame:ReloadAllCell()
  if not lastSelectShopTypeID or lastSelectShopTypeID ~= self._selectShopTypeID then
    local logicCell = self._rightPageFrame:GetLogicCell(1)
    if logicCell._cell.PlayTabShowAnimation then
      logicCell._cell:PlayTabShowAnimation()
    end
    if CShopTypeConfig:GetRecorder(self._selectShopID).ShopType == 1 then
      local logicCell_Cell = logicCell._cell._cellFrame:GetLogicCell(1)
      logicCell_Cell._cell:PlayShowAnimation()
    end
  end
  self._changeCurPos = true
  self._rightPageFrame:FireEvent("ChangedSelected", self._selectShopID)
  self:RefreshTopGroundFrame()
end

function ShopMainDialog:RemoveDLGTimerTaskIDs()
  if self._tlgTimerTaskIDs then
    for _, value in pairs(self._tlgTimerTaskIDs) do
      ServerGameTimer.RemoveTask(value)
    end
  end
end

function ShopMainDialog:RefreshRemainTime()
  self._rightPageFrame:FireEvent("RefreshMonthCard", nil)
end

function ShopMainDialog:RefreshTopGroundFrame()
  if self._selectShopID == 6 or self._selectShopID == 15 then
    self._shopMoneyTypeInfo = {
      DataCommon.DiamodID
    }
  else
    local shopInfo = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(self._selectShopID)
    self._shopMoneyType = shopInfo.moneyType
    self._shopMoneyTypeInfo = string.split(self._shopMoneyType, ";")
  end
  if table.nums(self._shopMoneyTypeInfo) > 0 then
    self._topGroup:SetActive(true)
    self._topGroupFrame:ReloadAllCell()
  else
    self._topGroup:SetActive(false)
  end
end

function ShopMainDialog:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    if #self._activeShopList > 0 then
      return #self._shopIDTypeList + 1
    else
      return #self._shopIDTypeList
    end
  elseif frame == self._rightPageFrame then
    return 1
  elseif frame == self._topGroupFrame then
    return #self._shopMoneyTypeInfo
  end
end

function ShopMainDialog:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopgroupbtncell"
  elseif frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  elseif frame == self._rightPageFrame then
    local shopType = CShopTypeConfig:GetRecorder(self._selectShopID).ShopType
    if shopType == 1 then
      return "shop.shoprecommendpage"
    elseif shopType == 2 then
      return "shop.shopchargepage"
    elseif shopType == 3 then
      return "shop.shopgiftpage"
    elseif shopType == 4 then
      return "shop.shopclothepage"
    elseif shopType == 5 then
      return "shop.shopgeneralpage"
    elseif shopType == 7 then
      return "shop.activityshoppage"
    elseif shopType == 9 then
      return "shop.appearanceshoppage"
    elseif 100 <= shopType and shopType <= 1000 then
      return "shop.shoplimittimepage"
    end
  end
end

function ShopMainDialog:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    local temp = {}
    if self._shopIDTypeList[index] then
      temp.id = self._shopIDTypeList[index]
    else
      temp.id = 0
    end
    return temp
  elseif frame == self._rightPageFrame then
    if self._selectShopID == 1 or self._selectShopID == 2 then
      local temp = {}
      temp.info = self._nowTypeIdsData
      return temp
    else
      local data = {}
      if self._selectShopID == DataCommon.FurnitureShopId then
        local list = {}
        for i, v in ipairs(self._shopGoodInfo) do
          if v.itemId ~= 777 then
            table.insert(list, v)
          end
        end
        data.goodInfo = list
      else
        data.goodInfo = self._shopGoodInfo
      end
      data.groupInfo = self._nowTypeIdsData
      return data
    end
  elseif frame == self._topGroupFrame then
    local temp = {}
    temp.moneyType = tonumber(self._shopMoneyTypeInfo[index])
    return temp
  end
end

function ShopMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShopMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ShopMainDialog:OnGroupBtnClicked(id)
  self._nowTypeIdsData = nil
  if self._typeGroupData[CShopTypeConfig:GetRecorder(id).ShopType] then
    if #self._typeGroupData[CShopTypeConfig:GetRecorder(id).ShopType] >= 1 then
      self._nowTypeIdsData = self._typeGroupData[CShopTypeConfig:GetRecorder(id).ShopType]
    end
  else
    self._nowTypeIdsData = self._activeShopList
  end
  if id == 1 or id == 2 then
    local lastSelectShopTypeID = self._selectShopTypeID
    self._selectShopID = id
    self._selectShopTypeID = CShopTypeConfig:GetRecorder(self._selectShopID).ShopType
    self._groupBtnFrame:FireEvent("ChangedSelected", self._selectShopTypeID)
    self._rightPageFrame:ReloadAllCell()
    if not lastSelectShopTypeID or lastSelectShopTypeID ~= self._selectShopTypeID then
      local logicCell = self._rightPageFrame:GetLogicCell(1)
      if logicCell._cell.PlayTabShowAnimation then
        logicCell._cell:PlayTabShowAnimation()
      end
      if CShopTypeConfig:GetRecorder(self._selectShopID).ShopType == 1 then
        local logicCell_Cell = logicCell._cell._cellFrame:GetLogicCell(1)
        logicCell_Cell._cell:PlayShowAnimation()
      end
    end
    if self._homePageInfo then
      self._rightPageFrame:FireEvent("Home", self._homePageInfo)
    end
    self:RefreshTopGroundFrame()
  else
    if not NekoData.BehaviorManager.BM_Shop:GetShopRefreshCointLeftChange() and id == 9 then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenresetshoppanel")
      if protocol then
        protocol.shopType = id
        protocol:Send()
      end
    end
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    if protocol then
      protocol.shopId = id
      protocol:Send()
    end
  end
end

function ShopMainDialog:OnGroupBtnCellClicked(typeId)
  if typeId == 0 then
    self:OnGroupBtnClicked(self._activeShopList[1])
    self._groupBtnFrame:FireEvent("ChangedSelected", 0)
  else
    self:OnGroupBtnClicked(self._typeGroupData[typeId][1])
  end
end

function ShopMainDialog:OnChargeAccmulationReceiveReawrd(notification)
  self:OnGroupBtnCellClicked(2)
end

function ShopMainDialog:SetJumpMonthCardFlag(flag)
  self._jumpMonthCardFlag = flag
end

function ShopMainDialog:GetJumpMonthCardFlag()
  return self._jumpMonthCardFlag
end

function ShopMainDialog:GetHomePageInfo()
  return self._homePageInfo
end

return ShopMainDialog
