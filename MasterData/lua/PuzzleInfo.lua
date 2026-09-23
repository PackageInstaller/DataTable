--拼图碎片信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgPuzzleBase:GetByID(cfgId);
    end
    if self.cfg==nil then
        LogError("CfgPuzzleBase中找不到对应ID："..tostring(cfgId).."的配置信息");
    end
end

function this:GetCfg()
    return self.cfg;
end

function this:SetData(proto)
    if proto then
        self.data=proto;
        self:UpdateGridsInfo(proto);
        self:UpdateRwdIds(proto);
        self:InitCfg(self.data.id);
    end
end

function this:UpdateGridsInfo(proto)
    if proto and self.data and self.data.id and self.data.id==proto.id and proto.unlockGrids then
        -- self.data.unlockGrids=proto.unlockGrids;
        local list={};
        for _,v in ipairs(proto.unlockGrids) do
            list[v]=true;
        end
        self.data.unlockGridsDic=list;
    else
        self.data.unlockGridsDic={}
    end
end

function this:UpdateRwdIds(proto)
    if proto and self.data and self.data.id and self.data.id==proto.id and proto.getRwdIds then
        local list={};
        for _,v in ipairs(proto.getRwdIds) do
            list[v]=true;
        end
        self.data.getRwdIdsDic=list;
    else
        self.data.getRwdIdsDic={}
    end
end

function this:GetData()
    return self.data;
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetBG()
    return self.cfg and self.cfg.bg or nil;
end

--是否已经领取
function this:IsRevice(idx)
    if idx and self.data and self.data.getRwdIdsDic and self.data.getRwdIdsDic[idx] then
        return true;
    else
        return false;
    end
end

function this:GetType()
    return self.cfg and self.cfg.type or 1;
end

function this:GetTaskType()
    return self.cfg and self.cfg.taskType or nil;
end

function this:GetBeginTime()
    return self.cfg and self.cfg.begTime or nil;
end

function this:GetEndTime()
    return self.cfg and self.cfg.endTime or nil;
end

--返回碎片的其他获得方式
function this:GetFragmentsWay()
    if self.cfg then
        if self.cfg.drawCost then
            return PuzzleEnum.GetWayType.Draw;
        elseif self.cfg.buyCfgId then
            return PuzzleEnum.GetWayType.Buy;
        end
    end
    return PuzzleEnum.GetWayType.Null;
end

function this:GetBuyCfg()
    if self.cfg and self.cfg.buyCfgId then
        local cfg=Cfgs.CfgPuzzleBuy:GetByID(self.cfg.buyCfgId)
        return cfg;
    end
    return nil;
end

--返回商品信息 hasOver:包含已卖完的数据
function this:GetBuyComms(hasOver)
    local list=nil;
    if self.cfg and self.cfg.buyCfgId then
        local cfg=Cfgs.CfgPuzzleBuy:GetByID(self.cfg.buyCfgId)
        local lockGrids=self:GetFragments(true);
        for k,v in ipairs(cfg.infos) do
            local comm=PuzzleCommodity.New();
            local isLock=true;
            for _,val in ipairs(lockGrids) do
                if val:IsCostsID(v.reward[1][1]) and val:IsUnlock()~=true then
                    isLock=false;
                    break;
                end
            end
            comm:SetData({cfg=v,canBuy=not isLock});
            if (hasOver) or (hasOver~=true and comm:CanBuy()) then
                list = list or {}
                table.insert(list,comm);
            end
        end
    end
    return list;
end

function this:GetDrawCfg()
    if self.cfg and self.cfg.drawCfgId then
        local cfg=Cfgs.RewardInfo:GetByID(self.cfg.drawCfgId)
        return cfg;
    end
    return nil;
end

function this:GetDrawCost()
    return self.cfg and self.cfg.drawCost or nil;
end

