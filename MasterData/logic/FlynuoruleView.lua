-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuoruleView.lua

module("logic.extensions.flyingnuo.view.FlynuoruleView", package.seeall)

local FlynuoruleView = class("FlynuoruleView", ViewComponent)

function FlynuoruleView:ctor()
	FlynuoruleView.super.ctor(self)
end

function FlynuoruleView:buildUI()
	FlynuoruleView.super.buildUI(self)

	self._okBtn = self:getBtn("okBtn")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._imgChange1 = self:getGo("card/cell1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgChange2 = self:getGo("card/cell2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgChange3 = self:getGo("card/cell3"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtRule1 = goutil.findChildTextComponent(self.mainGO, "card/cell1/txtRule")
	self._txtRule2 = goutil.findChildTextComponent(self.mainGO, "card/cell2/txtRule")
	self._txtRule3 = goutil.findChildTextComponent(self.mainGO, "card/cell3/txtRule")
	self._txtTipGo = self:getGo("txtTip")

	goutil.setActive(self._okBtn.gameObject, false)
end

function FlynuoruleView:bindEvents()
	FlynuoruleView.super.bindEvents(self)
	self._okBtn:AddClickListener(self.close, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
end

function FlynuoruleView:unbindEvents()
	FlynuoruleView.super.unbindEvents(self)
	self._okBtn:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function FlynuoruleView:destroyUI()
	FlynuoruleView.super.destroyUI(self)
end

function FlynuoruleView:onEnter()
	FlynuoruleView.super.onEnter(self)
	self:_updateView()
end

function FlynuoruleView:onEnterFinished()
	FlynuoruleView.super.onEnterFinished(self)
end

function FlynuoruleView:onExit()
	FlynuoruleView.super.onExit(self)
end

function FlynuoruleView:onExitFinished()
	FlynuoruleView.super.onExitFinished(self)
end

function FlynuoruleView:_onClickLeft()
	self:show(true)
end

function FlynuoruleView:_onClickRight()
	self:show(false)
end

function FlynuoruleView:show(isLeft)
	goutil.setActive(self._btnLeft.gameObject, not isLeft)
	goutil.setActive(self._btnRight.gameObject, isLeft)
	goutil.setActive(self._okBtn.gameObject, not isLeft)
	goutil.setActive(self._txtTipGo, isLeft)
	self._imgChange1:SetState(isLeft and 0 or 1)
	self._imgChange2:SetState(isLeft and 0 or 1)
	self._imgChange3:SetState(isLeft and 0 or 1)

	self._txtRule1.text = FlyNuoConfig.instance:getRuleDesc(isLeft and 1 or 4)
	self._txtRule2.text = FlyNuoConfig.instance:getRuleDesc(isLeft and 2 or 5)
	self._txtRule3.text = FlyNuoConfig.instance:getRuleDesc(isLeft and 3 or 6)
end

function FlynuoruleView:_updateView()
	self:_onClickLeft()
end

return FlynuoruleView
