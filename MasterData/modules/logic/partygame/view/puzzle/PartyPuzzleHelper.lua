-- chunkname: @modules/logic/partygame/view/puzzle/PartyPuzzleHelper.lua

module("modules.logic.partygame.view.puzzle.PartyPuzzleHelper", package.seeall)

local PartyPuzzleHelper = class("PartyPuzzleHelper")

function PartyPuzzleHelper.getPieceIcon(pictureId, pieceId)
	local resPath
	local config = lua_partygame_puzzle_pictures.configDict[pictureId]

	if pieceId then
		local name = string.format("%s_%s", config.resource, pieceId + 1)

		resPath = ResUrl.getV3a4PartySingleBg(name)
	else
		resPath = ResUrl.getV3a4PartySingleBg(config.resource)
	end

	return resPath
end

return PartyPuzzleHelper
