local this = MgrRegister("CumulativeSpendingMgr")
--小额付费管理
function this:Init()
    self:Clear()
    --新增所有类型为1的活动数据
    for k, v in ipairs(Cfgs.CfgMicroPayment:GetAll()) do
        local nInfo=CumulativeSpendingInfo.New();
        nInfo:InitCfg(v.id);
        table.insert(self.infos,nInfo);
    end 
    table.sort(self.infos,function(a,b)
        if a:GetIndex()==b:GetIndex() then
            return a:GetID()<b:GetID()
        else
            return a:GetIndex()<b:GetIndex()
        end
    end)
end

--返回当前开启的活动列表
function this:GetOpenInfos()
    local list={};
    for k,v in ipairs(self.infos) do
        if v:IsOpen() then
            table.insert(list,v);
        end
    end
    table.sort(list,function(a,b)
        if a:GetIndex()==b:GetIndex() then
            return a:GetID()>b:GetID()
        else
            return a:GetIndex()<b:GetIndex()
        end
    end)
    -- self:CheckRedInfo()
    return list;
end

function this:GetFirstData()
    local index=0;
    local lessStartTime=0;
    for k,v in ipairs(self.infos) do
        if v:IsOpen() then
            return v;
        elseif lessStartTime==0 or v:GetStartTime()<lessStartTime then
            lessStartTime=v:GetStartTime();
            index=k;
        end
    end
    if index~=0 and self.infos[index]~=nil then
        return self.infos[index]
    end
end

--更新数据
function this:Update(proto)
    if proto then
        for k,v in ipairs(proto.data) do
            local index=-1;
            for i, info in ipairs(self.infos) do
                if info:GetID()==v.id then
                    index=i;
                    break;
                end
            end
            local nInfo=CumulativeSpendingInfo.New();
            nInfo:SetData(v);
            if index~=-1 then
                self.infos[index]=nInfo;
            else
                table.insert(self.infos,nInfo);
            end
        end
        self:CheckRedInfo()
    end
end

function this:SetIsDailyShow(isShow)
    if isShow~=self.isDailyOn then
        TipsMgr:SaveDailyTips(self.dailyKeys, isShow);
    end
    self.isDailyOn=isShow
end

function this:GetIsDailyShow()
    return TipsMgr:IsShowDailyTips(self.dailyKeys);
end

function this:CheckRedInfo()
	local data=nil;
	if self.infos then
		for k,info in ipairs(self.infos) do
            if info:IsOpen() then
                for _, v in ipairs(info:GetCommodityList()) do
                    local price=v:GetRealPrice();
                    local isLock=info:GetLockState(v:GetID());
                    if (price==nil or (price and price.num==0)) and v:IsOver()~=true and v:GetBuyLimit()==true and isLock~=true then --免费物品且可以购买,且已解锁
                        data= data or {};
                        data[info:GetID()]=data[info:GetID()] or {}
                        data[info:GetID()][v:GetID()]=data[info:GetID()][v:GetID()] or true;
                    end
                end
            end
		end
	end
    RedPointMgr:UpdateData(RedPointType.CumulativeSpending,data)  
end

function this:Clear()
    self.isDailyOn=true;
    self.dailyKeys="CumulativeDaily";
    self.infos={};
end

return this;