-- chunkname: @modules/logic/dungeon/model/DungeonPuzzleChangeColorModel.lua

module("modules.logic.dungeon.model.DungeonPuzzleChangeColorModel", package.seeall)

local DungeonPuzzleChangeColorModel = class("DungeonPuzzleChangeColorModel", BaseModel)

function DungeonPuzzleChangeColorModel:onInit()
	return
end

function DungeonPuzzleChangeColorModel:reInit()
	return
end

DungeonPuzzleChangeColorModel.instance = DungeonPuzzleChangeColorModel.New()

return DungeonPuzzleChangeColorModel
