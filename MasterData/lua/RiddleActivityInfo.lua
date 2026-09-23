local this = {}
--猜谜活动信息
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
	if cfgId then
		self.cfg=Cfgs.cfgQuestions:GetByID(cfgId)
		if self.cfg==nil then
			LogError("猜谜活动表：cfgQuestions中未找到ID："..tostring(cfgId).."对应的数据");
		end
	end
end

function this:SetData(_d)
	self.data=_d;
	if self.data then
		self:InitCfg(self.data.id);
	end
end

function this:GetData()
	return self.data;
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:GetRewardCfgs()
	if self.cfg and self.cfg.rewardgroup then
		local cfg=Cfgs.cfgQuestionsReward:GetByID(self.cfg.rewardgroup)
		return cfg and cfg or nil;
	end
	return nil
end

function this:GetRewardsNum()
	local cfgs=self:GetRewardCfgs();
	return cfgs and #cfgs.item or 0;
end

--返回题目信息
function this:GetRiddles()
	local list={};
	if self.data and self.data.questionInfos then
		for k, v in ipairs(self.data.questionInfos) do
			local info=RiddleInfo.New();
			v.activityId=self:GetID();
			info:SetData(v);
			table.insert(list,info);
		end
	end
	return list;
end

function this:IsOpen()
	local curTime=TimeUtil:GetTime();
	local begTime = self:GetBegTime() and TimeUtil:GetTimeStampBySplit(self:GetBegTime()) or nil;
	local endTime = self:GetEndTime() and TimeUtil:GetTimeStampBySplit(self:GetEndTime()) or nil;
	if (begTime == nil and endTime == nil) then
        return false
    elseif ((begTime == nil or curTime > begTime)) and (endTime == nil or curTime < endTime) then
		return true
    end
	return true;
end

function this:GetBegTime()
	return self.cfg and self.cfg.begTime or nil;
end

function this:GetEndTime()
	return self.cfg and self.cfg.endTime or nil;
end

function this:GetAnswerCnt()
	return self.data and self.data.answerCnt or 0;
end

--返回当前是活动开放的第几天
function this:GetOpenDays()
	return self.data and self.data.openTime or 0;
end

function this:GetQuestionMaxNum()
	if self.cfg then
		return self.cfg.infos and #self.cfg.infos or 0
	end
	return 0;
end

--奖励是否已经被领取
function this:IsReivce(id)
	if self.data and self.data.reward then
		for k, v in ipairs(self.data.reward) do
			if id==v then
				return true;
			end
		end
	end
	return false;
end

--根据日期返回问题数据
function this:GetQuestionByDay(day)
	if day then
		local list=self:GetRiddles();
		if list then
			for k, v in ipairs(list) do
				if v:GetDay()==day then
					return v;
				end
			end
		end
	end
	return nil;
end

function this:GetQuestionOpenTimeByIndex(idx)
	if idx and self.cfg and self.cfg.infos[idx] then
		return self.cfg.infos[idx].openTime;
	end
	return nil;
end

--返回答对答错的CD完成时间
function this:GetTargetTimeStamp()
	if self.data and self.data.timeStamp then
		return self.data.timeStamp
	end
	return 0;
end

return this;