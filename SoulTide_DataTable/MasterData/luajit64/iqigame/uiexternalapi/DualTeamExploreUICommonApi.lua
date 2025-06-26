-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreUICommonApi.lua

DualTeamExploreUICommonApi = BaseLangApi:Extend()

function DualTeamExploreUICommonApi:Init()
	self:RegisterApi("TeamToggle_TitleText", self.GetTeamToggle_TitleText)
	self:RegisterApi("TeamToggle_OrderText", self.GetTeamToggle_OrderText)
	self:RegisterApi("TeamToggle_InActiveFlagText", self.GetTeamToggle_InActiveFlagText)
	self:RegisterApi("DollCell_LevelText", self.GetDollCell_LevelText)
	self:RegisterApi("TicketIcon", self.GetTicketIcon)
	self:RegisterApi("TicketTitle", self.GetTicketTitle)
	self:RegisterApi("TicketDesc", self.GetTicketDesc)
end

function DualTeamExploreUICommonApi:GetTeamToggle_TitleText(index)
	return self:GetCfgText(3410101)
end

function DualTeamExploreUICommonApi:GetTeamToggle_OrderText(index)
	return "0" .. index
end

function DualTeamExploreUICommonApi:GetTeamToggle_InActiveFlagText()
	return self:GetCfgText(3410102)
end

function DualTeamExploreUICommonApi:GetDollCell_LevelText(lv)
	return "Lv." .. lv
end

function DualTeamExploreUICommonApi:GetTicketIcon(openCount)
	if openCount == 1 then
		return self:GetResUrl(4900001)
	elseif openCount == 2 then
		return self:GetResUrl(4900002)
	elseif openCount == 3 then
		return self:GetResUrl(4900001)
	end

	return self:GetResUrl(4900001)
end

function DualTeamExploreUICommonApi:GetTicketTitle(openCount)
	if openCount == 1 then
		return self:GetCfgText(3410103)
	elseif openCount == 2 then
		return self:GetCfgText(3410105)
	elseif openCount == 3 then
		return self:GetCfgText(3410103)
	end

	return ""
end

function DualTeamExploreUICommonApi:GetTicketDesc(openCount)
	if openCount == 1 then
		return self:GetCfgText(3410104)
	elseif openCount == 2 then
		return self:GetCfgText(3410106)
	elseif openCount == 3 then
		return self:GetCfgText(3410104)
	end

	return ""
end

DualTeamExploreUICommonApi:Init()
