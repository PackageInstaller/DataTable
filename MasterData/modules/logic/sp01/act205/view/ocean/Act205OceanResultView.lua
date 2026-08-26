-- chunkname: @modules/logic/sp01/act205/view/ocean/Act205OceanResultView.lua

module("modules.logic.sp01.act205.view.ocean.Act205OceanResultView", package.seeall)

local Act205OceanResultView = class("Act205OceanResultView", BaseView)

function Act205OceanResultView:onInitView()
	self._txtneedPoint = gohelper.findChildText(self.viewGO, "Left/Need/#txt_needPoint")
	self._gonormalAll = gohelper.findChild(self.viewGO, "Left/#go_normalAll")
	self._txttotalDiceNum = gohelper.findChildText(self.viewGO, "Left/#go_normalAll/#txt_totalDiceNum")
	self._txtdiceNum1 = gohelper.findChildText(self.viewGO, "Left/#go_normalAll/Dice1/#txt_diceNum1")
	self._txtdiceNum2 = gohelper.findChildText(self.viewGO, "Left/#go_normalAll/Dice2/#txt_diceNum2")
	self._txtdiceNum3 = gohelper.findChildText(self.viewGO, "Left/#go_normalAll/Dice3/#txt_diceNum3")
	self._gospAll = gohelper.findChild(self.viewGO, "Left/#go_spAll")
	self._gosuccess = gohelper.findChild(self.viewGO, "Right/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "Right/#go_fail")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Right/#txt_Desc")
	self._goreward = gohelper.findChild(self.viewGO, "Right/#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_rewardItem")
	self._btnfinish = gohelper.findChildButtonWithAudio(self.viewGO, "Right/LayoutGroup/#btn_finish")
	self._btnnewGame = gohelper.findChildButtonWithAudio(self.viewGO, "Right/LayoutGroup/#btn_newGame")
	self._txtGameTimes = gohelper.findChildText(self.viewGO, "Right/LayoutGroup/#btn_newGame/#txt_GameTimes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205OceanResultView:addEvents()
	self._btnfinish:AddClickListener(self._btnfinishOnClick, self)
	self._btnnewGame:AddClickListener(self._btnnewGameOnClick, self)
	self.addEventCb(self, Act205Controller.instance, Act205Event.OnDailyRefresh, self.refreshTimesInfo, self)
end

function Act205OceanResultView:removeEvents()
	self._btnfinish:RemoveClickListener()
	self._btnnewGame:RemoveClickListener()
	self.removeEventCb(self, Act205Controller.instance, Act205Event.OnDailyRefresh, self.refreshTimesInfo, self)
end

function Act205OceanResultView:_btnfinishOnClick()
	Act205OceanModel.instance:cleanSelectData()

	self.gameInfoMo = Act205Model.instance:getGameInfoMo(self.activityId, self.gameType)

	if self.gameInfoMo and self.gameInfoMo.haveGameCount > 0 then
		Act205Controller.instance:openGameStartView(self.activityId, self.gameType)
	end

	TaskDispatcher.runDelay(self.closeThis, self, 0.1)
end

function Act205OceanResultView:_btnnewGameOnClick()
	Activity205Rpc.instance:sendAct205GetInfoRequest(self.activityId, self.openOceanSelectView, self)
end

function Act205OceanResultView:openOceanSelectView()
	Act205OceanModel.instance:cleanSelectData()
	Act205Controller.instance:openOceanSelectView({
		gameStageId = self.gameType
	})
	TaskDispatcher.runDelay(self.closeThis, self, 0.1)
end

function Act205OceanResultView:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self._txtSpAll = gohelper.findChildText(self.viewGO, "Left/#go_spAll/txt_total")
	self._txtSpAll.text = "?"

	gohelper.setActive(self._gorewardItem, false)
end

function Act205OceanResultView:onUpdateParam()
	return
end

function Act205OceanResultView:onOpen()
	self.activityId = Act205Enum.ActId
	self.gameType = Act205Enum.GameStageId.Ocean
	self.isHasWinDice = self.viewParam.isHasWinDice
	self.randomDiceNumList = self.viewParam.randomDiceNumList

	local curSelectGoldId = Act205OceanModel.instance:getCurSelectGoldId()

	self.goldConfig = Act205Config.instance:getDiceGoalConfig(curSelectGoldId)
	self.gameInfoMo = Act205Model.instance:getGameInfoMo(self.activityId, self.gameType)

	self:refreshDicePointUI()
	self:refreshRightUI()
end

function Act205OceanResultView:refreshDicePointUI()
	local goladRangeList = string.splitToNumber(self.goldConfig.goalRange, "#")

	self._txtneedPoint.text = string.format("%s~%s", goladRangeList[1], goladRangeList[2])

	gohelper.setActive(self._gonormalAll, not self.isHasWinDice)
	gohelper.setActive(self._gospAll, self.isHasWinDice)

	if not self.isHasWinDice then
		local totalDiceNum = 0

		for index, diceNum in ipairs(self.randomDiceNumList) do
			self["_txtdiceNum" .. index].text = diceNum
			totalDiceNum = totalDiceNum + diceNum
		end

		self._txttotalDiceNum.text = totalDiceNum
		self.isWin = totalDiceNum >= goladRangeList[1] and totalDiceNum <= goladRangeList[2]
	else
		self.isWin = true
	end
end

function Act205OceanResultView:refreshRightUI()
	gohelper.setActive(self._gosuccess, self.isWin)
	gohelper.setActive(self._gofail, not self.isWin)

	if self.isWin then
		if not self.goldConfig.winRewardId then
			local rewardId = self.goldConfig.failRewardId
			local rewardConfig = Act205Config.instance:getGameRewardConfig(Act205Enum.GameStageId.Ocean, rewardId)

			self._txtDesc.text = rewardConfig.rewardDesc

			self:refreshTimesInfo()
			self:createRewardItem(rewardConfig)
			TaskDispatcher.runDelay(self.showRewardItemGet, self, 0.5)

			if self.isWin then
				AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_win)
			else
				AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_fail)
			end
		end
	end
