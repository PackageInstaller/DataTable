-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingGainCoinView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingGainCoinView", package.seeall)

local YoungChampionKingGainCoinView = class("YoungChampionKingGainCoinView", ViewComponent)

function YoungChampionKingGainCoinView:ctor()
	YoungChampionKingGainCoinView.super.ctor(self)
end

function YoungChampionKingGainCoinView:unbindEvents()
	YoungChampionKingGainCoinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function YoungChampionKingGainCoinView:bindEvents()
	YoungChampionKingGainCoinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function YoungChampionKingGainCoinView:buildUI()
	YoungChampionKingGainCoinView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._rewardCon = self:getGo("rewardcell/rewardCon")
	self._txtCount = self:getTxt("rewardcell/txtCount")
	self._txtName = self:getTxt("rewardcell/txtName")
	self._txtBtnSure = self:getTxt("btnSure/txt")
end

function YoungChampionKingGainCoinView:onExit()
	YoungChampionKingGainCoinView.super.onExit(self)
	MaterialMgr.resetAll(self._rewardCon)
end

function YoungChampionKingGainCoinView:onEnter()
	YoungChampionKingGainCoinView.super.onEnter(self)

	self._activityId = YoungChampionKingModel.instance:getCurActId()
	self._actCfg = YoungChampionKingConfig.instance:getActCfg(self._activityId)

	local matType, id = MaterialMgr.getMatParams(self._actCfg.guessItem)
	local matStr = self._actCfg.guessItem .. ":" .. self._actCfg.dailyGuessCoin

	MaterialMgr.setCellByCfg(matStr, self._rewardCon)

	self._txtCount.text = ""
	self._txtName.text = MaterialMgr.getMaterialsName(matType, id)

	self.addGEvent(self, GlobalNotify.PM_YCKGainGuessCoinRes, self.close, self)
	GameUtil.SetGray(self._btnSure, false)

	self._curStepId = YoungChampionKingModel.instance:getCurStepId()
	self._curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(self._curStepId)

	if YoungChampionKingModel.instance:getIsGainDailyCoin() then
		GameUtil.SetGray(self._btnSure, true)

		self._txtBtnSure.text = "已领取"
	end

	if self._curRoundId < YoungChampionKingEnum.Common_Knockout_128To64_Id or self._curRoundId > YoungChampionKingEnum.Final_Match_Round_Id then
		GameUtil.SetGray(self._btnSure, true)

		self._txtBtnSure.text = "不可领取"
	end
end

function YoungChampionKingGainCoinView:_onClickSure()
	if self._curRoundId < YoungChampionKingEnum.Common_Knockout_128To64_Id or self._curRoundId > YoungChampionKingEnum.Final_Match_Round_Id then
		TipsFacade.instance:openCommonTips("当前轮次不可领取")

		return
	end

	if YoungChampionKingModel.instance:getIsGainDailyCoin() then
		TipsFacade.instance:openCommonTips("今日已领取")

		return
	end

	YoungChampionKingController.instance:sendPM_YCKGainGuessCoinReq(self._activityId)
end

return YoungChampionKingGainCoinView
