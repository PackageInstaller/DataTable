-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQualityFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeQualityFilterView", package.seeall)

local HolyStripeQualityFilterView = class("HolyStripeQualityFilterView", ViewComponent)

function HolyStripeQualityFilterView:buildUI()
	HolyStripeQualityFilterView.super.buildUI(self)

	self._btnAll = self:getBtn("fitlerRoot/btnAll")
	self._btnPos_1 = self:getBtn("fitlerRoot/btnPos_1")
	self._btnPos_2 = self:getBtn("fitlerRoot/btnPos_2")
	self._btnPos_3 = self:getBtn("fitlerRoot/btnPos_3")
	self._btnPos_4 = self:getBtn("fitlerRoot/btnPos_4")
	self._btnPos_5 = self:getBtn("fitlerRoot/btnPos_5")
	self._uiChangeAll = goutil.findChildComponent(self.mainGO, "fitlerRoot/btnAll", "UIChangeGroup")
	self._uiChange_1 = goutil.findChildComponent(self.mainGO, "fitlerRoot/btnPos_1", "UIChangeGroup")
	self._uiChange_2 = goutil.findChildComponent(self.mainGO, "fitlerRoot/btnPos_2", "UIChangeGroup")
	self._uiChange_3 = goutil.findChildComponent(self.mainGO, "fitlerRoot/btnPos_3", "UIChangeGroup")
	self._uiChange_4 = goutil.findChildComponent(self.mainGO, "fitlerRoot/btnPos_4", "UIChangeGroup")
	self._uiChange_5 = goutil.findChildComponent(self.mainGO, "fitlerRoot/btnPos_5", "UIChangeGroup")
	self._customInput = UICustomInput.Get(self:getGo("fitlerRoot"))
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

function HolyStripeQualityFilterView:bindEvents()
	HolyStripeQualityFilterView.super.bindEvents(self)
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

function HolyStripeQualityFilterView:unbindEvents()
	HolyStripeQualityFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()

	for i, v in ipairs(self._btnGroup) do
		v:RemoveClickListener()
	end

	self._btnAll:RemoveClickListener()
end

function HolyStripeQualityFilterView:onEnter()
	HolyStripeQualityFilterView.super.onEnter()

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

function HolyStripeQualityFilterView:_onClickPosBtn(posType)
	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterQuality, posType)
	self:close()
end

function HolyStripeQualityFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return HolyStripeQualityFilterView
