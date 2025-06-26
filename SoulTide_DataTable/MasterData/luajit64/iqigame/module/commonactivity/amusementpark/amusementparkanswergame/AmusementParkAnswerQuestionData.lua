-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkAnswerGame\\AmusementParkAnswerQuestionData.lua

local m = {
	playerSelectID = 0,
	isComplete = false,
	options = {}
}
local AmusementParkAnswerOptionData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkAnswerGame.AmusementParkAnswerOptionData")

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid
	self.playerSelectID = 0
	self.options = self:CreateOptions()

	self:SetQuestionState(false)
	self:RandomPosData()
end

function m:SetQuestionState(isComplete)
	self.isComplete = isComplete
end

function m:GetCfgData()
	return CfgAmusementParkQuestionBankTable[self.cid]
end

function m:IsUnlock()
	for i = 1, #self:GetCfgData().UnlockBuildingLevel, 2 do
		local needBuildID = self:GetCfgData().UnlockBuildingLevel[i]
		local needLv = self:GetCfgData().UnlockBuildingLevel[i + 1]
		local buildData = AmusementParkModule.GetAmusementParkBuildData(needBuildID)

		if buildData == nil then
			return false
		end

		if needLv > buildData.parkBuildPOD.level then
			return false
		end
	end

	return true
end

function m:CreateOptions()
	local tab = {}
	local cfgData = self:GetCfgData()

	for i = 1, #cfgData.Answer do
		local content = cfgData.Answer[i]
		local optionsData = AmusementParkAnswerOptionData.New(i, content)

		table.insert(tab, optionsData)
	end

	return tab
end

function m:RandomPosData()
	for i = #self.options, 2, -1 do
		local random_index = math.random(i)

		self.options[i], self.options[random_index] = self.options[random_index], self.options[i]
	end
end

return m
