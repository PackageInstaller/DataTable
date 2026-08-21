-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleWorkStartBattle.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleWorkStartBattle", package.seeall)

local M = class("DungeonBattleWorkStartBattle", WorkBase)

function M:onEnter(context)
	self.context = context

	local dungeonCode = context.model:getDungeonCode()
	local multiCount = context.model:getMultiCount()
	local gamePlay = context.model:getGamePlay()

	BattleDispatcher:addEventListener(BattleEventType.OnBattleExitFinish, self._onBattleFinish, self)
	BattleDispatcher:addEventListener(BattleEventType.OnDungeonBattleStart, self._onBattleStart, self)
	DungeonAgent.instance:sendStartDungeonRequest(dungeonCode, multiCount, false, gamePlay)
	LoadingFacade.instance:showLoading()
end

function M:onExit(isInterrupt)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleExitFinish, self._onBattleFinish, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnDungeonBattleStart, self._onBattleStart, self)
end

function M:_onBattleStart(e, status)
	if status ~= 0 then
		if BattleMgr.instance:isInBattle() then
			BattleMgr.instance:forceExit()
		end

		self.context.model:setBattleIsWin(false)
		self:onDone(WorkResult.Succeed)
	end
end

function M:_onBattleFinish(e, snapshotInfo)
	self.context.model:setBattleIsWin(snapshotInfo:isWin())

	if snapshotInfo:isWin() then
		DungeonModel.instance:deleteLocalStorageEnterDungeon(self.context.model:getDungeonCode())

		if self.context.model:getDungeonType() == CommEnum.DungeonType.Mainline then
			DungeonMainLineChapterModel.instance:updateWhenDungeonWin(self.context.model:getDungeonCode())
		elseif self.context.model:getDungeonType() == CommEnum.DungeonType.ControlAction then
			ControlActionModel.instance:updateWhenDungeonWin(self.context.model:getDungeonCode())
		end
	end

	BattleDispatcher:removeEventListener(BattleEventType.OnBattleExitFinish, self._onBattleFinish, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnDungeonBattleStart, self._onBattleStart, self)
	self:onDone(WorkResult.Succeed)
end

return M
