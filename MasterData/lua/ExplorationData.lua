--勘探活动数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化勘探配置数据失败！无效配置id")
    end
    if (self.cfg == nil) then
        self.cfg = Cfgs.CfgExploration:GetByID(cfgId)
        if (self.cfg == nil) then
            LogError("找不到勘探配置数据！id = " .. cfgId)
            do return end
        end
        local upExps=self:GetUpExpCfgs();
        for i=#upExps,1,-1 do
            if upExps[i].isInfinite~=1 then
                self.maxLv=i;
                break;
            else
                self.infiniteLv=i;
            end
        end
        -- self.maxLv=upExps and #upExps or 0;
    end
end

function this:SetData(_d)
    self.data=_d;
end

function this:GetData()
    return self.data
end

function this:GetCurrLv()
    return self.data and self.data.lv or 0;
end

function this:GetCurrExp()
    return self.data and self.data.exp or 0;
end

--返回测绘状态
function this:GetState()
    return self.data and self.data.type or ExplorationState.Normal;
end

function this:HasInfiniteLv()
    return self.infiniteLv~=nil;
end

--无限奖励可领取次数,根据协议里的次数做显示
function this:GetInfiniteRewardNum(explorationState)
    if self.data then
        if self.data.can_get_cnt>0 and ((explorationState~=nil and explorationState==ExplorationState.Normal) or explorationState==nil) then
            return self.data.can_get_cnt;
        elseif self.data.ex_can_get_cnt>0 and self:GetState()>=ExplorationState.Ex and ((explorationState~=nil and explorationState>=ExplorationState.Ex) or explorationState==nil) then
            return self.data.ex_can_get_cnt;
        end
    end
    return 0;
end

function this:GetInfiniteLv()
    return self.infiniteLv;
end

--返回无限档位的可领取状态
function this:GetInfiniteRewardState(explorationState)
    if self:HasInfiniteLv() then
        if self:GetInfiniteRewardNum(explorationState)>0 then
           return ExplorationRewardState.Available;
        end
    end
    return ExplorationRewardState.UnLock;
end

--返回解锁状态下奖励的可领取状态：rId:奖励模板ID，index：奖励下标
function this:GetRewardState(rId,index)
    local isReveice=false;
    if rId and self.data and self.data.get_infos and self.data.get_infos[rId] then
        for k,v in ipairs(self.data.get_infos[rId].gets) do
            if v==index then 
                isReveice=true;
                break;
            end
        end
    end
    local state=ExplorationRewardState.UnLock; --不可领取
    if isReveice then--已领取    
        state=ExplorationRewardState.Received;
    elseif index<=self:GetCurrLv() then --可领取
        state=ExplorationRewardState.Available;
    end
    return state;
end

function this:GetCfgVal(key)
    if key then
        return self.cfg and self.cfg[key] or nil;
    end
    return nil
end

function this:GetCfgID()
    return self:GetCfgVal("id");
end

function this:GetName()
    return self:GetCfgVal("name");
end

--返回等级配置
function this:GetLevelID()
    return self:GetCfgVal("levelID")
end

--返回模型ID
function this:GetModelID()
    return self:GetCfgVal("modelID")
end

--返回基础奖励模板ID
function this:GetBaseRewardID()
    return self:GetCfgVal("baseRewardID")
end

--返回高级奖励模板ID
function this:GetExRewardID()
    return self:GetCfgVal("fullRewardID")
end

--特殊奖励模板ID
function this:GetPlusRewardID()
    return self:GetCfgVal("spRewardID")
end

--经验获取模板
function this:GetExpGetID()
    return self:GetCfgVal("expGetID")
end

--开始时间
function this:GetStartTime()
    return self:GetCfgVal("startTime")
end

--结束时间
function this:GetEndTime()
    return self:GetCfgVal("endTime")
end

--描述
function this:GetDesc()
    return self:GetCfgVal("desc")
end

--返回当前经验获取配置
function this:GetExpGetCfg()
    local cfgId=self:GetExpGetID();
    local cfg=nil;
    if cfgId then
        cfg=Cfgs.CfgExplorationExpEnum:GetByID(cfgId);
    end
    return cfg;
end

--返回升级配置表数据,传入目标等级则会获取从当前等级到目标等级的所有配置，否则返回所有配置
function this:GetUpExpCfgs(lv)
    local expCfgs=nil;
    local currLv=self:GetCurrLv();
    if lv and currLv and lv>=currLv then
        for i=currLv,lv do
            local cfg=self:GetExpCfg(i);
            if cfg~=nil then
                expCfgs=expCfgs or {}
                table.insert(expCfgs,self:GetExpCfg(i))
            end
        end  
    else
        local lvID=self:GetLevelID();
        local cfg=Cfgs.CfgExplorationExp:GetByID(lvID);
        expCfgs= cfg.item;
    end
    return expCfgs;
