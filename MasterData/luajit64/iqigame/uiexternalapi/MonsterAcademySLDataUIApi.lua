-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademySLDataUIApi.lua

MonsterAcademySLDataUIApi = BaseLangApi:Extend()

function MonsterAcademySLDataUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextArchiveTitle", self.GetTextArchiveTitle)
	self:RegisterApi("TextEmpty", self.GetTextEmpty)
	self:RegisterApi("TextDay", self.GetTextDay)
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("ImgBGPath", self.GetImgBGPath)
end

function MonsterAcademySLDataUIApi:GetImgBGPath(week)
	local path = self:GetResUrl(4700001)

	if week == 1 then
		return self:GetResUrl(4700001)
	elseif week == 2 then
		return self:GetResUrl(4700003)
	elseif week == 3 then
		return self:GetResUrl(4700004)
	elseif week == 4 then
		return self:GetResUrl(4700005)
	elseif week == 5 then
		return self:GetResUrl(4700006)
	end

	return path
end

function MonsterAcademySLDataUIApi:GetPanelTitle(type)
	if type == 1 then
		return self:GetCfgText(3420051)
	end

	return self:GetCfgText(3420052)
end

function MonsterAcademySLDataUIApi:GetTextDay(day)
	return string.format(self:GetCfgText(3420053), day)
end

function MonsterAcademySLDataUIApi:GetTextArchiveTitle(index, type)
	if type == 1 then
		return string.format(self:GetCfgText(3420054), index)
	end

	return self:GetCfgText(3420055)
end

function MonsterAcademySLDataUIApi:GetTextEmpty()
	return self:GetCfgText(3420056)
end

function MonsterAcademySLDataUIApi:GetTextTitle(type)
	return self:GetCfgText(3420057)
end

function MonsterAcademySLDataUIApi:GetgoTargetDesc()
	return self:GetCfgText(3420058)
end

MonsterAcademySLDataUIApi:Init()
