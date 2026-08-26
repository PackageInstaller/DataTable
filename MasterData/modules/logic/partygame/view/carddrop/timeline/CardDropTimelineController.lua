-- chunkname: @modules/logic/partygame/view/carddrop/timeline/CardDropTimelineController.lua

module("modules.logic.partygame.view.carddrop.timeline.CardDropTimelineController", package.seeall)

local CardDropTimelineController = class("CardDropTimelineController")

function CardDropTimelineController:onGameStart()
	if self.inited then
		return
	end

	self.inited = true
	self.timelineId = 0
	self.playingTimelineDict = {}
	self.timelineItemPool = {}

	local curScene = GameSceneMgr.instance:getCurScene()

	self.goSceneRoot = curScene:getSceneContainerGO()
	self.goTimeLineRoot = gohelper.create3d(self.goSceneRoot, "party_game_timeline_root")
	self.goEffectRoot = gohelper.create3d(self.goSceneRoot, "effectRoot")
end

function CardDropTimelineController:getEffectRoot()
	return self.effectRoot
end

function CardDropTimelineController:playTimeline(uid, timelineUrl, callback, callbackObj)
	local timelineItem = table.remove(self.timelineItemPool)

	if not timelineItem then
		self.timelineId = self.timelineId + 1
		timelineItem = CardDropTimelineItem.New()

		timelineItem:init(self.timelineId, self.goTimeLineRoot)
		timelineItem:registerOnTimeLineEnd(self.onTimelineEnd, self)
	end

	timelineItem:play(uid, timelineUrl, callback, callbackObj)

	self.playingTimelineDict[timelineItem:getTimelineId()] = timelineItem

	return timelineItem
end

function CardDropTimelineController:stopTimeline(timelineItem)
	if timelineItem then
		timelineItem:stop()
	end
end

function CardDropTimelineController:stopAllTimeline()
	if self.playingTimelineDict then
		for _, timelineItem in pairs(self.playingTimelineDict) do
			timelineItem:stop()
		end

		tabletool.clear(self.playingTimelineDict)
	end
end

function CardDropTimelineController:onTimelineEnd(timelineItem)
	self:recycleTimeline(timelineItem)
end

function CardDropTimelineController:recycleTimeline(timelineItem)
	local timelineId = timelineItem:getTimelineId()

	self.playingTimelineDict[timelineId] = nil

	table.insert(self.timelineItemPool, timelineItem)
end

function CardDropTimelineController:onGameEnd()
	if self.playingTimelineDict then
		for _, timelineItem in pairs(self.playingTimelineDict) do
			timelineItem:destroy()
		end

		tabletool.clear(self.playingTimelineDict)

		self.playingTimelineDict = nil
	end

	if self.timelineItemPool then
		for _, timelineItem in ipairs(self.timelineItemPool) do
			timelineItem:destroy()
		end

		tabletool.clear(self.timelineItemPool)

		self.timelineItemPool = nil
	end

	gohelper.destroy(self.goTimeLineRoot)
	gohelper.destroy(self.goEffectRoot)

	self.goTimeLineRoot = nil
	self.goEffectRoot = nil

	PartyGame.Runtime.Timeline.PartyGameSkillTimelineAssetHelper.ClearAssetJson()

	self.inited = false
end

CardDropTimelineController.instance = CardDropTimelineController.New()

return CardDropTimelineController
