-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoMainView.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoMainView", package.seeall)

local M = class("AirWorkShopRodeoMainView", ViewComponent)

M.PosType = {
	Top = 1,
	Mid = 2,
	Down = 3
}

function M:buildUI()
	self._btnRecord = self:getBtn("sports_mode_view_720578399")
	self._goRedPointRecord = self:getGo("sports_mode_view_-1277791088")
	self._btnReward = self:getBtn("sports_mode_view_1418266234")
	self._btnRank = self:getBtn("sports_mode_view_1149925731")
	self._btnShowInfo = self:getBtn("sports_mode_view_-1297673229")
	self._goBtnShowDown = self:getGo("sports_mode_view_-584629284")
	self._goBtnShowUp = self:getGo("sports_mode_view_-819523176")
	self._txtInfoRanking = self:getText("sports_mode_view_-149975335")
	self._canvasGropInfo = self:getUIComponent("sports_mode_view_-536466153", ComponentType.CanvasGroup)
	self._infoComps = {
		[M.PosType.Top] = {
			go = self:getGo("sports_mode_view_1915276224"),
			goStatus = self:getGo("sports_mode_view_-159436041"),
			txtScore = self:getText("sports_mode_view_-47158823"),
			imgLv1 = self:getImage("sports_mode_view_266452625"),
			imgLv2 = self:getImage("sports_mode_view_368494646"),
			txtStateRoot = self:getText("sports_mode_view_1625642763"),
			goStateUp = self:getGo("sports_mode_view_1626276198"),
			goStateKeep = self:getGo("sports_mode_view_1209318224"),
			goStateDown = self:getGo("sports_mode_view_-1508861863"),
			slider = self:getUIComponent("sports_mode_view_210181617", UIComponentType.Slider),
			goSliderNodeLight = self:getGo("sports_mode_view_-1936797239"),
			goRank = self:getGo("sports_mode_view_105144069"),
			imgRankMaskIcon = self:getImage("sports_mode_view_1920703309"),
			txtPlayerName = self:getText("sports_mode_view_-1348822625"),
			txtPlayerScore = self:getText("sports_mode_view_1078628219")
		},
		[M.PosType.Mid] = {
			go = self:getGo("sports_mode_view_544576179"),
			goStatus = self:getGo("sports_mode_view_1642187068"),
			txtScore = self:getText("sports_mode_view_-1669375333"),
			imgLv1 = self:getImage("sports_mode_view_2011476267"),
			imgLv2 = self:getImage("sports_mode_view_-982081961"),
			txtStateRoot = self:getText("sports_mode_view_174887838"),
			goStateUp = self:getGo("sports_mode_view_-1655565832"),
			goStateKeep = self:getGo("sports_mode_view_1993841988"),
			goStateDown = self:getGo("sports_mode_view_948467456"),
			slider = self:getUIComponent("sports_mode_view_881874594", UIComponentType.Slider),
			goSliderNodeLight = self:getGo("sports_mode_view_-2026577016")
		},
		[M.PosType.Down] = {
			go = self:getGo("sports_mode_view_1583621067"),
			goStatus = self:getGo("sports_mode_view_1647257636"),
			txtScore = self:getText("sports_mode_view_89994069"),
			imgLv1 = self:getImage("sports_mode_view_-1926220450"),
			imgLv2 = self:getImage("sports_mode_view_-1277683940"),
			txtStateRoot = self:getText("sports_mode_view_-1471367026"),
			goStateUp = self:getGo("sports_mode_view_1374107199"),
			goStateKeep = self:getGo("sports_mode_view_1904916480"),
			goStateDown = self:getGo("sports_mode_view_1613720319"),
			slider = self:getUIComponent("sports_mode_view_-1022514808", UIComponentType.Slider),
			goSliderNodeLight = self:getGo("sports_mode_view_-1728847067")
		}
	}
	self._btnTopPlayerMask = self:getBtn("sports_mode_view_-639465879")
	self._goLvMid1Bg = self:getGo("sports_mode_view_-800022925")
	self._imgLvMid1 = self:getImage("sports_mode_view_1658412424")
	self._imgLvMid2 = self:getImage("sports_mode_view_1943983057")
	self._imgLvMid2Bg = self:getImage("sports_mode_view_829382858")
	self._txtCurScore = self:getText("sports_mode_view_1652025261")
	self._txtCurLvState = self:getText("sports_mode_view_-1228816306")
	self._goLvStateUp = self:getGo("sports_mode_view_1318411621")
	self._goLvStateKeep = self:getGo("sports_mode_view_1705504")
	self._goLvStateDown = self:getGo("sports_mode_view_-696494132")
	self._txtLvMidNickName = self:getUIComponent("sports_mode_view_2003595275", UIComponentType.Text)
	self._goRootFirstTry = self:getGo("sports_mode_view_-1614996001")
	self._btnFight = self:getBtnByPath("objRight/state_first_try/btnStartCheck")
	self._costCellShot = PrefabReferenceUtil.createCurrencyCostLuaCell(goutil.findChild(self.mainGO, "objRight/state_first_try/com_price").gameObject)

	self._costCellShot:updateData(CommEnum.CurrencyCodeEnum.AirStudioChallengeNum, 1)

	self._goRootContinue = self:getGo("sports_mode_view_1951309575")
	self._txtRoundProgress = self:getText("sports_mode_view_-2119893182")
	self._txtMaxScore = self:getText("sports_mode_view_-1723483406")
	self._btnFightAgain = self:getBtnByPath("objRight/state_continue/btnCheckAgain")
	self._rectTrRewardRoot = self:getUIComponent("sports_mode_view_1759941326", UIComponentType.RectTransform)

	goutil.setActive(self._rectTrRewardRoot:GetChild(0).gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnRecord:AddClickListener(self._onClickRecord, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
	self._btnFightAgain:AddClickListener(self._onClickFightAgain, self)
	self._btnShowInfo:AddClickListener(self._onClickShowInfo, self)
	self._btnTopPlayerMask:AddClickListener(self._onClickTopPlayerMask, self)
end

function M:unbindEvents()
	self._btnRecord:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnFightAgain:RemoveClickListener()
	self._btnShowInfo:RemoveClickListener()
	self._btnTopPlayerMask:RemoveClickListener()
end

function M:onEnter(reasonType)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	self:setEvent(true)
	self:_refreshInfo()
	AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()

	if not AirWorkBattleResultController.instance:tryPushRodeFinishResultTips(self._tryGainRodeoSettleReward, self) then
		self:_tryGainRodeoSettleReward()
	end

	if self._viewPresentor:getIsBackOpen() then
		self:_updateShowInfoStatus()
	else
		goutil.setActive(self._canvasGropInfo.gameObject, true)
		self:_updateShowInfoStatus(true)
	end
end

function M:_tryGainRodeoSettleReward()
	AirWorkShopUtil.TryGainRodeoSettleReward()
end

function M:onExit(reasonType)
	self:setEvent(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
end

function M:onExitFinished()
	for _, cell in pairs(self._winItemCell or {}) do
		goutil.destroy(cell:getGo())
	end

	self._winItemCell = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	end
end

function M:_handleOnRodeoInfoChange(e)
	self:_refreshInfo()
end

function M:_onClickRecord()
	ToolTipsMgr.showAirWorkShopRodeoCheckRecordTips()
end

function M:_onClickReward()
	ToolTipsMgr.showAirWorkShopRodeoRewardTips()
end

function M:_onClickRank()
	ToolTipsMgr.showAirWorkShopRodeoRankTips()
end

function M:_onClickShowInfo()
	local orgState = self._canvasGropInfo.gameObject.activeSelf
	local show = not orgState

	goutil.setActive(self._canvasGropInfo.gameObject, show)
	self:_updateShowInfoStatus(show)
end

function M:_onClickTopPlayerMask()
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local firstRankNO = info and info:getFirstRankNO() or false

	if firstRankNO then
		local bindGo = self._btnTopPlayerMask.gameObject
		local uid = firstRankNO.userId
		local playerLv = firstRankNO.playerLv
		local portrait = firstRankNO.portrait
		local nickName = firstRankNO.nickname

		ToolTipsMgr.showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
	end
end

function M:_updateShowInfoStatus(show)
	if show == nil then
		show = self._canvasGropInfo.gameObject.activeSelf
	end

	goutil.setActive(self._goBtnShowDown, not show)
	goutil.setActive(self._goBtnShowUp, show)
end

function M:_onClickFight()
	printWarn("<color=#C2C507>空气工坊-挑战模式-开始新挑战</color>")

	if not self:_checkCanMatch() then
		return
	end

	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_air_rodeo_start_tip"))

	dialog:setConfirmListener(function()
		local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

		if info:getChallengeNum() <= 0 then
			ToolTipsMgr.showCharacterTopToast(lang("tip_air_rodeo_challenge_num_not_enough"), CommEnum.CharacterTopToastIcon.Fail, 1)
		else
			ViewMgr.instance:open(ViewName.AirWorkShopRodeoLevelSelectView)
		end
	end, self)
end

function M:_onClickFightAgain()
	printWarn("<color=#C2C507>空气工坊-挑战模式-继续上次挑战</color>")

	if not self:_checkCanMatch() then
		return
	end

	ViewMgr.instance:open(ViewName.AirWorkShopRodeoLevelSelectView)
end

function M:_checkCanMatch()
	if AirWorkShopUtil.getInRodeoCalculateTime() then
		FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))

		return false
	end

	if AirWorkShopUtil.TryGainRodeoSettleReward() then
		return false
	end

	return true
end

function M:_refreshInfo()
	local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
		printWarn(info:getStatusMsg())
	end

	local curLv = minLv
	local lvState = AirWorkShopEnum.LvState.KEEP
	local defeatPosition = 0
	local maxScoreOfWeek = 0
	local score = 0
	local round = 0
	local maxRound = 0
	local mapLst = {}
	local isWin

	if info then
		curLv = info:getLv()
		lvState = info:getState()
		defeatPosition = info:getPosition()
		maxScoreOfWeek = info:getMaxOfWeek()
		score = info:getScore()
		round = info:getRound()
		maxRound = info:getMaxRound()
		mapLst = info:getMapLst() or {}
		isWin = info:getIsWin()
	end

	local mapCount = #mapLst
	local maxScoreShow = math.max(score, maxScoreOfWeek)

	self._txtInfoRanking.text = string.format("%s%%", AirWorkShopUtil.formatPassRatio(defeatPosition * 100, 1))

	AirWorkShopUtil.rodeoLvImgChange(curLv, self._imgLvMid1, self._imgLvMid2, self._goLvMid1Bg, self._imgLvMid2Bg)

	self._txtLvMidNickName.text = AirWorkShopUtil.getRodeoLvGradeNickName(curLv)
	self._txtCurScore.text = maxScoreOfWeek
	self._txtCurLvState.text = AirWorkShopUtil.getRodeoLvStateName(lvState)

	goutil.setActive(self._goLvStateUp, AirWorkShopEnum.LvStateNum[lvState] > 0)
	goutil.setActive(self._goLvStateKeep, AirWorkShopEnum.LvStateNum[lvState] == 0)
	goutil.setActive(self._goLvStateDown, AirWorkShopEnum.LvStateNum[lvState] < 0)

	local isFirst = round <= 0
	local isContinue = true

	if isContinue then
		self._txtMaxScore.text = string.format("%s%s", score, AirWorkShopEnum.RodeoScoreSuffix)

		local showRound = isWin == true and round + 1 or round - 1

		self._txtRoundProgress.text = langF("tip_air_rodeo_round_progress", showRound, AirWorkShopEnum.RodeoMaxRound)

		goutil.setActive(self._txtRoundProgress.gameObject, showRound >= 0)

		local rewardLst = AirWorkShopChallengeModel.instance:getContinueWinRewardLst(curLv)

		while self._rectTrRewardRoot.childCount < #rewardLst + 1 do
			goutil.cloneAndSetParent(self._rectTrRewardRoot:GetChild(0).gameObject, self._rectTrRewardRoot)
		end

		if not self._winItemCell then
			self._winItemCell = {}
		end

		for i = 1, self._rectTrRewardRoot.childCount - 1 do
			local itemGo = self._rectTrRewardRoot:GetChild(i).gameObject
			local data = rewardLst[i]

			if data then
				local itemCell = Astral.SimpleLuaComponentContainer.Add(itemGo, ItemCell)

				itemCell:updateData(data.itemDataShow)
				itemCell:setShowSelectedEffect(false)
				itemCell:getComponent("num"):setCostText(langF("tip_air_consecutive_victories", data.winCount))
				itemCell:getComponent("num"):setCostTextActive(true)
				goutil.setActive(itemCell:findUIElement("backpack_item_1042455870"), maxRound >= data.winCount)

				self._winItemCell[data.winCount] = itemCell
			end

			goutil.setActive(itemGo, data)
		end
	end

	goutil.setActive(self._goRootFirstTry, isFirst)
	goutil.setActive(self._txtRoundProgress.gameObject, not isFirst)
	goutil.setActive(self._btnFightAgain.gameObject, not isFirst)
	goutil.setActive(self._goRootContinue, isContinue)
	self:_refreshSliderInfo()
end

function M:_refreshSliderInfo()
	local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local firstRankIsMe = info:getFirstRankIsMe()
	local curLv = info and info:getLv() or minLv
	local lvState = info and info:getState() or AirWorkShopEnum.LvState.KEEP
	local lvStateNum = AirWorkShopEnum.LvStateNum[lvState]
	local posLv = {}
	local topShowLv = curLv == minLv and curLv + 2 or curLv + 1

	if lvStateNum > 1 then
		topShowLv = curLv + 3
	end

	if maxLv < topShowLv then
		posLv = {
			[M.PosType.Top] = {
				firskRank = true
			},
			[M.PosType.Mid] = {
				lv = maxLv
			},
			[M.PosType.Down] = {
				lv = maxLv - 1
			}
		}
	else
		posLv = {
			[M.PosType.Top] = {
				lv = topShowLv
			},
			[M.PosType.Mid] = {
				lv = topShowLv - 1
			},
			[M.PosType.Down] = {
				lv = topShowLv - 2
			}
		}
	end

	if Astral.OSDef.isEditor then
		printWarn(string.format("当前curLv[%s],lvState为[%s],lvStateNum[%s]", curLv, lvState, lvStateNum))
		TableUtil.dump(posLv)
	end

	for posType, data in ipairs(posLv) do
		local showLv = data.lv
		local firstRank = data.firskRank

		self:_refreshInfoComps(self._infoComps[posType], showLv, firstRank, firstRankIsMe)
	end
end

function M:_refreshInfoComps(comps, lv, isFirskRank, firstRankIsMe)
	goutil.setActive(comps.goStatus, not isFirskRank)

	if comps.goRank then
		goutil.setActive(comps.goRank, isFirskRank)
	end

	local compsScore = 1
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()
	local curLv = info:getLv()

	if isFirskRank then
		compsScore = info:getFirstScore()

		if not comps.goRank then
			return
		end

		local firstRankNO = info:getFirstRankNO()

		comps.txtPlayerName.text = firstRankNO and firstRankNO.nickname or ""
		comps.txtPlayerScore.text = compsScore

		local portraitCO = BackpackConfig.instance:getItemInfoByItemId(firstRankNO and firstRankNO.portrait or 0)

		if portraitCO then
			IconLoader.setSprite(comps.imgRankMaskIcon, IconType.PlayerInfoMask, portraitCO.icon)
		end
	else
		compsScore = info:getPredictScore(lv)

		local lvState = info and info:getState() or AirWorkShopEnum.LvState.KEEP
		local lvStateNum = AirWorkShopEnum.LvStateNum[lvState]

		comps.txtScore.text = compsScore > 0 and string.format("%s%s", compsScore, AirWorkShopEnum.RodeoScoreSuffix) or "--"

		AirWorkShopUtil.rodeoLvImgChange(lv, comps.imgLv1, comps.imgLv2)

		local isCur = curLv + lvStateNum == lv

		goutil.setActive(comps.txtStateRoot.gameObject, isCur)

		if isCur then
			comps.txtStateRoot.text = lvStateNum == 0 and "" or lvStateNum

			goutil.setActive(comps.goStateUp, lvStateNum > 0)
			goutil.setActive(comps.goStateKeep, lvStateNum == 0)
			goutil.setActive(comps.goStateDown, lvStateNum < 0)
		end
	end

	local curScore = info and info:getMaxOfWeek() or 0
	local progress = 0
	local showNodeLight = curScore > 0 and compsScore > 0 and compsScore <= curScore

	if curScore > 0 then
		if isFirskRank then
			progress = compsScore <= curScore and 1 or 0

			if firstRankIsMe then
				progress = 0
			end
		elseif lv == maxLv then
			local nextScore = info:getFirstScore()
			local range = nextScore - compsScore

			progress = range > 0 and (curScore - compsScore) / range or 1

			if firstRankIsMe then
				progress = 1
			end
		elseif curLv < lv and lv - curLv >= 3 then
			if compsScore > 0 then
				progress = compsScore <= curScore and 1 or 0
			else
				progress = 0
			end

			if firstRankIsMe then
				progress = 1
			end
		else
			local nextScore = info:getPredictScore(lv + 1)

			if nextScore > 0 then
				if nextScore <= curScore then
					progress = 1
				else
					local range = nextScore - compsScore

					progress = range > 0 and (curScore - compsScore) / range or 0
				end
			else
				progress = 0
			end

			if firstRankIsMe then
				progress = 1
			end
		end
	end

	progress = progress > 1 and 1 or progress
	progress = progress < 0 and 0 or progress
	comps.slider.value = progress

	goutil.setActive(comps.goSliderNodeLight, firstRankIsMe or showNodeLight)
end

function M:_getScore()
	return
end

return M
