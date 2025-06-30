-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkDetailUIApi.lua

AmusementParkDetailUIApi = BaseLangApi:Extend()

function AmusementParkDetailUIApi:Init()
	self:RegisterApi("TextCome", self.GetTextCome)
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("TextWorkerNum", self.GetTextWorkerNum)
	self:RegisterApi("TextPer", self.GetTextPer)
	self:RegisterApi("TextContent", self.GetTextContent)
	self:RegisterApi("TextOpenLv", self.GetTextOpenLv)
end

function AmusementParkDetailUIApi:GetTextOpenLv(lv)
	if lv < 4 then
		return self:GetCfgText(3830016)
	elseif lv < 5 then
		return self:GetCfgText(3830017)
	elseif lv < 7 then
		return self:GetCfgText(3830018)
	elseif lv < 9 then
		return self:GetCfgText(3830019)
	end

	return self:GetCfgText(3830029)
end

function AmusementParkDetailUIApi:GetTextContent(count, rewardStr, success, value)
	if success then
		return string.format(self:GetCfgText(3830027), count, rewardStr)
	end

	return string.format(self:GetCfgText(3830028), count, rewardStr)
end

function AmusementParkDetailUIApi:GetTextPer(count, maxCount)
	return count
end

function AmusementParkDetailUIApi:GetTextWorkerNum(num)
	return string.format("%s", num)
end

function AmusementParkDetailUIApi:GetTextLv(lv)
	return string.format("%s", lv)
end

function AmusementParkDetailUIApi:GetTextCome(value, cid)
	if cid == 14 then
		return string.format("%s/h", value)
	end

	return string.format("%s/m", value)
end

AmusementParkDetailUIApi:Init()
