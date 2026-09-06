-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenMonsterRuleView.lua

module("logic.extensions.halloweenguest.view.HalloweenMonsterRuleView", package.seeall)

local HalloweenMonsterRuleView = class("HalloweenMonsterRuleView", ViewComponent)

function HalloweenMonsterRuleView:ctor()
	HalloweenMonsterRuleView.super.ctor(self)

	self._endTime = nil
end

function HalloweenMonsterRuleView:bindEvents()
	HalloweenMonsterRuleView.super.bindEvents(self)
	self._sureBtn:AddClickListener(function()
		if checknumber(self._endTime) > 0 then
			return
		end

		self:close()
	end, self)
end

function HalloweenMonsterRuleView:unbindEvents()
	HalloweenMonsterRuleView.super.unbindEvents(self)
	self._sureBtn:RemoveClickListener()
end

function HalloweenMonsterRuleView:onExit()
	HalloweenMonsterRuleView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
end

function HalloweenMonsterRuleView:destroyUI()
	HalloweenMonsterRuleView.super.destroyUI(self)

	self._endTime = nil
end

function HalloweenMonsterRuleView:buildUI()
	HalloweenMonsterRuleView.super.buildUI(self)

	self._sureBtn = self:getBtn("sureBtn")
	self._sureTxt = goutil.findChildTextComponent(self.mainGO, "sureBtn/sureTxt")
end

function HalloweenMonsterRuleView:onEnter()
	HalloweenMonsterRuleView.super.onEnter(self)

	self._endTime = 5
	self._sureTxt.text = langPara("text_halloween_desc_7", self._endTime)

	uGuiUtil.setImageGrayState(self._sureBtn.gameObject, true)
	uGuiUtil.setTextGrayState(self._sureTxt.gameObject, true)
	settimer(1, self._calculationSurplusTime, self, true)
end

function HalloweenMonsterRuleView:_calculationSurplusTime()
	self._endTime = self._endTime - 1

	if self._endTime <= 0 then
		removetimer(self._calculationSurplusTime, self)
		uGuiUtil.setImageGrayState(self._sureBtn.gameObject, false)
		uGuiUtil.setTextGrayState(self._sureTxt.gameObject, false)

		self._sureTxt.text = lang("text_tong_know")

		return
	end

	self._sureTxt.text = langPara("text_halloween_desc_7", self._endTime)
end

return HalloweenMonsterRuleView
