-- chunkname: @IQIGame\\UIExternalApi\\FishingActivityMainUIApi.lua

FishingActivityMainUIApi = BaseLangApi:Extend()

function FishingActivityMainUIApi:Init()
	self:RegisterApi("TextThrowSpend", self.GetTextThrowSpend)
	self:RegisterApi("PlayerTensileValue", self.GetPlayerTensileValue)
	self:RegisterApi("FishTensileValue", self.GetFishTensileValue)
	self:RegisterApi("PlayerPercent", self.GetPlayerPercent)
	self:RegisterApi("FishPercent", self.GetFishPercent)
	self:RegisterApi("TextWeight", self.GetTextWeight)
	self:RegisterApi("TextPrice", self.GetTextPrice)
	self:RegisterApi("TextEnd", self.GetTextEnd)
	self:RegisterApi("TextEndTime", self.GetTextEndTime)
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("PlayerAddTensile", self.GetPlayerAddTensile)
	self:RegisterApi("PlayerKnocking", self.GetPlayerKnocking)
end

function FishingActivityMainUIApi:GetPlayerKnocking(value, name)
	return string.format("爆击")
end

function FishingActivityMainUIApi:GetPlayerAddTensile(value)
	return string.format("+%skp", value)
end

function FishingActivityMainUIApi:GetPanelTitle()
	return "钓鱼"
end

function FishingActivityMainUIApi:GetTextEndTime(num)
	return string.format("技能释放倒计时:%ss", num)
end

function FishingActivityMainUIApi:GetTextEnd(success)
	if success then
		return "钓鱼成功"
	end

	return "钓鱼失败"
end

function FishingActivityMainUIApi:GetTextPrice(num)
	return string.format("单价:%s 钓鱼币/吨", num)
end

function FishingActivityMainUIApi:GetTextWeight(num)
	return string.format("重量:%s kg", num)
end

function FishingActivityMainUIApi:GetFishPercent(num)
	return string.format("%s%%", num)
end

function FishingActivityMainUIApi:GetPlayerPercent(num)
	return string.format("%s%%", num)
end

function FishingActivityMainUIApi:GetFishTensileValue(num)
	return string.format("%s kp", num)
end

function FishingActivityMainUIApi:GetPlayerTensileValue(num)
	return string.format("%s kp", num)
end

function FishingActivityMainUIApi:GetTextThrowSpend(str, num)
	return string.format("消耗：%s * %s", str, num)
end

FishingActivityMainUIApi:Init()
