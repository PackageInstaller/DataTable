-- chunkname: @modules/logic/dungeon/controller/DungeonPuzzleCircuitController.lua

module("modules.logic.dungeon.controller.DungeonPuzzleCircuitController", package.seeall)

local DungeonPuzzleCircuitController = class("DungeonPuzzleCircuitController", BaseController)

function DungeonPuzzleCircuitController:onInitFinish()
	return
end

function DungeonPuzzleCircuitController:addConstEvents()
	return
end

function DungeonPuzzleCircuitController:reInit()
	return
end

function DungeonPuzzleCircuitController:openGame(elementCo)
	DungeonPuzzleCircuitModel.instance:initByElementCo(elementCo)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleCircuitView)
end

DungeonPuzzleCircuitController.instance = DungeonPuzzleCircuitController.New()

return DungeonPuzzleCircuitController
