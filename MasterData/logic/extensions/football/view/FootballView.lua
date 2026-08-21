-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballView.lua

module("logic.extensions.football.view.FootballView", package.seeall)

local M = class("FootballView", ViewComponent)
local MatchEnum = {
	IsMatching = 2,
	NotMatching = 1,
	MatchingSuccess = 3
}

function M:buildUI()
	self._titleGo = self:getGo("1&title_view_-478490097")
	self._player1ScoreTxt = self:getText("football_matching_view_-1257440070")
	self._player1WinCountTxt = self:getText("football_matching_view_-5605527")
	self._player1LoseCountTxt = self:getText("football_matching_view_-104824572")
	self._player1DrawCountTxt = self:getText("football_matching_view_-2096432856")
	self._player1NameTxt = self:getText("football_matching_view_-1253187194")
	self._player1Img = self:getGo("football_matching_view_-1790007981")
	self._player1PhotoUnit = PhotoBlurEffect.Get(self._player1Img)
	self._player1PhotoCenterPointGo = self:getGo("football_matching_view_-1453335218")
	self._player1MatchPhotoCenterGo = self:getGo("football_matching_view_178277483")
	self._reportBtn = self:getBtn("football_matching_view_-1549528664")
	self._rankBtn = self:getBtn("football_matching_view_-932998363")
	self._matchingBtn = self:getBtn("football_matching_view_-793107412")
	self._storeBtn = self:getBtn("football_matching_view_-1078347508")
	self._taskBtn = self:getBtn("football_matching_view_-1273872153")
	self._cancelMatchBtn = self:getBtn("football_matching_view_536360893")
	self._matchingHintPanelGo = self:getGo("football_matching_view_1105368895")
	self._leftTimeTxt = self:getText("football_matching_view_1518287978")
	self._leftTimeHintGo = self:getGo("football_matching_view_1398543809")
	self._successHintGo = self:getGo("football_matching_view_889058795")
	self._player2PhotoGo = self:getGo("football_matching_view_972007022")
	self._player2PanelGo = self:getGo("football_matching_view_952043260")
	self._play2UnknownPanelGO = self:getGo("football_matching_view_1549806423")
	self._player2ContentGo = self:getGo("football_matching_view_2060665356")
	self._player2ScoreTxt = self:getText("football_matching_view_72472708")
	self._player2WinCountTxt = self:getText("football_matching_view_465780353")
	self._player2LoseCountTxt = self:getText("football_matching_view_1323110819")
	self._player2DrawCountTxt = self:getText("football_matching_view_124398779")
	self._player2NameTxt = self:getText("football_matching_view_1948162037")
	self._player2Img = self:getGo("football_matching_view_426077007")

	goutil.setActive(self._player2PhotoGo, true)

	self._player2PhotoUnit = PhotoBlurEffect.Get(self._player2Img)

	goutil.setActive(self._player2PhotoGo, false)

	self._player2PhotoCenterPointGo = self:getGo("football_matching_view_338362328")
	self._player2ShadowImgGo = self:getGo("football_matching_view_411853375")

	self._player1PhotoUnit:clear()
	self._player2PhotoUnit:clear()
end

function M:bindEvents()
	self._reportBtn:AddClickListener(self._onClickReport, self)
	self._rankBtn:AddClickListener(self._onClickRank, self)
	self._matchingBtn:AddClickListener(self._onClickMatching, self)
	self._storeBtn:AddClickListener(self._onClickStore, self)
	self._taskBtn:AddClickListener(self._onClickTask, self)
	self._cancelMatchBtn:AddClickListener(self._onClickCancelMatching, self)
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.FOOTBALL_INFO_UPDATE, self._initView, self)
	GlobalDispatcher:addEventListener(EventType.FOOTBALL_START_MATCHING, self._onStartMatching, self)
	GlobalDispatcher:addEventListener(EventType.FOOTBALL_STOP_MATCHING, self._stopMatching, self)
	GlobalDispatcher:addEventListener(EventType.FOOTBALL_MATCHING_FINISH, self._matchingFinish, self)
	GlobalDispatcher:addEventListener(EventType.ACTIVITY_REFRESH + ActivityEnum.LogicType.FOOTBALL, self._activityUpdate, self)
end

function M:onEnter()
	goutil.setActive(self._titleGo, true)

	self._matchingStatus = MatchEnum.NotMatching

	GroupActivityAgent.instance:sendGetMyInfoRequest(BattleExtension_pb.GameType.FOOTBALLPVP)
	self:_bindEvents()
