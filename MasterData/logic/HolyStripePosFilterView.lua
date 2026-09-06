-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripePosFilterView.lua

module("logic.extensions.holystripe.view.HolyStripePosFilterView", package.seeall)

local HolyStripePosFilterView = class("HolyStripePosFilterView", ViewComponent)

function HolyStripePosFilterView:buildUI()
	HolyStripePosFilterView.super.buildUI(self)

	self._btnAll = self:getBtn("posFitlerRoot/btnAll")
	self._btnPos_1 = self:getBtn("posFitlerRoot/btnPos_1")
	self._btnPos_2 = self:getBtn("posFitlerRoot/btnPos_2")
	self._btnPos_3 = self:getBtn("posFitlerRoot/btnPos_3")
	self._btnPos_4 = self:getBtn("posFitlerRoot/btnPos_4")
	self._btnPos_5 = self:getBtn("posFitlerRoot/btnPos_5")
	self._uiChangeAll = goutil.findChildComponent(self.mainGO, "posFitlerRoot/btnAll", "UIChangeGroup")
	self._uiChange_1 = goutil.findChildComponent(self.mainGO, "posFitlerRoot/btnPos_1", "UIChangeGroup")
	self._uiChange_2 = goutil.findChildComponent(self.mainGO, "posFitlerRoot/btnPos_2", "UIChangeGroup")
	self._uiChange_3 = goutil.findChildComponent(self.mainGO, "posFitlerRoot/btnPos_3", "UIChangeGroup")
	self._uiChange_4 = goutil.findChildComponent(self.mainGO, "posFitlerRoot/btnPos_4", "UIChangeGroup")
	self._uiChange_5 = goutil.findChildComponent(self.mainGO, "posFitlerRoot/btnPos_5", "UIChangeGroup")
	self._customInput = UICustomInput.Get(self:getGo("posFitlerRoot"))
	self._btnGroup = {
		self._btnPos_1,
		self._btnPos_2,
		self._btnPos_3,
		self._btnPos_4,
		self._btnPos_5
	}
	self._uiChangeGroup = {
		self._uiChange_1,
		self._uiChange_2,
		self._uiChange_3,
		self._uiChange_4,
		self._uiChange_5
	}
end

function HolyStripePosFilterView:bindEvents()
	HolyStripePosFilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)

	for i, v in ipairs(self._btnGroup) do
		v:AddClickListener(function()
			self:_onClickPosBtn(i)
		end)
	end

	self._btnAll:AddClickListener(function()
		self:_onClickPosBtn(nil)
	end)
end

function HolyStripePosFilterView:unbindEvents()
	HolyStripePosFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()

	for i, v in ipairs(self._btnGroup) do
		v:RemoveClickListener()
	end

	self._btnAll:RemoveClickListener()
end

function HolyStripePosFilterView:onEnter()
	HolyStripePosFilterView.super.onEnter()

	self._param = checknumber(self:getFirstParam())

	if self._param ~= 0 then
		self._uiChangeAll:SetState(0)

		for i, v in ipairs(self._uiChangeGroup) do
			if self._param == i then
				v:SetState(1)
			else
				v:SetState(0)
			end
		end
	else
		self._uiChangeAll:SetState(1)

		for i, v in ipairs(self._uiChangeGroup) do
			v:SetState(0)
		end
	end
end

function HolyStripePosFilterView:_onClickPosBtn(posType)
	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterPos, posType)
	self:close()
end

function HolyStripePosFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return HolyStripePosFilterView
