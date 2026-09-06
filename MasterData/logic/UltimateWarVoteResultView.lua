-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarVoteResultView.lua

module("logic.extensions.ultimatewar.view.UltimateWarVoteResultView", package.seeall)

local UltimateWarVoteResultView = class("UltimateWarVoteResultView", ViewComponent)

function UltimateWarVoteResultView:buildUI()
	UltimateWarVoteResultView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtLeft = self:getTxt("txtLeft")
	self._txtRight = self:getTxt("txtRight")
	self._slider = self:getSlider("slider")
end

function UltimateWarVoteResultView:bindEvents()
	UltimateWarVoteResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function UltimateWarVoteResultView:unbindEvents()
	UltimateWarVoteResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function UltimateWarVoteResultView:onEnter()
	UltimateWarVoteResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarVoteRes, self._onUpdate, self)
	self:_onUpdate()
end

function UltimateWarVoteResultView:onExit()
	UltimateWarVoteResultView.super.onExit(self)
end

function UltimateWarVoteResultView:_onUpdate()
	local leftCount = self._ultimateWarMo:getVoteCount(1)
	local rightCount = self._ultimateWarMo:getVoteCount(2)
	local total = leftCount + rightCount
	local txtArr = {
		self._txtLeft,
		self._txtRight
	}
	local countArr = {
		leftCount,
		rightCount
	}

	for _, voteId in ipairs({
		1,
		2
	}) do
		local txt = txtArr[voteId]
		local count = countArr[voteId]
		local value = 0

		if total > 0 then
			value = Mathf.Floor(count / total * 10000) / 100
			value = Mathf.Max(value, 0.0001)
		end

		txt.text = string.format("%.02f%%", value)
	end

	self._slider:SetValue((total > 0 or nil) and Mathf.Max(leftCount / total, 0.01))
end

return UltimateWarVoteResultView
