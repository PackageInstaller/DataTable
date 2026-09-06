-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardNewAdd2022View.lua

module("logic.extensions.yearcard.view.2022.YearCardNewAdd2022View", package.seeall)

local YearCardNewAdd2022View = class("YearCardNewAdd2022View", ViewComponent)

function YearCardNewAdd2022View:buildUI()
	YearCardNewAdd2022View.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function YearCardNewAdd2022View:bindEvents()
	YearCardNewAdd2022View.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function YearCardNewAdd2022View:unbindEvents()
	YearCardNewAdd2022View.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

return YearCardNewAdd2022View
