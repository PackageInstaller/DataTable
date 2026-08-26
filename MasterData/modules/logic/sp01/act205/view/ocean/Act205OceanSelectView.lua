-- chunkname: @modules/logic/sp01/act205/view/ocean/Act205OceanSelectView.lua

module("modules.logic.sp01.act205.view.ocean.Act205OceanSelectView", package.seeall)

local Act205OceanSelectView = class("Act205OceanSelectView", BaseView)

function Act205OceanSelectView:onInitView()
	self._simagerightBg = gohelper.findChildSingleImage(self.viewGO, "root/#go_firstStepContent/#simage_rightbg")
	self._gofirstStepContent = gohelper.findChild(self.viewGO, "root/#go_firstStepContent")
	self._txtgoalDesc = gohelper.findChildText(self.viewGO, "root/#go_firstStepContent/#txt_goalDesc")
	self._gogoalItem = gohelper.findChild(self.viewGO, "root/#go_firstStepContent/#go_goalItem")
	self._godestPos1 = gohelper.findChild(self.viewGO, "root/#go_firstStepContent/#go_destPos1")
	self._godestPos2 = gohelper.findChild(self.viewGO, "root/#go_firstStepContent/#go_destPos2")
	self._godestPos3 = gohelper.findChild(self.viewGO, "root/#go_firstStepContent/#go_destPos3")
	self._gosecondStepContent = gohelper.findChild(self.viewGO, "root/#go_secondStepContent")
	self._godiceContent = gohelper.findChild(self.viewGO, "root/#go_secondStepContent/#go_diceContent")
	self._godiceItem = gohelper.findChild(self.viewGO, "root/#go_secondStepContent/#go_diceContent/#go_diceItem")
	self._btnnextStep = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottomInfo/#btn_nextStep")
	self._gonextStep = gohelper.findChild(self.viewGO, "root/bottomInfo/#btn_nextStep/#go_nextStep")
	self._gostart = gohelper.findChild(self.viewGO, "root/bottomInfo/#btn_nextStep/#go_start")
	self._golock = gohelper.findChild(self.viewGO, "root/bottomInfo/#btn_nextStep/#go_lock")
	self._gostepIndex1 = gohelper.findChild(self.viewGO, "root/bottomInfo/#btn_nextStep/stepIndexContent/#go_stepIndex1")
	self._gostepIndex2 = gohelper.findChild(self.viewGO, "root/bottomInfo/#btn_nextStep/stepIndexContent/#go_stepIndex2")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottomInfo/#btn_back")
	self._gocurNeedPoint = gohelper.findChild(self.viewGO, "root/#go_secondStepContent/stepNameEn/#go_curNeedPoint")
	self._txtcurNeedPoint = gohelper.findChildText(self.viewGO, "root/#go_secondStepContent/stepNameEn/#go_curNeedPoint/#txt_curNeedPoint")
	self._gogameTimes = gohelper.findChild(self.viewGO, "root/bottomInfo/#go_gameTimes")
	self._txtgameTimes = gohelper.findChildText(self.viewGO, "root/bottomInfo/#go_gameTimes/#txt_gameTimes")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_rule")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205OceanSelectView:addEvents()
	self._btnnextStep:AddClickListener(self._btnnextStepOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnrule:AddClickListener(self._btnruleOnClick, self)
end

function Act205OceanSelectView:removeEvents()
	self._btnnextStep:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnrule:RemoveClickListener()
end

function Act205OceanSelectView:_btnruleOnClick()
	Act205Controller.instance:openRuleTipsView()
end

function Act205OceanSelectView:_btnnextStepOnClick()
	if self.curPageStep == 1 then
		self.curPageStep = 2

		self:refreshUI()
		self._animPlayerView:Play("step2_in", nil, self)
	elseif self.curPageStep == 2 then
		if #self.curSelectDictIdList < Act205Enum.oceanDiceMaxCount then
			GameFacade.showToast(ToastEnum.Act205OceanSelectDictNotEnough)

			return
		end

		if self.isEnterShowView then
			return
		end

		self.isEnterShowView = true

		Act205OceanModel.instance:setcurSelectDiceIdList(self.curSelectDictIdList)
		self._animPlayerView:Play("close", self.enterShowView, self)
	end
end

function Act205OceanSelectView:_btnbackOnClick()
	if self.curPageStep ~= 2 then
		return
	end

	self.curSelectDictIdList = {}
	self.curSelectDictMap = {}
	self.curPageStep = 1

	self:refreshUI()
	self._animPlayerView:Play("step1_in", nil, self)
end

function Act205OceanSelectView:_onGoalItemClick(goldItem)
	if self.curGoldId == goldItem.id then
		return
	end

	self.curGoldId = goldItem.id

	Act205OceanModel.instance:setCurSelectGoldId(goldItem.id)
	self:refreshGoldItemSelectState()
	self._animPlayerView:Play("rightbg_in", nil, self)
end

function Act205OceanSelectView:_onDiceItemAddClick(diceItem)
	if #self.curSelectDictIdList == Act205Enum.oceanDiceMaxCount then
		GameFacade.showToast(ToastEnum.Act205OceanSelectMaxCount)

		return
	end

	table.insert(self.curSelectDictIdList, diceItem.id)

	self.curSelectDictMap[diceItem.index] = not self.curSelectDictMap[diceItem.index] and 1 or self.curSelectDictMap[diceItem.index] + 1

	self:refreshDiceSelectUI()
end

function Act205OceanSelectView:_onDiceItemSubClick(diceItem)
	if #self.curSelectDictIdList == 0 or not self.curSelectDictMap[diceItem.index] or self.curSelectDictMap[diceItem.index] == 0 then
		return
	end

	table.remove(self.curSelectDictIdList)

	if self.curSelectDictMap[diceItem.index] > 0 then
		self.curSelectDictMap[diceItem.index] = self.curSelectDictMap[diceItem.index] - 1 or 0
	end

	self:refreshDiceSelectUI()
end

function Act205OceanSelectView:_editableInitView()
	self.goldItemMap = self:getUserDataTb_()
	self.stepItemMap = self:getUserDataTb_()
	self.diceItemMap = self:getUserDataTb_()

	gohelper.setActive(self._gogoalItem, false)
	gohelper.setActive(self._godiceItem, false)

	self.curSelectDictIdList = {}
	self.curSelectDictMap = {}
	self._gohardMask = gohelper.findChild(self.viewGO, "root/simage_hardmask")
	self._animPlayerView = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function Act205OceanSelectView:onOpen()
	self.curPageStep = 1

	Act205OceanModel.instance:setCurSelectGoldId(nil)
	self:refreshUI()
end

function Act205OceanSelectView:refreshUI()
	self:refreshStepUI()

	if self.curPageStep == 1 then
		self:refreshFirstStepUI()
	elseif self.curPageStep == 2 then
		self:refreshSecondStepUI()
	end
end

function Act205OceanSelectView:refreshStepUI()
	gohelper.setActive(self._gofirstStepContent, self.curPageStep == 1)
	gohelper.setActive(self._gosecondStepContent, self.curPageStep == 2)
	gohelper.setActive(self._gocurNeedPoint, self.curPageStep == 2)
	gohelper.setActive(self._gogameTimes, self.curPageStep == 2)
	gohelper.setActive(self._btnback.gameObject, self.curPageStep == 2)
	gohelper.setActive(self._gonextStep, self.curPageStep == 1)
	gohelper.setActive(self._gostart, self.curPageStep == 2)
	gohelper.setActive(self._golock, self.curPageStep == 2)

	for step = 1, 2 do
		local stepItem = self.stepItemMap[step]

		if not stepItem then
			stepItem = {
				go = self["_gostepIndex" .. step]
			}
			stepItem.goLight = gohelper.findChild(stepItem.go, "go_light")
			stepItem.goDark = gohelper.findChild(stepItem.go, "go_dark")
			self.stepItemMap[step] = stepItem
		end

		gohelper.setActive(stepItem.goLight, step == self.curPageStep)
		gohelper.setActive(stepItem.goDark, step ~= self.curPageStep)
	end

	self.isEnterShowView = false

	self:setCloseOverrideFunc()
end

function Act205OceanSelectView:refreshFirstStepUI()
	self.goldIdList = Act205OceanModel.instance:getGoldList()

	self:createAndRefreshGoldItem()
	self:refreshGoldItemSelectState()
end

function Act205OceanSelectView:createAndRefreshGoldItem()
	for index, goldId in ipairs(self.goldIdList) do
		local goldItem = self.goldItemMap[index]

		if not goldItem then
			goldItem = {
				pos = gohelper.findChild(self["_godestPos" .. index], "go_pos")
			}
			goldItem.go = gohelper.clone(self._gogoalItem, goldItem.pos, "goalItem" .. goldId)
			goldItem.txtGoalName = gohelper.findChildText(goldItem.go, "txt_goalName")
			goldItem.txtNeedPoint = gohelper.findChildText(goldItem.go, "needPoint/txt_needPoint")
			goldItem.txtSelectGoldName = gohelper.findChildText(goldItem.go, "go_select/txt_selectGoalName")
			goldItem.txtSelectNeedPoint = gohelper.findChildText(goldItem.go, "go_select/needPoint/txt_selectNeedPoint")
			goldItem.goHardTag = gohelper.findChild(goldItem.go, "go_hardTag")
			goldItem.goSelect = gohelper.findChild(goldItem.go, "go_select")
			goldItem.btnClick = gohelper.findChildButtonWithAudio(goldItem.go, "btn_click")
			self.goldItemMap[index] = goldItem
		end

		goldItem.btnClick:AddClickListener(self._onGoalItemClick, self, goldItem)
		gohelper.setActive(goldItem.go, true)

		goldItem.id = goldId
		goldItem.index = index
		goldItem.config = Act205Config.instance:getDiceGoalConfig(goldId)
		goldItem.txtGoalName.text = goldItem.config.goalname
		goldItem.txtSelectGoldName.text = goldItem.config.goalname

		gohelper.setActive(goldItem.goHardTag, goldItem.config.hardType == Act205Enum.oceanGoldHardType.Hard)

		local goladRangeList = string.split(goldItem.config.goalRange, "#")

		goldItem.txtNeedPoint.text = string.format("%s~%s", goladRangeList[1], goladRangeList[2])
		goldItem.txtSelectNeedPoint.text = string.format("%s~%s", goladRangeList[1], goladRangeList[2])

		local curSelectGoldId = Act205OceanModel.instance:getCurSelectGoldId()

		if not curSelectGoldId or curSelectGoldId == 0 then
			Act205OceanModel.instance:setCurSelectGoldId(goldId)
		end
	end
end

function Act205OceanSelectView:refreshGoldItemSelectState()
	local curSelectGoldId = Act205OceanModel.instance:getCurSelectGoldId()

	for index, goldItem in pairs(self.goldItemMap) do
		gohelper.setActive(goldItem.goSelect, goldItem.id == curSelectGoldId)
	end

	local goldCo = Act205Config.instance:getDiceGoalConfig(curSelectGoldId)

	self._txtgoalDesc.text = goldCo.goaldesc

	self._simagerightBg:LoadImage(ResUrl.getV2a9ActOceanSingleBg(goldCo.iconRes))

	local isHardType = goldCo.hardType == Act205Enum.oceanGoldHardType.Hard

	gohelper.setActive(self._gohardMask, isHardType)
end

function Act205OceanSelectView:refreshSecondStepUI()
	local curSelectGoldId = Act205OceanModel.instance:getCurSelectGoldId()
	local selectGoldConfig = Act205Config.instance:getDiceGoalConfig(curSelectGoldId)
	local goladRangeList = string.split(selectGoldConfig.goalRange, "#")

	self._txtcurNeedPoint.text = string.format("%s~%s", goladRangeList[1], goladRangeList[2])

	self:createAndRefreshDiceItem()
	self:refreshDiceSelectUI()
end

function Act205OceanSelectView:createAndRefreshDiceItem()
	local goldId = Act205OceanModel.instance:getCurSelectGoldId()
	local goldIndex = Act205OceanModel.instance:getGoldIndexByGoldId(goldId)

	self.diceIdList = Act205OceanModel.instance:getDiceList(goldIndex)

	for index, diceId in ipairs(self.diceIdList) do
		local diceItem = self.diceItemMap[index]

		if not diceItem then
			diceItem = {
				go = gohelper.clone(self._godiceItem, self._godiceContent, "diceItem" .. diceId)
			}
			diceItem.imageShip = gohelper.findChildImage(diceItem.go, "#image_ship")
			diceItem.txtDiceName = gohelper.findChildText(diceItem.go, "txt_diceName")
			diceItem.txtDiceDesc = gohelper.findChildText(diceItem.go, "#scroll_dice/Viewport/Content/txt_diceDesc")
			diceItem.goDiceContent = gohelper.findChild(diceItem.go, "go_diceContent")
			diceItem.goDicePointItem = gohelper.findChild(diceItem.go, "go_diceContent/go_dicePointItem")
			diceItem.txtSelectNum = gohelper.findChildText(diceItem.go, "num/txt_selectNum")
			diceItem.btnAddNum = gohelper.findChildButtonWithAudio(diceItem.go, "btn_addNum")
			diceItem.goNormalAddIcon = gohelper.findChild(diceItem.go, "btn_addNum/go_normalAddIcon")
			diceItem.goLockAddIcon = gohelper.findChild(diceItem.go, "btn_addNum/go_lockAddIcon")
			diceItem.btnSubNum = gohelper.findChildButtonWithAudio(diceItem.go, "btn_subNum")
			diceItem.goNormalSubIcon = gohelper.findChild(diceItem.go, "btn_subNum/go_normalSubIcon")
			diceItem.goLockSubIcon = gohelper.findChild(diceItem.go, "btn_subNum/go_lockSubIcon")
			diceItem.goSelect = gohelper.findChild(diceItem.go, "go_select")
			diceItem.dicePointItemList = {}
			self.diceItemMap[index] = diceItem
		end

		diceItem.btnAddNum:AddClickListener(self._onDiceItemAddClick, self, diceItem)
		diceItem.btnSubNum:AddClickListener(self._onDiceItemSubClick, self, diceItem)
		gohelper.setActive(diceItem.go, true)
		gohelper.setActive(diceItem.goDicePointItem, false)

		diceItem.id = diceId
		diceItem.index = index
		diceItem.config = Act205Config.instance:getDicePoolConfig(diceId)
		diceItem.txtDiceName.text = diceItem.config.name
		diceItem.txtDiceDesc.text = diceItem.config.desc

		UISpriteSetMgr.instance:setSp01Act205Sprite(diceItem.imageShip, diceItem.config.iconRes)
		self:createAndShowDicePointItem(diceItem)
	end
end

function Act205OceanSelectView:createAndShowDicePointItem(diceItem)
	local dicePointList = diceItem.config.winDice == 1 and {
		"?",
		"?",
		"?",
		"?",
		"?",
		"?"
	} or string.splitToNumber(diceItem.config.dicePoints, "#")

	for index, pointNum in ipairs(dicePointList) do
		local pointItem = diceItem.dicePointItemList[index]

		if not pointItem then
			pointItem = {
				go = gohelper.clone(diceItem.goDicePointItem, diceItem.goDiceContent, "dicePointItem" .. index)
			}
			pointItem.goNormal = gohelper.findChild(pointItem.go, "go_normal")
			pointItem.txtPoint = gohelper.findChildText(pointItem.go, "go_normal/txt_point")
			pointItem.goWinDice = gohelper.findChild(pointItem.go, "go_winDice")
			pointItem.goSelect = gohelper.findChild(pointItem.go, "go_select")
			pointItem.isNormalPoint = type(pointNum) == "number"
			diceItem.dicePointItemList[index] = pointItem
		end

		gohelper.setActive(pointItem.goNormal, pointItem.isNormalPoint)
		gohelper.setActive(pointItem.goWinDice, not pointItem.isNormalPoint)
		gohelper.setActive(pointItem.go, true)

		pointItem.txtPoint.text = pointNum
	end
end

function Act205OceanSelectView:refreshDiceSelectUI()
	local isFullDice = #self.curSelectDictIdList == Act205Enum.oceanDiceMaxCount

	gohelper.setActive(self._gostart, isFullDice)
	gohelper.setActive(self._golock, not isFullDice)

	self._txtgameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_ocean_selectDiceCount"), #self.curSelectDictIdList, Act205Enum.oceanDiceMaxCount)

	for index, diceItem in pairs(self.diceItemMap) do
		self.curSelectDictMap[diceItem.index] = self.curSelectDictMap[diceItem.index] or 0

		gohelper.setActive(diceItem.goSelect, self.curSelectDictMap[diceItem.index] > 0)

		diceItem.txtSelectNum.text = self.curSelectDictMap[diceItem.index]

		gohelper.setActive(diceItem.goNormalAddIcon, #self.curSelectDictIdList < Act205Enum.oceanDiceMaxCount)
		gohelper.setActive(diceItem.goLockAddIcon, #self.curSelectDictIdList >= Act205Enum.oceanDiceMaxCount)
		gohelper.setActive(diceItem.goNormalSubIcon, self.curSelectDictMap[diceItem.index] > 0)
		gohelper.setActive(diceItem.goLockSubIcon, self.curSelectDictMap[diceItem.index] == 0)

		for _, dicePointItem in pairs(diceItem.dicePointItemList) do
			gohelper.setActive(dicePointItem.goSelect, self.curSelectDictMap[diceItem.index] > 0)
		end
	end
end

function Act205OceanSelectView:enterShowView()
	Act205Controller.instance:openOceanShowView()
	TaskDispatcher.runDelay(self.closeThis, self, 0.1)
end

function Act205OceanSelectView:setCloseOverrideFunc()
	if self.curPageStep == 2 then
		self.viewContainer:setOverrideCloseClick(self._btnbackOnClick, self)
	else
		self.viewContainer:setOverrideCloseClick(self.closeThis, self)
	end
end

function Act205OceanSelectView:onClose()
	for index, goldItem in pairs(self.goldItemMap) do
		goldItem.btnClick:RemoveClickListener()
	end

	for index, diceItem in pairs(self.diceItemMap) do
		diceItem.btnAddNum:RemoveClickListener()
		diceItem.btnSubNum:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.closeThis, self)
end

function Act205OceanSelectView:onDestroyView()
	self._simagerightBg:UnLoadImage()
end

return Act205OceanSelectView
