-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdimaxpassView.lua

module("logic.extensions.nvdi.view.NvdimaxpassView", package.seeall)

local NvdimaxpassView = class("NvdimaxpassView", ViewComponent)

function NvdimaxpassView:ctor()
	NvdimaxpassView.super.ctor(self)
end

function NvdimaxpassView:unbindEvents()
	NvdimaxpassView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NvdimaxpassView:bindEvents()
	NvdimaxpassView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NvdimaxpassView:buildUI()
	NvdimaxpassView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
end

function NvdimaxpassView:onExit()
	NvdimaxpassView.super.onExit(self)
end

function NvdimaxpassView:onEnter()
	NvdimaxpassView.super.onEnter(self)
end

return NvdimaxpassView
