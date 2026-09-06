-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtTruefalseSuccessView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtTruefalseSuccessView", package.seeall)

local DivineXiuErClgExtTruefalseSuccessView = class("DivineXiuErClgExtTruefalseSuccessView", ViewComponent)

function DivineXiuErClgExtTruefalseSuccessView:buildUI()
	DivineXiuErClgExtTruefalseSuccessView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._tip = goutil.findChild(self.mainGO, "tip")
	self._txtDesc1 = goutil.findChildTextComponent(self.mainGO, "txtDesc1")
	self._txtDesc2 = goutil.findChildTextComponent(self.mainGO, "txtDesc2")
end

function DivineXiuErClgExtTruefalseSuccessView:bindEvents()
	DivineXiuErClgExtTruefalseSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function DivineXiuErClgExtTruefalseSuccessView:unbindEvents()
	DivineXiuErClgExtTruefalseSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineXiuErClgExtTruefalseSuccessView:onEnter()
	DivineXiuErClgExtTruefalseSuccessView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local info = {}

		self._desc1 = info.desc1
		self._desc2 = info.desc2
		self._closeCallBack = info.closeCallBack
		self._txtDesc1.text = self._desc1
		self._txtDesc2.text = self._desc2

		self:_doAnim()
	end
end

function DivineXiuErClgExtTruefalseSuccessView:onExit()
	DivineXiuErClgExtTruefalseSuccessView.super.onExit(self)
end

function DivineXiuErClgExtTruefalseSuccessView:_doAnim()
	goutil.setActive(self._btnClose.gameObject, false)
	goutil.setActive(self._tip, false)
	TweenUtil.DoDelay(1, function()
		goutil.setActive(self._btnClose.gameObject, true)
		goutil.setActive(self._tip, true)
	end)
end

function DivineXiuErClgExtTruefalseSuccessView:_onClickBtnClose()
	self:close()
	GameUtil.callBack(self._closeCallBack)
end

return DivineXiuErClgExtTruefalseSuccessView
