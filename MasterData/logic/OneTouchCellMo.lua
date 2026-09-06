-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/model/OneTouchCellMo.lua

module("logic.extensions.luoshiqiordeal.model.OneTouchCellMo", package.seeall)

local OneTouchCellMo = class("OneTouchCellMo")

function OneTouchCellMo:ctor()
	self.index = 0
	self.row = 0
	self.column = 0
	self.cellType = 0
end

return OneTouchCellMo
