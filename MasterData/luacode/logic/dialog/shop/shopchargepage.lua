local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopChargePage = class("ShopChargePage", Dialog)
ShopChargePage.AssetBundleName = "ui/layouts.baseshop"
ShopChargePage.AssetName = "RechargeShop"
local BottomToTop = 3

function ShopChargePage:Ctor(...)
  ShopChargePage.super.Ctor(self, ...)
end

function ShopChargePage:OnCreate()
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._cellArea = self:GetChild("CellFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._accumulationButton = self:GetChild("DetailBtn")
  self._accumulationRedPoint = self:GetChild("DetailBtn/RedDot")
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, 4)
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true, true)
  self._accumulationButton:Subscribe_PointerClickEvent(self.OnAccumulationButtonClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnChargeAccumulationUnlock, Common.n_ChargeAccumulationUnlock, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChargeAccumulationAddPoints, Common.n_ChargeAccumulationAddPoints, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChargeAccumulationReceiveReward, Common.n_ChargeAccumulationReceiveReward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnFlowerActivityEnd, Common.n_FlowerActivityEnd, nil)
end

function ShopChargePage:OnDestroy()
  self._groupBtnFrame:Destroy()
  self._cellFrame:Destroy()
  if self._monthCardTask then
    ServerGameTimer.RemoveTask(self._monthCardTask)
    self._monthCardTask = nil
  end
end

function ShopChargePage:RefreshCell(data)
  self._groupBtnShowData = data.groupInfo
  table.sort(self._groupBtnShowData)
  self._groupBtnFrame:ReloadAllCell()
  self._goodInfoData = data.goodInfo
  table.sort(self._goodInfoData, function(a, b)
    return a.sortId < b.sortId
  end)
  self._cellFrame:ReloadAllCell()
  for key, value in ipairs(self._goodInfoData) do
    if value.goodType == 11 or value.goodType == 12 then
      self._lastDiamondIndex = key
    end
  end
  self._totalLength = self._cellFrame:GetTotalLength()
  self._showLength = select(2, self._cellArea:GetRectSize())
  self._scrollBar:SetActive(self._showLength < self._totalLength)
  self._cellFrame:SetSlide(self._showLength < self._totalLength)
  self._accumulationButton:SetActive(NekoData.BehaviorManager.BM_Shop:IsChargeAccumulationUnlock())
  self:RefreshAccumulationRedPoint()
  if self._monthCardTask then
    ServerGameTimer.RemoveTask(self._monthCardTask)
    self._monthCardTask = nil
  end
  if self._delegate._selectShopID == 50 then
    for _, value in pairs(self._goodInfoData) do
      if value.goodType == 13 and value.endTime > 0 then
        self._monthCardTask = ServerGameTimer.AddTask(value.endTime // 1000, -1, function()
          if self._delegate._selectShopID == 4 then
            NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(50)
          end
        end, nil)
        break
      end
    end
  end
  local dialog = DialogManager.GetDialog("uniqueequip.uniqueequipdialog")
  if dialog then
    if dialog._openShopAccumulationDialog and self._delegate._selectShopID == DataCommon.AccumulationShopId then
      self:OnAccumulationButtonClicked()
      local accumulationDialog = DialogManager.GetDialog("shop.shopaccumulationdialog")
      if accumulationDialog and accumulationDialog._rewardFrame then
        accumulationDialog._rewardFrame:MoveLeftToIndex(13)
      end
    end
    dialog._openShopAccumulationDialog = false
  end
end

function ShopChargePage:OnCurPosChange(frame, proportion)
  if self._showLength and self._totalLength then
    self._scrollBar:SetScrollSize(self._showLength / self._totalLength)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function ShopChargePage:RefreshAccumulationRedPoint()
  local needShowAccumulationRedPoint = DM_RedDot.GetNodeResult(DM_RedDot.nodeShop.childNode.KeyHasAccumulationRewardToGet)
  self._accumulationRedPoint:SetActive(needShowAccumulationRedPoint)
end

function ShopChargePage:OnGroupBtnClicked(id)
  self._delegate:OnGroupBtnClicked(id)
end

function ShopChargePage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._groupBtnShowData
  else
    return #self._goodInfoData
  end
end

function ShopChargePage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  elseif self._delegate._selectShopID == 4 or self._delegate._selectShopID == 50 then
    if self._goodInfoData[index].goodType == 13 or self._goodInfoData[index].goodType == 17 then
      return "shop.shopmonthcell"
    elseif self._goodInfoData[index].goodType == 16 then
      return "shop.shopmonthcell2"
    else
      return "shop.shoprechargecell"
    end
  else
    return "shop.shoprechargecellsoul"
  end
end

function ShopChargePage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._groupBtnShowData[index]
  else
    return {
      iteminfo = self._goodInfoData[index],
      isLastDiamondCell = self._lastDiamondIndex and index == self._lastDiamondIndex
    }
  end
end

function ShopChargePage:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    self._cellFrame:FireEvent("BuyGoodRefresh", {
      shopid = arg.shopid,
      goodInfo = arg.goodInfo
    })
  elseif eventName == "RefreshMonthCard" then
    self._cellFrame:FireEvent("RefreshMonthCard", nil)
  elseif eventName == "ChangedSelected" then
    self._groupBtnFrame:FireEvent("ChangedSelected", arg)
  elseif eventName == "RedPointInfo" and (self._delegate._selectShopID == 4 or self._delegate._selectShopID == 19 or self._delegate._selectShopID == 50) then
    self._groupBtnFrame:FireEvent("RedPointInfo", arg)
    self._cellFrame:FireEvent("RedPointInfo", arg)
  end
end

function ShopChargePage:OnAccumulationButtonClicked()
  DialogManager.CreateSingletonChildDialog("shop.shopaccumulationdialog", self._delegate._dialogName, self._delegate:GetRootWindow())
end

function ShopChargePage:OnChargeAccumulationUnlock()
  self._accumulationButton:SetActive(true)
end

function ShopChargePage:OnChargeAccumulationAddPoints(notification)
  self:RefreshAccumulationRedPoint()
end

function ShopChargePage:OnChargeAccumulationReceiveReward(notification)
  self:RefreshAccumulationRedPoint()
end

function ShopChargePage:OnFlowerActivityEnd(notification)
  self._cellFrame:FireEvent("FlowerActEnd", nil)
end

function ShopChargePage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

return ShopChargePage
