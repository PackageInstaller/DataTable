-- chunkname: @modules/logic/dungeon/controller/DungeonPuzzlePipeController.lua

module("modules.logic.dungeon.controller.DungeonPuzzlePipeController", package.seeall)

local DungeonPuzzlePipeController = class("DungeonPuzzlePipeController", BaseController)

function DungeonPuzzlePipeController:onInitFinish()
	return
end

function DungeonPuzzlePipeController:addConstEvents()
	return
end

function DungeonPuzzlePipeController:reInit()
	return
end

local LEFT = DungeonPuzzleEnum.dir.left
local RIGHT = DungeonPuzzleEnum.dir.right
local DOWN = DungeonPuzzleEnum.dir.down
local UP = DungeonPuzzleEnum.dir.up

function DungeonPuzzlePipeController:release()
	self._rule = nil
end

function DungeonPuzzlePipeController:checkInit()
	self._rule = self._rule or DungeonPuzzlePipeRule.New()

	local w, h = DungeonPuzzlePipeModel.instance:getGameSize()

	self._rule:setGameSize(w, h)
end

function DungeonPuzzlePipeController:openGame(elementCo)
	DungeonPuzzlePipeModel.instance:initByElementCo(elementCo)
	self:checkInit()
	self:randomPuzzle()
	ViewMgr.instance:openView(ViewName.DungeonPuzzlePipeView)
end

function DungeonPuzzlePipeController:resetGame()
	local elementCo = DungeonPuzzlePipeModel.instance:getElementCo()

	DungeonPuzzlePipeModel.instance:initByElementCo(elementCo)
	self:randomPuzzle()
end

function DungeonPuzzlePipeController:changeDirection(x, y, needRefresh)
	local mo = self._rule:changeDirection(x, y)

	if needRefresh then
		self:refreshConnection(mo)
	end
end

function DungeonPuzzlePipeController:randomPuzzle()
	local skipSet = self._rule:getRandomSkipSet()
	local w, h = DungeonPuzzlePipeModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = DungeonPuzzlePipeModel.instance:getData(x, y)

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

function DungeonPuzzlePipeController:refreshAllConnection()
	local w, h = DungeonPuzzlePipeModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = DungeonPuzzlePipeModel.instance:getData(x, y)

			self:refreshConnection(mo)
		end
	end
end

function DungeonPuzzlePipeController:refreshConnection(mo)
	local x, y = mo.x, mo.y

	self._rule:setSingleConnection(x - 1, y, RIGHT, LEFT, mo)
	self._rule:setSingleConnection(x + 1, y, LEFT, RIGHT, mo)
	self._rule:setSingleConnection(x, y + 1, DOWN, UP, mo)
	self._rule:setSingleConnection(x, y - 1, UP, DOWN, mo)
end

function DungeonPuzzlePipeController:updateConnection()
	DungeonPuzzlePipeModel.instance:resetEntryConnect()

	local entryTable, resultTable = self._rule:getReachTable()

	self._rule:_mergeReachDir(entryTable)
	self._rule:_unmarkBranch()

	local result = self._rule:isGameClear(resultTable)

	DungeonPuzzlePipeModel.instance:setGameClear(result)
end

function DungeonPuzzlePipeController:checkDispatchClear()
	if DungeonPuzzlePipeModel.instance:getGameClear() then
		self:dispatchEvent(DungeonPuzzleEvent.PipeGameClear)
	end
end

function DungeonPuzzlePipeController:getIsEntryClear(entryMo)
	return self._rule:getIsEntryClear(entryMo)
end

DungeonPuzzlePipeController.instance = DungeonPuzzlePipeController.New()

return DungeonPuzzlePipeController
