--单个活动
local this = {}

function this.New()
	local ins = {}
	this.__index = this.__index or this
	setmetatable(ins, this)
	return ins
end

function this:InitData(key, proto)
	self.key = key
	self.proto = proto
end

--混合key
function this:GetKey()
	return self.key
end

--签到表id
function this:GetID()
	return self.proto.id
end

--签到表某id的index
function this:GetIndex()
	return self.proto.index
end

--签到记录
function this:GetRewardsInfos()
	return self.proto.rewardsInfos
end

--更新记录
function this:SetRewardsInfos(rewardsInfos)
	self.proto.rewardsInfos = rewardsInfos
end

function this:SetIsMucheckin(b)
	self.proto.is_mucheckin = b
end

--签到表
function this:GetCfg()
	return Cfgs.CfgSignReward:GetByID(self:GetID())
end

--奖励表
function this:GetRewardCfg()
	local cfg = self:GetCfg()
	local rewardCfgID = cfg.infos[self:GetIndex()].activityRewardId
	return Cfgs.CfgSignRewardItem:GetByID(rewardCfgID)
end

function this:GetSortIndex()
	return self:GetCfg() and self:GetCfg().sortIndex or 0
end

--活动在当天是否已签 （根据最后签到时间来检测）
function this:CheckIsDone()
	--如果已经签到过
	if(SignInMgr:CurDayIsOpen(self.key)) then
		return true
	end
	
	--如果当天不存在签到，默认已签到
	if(not self:CurDayIsExit()) then
		return true
	end

	--不在签到时间内
	if not self:CheckInTime() then
		return true
	end
	
    local rewardsInfos = self:GetRewardsInfos();
	local time = rewardsInfos and rewardsInfos.lastSingTime 
	if(time) then
		time = time + TimeUtil:GetTZDiffTime()
		--是否是当天
		local curTime = TimeUtil:GetBJTime()
		if(curTime - time >= 86400) then
			return false
		else
			local oldDay = SignInMgr:GetCurDay(time)
			local curDay = SignInMgr:GetCurDay()
			return oldDay == curDay
		end
	else
		return false
	end
end

--当天是否存在签到
function this:CurDayIsExit(curDay)
	curDay = curDay ~= nil and curDay or SignInMgr:GetCurDay()
	local rewardCfg = self:GetRewardCfg()
	if(self:GetType() == RewardActivityType.DateDay) then
		local tab = TimeUtil:GetTimeHMS(TimeUtil:GetBJTime())
		if tab.month ~= self:GetIndex() then --不在同一个月，针对最后一天没签并等待到下一天签到的情况
			if tab.hour >= g_ActivityDiffDayTime then --超过当天刷新时间
				return false
			end
		end
		return #rewardCfg.infos >= curDay
	elseif(self:GetType() == RewardActivityType.DateMonth) then
		return false
	elseif(self:GetType() == RewardActivityType.Continuous) then
		local infos = self:GetRewardsInfos().indexs or {}
		return #rewardCfg.infos > #infos
	end
	return false
end

--[[RewardActivityType = {
	DateDay = 1, -- 月份日期类型
	DateMonth = 2, -- 天数日期类型
	Continuous = 3 -- 连续类型
}
]]
function this:GetType()
	return self:GetCfg().type
end

--活动是否在有效时间段内
function this:CheckInTime()
	local cfg = self:GetCfg()
	if cfg and not cfg.begTime and not cfg.endTime then
		return true
	end
	local begTime = TimeUtil:GetTimeStampBySplit(cfg.begTime)
	local entTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
	local curTime = TimeUtil:GetTime()
	if(curTime >= begTime and curTime <= entTime) then
		return true
	end
	return false
end

--检测某index是否已签
function this:CheckIndexIsDone(index)
	local indexs = self:GetRewardsInfos().indexs
	if(indexs[index]) then
		return true
	end
	return false
end

--连续签到，当前第几天
function this:GetRealDay()
	local indexs = self:GetRewardsInfos().indexs
	local realDay = #indexs
	if(not self:CheckIsDone()) then
		realDay = realDay + 1
	end
	return realDay
end

function this:GetActivityID()
	return self:GetCfg() and self:GetCfg().activityID
end

--连续签到结束签到
function this:CheckIsEnd()
	local cfg = self:GetCfg()
	if cfg and cfg.endTime then
		local eTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
		return eTime < TimeUtil:GetTime()
	end
	return false
end

--补签开始
function this:CheckIsFillStart()
	if self:CheckIsFillOpen() then
		return self.proto and self.proto.is_mucheckin
	end
	return false
end

--补签开启
function this:CheckIsFillOpen()
	local cfg = self:GetCfg()
	if cfg and cfg.MuCheckin and cfg.MuCheckin == 1 then
		return true
	end
	return false
end

function this:GetFillNum()
	local cfg = self:GetCfg()
	if cfg and cfg.MuCheckin_Times then
		local cost = (self.proto and self.proto.rewardsInfos and self.proto.rewardsInfos.muCheckinCost) or 0
		return cfg.MuCheckin_Times - cost
	end
	return 0
end

function this:IsShowFillNum()
	local cfg = self:GetCfg()
	if cfg and cfg.MuCheckin_Times and cfg.MuCheckin_Times >= 99 then
		return false
	end
	return true
end

function this:GetFillStartTime()
	if not self:CheckIsFillOpen() then
		return
	end
	local cfg = self:GetCfg()
	if cfg and cfg.begTime then
		return TimeUtil:GetTimeStampBySplit(cfg.begTime) + ((cfg.MuCheckin_Open or 0)*86400)
	end
	return 0
end

return this 