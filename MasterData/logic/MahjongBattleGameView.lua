-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleGameView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleGameView", package.seeall)

local MahjongBattleGameView = class("MahjongBattleGameView", ViewComponent)

function MahjongBattleGameView:ctor()
	MahjongBattleGameView.super.ctor(self)

	self._allowStateMap = {
		[MahjongBattleModel.PLAYER_STATE.WAITING_DRAW_MAHJONG] = true,
		[MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG] = true,
		[MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG] = true,
		[MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION] = true
	}
	self._curState = nil
end

function MahjongBattleGameView:unbindEvents()
	MahjongBattleGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShowMore)
	GameUtil.rmClickHandler(self._btnPicRule)
	GameUtil.rmClickHandler(self._btnDeck)
	GameUtil.rmClickHandler(self._btnDrop)
	GameUtil.rmClickHandler(self._btnHu)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnTipsPeng)
	GameUtil.rmClickHandler(self._btnTipsChi)
	GameUtil.rmClickHandler(self._btnTipsGang)
	GameUtil.rmClickHandler(self._btnTipsHu)

	for i, cell in ipairs(self._drawcardList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function MahjongBattleGameView:bindEvents()
	MahjongBattleGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickBtnHide, self)
	GameUtil.addClickHandler(self._btnShowMore, self._onClickBtnShowMore, self)
	GameUtil.addClickHandler(self._btnPicRule, self._onClickBtnPicRule, self)
	GameUtil.addClickHandler(self._btnDeck, self._onClickBtnDeck, self)
	GameUtil.addClickHandler(self._btnDrop, self._onClickBtnDrop, self)
	GameUtil.addClickHandler(self._btnHu, self._onClickBtnHu, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
	GameUtil.addClickHandler(self._btnSummon, self._onClickBtnSummon, self)
	GameUtil.addClickHandler(self._btnTipsPeng, self._onClickBtnTipsPeng, self)
	GameUtil.addClickHandler(self._btnTipsChi, self._onClickBtnTipsChi, self)
	GameUtil.addClickHandler(self._btnTipsGang, self._onClickBtnTipsGang, self)
	GameUtil.addClickHandler(self._btnTipsHu, self._onClickBtnTipsHu, self)

	for i, cell in ipairs(self._drawcardList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickDrawMJs, self, cell), self)
	end
end

