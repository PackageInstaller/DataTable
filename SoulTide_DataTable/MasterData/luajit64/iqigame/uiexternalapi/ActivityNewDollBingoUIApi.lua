-- chunkname: @IQIGame\\UIExternalApi\\ActivityNewDollBingoUIApi.lua

ActivityNewDollBingoUIApi = BaseLangApi:Extend()

function ActivityNewDollBingoUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("bingoTitle", self.GetBingoTitle)
	self:RegisterApi("btnOneTxt", self.GetBtnOneTxt)
	self:RegisterApi("btnTenTxt", self.GetBtnTenTxt)
	self:RegisterApi("btnRewardTxt", self.GetBtnRewardTxt)
	self:RegisterApi("btnRecordTxt", self.GetBtnRecordTxt)
	self:RegisterApi("btnRewardEngTxt", self.GetBtnRewardEngTxt)
	self:RegisterApi("btnRecordEngTxt", self.GetBtnRecordEngTxt)
	self:RegisterApi("bingoCellIndex", self.GetBingoCellIndex)
	self:RegisterApi("roundNum", self.GetRoundNum)
	self:RegisterApi("goTips", self.GetTips)
	self:RegisterApi("bingoTitleEng", self.GetBingoTitleEng)
	self:RegisterApi("numTimes", self.GetNumTimes)
	self:RegisterApi("circleEffectState1_IntervalTime", self.GetCircleEffectState1_IntervalTime)
	self:RegisterApi("circleEffectState2_IntervalTime", self.GetCircleEffectState2_IntervalTime)
	self:RegisterApi("circleEffectState2_Duration", self.GetCircleEffectState2_Duration)
	self:RegisterApi("circleEffectState4_Duration", self.GetCircleEffectState4_Duration)
	self:RegisterApi("tenEffectState1_Duration", self.GetTenEffectState1_Duration)
	self:RegisterApi("tenEffectState2_Duration", self.GetTenEffectState2_Duration)
	self:RegisterApi("allActiveEffectDuration", self.GetAllActiveEffectDuration)
	self:RegisterApi("tenCellEffectIntervalMax", self.GetTenCellEffectIntervalMax)
	self:RegisterApi("tenCellEffectIntervalMin", self.GetTenCellEffectIntervalMin)
	self:RegisterApi("recordTitle", self.GetRecordTitle)
	self:RegisterApi("recordTag", self.GetRecordTag)
	self:RegisterApi("recordDesc", self.GetRecordDesc)
	self:RegisterApi("recordEmptyDesc", self.GetRecordEmptyDesc)
	self:RegisterApi("recordTime", self.GetRecordTime)
	self:RegisterApi("recordName", self.GetRecordName)
	self:RegisterApi("rewardItemDesc", self.GetRewardItemDesc)
	self:RegisterApi("rewardTgBingoTxt", self.GetRewardTgBingoTxt)
	self:RegisterApi("rewardTgNumTxt", self.GetRewardTgNumTxt)
	self:RegisterApi("rewardNumDesc", self.GetRewardNumDesc)
	self:RegisterApi("rewardBingoCellDesc", self.GetRewardBingoCellDesc)
	self:RegisterApi("rewardNumName", self.GetRewardNumName)
	self:RegisterApi("rewardNumProb", self.GetRewardNumProb)
end

function ActivityNewDollBingoUIApi:GetCircleEffectState1_IntervalTime()
	return 0.2
end

function ActivityNewDollBingoUIApi:GetCircleEffectState2_IntervalTime()
	return 0.05
end

function ActivityNewDollBingoUIApi:GetCircleEffectState2_Duration()
	return 1.5
end

function ActivityNewDollBingoUIApi:GetCircleEffectState4_Duration()
	return 1
end

function ActivityNewDollBingoUIApi:GetTenEffectState1_Duration()
	return 5
end

function ActivityNewDollBingoUIApi:GetTenEffectState2_Duration()
	return 2
end

