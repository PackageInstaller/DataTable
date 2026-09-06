-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkResourcePopView.lua

module("logic.extensions.elementspark.view.ElementSparkResourcePopView", package.seeall)

local ElementSparkResourcePopView = class("ElementSparkResourcePopView", ViewComponent)

function ElementSparkResourcePopView:ctor()
	ElementSparkResourcePopView.super.ctor(self)
end

function ElementSparkResourcePopView:unbindEvents()
	ElementSparkResourcePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose, self)
	GameUtil.rmClickHandler(self._btnSure, self)
end

function ElementSparkResourcePopView:bindEvents()
	ElementSparkResourcePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function ElementSparkResourcePopView:buildUI()
	ElementSparkResourcePopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtCampScore = self:getTxt("detail/txtCampScore")
	self._txtPersonScore = self:getTxt("detail/txtPersonScore")
	self._txtPetShop = self:getTxt("detail/txtPetShop")
end

function ElementSparkResourcePopView:onExit()
	ElementSparkResourcePopView.super.onExit(self)
end

function ElementSparkResourcePopView:onEnter()
	ElementSparkResourcePopView.super.onEnter(self)

	local data = self:getFirstParam()

	self._txtCampScore.text = "+" .. data.campScore
	self._txtPersonScore.text = "+" .. data.personScore
	self._txtPetShop.text = "+" .. data.petShopScore
end

return ElementSparkResourcePopView
