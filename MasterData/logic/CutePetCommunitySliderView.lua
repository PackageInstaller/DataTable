-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunitySliderView.lua

module("logic.extensions.cutepet.view.CutePetCommunitySliderView", package.seeall)

local CutePetCommunitySliderView = class("CutePetCommunitySliderView", ViewComponent)

function CutePetCommunitySliderView:ctor()
	CutePetCommunitySliderView.super.ctor(self)
end

function CutePetCommunitySliderView:unbindEvents()
	CutePetCommunitySliderView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReduce)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMax)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	self._slider:RemoveOnValueChanged()
end

function CutePetCommunitySliderView:bindEvents()
	CutePetCommunitySliderView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReduce, self._onClickReduce, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickMax, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._slider:AddOnValueChanged(self._onSliderValueChange, self)
end

function CutePetCommunitySliderView:buildUI()
	CutePetCommunitySliderView.super.buildUI(self)

	self._slider = self:getSlider("timeSlider")
	self._txtTime = self:getTxt("txtTime")
	self._btnReduce = self:getBtn("btnReduce")
	self._btnAdd = self:getBtn("btnAdd")
	self._btnMax = self:getBtn("btnMax")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
end

function CutePetCommunitySliderView:onExit()
	CutePetCommunitySliderView.super.onExit(self)
end

function CutePetCommunitySliderView:onEnter()
	CutePetCommunitySliderView.super.onEnter(self)

	local params = self:getOpenParam()

	self._max = params[1]
	self._curNum = params[2]
	self._slider.slider.maxValue = self._max

	self._slider:SetValue(self._curNum)
end

function CutePetCommunitySliderView:_onClickReduce()
	if self._curNum > 1 then
		self._slider:SetValue(self._curNum - 1)
	end
end

function CutePetCommunitySliderView:_onClickAdd()
	if self._curNum < self._max then
		self._slider:SetValue(self._curNum + 1)
	end
end

function CutePetCommunitySliderView:_onClickMax()
	self._slider:SetValue(self._max)
end

function CutePetCommunitySliderView:_onClickClose()
	self:close()
end

function CutePetCommunitySliderView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.CutePetCommunitySliderNum, self._curNum)
	self:close()
end

function CutePetCommunitySliderView:_onSliderValueChange()
	self._curNum = self._slider:GetValue()
	self._txtTime.text = langPara("%d/%d", self._curNum, self._max)
end

return CutePetCommunitySliderView