--返回行奖励信息
function this:GetRowRewards()
    local list={};
    if self.cfg and self.cfg.rewardId then
        local rewardCfg=Cfgs.CfgPuzzleReward:GetByID(self.cfg.rewardId);
        if rewardCfg then
            for k,v in ipairs(rewardCfg.infos) do
                if v.grids then
                    local info=PuzzleRowRewardInfo.New();
                    local state=1;
                    if self.data.getRwdIdsDic and self.data.getRwdIdsDic[k] then
                        state=3 --已领取
                    else --判断对应格子是否解锁
                        local canRevice=true;
                        for _,idx in ipairs(v.grids) do
                            if self.data.unlockGridsDic==nil or (self.data.unlockGridsDic and self.data.unlockGridsDic[idx]~=true) then
                                canRevice=false;
                                break;
                            end
                        end
                        if canRevice then
                            state=2; --可以领取
                        end
                    end
                    info:SetData({id=self.cfg.rewardId,idx=k,state=state});
                    table.insert(list,info);
                end
            end
        end
    end
    return list;
end

--返回全解锁的奖励
function this:GetOverReward()
    local list=nil;
    if self.cfg and self.cfg.rewardId then
        local rewardCfg=Cfgs.CfgPuzzleReward:GetByID(self.cfg.rewardId);
        if rewardCfg then
            for k,v in ipairs(rewardCfg.infos) do
                if v.grids==nil then
                    local info=PuzzleRowRewardInfo.New();
                    local state=1;
                    if self.data.getRwdIdsDic and self.data.getRwdIdsDic[k] then
                        state=3 --已领取
                    else --最终奖励，判断所有格子是否都已经解锁
                        local infos=self:GetFragments(true);
                        if infos and #infos==0 then
                            state=2;
                        end
                    end
                    info:SetData({id=self.cfg.rewardId,idx=k,state=state});
                    list=list or {}
                    table.insert(list,info);
                end
            end
        end
    end
    return list;
end

--是否已经全解锁奖励
function this:HasOverReward()
    if self.hasOverReward==true then
        return self.hasOverReward;
    else
        local reward=self:GetOverReward()
        if reward and reward[1]:GetState()==3 then --全解锁
            self.hasOverReward=true;
        end
        return self.hasOverReward;
    end
end

--格子是否领取奖励
function this:IsGridRevice(idx)
    if idx and self.data.unlockGridsDic and self.data.unlockGridsDic[idx]==true then
        return true
    end
    return false;
end

--返回碎片集合 isUnlock :是否只返回未解锁的碎片
function this:GetFragments(isUnlock)
    local list={};
    if self.cfg and self.cfg.gridCfgId then
        local gridCfg=Cfgs.CfgPuzzleGrid:GetByID(self.cfg.gridCfgId);
        if gridCfg then
            for k,v in ipairs(gridCfg.infos) do
                local frag=PuzzleFragment.New();
                local isReivce=false;
                if self.data.unlockGridsDic and self.data.unlockGridsDic[v.idx]==true then
                    isReivce=true;
                end
                frag:SetData(gridCfg.id,v.idx,v.unlockCost,v.reward,v.position,v.img,isReivce);
                if isUnlock==true then
                    if isReivce~=true  then
                        table.insert(list,frag);
                    end
                else
                    table.insert(list,frag);
                end
            end
        end
    end
    return list;
end

--返回单个格子预览信息
function this:GetSingleRewardGoods()
    local goods=nil;
    if self.cfg and self.cfg.gridCfgId then
        local gridCfg=Cfgs.CfgPuzzleGrid:GetByID(self.cfg.gridCfgId);
        if gridCfg then
            goods=BagMgr:GetFakeData(gridCfg.rewardShow[1][1]);
        end
    end
    return goods;
end

--是否存在达成条件但未领取的奖励(行列奖励和格子奖励)
function this:HasReward()
    local hasReward=false;
    --格子奖励
    if self:GetType()==ePuzzleType.Type1 then
        local frags=self:GetFragments(true);
        if frags then
            for k, v in ipairs(frags) do
                if v:IsUnlock() then
                    hasReward=true
                    return hasReward
                end
            end
        end
    end
    --行列奖励
    local rowRewards=self:GetRowRewards();
    if rowRewards then
        for k,v in ipairs(rowRewards) do
            if v:GetState()==2 then
                hasReward=true;
                return hasReward;
            end
        end
    end
    return hasReward;
end

return this;