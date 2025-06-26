-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGameFlappyBirdUIApi.lua

AmusementParkGameFlappyBirdUIApi = BaseLangApi:Extend()

function AmusementParkGameFlappyBirdUIApi:Init()
	self:RegisterApi("TextCurrentLV", self.GetTextCurrentLV)
	self:RegisterApi("TextGameScore", self.GetTextGameScore)
	self:RegisterApi("TextRank", self.GetTextRank)
end

function AmusementParkGameFlappyBirdUIApi:GetTextRank(rank)
	if rank == nil or rank <= 0 then
		return self:GetCfgText(3830093)
	end

	return rank
end

function AmusementParkGameFlappyBirdUIApi:GetTextGameScore(s)
	return string.format("%ss", s)
end

function AmusementParkGameFlappyBirdUIApi:GetTextCurrentLV(lv)
	if lv == 0 then
		return self:GetCfgText(3830085)
	end

	return string.format(self:GetCfgText(3830092), lv)
end

AmusementParkGameFlappyBirdUIApi:Init()
