local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ColumnNum = 7
local HalloweenSheet2 = class("HalloweenSheet2", Dialog)
HalloweenSheet2.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenSheet2.AssetName = "ActivityHalloweenTicket"

function HalloweenSheet2:Ctor(...)
  HalloweenSheet2.super.Ctor(self, ...)
  self._rewardData = {}
end

function HalloweenSheet2:OnCreate()
  self._poolName = self:GetChild("PoolName")
  self._poolTxt = self:GetChild("PoolTxt")
  self._staticTxt1 = self:GetChild("Text")
  self._activeTime = self:GetChild("ActiveTime")
  self._currencyIcon = self:GetChild("Item")
  self._num1 = self:GetChild("Txt/Num1")
  self._num2 = self:GetChild("Txt/Num2")
  self._panel = self:GetChild("FrameTask")
  self._currencyNum = self:GetChild("NowNum")
  self._confirmBtn = self:GetChild("Btn3")
  self._tipsBtn = self:GetChild("Tips")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyIcon:Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._frame = GridFrame.Create(self._panel, self, true, ColumnNum, true)
  LuaNotificationCenter.AddObserver(self, self.RefreshRewardData, Common.n_OnSOpenHalloweenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRewardData, Common.n_OnSRefreshHalloweenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
  self:SetData()
end

function HalloweenSheet2:SetStaticRes()
  self._poolName:SetText(TextManager.GetText(CStringRes:GetRecorder(1634).msgTextID))
  self._poolTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1635).msgTextID))
  self._staticTxt1:SetText(TextManager.GetText(CStringRes:GetRecorder(1632).msgTextID))
  self._activeTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1627).msgTextID))
  self._currencyItem = Item.Create(DataCommon.PumpkinPie)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function HalloweenSheet2:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function HalloweenSheet2:SetData(data)
  self:RefreshCurrencyData()
  self:RefreshRewardData()
end

function HalloweenSheet2:RefreshCurrencyData()
  local havePumpkinPieNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.PumpkinPie)
  self._currencyNum:SetText(NumberManager.GetShowNumber(havePumpkinPieNum))
end

function HalloweenSheet2:RefreshRewardData()
  for key, _ in pairs(self._rewardData) do
    self._rewardData[key] = nil
  end
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID)
  local allRewards, allRewardsOnceNum, allRewardsTotalNum = bm:GetPumpkinPieReward()
  if allRewards then
    for itemID, itemNum in pairs(allRewards) do
      local item = Item.Create(itemID)
      table.insert(self._rewardData, {
        item = item,
        itemNum = allRewardsOnceNum[itemID],
        itemNowNum = itemNum,
        itemTotalNum = allRewardsTotalNum[itemID]
      })
    end
    table.sort(self._rewardData, function(itemA, itemB)
      local sortIdA1 = bm:GetPumpkinPieRewardSort(itemA.item:GetID())
      local sortIdB1 = bm:GetPumpkinPieRewardSort(itemB.item:GetID())
      if sortIdA1 == nil then
        sortIdA1 = math.maxinteger
      end
      if sortIdB1 == nil then
        sortIdB1 = math.maxinteger
      end
      return sortIdA1 < sortIdB1
    end)
    self._allRewardsLen = table.sum(allRewards)
    self._allRewardsTotalNumLen = table.sum(allRewardsTotalNum)
    self._num1:SetText(self._allRewardsLen)
    self._num2:SetText(self._allRewardsTotalNumLen)
  else
    self._num1:SetText("")
    self._num2:SetText("")
  end
  self._frame:ReloadAllCell()
end

function HalloweenSheet2:CellAtIndex(frame, index)
  return "activity.halloween.halloweenticketcell"
end

function HalloweenSheet2:NumberOfCell(frame, index)
  return #self._rewardData
end

function HalloweenSheet2:DataAtIndex(frame, index)
  return {
    data = self._rewardData[index],
    index = index
  }
end

function HalloweenSheet2:OnConfirmBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("activity.halloween.halloweenexchangedialog")
  if dialog then
    dialog:SetData(self._allRewardsLen)
  end
end

function HalloweenSheet2:OnTipsBtnClicked()
  local dialogName = "activity.halloween.halloweentipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1630).msgTextID)
  end
end

function HalloweenSheet2:OnCurrencyIconClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._currencyItem
    })
  end
end

return HalloweenSheet2