function MahjongBattleGameView:buildUI()
	MahjongBattleGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local goTabHp = self:getGo("top/hp/tableview")
	local goCellHp = self:getGo("top/hp/tablecell")

	self._tableviewHp = ScrollerList.create(goTabHp, goCellHp, GameUtil.handler(self._updateCellHp, self), GameUtil.handler(self._clearCellHp, self))

	local goTabWin = self:getGo("top/win/tableview")
	local goCellWin = self:getGo("top/win/tablecell")

	self._tableviewWin = ScrollerList.create(goTabWin, goCellWin, GameUtil.handler(self._updateCellWin, self), GameUtil.handler(self._clearCellWin, self))
	self._btnShowMore = self:getGo("bottom/bg/btnShowMore")
	self._bottombgCon = self:getGo("bottom/bg")
	self._bottombg = self:getGo("bottom/bg/bottombg")

	local goTabPet = self:getGo("bottom/pet/tablecell")

	self._goTableviewPet = self:getGo("bottom/pet/tableview")
	self._tableviewPet = ScrollerList.create(self._goTableviewPet, goTabPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._btnPicRule = self:getGo("topRight/btnPicRule")
	self._btnDeck = self:getGo("topRight/btnDeck")
	self._txtNumDeck = self:getTxt("topRight/btnDeck/txtNum")
	self._btnDrop = self:getGo("right/btnDrop")
	self._btnHu = self:getGo("right/btnHu")
	self._btnMatch = self:getGo("right/btnMatch")
	self._btnSummon = self:getGo("right/btnSummon")
	self._conHandlist = self:getGo("handlist")
	self._handcell = self:getGo("handlist/handcell")

	goutil.setActive(self._handcell, false)

	self._handsList = {}
	self._conFuloulist = self:getGo("fuloulist")
	self._fuloucell = self:getGo("fuloulist/fuloucell")

	goutil.setActive(self._fuloucell, false)

	self._fulouList = {}
	self._conGangshow = self:getGo("gangshow")
	self._bgGang = self:getGo("gangshow/bg")
	self._gangList = {}

	for i = 1, 4 do
		local gangCell = {}

		gangCell.go = self:getGo("gangshow/gangList/gang_" .. i)

		local cardList = {}

		for j = 1, 4 do
			local pirChanger = goutil.findChildComponent(gangCell.go, "card_" .. j .. "/showpic", "UIImageSpriteChange")

			table.insert(cardList, pirChanger)
		end

		gangCell.cardList = cardList
		gangCell.data = nil

		table.insert(self._gangList, gangCell)
	end

	self._conDrawcardlist = self:getGo("drawcardlist")
	self._drawcardList = {}

	for i = 1, 3 do
		local cardCell = {}

		cardCell.go = self:getGo("drawcardlist/card" .. i)
		cardCell.picChanger = goutil.findChildComponent(cardCell.go, "card/showpic", "UIImageSpriteChange")
		cardCell.btn = goutil.findChild(cardCell.go, "btn")
		cardCell.tagChi = goutil.findChild(cardCell.go, "tags/tagChi")
		cardCell.tagPeng = goutil.findChild(cardCell.go, "tags/tagPeng")
		cardCell.tagGang = goutil.findChild(cardCell.go, "tags/tagGang")
		cardCell.tagHu = goutil.findChild(cardCell.go, "tags/tagHu")
		cardCell.data = nil

		table.insert(self._drawcardList, cardCell)
	end

	self._conTips = self:getGo("tips")
	self._btnTipsPeng = self:getGo("tips/btnTipsPeng")
	self._btnTipsChi = self:getGo("tips/btnTipsChi")
	self._btnTipsGang = self:getGo("tips/btnTipsGang")
	self._btnTipsHu = self:getGo("tips/btnTipsHu")
	self._txtTips = self:getTxt("txtTips")
	self._btnHide = self:getGo("btnHide")
	self._animNode1 = self:getGo("animNode1")
	self._animNode2 = self:getGo("animNode2")
	self._goAnimDraw = self:getResInstance(MahjongBattleGameViewPresentor.DrawAniSpine)

	goutil.addChildToParent(self._goAnimDraw, self._animNode1)

	self._goAnimDiHu = self:getResInstance(MahjongBattleGameViewPresentor.DiHuAniSpine)

	goutil.addChildToParent(self._goAnimDiHu, self._animNode2)
end

function MahjongBattleGameView:onExit()
	MahjongBattleGameView.super.onExit(self)
	self._tableviewHp:dispose()
	self._tableviewWin:dispose()
	self._tableviewPet:dispose()

	for k, cell in ipairs(self._handsList) do
		cell.data = nil

		goutil.setActive(cell.go, false)
		GameUtil.rmClickHandler(cell.card)
	end
end

function MahjongBattleGameView:onEnter()
	MahjongBattleGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleGetInfoRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleDrawMahjongRes, self._handleDrawMJ, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleGmCoverSystemCardRes, self._handleGmCoverSystemCard, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleSelectMahjongRes, self._handleSelectMJ, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleDropMahjongRes, self._handleDropMJ, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleGmCoverHandRes, self._handleGmCoverHand, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleNotifyDrawMahjong, self._handleNotifyDrawMJ, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleSummonRes, self._handleSummonMJ, self)
	self.addGEvent(self, GlobalNotify.MahjongBattleTeachDataChange, self._handleChangeTeachStage, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	self._lastDarwCardIdList = nil
	self._lastFulouIdList = nil
	self._lastGangIdList = nil
	self._lastHandMjIdList = nil

	self:_resetCurSelectData()
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_switchBottomState(false)
	MahjongBattleController.instance:getInfo(self._activityId)
	goutil.setActive(self._animNode1, false)
	goutil.setActive(self._animNode2, false)
end

function MahjongBattleGameView:onEnterFinished()
	MahjongBattleGameView.super.onEnterFinished(self)

	if MahjongBattleController.instance:getIsPlayVideo() then
		MahjongBattleController.instance:playVideo()
	end
end

function MahjongBattleGameView:_resetCurSelectData()
	self._curSelectCardCellMap = {}
	self._curSelectMjKey = nil
end

function MahjongBattleGameView:_updateState()
	local curState = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	if self._curState ~= curState then
		self:_resetCurSelectData()

		self._curState = curState
	end

	goutil.setActive(self._btnDrop, false)
	goutil.setActive(self._btnHu, false)
	goutil.setActive(self._btnMatch, false)
	goutil.setActive(self._btnSummon, false)
	goutil.setActive(self._conDrawcardlist, false)
	goutil.setActive(self._conHandlist, false)
	goutil.setActive(self._conTips, false)
	goutil.setActive(self._conFuloulist, false)

	self._txtTips.text = ""

	if self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_DRAW_MAHJONG then
		-- block empty
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG then
		goutil.setActive(self._conDrawcardlist, true)
		goutil.setActive(self._conHandlist, true)
		goutil.setActive(self._conFuloulist, true)

		self._txtTips.text = lang("请摸一张牌")

		local curSummonType = MahjongBattleModel.instance:getCurSummonTypeByActId(self._activityId)

		if curSummonType == MahjongBattleModel.SUMMON_TYPE.GANGZI or curSummonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG or curSummonType == MahjongBattleModel.SUMMON_TYPE.SILIANGGANG or curSummonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG then
			self._txtTips.text = lang("请继续摸一张牌")
		end
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		self._txtTips.text = lang("请弃一张牌")

		goutil.setActive(self._btnDrop, true)
		goutil.setActive(self._conHandlist, true)
		goutil.setActive(self._conFuloulist, true)
		goutil.setActive(self._btnHu, self:_isGanHu())

		if self:_isGanHu() then
			self._txtTips.text = lang("您已胡牌！")
		end

		if self:_isCanGang() then
			goutil.setActive(self._btnSummon, true)
			self:_onClickBtnTipsGang()
		end
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		self._txtTips.text = lang("请您尽快匹配！")

		goutil.setActive(self._btnMatch, true)
		goutil.setActive(self._conHandlist, true)
		goutil.setActive(self._conFuloulist, true)

		if self:_isCanPeng() then
			self:_onClickBtnTipsPeng()
			goutil.setActive(self._btnSummon, true)

			self._txtTips.text = ""
		elseif self:_isCanChi() then
			self:_onClickBtnTipsChi()
			goutil.setActive(self._btnSummon, true)

			self._txtTips.text = ""
		end
	end
end

function MahjongBattleGameView:_updateUIByInfo()
	self._curHp = 0
	self._curWinTimes = 0

	local decBloodNum = 0
	local curRoundNum = 0

	if MahjongBattleController.instance:getIsTeachMode() then
		-- block empty
	else
		local baseInfo = MahjongBattleModel.instance:getBaseInfoByActId(self._activityId)

		if baseInfo then
			local challengeInfo = baseInfo.challengeInfo

			if challengeInfo then
				decBloodNum = checknumber(challengeInfo.decBloodNum) or 0
				curRoundNum = checknumber(challengeInfo.curRound) or 0
			end
		end
	end

	self._curPetMoList = MahjongBattleModel.instance:getCurPetMoListByActId(self._activityId) or {}
	self._curHp = math.max(self._maxHp - decBloodNum, 0)
	self._curWinTimes = curRoundNum - decBloodNum

	self:_updateUITopPart()
	self:_refreshHandMJs()
	self:_refreshFulouMJs()
	self:_refreshHandMJsPos()
	self:_refreshGangMJs()
	self:_refreshGangMJsPos()
	self:_refreshDrawcardMJs()
	self:_refreshDrawcardMJTags()
	self:_refreshHintButton()
	self:_updateState()
end

function MahjongBattleGameView:_updateUIByCfg()
	self._actCfg = MahjongBattleConfig.instance:getActivityCfg(self._activityId)
	self._maxWinTimesInSameFight = MahjongBattleConfig.instance:getCommonValueToNumber("END_NEED_WIN_TIMES")
	self._winTimesArr = {}

	for i = 1, self._maxWinTimesInSameFight do
		table.insert(self._winTimesArr, i)
	end

	self._maxHp = MahjongBattleConfig.instance:getCommonValueToNumber("ORIGIN_BLOOD")
	self._hpArr = {}

	for i = 1, self._maxHp do
		table.insert(self._hpArr, i)
	end

	self._mahjongCfgs = MahjongBattleConfig.instance:getMahjongCfgs(self._activityId) or {}
	self._maxDrawcardNum = #self._mahjongCfgs * 4
end

function MahjongBattleGameView:_switchBottomState(isShow)
	self._isBottomShow = isShow

	goutil.setActive(self._goTableviewPet, isShow)
	goutil.setActive(self._btnHide, isShow)

	if isShow then
		self:_updateCurPetTableview()
		table.clear(self._curSelectCardCellMap)
		self:_refreshHandSelectState()
	end

	local posY = isShow and 90 or 0
	local bgHight = isShow and 230 or 160

	GameUtil.setAnchoredPos(self._bottombgCon, 0, posY)
	GameUtil.setHeight(self._bottombg, bgHight)
end

function MahjongBattleGameView:_updateUITopPart()
	self._tableviewHp:reloadData(self._hpArr)
	self._tableviewWin:reloadData(self._winTimesArr)
	self._tableviewWin:setCenterMode(true)
end

function MahjongBattleGameView:_updateCurPetTableview()
	self._tableviewPet:reloadData(self._curPetMoList)
end

function MahjongBattleGameView:_checkAndSelectList(list)
	local isMatch = true
	local curSelectMjDataMap = {}
	local curSelectCount = 0

	for cell, isSelect in pairs(self._curSelectCardCellMap) do
		if cell.data and isSelect then
			curSelectMjDataMap[cell.data] = true
			curSelectCount = curSelectCount + 1
		end
	end

	if curSelectCount == #list then
		for _, mjData in ipairs(list) do
			if not curSelectMjDataMap[mjData] then
				isMatch = false

				break
			end
		end
	else
		isMatch = false
	end

	if not isMatch then
		local tipMjDataMap = {}

		for _, tipMjData in ipairs(list) do
			tipMjDataMap[tipMjData] = true
		end

		table.clear(self._curSelectCardCellMap)

		for k, cell in ipairs(self._handsList) do
			local handMjData = cell.data

			if handMjData and tipMjDataMap[handMjData] then
				self._curSelectCardCellMap[cell] = true
			end
		end

		self:_refreshHandSelectState()
	end

	return isMatch
end

function MahjongBattleGameView:_refreshAfterCallback(opts)
	opts = opts or {}

	if opts.clearSelect then
		table.clear(self._curSelectCardCellMap)
	end

	if opts.refreshHand then
		self:_refreshHandMJs()
		self:_refreshFulouMJs()
		self:_refreshHandMJsPos()
		self:_refreshGangMJs()
		self:_refreshGangMJsPos()
	end

	if opts.refreshDrawcard then
		self:_refreshDrawcardMJs()
	end

	if opts.refreshDrawcardTags then
		self:_refreshDrawcardMJTags()
	end

	if opts.refreshHintButton then
		self:_refreshHintButton()
	end

	self:_updateState()
end

function MahjongBattleGameView:_closeAndContinueIfStateInvalid()
	if not self._allowStateMap[self._curState] then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)
	end
