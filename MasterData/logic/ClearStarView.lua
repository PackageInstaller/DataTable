-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarView.lua

module("logic.extensions.clearstargame.view.ClearStarView", package.seeall)

local ClearStarView = class("ClearStarView", ViewComponent)

function ClearStarView:ctor()
	ClearStarView.super.ctor(self)
end

function ClearStarView:unbindEvents()
	ClearStarView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPreview)
	GameUtil.rmClickHandler(self._btnFight)
end

function ClearStarView:bindEvents()
	ClearStarView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickPreview, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
end

function ClearStarView:buildUI()
	ClearStarView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtNum = self:getTxt("times/txtNum")
	self._btnPreview = self:getGo("btnPreview")
	self._btnFight = self:getGo("btnFight")
end

function ClearStarView:onExit()
	ClearStarView.super.onExit(self)
end

function ClearStarView:onEnter()
	ClearStarView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.ClearStarGameGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameStartGame, self._handleStartGame, self)
	ClearStarGameController.instance:getInfo(self._activityId)
end

function ClearStarView:_updateUIByCfg()
	self._actCfg = ClearStarGameConfig.instance:getActivityCfgById(self._activityId)
end

function ClearStarView:_updateUIByInfo()
	local info = ClearStarGameModel.instance:getInfo(self._activityId)

	if info == nil then
		return
	end

	self._times = self._actCfg.dailyTime - checknumber(info.todayTimes)
	self._txtNum.text = string.format("今日剩余次数：%s", self._times)
end

function ClearStarView:_onClickPreview()
	ClearStarGameController.instance:enterGame(self._activityId, true)
end

function ClearStarView:_onClickFight()
	if self._times <= 0 then
		local text = string.format("今日剩余次数不足")

		TipsFacade.instance:openTipWindow("提示", text, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	ClearStarGameController.instance:enterGame(self._activityId, false)
end

function ClearStarView:_handleStartGame()
	ClearStarGameController.instance:enterGame(self._activityId, false)
end

return ClearStarView
