-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROAnswerGame\\ROAnswerQuestionData.lua

local m = {
	playerSelectID = 0,
	options = {}
}
local ROAnswerOptionData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROAnswerGame.ROAnswerOptionData")

function m.New(cid, question)
	local o = Clone(m)

	o:Init(cid, question)

	return o
end

function m:Init(cid, question)
	self.cid = cid
	self.questionPOD = question
	self.playerSelectID = 0
	self.options = self:CreateOptions()

	self:RandomPosData()
end

function m:GetCfgData()
	return CfgRestaurantOperationQuestionBankTable[self.cid]
end

function m:CreateOptions()
	local tab = {}
	local cfgData = self:GetCfgData()

	for i = 1, #cfgData.Answer do
		local content = cfgData.Answer[i]
		local optionsData = ROAnswerOptionData.New(i, content)

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
