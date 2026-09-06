-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionSettingView.lua

module("logic.extensions.mission.view.MissionSettingView", package.seeall)

local MissionSettingView = class("MissionSettingView", ViewComponent)

function MissionSettingView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._slider1 = self:getSlider("main/Slider1")
	self._slider2 = self:getSlider("main/Slider2")
	self._slider3 = self:getSlider("main/Slider3")
	self._imgNo1 = self:getGo("main/Slider1/imgFalse")
	self._imgYes1 = self:getGo("main/Slider1/imgTrue")
	self._imgNo2 = self:getGo("main/Slider2/imgFalse")
	self._imgYes2 = self:getGo("main/Slider2/imgTrue")
	self._imgNo3 = self:getGo("main/Slider3/imgFalse")
	self._imgYes3 = self:getGo("main/Slider3/imgTrue")
end

function MissionSettingView:onEnter()
	self:_initSetting()
end

function MissionSettingView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._slider1:AddOnValueChanged(self._onValueChanged1, self)
	self._slider2:AddOnValueChanged(self._onValueChanged2, self)
	self._slider3:AddOnValueChanged(self._onValueChanged3, self)
end

function MissionSettingView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._slider1:RemoveOnValueChanged()
	self._slider2:RemoveOnValueChanged()
	self._slider3:RemoveOnValueChanged()
end

function MissionSettingView:onExit()
	self:_saveSetting()
end

function MissionSettingView:_onClickClose()
	self:close()
end

function MissionSettingView:_getSliderName(index)
	return ViewName.MissionSettingView .. index
end

function MissionSettingView:_initSetting()
	local isClose = GameUtil.getUserData(self:_getSliderName(GameEnum.MissionSetting.Restrain))

	self._slider1:SetValue(isClose and 0 or 1)

	local isClose2 = GameUtil.getUserData(self:_getSliderName(GameEnum.MissionSetting.AtkTarget))

	self._slider2:SetValue(isClose2 and 0 or 1)

	local isClose3 = GameUtil.getUserData(self:_getSliderName(GameEnum.MissionSetting.RecPos))

	self._slider3:SetValue(isClose3 and 0 or 1)
	printInfo("test 三个滑动条状态：", isClose, isClose2, isClose3)
end

function MissionSettingView:_saveSetting()
	local value1 = self._slider1:GetValue()
	local value2 = self._slider2:GetValue()
	local value3 = self._slider3:GetValue()

	GameUtil.saveUserData(self:_getSliderName(1), value1 == 0 and true or false)
	GameUtil.saveUserData(self:_getSliderName(2), value2 == 0 and true or false)
	GameUtil.saveUserData(self:_getSliderName(3), value3 == 0 and true or false)
end

function MissionSettingView:_onValueChanged1(value)
	local isClose = value == 0

	self._imgNo1:SetActive(isClose)
	self._imgYes1:SetActive(not isClose)
end

function MissionSettingView:_onValueChanged2(value)
	local isClose = value == 0

	self._imgNo2:SetActive(isClose)
	self._imgYes2:SetActive(not isClose)
end

function MissionSettingView:_onValueChanged3(value)
	local isClose = value == 0

	self._imgNo3:SetActive(isClose)
	self._imgYes3:SetActive(not isClose)
end

return MissionSettingView
