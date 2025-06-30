-- chunkname: @IQIGame\\UIExternalApi\\HomeLandVisitUIApi.lua

HomeLandVisitUIApi = BaseLangApi:Extend()

function HomeLandVisitUIApi:Init()
	self:RegisterApi("TextToggleVisit1", self.GetTextToggleVisit1)
	self:RegisterApi("TextToggleVisit2", self.GetTextToggleVisit2)
	self:RegisterApi("TextBtnVisit", self.GetTextBtnVisit)
	self:RegisterApi("TextVisitHistoryMsg", self.GetTextVisitHistoryMsg)
	self:RegisterApi("TextVisitHistoryTitle", self.GetTextVisitHistoryTitle)
	self:RegisterApi("OpenTreasureChestErrorMsg", self.GetOpenTreasureChestErrorMsg)
	self:RegisterApi("HelpErrorMsg", self.GetHelpErrorMsg)
	self:RegisterApi("TextBtnGoHome", self.GetTextBtnGoHome)
	self:RegisterApi("TextGetReward", self.GetTextGetReward)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextEmpty", self.GetTextEmpty)
end

function HomeLandVisitUIApi:GetTextEmpty()
	return self:GetCfgText(1015573)
end

function HomeLandVisitUIApi:GetTextDes()
	return self:GetCfgText(1015564)
end

function HomeLandVisitUIApi:GetTextTitle(isEng)
	if isEng then
		return self:GetCfgText(1015565)
	end

	return self:GetCfgText(1015538)
end

function HomeLandVisitUIApi:GetTextGetReward(type, string)
	if type == 1 then
		return self:GetCfgText(1015566)
	elseif type == 2 then
		return self:GetCfgText(1015567)
	end
end

function HomeLandVisitUIApi:GetTextBtnGoHome()
	return self:GetCfgText(1015537)
end

function HomeLandVisitUIApi:GetHelpErrorMsg()
	return self:GetCfgText(1015568)
end

function HomeLandVisitUIApi:GetOpenTreasureChestErrorMsg()
	return self:GetCfgText(1015569)
end

function HomeLandVisitUIApi:GetTextVisitHistoryTitle(isEng)
	if isEng then
		return self:GetCfgText(1015565)
	end

	return self:GetCfgText(1015570)
end

function HomeLandVisitUIApi:GetTextVisitHistoryMsg(buildID, target, entryCid, entryVal)
	local cfgBuild = CfgHomeLandBuildingTable[buildID]

	if buildID == 36000001 then
		return self:GetCfgText(1015572) .. self.TextColor[201] .. entryVal .. self:GetCfgText(2200001) .. self.TextColor[0]
	elseif buildID == 36000002 then
		return self:GetCfgText(1015574) .. self.TextColor[201] .. cfgBuild.HelpParam .. self:GetCfgText(1015575) .. self.TextColor[0]
	elseif buildID == 36000003 then
		return self:GetCfgText(1015574) .. self.TextColor[201] .. cfgBuild.HelpParam .. self:GetCfgText(1015576) .. self.TextColor[0]
	elseif buildID == 36000005 then
		return self:GetCfgText(1015574) .. self.TextColor[201] .. cfgBuild.HelpParam .. self:GetCfgText(1015577) .. self.TextColor[0]
	elseif buildID == 36000006 then
		return self:GetCfgText(1015574) .. self.TextColor[201] .. cfgBuild.HelpParam .. self:GetCfgText(1015578) .. self.TextColor[0]
	end

	return ""
end

function HomeLandVisitUIApi:GetTextBtnVisit()
	return self:GetCfgText(1015538)
end

function HomeLandVisitUIApi:GetTextToggleVisit2()
	return self:GetCfgText(1015565)
end

function HomeLandVisitUIApi:GetTextToggleVisit1()
	return self:GetCfgText(1015571)
end

HomeLandVisitUIApi:Init()
