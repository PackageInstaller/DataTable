-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleWorkShowPlotBeforeBattle.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleWorkShowPlotBeforeBattle", package.seeall)

local M = class("DungeonBattleWorkShowPlotBeforeBattle", WorkBase)

function M:onEnter(context)
	DungeonModel.instance:setLastEnterDungeonCode(context.model:getDungeonCode())

	self._plotCode = context.model:getPlotCodeBeforeBattle()
	self._unlockChapter = false
	self._context = context

	local isShowPlot = context.model:isShowPlot()

	self:_setEvent(true)

	if isShowPlot and self._plotCode and self._plotCode > 0 then
		LoadingFacade.instance:hideLoading()

		if PlayerCreateController.instance:isCreatePlayerPlot(self._plotCode) then
			StoryMgr.instance:startSingle(self._plotCode, false, self._onCreatePlayerPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
		else
			StoryMgr.instance:startSingle(self._plotCode, false, self._onPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
		end
	else
		self:_onPlotFinish()
	end
end

function M:onExit(isInterrupt)
	self:_setEvent(false)

	if self._delayedCall then
		self._delayedCall:Kill(false)

		self._delayedCall = nil
	end
end

function M:_setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.FIRST_UNLOCK_CHAPTER_BY_STORY, self._onUnlockStory, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FIRST_UNLOCK_CHAPTER_BY_STORY, self._onUnlockStory, self)
	end
end

function M:_onCreatePlayerPlotFinish()
	GlobalDispatcher:addEventListener(EventType.PLAYER_CREATED_UI_CLOSED, self._onCreatedPlayer, self)
	PlayerCreateController.instance:handleToCreatePlayer(self._plotCode)
end

function M:_onCreatedPlayer(_, plotId)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_CREATED_UI_CLOSED, self._onCreatedPlayer, self)
	StoryMgr.instance:startSingle(plotId, false, self._onPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
end

function M:_onPlotFinish()
	if self._context.model:getIsPlotDungeon() then
		DungeonDispatcher:addEventListener(DungeonEventType.OnPassPlotDungeonReply, self._handlePassedPlotDungeonRequest, self)
		DungeonAgent.instance:SendPassPlotDungeonRequest(self._context.model:getDungeonCode())

		if self._unlockChapter then
			ViewMgr.instance:openSpecialView(ViewName.StoryUnlockTipView, {
				index = 2,
				desc = false
			})

			self._unlockChapter = false
		end
	else
		LoadingFacade.instance:showLoading(false)
		self:onDone(WorkResult.Succeed)
	end
end

function M:_onUnlockStory()
	self._unlockChapter = true
end

function M:_handlePassedPlotDungeonRequest()
	DungeonDispatcher:removeEventListener(DungeonEventType.OnPassPlotDungeonReply, self._handlePassedPlotDungeonRequest, self)
	self:onDone(WorkResult.Succeed)
end

return M
