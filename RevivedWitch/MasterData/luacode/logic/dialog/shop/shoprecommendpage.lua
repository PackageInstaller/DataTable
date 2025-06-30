-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprecommendpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopRecommendPage = class("ShopRecommendPage", Dialog)
ShopRecommendPage.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPage.AssetName = "RecommendShop"
ShopRecommendPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRecommendPage
  ((ShopRecommendPage.super).Ctor)(self, ...)
  self._selectShopID = 0
  self._randomList = {}
  self._dailyGiftData = {}
  self._task = nil
end

ShopRecommendPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._cellArea = self:GetChild("CellFrame")
  self._dayGiftPanel = self:GetChild("DayGift/Frame")
  self._dailyGiftTime = self:GetChild("DayGift/Time/Time")
  self._cellFrame = (TableFrame.Create)(self._cellArea, self, true, false, true)
  self._dailyGiftFrame = (TableFrame.Create)(self._dayGiftPanel, self, true, false, true)
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true)
end

ShopRecommendPage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._groupBtnFrame):Destroy()
  ;
  (self._cellFrame):Destroy()
  ;
  (self._dailyGiftFrame):Destroy()
  if self._backTxtTimer then
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if self._monthCardTask then
    (ServerGameTimer.RemoveTask)(self._monthCardTask)
    self._monthCardTask = nil
  end
end

ShopRecommendPage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data.info
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Welfare) or ((NekoData.BehaviorManager).BM_Welfare):IsFitstRechargeGiftAllGet() then
    (table.removebyvalue)(self._data, 2)
  end
  local agCoinManager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  if agCoinManager:GetCurrentActId() <= 0 then
    (table.removebyvalue)(self._data, 23)
  end
  ;
  (self._groupBtnFrame):ReloadAllCell()
  for _,v in pairs(self._data) do
    self:OnGroupBtnClicked(v)
    do break end
  end
end

ShopRecommendPage.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._groupBtnFrame then
    return #self._data
  else
    if frame == self._dailyGiftFrame then
      return #self._dailyGiftData
    else
      return 1
    end
  end
end

ShopRecommendPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_5 , upvalues : _ENV
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    if frame == self._dailyGiftFrame then
      if #self._dailyGiftData == 1 then
        return "shop.dailygiftbigcell"
      else
        return "shop.dailygiftcell"
      end
    else
      if self._selectShopID == 1 then
        return "shop.shoprecommendpagedetailcell1"
      else
        if self._selectShopID == 2 then
          return "shop.shoprecommendpagedetailcell2"
        else
          if self._selectShopID == DataCommon.GrowGiftShopId then
            return "shop.shoprecommendpagegrowgiftcell"
          else
            if self._selectShopID == 23 then
              return "shop.shoprecommendpagedreamspiralcell"
            else
              if self._selectShopID == 49 then
                return "shop.shoprecommendpagedetailcell3"
              end
            end
          end
        end
      end
    end
  end
end

ShopRecommendPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._groupBtnFrame then
    return (self._data)[index]
  else
    if frame == self._dailyGiftFrame then
      return (self._dailyGiftData)[index]
    else
      if self._selectShopID == 1 or self._selectShopID == 49 then
        return self._monthCardInfo
      else
        return nil
      end
    end
  end
end

ShopRecommendPage.OnGroupBtnClicked = function(self, id, fromClick)
  -- function num : 0_7
  self._selectShopID = id
  ;
  (self._groupBtnFrame):FireEvent("ChangedSelected", self._selectShopID)
  ;
  (self._cellFrame):ReloadAllCell()
  if fromClick then
    local logicCell = (self._cellFrame):GetLogicCell(1)
    ;
    (logicCell._cell):PlayShowAnimation()
  end
end

