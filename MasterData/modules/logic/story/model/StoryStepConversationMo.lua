-- chunkname: @modules/logic/story/model/StoryStepConversationMo.lua

module("modules.logic.story.model.StoryStepConversationMo", package.seeall)

local StoryStepConversationMo = pureTable("StoryStepConversationMo")

function StoryStepConversationMo:ctor()
	self.type = 0
	self.delayTimes = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
	self.isAuto = false
	self.effType = 0
	self.effLv = 0
	self.effDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.effTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.effRate = 1
	self.showList = {}
	self.nameShow = false
	self.nameEnShow = false
	self.heroNames = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.iconShow = false
	self.heroIcon = ""
	self.audios = {}
	self.audioDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.disableAudio = {
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false
	}
	self.diaTexts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.showTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.keepTimes = {
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5
	}
end

function StoryStepConversationMo:init(info)
	self.type = info[1]
	self.delayTimes = info[2]
	self.isAuto = info[3]
	self.effType = info[4]
	self.effLv = info[5]
	self.effDelayTimes = info[6]
	self.effTimes = info[7]
	self.effRate = info[8]
	self.showList = info[9]
	self.nameShow = info[10]
	self.nameEnShow = info[11]
	self.heroNames = info[12]
	self.iconShow = info[13]
	self.heroIcon = info[14]

	local audioParams = string.split(info[15], "#")

	self.audios = audioParams[1] == "" and {
		0
	} or string.splitToNumber(audioParams[1], "&")

	if audioParams[2] then
		local audios = string.split(audioParams[2], "|")

		for i = 1, 8 do
			if audios[i] then
				local extraParams = string.split(audios[i], "-")

				self.audioDelayTimes[i] = tonumber(extraParams[1])
				self.disableAudio[i] = extraParams[2] and extraParams[2] == "0" or false
			end
		end
	end

	self.diaTexts = info[16]
	self.showTimes = info[17]
	self.keepTimes = info[18]
end

return StoryStepConversationMo
