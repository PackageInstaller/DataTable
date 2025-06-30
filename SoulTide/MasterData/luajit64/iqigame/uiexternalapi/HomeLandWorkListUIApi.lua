-- chunkname: @IQIGame\\UIExternalApi\\HomeLandWorkListUIApi.lua

HomeLandWorkListUIApi = BaseLangApi:Extend()

function HomeLandWorkListUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("btnLvUpTxt", self.GetBtnLvUpTxt)
	self:RegisterApi("btnShopTxt", self.GetBtnShopTxt)
	self:RegisterApi("btnRecordTxt", self.GetBtnRecordTxt)
	self:RegisterApi("countDesc", self.GetCountDesc)
	self:RegisterApi("affairName", self.GetAffairName)
	self:RegisterApi("rewardEng", self.GetRewardEng)
	self:RegisterApi("statusDesc", self.GetStatusDesc)
	self:RegisterApi("statusBgPath", self.GetStatusBgPath)
	self:RegisterApi("nameBgPath", self.GetNameBgPath)
	self:RegisterApi("cellBg", self.GetCellBg)
	self:RegisterApi("needMoodTitle", self.GetNeedMoodTitle)
	self:RegisterApi("needMood", self.GetNeedMood)
	self:RegisterApi("needCountTitle", self.GetNeedCountTitle)
	self:RegisterApi("needCount", self.GetNeedCount)
	self:RegisterApi("needFavorTitle", self.GetNeedFavorTitle)
	self:RegisterApi("needFavor", self.GetNeedFavor)
	self:RegisterApi("residueTime", self.GetResidueTime)
	self:RegisterApi("btnRefreshTxt", self.GetBtnRefreshTxt)
	self:RegisterApi("freeDesc", self.GetFreeDesc)
	self:RegisterApi("refreshCost", self.GetRefreshCost)
	self:RegisterApi("bestSoulName", self.GetBestSoulNameDesc)
	self:RegisterApi("timeTitle", self.GetTitleTime)
	self:RegisterApi("workViewTitle", self.GetWorkViewTitle)
	self:RegisterApi("workViewTitle2", self.GetWorkViewTitle2)
	self:RegisterApi("workViewCellNum", self.GetWorkViewCellNum)
	self:RegisterApi("workViewCellWorkName", self.GetWorkViewCellWorkName)
	self:RegisterApi("workViewCellFinishDesc", self.GetWorkViewCellFinishDesc)
	self:RegisterApi("workViewRecordDDesc", self.GetWorkViewRecordDesc)
	self:RegisterApi("workViewCurRecordNum", self.GetWorkViewCurRecordNum)
	self:RegisterApi("workViewTotalRecordNum", self.GetWorkViewTotalRecordNum)
	self:RegisterApi("btnDeleteAllTxt", self.GetBtnDeleteAllTxt)
	self:RegisterApi("eventViewBtnDeleteTxt", self.GetEventViewBtnDeleteTxt)
	self:RegisterApi("eventViewFinishDesc", self.GetEventViewFinishDesc)
	self:RegisterApi("eventViewRewardTitle", self.GetEventViewRewardTitle)
	self:RegisterApi("eventViewRewardTitle2", self.GetEventViewRewardTitle2)
end

function HomeLandWorkListUIApi:GetEventViewRewardTitle()
	return self:GetCfgText(1015250)
end

function HomeLandWorkListUIApi:GetEventViewRewardTitle2()
	return self:GetCfgText(1015204)
end

function HomeLandWorkListUIApi:GetCountDesc(residueTimes, totalTimes)
	return self:GetCfgText(1015251) .. ": " .. tostring(residueTimes) .. "/" .. tostring(totalTimes)
end

function HomeLandWorkListUIApi:GetWorkViewCurRecordNum(num)
	return tostring(num)
end

function HomeLandWorkListUIApi:GetWorkViewTotalRecordNum(num)
	return num
end

function HomeLandWorkListUIApi:GetBtnDeleteAllTxt()
	return self:GetCfgText(1015259)
end

function HomeLandWorkListUIApi:GetEventViewFinishDesc(isPerfect)
	if isPerfect then
		return self:GetCfgText(1015252)
	else
		return self:GetCfgText(1015253)
	end
end

function HomeLandWorkListUIApi:GetEventViewBtnDeleteTxt()
	return self:GetCfgText(1015254)
end

function HomeLandWorkListUIApi:GetWorkViewCellFinishDesc(isPerfect)
	if isPerfect then
		return self:GetCfgText(1015252)
	else
		return self:GetCfgText(1015255)
	end
