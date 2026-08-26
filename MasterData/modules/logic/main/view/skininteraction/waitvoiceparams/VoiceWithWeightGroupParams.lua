-- chunkname: @modules/logic/main/view/skininteraction/waitvoiceparams/VoiceWithWeightGroupParams.lua

module("modules.logic.main.view.skininteraction.waitvoiceparams.VoiceWithWeightGroupParams", package.seeall)

local VoiceWithWeightGroupParams = class("VoiceWithWeightGroupParams", BaseWaitVoiceParams)

function VoiceWithWeightGroupParams:init(list)
	self._successVoice = {}

	for i, v in ipairs(list) do
		if i ~= 1 then
			local t = string.splitToNumber(v, "#")

			table.insert(self._successVoice, t)
		end
	end

	if not self._successVoice or #self._successVoice == 0 then
		logError("VoiceWithWeightGroupParams:successVoice is empty")
	end
end

function VoiceWithWeightGroupParams:getSuccessVoiceId()
	local weight = 0

	for i, v in ipairs(self._successVoice) do
		weight = weight + v[1]
	end

	local rand = math.random(1, weight)

	for i, v in ipairs(self._successVoice) do
		if rand <= v[1] then
			return v[2]
		else
			rand = rand - v[1]
		end
	end

	return self._successVoice[1][2]
end

return VoiceWithWeightGroupParams
