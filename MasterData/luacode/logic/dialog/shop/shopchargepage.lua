-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopchargepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopChargePage = class("ShopChargePage", Dialog)
ShopChargePage.AssetBundleName = "ui/layouts.baseshop"
ShopChargePage.AssetName = "RechargeShop"
local BottomToTop = 3
ShopChargePage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopChargePage
  ((ShopChargePage.super).Ctor)(self, ...)
end

ShopChargePage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, TableFrame, _ENV
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._cellArea = self:GetChild("CellFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._accumulationButton = self:GetChild("DetailBtn")
  self._accumulationRedPoint = self:GetChild("DetailBtn/RedDot")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 4)
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true, true)
  ;
  (self._accumulationButton):Subscribe_PointerClickEvent(self.OnAccumulationButtonClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChargeAccumulationUnlock, Common.n_ChargeAccumulationUnlock, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChargeAccumulationAddPoints, Common.n_ChargeAccumulationAddPoints, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChargeAccumulationReceiveReward, Common.n_ChargeAccumulationReceiveReward, nil)
end

ShopChargePage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._groupBtnFrame):Destroy()
  ;
  (self._cellFrame):Destroy()
  if self._monthCardTask then
    (ServerGameTimer.RemoveTask)(self._monthCardTask)
    self._monthCardTask = nil
  end
end

ShopChargePage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._groupBtnShowData = data.groupInfo
  ;
  (table.sort)(self._groupBtnShowData)
  ;
  (self._groupBtnFrame):ReloadAllCell()
  self._goodInfoData = data.goodInfo
  ;
  (table.sort)(self._goodInfoData, function(a, b)
    -- function num : 0_3_0
    do return a.sortId < b.sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._cellFrame):ReloadAllCell()
  for key,value in ipairs(self._goodInfoData) do
    if value.goodType == 11 or value.goodType == 12 then
      self._lastDiamondIndex = key
    end
  end
  self._totalLength = (self._cellFrame):GetTotalLength()
  self._showLength = select(2, (self._cellArea):GetRectSize())
  ;
  (self._scrollBar):SetActive(self._showLength < self._totalLength)
  ;
  (self._cellFrame):SetSlide(self._showLength < self._totalLength)
  ;
  (self._accumulationButton):SetActive(((NekoData.BehaviorManager).BM_Shop):IsChargeAccumulationUnlock())
  self:RefreshAccumulationRedPoint()
  if self._monthCardTask then
    (ServerGameTimer.RemoveTask)(self._monthCardTask)
    self._monthCardTask = nil
  end
  if (self._delegate)._selectShopID == 50 then
    for _,value in pairs(self._goodInfoData) do
      if value.goodType == 13 and value.endTime > 0 then
        self._monthCardTask = (ServerGameTimer.AddTask)(value.endTime // 1000, -1, function()
    -- function num : 0_3_1 , upvalues : self, _ENV
    if (self._delegate)._selectShopID == 4 then
      ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(50)
    end
  end
, nil)
        break
      end
    end
  end
  local dialog = (DialogManager.GetDialog)("uniqueequip.uniqueequipdialog")
  if dialog and dialog._openShopAccumulationDialog and (self._delegate)._selectShopID == DataCommon.AccumulationShopId then
    self:OnAccumulationButtonClicked()
    local accumulationDialog = (DialogManager.GetDialog)("shop.shopaccumulationdialog")
    if accumulationDialog and accumulationDialog._rewardFrame then
      (accumulationDialog._rewardFrame):MoveLeftToIndex(13)
    end
  end
  dialog._openShopAccumulationDialog = false
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

ShopChargePage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  if self._showLength and self._totalLength then
    (self._scrollBar):SetScrollSize(self._showLength / self._totalLength)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

ShopChargePage.RefreshAccumulationRedPoint = function(self)
  -- function num : 0_5 , upvalues : DM_RedDot
  local needShowAccumulationRedPoint = (DM_RedDot.GetNodeResult)(((DM_RedDot.nodeShop).childNode).KeyHasAccumulationRewardToGet)
  ;
  (self._accumulationRedPoint):SetActive(needShowAccumulationRedPoint)
end

ShopChargePage.OnGroupBtnClicked = function(self, id)
  -- function num : 0_6
  (self._delegate):OnGroupBtnClicked(id)
end

ShopChargePage.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._groupBtnFrame then
    return #self._groupBtnShowData
  else
    return #self._goodInfoData
  end
end

ShopChargePage.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    if (self._delegate)._selectShopID == 4 or (self._delegate)._selectShopID == 50 then
      if ((self._goodInfoData)[index]).goodType == 13 or ((self._goodInfoData)[index]).goodType == 17 then
        return "shop.shopmonthcell"
      else
        if ((self._goodInfoData)[index]).goodType == 16 then
          return "shop.shopmonthcell2"
        else
          return "shop.shoprechargecell"
        end
      end
    else
      return "shop.shoprechargecellsoul"
    end
  end
end

ShopChargePage.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._groupBtnFrame then
    return (self._groupBtnShowData)[index]
  else
    return {iteminfo = (self._goodInfoData)[index], isLastDiamondCell = not self._lastDiamondIndex or index == self._lastDiamondIndex}
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ShopChargePage.OnEvent = function(self, eventName, arg)
  -- function num : 0_10
  if eventName == "BuyGoodRefresh" then
    (self._cellFrame):FireEvent("BuyGoodRefresh", {shopid = arg.shopid, goodInfo = arg.goodInfo})
  else
    if eventName == "RefreshMonthCard" then
      (self._cellFrame):FireEvent("RefreshMonthCard", nil)
    else
      if eventName == "ChangedSelected" then
        (self._groupBtnFrame):FireEvent("ChangedSelected", arg)
      else
        if eventName == "RedPointInfo" and ((self._delegate)._selectShopID == 4 or (self._delegate)._selectShopID == 19 or (self._delegate)._selectShopID == 50) then
          (self._groupBtnFrame):FireEvent("RedPointInfo", arg)
          ;
          (self._cellFrame):FireEvent("RedPointInfo", arg)
        end
      end
    end
  end
end

ShopChargePage.OnAccumulationButtonClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonChildDialog)("shop.shopaccumulationdialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())
end

ShopChargePage.OnChargeAccumulationUnlock = function(self)
  -- function num : 0_12
  (self._accumulationButton):SetActive(true)
end

ShopChargePage.OnChargeAccumulationAddPoints = function(self, notification)
  -- function num : 0_13
  self:RefreshAccumulationRedPoint()
end

ShopChargePage.OnChargeAccumulationReceiveReward = function(self, notification)
  -- function num : 0_14
  self:RefreshAccumulationRedPoint()
end

ShopChargePage.PlayTabShowAnimation = function(self)
  -- function num : 0_15
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

return ShopChargePage

