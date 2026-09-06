-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameResultView.lua

module("logic.extensions.landlords.view.FalGameResultView", package.seeall)

local FalGameResultView = class("FalGameResultView", ViewComponent)

function FalGameResultView:buildUI()
	FalGameResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnDetail = goutil.findChild(self.mainGO, "btnDetail")

	local resultScrollerview = goutil.findChild(self.mainGO, "resultCol/resultScrollerview")
	local resultScrollercell = goutil.findChild(self.mainGO, "resultCol/resultScrollercell")

	self._resultScrollList = ScrollerList.create(resultScrollerview, resultScrollercell, GameUtil.handler(self._updateResultCell, self), GameUtil.handler(self._clearResultCell, self))
end

function FalGameResultView:bindEvents()
	FalGameResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickBtnDetail, self)
end

function FalGameResultView:unbindEvents()
	FalGameResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDetail)
end

function FalGameResultView:onEnter()
	FalGameResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._isInBattle = params[1] == true
	self._activityId = FightAgainstLandlordsController.instance:getFalGameMo():getActivityId()
	self._battleResultMsg = FightAgainstLandlordsModel.instance:getBattleResultMsg()

	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKGetSimpleRecordRes(self._battleResultMsg)
	print(string.format("test+ --> activityId=%s, battleId=%s", self._activityId, self._battleId))

	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()

	GameUtil.SetActive(self._btnShare, false)
	GameUtil.SetActive(self._btnDetail, self._isInBattle)
	self:_onUpdateResultColUI()
end

function FalGameResultView:onExit()
	FalGameResultView.super.onExit(self)
	self._resultScrollList:dispose()
end

function FalGameResultView:_onUpdateResultColUI()
	self._recordMo = FightAgainstLandlordsModel.instance:getRecordMoInSimpleRecord()

	local userIdList = self._recordMo:getUesrIdList()

	self._resultScrollList:reloadData(userIdList)
end

function FalGameResultView:_updateResultCell(view, cell, userId, tag)
	local mainGo = cell.gameObject
	local headIcon = goutil.findChild(mainGo, "headIcon")
	local tag = goutil.findChild(mainGo, "tag")
	local txtTag = goutil.findChildTextComponent(mainGo, "tag/txt")
	local select = goutil.findChild(mainGo, "select")
	local txtGold_1 = goutil.findChildTextComponent(mainGo, "gold_1/txtGold")
	local txtPet = goutil.findChildTextComponent(mainGo, "txtPet")
	local txtPetMe = goutil.findChildTextComponent(mainGo, "txtPetMe")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local lostGainCon = goutil.findChild(mainGo, "lostGainCon")

	HeadItemController.instance:setHeadCellByInfo(headIcon, self._recordMo:getHeadInfo(userId))

	txtName.text = self._recordMo:getUserName(userId)

	local tagIdx = 0

	if self._recordMo:getIdentity(userId) == GameEnum.FalIdentity.Landlord then
		tagIdx = 0
		txtTag.text = FightAgainstLandlordsConfig.instance:getFalCommonValue("LANDLORD_NAME")
	else
		tagIdx = 1
		txtTag.text = FightAgainstLandlordsConfig.instance:getFalCommonValue("FRAMER_NAME")
	end

	GameUtil.setUIImageColorIdx(tag, tagIdx)

	local isMe = userId == self._myUserId

	GameUtil.SetActive(select, isMe)

	local petTxt = string.format("存活精灵：%s", self:_getLeftPetNum(userId))

	if isMe then
		txtPet.text = ""
		txtPetMe.text = petTxt
	else
		txtPet.text = petTxt
		txtPetMe.text = ""
	end

	local goldValue = self._recordMo:getGoldValueA(userId)

	txtGold_1.text = goldValue

	local isWin = self._recordMo:isWin(userId)
	local baseCfg = FightAgainstLandlordsConfig.instance:getFalBaseData(self._activityId)
	local num = 0

	if isWin then
		local coin_exchange_rate = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("COIN_EXCHANGE_RATE"))

		num = goldValue * coin_exchange_rate
	else
		num = isMe and (FightAgainstLandlordsModel.instance:isCanGainLostPrize() and baseCfg.loseNum or 0) or baseCfg.loseNum
	end

	MaterialMgr.resetAll(lostGainCon)

	num = math.floor(num)

	if num > 0 then
		local prizes = string.split(baseCfg.prize, "#")
		local newPrizes = {}

		for i, v in ipairs(prizes) do
			local matType, matId, matNum = MaterialMgr.getMatParams(v)
			local p = string.format("%s:%s:%s", matType, matId, num * matNum)

			table.insert(newPrizes, p)
		end

		local cfgStr = table.concat(newPrizes, "#")

		MaterialMgr.setCellListByCfg(cfgStr, lostGainCon)
	end
end

function FalGameResultView:_clearResultCell(cell)
	local mainGo = cell.gameObject
	local headIcon = goutil.findChild(mainGo, "headIcon")
	local lostGainCon = goutil.findChild(mainGo, "lostGainCon")

	HeadItemController.instance:resetHeadCell(headIcon)
	MaterialMgr.resetAll(lostGainCon)
end

function FalGameResultView:_onClickBtnClose()
	if self._isInBattle then
		BattleController.instance:endBattle()
	else
		self:close()
	end
end

function FalGameResultView:_onClickBtnDetail()
	UIStateManager.instance:push(ViewName.BattleStatics)
end

function FalGameResultView:_getLeftPetNum(userId)
	for i, v in ipairs(self._battleResultMsg.leftPetItems) do
		if checknumber(v.userId) == checknumber(userId) then
			return v.leftPetNum
		end
	end
end

return FalGameResultView
