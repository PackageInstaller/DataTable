--道具池活动管理类
local this = MgrRegister("ItemPoolActivityMgr")

function this:Init()
    self:Clear()
    -- 道具池信息初始化
    RegressionProto:ItemPoolInfo()
end

function this:UpdatePoolInfo(proto)
    if proto and proto.info then
        self.poolInfos=self.poolInfos or {};
        for k,v in ipairs(proto.info) do
            local info=ItemPoolInfo.New();
            info:SetData(v);
            self.poolInfos[info:GetID()]=info;
        end
    else
        self.poolInfos=nil;
    end
end

function this:OnDrawRet(proto)
    if proto and proto.info then
        local info=ItemPoolInfo.New();
        info:SetData(proto.info);
        self.poolInfos=self.poolInfos or {};
        self.poolInfos[info:GetID()]=info;
    end
end

function this:GetPoolInfo(id)
    if self.poolInfos~=nil and self.poolInfos[id] then
        return self.poolInfos[id]
    end
    local info=ItemPoolInfo.New();
    info:InitCfg(id);
    return info;
end

--根据掉落类型返回当前开启的活动信息
function this:GetCurrPoolInfoByType(itemPoolExtractType)
    if itemPoolExtractType and self.poolInfos then
        for k,v in pairs(self.poolInfos) do
            if v:GetExtractType()==itemPoolExtractType and v:IsOpen() then
                return v;
            end
        end
    end
    return nil;
end

--根据道具池类型返回当前开启的活动信息
function this:GetPoolInfoByType(itemPoolType)
    if itemPoolType and self.poolInfos then
        for k,v in pairs(self.poolInfos) do
            if v:GetType()==itemPoolType and v:IsOpen() then
                return v;
            end
        end
    end
    return nil;
end

--检查对应ID的道具池是否有红点
function this:CheckPoolHasRedPoint(id)
    if id then
        local data=self:GetPoolInfo(id);
        local isRed=false;
        if data and data:GetType()==3 and data:GetBuyCommID()~=nil then
            local comm=ShopMgr:GetFixedCommodity(data:GetBuyCommID());
            if data:CanGet() then
                isRed=(comm and comm:IsOver()~=true) and true or false;
            end
        else
            isRed=data:CanGet();
        end
        return isRed;
    end
    return false;
end


--返回扭蛋图标名
function this:GetGachaBallImgName(_quality,isOpen)
    if _quality then
        return isOpen==true and "img_08_0".._quality or "img_09_0".._quality
    end
end

function this:Clear()
    self.poolInfos=nil;
end

function this:MenuLTime()
    local begTime,endTime
    local info = self:GetPoolInfoByType(ItemPoolType.LuckyGacha);
    if info then
        begTime = info:GetOpenTime() and TimeUtil:GetTimeStampBySplit(info:GetOpenTime()) or nil;
        endTime = info:GetCloseTime() and TimeUtil:GetTimeStampBySplit(info:GetCloseTime()) or nil;
    end
    return begTime,endTime
end

function this:GetPoolTime(id)
    local begTime,endTime
    local info = self:GetPoolInfo(id);
    if info then
        begTime = info:GetOpenTime() and TimeUtil:GetTimeStampBySplit(info:GetOpenTime()) or nil;
        endTime = info:GetCloseTime() and TimeUtil:GetTimeStampBySplit(info:GetCloseTime()) or nil;
    end
    return begTime,endTime
end

return this;