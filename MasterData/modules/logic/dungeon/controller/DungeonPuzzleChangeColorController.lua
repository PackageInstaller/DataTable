-- chunkname: @modules/logic/dungeon/controller/DungeonPuzzleChangeColorController.lua

module("modules.logic.dungeon.controller.DungeonPuzzleChangeColorController", package.seeall)

local DungeonPuzzleChangeColorController = class("DungeonPuzzleChangeColorController", BaseController)

function DungeonPuzzleChangeColorController:onInit()
	return
end

function DungeonPuzzleChangeColorController:reInit()
	return
end

function DungeonPuzzleChangeColorController:enterDecryptChangeColor(id)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleChangeColorView, id)
end

function DungeonPuzzleChangeColorController:openDecryptTipView(id)
	ViewMgr.instance:openView(ViewName.DecryptPropTipView, id)
end

DungeonPuzzleChangeColorController.instance = DungeonPuzzleChangeColorController.New()

return DungeonPuzzleChangeColorController