end

function MahjongBattleGameView:_handleGetInfo()
	self:_updateUIByInfo()

	if self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_DRAW_MAHJONG then
		MahjongBattleController.instance:drawMahjong(self._activityId)
	end

	if not self._allowStateMap[self._curState] then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)

		return
	end
end

function MahjongBattleGameView:_handleDrawMJ()
	self:_refreshAfterCallback({
		refreshDrawcard = true,
		refreshDrawcardTags = true,
		clearSelect = true
	})
end

function MahjongBattleGameView:_handleGmCoverSystemCard()
	self:_handleDrawMJ()
end

function MahjongBattleGameView:_handleSelectMJ()
	self:_refreshAfterCallback({
		refreshHintButton = true,
		clearSelect = true,
		refreshHand = true
	})
end

function MahjongBattleGameView:_handleDropMJ()
	self:_refreshAfterCallback({
		refreshHintButton = true,
		clearSelect = true,
		refreshHand = true
	})
	self:_closeAndContinueIfStateInvalid()
end

function MahjongBattleGameView:_handleGmCoverHand()
	self:_refreshAfterCallback({
		refreshHintButton = true,
		refreshDrawcardTags = true,
		clearSelect = true,
		refreshHand = true
	})
end

function MahjongBattleGameView:_handleNotifyDrawMJ()
	self:_refreshAfterCallback({
		refreshDrawcard = true,
		refreshDrawcardTags = true,
		refreshHintButton = true,
		clearSelect = true,
		refreshHand = true
	})
