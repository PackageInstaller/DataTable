-- chunkname: @IQIGame\\UIExternalApi\\MazeSettlementUIApi.lua

MazeSettlementUIApi = BaseLangApi:Extend()

function MazeSettlementUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SubTitleText", self.GetSubTitleText)
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("NoItemNoticeText", self.GetNoItemNoticeText)
	self:RegisterApi("RewardLabel", self.GetRewardLabel)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function MazeSettlementUIApi:GetTitleText()
	return self:GetCfgText(2300053), self:GetCfgText(2300054)
end

function MazeSettlementUIApi:GetSubTitleText()
	return self:GetCfgText(2300055)
end

function MazeSettlementUIApi:GetNoItemNoticeText()
	return self:GetCfgText(1150063)
end

function MazeSettlementUIApi:GetRewardLabel()
	return self:GetCfgText(2300056)
end

function MazeSettlementUIApi:GetMazeNameText(chapterOrder, order, name)
	if order == 0 then
		return ""
	end

	if chapterOrder == 1 then
		if order <= 3 then
			return "0-" .. order .. " " .. name
		else
			return chapterOrder .. "-" .. order - 3 .. " " .. name
		end
	end

	if chapterOrder == 16 and order <= 4 then
		return chapterOrder .. "-? " .. name
	end

	return chapterOrder .. "-" .. order .. " " .. name
end

function MazeSettlementUIApi:GetConfirmBtnText()
	return self:GetCfgText(2209001)
end

MazeSettlementUIApi:Init()
