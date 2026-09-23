local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--设置配置
function this:Init(cfg)
   self.cfg = cfg 
   self:SetFinish()
end

function this:SetFinish(list)
	self.cur,self.max = 0,1
	if self.cfg and self.cfg.aFinishIds then
		self.max = self.cfg.aFinishIds[2] or 1
		if list and list[self.cfg.aFinishIds[1]] then
			self.cur = list[self.cfg.aFinishIds[1]]
		end
	end
	self.cur = self.cur > self.max and self.max or self.cur
end

function this:SetIsGet(b)
	self.isGet = b
end

--领取时间
function this:SetRewardTime(time)
	self.rewardTime = time
end

--完成时间
function this:SetFinishTime(time)
	if self.finishTime == nil then
		self.finishTime = time
	end
end

function this:GetID()
	return self.cfg and self.cfg.id
end

function this:GetKey()
	return "AchievemenData"
end

function this:GetType()
	return self.cfg and self.cfg.type
end

function this:GetName()
	return self.cfg and self.cfg.sName
end

function this:GetQuality()
	return self.cfg and self.cfg.quality
end

function this:GetDesc()
	local str = ""
	if self.cfg then
		str = self.cfg.sDescription
		if self:IsHide() and not self:IsFinish() then
			str = self.cfg.sStory
		end
	end
	return str 
end

function this:GetStory()
	return self.cfg and self.cfg.sStory
end

function this:GetIcon()
	return self.cfg and self.cfg.icon
end

function this:GetIcon2()
	return self.cfg and self.cfg.icon2
end

function this:IsHide()
	return self.cfg and self.cfg.nIsHide ~= nil
end

function this:GetRewards()
	if(self.jAwardIds == nil) then
		self.jAwardId = {}
		if(self.cfg and self.cfg.jAwardId) then
			for i, v in ipairs(self.cfg.jAwardId) do
				table.insert(self.jAwardId, {id = v[1], num = v[2], type = v[3]})
			end
		end
	end
	return self.jAwardId
end

function this:GetCount(isReal)
	if not isReal and self:IsHide() and not self:IsFinish() then
		return 0,1
	else
		return self.cur,self.max
	end
end

function this:GetTimeStr()
	local str = ""
	if self.finishTime then
		local tab = TimeUtil:GetTimeHMS(self.finishTime)
		str = LanguageMgr:GetByID(47008,tab.year.."/"..tab.month.."/"..tab.day)
	end
	return str
end

--领取奖励时间
function this:GetRewardTime()
	return self.rewardTime or 0
end

--完成时间
function this:GetFinishTime()
	return self.finishTime or 0
end

function this:GetPercent(isReal)
	if self:IsHide() and not self:IsFinish() and not isReal then --隐藏成就未完成不显示
		return 0
	end
	return math.floor(self.cur / self.max * 100)
end

function this:IsFinish()
	return self.cur >= self.max and self.finishTime ~= nil
end

function this:IsGet()
	return self.isGet
end

function this:IsShow()
	if self.cfg and self.cfg.showTime then
		if not self.sTime then
			self.sTime = TimeUtil:GetTimeStampBySplit(self.cfg.showTime)
		end
		return self.sTime <= TimeUtil:GetTime()
	end
	return true
end

--前置
function this:GetPreposition()
	return self.cfg and self.cfg.before
end

--后置
function this:GetPostposition()
	return self.cfg and self.cfg.after
end

function this:GetJumpId()
	return self.cfg and self.cfg.jump
end

return this;