end

function HomeLandWorkListUIApi:GetWorkViewRecordDesc()
	return self:GetCfgText(1015256)
end

function HomeLandWorkListUIApi:GetWorkViewCellWorkName(name)
	return name
end

function HomeLandWorkListUIApi:GetWorkViewCellNum(number)
	if number < 10 then
		return "0" .. tostring(number)
	else
		return tostring(number)
	end
end

function HomeLandWorkListUIApi:GetWorkViewTitle()
	return self:GetCfgText(1015257)
end

function HomeLandWorkListUIApi:GetWorkViewTitle2()
	return self:GetCfgText(1015258)
end

function HomeLandWorkListUIApi:GetTitle(lv)
	return string.format(self:GetCfgText(1015202) .. " <Size=16>Lv.%s</Size>", lv)
end

function HomeLandWorkListUIApi:GetBtnLvUpTxt()
	return self:GetCfgText(1015022)
end

function HomeLandWorkListUIApi:GetBtnShopTxt()
	return self:GetCfgText(47)
end

function HomeLandWorkListUIApi:GetBtnRecordTxt()
	return self:GetCfgText(1015257)
end

function HomeLandWorkListUIApi:GetAffairName(name)
	return name
end

function HomeLandWorkListUIApi:GetRewardEng(isUnlock, status)
	return self:GetCfgText(1015216)
end

function HomeLandWorkListUIApi:GetStatusDesc(status)
	if status == 0 then
		return self:GetCfgText(1015207)
	elseif status == 1 then
		return self:GetCfgText(1015208)
	elseif status == 2 then
		return self:GetCfgText(1015209)
	elseif status == 3 then
		return self:GetCfgText(1015210)
	end
end

function HomeLandWorkListUIApi:GetStatusBgPath(status)
	if status == 0 then
		return self:GetResUrl(3000002)
	elseif status == 1 then
		return self:GetResUrl(3000003)
	elseif status == 2 then
		return self:GetResUrl(3000004)
	elseif status == 3 then
		return self:GetResUrl(3000001)
	else
		return self:GetResUrl(3000002)
	end
end

function HomeLandWorkListUIApi:GetNameBgPath(status)
	if status == 0 then
		return self:GetResUrl(3000010)
	elseif status == 1 then
		return self:GetResUrl(3000010)
	elseif status == 2 then
		return self:GetResUrl(3000011)
	elseif status == 3 then
		return self:GetResUrl(3000010)
	else
		return self:GetResUrl(3000010)
	end
end

function HomeLandWorkListUIApi:GetCellBg(status)
	if status == 0 then
		return self:GetResUrl(3000015)
	elseif status == 1 then
		return self:GetResUrl(3000017)
	elseif status == 2 then
		return self:GetResUrl(3000015)
	elseif status == 3 then
		return self:GetResUrl(3000016)
	else
		return self:GetResUrl(3000018)
	end
end

function HomeLandWorkListUIApi:GetNeedMoodTitle()
	return self:GetCfgText(1015211)
end

function HomeLandWorkListUIApi:GetNeedMood(mood, status)
	return mood
end

function HomeLandWorkListUIApi:GetNeedCountTitle()
	return self:GetCfgText(1015212)
end

function HomeLandWorkListUIApi:GetNeedCount(status, count)
	return "1-" .. count
end

function HomeLandWorkListUIApi:GetNeedFavorTitle()
	return self:GetCfgText(1015213)
end

function HomeLandWorkListUIApi:GetNeedFavor(status, lv)
	return lv
end

function HomeLandWorkListUIApi:GetResidueTime(time)
	return tostring(time)
end

function HomeLandWorkListUIApi:GetBtnRefreshTxt()
	return self:GetCfgText(81)
end

function HomeLandWorkListUIApi:GetFreeDesc(freeTimes)
	if freeTimes == 0 then
		return " "
	else
		return self:GetCfgText(1015218, freeTimes)
	end
end

function HomeLandWorkListUIApi:GetRefreshCost(value)
	return value
end

function HomeLandWorkListUIApi:GetBestSoulNameDesc(nameList)
	local ret = self:GetCfgText(1015217)

	ret = ret .. ":"

	for i, v in ipairs(nameList) do
		if i == 1 then
			ret = ret .. v
		else
			ret = ret .. "," .. v
		end
	end

	return ret
end

function HomeLandWorkListUIApi:GetTitleTime()
	return self:GetCfgText(1015219)
end

HomeLandWorkListUIApi:Init()
