local this = MgrRegister("SkinDealsMgr")

function this:Init()
    self:Clear()
end

function this:SetDefaultState()
    self.data={
        dailyReward=false,
    }
    self:CheckRed();
end

function this:Update(proto)
    if proto then
        self.data=proto;
    end
    self:CheckRed()
end

function this:OnRevice(proto)
    if proto then
        self.data.dailyReward=proto.dailyReward
    end
    self:CheckRed();
end

function this:CheckRed()
    local d=self:GetData()
    local rData=nil;
    if d and d.dailyReward==false then
        rData=true;
    end
    RedPointMgr:UpdateData(RedPointType.SkinDeals,rData)  
end

function this:GetData()
    return self.data;
end

function this:Clear()
    self.data=nil;
end

return this;