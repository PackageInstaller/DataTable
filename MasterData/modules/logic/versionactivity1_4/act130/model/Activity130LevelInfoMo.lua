-- chunkname: @modules/logic/versionactivity1_4/act130/model/Activity130LevelInfoMo.lua

module("modules.logic.versionactivity1_4.act130.model.Activity130LevelInfoMo", package.seeall)

local Activity130LevelInfoMo = pureTable("Activity130LevelInfoMo")

function Activity130LevelInfoMo:ctor()
	self.episodeId = 0
	self.state = 0
	self.progress = 0
	self.act130Elements = {}
	self.tipsElementId = 0
	self.challengeNum = 0
end

function Activity130LevelInfoMo:init(info)
	self.episodeId = info.episodeId
	self.state = info.state
	self.progress = info.progress
	self.act130Elements = {}

	for _, v in ipairs(info.act130Elements) do
		local elementMo = Activity130ElementMo.New()

		elementMo:init(v)
		table.insert(self.act130Elements, elementMo)
	end

	self.tipsElementId = info.tipsElementId
	self.challengeNum = info.startGameTimes
end

function Activity130LevelInfoMo:updateInfo(info)
	self.state = info.state
	self.progress = info.progress
	self.act130Elements = {}

	for _, v in ipairs(info.act130Elements) do
		local elementMo = Activity130ElementMo.New()

		elementMo:init(v)
		table.insert(self.act130Elements, elementMo)
	end

	self.tipsElementId = info.tipsElementId
	self.challengeNum = info.startGameTimes
end

function Activity130LevelInfoMo:getFinishElementCount()
	local count = 0

	if not count then
		return count
	end

	for _, elementMo in ipairs(self.act130Elements) do
		if elementMo.isFinish then
			count = count + 1
		end
	end

	return count
end

function Activity130LevelInfoMo:updateChallengeNum(challengeNum)
	self.challengeNum = challengeNum
end

return Activity130LevelInfoMo