end

function MahjongBattleGameView:_handleSummonMJ()
	local function finishFunc()
		self:_refreshAfterCallback({
			refreshDrawcardTags = true,
			refreshHintButton = true,
			refreshHand = true
		})
		self:_closeAndContinueIfStateInvalid()
	end

	local curSummonType = MahjongBattleModel.instance:getCurSummonTypeByActId(self._activityId)

	if curSummonType == MahjongBattleModel.SUMMON_TYPE.DIHU then
		self:_playDiHuAnim(finishFunc)
	else
		finishFunc()
	end
end

function MahjongBattleGameView:_handleChangeTeachStage()
	local function finishFunc()
		self:_refreshAfterCallback({
			refreshDrawcard = true,
			refreshDrawcardTags = true,
			refreshHintButton = true,
			clearSelect = true,
			refreshHand = true
		})
		self:_closeAndContinueIfStateInvalid()
	end

	local curSummonType = MahjongBattleModel.instance:getCurSummonTypeByActId(self._activityId)

	if curSummonType == MahjongBattleModel.SUMMON_TYPE.DIHU then
		self:_playDiHuAnim(finishFunc)
	else
		finishFunc()
	end
end

function MahjongBattleGameView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MahjongBattleGameView:_onClickBtnShowMore()
	if self._isBottomShow then
		self:_switchBottomState(false)
	else
		self:_switchBottomState(true)
	end
end

function MahjongBattleGameView:_onClickBtnHide()
	self:_switchBottomState(false)
end

function MahjongBattleGameView:_onClickBtnPicRule()
	UIStateManager.instance:push(ViewName.MahjongBattlePicRuleView)
end

function MahjongBattleGameView:_onClickBtnDeck()
	UIStateManager.instance:push(ViewName.MahjongBattleDeskView, self._activityId)
end

function MahjongBattleGameView:_onClickBtnDrop()
	if MahjongBattleController.instance:getIsTeachMode() then
		return
	end

	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		FloatWordMgr.instance:show("当前状态不能丢牌")

		return
	end

	local curSelectMj

	for k, v in pairs(self._curSelectCardCellMap) do
		if v == true then
			if curSelectMj then
				FloatWordMgr.instance:show("只能选择一张牌进行丢弃")

				return
			end

			curSelectMj = k.data
		end
	end

	if curSelectMj then
		local mahjongId = curSelectMj:getExtraParam("mahjongId")

		if mahjongId then
			MahjongBattleController.instance:dropMahjong(self._activityId, mahjongId)
		end
	else
		FloatWordMgr.instance:show("先选择要丢弃的牌")
	end
end

function MahjongBattleGameView:_onClickBtnHu()
	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		FloatWordMgr.instance:show("当前状态不能胡牌")

		return
	end

	local isGanHu = self:_isGanHu()

	if not isGanHu then
		FloatWordMgr.instance:show("当前牌型不能胡牌")

		return
	end

	if MahjongBattleController.instance:getIsTeachMode() then
		MahjongBattleController.instance:enterNextTeachStage(self._activityId)

		return
	end

	local summonType = MahjongBattleModel.SUMMON_TYPE.PINGHU

	if MahjongBattleModel.instance:isQingYiSe(self._activityId) then
		summonType = MahjongBattleModel.SUMMON_TYPE.QINGYISE
	elseif MahjongBattleModel.instance:isDiHu(self._activityId) then
		summonType = MahjongBattleModel.SUMMON_TYPE.DIHU
	end

	local ids = {}

	for k, mjData in ipairs(self._curHandDataList) do
		local mahjongId = mjData:getExtraParam("mahjongId")

		if mahjongId then
			table.insert(ids, mahjongId)
		end
	end

	MahjongBattleController.instance:summon(self._activityId, summonType, ids)
end