end

function Act205OceanResultView:refreshTimesInfo()
	self.gameInfoMo = Act205Model.instance:getGameInfoMo(self.activityId, self.gameType)

	if self.gameInfoMo then
		if not self.gameInfoMo.haveGameCount then
			local curRemainGameTimes = 0
			local stageConfig = Act205Config.instance:getStageConfig(Act205Enum.ActId, Act205Enum.GameStageId.Ocean)
			local totalGameTimes = stageConfig.times

			gohelper.setActive(self._btnnewGame.gameObject, curRemainGameTimes > 0)

			if curRemainGameTimes > 0 then
				self._txtGameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_remainGameTimes"), curRemainGameTimes, totalGameTimes)
			end
		end
	end
end

function Act205OceanResultView:createRewardItem(rewardConfig)
	local rewardList = GameUtil.splitString2(rewardConfig.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._gorewardItem, self._goreward, "rewardItem_" .. index)
			}
			rewardItem.pos = gohelper.findChild(rewardItem.go, "go_rewardPos")
			rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.pos)
			rewardItem.goRewardGet = gohelper.findChild(rewardItem.go, "go_rewardGet")
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.itemIcon:setMOValue(rewardData[1], rewardData[2], rewardData[3])
		gohelper.setActive(rewardItem.goRewardGet, false)
		rewardItem.itemIcon:isShowCount(true)
		rewardItem.itemIcon:setCountFontSize(40)
		rewardItem.itemIcon:showStackableNum2()
		rewardItem.itemIcon:setHideLvAndBreakFlag(true)
		rewardItem.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(rewardItem.go, true)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function Act205OceanResultView:showRewardItemGet()
	for index, rewardItem in ipairs(self.rewardItemTab) do
		gohelper.setActive(rewardItem.goRewardGet, true)
	end
end

function Act205OceanResultView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function Act205OceanResultView:onDestroyView()
	return
end

return Act205OceanResultView
