--道具池奖励池信息 (目前仅支持物品类型)
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgItemPool:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgItemPool中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
        self.rewardCfg=Cfgs.CfgItemPoolReward:GetByID(self.cfg.group);
        if self.rewardCfg==nil then
            LogError("CfgItemPoolReward中找不到对应ID："..tostring(self.cfg.group).."的配置信息");
        end
        --不同轮次分组
        self.groups={};
        self.maxRounds=0;
        for k,v in ipairs(self.rewardCfg.pool) do
            for _, g in ipairs(v.rounds) do
                self.groups[g]=self.groups[g] or {};
                table.insert(self.groups[g],v);
                if g>self.maxRounds then
                    self.maxRounds=g;
                end
            end
        end
        -- LogError("Groups------------------>")
        -- for k,v in pairs(self.groups) do
        --     LogError("key:"..tostring(k));
        --     LogError(v);
        -- end
    end
end

function this:SetData(data)
    self.data = data; --data中只存在当前轮次的抽取信息
    if self.data then
        self:InitCfg(self.data.id);
    end
end

function this:GetDrawArr()
    if self.data then
        return self.data.drawArr;
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetName()
    if self.cfg then
        return self.cfg.name;
    end
end

function this:GetType()
    if self.cfg then
        return self.cfg.type
    end
end

function this:GetRound()
    return self.data and self.data.round or 1;
end

--返回已抽取次数
function this:GetDrawCount()
    return self.data and self.data.drawTimes or 0;
end

--返回开启条件
function this:GetPropType()
    return self.cfg and self.cfg.Proptype or nil;
end

function this:GetName()
    return self.cfg and self.cfg.Propname or "";
end

--返回抽取类型
function this:GetExtractType()
    return self.cfg and self.cfg.extracttype or nil;
end

--开启时间
function this:GetOpenTime()
    return self.cfg and self.cfg.starttime or nil;
end

--结束时间
function this:GetCloseTime()
    return self.cfg and self.cfg.endtime or nil;
end

function this:IsOpen()
    local oTime=self:GetOpenTime();
    local eTime=self:GetCloseTime();
    local startTime=0;
    local endTime=0;
    if oTime~=nil then
        startTime=TimeUtil:GetTimeStampBySplit(oTime)
    end
    if eTime~=nil then
        endTime=TimeUtil:GetTimeStampBySplit(eTime)
    end
    if startTime~=0 or endTime~=0 then
        return ShopCommFunc.TimeIsBetween2(startTime, endTime)
    else
        return true;
    end
end

--canNext:是否可以进入下一轮  hasOther:是否还有下一轮
function this:CanNext()
    local maxRound=self:GetMaxRounds();
    local canNext=true;
    local hasOther=false;
    if maxRound==-1 or (maxRound-self:GetRound()>0) then
        --判断当前轮次中的所有稀有奖励是否抽取完毕
        local list=self:GetInfos(self:GetRound());
        if list then
            for k,v in ipairs(list) do
                if v:GetCurrRewardNum()>0 and v:IsKeyReward() and canNext==true then
                    canNext=false;
                    if hasOther then
                        break;
                    end
                elseif v:GetCurrRewardNum()>0 and v:IsKeyReward()~=true and hasOther~=true then
                    hasOther=true;
                    if canNext~=true then
                        break;
                    end
                end
            end
        end
    else
        canNext=false;
        hasOther=maxRound-self:GetRound()>0;
    end
    return canNext,hasOther;
end

function this:GetMaxRounds()
    if self:GetExtractType()==ItemPoolExtractType.RoundLoop or self:GetExtractType()==ItemPoolExtractType.DropLoop then
        return -1;        
    elseif self:GetExtractType()==ItemPoolExtractType.Once then
        return 1;
    else
        return self.maxRounds;
    end
end

--抽取消耗
function this:GetCost()
    return self.cfg and self.cfg.cost or nil;
end

function this:GetCostType()
    return self.cfg and self.cfg.costtype or 1;
end

--返回当前轮次可以抽取的最大次数
function this:GetRoundDrawCount(round)
    local maxRound=self:GetMaxRounds();
    if self:GetRound()>=self.maxRounds and maxRound==-1 then
        return -1;
    end
    local num=0;
    local list=self:GetInfos(self:GetRound()); --检查是否还有物品可以抽取
    if list then
        for k,v in ipairs(list) do
            num=num+v:GetCurrRewardNum();
        end
    end
    return num;
end

