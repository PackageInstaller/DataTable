-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportlwCellItem.lua

module("logic.extensions.passport.view.PassportlwCellItem", package.seeall)

local PassportlwCellItem = class("PassportlwCellItem", PassportCellItem)

function PassportlwCellItem:buildUI()
	PassportlwCellItem.super.buildUI(self)

	self._cellGroup = nil
end

return PassportlwCellItem
