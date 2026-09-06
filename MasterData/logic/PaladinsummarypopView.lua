-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/paladin/PaladinsummarypopView.lua

module("logic.extensions.operationsummary.view.paladin.PaladinsummarypopView", package.seeall)

local PaladinsummarypopView = class("PaladinsummarypopView", ViewComponent)

function PaladinsummarypopView:ctor()
	PaladinsummarypopView.super.ctor(self)
end

function PaladinsummarypopView:unbindEvents()
	PaladinsummarypopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PaladinsummarypopView:bindEvents()
	PaladinsummarypopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function PaladinsummarypopView:buildUI()
	PaladinsummarypopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function PaladinsummarypopView:onExit()
	PaladinsummarypopView.super.onExit(self)
end

function PaladinsummarypopView:onEnter()
	PaladinsummarypopView.super.onEnter(self)
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_PALADINSUMMARYFEATURE, true)
end

function PaladinsummarypopView:_onClickClose()
	self:close()
end

return PaladinsummarypopView
