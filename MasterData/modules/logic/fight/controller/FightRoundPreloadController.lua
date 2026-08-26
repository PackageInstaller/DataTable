-- chunkname: @modules/logic/fight/controller/FightRoundPreloadController.lua

module("modules.logic.fight.controller.FightRoundPreloadController", package.seeall)

local FightRoundPreloadController = class("FightRoundPreloadController", BaseController)

function FightRoundPreloadController:onInit()
	self._assetItemDict = self:getUserDataTb_()
	self._roundPreloadSequence = FlowSequence.New()

	self._roundPreloadSequence:addWork(FightRoundPreloadTimelineWork.New())
	self._roundPreloadSequence:addWork(FightPreloadTimelineRefWork.New())
	self._roundPreloadSequence:addWork(FightRoundPreloadEffectWork.New())

	self._monsterPreloadSequence = FlowSequence.New()

	self._monsterPreloadSequence:addWork(FightRoundPreloadMonsterWork.New())

	self._context = {
		callback = self._onPreloadOneFinish,
		callbackObj = self
	}
end

function FightRoundPreloadController:registStageEvent()
	FightController.instance:registerCallback(FightEvent.StageChanged, self.onStageChange, self)
end

function FightRoundPreloadController:reInit()
	self:dispose()
end

function FightRoundPreloadController:onStageChange(stage)
	if FightScene.isLowMemory then
		return
	end

	if stage == FightStageMgr.StageType.Operate then
		self:preload()
	elseif stage == FightStageMgr.StageType.Play then
		if self._monsterPreloadSequence and self._monsterPreloadSequence.status == WorkStatus.Running then
			self._monsterPreloadSequence:stop()
		end

		self._monsterPreloadSequence:start(self._context)
	end
end

function FightRoundPreloadController:preload()
	self._assetItemDict = self._assetItemDict or self:getUserDataTb_()

	if self._roundPreloadSequence and self._roundPreloadSequence.status == WorkStatus.Running then
		self._roundPreloadSequence:stop()
	end

	self._roundPreloadSequence:registerDoneListener(self._onPreloadDone, self)
	self._roundPreloadSequence:start(self._context)
end

function FightRoundPreloadController:dispose()
	FightController.instance:unregisterCallback(FightEvent.StageChanged, self.onStageChange, self)

	self._battleId = nil

	self._roundPreloadSequence:stop()
	self._monsterPreloadSequence:stop()

	if self._assetItemDict then
		for url, assetItem in pairs(self._assetItemDict) do
			assetItem:Release()

			self._assetItemDict[url] = nil
		end

		self._assetItemDict = nil
	end

	self._context.timelineDict = nil
	self._context.timelineUrlDict = nil
	self._context.timelineSkinDict = nil

	self._roundPreloadSequence:unregisterDoneListener(self._onPreloadDone, self)
	self:__onDispose()
end

function FightRoundPreloadController:_onPreloadDone()
	return
end

function FightRoundPreloadController:_onPreloadOneFinish(assetItem)
	local url = assetItem.ResPath

	if not self._assetItemDict[url] then
		self._assetItemDict[url] = assetItem

		assetItem:Retain()
	end
end

FightRoundPreloadController.instance = FightRoundPreloadController.New()

return FightRoundPreloadController
