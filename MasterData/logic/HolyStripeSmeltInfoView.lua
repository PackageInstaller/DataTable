-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSmeltInfoView.lua

module("logic.extensions.holystripe.view.HolyStripeSmeltInfoView", package.seeall)

local HolyStripeSmeltInfoView = class("HolyStripeSmeltInfoView", ViewComponent)

function HolyStripeSmeltInfoView:ctor()
	self._qualitySelect = {
		false,
		false,
		false
	}
	self._daysSelect = {
		false,
		false,
		false,
		false
	}
	self._daysList = nil
end

function HolyStripeSmeltInfoView:buildUI()
	HolyStripeSmeltInfoView.super.buildUI(self)

	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._toggleQuality1 = self:getToggle("quality/toggle_1")
	self._toggleQuality2 = self:getToggle("quality/toggle_2")
	self._toggleQuality3 = self:getToggle("quality/toggle_3")
	self._toggleDays1 = self:getToggle("time/toggle_1")
	self._txtDays1 = self:getTxt("time/toggle_1/Label")
	self._toggleDays2 = self:getToggle("time/toggle_2")
	self._txtDays2 = self:getTxt("time/toggle_2/Label")
	self._toggleDays3 = self:getToggle("time/toggle_3")
	self._txtDays3 = self:getTxt("time/toggle_3/Label")
	self._toggleDays4 = self:getToggle("time/toggle_4")
	self._txtDays4 = self:getTxt("time/toggle_4/Label")
	self._toggleQualityGroup = {
		self._toggleQuality1,
		self._toggleQuality2,
		self._toggleQuality3
	}
	self._toggleDaysGroup = {
		self._toggleDays4,
		self._toggleDays1,
		self._toggleDays2,
		self._toggleDays3
	}
	self._txtDayGroup = {
		self._txtDays4,
		self._txtDays1,
		self._txtDays2,
		self._txtDays3
	}
end

function HolyStripeSmeltInfoView:bindEvents()
	HolyStripeSmeltInfoView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickSave, self)

	for i, v in ipairs(self._toggleQualityGroup) do
		v:AddOnValueChanged(function(go, state)
			self:_onChangeQualitSelect(go, state, i)
		end)
	end

	for i, v in ipairs(self._toggleDaysGroup) do
		v:AddOnValueChanged(function(go, state)
			self:_onChangeDaysSelect(go, state, i)
		end)
	end
end

function HolyStripeSmeltInfoView:unbindEvents()
	HolyStripeSmeltInfoView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()

	for i, v in ipairs(self._toggleDaysGroup) do
		v:RemoveOnValueChanged()
	end

	for i, v in ipairs(self._toggleDaysGroup) do
		v:RemoveOnValueChanged()
	end
end

function HolyStripeSmeltInfoView:onEnter()
	HolyStripeSmeltInfoView.super.onEnter(self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeSetSmeltInfoRes, self._PM_HolyStripeSetSmeltInfoRes, self)

	self._qualitySelect = {
		false,
		false,
		false
	}
	self._daysSelect = {
		false,
		false,
		false
	}
	self._daysList = HolyStripeConfig.instance:getSmeltDays()

	for i, v in ipairs(self._txtDayGroup) do
		v.text = self._daysList[i] == 0 and "停止逐愿" or string.format("%d天后", self._daysList[i])
	end

	local smeltDays = HolyStripeModel.instance:getAutoSmeltDays()

	self._toggleDays1.isOn = false
	self._toggleDays2.isOn = false
	self._toggleDays3.isOn = false
	self._toggleDays4.isOn = false

	for i, v in ipairs(self._daysList) do
		if smeltDays == v then
			for n, toggle in ipairs(self._toggleDaysGroup) do
				if n == i then
					toggle.isOn = true

					break
				end
			end

			break
		end
	end

	local qualitys = HolyStripeModel.instance:getAutoSmeltQualityList()

	self._toggleQuality1.isOn = false
	self._toggleQuality2.isOn = false
	self._toggleQuality3.isOn = false

	for i, v in ipairs(qualitys) do
		if v == 1 or v == 2 then
			self._toggleQuality1.isOn = true
		elseif v == 3 then
			self._toggleQuality2.isOn = true
		elseif v == 4 then
			self._toggleQuality3.isOn = true
		end
	end
end

function HolyStripeSmeltInfoView:onExit()
	HolyStripeSmeltInfoView.super.onExit()
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeSetSmeltInfoRes, self._PM_HolyStripeSetSmeltInfoRes, self)
end

function HolyStripeSmeltInfoView:_onClickbtnClose()
	self:close()
end

function HolyStripeSmeltInfoView:_onChangeQualitSelect(go, state, btn)
	self._qualitySelect[btn] = state
end

function HolyStripeSmeltInfoView:_onChangeDaysSelect(go, state, btn)
	self._daysSelect[btn] = state
end

function HolyStripeSmeltInfoView:_onClickSave(go, state)
	local qualitys = {}

	for i, v in ipairs(self._qualitySelect) do
		if v == true then
			if i == 1 then
				table.insert(qualitys, 1)
				table.insert(qualitys, 2)
			elseif i == 2 then
				table.insert(qualitys, 3)
			elseif i == 3 then
				table.insert(qualitys, 4)
			end
		end
	end

	local days = 0

	for i, v in ipairs(self._daysSelect) do
		if v == true then
			days = self._daysList[i]

			break
		end
	end

	HolyStripeAgent.instance:sendPM_HolyStripeSetSmeltInfoReq(qualitys, days)
	HolyStripeModel.instance:setCacheAutoSmelt(qualitys, days)
end

function HolyStripeSmeltInfoView:_PM_HolyStripeSetSmeltInfoRes()
	local qualitys = {}

	for i, v in ipairs(self._qualitySelect) do
		if v == true then
			if i == 1 then
				table.insert(qualitys, 1)
				table.insert(qualitys, 2)
			elseif i == 2 then
				table.insert(qualitys, 3)
			elseif i == 3 then
				table.insert(qualitys, 4)
			end
		end
	end

	local days = 0

	for i, v in ipairs(self._daysSelect) do
		if v == true then
			days = self._daysList[i]

			break
		end
	end

	HolyStripeModel.instance:setCacheAutoSmelt(qualitys, days)
	self:close()
end

return HolyStripeSmeltInfoView
