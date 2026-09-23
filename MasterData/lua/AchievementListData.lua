local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--设置配置
function this:Init(info)
    self.info = info
end

function this:GetID()
	return self.info and self.info.typeNum
end

function this:GetKey()
	return "AchievementListData"
end

function this:GetIndex()
	return self.info and self.info.index or 0
end

function this:GetName()
	local str = ""
	if self.info and self.info.childId then
		str = LanguageMgr:GetByID(self.info.childId)
	end
	return str
end

function this:GetIcon()
	return self.info and self.info.childIcon
end

function this:GetBigIcon()
	return self.info and self.info.childBigIcon
end

--获取收集数量
function this:GetCount()
	local cur,max = 0,0
	local _datas = AchievementMgr:GetArr3(self:GetID())
	if #_datas > 0 then
		for i, v in ipairs(_datas) do
			if v:IsFinish() then
				cur = cur + 1
			end
		end
		max = #_datas
	end
	return cur,max
end

--获取各品质的收集数量
function this:GetQualityCount()
	local datas = {}
	local counts = {}
	local _datas = AchievementMgr:GetArr3(self:GetID())
	if #_datas > 0 then
		for i, v in ipairs(_datas) do
			counts[v:GetQuality()] = counts[v:GetQuality()] or {cur = 0,max = 0,index = 0}
			counts[v:GetQuality()].index = v:GetQuality()
			counts[v:GetQuality()].max = counts[v:GetQuality()].max + 1
			if v:IsFinish() then
				counts[v:GetQuality()].cur = counts[v:GetQuality()].cur + 1
			end
		end
	end
	for k, v in pairs(counts) do
		table.insert(datas,v)
	end
	if #datas>0 then
		table.sort(datas,function (a,b)
			return a.index < b.index 
		end)
	end
	return datas
end

--完成度百分比
function this:GetPercent()
	return 0
end

function this:IsShow()
	if self.info and self.info.showTime then
		local sTime = TimeUtil:GetTimeStampBySplit(self.info.showTime)
		if sTime and TimeUtil:GetTime() < sTime then
			return false
		end
	end
	return true
end

return this;