function MahjongBattleGameView:_onClickBtnMatch()
	UIStateManager.instance:push(ViewName.MahjongBattleMatchView, self._activityId)
end

function MahjongBattleGameView:_onClickBtnSummon()
	if self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		self:_handleSummonHandInDropState()
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		self:_handleSummonHandInOperationState()
	else
		FloatWordMgr.instance:show("当前状态不能召唤")
	end
end

function MahjongBattleGameView:_handleSummonHandInDropState()
	local gangIdList = {}

	for cell, isSelect in pairs(self._curSelectCardCellMap) do
		if isSelect and cell.data then
			local mahjongId = cell.data:getExtraParam("mahjongId")

			if mahjongId then
				table.insert(gangIdList, mahjongId)
			end
		end
	end

	if #gangIdList ~= 4 then
		FloatWordMgr.instance:show("请选择杠牌进行召唤")

		return
	end

	local curSumType = MahjongBattleModel.SUMMON_TYPE.GANGZI
	local lastSummonType = MahjongBattleModel.instance:getCurSummonTypeByActId(self._activityId)

	if lastSummonType then
		if lastSummonType == MahjongBattleModel.SUMMON_TYPE.GANGZI then
			curSumType = MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG
		elseif lastSummonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG then
			curSumType = MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG
		elseif lastSummonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG then
			curSumType = MahjongBattleModel.SUMMON_TYPE.SILIANGGANG
		end
	end

	MahjongBattleController.instance:summon(self._activityId, curSumType, gangIdList)
end

function MahjongBattleGameView:_handleSummonHandInOperationState()
	local summonMJDataList = {}
	local summonMJIdList = {}

	for cell, isSelect in pairs(self._curSelectCardCellMap) do
		if isSelect and cell.data then
			table.insert(summonMJDataList, cell.data)

			local mahjongId = cell.data:getExtraParam("mahjongId")

			if mahjongId then
				table.insert(summonMJIdList, mahjongId)
			end
		end
	end

	if #summonMJDataList ~= 3 then
		FloatWordMgr.instance:show("请选择顺子或刻子进行召唤")

		return
	end

	local isShunzi = MahjongBattleGameController.instance:isShunZi(summonMJDataList)

	if isShunzi then
		MahjongBattleController.instance:summon(self._activityId, MahjongBattleModel.SUMMON_TYPE.SHUNZI, summonMJIdList)

		return
	end

	local isKeZi = MahjongBattleGameController.instance:isKeZi(summonMJDataList)

	if isKeZi then
		MahjongBattleController.instance:summon(self._activityId, MahjongBattleModel.SUMMON_TYPE.KEZI, summonMJIdList)

		return
	end

	FloatWordMgr.instance:show("请选择顺子或刻子进行召唤")
end

function MahjongBattleGameView:_onClickBtnTipsPeng()
	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		return
	end

	if not self._firstKeZiData then
		return
	end

	if self:_checkAndSelectList(self._firstKeZiData) then
		-- block empty
	end
end

function MahjongBattleGameView:_onClickBtnTipsChi()
	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		return
	end

	if not self._firstShunZiData then
		return
	end

	if self:_checkAndSelectList(self._firstShunZiData) then
		-- block empty
	end
end

function MahjongBattleGameView:_onClickBtnTipsGang()
	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		return
	end

	if not self._firstGangData then
		return
	end

	if self:_checkAndSelectList(self._firstGangData) then
		-- block empty
	end
end

function MahjongBattleGameView:_onClickBtnTipsHu()
	self:_onClickBtnHu()
end

function MahjongBattleGameView:_updateCellHp(view, cell, data)
	local go = cell.gameObject
	local heart = goutil.findChild(go, "heart")

	goutil.setActive(heart, data <= self._curHp)
end

function MahjongBattleGameView:_clearCellHp(cell)
	return
end

function MahjongBattleGameView:_updateCellWin(view, cell, data)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	goutil.setActive(goIcon, data <= self._curWinTimes)
end

function MahjongBattleGameView:_clearCellWin(cell)
	return
end

function MahjongBattleGameView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local pet = goutil.findChild(go, "pet")
	local proxy = MaterialMgr.setCellByMo(data, pet)

	if proxy then
		if data.awakenLv and data.awakenLv > 0 then
			proxy.binder:showStarByCustom(data.awakenLv)
		end

		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end
end

function MahjongBattleGameView:_clearCellPet(cell)
	return
end

function MahjongBattleGameView:_refreshDrawcardMJs()
	self._txtNumDeck.text = string.format("%d/%d", MahjongBattleModel.instance:getDeckRemainNum(self._activityId) or 0, self._maxDrawcardNum)

	local drawCardIdList = MahjongBattleModel.instance:getCurDrawnMahjongByActId(self._activityId) or {}

	self._lastDarwCardIdList = self._lastDarwCardIdList or {}

	local isSame = true

	if #drawCardIdList ~= #self._lastDarwCardIdList then
		isSame = false
	else
		for i, id in ipairs(drawCardIdList) do
			if id ~= self._lastDarwCardIdList[i] then
				isSame = false

				break
			end
		end
	end

	if isSame then
		return
	end

	self._lastDarwCardIdList = drawCardIdList

	for k, cell in ipairs(self._drawcardList) do
		self:_setDarwMJId(cell, nil)
	end

	if #drawCardIdList == 1 then
		self:_setDarwMJId(self._drawcardList[2], drawCardIdList[1])
	elseif #drawCardIdList == 2 then
		self:_setDarwMJId(self._drawcardList[1], drawCardIdList[1])
		self:_setDarwMJId(self._drawcardList[3], drawCardIdList[2])
	else
		for i, mahjongId in ipairs(drawCardIdList) do
			local cell = self._drawcardList[i]

			if cell then
				self:_setDarwMJId(cell, mahjongId)
			end
		end
	end
