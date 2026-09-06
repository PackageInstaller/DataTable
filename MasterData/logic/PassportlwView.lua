-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportlwView.lua

module("logic.extensions.passport.view.PassportlwView", package.seeall)

local PassportlwView = class("PassportlwView", PassportshowView)

function PassportlwView:buildUI()
	PassportlwView.super.buildUI(self)

	self._changeGroup = nil
	self._imgBG = nil
	self._txtDiamondNum = nil
end

function PassportlwView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PassportlwCellItem)

	if self._scrollRect and self._curData and data then
		component:setData(self, self._scrollRect, self._curData, data)
	end
end

function PassportlwView:_getPassportbuyViewExtraParam()
	local param = {}

	param.descAll = "购买后且战令满级可获得"

	return param
end

return PassportlwView
