-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgDamageView.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgDamageView", package.seeall)

local DivineWeiLeiTaClgDamageView = class("DivineWeiLeiTaClgDamageView", ViewComponent)

function DivineWeiLeiTaClgDamageView:ctor()
	DivineWeiLeiTaClgDamageView.super.ctor(self)
end

function DivineWeiLeiTaClgDamageView:unbindEvents()
	DivineWeiLeiTaClgDamageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineWeiLeiTaClgDamageView:bindEvents()
	DivineWeiLeiTaClgDamageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function DivineWeiLeiTaClgDamageView:buildUI()
	DivineWeiLeiTaClgDamageView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtDamage = self:getTxt("txtDamage")
	self._txtMax = self:getTxt("txtMax")
end

function DivineWeiLeiTaClgDamageView:onExit()
	DivineWeiLeiTaClgDamageView.super.onExit(self)
end

function DivineWeiLeiTaClgDamageView:onEnter()
	DivineWeiLeiTaClgDamageView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._txtDamage.text = DivineWeiLeiTaClgModel.instance:getCurDamage(self._activityId)
	self._txtMax.text = DivineWeiLeiTaClgModel.instance:getTodayMaxDamage(self._activityId)
end

function DivineWeiLeiTaClgDamageView:_onClickSure()
	self:close()
end

return DivineWeiLeiTaClgDamageView
