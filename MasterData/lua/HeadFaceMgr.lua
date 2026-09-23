-- 头像框（只处理红点）
local this = MgrRegister("HeadFaceMgr")

function this:Init()
    self:Clear()
    self.datas = {}
end

function this:Clear()

end

--仅包含红点数据
function this:GetDatas()
    return self.datas 
end

-- 物品更新（游戏中的更新推送）
function this:UpdateGoodsData(goodsData, setNew)
    -- 物品移除
    local isChange = false
    if (goodsData:GetCount() <= 0) then
        if (self.datas[goodsData:GetID()] ~= nil) then
            self.datas[goodsData:GetID()] = nil
            isChange = true
        end
    else
        if (setNew) then
            -- 新获得或者加时间
            if (not self.datas[goodsData:GetID()]) then
                self.datas[goodsData:GetID()] = {1, goodsData:GetHeadFrameExpiry()}
                isChange = true
            end
        end
    end
    if (isChange) then
        RedPointMgr:UpdateData(RedPointType.Face, self:IsRed())
    end

    self:InitMinTime()
end

-- 是否有红点
function this:IsRed()
    for k, v in pairs(self.datas) do
        if (v[1] == 1) then
            return 1
        end
    end
    return nil
end

function this:RefreshDatas()
    for k, v in pairs(self.datas) do
        local goodsData = BagMgr:GetData(k)
        if (goodsData == nil or goodsData:GetCount() <= 0 or
            (goodsData:GetHeadFrameExpiry() and TimeUtil:GetTime() >= goodsData:GetHeadFrameExpiry())) then
            self.datas[k] = nil
        end
    end
    self:InitMinTime()
    RedPointMgr:UpdateData(RedPointType.Face, self:IsRed())
end

function this:RefreshData(id)
    self.datas[id][1] = 0
    RedPointMgr:UpdateData(RedPointType.Face, self:IsRed())
end

-- 最小更新时间
function this:InitMinTime()
    self.expiry = nil
    local curTime = TimeUtil:GetTime()
    for k, v in pairs(self.datas) do
        local goodsData = BagMgr:GetData(k)
        if (goodsData) then
            local _expiry = goodsData:GetHeadFrameExpiry()
            if (_expiry and curTime < _expiry) then
                if (self.expiry == nil or self.expiry > _expiry) then
                    self.expiry = _expiry
                end
            end
        end
    end
end

-- 红点变动的最小刷新时间
function this:GetMinExpiry()
    return self.expiry
end

function this:CheckRed(id)
    if (self.datas[id] and self.datas[id][1] == 1) then
        return true
    else
        return false
    end
end

-- 商店头像刷新时间（显示或者隐藏）
function this:GetMinShopRefreshTime()
    local minTime = nil
    local cfgs = Cfgs.CfgIconEmote:GetAll()
    local curTime = TimeUtil:GetTime()
    for k, v in pairs(cfgs) do
        if (v.shopId) then
            local itemData = ShopMgr:GetFixedCommodity(v.shopId)
            if (itemData) then
                local startTime = itemData:GetBuyStartTime()
                local sBuyEnd = itemData:GetBuyEndTime()
                local _time = nil
                if (startTime ~= 0 and curTime < startTime) then
                    _time = startTime
                elseif (sBuyEnd ~= 0 and curTime < sBuyEnd) then
                    _time = sBuyEnd
                end
                if (_time ~= nil and (minTime == nil or _time < minTime)) then
                    minTime = _time
                end
            end
        end
    end
    return minTime
end

return this
