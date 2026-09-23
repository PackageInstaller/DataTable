local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(cfg)
    self.cfg = cfg
end

function this:SetData(data)
    self.data = data
end

function this:GetID()
    return self.cfg and self.cfg.id
end

--bossId
function this:GetBossID()
    return self.data and self.data.id
end

function this:GetRealDamage()
    return self.data and tonumber(self.data.maxDamage) or 0
end

--最高伤害
function this:GetDamage()
    local damage = self:GetRealDamage()
    if damage / 10000 >= 1 then
        return math.floor(damage / 10000 * 100) / 100,true
    else
        return damage,false
    end
end

--排名
function this:GetRank()
    return self.data and self.data.rank or 0
end

--已领取奖励下标
function this:GetRewardIndex()
    return self.data and self.data.rewardIdx or 0
end

--本期剩余挑战次数
function this:GetChangeNum()
    local cur,max = self.data and self.data.cnt or 0,self.cfg and self.cfg.battleCount or 0
    -- local dungeonCfg = self:GetDungeonCfg()
    -- if dungeonCfg then
    --     local cost = DungeonUtil.GetCost(dungeonCfg)
    --     if cost then
    --         cur = BagMgr:GetCount(cost[1])
    --     end
    -- end
    return cur,max
end

function this:GetDungeonId()
    return self.cfg and self.cfg.dupId
end

function this:GetDungeonCfg()
    return Cfgs.MainLine:GetByID(self:GetDungeonId())
end

function this:GetDungeonName()
    local cfg = self:GetDungeonCfg()
    return cfg and cfg.name or ""
end

function this:GetBuffID()
    return self.cfg and self.cfg.buffId
end

function this:GetRewardID()
    return self.cfg and self.cfg.battleReward
end

function this:GetBattleRewardCfg()
    return Cfgs.CfgPeriodicBossBattleReward:GetByID(self:GetRewardID())
end

function this:GetRankRewardID()
    return self.cfg and self.cfg.rankRewardId
end

function this:GetRankRewardCfg()
    return Cfgs.CfgPeriodicBossRankReward:GetByID(self:GetRankRewardID())
end

function this:GetRankId()
    return self.cfg and self.cfg.rankId
end

function this:GetIcon()
    return self.cfg and self.cfg.icon
end

function this:GetIcon2()
    return self.cfg and self.cfg.banner
end

function this:GetBGEffect()
    return self.cfg and self.cfg.bgEffect
end

function this:GetBGName()
    return self.cfg and self.cfg.bg
end

function this:SetTimeInfo(info)
    self.timeInfo = info
end

function this:GetStartTime()
    return self.timeInfo and self.timeInfo.startTime or 0
end

function this:GetDupOverTime()
    return self.timeInfo and self.timeInfo.enterEnd or 0
end

function this:GetEndTime()
    return self.timeInfo and self.timeInfo.endTime or 0
end

--开启中
function this:IsOpen()
    return self:GetStartTime() <= TimeUtil:GetTime() and TimeUtil:GetTime() < self:GetEndTime() 
end

--结算中
function this:IsOver()
    return self:GetDupOverTime() <= TimeUtil:GetTime() and TimeUtil:GetTime() < self:GetEndTime()
end

return this