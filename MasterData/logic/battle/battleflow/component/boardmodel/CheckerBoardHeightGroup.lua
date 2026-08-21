-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/boardmodel/CheckerBoardHeightGroup.lua

module("logic.battle.battleflow.component.boardmodel.CheckerBoardHeightGroup", package.seeall)

local M = class("CheckerBoardHeightGroup")

function M:ctor(code)
	self._checkerbBoardCode = code
	self._unionIndexToHeight = {}
end

function M:addHeight(unionIndex, height)
	self._unionIndexToHeight[unionIndex] = height
end

function M:getHeight(unionIndex)
	return self._unionIndexToHeight[unionIndex]
end

return M
