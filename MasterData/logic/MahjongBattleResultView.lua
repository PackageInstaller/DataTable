-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleResultView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleResultView", package.seeall)

local MahjongBattleResultView = class("MahjongBattleResultView", ViewComponent)

function MahjongBattleResultView:ctor()
	MahjongBattleResultView.super.ctor(self)
end

function MahjongBattleResultView:unbindEvents()
	MahjongBattleResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnclose)
	GameUtil.rmClickHandler(self._btnStatics)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnVideo)
end

function MahjongBattleResultView:bindEvents()
	MahjongBattleResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnclose, self._OnClickClose, self)
	GameUtil.addClickHandler(self._btnStatics, self._onClickStatics, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
	GameUtil.addClickHandler(self._btnVideo, self._onClickVideo, self)
end

function MahjongBattleResultView:buildUI()
	MahjongBattleResultView.super.buildUI(self)

	self._btnclose = self:getGo("btnclose")
	self._pet = self:getGo("pet")

	local goTabPet = self:getGo("pet/tableviewpet")
	local goCellPet = self:getGo("pet/tablecellpet")

	self._tableviewPet = ScrollerList.create(goTabPet, goCellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._btnStatics = self:getGo("pet/btnStatics")
	self._win = self:getGo("win")

	local goTabWin = self:getGo("win/tableviewwin")
	local goCellWin = self:getGo("win/tablecellwin")

	self._tableviewWin = ScrollerList.create(goTabWin, goCellWin, GameUtil.handler(self._updateCellWin, self), GameUtil.handler(self._clearCellWin, self))
	self._hp = self:getGo("hp")

	local goTabHp = self:getGo("hp/tableviewhp")
	local goCellHp = self:getGo("hp/tablecellhp")

	self._tableviewHp = ScrollerList.create(goTabHp, goCellHp, GameUtil.handler(self._updateCellHp, self), GameUtil.handler(self._clearCellHp, self))
	self._score = self:getGo("score")
	self._txtScore = self:getTxt("score/txtScore")
	self._btnRule = self:getGo("score/btnRule")
	self._result_1 = self:getGo("result/result_1")
	self._result_2 = self:getGo("result/result_2")
	self._result_3 = self:getGo("result/result_3")
	self._handsCon = self:getGo("hands")
	self._txtTeamName = self:getTxt("pet/txtTeamName")
	self._goBuff = self:getGo("pet/buff")
	self._picBuff = self:getGo("pet/buff/icon/pic")
	self._txtBuff = self:getTxt("pet/buff/txt")
	self._btnVideo = self:getGo("pet/btnVideo")
	self._btnShare = self:getGo("hands/btnShare")
	self._cardcell = self:getGo("hands/cardlist/cardcell")
	self._conCardlist = self:getGo("hands/cardlist")
	self._cardCellList = {}

	goutil.setActive(self._cardcell, false)

	self._empty = self:getGo("hands/empty")
	self._addtips = self:getGo("hands/addtips")
	self._txtAddtips = self:getTxt("hands/addtips/txt")
end

function MahjongBattleResultView:onExit()
	MahjongBattleResultView.super.onExit(self)
	self._tableviewWin:dispose()
	self._tableviewHp:dispose()
	self._tableviewPet:dispose()
	uGuiUtil.clearImage(self._picBuff)
end

function MahjongBattleResultView:onEnter()
	MahjongBattleResultView.super.onEnter(self)

	local lastFightResult = MahjongBattleModel.instance:getLastFightResult()

	if lastFightResult == nil then
		self:_OnClickClose()

		return
	end

	local activityId = lastFightResult.activityId

	self:_updateUIByCfg(activityId)
	self:_updateUIByInfo(lastFightResult)
	MahjongBattleController.instance:setIsPlayVideo(false)
end

function MahjongBattleResultView:_updateUIByCfg(activityId)
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
end

function MahjongBattleResultView:_updateUIByInfo(info)
	self._totalScore = 0
	self._curRound = 0
	self._curWinTimes = 0
	self._curDecBloodNum = 0
	self._petMoList = {}
	self._isWin = false
	self._baseScore = 0
	self._boundScore = 0
	self._curHp = 0
	self._curWinTimes = 0
	self._curResult = 0
	self._curBuffId = 0
	self._activityId = 0
	self._curSummonType = 0

	if info then
		self._totalScore = info.totalScore or 0

		local challengeInfo = info.challengeInfo
		local activityId = info.activityId

		self._activityId = activityId

		if not challengeInfo.creepsInfos then
			self._curRound = challengeInfo.curRound or 0
			self._curDecBloodNum = challengeInfo.decBloodNum or 0

			for _, creepsInfo in ipairs(challengeInfo.creepsInfos) do
				local petMo = MahjongBattleModel.instance:getPetMo(activityId, creepsInfo.creepsId, creepsInfo.awakenLevel)

				if petMo then
					table.insert(self._petMoList, petMo)
				end
			end

			self._isWin = info.isWin
			self._curHp = self._maxHp - self._curDecBloodNum
			self._curWinTimes = self._curRound - self._curDecBloodNum

			if not challengeInfo.cardTypeToNum then
				local cardTypeToNums = {}

				for _, typeInfo in ipairs(cardTypeToNums) do
					local cardType = typeInfo.left
					local num = typeInfo.right
					local summonTypeCfg = MahjongBattleConfig.instance:getSummonTypeCfgById(activityId, cardType)

					if summonTypeCfg then
						self._boundScore = self._boundScore + summonTypeCfg.bonusScore * num
					end
				end

				self._baseScore = MahjongBattleConfig.instance:getScoreByWinNum(self._curWinTimes or 0)
				self._curBuffId = challengeInfo.selectSummonBuff or 0

				local saveChallengeInfo = MahjongBattleModel.instance:getCurChallengeInfoByActId(activityId)

				if saveChallengeInfo then
					self._curSummonType = saveChallengeInfo.summonType or 0
				end
			end
		end
	end

	if self._curBuffId > 0 then
		local buffCfg = MahjongBattleConfig.instance:getSummonBuffCfgById(self._activityId, self._curBuffId)

		if buffCfg then
			goutil.setActive(self._goBuff, true)

			self._txtBuff.text = buffCfg.desc

			local spriteName = GameUrl.getIconUrl(buffCfg.buffIcon)

			uGuiUtil.setSpriteToImage(self._picBuff, nil, spriteName)
		else
			goutil.setActive(self._goBuff, false)
		end
	else
		goutil.setActive(self._goBuff, false)
	end

	self._tableviewWin:reloadData(self._winTimesArr)
	self._tableviewHp:reloadData(self._hpArr)
	self._tableviewPet:reloadData(self._petMoList)
	goutil.setActive(self._score, false)
	goutil.setActive(self._result_1, false)
	goutil.setActive(self._result_2, false)
	goutil.setActive(self._result_3, false)
	goutil.setActive(self._handsCon, false)

	if self._curHp <= 0 or self._curWinTimes >= self._maxWinTimesInSameFight then
		self._curResult = 1
	elseif self._isWin then
		self._curResult = 2
	else
		self._curResult = 3

		goutil.setActive(self._result_3, true)
	end

	if self._curResult == 1 then
		goutil.setActive(self._result_1, true)
		goutil.setActive(self._score, true)

		local addScore = self._baseScore + self._boundScore

		self._txtScore.text = string.format("%s <color=#9dffb6>+ %s</color>", self._totalScore, addScore)
	elseif self._curResult == 2 then
		goutil.setActive(self._result_2, true)
		goutil.setActive(self._handsCon, true)
		UIJumper.instance:pushOneStack(ViewName.MahjongBattleGameView, true, self._activityId)
	elseif self._curResult == 3 then
		goutil.setActive(self._result_3, true)
		goutil.setActive(self._handsCon, true)
		UIJumper.instance:pushOneStack(ViewName.MahjongBattleGameView, true, self._activityId)
	end

	goutil.setActive(self._addtips, false)

	local summonCfg = MahjongBattleConfig.instance:getSummonTypeCfgById(self._activityId, self._curSummonType)

	if summonCfg and summonCfg.bonusScore > 0 then
		goutil.setActive(self._addtips, true)

		self._txtAddtips.text = string.format("%s\n乱斗积分+%s", summonCfg.name, summonCfg.bonusScore)
	end

	self:_updateCurCardList()
end

function MahjongBattleResultView:_updateCellWin(view, cell, data)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	goutil.setActive(goIcon, data <= self._curWinTimes)
end

function MahjongBattleResultView:_clearCellWin(cell)
	return
end

function MahjongBattleResultView:_updateCellHp(view, cell, data)
	local go = cell.gameObject
	local heart = goutil.findChild(go, "heart")

	goutil.setActive(heart, data <= self._curHp)
end

function MahjongBattleResultView:_clearCellHp(cell)
	return
end

function MahjongBattleResultView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local pet = goutil.findChild(go, "pet")
	local proxy = MaterialMgr.setCellByMo(data, pet)

	if proxy then
		proxy.binder:setAutoTips(false)

		if data.awakenLv and data.awakenLv > 0 then
			proxy.binder:showStarByCustom(data.awakenLv)
		end

		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end
end

function MahjongBattleResultView:_clearCellPet(cell)
	local go = cell.gameObject
	local pet = goutil.findChild(go, "pet")

	MaterialMgr.resetAll(pet)
end

function MahjongBattleResultView:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function MahjongBattleResultView:_onClickRule()
	local content = string.format("收益说明：\n胜场数积分：%s\n胡牌积分：%s", self._baseScore, self._boundScore)

	CommonTipsMgr.instance:showTextTips(content, self._btnRule.gameObject)
end

function MahjongBattleResultView:_OnClickClose()
	BattleController.instance:endBattle()
	self:close()
end

function MahjongBattleResultView:_onClickShare()
	local hideObjs = {
		self._btnShare
	}

	ShareController.instance:share(21, hideObjs, nil, 0, function()
		MahjongBattleAgent.instance:sendPM_MahjongBattleShareBattleResultReq(self._activityId)
	end)
end

function MahjongBattleResultView:_onClickVideo()
	self:close()
	MahjongBattleController.instance:setIsPlayVideo(true)
	BattleController.instance:endBattle()
end

function MahjongBattleResultView:_updateCurCardList()
	local cardIds = MahjongBattleModel.instance:getCurSummonOperaMahjongIds(self._activityId) or {}

	for _, cell in pairs(self._cardCellList) do
		goutil.setActive(cell.go, false)
	end

	for index, cardId in ipairs(cardIds) do
		local cell = self._cardCellList[index]

		if not cell then
			cell = {
				go = goutil.cloneAndSetParent(self._cardcell, self._conCardlist.transform)
			}
			cell.picChanger = goutil.findChildComponent(cell.go, "card/showpic", "UIImageSpriteChange")
			self._cardCellList[index] = cell
		end

		local mahjongData = MahjongBattleController.instance:convertMahjongIdToData(self._activityId, cardId)

		if mahjongData then
			local showPic = mahjongData:getExtraParam("showPic") or ""

			if showPic ~= "" then
				cell.picChanger:ChangeSprite(showPic)
			end

			goutil.setActive(cell.go, true)
		else
			goutil.setActive(cell.go, false)
		end
	end

	local totalWidth = #cardIds * 70
	local handStartPosX = -totalWidth / 2 + 35

	GameUtil.setAnchoredPos(self._conCardlist, handStartPosX, -257)
	goutil.setActive(self._empty, #cardIds == 0)
end

return MahjongBattleResultView
