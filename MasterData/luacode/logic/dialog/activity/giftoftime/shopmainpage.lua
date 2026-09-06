local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ShopMainPage = class("ShopMainPage", Dialog)
ShopMainPage.AssetBundleName = "ui/layouts.battlepassnew"
ShopMainPage.AssetName = "BattlePassNewShop"

function ShopMainPage:Ctor(...)
  ShopMainPage.super.Ctor(self, ...)
  self._goodData = {}
  self._shopId = DataCommon.GiftofTime.Shop.ShopID
end

function ShopMainPage:OnCreate()
  self._panel = self:GetChild("Frame")
  self._leftTime = self:GetChild("Time")
  self._tipBtn = self:GetChild("Tip")
  self._goodsFrame = GridFrame.Create(self._panel, self, true, 4, false)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
end

function ShopMainPage:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
  if self._goodsFrame then
    self._goodsFrame:Destroy()
  end
  if self._timerId ~= 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
  end
end

local function format_str(id, value)
  local s = TextManager.GetText(CStringRes:GetRecorder(id).msgTextID)
  return string.gsub(s, "%$parameter1%$", value)
end

local function GetRemainTimeStr(endTime)
  local str
  if endTime and 0 < endTime then
    local time = endTime
    local day = time // 86400
    local hour = math.ceil(time / 3600)
    if 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1935).msgTextID, string.format("%d", day), string.format("%d", hour - day * 24))
    else
      str = TextManager.GetText(CStringRes:GetRecorder(1936).msgTextID, hour)
    end
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1936).msgTextID, 0)
  end
  return str
end

function ShopMainPage:UpdateLeftTime()
  self._leftTimeData = self._leftTimeData - 1
  if self._leftTimeData < 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
    return
  end
  local str = GetRemainTimeStr(self._leftTimeData)
  self._leftTime:SetText(str)
end

function ShopMainPage:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(3)
end

function ShopMainPage:RefreshGoodsData(notChangePos)
  self._leftTimeData = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetWeeklyLeftTime()
  self:UpdateLeftTime()
  if self._timerId ~= 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
  end
  self._timerId = GameTimer.AddTask(1, 1, self.UpdateLeftTime, self)
  self._shopData = {}
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.GiftofTime.Shop.ShopID)
  shopData = shopData or {}
  for _, good in ipairs(shopData) do
    local isrmt = 0
    if NekoData.BehaviorManager.BM_Currency:IsRealityCurrency(good.moneyType) then
      isrmt = 1
    end
    table.insert(self._shopData, {isrmt = isrmt, iteminfo = good})
  end
  local refreshShopTime
  for i, v in ipairs(self._shopData) do
    if v.iteminfo.beginTime and v.iteminfo.endTime and v.iteminfo.beginTime ~= 0 and v.iteminfo.endTime ~= 0 and (not refreshShopTime or refreshShopTime > v.iteminfo.endTime) then
      refreshShopTime = v.iteminfo.endTime
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
  local lastPos = self._goodsFrame:GetCurrentPosition()
  self._goodsFrame:ReloadAllCell()
  if notChangePos and lastPos then
    self._goodsFrame:MoveToAssignedPos(lastPos)
  end
end

function ShopMainPage:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopId then
    self:RefreshGoodsData(true)
  end
end

function ShopMainPage:NumberOfCell(frame, index)
  if frame == self._goodsFrame then
    return #self._shopData
  end
end

function ShopMainPage:CellAtIndex(frame, index)
  if frame == self._goodsFrame then
    return "activity.giftoftime.shopgoodscell"
  end
end

function ShopMainPage:DataAtIndex(frame, index)
  if frame == self._goodsFrame then
    return self._shopData[index]
  end
end

return ShopMainPage
