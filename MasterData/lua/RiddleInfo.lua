local this = {}
--谜题
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
	if cfgId then
		self.cfg=Cfgs.cfgQuestionsGroup:GetByID(cfgId)
		if self.cfg==nil then
			LogError("猜谜活动表：cfgQuestionsGroup中未找到ID："..tostring(cfgId).."对应的数据");
		end
	end
end

function this:SetData(_d)
	self.data=_d
	if self.data then
		self:InitCfg(self.data.drawnQuestions);
	end
end

function this:GetCfg()
	return self.cfg or nil;
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:GetContent()
	return self.cfg and self.cfg.question or ""
end

function this:GetAnswers()
	return self.data and self.data.drawnAnswers or {};
end

--已回答过的答案
function this:GetAnswerHistorys()
	return self.data and self.data.answers or nil;
end

--是否答对
function this:IsTure()
	return self.data and self.data.isTake==1 or false;
end

function this:GetDay()
	return self.data and self.data.openTime or nil;
end

function this:GetActivityData()
	if self.data and self.data.activityId then
		return RiddleMgr:GetData(self.data.activityId)
	end
end

return this;