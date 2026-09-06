-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingGainCoinView.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingGainCoinView", package.seeall)

local TeenChampionKingGainCoinView = class("TeenChampionKingGainCoinView", ViewComponent)

function TeenChampionKingGainCoinView:ctor()
	TeenChampionKingGainCoinView.super.ctor(self)
end

function TeenChampionKingGainCoinView:unbindEvents()
	TeenChampionKingGainCoinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TeenChampionKingGainCoinView:bindEvents()
	TeenChampionKingGainCoinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function TeenChampionKingGainCoinView:buildUI()
	TeenChampionKingGainCoinView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._rewardCon = self:getGo("rewardcell/rewardCon")
	self._txtCount = self:getTxt("rewardcell/txtCount")
	self._txtName = self:getTxt("rewardcell/txtName")
	self._txtBtnSure = self:getTxt("btnSure/txt")
end

function TeenChampionKingGainCoinView:onExit()
	TeenChampionKingGainCoinView.super.onExit(self)
	MaterialMgr.resetAll(self._rewardCon)
end

function TeenChampionKingGainCoinView:onEnter()
	TeenChampionKingGainCoinView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self.addGEvent(self, GlobalNotify.PM_TCKGainGuessCoin, self._handleGainCoin, self)
	self:_updateUIByCfg()
end

function TeenChampionKingGainCoinView:_updateUIByCfg()
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)

	local guessItem = self._actCfg.guessItem
	local matType, id = MaterialMgr.getMatParams(self._actCfg.guessItem)
	local coinNum = 1

	self._txtCount.text = ""
	self._txtName.text = MaterialMgr.getMaterialsName(matType, id)

	GameUtil.SetGray(self._btnSure, false)

	self._curRoundType = ""
	self._hasGainCoin = false
	self._coinNum = 0

	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if globalInfo then
		local curStepId = checknumber(globalInfo.curStepId)
		local curRoundCfg = TeenChampionKingConfig.instance:getRoundCfgByStepId(self._activityId, curStepId)

		self._curRoundType = curRoundCfg and curRoundCfg.roundType
		self._hasGainCoin = globalInfo.gainDailyCoin

		if self._hasGainCoin then
			GameUtil.SetGray(self._btnSure, true)

			self._txtBtnSure.text = "已领取"
		end

		if self._curRoundType ~= TeenChampionKingController.RoundType.KNOCKOUT and self._curRoundType ~= TeenChampionKingController.RoundType.CHAMPION then
			GameUtil.SetGray(self._btnSure, true)

			self._txtBtnSure.text = "不可领取"
		end

		coinNum = globalInfo.coinCount or 0

		if coinNum <= 0 then
			GameUtil.SetGray(self._btnSure, true)

			self._txtBtnSure.text = "不可领取"
		end

		self._coinNum = coinNum
	end

	local matStr = guessItem .. ":" .. coinNum

	MaterialMgr.setCellByCfg(matStr, self._rewardCon)
end

function TeenChampionKingGainCoinView:_onClickSure()
	if self._curRoundType ~= TeenChampionKingController.RoundType.KNOCKOUT and self._curRoundType ~= TeenChampionKingController.RoundType.CHAMPION then
		TipsFacade.instance:openCommonTips("当前轮次不可领取")

		return
	end

	if self._coinNum <= 0 then
		TipsFacade.instance:openCommonTips("当前轮次不可领取")

		return
	end

	if self._hasGainCoin then
		TipsFacade.instance:openCommonTips("本轮已领取")

		return
	end

	TeenChampionKingController.instance:gainGuessCoin(self._activityId)
end

function TeenChampionKingGainCoinView:_handleGainCoin()
	TipsFacade.instance:openCommonTips("领取成功")
	self:close()
end

return TeenChampionKingGainCoinView
