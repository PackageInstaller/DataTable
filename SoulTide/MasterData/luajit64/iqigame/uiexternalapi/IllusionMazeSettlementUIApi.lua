-- chunkname: @IQIGame\\UIExternalApi\\IllusionMazeSettlementUIApi.lua

IllusionMazeSettlementUIApi = BaseLangApi:Extend()

function IllusionMazeSettlementUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SubTitleText", self.GetSubTitleText)
	self:RegisterApi("NoItemNoticeText", self.GetNoItemNoticeText)
	self:RegisterApi("RewardItemNumText", self.GetRewardItemNumText)
	self:RegisterApi("CommentText", self.GetCommentText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("RewardLabel", self.GetRewardLabel)
end

function IllusionMazeSettlementUIApi:GetTitleText()
	return self:GetCfgText(2300053), self:GetCfgText(2300054)
end

function IllusionMazeSettlementUIApi:GetSubTitleText()
	return self:GetCfgText(2300055)
end

function IllusionMazeSettlementUIApi:GetNoItemNoticeText()
	return self:GetCfgText(1150063)
end

function IllusionMazeSettlementUIApi:GetRewardItemNumText(num)
	return "x " .. num
end

function IllusionMazeSettlementUIApi:GetCommentText(playerParams)
	return ""
end

function IllusionMazeSettlementUIApi:GetConfirmBtnText()
	return self:GetCfgText(2209002)
end

function IllusionMazeSettlementUIApi:GetRewardLabel()
	return self:GetCfgText(2300056)
end

IllusionMazeSettlementUIApi:Init()
