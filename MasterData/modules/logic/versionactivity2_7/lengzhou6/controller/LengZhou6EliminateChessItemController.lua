-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/LengZhou6EliminateChessItemController.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6EliminateChessItemController", package.seeall)

local LengZhou6EliminateChessItemController = class("LengZhou6EliminateChessItemController", EliminateChessItemController)

function LengZhou6EliminateChessItemController:InitChess()
	local chessList = LocalEliminateChessModel.instance:getAllCell()

	if chessList == nil then
		return
	end

	for i = 1, #chessList do
		if self._chess[i] == nil then
			self._chess[i] = {}
		end

		local row = chessList[i]

		for j = 1, #row do
			local chessMo = row[j]
			local chessItem = self:createChess(i, j)

			chessItem:initData(chessMo)

			self._chess[i][j] = chessItem
		end
	end
end

function LengZhou6EliminateChessItemController:createChess(x, y)
	local cloneGo = self:getChessItemGo(string.format("chess_%d_%d", x, y), x, y)
	local resItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EliminateChessItem2_7, self)

	resItem:init(cloneGo)

	return resItem
end

function LengZhou6EliminateChessItemController:tempClearAllChess()
	for _, row in pairs(self._chess) do
		for _, item in pairs(row) do
			if item ~= nil then
				item:onDestroy()
			end
		end
	end

	tabletool.clear(self._chess)
end

LengZhou6EliminateChessItemController.instance = LengZhou6EliminateChessItemController.New()

return LengZhou6EliminateChessItemController