function ActivityNewDollBingoUIApi:GetAllActiveEffectDuration()
	return 2
end

function ActivityNewDollBingoUIApi:GetTenCellEffectIntervalMax()
	return 0.3
end

function ActivityNewDollBingoUIApi:GetTenCellEffectIntervalMin()
	return 0.1
end

function ActivityNewDollBingoUIApi:GetNumTimes(times)
	return tostring(times)
end

function ActivityNewDollBingoUIApi:GetBtnRecordEngTxt()
	return self:GetCfgText(3300220)
end

function ActivityNewDollBingoUIApi:GetBtnRewardEngTxt()
	return self:GetCfgText(3300221)
end

function ActivityNewDollBingoUIApi:GetRewardItemDesc(datum)
	local ret = ""

	for i, v in ipairs(datum) do
		if i == 1 then
			ret = ret .. v.name .. "*" .. tostring(v.num)
		else
			ret = ret .. "," .. v.name .. "*" .. tostring(v.num)
		end
	end

	return ret
end

function ActivityNewDollBingoUIApi:GetRecordName(name)
	return name
end

function ActivityNewDollBingoUIApi:GetRecordTime(time)
	return getDateTimeText(time)
end

function ActivityNewDollBingoUIApi:GetRecordDesc()
	return ""
end

function ActivityNewDollBingoUIApi:GetRecordEmptyDesc()
	return self:GetCfgText(3300218)
end

function ActivityNewDollBingoUIApi:GetRewardNumProb(value)
	return tostring(value * 100) .. "%"
end

function ActivityNewDollBingoUIApi:GetRewardNumName(name)
	return name
end

function ActivityNewDollBingoUIApi:GetRewardBingoCellDesc(desc)
	return desc
end

function ActivityNewDollBingoUIApi:GetRewardNumDesc()
	return self:GetCfgText(3300214)
end

function ActivityNewDollBingoUIApi:GetRewardTgNumTxt()
	return self:GetCfgText(3300215)
end

function ActivityNewDollBingoUIApi:GetRewardTgBingoTxt(type)
	if type == 1 then
		return self:GetCfgText(3300216)
	elseif type == 2 then
		return self:GetCfgText(3300223)
	end
end

function ActivityNewDollBingoUIApi:GetRecordTag(index)
	if index == 1 then
		return self:GetCfgText(3300211)
	elseif index == 2 then
		return self:GetCfgText(3300212)
	elseif index == 3 then
		return self:GetCfgText(3300213)
	end
end

function ActivityNewDollBingoUIApi:GetRecordTitle()
	return self:GetCfgText(3300202)
end

function ActivityNewDollBingoUIApi:GetBingoCellIndex(index)
	return tostring(index)
end

function ActivityNewDollBingoUIApi:GetBingoTitle()
	return self:GetCfgText(3300201)
end

function ActivityNewDollBingoUIApi:GetTitle()
	return self:GetCfgText(1233204)
end

function ActivityNewDollBingoUIApi:GetBtnOneTxt()
	return self:GetCfgText(3300204)
end

function ActivityNewDollBingoUIApi:GetBtnTenTxt()
	return self:GetCfgText(3300205)
end

function ActivityNewDollBingoUIApi:GetBtnRewardTxt()
	return self:GetCfgText(3300206)
end

function ActivityNewDollBingoUIApi:GetBtnRecordTxt()
	return self:GetCfgText(3300207)
end

function ActivityNewDollBingoUIApi:GetRoundNum(num)
	return string.format(self:GetCfgText(3300208), num)
end

function ActivityNewDollBingoUIApi:GetTips(num)
	if num > 0 then
		return string.format(self:GetCfgText(3300209), num)
	elseif num <= 0 then
		return self:GetCfgText(3300222)
	end
end

function ActivityNewDollBingoUIApi:GetBingoTitleEng()
	return self:GetCfgText(3300210)
end

ActivityNewDollBingoUIApi:Init()
