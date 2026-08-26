-- chunkname: @modules/logic/guide/controller/GuideTriggerController.lua

module("modules.logic.guide.controller.GuideTriggerController", package.seeall)

local GuideTriggerController = class("GuideTriggerController", BaseController)

function GuideTriggerController:onInitFinish()
	self.triggers = {}

	self:_addTrigger(GuideTriggerPlayerLv.New("PlayerLv"))
	self:_addTrigger(GuideTriggerEpisodeFinish.New("EpisodeFinish"))
	self:_addTrigger(GuideTriggerWeekWalkLayerOpen.New("WeekWalkLayerOpen"))
	self:_addTrigger(GuideTriggerUnlockChapter.New("UnlockChapter"))
	self:_addTrigger(GuideTriggerFinishTask.New("FinishTask"))
	self:_addTrigger(GuideTriggerOpenView.New("OpenView"))
	self:_addTrigger(GuideTriggerOpenViewCondition.New("OpenViewCondition"))
	self:_addTrigger(GuideTriggerEnterScene.New("EnterScene"))
	self:_addTrigger(GuideTriggerEnterExplore.New("EnterExplore"))
	self:_addTrigger(GuideTriggerEnterEpisode.New("EnterEpisode"))
	self:_addTrigger(GuideTriggerRoomConfirmBuilding.New("RoomConfirmBuilding"))
	self:_addTrigger(GuideTriggerRoomOpenBuildingStrengthView.New("RoomOpenBuildingStrengthView"))
	self:_addTrigger(GuideTriggerRoomReset.New("RoomReset"))
	self:_addTrigger(GuideTriggerRoomEnterEdit.New("RoomEnterEdit"))
	self:_addTrigger(GuideTriggerFinishGuide.New("FinishGuide"))
	self:_addTrigger(GuideTriggerEpisodeFinishAndTalent.New("EpisodeFinishAndTalent"))
	self:_addTrigger(GuideTriggerEpisodeFinishWithOpen.New("EpisodeFinishWithOpen"))
	self:_addTrigger(GuideTriggerEpisodeFinishAndInMainScene.New("EpisodeFinishAndInMainScene"))
	self:_addTrigger(GuideTriggerRoomCheckGatherFactoryNum.New("RoomCheckGatherFactoryNum"))
	self:_addTrigger(GuideTriggerEpisodeAndGuideFinish.New("EpisodeAndGuideFinish"))
	self:_addTrigger(GuideTriggerEnterActivity109Chess.New("EnterActivity109Chess"))
	self:_addTrigger(GuideTriggerCachotEnterRoom.New("CachotEnterRoom"))
	self:_addTrigger(GuideTriggerMainSceneSkin.New("MainSceneSkin"))
	self:_addTrigger(GuideTriggerTalentStyle.New("TalentStyle"))
	self:_addTrigger(GuideTriggerChessGameGuideStart.New("ChessGameGuideStart"))
	self:_addTrigger(GuideTriggerElementFinish.New("ElementFinish"))
	self:_addTrigger(GuideTriggerRoomLv.New("RoomLv"))
	self:_addTrigger(GuideTriggerRoomTradeLv.New("RoomTradeLv"))
	self:_addTrigger(GuideTriggerDestinyStone.New("DestinyStone"))
	self:_addTrigger(GuideTriggerStoryStep.New("StoryStep"))
	self:_addTrigger(GuideTriggerGuideEvent.New("GuideEvent"))
	self:_addTrigger(GuideTriggerOdysseyEpisodeFinish.New("OdysseyEpisodeFinish"))
	self:_addTrigger(GuideTriggerTowerDeepSuccReward.New("TowerDeepSuccReward"))
end

function GuideTriggerController:_addTrigger(trigger)
	table.insert(self.triggers, trigger)
end

function GuideTriggerController:addConstEvents()
	GuideController.instance:registerCallback(GuideEvent.TriggerGuide, self._onTriggerGuide, self)
end

function GuideTriggerController:onReset()
	for i = 1, #self.triggers do
		self.triggers[i]:onReset()
	end
end

function GuideTriggerController:startTrigger()
	for i = 1, #self.triggers do
		self.triggers[i]:setCanTrigger(true)
		self.triggers[i]:checkStartGuide(nil, nil)
	end
end

function GuideTriggerController:_onTriggerGuide(toTriggerGuideId)
	for i = 1, #self.triggers do
		self.triggers[i]:checkStartGuide(nil, toTriggerGuideId)
	end
end

function GuideTriggerController:hasSatisfyGuide()
	for i = 1, #self.triggers do
		if self.triggers[i]:hasSatisfyGuide() then
			return true
		end
	end

	return false
end

GuideTriggerController.instance = GuideTriggerController.New()

return GuideTriggerController
