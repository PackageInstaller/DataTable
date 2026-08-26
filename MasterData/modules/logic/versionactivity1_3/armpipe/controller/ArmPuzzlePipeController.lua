-- chunkname: @modules/logic/versionactivity1_3/armpipe/controller/ArmPuzzlePipeController.lua

module("modules.logic.versionactivity1_3.armpipe.controller.ArmPuzzlePipeController", package.seeall)

local ArmPuzzlePipeController = class("ArmPuzzlePipeController", BaseController)

function ArmPuzzlePipeController:onInit()
	return
end

function ArmPuzzlePipeController:onInitFinish()
	return
end

function ArmPuzzlePipeController:addConstEvents()
	return
end

function ArmPuzzlePipeController:reInit()
	return
end

function ArmPuzzlePipeController:openMainView()
	Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305, self._onOpenMainViewCB, self)
end

function ArmPuzzlePipeController:_onOpenMainViewCB(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.ArmMainView)
	end
end

local LEFT = ArmPuzzlePipeEnum.dir.left
local RIGHT = ArmPuzzlePipeEnum.dir.right
local DOWN = ArmPuzzlePipeEnum.dir.down
local UP = ArmPuzzlePipeEnum.dir.up

function ArmPuzzlePipeController:release()
	self._rule = nil
end

function ArmPuzzlePipeController:checkInit()
	self._rule = self._rule or ArmPuzzlePipeRule.New()

	local w, h = ArmPuzzlePipeModel.instance:getGameSize()

	self._rule:setGameSize(w, h)
end

function ArmPuzzlePipeController:openGame(episodeCo)
	self._waitEpisodeCo = episodeCo

	if not Activity124Model.instance:getEpisodeData(episodeCo.activityId, episodeCo.episodeId) then
		Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305, self._onOpenGame, self)
	else
		self:_onOpenGame()
	end
end

function ArmPuzzlePipeController:_onOpenGame()
	local episodeCo = self._waitEpisodeCo

	self._waitEpisodeCo = nil

	if episodeCo and Activity124Model.instance:getEpisodeData(episodeCo.activityId, episodeCo.episodeId) then
		ArmPuzzlePipeModel.instance:initByEpisodeCo(episodeCo)
		self:checkInit()
		self:refreshAllConnection()
		self:updateConnection()
		ViewMgr.instance:openView(ViewName.ArmPuzzlePipeView)

		local episodeId = episodeCo.episodeId

		self:dispatchEvent(ArmPuzzlePipeEvent.GuideOpenGameView, episodeId)
	end
end

function ArmPuzzlePipeController:resetGame()
	local episodeCo = ArmPuzzlePipeModel.instance:getEpisodeCo()

	ArmPuzzlePipeModel.instance:initByEpisodeCo(episodeCo)
	self:refreshAllConnection()
	self:updateConnection()
	self:dispatchEvent(ArmPuzzlePipeEvent.ResetGameRefresh)
end

function ArmPuzzlePipeController:changeDirection(x, y, needRefresh)
	local mo = self._rule:changeDirection(x, y)

	if needRefresh then
		self:refreshConnection(mo)
	end
end

function ArmPuzzlePipeController:randomPuzzle()
	local skipSet = self._rule:getRandomSkipSet()
	local w, h = ArmPuzzlePipeModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = ArmPuzzlePipeModel.instance:getData(x, y)

			if not skipSet[mo] then
				local rndTimes = math.random(0, 3)

				for i = 1, rndTimes do
					self._rule:changeDirection(x, y)
				end
			end
		end
	end

	self:refreshAllConnection()
	self:updateConnection()
end

function ArmPuzzlePipeController:refreshAllConnection()
	local w, h = ArmPuzzlePipeModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = ArmPuzzlePipeModel.instance:getData(x, y)

			self:refreshConnection(mo)
		end
	end
end

function ArmPuzzlePipeController:refreshConnection(mo)
	local x, y = mo.x, mo.y

	self._rule:setSingleConnection(x - 1, y, RIGHT, LEFT, mo)
	self._rule:setSingleConnection(x + 1, y, LEFT, RIGHT, mo)
	self._rule:setSingleConnection(x, y + 1, DOWN, UP, mo)
	self._rule:setSingleConnection(x, y - 1, UP, DOWN, mo)
end

function ArmPuzzlePipeController:updateConnection()
	ArmPuzzlePipeModel.instance:resetEntryConnect()

	local entryTable, resultTable = self._rule:getReachTable()

	self._rule:_mergeReachDir(entryTable)
	self._rule:_unmarkBranch()

	local result = self._rule:isGameClear(resultTable)

	ArmPuzzlePipeModel.instance:setGameClear(result)
end

function ArmPuzzlePipeController:checkDispatchClear()
	if ArmPuzzlePipeModel.instance:getGameClear() then
		self:dispatchEvent(ArmPuzzlePipeEvent.PipeGameClear)
	end
end

function ArmPuzzlePipeController:getIsEntryClear(entryMo)
	return self._rule:getIsEntryClear(entryMo)
end

ArmPuzzlePipeController.instance = ArmPuzzlePipeController.New()

return ArmPuzzlePipeController
