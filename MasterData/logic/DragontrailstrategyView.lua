-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrailstrategyView.lua

module("logic.extensions.dragontrial.view.DragontrailstrategyView", package.seeall)

local DragontrailstrategyView = class("DragontrailstrategyView", ViewComponent)

function DragontrailstrategyView:buildUI()
	DragontrailstrategyView.super.buildUI(self)

	self._okBtn = self:getBtn("okBtn")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._rule1Go = self:getGo("rule1")
	self._rule2Go = self:getGo("rule2")
	self._txtTipGo = self:getGo("txtTip")
end

function DragontrailstrategyView:bindEvents()
	DragontrailstrategyView.super.bindEvents(self)
	self._okBtn:AddClickListener(self.close, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
end

function DragontrailstrategyView:unbindEvents()
	DragontrailstrategyView.super.unbindEvents(self)
	self._okBtn:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function DragontrailstrategyView:onEnter()
	DragontrailstrategyView.super.onEnter(self)
	self:_onClickLeft()
end

function DragontrailstrategyView:_onClickLeft()
	self:show(true)
end

function DragontrailstrategyView:_onClickRight()
	self:show(false)
end

function DragontrailstrategyView:show(isLeft)
	goutil.setActive(self._rule2Go, not isLeft)
	goutil.setActive(self._rule1Go, isLeft)
	goutil.setActive(self._btnLeft.gameObject, not isLeft)
	goutil.setActive(self._btnRight.gameObject, isLeft)
	goutil.setActive(self._okBtn.gameObject, not isLeft)
	goutil.setActive(self._txtTipGo, isLeft)
end

return DragontrailstrategyView
