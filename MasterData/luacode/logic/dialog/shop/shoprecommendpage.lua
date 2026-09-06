local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopRecommendPage = class("ShopRecommendPage", Dialog)
ShopRecommendPage.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPage.AssetName = "RecommendShop"

function ShopRecommendPage:Ctor(...)
  ShopRecommendPage.super.Ctor(self, ...)
  self._selectShopID = 0
  self._randomList = {}
  self._dailyGiftData = {}
  self._task = nil
end

function ShopRecommendPage:OnCreate()
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._cellArea = self:GetChild("CellFrame")
  self._dayGiftPanel = self:GetChild("DayGift/Frame")
  self._dailyGiftTime = self:GetChild("DayGift/Time/Time")
  self._cellFrame = TableFrame.Create(self._cellArea, self, true, false, true)
  self._dailyGiftFrame = TableFrame.Create(self._dayGiftPanel, self, true, false, true)
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true)
end

function ShopRecommendPage:OnDestroy()
  self._groupBtnFrame:Destroy()
  self._cellFrame:Destroy()
  self._dailyGiftFrame:Destroy()
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if self._monthCardTask then
    ServerGameTimer.RemoveTask(self._monthCardTask)
    self._monthCardTask = nil
  end
end

function ShopRecommendPage:RefreshCell(data)
  self._data = data.info
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Welfare) or NekoData.BehaviorManager.BM_Welfare:IsFitstRechargeGiftAllGet() then
    table.removebyvalue(self._data, 2)
  end
  local agCoinManager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  if not (agCoinManager:GetCurrentActId() > 0) then
    table.removebyvalue(self._data, 23)
  end
  self._groupBtnFrame:ReloadAllCell()
  for _, v in pairs(self._data) do
    self:OnGroupBtnClicked(v)
    break
  end
end

function ShopRecommendPage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._data
  elseif frame == self._dailyGiftFrame then
    return #self._dailyGiftData
  else
    return 1
  end
end

function ShopRecommendPage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  elseif frame == self._dailyGiftFrame then
    if #self._dailyGiftData == 1 then
      return "shop.dailygiftbigcell"
    else
      return "shop.dailygiftcell"
    end
  elseif self._selectShopID == 1 then
    return "shop.shoprecommendpagedetailcell1"
  elseif self._selectShopID == 2 then
    return "shop.shoprecommendpagedetailcell2"
  elseif self._selectShopID == DataCommon.GrowGiftShopId then
    return "shop.shoprecommendpagegrowgiftcell"
  elseif self._selectShopID == 23 then
    return "shop.shoprecommendpagedreamspiralcell"
  elseif self._selectShopID == 49 then
    return "shop.shoprecommendpagedetailcell3"
  end
end

function ShopRecommendPage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._data[index]
  elseif frame == self._dailyGiftFrame then
    return self._dailyGiftData[index]
  elseif self._selectShopID == 1 or self._selectShopID == 49 then
    return self._monthCardInfo
  else
    return nil
  end
end

function ShopRecommendPage:OnGroupBtnClicked(id, fromClick)
  self._selectShopID = id
  self._groupBtnFrame:FireEvent("ChangedSelected", self._selectShopID)
  self._cellFrame:ReloadAllCell()
  if fromClick then
    local logicCell = self._cellFrame:GetLogicCell(1)
    logicCell._cell:PlayShowAnimation()
  end
end

function ShopRecommendPage:OnEvent(eventName, arg)
  if eventName == "Home" then
    self._dailyGiftData = arg.dailyGitfInfo
    local haveFreeDailyGift = false
    for _, value in pairs(self._dailyGiftData) do
      if value.discountPrice == 0 and value.goodRemain ~= 0 then
        haveFreeDailyGift = true
        break
      end
    end
    local dailyGiftShop = NekoData.DataManager.DM_RedDot.nodeShop.childNode.KeyDailyGiftShop
    local dailyGiftShopResult = NekoData.DataManager.DM_RedDot.GetNodeResult(dailyGiftShop)
    if dailyGiftShopResult ~= haveFreeDailyGift then
      if haveFreeDailyGift then
        NekoData.DataManager.DM_RedDot.SetNodeUnread(dailyGiftShop, true)
      else
        NekoData.DataManager.DM_RedDot.SetNodeRead(dailyGiftShop, true)
      end
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
    self._dailyGiftFrame:ReloadAllCell()
    self._monthCardInfo = arg.monthCardInfo
    self._cellFrame:ReloadAllCell()
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._delTime = self._dailyGiftData[1].endTime
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:SetTime()
    end, nil)
    if self._monthCardTask then
      ServerGameTimer.RemoveTask(self._monthCardTask)
      self._monthCardTask = nil
    end
    if self._monthCardInfo[1].goodType == 13 and 0 < self._monthCardInfo[1].endTime then
      self._monthCardTask = ServerGameTimer.AddTask(self._monthCardInfo[1].endTime // 1000, -1, function()
        local protocol = LuaNetManager.CreateProtocol("protocol.shop.crefreshshophomepage")
        if protocol then
          protocol:Send()
        end
      end, nil)
    end
  elseif eventName == "BuyGoodRefresh" and arg.shopid == 1 then
    for i, v in ipairs(self._dailyGiftData) do
      if v.goodId == arg.goodInfo.goodId then
        self._dailyGiftData[i] = arg.goodInfo
        break
      end
    end
    local haveFreeDailyGift = false
    for _, value in pairs(self._dailyGiftData) do
      if value.discountPrice == 0 and value.goodRemain ~= 0 then
        haveFreeDailyGift = true
        break
      end
    end
    local dailyGiftShop = NekoData.DataManager.DM_RedDot.nodeShop.childNode.KeyDailyGiftShop
    local dailyGiftShopResult = NekoData.DataManager.DM_RedDot.GetNodeResult(dailyGiftShop)
    if dailyGiftShopResult ~= haveFreeDailyGift then
      if haveFreeDailyGift then
        NekoData.DataManager.DM_RedDot.SetNodeUnread(dailyGiftShop, true)
      else
        NekoData.DataManager.DM_RedDot.SetNodeRead(dailyGiftShop, true)
      end
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
    self._dailyGiftFrame:ReloadAllCell()
  end
end

function ShopRecommendPage:SetTime()
  local time = self._delTime
  if 0 < time then
    self._dailyGiftTime:SetText(GetTimeStr(time))
    self._delTime = self._delTime - 1000
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.crefreshshophomepage")
    if protocol then
      protocol:Send()
      return
    end
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
  end
end

function GetTimeStr(ms)
  local sec = ms // 1000
  local str
  str = TextManager.GetText(700128)
  str = string.gsub(str, "%$parameter1%$", os.date("!%H", sec))
  str = string.gsub(str, "%$parameter2%$", os.date("!%M", sec))
  str = string.gsub(str, "%$parameter3%$", os.date("!%S", sec))
  return str
end

function ShopRecommendPage:ShopRedPoint()
  self._groupBtnFrame:FireEvent("RedPoint")
end

function ShopRecommendPage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

return ShopRecommendPage