end

function M:_initView()
	self._player1Info = FootballModel.instance:getPlayer1Info()

	self:_refreshPlayer1()
	self:_refreshView()
	self:_checkAutoStart()
end

function M:_checkAutoStart()
	local isRestart = FootballModel.instance:getRestart()

	if isRestart then
		FootballModel.instance:setRestart(false)
		self:_onClickMatching()
	end
end

function M:_refreshView()
	self:_refreshGoActive()
	self:_refreshPlayer2()
	self:_refreshTimeHint()
end

function M:_refreshGoActive()
	if self._matchingStatus == MatchEnum.NotMatching then
		goutil.setActive(self._storeBtn.gameObject, true)
		goutil.setActive(self._taskBtn.gameObject, true)
		goutil.setActive(self._matchingBtn.gameObject, true)
		goutil.setActive(self._reportBtn.gameObject, true)
		goutil.setActive(self._rankBtn.gameObject, true)
		goutil.setActive(self._matchingHintPanelGo, false)
		goutil.setActive(self._player2PanelGo, false)
		goutil.setActive(self._titleGo, true)
	else
		goutil.setActive(self._storeBtn.gameObject, false)
		goutil.setActive(self._taskBtn.gameObject, false)
		goutil.setActive(self._matchingBtn.gameObject, false)
		goutil.setActive(self._reportBtn.gameObject, false)
		goutil.setActive(self._rankBtn.gameObject, false)
		goutil.setActive(self._matchingHintPanelGo, true)
		goutil.setActive(self._player2PanelGo, true)
		goutil.setActive(self._titleGo, false)
	end

	goutil.setActive(self._cancelMatchBtn.gameObject, false)
	goutil.setActive(self._player2ShadowImgGo, false)
	goutil.setActive(self._player2PhotoGo, false)
	goutil.setActive(self._play2UnknownPanelGO, true)

	if self._matchingStatus == MatchEnum.IsMatching then
		goutil.setActive(self._player2ContentGo, false)
		goutil.setActive(self._cancelMatchBtn.gameObject, true)
		goutil.setActive(self._player2ShadowImgGo, true)
	elseif self._matchingStatus == MatchEnum.MatchingSuccess then
		goutil.setActive(self._player2ContentGo, true)
		goutil.setActive(self._player2PhotoGo, true)
		goutil.setActive(self._play2UnknownPanelGO, false)
	end
end

function M:_refreshTimeHint()
	if self._matchingStatus == MatchEnum.IsMatching then
		goutil.setActive(self._leftTimeTxt.gameObject, true)
		goutil.setActive(self._leftTimeHintGo, true)
		goutil.setActive(self._successHintGo, false)
	elseif self._matchingStatus == MatchEnum.MatchingSuccess then
		goutil.setActive(self._leftTimeTxt.gameObject, false)
		goutil.setActive(self._leftTimeHintGo, false)
		goutil.setActive(self._successHintGo, true)
	end
end

function M:_refreshPlayer1()
	self._player1ScoreTxt.text = self._player1Info.score
	self._player1WinCountTxt.text = self._player1Info.win
	self._player1LoseCountTxt.text = self._player1Info.fail
	self._player1DrawCountTxt.text = self._player1Info.draw
	self._player1NameTxt.text = self._player1Info.nickname

	local heroCO = CharacterConfig.instance:getCfgInfoByID(self._player1Info.displayHero)
	local modelId = heroCO.modelId
	local transform = self._player1PhotoCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._player1PhotoUnit,
		modelId = modelId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}

	paramTable.needIgnore = true

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
end

function M:_doPlayer1MoveAnim(isMatching)
	local heroCO = CharacterConfig.instance:getCfgInfoByID(self._player1Info.displayHero)
	local modelId = heroCO.modelId
	local transform

	if isMatching then
		transform = self._player1MatchPhotoCenterGo.transform
	else
		transform = self._player1PhotoCenterPointGo.transform
	end

	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._player1PhotoUnit,
		modelId = modelId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}
	local params = SpineCutShowLoader.getSpineLiHuiParam(paramTable)

	self._player1PhotoUnit:getUnit().go.transform:DOKill(false)
	self._player1PhotoUnit:getUnit().go.transform:DOLocalMove(Vector3.New(params[1], params[2], 0), 0.3)
	self._player1PhotoUnit:getUnit().go.transform:DOScale(Vector3.New(params[3], params[4], 1), 0.3)
