-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTPetRankJumpView.lua

module("logic.extensions.saintknighttask.view.SKTPetRankJumpView", package.seeall)

local SKTPetRankJumpView = class("SKTPetRankJumpView", ViewComponent)

function SKTPetRankJumpView:ctor()
	SKTPetRankJumpView.super.ctor(self)
end

function SKTPetRankJumpView:buildUI()
	SKTPetRankJumpView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._btnGoto = goutil.findChild(self.mainGO, "btnGoto")
end

function SKTPetRankJumpView:bindEvents()
	SKTPetRankJumpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickBtnGoto, self)
end

function SKTPetRankJumpView:unbindEvents()
	SKTPetRankJumpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function SKTPetRankJumpView:destroyUI()
	SKTPetRankJumpView.super.destroyUI(self)
end

function SKTPetRankJumpView:onEnter()
	SKTPetRankJumpView.super.onEnter(self)

	self._activityId = SaintKnightTaskController.instance:getActivityId()

	local isInTime = SaintKnightTaskController.instance:isInActivityTimeAsSkt(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	local data = SaintKnightTaskConfig.instance:getSktActData(self._activityId)

	GameUtil.SetActive(self._btnGoto, data and not string.nilorempty(data.petRankJumpKey))
end

function SKTPetRankJumpView:onExit()
	SKTPetRankJumpView.super.onExit(self)
end

function SKTPetRankJumpView:_onClickBtnGoto()
	local data = SaintKnightTaskConfig:getSktActData(self._activityId)

	if data then
		GotoMgr.gotoByString(data.petRankJumpKey)
	end
end

return SKTPetRankJumpView
