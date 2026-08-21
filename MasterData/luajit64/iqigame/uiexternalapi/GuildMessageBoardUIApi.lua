-- chunkname: @IQIGame\\UIExternalApi\\GuildMessageBoardUIApi.lua

GuildMessageBoardUIApi = BaseLangApi:Extend()

function GuildMessageBoardUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("PlaceHolder", self.GetPlaceHolder)
end

function GuildMessageBoardUIApi:GetPlaceHolder()
	return self:GetCfgText(9101215)
end

function GuildMessageBoardUIApi:GetTextTitle()
	return self:GetCfgText(9101216)
end

GuildMessageBoardUIApi:Init()
