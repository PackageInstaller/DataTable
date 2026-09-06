-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBattleSettlementView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBattleSettlementView", package.seeall)

local SummerTreasureSnatchBattleSettlementView = class("SummerTreasureSnatchBattleSettlementView", ViewComponent)

function SummerTreasureSnatchBattleSettlementView:ctor()
	SummerTreasureSnatchBattleSettlementView.super.ctor(self)
end

function SummerTreasureSnatchBattleSettlementView:buildUI()
	SummerTreasureSnatchBattleSettlementView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._players = self:getGo("players")
	self._twoForms = self:getGo("twoForms")
	self._win = self:getGo("win")
	self._fail = self:getGo("fail")
	self._txtScore = self:getTxt("txtScore")
	self._result = self:getGo("result")
	self._imgItem = self:getGo("result/txt/imgItem")
	self._txtGetScore = self:getTxt("result/txt/txtGetScore")
end

function SummerTreasureSnatchBattleSettlementView:bindEvents()
	SummerTreasureSnatchBattleSettlementView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function SummerTreasureSnatchBattleSettlementView:unbindEvents()
	SummerTreasureSnatchBattleSettlementView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummerTreasureSnatchBattleSettlementView:onEnter()
	SummerTreasureSnatchBattleSettlementView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	if not params[2] then
		local playerInfo1 = {}

		if not params[3] then
			local playerInfo2 = {}

			if not params[4] then
				local formList = {}
				local oldScore = checknumber(params[5])
				local newScore = checknumber(params[6])

				self._pointHeads = {}

				GameUtil.updateCells(self._players, {
					playerInfo1,
					playerInfo2
				}, self._updateOnePlayer, self)
				GameUtil.updateCells(self._twoForms, formList, self._updateOneForms, self, true)

				local leftScore, rightScore = 0, 0
				local actCfg = SummerTreasureSnatchConfig.instance:getActivityCfg(self._activityId)
				local matType, matId, matNum = MaterialMgr.getMatParams(actCfg.scoreMatStr)

				for _, formInfo in ipairs(formList) do
					if formInfo.isChallengerWin then
						leftScore = leftScore + 1
					else
						rightScore = rightScore + 1
					end
				end

				local winPrizeCfg = SummerTreasureSnatchConfig.instance:getWinPrizeCfg(self._activityId, leftScore)

				self._txtScore.text = string.format("%s  :  %s", leftScore, rightScore)

				if winPrizeCfg then
					self._txtGetScore.text = winPrizeCfg.score or 0
				end

				GameUtil.SetActive(self._win, rightScore < leftScore)
				GameUtil.SetActive(self._fail, leftScore <= rightScore)
				MaterialMgr.setIcon(self._imgItem, matType, matId, nil, nil)
			end
		end
	end
end

function SummerTreasureSnatchBattleSettlementView:onExit()
	SummerTreasureSnatchBattleSettlementView.super.onExit(self)

	for _, v in ipairs(self._pointHeads) do
		MaterialMgr.resetAll(v)
	end

	self._pointHeads = nil

	MaterialMgr.clearIcon(self._imgItem)
end

function SummerTreasureSnatchBattleSettlementView:_onClickClose()
	BattleController.instance:endBattle()
end

function SummerTreasureSnatchBattleSettlementView:_updateOnePlayer(cell, data)
	local pointHead = goutil.findChild(cell, "pointHead")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")

	if data.isMyInfo then
		HeadItemController.instance:setMyHeadCell(pointHead)

		txtUserName.text = data.userName
	elseif not data.headInfo then
		local headInfo = data.opHeadInfo

		HeadItemController.instance:setHeadCellByInfo(pointHead, headInfo)

		txtUserName.text = headInfo.userName
	end

	table.insert(self._pointHeads, pointHead)
end

function SummerTreasureSnatchBattleSettlementView:_updateOneForms(cell, data)
	local leftForm = goutil.findChild(cell, "leftForm")
	local rightForm = goutil.findChild(cell, "rightForm")

	self._isLeft = true

	self:_updateOneForm(leftForm, data.formId, data.challengePets, data.isChallengerWin, data.challengeZdl)

	self._isLeft = false

	self:_updateOneForm(rightForm, data.formId, data.beChallengePets, not data.isChallengerWin, data.beChallengeZdl)

	local imgResult = goutil.findChildComponent(cell, "imgResult", ComponentType.UIImageSpriteChange)
	local btnVideo = goutil.findChild(cell, "btnVideo")

	GameUtil.SetActive(btnVideo, false)
	imgResult:SetState(data.isChallengerWin and 0 or 1)
end

function SummerTreasureSnatchBattleSettlementView:_updateOneForm(cell, formId, petDatas, isWin, power)
	local txtTotalForce = goutil.findChildTextComponent(cell, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(cell, "txtTeam")
	local pets = goutil.findChild(cell, "formations")
	local txtWin = goutil.findChild(cell, "txtWin")
	local txtFail = goutil.findChild(cell, "txtFail")

	goutil.setActive(txtWin, isWin)
	goutil.setActive(txtFail, not isWin)

	txtTeam.text = "队伍" .. formId
	txtTotalForce.text = power

	GameUtil.updateCells(pets, petDatas, self._updateOnePet, self)
end

function SummerTreasureSnatchBattleSettlementView:_updateOnePet(cell, data)
	local txtForce = goutil.findChildTextComponent(cell, "force/txtForce")
	local pointPet = goutil.findChild(cell, "pointPet")

	MaterialMgr.resetAll(pointPet)

	txtForce.text = "0"

	if data then
		local proxy = data.petMo and MaterialMgr.setCellByData(MatType.Pet, data.petMo, pointPet) or MaterialMgr.setCell(MatType.Pet, data.raceId, pointPet)

		table.insert(self._pointHeads, pointPet)

		if proxy then
			proxy.binder:setClickCallBack(function()
				if data.petMo then
					CommonTipsMgr.instance:showPetTips(data.petMo)
				else
					CommonTipsMgr.instance:showPetTips(data)
				end
			end)
			proxy.binder:setLvl(data.level)

			local awakenLv = checknumber(data.awakeLevel)

			if awakenLv == 0 then
				awakenLv = checknumber(data.awakenLevel)
			end

			proxy.binder:setStars(awakenLv)
			proxy.binder:setIconDirection(self._isLeft)
		end
	end
end

return SummerTreasureSnatchBattleSettlementView
