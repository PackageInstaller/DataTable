local M = BaseClass("LimitShopData")

function M:__init(shopId,protoData)
    self.m_limitShopCfg = ConfigHelper.GetCfg("extremeMissionShop",shopId)
    self.m_id = self.m_limitShopCfg.id
    self.m_itemId = self.m_limitShopCfg.shopItem
    self.m_itemNumber = self.m_limitShopCfg.itemNum
    self.m_costItemId = self.m_limitShopCfg.costItem
    self.m_costItemNumber = self.m_limitShopCfg.costNum
    self.m_times = self.m_limitShopCfg.times
    self.m_buyTimes = protoData and protoData.BuyTimes or 0
end

function M:GetId()
    return self.m_id 
end

function M:GetItemId()
    return self.m_itemId
end

function M:GetItemNumber()
    return self.m_itemNumber
end

function M:GetCostItemId()
    return self.m_costItemId
end

function M:GetCostItemNumber()
    return self.m_costItemNumber
end

function M:GetBuyTimes()
    return self.m_buyTimes
end

function M:GetCfg()
    return self.m_limitShopCfg
end

--可购买的数量
function M:GetResidualTime()
    return self.m_times - self.m_buyTimes
end

--还可以继续买吗
function M:GetBuyMore(buyTime)
    return self:GetBuyTimes() + buyTime <= self:GetCfg().times
end

--购买成功之后，更新购买次数
function M:UpdateBuyInfo(buyTime)
    if not self:GetBuyMore(buyTime) then
        Logger.LogError("更新购买次数错误")
        return 
    end
    self.m_buyTimes = self.m_buyTimes + buyTime
end

return M