end

function this:GetExpCfg(lv)
    local lvID=self:GetLevelID();
    local cfg=Cfgs.CfgExplorationExp:GetByID(lvID);
    if cfg==nil or lv==nil then
        return nil;
    end
    if lv>=self:GetMaxLv() then
        lv=self:HasInfiniteLv() and self:GetInfiniteLv() or self:GetMaxLv();
    end
    return cfg.item[lv];
end

--返回目标等级的配置信息 expType:ExplorationState勘探解锁类型 lv:目标等级奖励
function this:GetRewardCfg(expType,lv)
    if expType and lv then
        if self:HasInfiniteLv() and lv>=self:GetInfiniteLv() then
            lv=self:GetInfiniteLv();
        end
        local cfgId=self:GetBaseRewardID();
        local isUnLock=false;
        if expType==ExplorationState.Normal then
            isUnLock=true
        elseif expType==ExplorationState.Ex then
            cfgId=self:GetExRewardID();
            isUnLock=self:GetState()>=ExplorationState.Ex;
        elseif expType==ExplorationState.Plus then
            cfgId=self:GetPlusRewardID();
            isUnLock=self:GetState()>=ExplorationState.Plus;
        end        
        local cfg=Cfgs.CfgExplorationReward:GetByID(cfgId);
        if cfg==nil then
            return nil;
        end
        local rewardInfo=ExplorationRewardInfo.New()
        rewardInfo:SetCfg(cfg.item[lv]);
        if isUnLock then
            local state=self:GetRewardState(cfgId,lv);
            rewardInfo:SetData({state=state});
        else
            rewardInfo:SetData({state=ExplorationRewardState.Lock});
        end
        return rewardInfo
    end
    return nil;
end

--返回奖励对象 lv:传入目标等级则会获取从当前等级到目标等级的所有配置，否则返回到最大等级的配置 hasFirst:为true时获取从1级到目标等级的所有配置
function this:GetRewardCfgs(expType,lv,hasFirst)
    local currLv=self:GetCurrLv();
    local cfg=Cfgs.CfgExplorationReward:GetByID(self:GetBaseRewardID());
    if cfg==nil then
        return nil;
    end
    local startIdx=1
    local endIdx=#cfg.item;
    if lv then
        if hasFirst~=true then
            startIdx=currLv+1;
        end
        endIdx=lv;
    end
    local list={}
    for i=startIdx,endIdx do
        local rewardInfo=self:GetRewardCfg(expType,i);
        if rewardInfo then
            table.insert(list,rewardInfo)
        end
    end
    return list;
end

--返回基础奖励配置表,传入目标等级则会获取从当前等级到目标等级的所有配置，否则返回所有配置
function this:GetBaseRewardCfgs(lv,hasFirst)
    return self:GetRewardCfgs(ExplorationState.Normal,lv,hasFirst);
end

--返回高级奖励配置表,传入目标等级则会获取从当前等级到目标等级的所有配置，否则返回所有配置
function this:GetExRewardCfgs(lv,hasFirst)
    return self:GetRewardCfgs(ExplorationState.Ex,lv,hasFirst);
end

--返回特殊奖励配置表,传入目标等级则会获取从当前等级到目标等级的所有配置，否则返回所有配置
function this:GetPlusRewardCfgs(lv,hasFirst)
    return self:GetRewardCfgs(ExplorationState.Plus,lv,hasFirst);
end

function this:GetDailyRewardID()
    return self.cfg and self.cfg.dailyRewardID or nil;
end

function this:GetDailySPRewardID()
    return self.cfg and self.cfg.dailyspRewardID or nil;
end

--返回高级勘探每日获得奖励
function this:GetDailyReward()
    local fID=self:GetDailyRewardID();
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local rewardInfo=ExplorationRewardInfo.New()
        rewardInfo:SetCfg(cfg.item[1]);
        return rewardInfo
    end
    return nil;
end

--返回机密勘探每日获得奖励
function this:GetPlusDailyReward()
    local fID=self:GetDailySPRewardID();
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local rewardInfo=ExplorationRewardInfo.New()
        rewardInfo:SetCfg(cfg.item[1]);
        return rewardInfo
    end
    return nil;
end


--返回当前期首次购买额外奖励的第一个配置信息 ExplorationRewardInfo
function this:GetFirstRewardInfo()
    local fID=self:GetFirstRewardID();
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local rewardInfo=ExplorationRewardInfo.New()
        rewardInfo:SetCfg(cfg.item[1]);
        return rewardInfo
    end
    return nil;
end

function this:GetFirstRewardInfos()
    local fID=self:GetFirstRewardID();
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local infos={};
        for k,v in ipairs(cfg.item) do
            local rewardInfo=ExplorationRewardInfo.New()
            rewardInfo:SetCfg(v);
            table.insert(infos,rewardInfo);
        end
        return infos
    end
    return nil;
