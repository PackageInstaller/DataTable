-- chunkname: @modules/logic/explore/model/mo/ExploreChapterSimpleMo.lua

module("modules.logic.explore.model.mo.ExploreChapterSimpleMo", package.seeall)

local ExploreChapterSimpleMo = pureTable("ExploreChapterSimpleMo")

function ExploreChapterSimpleMo:ctor()
	self.archiveIds = {}
	self.bonusScene = {}
	self.isFinish = false
end

function ExploreChapterSimpleMo:init(msg)
	for i, v in ipairs(msg.archiveIds) do
		self.archiveIds[v] = true
	end

	for i, v in ipairs(msg.bonusScene) do
		self.bonusScene[v.bonusSceneId] = v.options
	end

	self.isFinish = msg.isFinish
end

function ExploreChapterSimpleMo:onGetArchive(id)
	self.archiveIds[id] = true
end

function ExploreChapterSimpleMo:onGetBonus(id, options)
	self.bonusScene[id] = options
end

function ExploreChapterSimpleMo:haveBonusScene()
	return not not next(self.bonusScene)
end

return ExploreChapterSimpleMo
