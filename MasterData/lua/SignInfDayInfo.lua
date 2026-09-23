--日数据
local this = {}

function this.New()
	local ins = {}
	this.__index = this.__index or this
	setmetatable(ins, this)
	return ins
end

function this:InitData(id, cfg)
	self.id = id
	self.cfg = cfg
end

function this:SetInfos(isDone, isEnd, isCurDay, isNextDay)
	self.isDone = isDone
	self.isEnd = isEnd
	self.isCurDay = isCurDay
	self.isNextDay = isNextDay
end

function this:GetID()
	return self.id
end

function this:GetCfg()
	return self.cfg
end

function this:CheckIsDone()
	return self.isDone
end

function this:CheckIsEnd()
	return self.isEnd
end

function this:GetIsCurDay()
	return self.isCurDay
end

function this:GetIsNextDay()
	return self.isNextDay
end

function this:GetIndex()
	return self.cfg and self.cfg.index
end

--奖励列表
function this:GetRewards()
	return self.cfg and self.cfg.rewards
end

--转化第一个数据为物体数据结构 
function this:GetGoodsData()
	local goodsData, clickCB = nil, nil
	local rewards = self:GetRewards()
	if(rewards) then
		local reward = rewards[1]
		local _data = {id = reward[1], num = BagMgr:GetCount(reward[1]), type = reward[3]}	
		goodsData, clickCB = GridFakeData(_data)
	end
	return goodsData, clickCB
end

--获取本月这天的时间戳
function this:GetDayTime()
	local tab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
	return TimeUtil:GetTime2(tab.year,tab.month,self:GetIndex(),0,0,0)
end

--特殊
function this:GetSpecial()
	return self:GetCfg() and self:GetCfg().special
end

return this 