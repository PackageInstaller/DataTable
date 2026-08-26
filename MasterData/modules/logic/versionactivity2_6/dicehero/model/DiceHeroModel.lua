-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/DiceHeroModel.lua

module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroModel", package.seeall)

local DiceHeroModel = class("DiceHeroModel", BaseModel)

function DiceHeroModel:onInit()
	self.unlockChapterIds = {}
	self.gameInfos = {}
	self.guideChapter = 0
	self.guideLevel = 0
	self.isUnlockNewChapter = false
	self.talkId = 0
	self.stepId = 0
end

function DiceHeroModel:reInit()
	self:onInit()
end

function DiceHeroModel:initInfo(msg)
	self.gameInfos = {}

	local leftUnlockChapters = self.unlockChapterIds

	self.unlockChapterIds = {
		[1] = true
	}

	for _, info in ipairs(msg.gameInfo) do
		self.gameInfos[info.chapter] = DiceHeroGameInfoMo.New()

		self.gameInfos[info.chapter]:init(info)

		if self.gameInfos[info.chapter].allPass then
			self.unlockChapterIds[info.chapter + 1] = true
		end
	end

	self.isUnlockNewChapter = #leftUnlockChapters ~= #self.unlockChapterIds

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.InfoUpdate)
end

function DiceHeroModel:getGameInfo(chapter)
	return self.gameInfos[chapter or 1]
end

function DiceHeroModel:hasReward(chapter)
	chapter = chapter or 1

	if not self.gameInfos[chapter] then
		return false
	end

	return self.gameInfos[chapter]:hasReward()
end

DiceHeroModel.instance = DiceHeroModel.New()

return DiceHeroModel
