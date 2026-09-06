-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardShowAllView.lua

module("logic.extensions.yearcard.view.2022.YearCardShowAllView", package.seeall)

local YearCardShowAllView = class("YearCardShowAllView", ViewComponent)

function YearCardShowAllView:ctor()
	YearCardShowAllView.super.ctor(self)
end

function YearCardShowAllView:unbindEvents()
	YearCardShowAllView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function YearCardShowAllView:bindEvents()
	YearCardShowAllView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function YearCardShowAllView:onExit()
	YearCardShowAllView.super.onExit(self)
end

function YearCardShowAllView:buildUI()
	YearCardShowAllView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

return YearCardShowAllView
