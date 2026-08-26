-- chunkname: @modules/logic/partygame/view/guesswho/GuessWhoGameView.lua

module("modules.logic.partygame.view.guesswho.GuessWhoGameView", package.seeall)

local GuessWhoGameView = class("GuessWhoGameView", PartyGameCommonView)

function GuessWhoGameView:onInitView()
	GuessWhoGameView.super.onInitView(self)

	self._simageQuestion = gohelper.findChildSingleImage(self.viewGO, "centerContent/#simage_Question")
	self._goStart = gohelper.findChild(self.viewGO, "Tips/#go_Start")
	self._goSuccess = gohelper.findChild(self.viewGO, "Tips/#go_Success")
	self._goFail = gohelper.findChild(self.viewGO, "Tips/#go_Fail")
	self._goHeadItem = gohelper.findChild(self.viewGO, "#go_HeadItem")
	self._goAnswerItem = gohelper.findChild(self.viewGO, "#go_AnswerItem")
	self._goPlayers = gohelper.findChild(self.viewGO, "#go_Players")
	self._goGrid1 = gohelper.findChild(self.viewGO, "#go_Grid1")
	self._goGrid2 = gohelper.findChild(self.viewGO, "#go_Grid2")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self.animCurtain = gohelper.findChildAnim(self.viewGO, "centerContent")
	self.animStart = gohelper.findChildAnim(self.viewGO, "Tips/#go_Start")
	self.animSuccess = gohelper.findChildAnim(self.viewGO, "Tips/#go_Success")
	self.animFail = gohelper.findChildAnim(self.viewGO, "Tips/#go_Fail")
	self.imageTrs = self._simageQuestion.transform
end

function GuessWhoGameView:onDestroy()
	TaskDispatcher.cancelTask(self.hideStartTip, self)
	TaskDispatcher.cancelTask(self.hideResultTip, self)
end

function GuessWhoGameView:onCreateCompData()
	self.GameInterface = PartyGameCSDefine.GuessWhoGameInterface
	self.maxRound = self.GameInterface.GetMaxRound()
	self.playerMoList = PartyGameModel.instance:getCurGamePlayerList()
	self.mainPlayerIndex = self.GameInterface.GetMainPlayerIndex()
	self.partyGameCountDownData = {
		getCountDownFunc = self.getCountDownFunc,
		context = self
	}
end

function GuessWhoGameView:onCreate()
	self.operateCntMap = {}
	self.answerItems = {}
	self.headItemMap = {}

	for i = 1, 16 do
		local go = gohelper.cloneInPlace(self._goAnswerItem)
		local answerItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, GuessWhoAnswerItem)

		answerItem:setCallback(self.onClickAnswerItem, self, i)

		self.answerItems[i] = answerItem
	end

	for i = 1, #self.playerMoList do
		local playerMo = self.playerMoList[i]

		self.operateCntMap[playerMo.index] = self.GameInterface.GetOperateCount(playerMo.index)

		local go = gohelper.cloneInPlace(self._goHeadItem)
		local headItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyGamePlayerHead)

		headItem:setData({
			isAutoShowArrow = true,
			uid = playerMo.uid
		})

		self.headItemMap[playerMo.index] = headItem
	end

	gohelper.setActive(self._simageQuestion, false)
end

function GuessWhoGameView:onViewUpdate()
	local curStep = self.GameInterface.GetCurStep()

	if self.curStep ~= curStep then
		self:onStateChange(curStep)
	end

	if self.canOperate then
		for i = 1, #self.playerMoList do
			local playerMo = self.playerMoList[i]
			local playerIndex = playerMo.index
			local operateCnt = self.GameInterface.GetOperateCount(playerIndex)

			if self.operateCntMap[playerIndex] ~= operateCnt then
				local selectIndex = self.GameInterface.GetAnswerIndex(playerIndex)

				if playerMo:isMainPlayer() then
					self.selectIndex = selectIndex

					for k, item in ipairs(self.answerItems) do
						item:setSelect(k == self.selectIndex)
					end
				end

				if selectIndex ~= 0 then
					local headItem = self.headItemMap[playerIndex]

					self.answerItems[selectIndex]:addHeadItem(headItem.viewGO)
				end

				self.operateCntMap[playerIndex] = operateCnt
			end
		end
	end
end