ShopRecommendPage.OnEvent = function(self, eventName, arg)
  -- function num : 0_8 , upvalues : _ENV
  if eventName == "Home" then
    self._dailyGiftData = arg.dailyGitfInfo
    local haveFreeDailyGift = false
    for _,value in pairs(self._dailyGiftData) do
      if value.discountPrice == 0 and value.goodRemain ~= 0 then
        haveFreeDailyGift = true
        break
      end
    end
    do
      local dailyGiftShop = ((((NekoData.DataManager).DM_RedDot).nodeShop).childNode).KeyDailyGiftShop
      do
        local dailyGiftShopResult = (((NekoData.DataManager).DM_RedDot).GetNodeResult)(dailyGiftShop)
        if dailyGiftShopResult ~= haveFreeDailyGift then
          if haveFreeDailyGift then
            (((NekoData.DataManager).DM_RedDot).SetNodeUnread)(dailyGiftShop, true)
          else
            ;
            (((NekoData.DataManager).DM_RedDot).SetNodeRead)(dailyGiftShop, true)
          end
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
        end
        ;
        (self._dailyGiftFrame):ReloadAllCell()
        self._monthCardInfo = arg.monthCardInfo
        ;
        (self._cellFrame):ReloadAllCell()
        if self._task then
          (ServerGameTimer.RemoveTask)(self._task)
          self._task = nil
        end
        self._delTime = ((self._dailyGiftData)[1]).endTime
        self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_8_0 , upvalues : self
    self:SetTime()
  end
, nil)
        if self._monthCardTask then
          (ServerGameTimer.RemoveTask)(self._monthCardTask)
          self._monthCardTask = nil
        end
        if ((self._monthCardInfo)[1]).goodType == 13 and ((self._monthCardInfo)[1]).endTime > 0 then
          self._monthCardTask = (ServerGameTimer.AddTask)(((self._monthCardInfo)[1]).endTime // 1000, -1, function()
    -- function num : 0_8_1 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.crefreshshophomepage")
    if protocol then
      protocol:Send()
    end
  end
, nil)
        end
        if eventName == "BuyGoodRefresh" and arg.shopid == 1 then
          for i,v in ipairs(self._dailyGiftData) do
            -- DECOMPILER ERROR at PC130: Confused about usage of register: R8 in 'UnsetPending'

            if v.goodId == (arg.goodInfo).goodId then
              (self._dailyGiftData)[i] = arg.goodInfo
              break
            end
          end
          do
            local haveFreeDailyGift = false
            for _,value in pairs(self._dailyGiftData) do
              if value.discountPrice == 0 and value.goodRemain ~= 0 then
                haveFreeDailyGift = true
                break
              end
            end
            do
              local dailyGiftShop = ((((NekoData.DataManager).DM_RedDot).nodeShop).childNode).KeyDailyGiftShop
              local dailyGiftShopResult = (((NekoData.DataManager).DM_RedDot).GetNodeResult)(dailyGiftShop)
              if dailyGiftShopResult ~= haveFreeDailyGift then
                if haveFreeDailyGift then
                  (((NekoData.DataManager).DM_RedDot).SetNodeUnread)(dailyGiftShop, true)
                else
                  ;
                  (((NekoData.DataManager).DM_RedDot).SetNodeRead)(dailyGiftShop, true)
                end
                ;
                (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
              end
              ;
              (self._dailyGiftFrame):ReloadAllCell()
            end
          end
        end
      end
    end
  end
end

ShopRecommendPage.SetTime = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local time = self._delTime
  if time > 0 then
    (self._dailyGiftTime):SetText(GetTimeStr(time))
    self._delTime = self._delTime - 1000
  else
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.crefreshshophomepage")
    if protocol then
      protocol:Send()
      return 
    end
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
  end
end

GetTimeStr = function(ms)
  -- function num : 0_10 , upvalues : _ENV
  local sec = ms // 1000
  local str = nil
  str = (TextManager.GetText)(700128)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", sec))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", sec))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", sec))
  return str
end

ShopRecommendPage.ShopRedPoint = function(self)
  -- function num : 0_11
  (self._groupBtnFrame):FireEvent("RedPoint")
end

ShopRecommendPage.PlayTabShowAnimation = function(self)
  -- function num : 0_12
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

return ShopRecommendPage

