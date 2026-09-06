-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/model/LinkGameCellMo.lua

module("logic.extensions.linkgame.model.LinkGameCellMo", package.seeall)

local LinkGameCellMo = class("LinkGameCellMo")

function LinkGameCellMo:ctor()
	self.index = 0
	self.row = 0
	self.col = 0
	self.stateIdx = 0
end

function LinkGameCellMo:setInfo(index, row, col, stateIdx)
	self.index = checknumber(index)
	self.row = checknumber(row)
	self.col = checknumber(col)
	self.stateIdx = checknumber(stateIdx)
end

return LinkGameCellMo