end

function MahjongBattleGameView:_refreshDrawcardMJTags()
	if not self._curHandDataList then
		return
	end

	for i, cell in ipairs(self._drawcardList) do
		local mjData = cell.data

		if mjData then
			local canChi = MahjongBattleGameController.instance:canFormShunZi(self._curHandDataList, mjData)
			local canPeng = MahjongBattleGameController.instance:canFormKeZi(self._curHandDataList, mjData)
			local canGang = MahjongBattleGameController.instance:canFormGang(self._curHandDataList, mjData)
			local canHu = MahjongBattleGameController.instance:canHu(self._curHandDataList, mjData, (#self._curHandDataList % 3 == 1 or nil) and 4 - (#self._curHandDataList - 1) / 3)

			goutil.setActive(cell.tagChi, canChi)
			goutil.setActive(cell.tagPeng, canPeng)
			goutil.setActive(cell.tagGang, canGang)
			goutil.setActive(cell.tagHu, canHu)
		else
			goutil.setActive(cell.tagChi, false)
			goutil.setActive(cell.tagPeng, false)
			goutil.setActive(cell.tagGang, false)
			goutil.setActive(cell.tagHu, false)
		end
	end
end

function MahjongBattleGameView:_setDarwMJId(drawCardCell, mahjongId)
	local mahjongId = checknumber(mahjongId)

	if drawCardCell then
		drawCardCell.data = mahjongId > 0 and MahjongBattleController.instance:convertMahjongIdToData(self._activityId, mahjongId) or nil

		if drawCardCell.data then
			local showPic = drawCardCell.data:getExtraParam("showPic") or ""

			if showPic ~= "" and drawCardCell.picChanger then
				drawCardCell.picChanger:ChangeSprite(showPic)
			end

			goutil.setActive(drawCardCell.go, true)
		else
			goutil.setActive(drawCardCell.go, false)
		end
	end
end

function MahjongBattleGameView:_onClickDrawMJs(drawCardCell)
	if drawCardCell and drawCardCell.data and self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG then
		local aniName = ""

		if GameUtil.GetActive(drawCardCell.tagHu) then
			aniName = "hu"
		elseif GameUtil.GetActive(drawCardCell.tagGang) then
			aniName = "gang"
		elseif GameUtil.GetActive(drawCardCell.tagPeng) then
			aniName = "peng"
		elseif GameUtil.GetActive(drawCardCell.tagChi) then
			aniName = "chi"
		end

		if aniName ~= "" then
			self:_playMoPaiAnim(nil, aniName)
		end

		local mahjongId = drawCardCell.data:getExtraParam("mahjongId")

		if mahjongId then
			if MahjongBattleController.instance:getIsTeachMode() then
				MahjongBattleController.instance:enterNextTeachStage(self._activityId)
			else
				MahjongBattleController.instance:selectMahjong(self._activityId, mahjongId)
			end
		end
	end
end

function MahjongBattleGameView:_refreshHandMJs()
	local handMjIdList = MahjongBattleModel.instance:getCurHandMahjongByActId(self._activityId) or {}

	self._lastHandMjIdList = self._lastHandMjIdList or {}

	local isSame = true

	if #handMjIdList ~= #self._lastHandMjIdList then
		isSame = false
	else
		for i, id in ipairs(handMjIdList) do
			if id ~= self._lastHandMjIdList[i] then
				isSame = false

				break
			end
		end
	end

	if isSame then
		return
	end

	self._lastHandMjIdList = handMjIdList

	table.sort(handMjIdList, function(a, b)
		return b < a
	end)

	self._curHandDataList = MahjongBattleController.instance:convertMahjongIdListToDataList(self._activityId, handMjIdList)

	for k, cell in ipairs(self._handsList) do
		cell.data = nil

		goutil.setActive(cell.go, false)
		GameUtil.rmClickHandler(cell.card)
	end

	for i, mahjongData in ipairs(self._curHandDataList) do
		local cell = self._handsList[i]

		if not cell then
			cell = self:_createHandCell()

			table.insert(self._handsList, cell)
		end

		self:_setHandMJData(cell, mahjongData)
	end

	self:_refreshHandSelectState()
end

function MahjongBattleGameView:_createHandCell()
	local cell = {}

	cell.data = nil
	cell.go = goutil.cloneAndSetParent(self._handcell, self._conHandlist.transform)
	cell.card = goutil.findChild(cell.go, "card")
	cell.picChanger = goutil.findChildComponent(cell.go, "card/showpic", "UIImageSpriteChange")

	return cell
end

function MahjongBattleGameView:_setHandMJData(handCell, mahjongData)
	if handCell and mahjongData then
		handCell.data = mahjongData

		local showPic = mahjongData:getExtraParam("showPic") or ""

		if showPic ~= "" and handCell.picChanger then
			handCell.picChanger:ChangeSprite(showPic)
		end

		goutil.setActive(handCell.go, true)
		GameUtil.addClickHandler(handCell.card, GameUtil.handler(self._onClickHandCell, self, handCell), self)
	end
end

function MahjongBattleGameView:_refreshHandMJsPos()
	self._curHandDataList = self._curHandDataList or {}

	local handCount = #self._curHandDataList
	local totalWidth = handCount * 87
	local handStartPosX = -totalWidth / 2 + 43.5
	local fuluIdCount = 0

	if self._lastFulouIdList and #self._lastFulouIdList > 0 then
		fuluIdCount = #self._lastFulouIdList
	end

	if fuluIdCount > 0 then
		local fuluTotalWidth = fuluIdCount * 80
		local fuluStartPosX = -fuluTotalWidth / 2 + 40 - totalWidth / 2 - 4

		GameUtil.setAnchoredPos(self._conFuloulist, fuluStartPosX, -255)

		handStartPosX = handStartPosX + fuluTotalWidth / 2 + 4
	end

	GameUtil.setAnchoredPos(self._conHandlist, handStartPosX, -255)
end

function MahjongBattleGameView:_refreshHandSelectState()
	for k, cell in ipairs(self._handsList) do
		local isSelect = self._curSelectCardCellMap[cell]
		local posY = isSelect and 20 or 0

		GameUtil.setAnchoredPos(cell.card, 0, posY)
	end
end

function MahjongBattleGameView:_onClickHandCell(handCell)
	local mjData = handCell and handCell.data

	if not mjData then
		return
	end

	if self._isBottomShow then
		return
	end

	if self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		self:_handleClickHandInDropState(handCell)
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		self:_handleClickHandInOperationState(handCell)
	else
		self:_refreshHandSelectState()
	end
end

function MahjongBattleGameView:_handleClickHandInDropState(handCell)
	local isSelect = self._curSelectCardCellMap[handCell]

	if isSelect then
		self._curSelectCardCellMap[handCell] = nil

		local isExist = false

		for k, v in pairs(self._curSelectCardCellMap) do
			if v then
				isExist = true

				break
			end
		end

		if not isExist then
			self._curSelectMjKey = nil
		end
	else
		local newKey = handCell.data:getUniqueKey()

		if self._curSelectMjKey ~= newKey then
			table.clear(self._curSelectCardCellMap)
		end

		self._curSelectCardCellMap[handCell] = true
		self._curSelectMjKey = newKey
	end

	self:_refreshHandSelectState()
end

function MahjongBattleGameView:_handleClickHandInOperationState(handCell)
	local isSelect = self._curSelectCardCellMap[handCell]

	self._curSelectCardCellMap[handCell] = not isSelect

	self:_refreshHandSelectState()
end

function MahjongBattleGameView:_refreshHintButton()
	self:_refreshHandMJsFirstFuluInfo()
	goutil.setActive(self._btnTipsChi, false)
	goutil.setActive(self._btnTipsPeng, false)
	goutil.setActive(self._btnTipsGang, false)
	goutil.setActive(self._btnTipsHu, false)

	if self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG then
		-- block empty
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		goutil.setActive(self._btnTipsGang, self._firstGangData ~= nil)
		goutil.setActive(self._btnTipsHu, self:_isGanHu())
	elseif self._curState == MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		goutil.setActive(self._btnTipsChi, self._firstShunZiData ~= nil)
		goutil.setActive(self._btnTipsPeng, self._firstKeZiData ~= nil)
	end
end

function MahjongBattleGameView:_refreshHandMJsFirstFuluInfo()
	self._curHandDataList = self._curHandDataList or {}
	self._firstKeZiData = MahjongBattleGameController.instance:findKeZiInList(self._curHandDataList)
	self._firstShunZiData = MahjongBattleGameController.instance:findShunZiInList(self._curHandDataList)
	self._firstGangData = MahjongBattleGameController.instance:findGangInList(self._curHandDataList)
end

function MahjongBattleGameView:_isGanHu()
	self._curHandDataList = self._curHandDataList or {}

	return (MahjongBattleGameController.instance:canHuWithFuluCount(self._curHandDataList, (#self._curHandDataList % 3 == 2 or nil) and 4 - (#self._curHandDataList - 2) / 3))
end

function MahjongBattleGameView:_isCanGang()
	self._curHandDataList = self._curHandDataList or {}

	return (MahjongBattleGameController.instance:findGangInList(self._curHandDataList))
end

function MahjongBattleGameView:_isCanPeng()
	self._curHandDataList = self._curHandDataList or {}

	return (MahjongBattleGameController.instance:findKeZiInList(self._curHandDataList))
end

function MahjongBattleGameView:_isCanChi()
	self._curHandDataList = self._curHandDataList or {}

	return (MahjongBattleGameController.instance:findShunZiInList(self._curHandDataList))
end

function MahjongBattleGameView:_refreshFulouMJs()
	local fulouList = MahjongBattleModel.instance:getCurSummonChiPengMJInfoByActId(self._activityId) or {}

	self._lastFulouIdList = {}

	for i, fulouInfo in ipairs(fulouList) do
		if not fulouInfo.summonMahjong then
			local summonMahjong = {}

			table.sort(summonMahjong, function(a, b)
				return b < a
			end)

			for k, v in pairs(summonMahjong) do
				table.insert(self._lastFulouIdList, checknumber(v))
			end
		end
	end

	for k, cell in ipairs(self._fulouList) do
		cell.data = nil

		goutil.setActive(cell.go, false)
	end

	for i, id in ipairs(self._lastFulouIdList) do
		local cell = self._fulouList[i]

		if not cell then
			cell = self:_createFulouCell()

			table.insert(self._fulouList, cell)
		end

		self:_setFulouMJId(cell, id)
	end
end

function MahjongBattleGameView:_createFulouCell()
	local cell = {}

	cell.data = nil
	cell.go = goutil.cloneAndSetParent(self._fuloucell, self._conFuloulist.transform)
	cell.card = goutil.findChild(cell.go, "card")
	cell.picChanger = goutil.findChildComponent(cell.go, "card/showpic", "UIImageSpriteChange")

	return cell
end

function MahjongBattleGameView:_setFulouMJId(fulouCell, mahjongId)
	local mahjongId = checknumber(mahjongId)

	if fulouCell then
		fulouCell.data = mahjongId > 0 and MahjongBattleController.instance:convertMahjongIdToData(self._activityId, mahjongId) or nil

		if fulouCell.data then
			local showPic = fulouCell.data:getExtraParam("showPic") or ""

			if showPic ~= "" and fulouCell.picChanger then
				fulouCell.picChanger:ChangeSprite(showPic)
			end

			goutil.setActive(fulouCell.go, true)
		else
			goutil.setActive(fulouCell.go, false)
		end
	end
end

function MahjongBattleGameView:_refreshGangMJs()
	local gangList = MahjongBattleModel.instance:getCurSummonGangMJInfoByActId(self._activityId) or {}
	local gangIdList = {}

	for i, gangInfo in ipairs(gangList) do
		if not gangInfo.summonMahjong then
			local summonMahjong = {}
			local gangId = checknumber(summonMahjong[1])

			if gangId > 0 then
				table.insert(gangIdList, gangId)
			end
		end
	end

	table.sort(gangIdList, function(a, b)
		return b < a
	end)

	self._lastGangIdList = self._lastGangIdList or {}

	local isSame = true

	if #gangIdList ~= #self._lastGangIdList then
		isSame = false
	else
		for i, id in ipairs(gangIdList) do
			if id ~= self._lastGangIdList[i] then
				isSame = false

				break
			end
		end
	end

	if isSame then
		return
	end

	self._lastGangIdList = gangIdList

	for k, cell in ipairs(self._gangList) do
		cell.data = nil

		goutil.setActive(cell.go, false)
	end

	for i, id in ipairs(gangIdList) do
		local cell = self._gangList[i]

		if cell then
			self:_setGangMJId(cell, id)
		end
	end
end

function MahjongBattleGameView:_setGangMJId(gangCell, mahjongId)
	local mahjongId = checknumber(mahjongId)

	if gangCell then
		gangCell.data = mahjongId > 0 and MahjongBattleController.instance:convertMahjongIdToData(self._activityId, mahjongId) or nil

		if gangCell.data then
			goutil.setActive(gangCell.go, true)

			if not gangCell.cardList then
				local cardList = {}
				local showPic = gangCell.data:getExtraParam("showPic") or ""

				if showPic ~= "" then
					for i, picChanger in ipairs(cardList) do
						if picChanger then
							picChanger:ChangeSprite(showPic)
						end
					end
				end
			end
		else
			goutil.setActive(gangCell.go, false)
		end
	end
end

function MahjongBattleGameView:_refreshGangMJsPos()
	self._lastGangIdList = self._lastGangIdList or {}

	local gangCount = #self._lastGangIdList

	if gangCount == 0 then
		goutil.setActive(self._conGangshow, false)

		return
	end

	goutil.setActive(self._conGangshow, true)

	local totalHeight = gangCount * 70 + 70
	local posY = -210 + 70 * gangCount

	GameUtil.setAnchoredPos(self._conGangshow, -505, posY)
	GameUtil.setHeight(self._bgGang, totalHeight)
end

function MahjongBattleGameView:_playDiHuAnim(finishFunc)
	if not self._goAnimDiHu then
		if finishFunc then
			GameUtil.callBack(finishFunc)
		end

		return
	end

	goutil.setActive(self._animNode2, true)
	RoleObjectPool.instance:playAnimation(self._goAnimDiHu, "idle", false, function()
		goutil.setActive(self._animNode2, false)

		if finishFunc then
			GameUtil.callBack(finishFunc)
		end
	end, true)
end

function MahjongBattleGameView:_playMoPaiAnim(finishFunc, aniName)
	if not self._goAnimDraw then
		if finishFunc then
			GameUtil.callBack(finishFunc)
		end

		return
	end

	goutil.setActive(self._animNode1, true)
	RoleObjectPool.instance:playAnimation(self._goAnimDraw, aniName or "chi", false, function()
		goutil.setActive(self._animNode1, false)

		if finishFunc then
			GameUtil.callBack(finishFunc)
		end
	end, true)
end

return MahjongBattleGameView
