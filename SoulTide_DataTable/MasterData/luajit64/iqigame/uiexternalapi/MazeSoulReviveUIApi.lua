-- chunkname: @IQIGame\\UIExternalApi\\MazeSoulReviveUIApi.lua

MazeSoulReviveUIApi = BaseLangApi:Extend()

function MazeSoulReviveUIApi:Init()
	self:RegisterApi("NoticeText", self.GetNoticeText)
	self:RegisterApi("ReviveBtnText", self.GetReviveBtnText)
end

function MazeSoulReviveUIApi:GetNoticeText(maxNum)
	return self:GetCfgText(2300057) .. maxNum .. self:GetCfgText(2300059)
end

function MazeSoulReviveUIApi:GetReviveBtnText()
	return self:GetCfgText(2300058)
end

MazeSoulReviveUIApi:Init()
