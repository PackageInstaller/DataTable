-- chunkname: @IQIGame\\UIExternalApi\\DailyActivityTipsUIApi.lua

DailyActivityTipsUIApi = BaseLangApi:Extend()

function DailyActivityTipsUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextMsg", self.GetTextMsg)
end

function DailyActivityTipsUIApi:GetTextMsg()
	return self:GetCfgText(3300445)
end

function DailyActivityTipsUIApi:GetTextTitle()
	return self:GetCfgText(3300199)
end

DailyActivityTipsUIApi:Init()
