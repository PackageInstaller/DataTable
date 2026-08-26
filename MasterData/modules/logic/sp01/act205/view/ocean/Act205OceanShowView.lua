-- chunkname: @modules/logic/sp01/act205/view/ocean/Act205OceanShowView.lua

module("modules.logic.sp01.act205.view.ocean.Act205OceanShowView", package.seeall)

local Act205OceanShowView = class("Act205OceanShowView", BaseView)

function Act205OceanShowView:onInitView()
	self._txtneedPoints = gohelper.findChildText(self.viewGO, "#txt_needPoints")
	self._goDice1 = gohelper.findChild(self.viewGO, "#go_Dice1")
	self._goDice2 = gohelper.findChild(self.viewGO, "#go_Dice2")
	self._goDice3 = gohelper.findChild(self.viewGO, "#go_Dice3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205OceanShowView:addEvents()
	return
end

function Act205OceanShowView:removeEvents()
	return
end

Act205OceanShowView.rotationDict = {
	Vector3(90, 0, 0),
	Vector3(90, 90, 0),
	Vector3(90, 180, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	(Vector3(180, 0, 0))
}

function Act205OceanShowView:_onEscBtnClick()
	return
end

function Act205OceanShowView:_editableInitView()
	self.dictItemMap = self:getUserDataTb_()
	self._animPlayerView = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function Act205OceanShowView:onUpdateParam()
	return
end

function Act205OceanShowView:onOpen()
	self.activityId = Act205Enum.ActId
	self.gameType = Act205Enum.GameStageId.Ocean
	self.gameInfoMo = Act205Model.instance:getGameInfoMo(self.activityId, self.gameType)

	self:refreshUI()
	self:refreshDice()
	self._animPlayerView:Play("open", self.showDiceAnim, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_yun)
end

function Act205OceanShowView:refreshUI()
	local curSelectGoldId = Act205OceanModel.instance:getCurSelectGoldId()

	self.goldConfig = Act205Config.instance:getDiceGoalConfig(curSelectGoldId)
	self.goladRangeList = string.splitToNumber(self.goldConfig.goalRange, "#")
	self._txtneedPoints.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_ocean_needPoints"), self.goladRangeList[1], self.goladRangeList[2])
end

function Act205OceanShowView:refreshDice()
	local curSelectDiceIdList = Act205OceanModel.instance:getcurSelectDiceIdList()
	local winDiceConfig = Act205Config.instance:getWinDiceConfig()

	self.isHasWinDice = tabletool.indexOf(curSelectDiceIdList, winDiceConfig.id)
	self.randomDiceNumList = {}

	for index, diceId in ipairs(curSelectDiceIdList) do
		local diceItem = {}
		local path = self.viewContainer:getSetting().otherRes[1]

		diceItem.go = self:getResInst(path, self["_goDice" .. index], "diceItem" .. index)
		diceItem.anim = diceItem.go:GetComponent(gohelper.Type_Animator)
		diceItem.goNormal = gohelper.findChild(diceItem.go, "touzi_ani/go_normal")
		diceItem.goWin = gohelper.findChild(diceItem.go, "touzi_ani/go_win")

		if not self.isHasWinDice then
			diceItem.normalTxtDiceNumList = {}

			local diceConfig = Act205Config.instance:getDicePoolConfig(diceId)
			local dicePointList = string.splitToNumber(diceConfig.dicePoints, "#")

			for diceIndex, diceNum in ipairs(dicePointList) do
				diceItem.normalTxtDiceNumList[diceIndex] = gohelper.findChildText(diceItem.go, "touzi_ani/go_normal/" .. diceIndex .. "/txt_num")
				diceItem.normalTxtDiceNumList[diceIndex].text = diceNum
			end

			diceItem.randomIndex = math.random(#dicePointList)

			table.insert(self.randomDiceNumList, dicePointList[diceItem.randomIndex])
		else
			diceItem.randomIndex = math.random(6)
		end

		if self.isHasWinDice then
			diceItem.curDiceRoot = diceItem.goWin or diceItem.goNormal
		end

		gohelper.setActive(diceItem.goNormal, not self.isHasWinDice)
		gohelper.setActive(diceItem.goWin, self.isHasWinDice)
		gohelper.setActive(diceItem.go, false)

		self.dictItemMap[index] = diceItem
	end
end

function Act205OceanShowView:showDiceAnim()
	for index, diceItem in ipairs(self.dictItemMap) do
		gohelper.setActive(diceItem.go, true)
		diceItem.anim:Play("in", 0, 0)
		diceItem.anim:Update(0)

		local nowRotationX, nowRotationY, nowRotationZ = transformhelper.getLocalRotation(diceItem.curDiceRoot.transform)

		diceItem.rotateTweenId = ZProj.TweenHelper.DOLocalRotate(diceItem.curDiceRoot.transform, nowRotationX + math.random(100, 200), nowRotationY + math.random(100, 200), nowRotationZ + math.random(100, 200), 0.5, self._delayTweenRotate, self, diceItem, EaseType.Linear)
	end

	self.isWin = self:checkIsWin()

	TaskDispatcher.runDelay(self.playFinishAnim, self, 1.1)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_touzi)
end

function Act205OceanShowView:_delayTweenRotate(diceItem)
	local nowRotation = Act205OceanShowView.rotationDict[diceItem.randomIndex]

	if nowRotation then
		diceItem.rotateTweenId = ZProj.TweenHelper.DOLocalRotate(diceItem.curDiceRoot.transform, nowRotation.x, nowRotation.y, nowRotation.z, 0.2, nil, nil, nil, EaseType.Linear)
	end
end

function Act205OceanShowView:playFinishAnim()
	self._animPlayerView:Play(self.isWin and "finish2" or "finish1", self.sendGameFinish, self)
end

function Act205OceanShowView:sendGameFinish()
	local isGameOpen = Act205Model.instance:isGameStageOpen(self.gameType, true)

	if not isGameOpen then
		return
	end

	local curSaveFailTimes = string.nilorempty(self.gameInfoMo:getGameInfo()) and 0 or tonumber(self.gameInfoMo:getGameInfo())
	local saveFailTimesResult = self.isWin and 0 or curSaveFailTimes + 1

	if self.isWin then
		if not self.goldConfig.winRewardId then
			local rewardId = self.goldConfig.failRewardId
			local param = {}

			param.activityId = self.activityId
			param.gameType = self.gameType
			param.gameInfo = tostring(saveFailTimesResult)
			param.rewardId = rewardId

			Activity205Rpc.instance:sendAct205FinishGameRequest(param, self.openResultView, self)
		end
	end
end

function Act205OceanShowView:checkIsWin()
	if self.isHasWinDice then
		return true
	else
		local totalDiceNum = 0

		for _, diceNum in ipairs(self.randomDiceNumList) do
			totalDiceNum = totalDiceNum + diceNum
		end

		return totalDiceNum >= self.goladRangeList[1] and totalDiceNum <= self.goladRangeList[2]
	end
end

function Act205OceanShowView:openResultView()
	local viewParam = {}

	viewParam.isHasWinDice = self.isHasWinDice
	viewParam.randomDiceNumList = self.randomDiceNumList

	Act205Controller.instance:openOceanResultView(viewParam)
	Activity205Rpc.instance:sendAct205GetGameInfoRequest(Act205Enum.ActId)
	self:closeThis()
end

function Act205OceanShowView:onClose()
	Act205OceanModel.instance:cleanLocalSaveKey()
	TaskDispatcher.cancelTask(self.playFinishAnim, self)

	for index, diceItem in pairs(self.dictItemMap) do
		if diceItem.rotateTweenId then
			ZProj.TweenHelper.KillById(diceItem.rotateTweenId)

			diceItem.rotateTweenId = nil
		end
	end
end

function Act205OceanShowView:onDestroyView()
	return
end

return Act205OceanShowView