function GuessWhoGameView:onStateChange(step)
	self.curStep = step

	if step == GuessWhoEnum.GameState.Ready then
		local curRound = self.GameInterface.GetCurRound()

		if self.curRound ~= curRound then
			if self.curRound then
				self:onSettleExit()
			end

			self.partyGameRoundTip:setRoundData(curRound, self.maxRound)

			self.selectIndex = 0
			self.options = self.GameInterface.GetOptions()
			self.optionCnt = self.options.Length
			self.correctIndex = self.GameInterface.GetCorrectIndex()

			local optionId = self.options[self.correctIndex - 1]
			local config = lua_partygame_guesswho_pictures.configDict[optionId]

			if config then
				local anchorX = PartyGameHelper.instance:getSingleComponentData("PartyGame.Runtime.Games.GuessWho.Component.GuessWhoDataComponent", "posX")
				local anchorY = PartyGameHelper.instance:getSingleComponentData("PartyGame.Runtime.Games.GuessWho.Component.GuessWhoDataComponent", "posY")

				recthelper.setAnchor(self.imageTrs, anchorX, anchorY)

				local flip = PartyGameHelper.instance:getSingleComponentData("PartyGame.Runtime.Games.GuessWho.Component.GuessWhoDataComponent", "flip")
				local rotationY = flip and 180 or 0

				transformhelper.setEulerAngles(self.imageTrs, 0, rotationY, 0)
				self._simageQuestion:LoadImage(ResUrl.getPropItemIcon(config.resource))
				gohelper.setActive(self._simageQuestion, true)
			end

			self:refreshAnswerItem()
		end

		self.curRound = curRound
	elseif step == GuessWhoEnum.GameState.Answer then
		self.partyGameRoundTip:setIsShow(false)
		self.animCurtain:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame17.play_ui_bulaochun_curtain_pull)
		self.animStart:Play("in", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame17.play_ui_activity_dog_page)
		TaskDispatcher.runDelay(self.hideStartTip, self, 2)
	elseif step == GuessWhoEnum.GameState.Settle then
		self:onSettleEnter()
	end

	self.canOperate = step == GuessWhoEnum.GameState.Answer
end

function GuessWhoGameView:onClickAnswerItem(index)
	if self.selectIndex == index then
		return
	end

	if self.canOperate then
		self.GameInterface.SetAnswerIndex(index)
	end
end

function GuessWhoGameView:refreshAnswerItem()
	if self.optionCnt == 12 then
		if not self._goGrid2 then
			local parentGo = self._goGrid1

			for i = 1, 16 do
				local answerItem = self.answerItems[i]

				if i <= self.optionCnt then
					local optionId = self.options[i - 1]

					gohelper.setParent(answerItem.go, parentGo)

					local config = lua_partygame_guesswho_pictures.configDict[optionId]

					if config then
						answerItem:setIcon(config.resource)
					end
				end

				gohelper.setActive(answerItem.go, i <= self.optionCnt)
			end
		end
	end
end

function GuessWhoGameView:getCountDownFunc()
	if self.curStep == GuessWhoEnum.GameState.Answer then
		return self.GameInterface.GetStepLeftTime()
	end
end

function GuessWhoGameView:onSettleEnter()
	for _, item in pairs(self.headItemMap) do
		gohelper.setActive(item.viewGO, false)
	end

	local items = self._playerInfoComp:getPlayerItems()

	for _, v in ipairs(items) do
		local value = self.GameInterface.GetPlayerScoreAdd(v._mo.index)

		v:playScoreAdd(value)
	end

	local answerCorrect = self.selectIndex == self.correctIndex
	local answerItem = self.answerItems[self.selectIndex]

	if answerItem then
		answerItem:setSelect(false)

		if answerCorrect then
			answerItem:setCorrect(true)
		else
			answerItem:setError(true)
		end
	end

	if answerCorrect then
		self.animSuccess:Play("in", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame17.play_ui_tangren_store_upgrade)
	else
		self.animFail:Play("in", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame17.play_ui_fuleyuan_tiaoyitiao_fail)
	end

	TaskDispatcher.runDelay(self.hideResultTip, self, 2)
	self.animCurtain:Play("close", 0, 0)
end

function GuessWhoGameView:hideStartTip()
	self.animStart:Play("out", 0, 0)
end

function GuessWhoGameView:hideResultTip()
	if self.selectIndex == self.correctIndex then
		self.animSuccess:Play("out", 0, 0)
	else
		self.animFail:Play("out", 0, 0)
	end
end

function GuessWhoGameView:onSettleExit()
	local answerItem = self.answerItems[self.selectIndex]

	if answerItem then
		if self.selectIndex == self.correctIndex then
			answerItem:setCorrect(false)
		else
			answerItem:setError(false)
		end
	end
end

return GuessWhoGameView