end

function M:_refreshPlayer2()
	if self._matchingStatus == MatchEnum.MatchingSuccess then
		self._player2Info = FootballModel.instance:getPlayer2Info()
		self._player2ScoreTxt.text = self._player2Info.score
		self._player2WinCountTxt.text = self._player2Info.win
		self._player2LoseCountTxt.text = self._player2Info.fail
		self._player2DrawCountTxt.text = self._player2Info.draw
		self._player2NameTxt.text = self._player2Info.nickname

		local heroCO = CharacterConfig.instance:getCfgInfoByID(self._player2Info.displayHero)
		local modelId = heroCO.modelId
		local transform = self._player2PhotoCenterPointGo.transform
		local cutCenterPos = {
			transform.anchoredPosition.x,
			transform.anchoredPosition.y,
			transform.localScale.x,
			transform.localScale.y
		}
		local paramTable = {
			isShowEgg = true,
			isShowEnter = true,
			photo = self._player2PhotoUnit,
			modelId = modelId,
			cutCenterPos = cutCenterPos,
			iconType = IconType.CharaterBust
		}

		paramTable.needIgnore = true

		SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	end
end

function M:_onStartMatching()
	self._timeLeft = 61
	self._matchingStatus = MatchEnum.IsMatching

	self:_refreshView()
	self:_matchingTimeUpdate()
	settimer(1, self._matchingTimeUpdate, self, true)
	self:_doPlayer1MoveAnim(true)
end

function M:_matchingTimeUpdate()
	self._timeLeft = self._timeLeft - 1
	self._leftTimeTxt.text = TimeUtil.instance:numberToTime(self._timeLeft)
end

function M:_stopMatching()
	removetimer(self._matchingTimeUpdate, self)

	self._matchingStatus = MatchEnum.NotMatching

	self:_refreshView()
	self:_doPlayer1MoveAnim(false)
end

function M:_matchingFinish(_, msg)
	removetimer(self._matchingTimeUpdate, self)

	if msg.result == 0 then
		self._matchingStatus = MatchEnum.MatchingSuccess

		self:_refreshView()
		settimer(2, self._startBattle, self, false)
	else
		self:_stopMatching()
	end
end

function M:_startBattle()
	BattleAgent.instance:sendConnectRequest()
end

function M:_onClickReport()
	ViewMgr.instance:open(ViewName.FootballRecord)
end

function M:_onClickRank()
	ViewMgr.instance:open(ViewName.FootballRank)
end

function M:_onClickMatching()
	GroupActivityAgent.instance:sendStartMatchRequest(BattleExtension_pb.GameType.FOOTBALLPVP)
end

function M:_onClickStore()
	return
end

function M:_onClickTask()
	return
end

function M:_activityUpdate()
	self._activityMO = TimeLimitActivityModel.instance:getActivityMO(ActivityEnum.LogicType.FOOTBALL)

	if not self._activityMO then
		FloatWordMgr.instance:show("活动已经结束~")
		self:back()
	end
end

function M:_onClickCancelMatching()
	GroupActivityAgent.instance:sendStopMatchRequest(BattleExtension_pb.GameType.FOOTBALLPVP)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.FOOTBALL_INFO_UPDATE, self._initView, self)
	GlobalDispatcher:removeEventListener(EventType.FOOTBALL_START_MATCHING, self._onStartMatching, self)
	GlobalDispatcher:removeEventListener(EventType.FOOTBALL_STOP_MATCHING, self._stopMatching, self)
	GlobalDispatcher:removeEventListener(EventType.FOOTBALL_MATCHING_FINISH, self._matchingFinish, self)
	GlobalDispatcher:removeEventListener(EventType.ACTIVITY_REFRESH + ActivityEnum.LogicType.FOOTBALL, self._activityUpdate, self)
end

function M:unbindEvents()
	self._reportBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._matchingBtn:RemoveClickListener()
	self._storeBtn:RemoveClickListener()
	self._taskBtn:RemoveClickListener()
	self._cancelMatchBtn:RemoveClickListener()
end

function M:onExit()
	self._player1PhotoUnit:getUnit().go.transform:DOKill(false)
	removetimer(self._startBattle, self)
	self:_unbindEvents()
	removetimer(self._matchingTimeUpdate, self)
end

function M:destroyUI()
	self._player1PhotoUnit:clear()
	self._player2PhotoUnit:clear()
end

return M
