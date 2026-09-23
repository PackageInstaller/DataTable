--道具池元素信息
local this = {}
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:SetData(cfg,num,round,isFull,isOver)
    self.cfg=cfg;
    self.num=num;
    self.round=round;
    self.isFull=isFull;
    self.isOver=isOver;
end

--是否关键奖励
function this:IsKeyReward()
    return self.cfg and self.cfg.iskeyreward or false;
end

function this:GetRewardNum()
    return self.cfg and self.cfg.rewardnum or 1;
end

function this:GetIndex()
    return self.cfg and self.cfg.index or 0;
end

function this:GetWeight()
    return self.cfg and self.cfg.weight or 0;
end

function this:GetInfinite()
    return self.cfg and self.cfg.isInfinite or false;
end

--返回当前剩余的奖励数量
function this:GetCurrRewardNum()
    local num=0;
    if self.num then
        local max=self:GetRewardNum();
        num=max-self.num;
    elseif self.isFull then
        num=self:GetRewardNum();
    end
    return num;
end

--返回轮次信息，SetData之后才能正常得到
function this:GetRound()
    if self.round then
        return self.round;
    end
    return 1;
end

--返回显示的数量
function this:GetShowNum()
    if self:GetInfinite() then
        return  LanguageMgr:GetByID(67021);
    else
        local num=self:GetCurrRewardNum()
        num = num or 0
        return "x"..num;
    end
end

function this:IsOver()
    if self:GetInfinite() then
        return self.isOver;
    else
        local num=self:GetCurrRewardNum();
        return num<=0
    end
end

function this:GetIndex()
    return self.cfg and self.cfg.index or 1;
end

--返回奖励道具信息
function this:GetGoodInfo(disNum)
    if self.cfg and self.cfg.reward then
        local cfgId=self.cfg.reward[1];
        local num=self.cfg.reward[2];
        local goods=nil;
        if disNum then
            goods=BagMgr:GetFakeData(cfgId);
        else
            goods=GoodsData({id=cfgId,num=num});
        end
        return goods;
    end
    return nil;
end

function this:GetRewardLevel()
    if self.cfg and self.cfg.rewardLevel then
        return self.cfg.rewardLevel
    end
    return 1;
end

function this:IsShow()
    return self.cfg and self.cfg.isShow==1 or false;
end

function this:GetLanguageID()
    return self.cfg and self.cfg.Languageid or nil;
end

function this:GetQuality()
    return self.cfg and self.cfg.quality or 1;
end

return this;