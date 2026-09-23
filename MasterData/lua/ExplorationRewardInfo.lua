--勘探物品奖励信息
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfg)
    if cfg then
        self.cfg=cfg;
    end
end

function this:GetCfg()
    return self.cfg;
end

function this:SetData(_d)
    self.data=_d;
end

--是否是无限奖励
function this:IsInfinite()
    return self.cfg and self.cfg.isInfinite==1 or false;
end

--当前奖励状态： ExplorationRewardState
function this:GetState()
    return self.data and self.data.state or ExplorationRewardState.Lock;
end

function this:GetLv()
    return self.cfg and self.cfg.index or 0;
end

-- function this:GetRewardType()
--     return self.cfg and self.cfg.rewardType or nil;
-- end

-- function this:GetGoodsID()
--     return self.cfg and self.cfg.goodsID or nil;
-- end

-- function this:GetCount()
--     return self.cfg and self.cfg.count or nil;
-- end

--返回奖励Json
function this:GetReward()
    return self.cfg and self.cfg.jGets or nil;
end

function this:GetRewardData()
    local list=nil;
    local rewards=self:GetReward();
    if  rewards then
        list={};
        for k,v in ipairs(rewards) do
            table.insert(list,{id=v[1],num=v[2],type=v[3]});
        end
    end
    return list;
end 

--返回当前奖励中的稀有奖励
function this:GetSPReward()
    local rewards=nil;
    if self.cfg and self.cfg.tag then
        local list=self:GetRewardData();
        if self.cfg.tag==2 then --取两个物品
            rewards=list;
        else
            local idx=self.cfg.tag==3 and 2 or 1;
            rewards={list[idx]}
        end
    end
    return rewards;
end

return this;