function this:IsOver()
    local maxRound=self:GetMaxRounds();
    if self:GetExtractType()==ItemPoolExtractType.Control then
        return GCalHelp:ItemPoolControlSoldOut(self.rewardCfg,self:GetDrawArr());
    elseif maxRound==-1 then
        return false;
    else
        local canNext,hasOther=self:CanNext();
        local isOver=false;
        local drawCount=self:GetRoundDrawCount(self:GetRound())
        if canNext~=true and hasOther~=true and drawCount==0 then
            isOver=true
        end
        return isOver;
    end
end

--返回抽取道具对象
function this:GetCostGoods()
    local cost=self:GetCost();
    if cost then
        if self:GetCostType()==1 then
            local goods=GoodsData({id=cost[1][1],num=cost[1][2]});
            return goods;
        elseif self:GetCostType()==2 then --根据当前剩余可抽取次数拿当前的消耗物品
            local index=self:GetDrawCount();
            local canNext,hasOther=self:CanNext();
            local isOver=self:IsOver()
            if isOver~=true then --抽取类型为2时所有道具组都是重要道具
                index=index+1;
                if #cost<index then
                    LogError("配置表错误！无法读取第"..index.."次消耗信息！配置表id："..tostring(self.cfg.id));
                    do return end;
                else
                    local goods=GoodsData({id=cost[index][2],num=cost[index][3]});
                    return goods;
                end
            end
        elseif self:GetCostType()==3 then
            local spCfg=self:GetPoolConsume();
            local drawCount=self:GetDrawCount();
            local num=0;
            if drawCount+1<=#spCfg.infos then
                num=spCfg.infos[drawCount+1].costNum;
            else
                num=spCfg.infos[#spCfg.infos].costNum;
            end
            local bagNum=BagMgr:GetCount(cost[1][1])
            local goods={};--需要消耗的物品
            if bagNum<num then --不够时
                if bagNum>0 then
                    table.insert(goods,GoodsData({id=cost[1][1],num=bagNum}));
                    num=num-bagNum;
                end
                if #cost>1 then --是否存在第二种可以使用的道具
                    table.insert(goods,GoodsData({id=cost[2][1],num=num}));
                end
            else--足够时
                table.insert(goods,GoodsData({id=cost[1][1],num=num}));
            end      
            return goods;            
        end
    end
end

--默认抽取次数
function this:GetDefaultCostNum()
    return self.cfg and self.cfg.costnum or 1;
end

--单次最大抽取次数 isNowRound:是否是当前轮次的剩余最大次数
function this:GetMaxCostNum(isNowRound)
    local maxNum=self.cfg and self.cfg.maxcostnum or 1;
    if self.data and isNowRound then
        local tempNum=0;
        local list=self:GetInfos(self:GetRound());
        if list then
            for k,v in ipairs(list) do
                if v:GetInfinite()==true then
                    tempNum=maxNum;
                    break;
                elseif v:GetCurrRewardNum()>0 then
                    tempNum=tempNum+v:GetCurrRewardNum();
                end
            end
        end
        maxNum=tempNum>=maxNum and maxNum or tempNum;
    end
    return maxNum;
end

--返回标题和简介
function this:GetDescInfo()
    return self.cfg and self.cfg.Languageid or nil;
end

--返回每一轮中的道具信息 hasOver:已经抽取完的奖励是否添加到列表中
function this:GetInfos(round,forceFull,hasOver)
    local list={};
    local realRound=round>self.maxRounds and self.maxRounds or round;
    local isOver=false;
    if self:GetExtractType()==ItemPoolExtractType.Control then
        --判断大奖是否被抽取
        for k,v in ipairs(self.groups[realRound]) do
            if v.iskeyreward and v.countMax and self.data and self.data.drawArr[v.index] then
                isOver=true;
                break;
            end
        end
    end
    if self.groups and self.groups[realRound]~=nil then
        for k,v in ipairs(self.groups[realRound]) do
            --获取当前轮次的道具剩余数量
            local n=nil;
            local isFull=true;   
            if self.data and self.data.drawArr[v.index] then
                n=self.data.drawArr[v.index];
            elseif self.data and self.data.round>round then
                isFull=false;
            end
            local item=ItemPoolGoodsInfo.New();
            if forceFull then
                item:SetData(v,0,round,true,isOver);
            else
                item:SetData(v,n,round,isFull,isOver);
            end
            if item:GetCurrRewardNum()>0 or hasOver==true then
                table.insert(list,item);
            end
        end
        table.sort(list,function(a,b)
            local g1=a:GetGoodInfo();
            local g2=b:GetGoodInfo();
            if g1:GetQuality()==g2:GetQuality() then
                return a:GetIndex()<b:GetIndex();
            else
                return g1:GetQuality()>g2:GetQuality()
            end
        end);
    end
    return list;
end

--是否可以抽取
function this:CanGet()
    local maxRound=self:GetMaxRounds();
    local canGet=false;
    local costGoods=self:GetCostGoods();
    local canCost=false;
    if self:GetCostType()==3 then
        local passCount=0;
        for k, v in ipairs(costGoods) do
            local needCostNum=v:GetCount();
            local costNum=costGoods and BagMgr:GetCount(v:GetID()) or 0;
            if needCostNum<=costNum then
                passCount=passCount+1;
            end
        end
        canCost=passCount==#costGoods;
    else
        local needCostNum=costGoods and costGoods:GetCount() or 1;
        local costNum=costGoods and BagMgr:GetCount(costGoods:GetID()) or 0;
        canCost=needCostNum<=costNum
    end
    if self:IsOver() then
        return canGet;
    elseif maxRound==-1 then
        canGet=canCost;
    else
        local curRound=self:GetRound();
        if curRound==maxRound then
            local list=self:GetInfos(self:GetRound()); --检查是否还有物品可以抽取
            local hasNum=true;
            if list then
                local num=0;
                for k,v in ipairs(list) do
                    num=num+v:GetCurrRewardNum();
                end
                hasNum=num>0;
            end
            if hasNum and canCost then
                canGet=true;
            end
        elseif canCost then
            canGet=true;
        end
    end
    return canGet;
end

function this:GetFullInfos()
    local dList={};
    if self.groups then
        for k,v in pairs(self.groups) do
            local list=self:GetInfos(k);
            table.insert(dList,{round=k,infos=list});
        end
        table.sort(dList,function(a,b)
            return a.round<b.round;
        end);
    end
    return dList;
end

--返回奖励预览列表
function this:GetRewardInfos()
    local dList={};
    local sortNum=function(a,b)
        return a>b;
    end
    if self.rewardCfg then
        for k,v in ipairs(self.rewardCfg.pool) do
            local key=nil;
            local currRound=nil;
            local min,max=1,1;
            if #v.rounds>1 then
                table.sort(v.rounds,sortNum)
                min=v.rounds[#v.rounds];
                max=v.rounds[1];
                key=min.."~"..max;
                currRound=min;
            elseif #v.rounds==1 then
                key=tostring(v.rounds[1]);
                currRound=v.rounds[1];
                min=currRound;
                max=currRound;
            end
            if key==nil then
                break;
            end
            local index=-1;
            for k,v in ipairs(dList) do
                if v.key==key then
                    index=k;
                    break;
                end
            end
            if index==-1 then --不同样的数据
                local list=self:GetInfos(currRound,true);
                table.insert(dList,{sRound=currRound,infos=list,key=key,min=min,max=max,type=self:GetExtractType(),maxRounds=self.maxRounds});
            end
        end
        table.sort(dList,function(a,b)
            return a.sRound<b.sRound;
        end);
    end
    return dList;
end

--返回当前轮次对应级别的奖励
function this:GetCurrRoundGradeInfo(itemPoolGoodsGrade,isShow)
    if itemPoolGoodsGrade then
        local list=self:GetInfos(self:GetRound(),false,true);
        if list then
            for k,v in ipairs(list) do
                if v:GetRewardLevel()==itemPoolGoodsGrade and (isShow~=true or (isShow==true and v:IsShow())) then
                    return v;
                end
            end
        end
    end
end


--返回保底次数
function this:GetCountMax()
    local num=0;
    local round=self:GetRound();
    local realRound=round>self.maxRounds and self.maxRounds or round;
    if self.groups then
        for k,v in ipairs(self.groups[realRound]) do
            if v.iskeyreward and v.countMax then
                num=v.countMax;
                break;
            end
        end
    end
    return num;
end

function this:IsLimitImg()
    return self.cfg and self.cfg.limitimg==1 or false;
end

--返回可以直购的商品ID
function this:GetBuyCommID()
    return self.cfg and self.cfg.canBuy or nil;
end

--道具池消耗表,配置之后的消耗需要以这里的为准进行扣除
function this:GetPoolConsume()
    if self.cfg and self.cfg.specialCost then
        local cfg=Cfgs.CfgItemPoolConsume:GetByID(self.cfg.specialCost);
        return cfg;
    end
end

--返回指定轮次最高奖励等级
function this:GetTopRewardLv(round)
    local round=round or self:GetRound();
    local realRound=round>self.maxRounds and self.maxRounds or round;
    local list=self.groups[realRound];
    if list~=nil then
        table.sort(list,function(a,b)
            return a.rewardLevel<b.rewardLevel
        end)
        return list[1].rewardLevel;
    end
end

return this;