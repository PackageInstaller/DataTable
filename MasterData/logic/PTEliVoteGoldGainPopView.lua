-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliVoteGoldGainPopView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliVoteGoldGainPopView", package.seeall)

local PTEliVoteGoldGainPopView = class("PTEliVoteGoldGainPopView", ViewComponent)

function PTEliVoteGoldGainPopView:buildUI()
	PTEliVoteGoldGainPopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._rewardcell = goutil.findChild(self.mainGO, "rewardcell")
	self._rewardCon = goutil.findChild(self.mainGO, "rewardcell/rewardCon")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "rewardcell/txtName")
end

function PTEliVoteGoldGainPopView:bindEvents()
	PTEliVoteGoldGainPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function PTEliVoteGoldGainPopView:unbindEvents()
	PTEliVoteGoldGainPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function PTEliVoteGoldGainPopView:onEnter()
	PTEliVoteGoldGainPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewEliRound, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetGuessInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGainGuessCoinRes, self._handleGainGuessCoinRes, self)
	self:_onUpdate()
end

function PTEliVoteGoldGainPopView:onExit()
	PTEliVoteGoldGainPopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewEliRound, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetGuessInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGainGuessCoinRes, self._handleGainGuessCoinRes, self)
	MaterialMgr.resetAll(self._rewardCon)
end

function PTEliVoteGoldGainPopView:_onUpdate()
	local eliRoundIdListAsCanGain = PeakTournamentModel.instance:getCanGainCoinRoundIdList()
	local matStr = PeakTournamentConfig.instance:getVoteMate()
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local proxy = MaterialMgr.setCell(matType, matId, self._rewardCon)

	self._txtName.text = matName

	local getNum = 0

	for _, eliRoundId in ipairs(eliRoundIdListAsCanGain) do
		local voteData = PeakTournamentConfig.instance:getPtEliVotePlateDataById(self._activityId, eliRoundId)

		if voteData then
			getNum = getNum + voteData.receiveVoteScore
		end
	end

	if proxy then
		proxy:setNum(getNum)
	end

	GameUtil.SetActive(self._btnSure, #eliRoundIdListAsCanGain > 0)
end

function PTEliVoteGoldGainPopView:_onClickBtnSure()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGainGuessCoinReq(self._activityId)
end

function PTEliVoteGoldGainPopView:_handleGainGuessCoinRes()
	FloatWordMgr.instance:show("领取成功")
	self:close()
end

return PTEliVoteGoldGainPopView
