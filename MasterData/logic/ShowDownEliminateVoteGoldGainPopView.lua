-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateVoteGoldGainPopView.lua

module("logic.extensions.showdown.view.ShowDownEliminateVoteGoldGainPopView", package.seeall)

local ShowDownEliminateVoteGoldGainPopView = class("ShowDownEliminateVoteGoldGainPopView", ViewComponent)

function ShowDownEliminateVoteGoldGainPopView:ctor()
	ShowDownEliminateVoteGoldGainPopView.super.ctor(self)
end

function ShowDownEliminateVoteGoldGainPopView:bindEvents()
	ShowDownEliminateVoteGoldGainPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ShowDownEliminateVoteGoldGainPopView:unbindEvents()
	ShowDownEliminateVoteGoldGainPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._btnSure:RemoveClickListener()
end

function ShowDownEliminateVoteGoldGainPopView:buildUI()
	ShowDownEliminateVoteGoldGainPopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtName = self:getTxt("rewardcell/txtName")
	self._rewardCon = self:getGo("rewardcell/rewardCon")
	self._txtCount = self:getTxt("rewardcell/txtCount")
end

function ShowDownEliminateVoteGoldGainPopView:onEnter()
	ShowDownEliminateVoteGoldGainPopView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = checknumber(param[1])
	self._curRoundId = checknumber(param[2])

	self:_initView()
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GainDailyGuessItemRes, self.close, self)
end

function ShowDownEliminateVoteGoldGainPopView:onExit()
	ShowDownEliminateVoteGoldGainPopView.super.onExit(self)
	MaterialMgr.resetAll(self._rewardCon)
end

function ShowDownEliminateVoteGoldGainPopView:_initView()
	local data = ShowDownConfig.instance:getActData(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(data.guessItem)

	MaterialMgr.setIcon(self._rewardCon, matType, matId)

	local roundData = ShowDownConfig.instance:getRoundData(self._activityId, self._curRoundId)

	if roundData then
		if not roundData.dailyGuessItemCount then
			local dailyGuessItemCount = 0

			self._txtName.text = MaterialMgr.getMaterialsName(matType, matId)
			self._txtCount.text = string.format("x%s", dailyGuessItemCount)

			local isGainDailyGuessItem = ShowDownController.instance:isGainDailyGuessItem(self._activityId)

			GameUtil.SetGray(self._btnSure, isGainDailyGuessItem)
		end
	end
end

function ShowDownEliminateVoteGoldGainPopView:_onClickSure()
	local isGainDailyGuessItem = ShowDownController.instance:isGainDailyGuessItem(self._activityId)

	if isGainDailyGuessItem then
		FloatWordMgr.instance:show("已领取")

		return
	end

	ShowDownController.instance:sendPM_ShowDown_GainDailyGuessItemReq(self._activityId)
end

return ShowDownEliminateVoteGoldGainPopView