end

--返回当前期首次购买额外奖励配置信息
function this:GetFirstRewardCfg()
    local fID=self:GetFirstRewardID();
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local realCfg=cfg.item[1];
        return realCfg
    end
    return nil;
end

function this:GetFirstRewardCfgs()
    local fID=self:GetFirstRewardID();
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        return cfg.item
    end
    return nil;
end


function this:GetFirstRewardID()
    return self.cfg and self.cfg.buyRewardID or nil;
end

--首次购买额外奖励模板（仅展示）
function this:GetBuyRewardShows()
    local fID=self.cfg and self.cfg.buyRewardShowID or nil;
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local infos={};
        for k,v in ipairs(cfg.item) do
            local rewardInfo=ExplorationRewardInfo.New()
            rewardInfo:SetCfg(v);
            table.insert(infos,rewardInfo);
        end
        return infos
    end
    return nil;
end

--首次购买机密勘探额外奖励模板（仅展示）
function this:GetExBuyRewardShows()
    local fID=self.cfg and self.cfg.spRewardShowID or nil;
    if fID then
        local cfg=Cfgs.CfgExplorationReward:GetByID(fID);
        local infos={};
        for k,v in ipairs(cfg.item) do
            local rewardInfo=ExplorationRewardInfo.New()
            rewardInfo:SetCfg(v);
            table.insert(infos,rewardInfo);
        end
        return infos
    end
    return nil;
end

--返回开通目标测绘价格
function this:GetTargetPrice(targetState)
    local commInfo=self:GetTargetCommInfo(targetState);
    if commInfo~=nil then
        local priceInfo=commInfo:GetRealPrice();
        return priceInfo[1].num;
    else
        return 0;
    end
end

---台服
function this:GetTWDDataPrice(targetState)
    local commInfo=self:GetTargetCommInfo(targetState);
    return commInfo;
end

function this:GetTargetCommInfo(targetState)
    local curState=self:GetState();
    local commId=nil;
    local commInfo=nil;
    if targetState==ExplorationState.Ex then
        commId=g_ExplorationBaseShopID;
    else
        if curState==ExplorationState.Normal then
            commId=g_ExplorationPlusShopID;
        elseif curState~=ExplorationState.Plus then
            commId=g_ExplorationArbitrageShopID;
        else
            return nil;
        end
    end
    if commId then
        -- commInfo=CommodityData.New();
        -- commInfo:SetCfg(commId);
        commInfo=ShopMgr:GetFixedCommodity(commId);
        return commInfo;
    end
end

--是否达到最大等级
function this:IsMaxLv()
    if self.maxLv~=nil then
        return self:GetCurrLv()>=self.maxLv;
    else
        return true;
    end
end

--返回下一个等级值,满级后只返回满级的值
function this:GetNextLv()
    return not self:IsMaxLv() and self:GetCurrLv()+1 or self.maxLv;
end

function this:GetNextExp()
    local expCfg=nil;
    local idx=self:GetCurrLv();
    if self:HasInfiniteLv() and idx>=self:GetInfiniteLv() then
        idx=self:GetInfiniteLv();
    end
    local lvID=self:GetLevelID();
    local cfg=Cfgs.CfgExplorationExp:GetByID(lvID);
    if cfg==nil then
        return nil;
    end
    --[[
    for i=currLv,#cfg.item do
        if cfg.item[i].lv==self:GetNextLv() then
            expCfg=cfg.item[i]
            break;
        end
    end  
    return expCfg;
    ]]
    return cfg.item[idx];
end

--返回当前显示的阶段性奖励等级
function this:GetFixedSPLv(lv)
    local currLv=lv or self:GetCurrLv();
    local lvID=self:GetLevelID();
    local cfg=Cfgs.CfgExplorationExp:GetByID(lvID);
    if cfg==nil then
        return nil;
    end
    local list={};
    local index=1;
    for i=1,#cfg.item do
        if cfg.item[i].isSpecial or cfg.item[i].isInfinite==1 then --特殊奖励和无限奖励
            table.insert(list,cfg.item[i].lv)
            if cfg.item[i].lv<=currLv then
                index=index+1;
            end
        end
    end  
    index=index>#list and #list or index;
    return list[index];
end

function this:GetMaxLv()
    return self.maxLv or 0;
end

function this:GetBackImg()
    return self.cfg and self.cfg.backResource or nil;
end

function this:GetBackPos()
    return self.cfg and self.cfg.backPos or {0,0,1};
end

function this:GetBaseMailReward()
    return self.cfg and self.cfg.baseMailReward or nil;
end

function this:GetFullMailReward()
    return self.cfg and self.cfg.fullMailReward or nil;
end

return this;