-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleResultView.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleResultView", package.seeall)

local M = class("AirWorkBattleResultView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._isPlayingAni = false
end

function M:buildUI()
	self._btnClose = self:getBtn("air_workshop_calculate_fail_tips_-170231369")
	self._btnExit = self:getBtn("0&com_btn_2_-31477526")
	self._btnAgain = self:getBtn("1&btn_middle_-31477526")
	self._btnEditFlag = self:getBtn("air_workshop_calculate_fail_tips_-411135709")
	self._btnMessage = self:getBtn("air_workshop_calculate_fail_tips_1561519664")
	self._btnLike = self:getBtn("air_workshop_calculate_fail_tips_-1412069671")
	self._btnRecord = self:getBtn("air_workshop_calculate_fail_tips_1068313920")
	self._canvasGroupLiked = goutil.findChildComponent(self._btnLike.gameObject, "Image", ComponentType.CanvasGroup)
	self._txtAgain = self:getText("1&btn_middle_1478048452")
	self._txtContent = self:getText("air_workshop_calculate_results_tips_-1096659915")
	self._txtScore1 = self:getText("air_workshop_calculate_fail_tips_-1169410242")
	self._txtScore2 = self:getText("air_workshop_calculate_fail_tips_-1401564671")
	self._txtScore2_1 = self:getText("air_workshop_calculate_fail_tips_1655016756")
	self._txtScore3 = self:getText("air_workshop_calculate_fail_tips_466042368")
	self._flagGo = self:getGo("air_workshop_calculate_results_tips_735377702")
	self._txtFlagCount = self:getText("air_workshop_calculate_fail_tips_-1391358228")
	self._txtMessageCount = self:getText("air_workshop_calculate_fail_tips_1763359849")
	self._txtLikeCount = self:getText("air_workshop_calculate_fail_tips_1422001996")
	self._successPanel = self:getGo("air_workshop_calculate_fail_tips_-1343033007")
	self._failedPanel = self:getGo("air_workshop_calculate_fail_tips_-1578204533")
	self._testPanel = self:getGo("air_workshop_calculate_fail_tips_-909877182")
	self._freePanel = self:getGo("air_workshop_calculate_results_tips_-622855985")
	self._scorePanel = self:getGo("air_workshop_calculate_fail_tips_-1772721259")
	self._btnListPanel = self:getGo("air_workshop_calculate_fail_tips_-1049876579")
	self._downBtnPanel = self:getGo("air_workshop_calculate_fail_tips_1194500337")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExit:AddClickListener(self._onClickExit, self)
	self._btnAgain:AddClickListener(self._onClickAgain, self)
	self._btnEditFlag:AddClickListener(self._onClickEditFlag, self)
	self._btnMessage:AddClickListener(self._onClickMessage, self)
	self._btnLike:AddClickListener(self._onClickLike, self)
	self._btnRecord:AddClickListener(self._onClickRecord, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._btnEditFlag:RemoveClickListener()
	self._btnMessage:RemoveClickListener()
	self._btnLike:RemoveClickListener()
	self._btnRecord:RemoveClickListener()
end

function M:_addEvents(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_COMMENT_MAP, self._handleOnCommentMap, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_LIKED_MAP, self._handleLike, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_COMMENT_MAP, self._handleOnCommentMap, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_LIKED_MAP, self._handleLike, self)
	end
end

function M:onEnter()
	self:_addEvents(true)

	local params = self:getOpenParam()

	self._style = params[1]
	self._resultData = params[2]

	self:_setContent()
end

function M:onExit()
	self:_addEvents(false)

	self._isPlayingAni = false

	self:_tryLikedMap()
	removetimer(self._setContentFail, self)
end

function M:_setContent()
	local isTest = self._style == AirWorkShopEnum.CalculateStyle.Test
	local isWin = false

	if isTest then
		isWin = self._resultData.win
	else
		isWin = self._resultData.isWin
	end

	goutil.setActive(self._successPanel, isWin)
	goutil.setActive(self._failedPanel, not isWin)
	goutil.setActive(self._testPanel, false)
	goutil.setActive(self._freePanel, false)
	goutil.setActive(self._scorePanel, false)
	goutil.setActive(self._btnListPanel, false)
	goutil.setActive(self._downBtnPanel, false)
	self._guiAnimation:StopTimelineAni()

	if isWin then
		self._guiAnimation:PlayAniByName("success")
		BattleAudioUtil.playSEByName("ui_battle_diaochawancheng")

		self._isPlayingAni = true

		settimer(1.5, self._setContentWin, self, false)
		BattleCalculateMgr.instance:startVictoryPerformance()
	else
		self._guiAnimation:PlayAniByName("fail")
		BattleAudioUtil.playSEByName("ui_battle_diaochashibai")

		self._isPlayingAni = false

		settimer(1.5, self._setContentFail, self, false)
	end
end

function M:_setContentWin()
	self._isPlayingAni = false

	self:close()
	ViewMgr.instance:open(ViewName.AirWorkShopBattleCalculate, self._style, self._resultData)
end

function M:_setContentFail()
	self._isPlayingAni = false

	if self._style == AirWorkShopEnum.CalculateStyle.Free then
		self._txtContent.text = string.format("%s%%", AirWorkShopUtil.formatPassRatio(self._resultData.level.passRate * 100, 1))
	end

	if self._style == AirWorkShopEnum.CalculateStyle.Competitive then
		local addScore = self._resultData.rodeo.totalScore - self._resultData.rodeo.addScore

		self._txtScore1.text = self._resultData.rodeo.curScore
		self._txtScore2.text = self._resultData.rodeo.addScore
		self._txtScore2_1.text = addScore
		self._txtScore3.text = self._resultData.rodeo.maxScore

		goutil.setActive(self._flagGo, addScore > 0)
		goutil.setActive(self._txtScore2_1.gameObject, addScore > 0)
	end

	if self._style ~= AirWorkShopEnum.CalculateStyle.Test then
		self._txtFlagCount.text = #self._resultData.level.tags
		self._txtMessageCount.text = self._resultData.level.commentNum
		self._txtLikeCount.text = self._resultData.level.likeNum
		self._cachLikedMap = self._resultData.level.liked
		self._canvasGroupLiked.alpha = self._cachLikedMap and 1 or 0.35
	end

	local isTest = self._style == AirWorkShopEnum.CalculateStyle.Test

	self._txtAgain.text = isTest and lang("tip_air_workshop_calculate_btntest") or lang("tip_air_workshop_calculate_btnfight")

	goutil.setActive(self._successPanel, false)
	goutil.setActive(self._failedPanel, false)
	goutil.setActive(self._btnListPanel, true)
	goutil.setActive(self._testPanel, isTest)
	goutil.setActive(self._downBtnPanel, not isTest)
	goutil.setActive(self._freePanel, self._style == AirWorkShopEnum.CalculateStyle.Free)
	goutil.setActive(self._scorePanel, self._style == AirWorkShopEnum.CalculateStyle.Competitive)
end

function M:_handleOnCommentMap(e)
	self._resultData.level.commented = true
	self._resultData.level.commentNum = self._resultData.level.commentNum + 1
	self._txtMessageCount.text = self._resultData.level.commentNum
end

function M:_handleLike(e, mapId, isLike)
	return
end

function M:_tryLikedMap()
	if self._cachLikedMap == nil then
		return
	end

	if self._style ~= AirWorkShopEnum.CalculateStyle.Test and self._cachLikedMap ~= self._resultData.level.liked then
		local mapId = self._resultData.level.mapId
		local liked = self._cachLikedMap

		AirWorkShopAtkAgent.instance:sendLikeRequest(mapId, liked)
	end
end

function M:_onClickEditFlag()
	local mapId = self._resultData.level.mapId
	local tagIds = self._resultData.level.tags

	ToolTipsMgr.showAirWorkShopBattleCalculateTagView(mapId, tagIds)
end

function M:_onClickMessage()
	local hideEditBtn = false
	local editBtnInteractable = not self._resultData.level.commented

	ToolTipsMgr.showAirWorkShopMessageLogTipsView(self._resultData.level.mapId, self._resultData.level.cover, hideEditBtn, editBtnInteractable)
end

function M:_onClickLike()
	self._cachLikedMap = not self._cachLikedMap
	self._canvasGroupLiked.alpha = self._cachLikedMap and 1 or 0.35

	local likeCount = self._resultData.level.likeNum

	if self._resultData.level.liked then
		likeCount = self._cachLikedMap and self._resultData.level.likeNum or self._resultData.level.likeNum - 1
	else
		likeCount = self._cachLikedMap and self._resultData.level.likeNum + 1 or self._resultData.level.likeNum
	end

	self._txtLikeCount.text = likeCount
end

function M:_onClickRecord()
	local params = {}

	params.mapId = self._resultData.level.mapId
	params.showTabCount = 1

	ViewMgr.instance:open(ViewName.AirWorkShopStatisticView, params)
end

function M:_onClickAgain()
	if self._style == AirWorkShopEnum.CalculateStyle.Test then
		AirWorkBattleResultController.instance:clearResultData()
		self:close()
		BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.CALCULATE)
	else
		self:_onClickClose()
	end
end

function M:_onClickExit()
	if self._isPlayingAni then
		return
	end

	self:close()
	BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
end

function M:_onClickClose()
	if self._isPlayingAni then
		return
	end

	self:close()
	BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
end

return M
