-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceAnimView.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceAnimView", package.seeall)

local Rouge2_MapDiceAnimView = class("Rouge2_MapDiceAnimView", BaseView)
local WaitSec2MoveOtherValue = 0.06
local FixValueFadeOutWaitTime = 0.1
local MiddleValueFadeInDuration = 0.3
local DiceAnimDuration = 2

Rouge2_MapDiceAnimView.DiceType = {
	Twenty = 20,
	Six = 6
}
Rouge2_MapDiceAnimView.DiceType2Cls = {
	[Rouge2_MapDiceAnimView.DiceType.Six] = Rouge2_MapSixDiceItem,
	[Rouge2_MapDiceAnimView.DiceType.Twenty] = Rouge2_MapTwentyDiceItem
}
Rouge2_MapDiceAnimView.CheckResult2InfoAnim = {
	[Rouge2_MapEnum.AttrCheckResult.None] = "idle",
	[Rouge2_MapEnum.AttrCheckResult.Succeed] = "succeed",
	[Rouge2_MapEnum.AttrCheckResult.Failure] = "failure",
	[Rouge2_MapEnum.AttrCheckResult.BigSucceed] = "bigsucceed"
}

function Rouge2_MapDiceAnimView:onInitView()
	self._goInfo = gohelper.findChild(self.viewGO, "root/#go_Info")
	self._imageRateAttribute = gohelper.findChildImage(self.viewGO, "root/#go_Info/Rate/#image_Attribute")
	self._txtRate = gohelper.findChildText(self.viewGO, "root/#go_Info/Rate/#txt_Rate")
	self._txtFixAttributeName = gohelper.findChildText(self.viewGO, "root/#go_Info/Value/#txt_AttributeName")
	self._imageFixAttribute = gohelper.findChildImage(self.viewGO, "root/#go_Info/Value/#image_Attribute")
	self._txtFixValue = gohelper.findChildText(self.viewGO, "root/#go_Info/Value/#txt_FixValue")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Tips")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Target")
	self._txtMiddle = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Middle")
	self._goDice = gohelper.findChild(self.viewGO, "root/#go_Dice")
	self._goSixItem = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_SixItem")
	self._goTwentyItem = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_TwentyItem")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Click", AudioEnum.Rouge2.StartDice)
	self._btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Jump")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._goResult = gohelper.findChild(self.viewGO, "root/#go_Result")
	self._goFailure = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Failure")
	self._goSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Succeed")
	self._goBigSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_BigSucceed")
	self._scrollFixList = gohelper.findChild(self.viewGO, "root/#go_Info/Value/#scroll_FixList")
	self._goFixList = gohelper.findChild(self.viewGO, "root/#go_Info/Value/#scroll_FixList/Viewport/#go_FixList")
	self._goFlyContent = gohelper.findChild(self.viewGO, "root/#go_Info/#go_flyItemContent")
	self._goFlyMgr = gohelper.findChild(self.viewGO, "root/#go_Info/#go_flyItemContent/#fly")
	self._goFlyEndPos = gohelper.findChild(self.viewGO, "root/#go_Info/#go_middleTarget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDiceAnimView:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnJump:AddClickListener(self._btnJumpOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnJumpFinishDice, self._onJumpFinishDice, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
end

function Rouge2_MapDiceAnimView:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnJump:RemoveClickListener()
end

function Rouge2_MapDiceAnimView:_btnClickOnClick()
	gohelper.setActive(self._btnClick.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, true)

	self._clickDiceCount = self._clickDiceCount + 1

	self:dice()
end

function Rouge2_MapDiceAnimView:_btnJumpOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.StopDice)
	gohelper.setActive(self._btnClick.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnJumpFinishDice)
end

function Rouge2_MapDiceAnimView:_editableInitView()
	self._goFixViewport = self._scrollFixList.gameObject
	self._tranFlyContent = self._goFlyContent.transform
	self._uiFlying = self._goFlyMgr:GetComponent(typeof(UnityEngine.UI.UIFlying))
	self._uiFlyingEndPos = recthelper.rectToRelativeAnchorPos(self._goFlyEndPos.transform.position, self._tranFlyContent)
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._infoAnimWorkParam = self:getUserDataTb_()
	self._infoAnimWorkParam.go = self._goInfo
	self._mainView = self.viewContainer:getMainView()
	self._rollView = self.viewContainer:getRollView()
	self._clickDiceCount = 0
	self._diceType2ItemTab = self:getUserDataTb_()

	self:initDicePrefabTab()
	self:initPosList()
end

function Rouge2_MapDiceAnimView:initDicePrefabTab()
	self._diceType2Prefab = self:getUserDataTb_()
	self._diceType2Prefab[Rouge2_MapDiceAnimView.DiceType.Six] = self._goSixItem
	self._diceType2Prefab[Rouge2_MapDiceAnimView.DiceType.Twenty] = self._goTwentyItem

	for _, goDicePrefab in pairs(self._diceType2Prefab) do
		gohelper.setActive(goDicePrefab, false)
	end
end

function Rouge2_MapDiceAnimView:initPosList()
	self._goPosList = self:getUserDataTb_()

	for i = 1, math.huge do
		local gopos = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_poslist/#go_pos" .. i)

		if gohelper.isNil(gopos) then
			return
		end

		table.insert(self._goPosList, gopos)
	end
end

function Rouge2_MapDiceAnimView:onOpen()
	self:refresh()
	self:tryForceSetResult()
end

function Rouge2_MapDiceAnimView:refresh()
	self:initViewParams()
	self:initDiceList()
end

function Rouge2_MapDiceAnimView:tryForceSetResult()
	if self._clickDiceCount > self._reRollTimes or Rouge2_MapModel.instance:getMapState() ~= Rouge2_MapEnum.MapState.WaitFlow then
		self._needForceSet = false

		return
	end

	for _, diceItemList in pairs(self._diceType2ItemTab) do
		for _, diceItem in pairs(diceItemList) do
			diceItem:forceSet()
		end
	end

	self._needForceSet = true
end

function Rouge2_MapDiceAnimView:onOpenFinish()
	if self._needForceSet then
		self:playFinishAnim(true)

		self._needForceSet = false
	end
end

function Rouge2_MapDiceAnimView:initViewParams()
	self._checkResInfo = self._mainView:getCheckResInfo()
	self._checkCo = self._checkResInfo and self._checkResInfo:getCheckConfig()
	self._checkId = self._checkResInfo and self._checkResInfo:getCheckId()
	self._checkDiceRes = self._checkResInfo and self._checkResInfo:getCheckDiceRes()
	self._checkRes = self._checkResInfo and self._checkResInfo:getCheckRes()
	self._isSucceed = self._checkRes ~= Rouge2_MapEnum.AttrCheckResult.Failure
	self._reRollTimes = self._checkResInfo and self._checkResInfo:getCheckReRollTimes()
end

function Rouge2_MapDiceAnimView:getOrCreateDiceItem(diceType, index)
	local diceList = self._diceType2ItemTab[diceType]
	local diceItem = diceList and diceList[index]

	if not diceItem then
		diceList = diceList or self:getUserDataTb_()
		self._diceType2ItemTab[diceType] = diceList

		local cls = Rouge2_MapDiceAnimView.DiceType2Cls[diceType]
		local goTemplate = self._diceType2Prefab[diceType]
		local goDiceItem = gohelper.cloneInPlace(goTemplate, index)

		diceItem = MonoHelper.addNoUpdateLuaComOnceToGo(goDiceItem, cls, self)

		table.insert(diceList, diceItem)
	end

	return diceItem
end

function Rouge2_MapDiceAnimView:initDiceList()
	for _, goPos in pairs(self._goPosList) do
		gohelper.setActive(goPos, false)
	end

	local useMap = {}
	local diceType2Num = {}

	self._totalDicePoint = 0
	self._totalFixValue = self._mainView:getTotalFixValue()

	for i, diceInfo in ipairs(self._checkDiceRes or {}) do
		local diceId = diceInfo[1]

		if not diceInfo[2] then
			local diceCo = lua_rouge2_dice.configDict[diceId]
			local diceType = diceCo.sides

			if not diceType2Num[diceType] then
				local index = 0

				index = index + 1
				diceType2Num[diceType] = index

				local diceItem = self:getOrCreateDiceItem(diceType, index)

				if self._goPosList then
					gohelper.addChild(self._goPosList, diceItem.go)
					gohelper.setActive(self._goPosList, true)
					recthelper.setAnchor(diceItem.go.transform, 0, 0)
					diceItem:initInfo(diceInfo)

					useMap[diceItem] = true
					self._totalDicePoint = self._totalDicePoint + diceInfo[2]
				end
			end
		end
	end

	for _, diceItemList in pairs(self._diceType2ItemTab) do
		for _, diceItem in pairs(diceItemList) do
			if not useMap[diceItem] then
				diceItem:setUse(false)
			end
		end
	end

	self._baseDicePoint = self._totalDicePoint
	self._txtMiddle.text = self._totalDicePoint

	gohelper.setActive(self._goResult, false)
	gohelper.setActive(self._btnClick.gameObject, true)
	gohelper.setActive(self._btnJump.gameObject, false)
	gohelper.setActive(self._txtMiddle.gameObject, false)
end

function Rouge2_MapDiceAnimView:dice(diceAnimDuration)
	for _, diceItemList in pairs(self._diceType2ItemTab) do
		for _, diceItem in pairs(diceItemList) do
			diceItem:dice()
		end
	end

	self:playDiceResultFlow(diceAnimDuration)
end

function Rouge2_MapDiceAnimView:playDiceResultFlow(diceAnimDuration)
	self:destroyFlow()

	diceAnimDuration = diceAnimDuration or DiceAnimDuration
	self._flow = FlowSequence.New()

	self._flow:addWork(WorkWaitSeconds.New(diceAnimDuration))
	self._flow:addWork(FunctionWork.New(self._showMiddleValue, self))
	self._flow:addWork(TweenWork.New({
		from = 0,
		type = "DOFadeCanvasGroup",
		to = 1,
		t = MiddleValueFadeInDuration,
		go = self._txtMiddle.gameObject
	}))
	self._flow:addWork(self:buildFixValueMoveFlow())

	local infoAnimName = Rouge2_MapDiceAnimView.CheckResult2InfoAnim[self._checkRes]

	if not string.nilorempty(infoAnimName) then
		self._infoAnimWorkParam.animName = infoAnimName

		self._flow:addWork(FunctionWork.New(AudioMgr.trigger, AudioMgr.instance, AudioEnum.Rouge2.DiceValue))
		self._flow:addWork(AnimatorWork.New(self._infoAnimWorkParam))
	end

	self._flow:registerDoneListener(self.playFinishAnim, self)
	self._flow:start()
end

function Rouge2_MapDiceAnimView:buildFixValueMoveFlow()
	local moveFlow = FlowParallel.New()
	local fixItemList = self._mainView:getFixItemList()

	if fixItemList then
		for i, fixItem in ipairs(fixItemList) do
			if not fixItem.fixValue then
				if fixItem.fixValue ~= 0 and not fixItem.done then
					local oneFixFlow = self:buildOneFixValueMoveFlow(i, fixItem)

					moveFlow:addWork(oneFixFlow)
				end
			end
		end
	end

	return moveFlow
end

function Rouge2_MapDiceAnimView:buildOneFixValueMoveFlow(index, fixItem)
	local moveFlow = FlowSequence.New()

	moveFlow:addWork(FunctionWork.New(self.fitScrollItemOffset, self, fixItem))

	local waitSec = (index - 1) * WaitSec2MoveOtherValue

	moveFlow:addWork(WorkWaitSeconds.New(waitSec))

	local parallel = FlowParallel.New()

	parallel:addWork(FunctionWork.New(self._showFlyEffect, self, fixItem))

	local fadeFlow = FlowSequence.New()

	fadeFlow:addWork(WorkWaitSeconds.New(FixValueFadeOutWaitTime))
	parallel:addWork(fadeFlow)
	moveFlow:addWork(parallel)
	moveFlow:addWork(FunctionWork.New(self._updateFixValue, self, fixItem))

	return moveFlow
end

function Rouge2_MapDiceAnimView:fitScrollItemOffset(fixItem)
	local offset = gohelper.fitScrollItemOffset(self._goFixViewport, self._goFixList, fixItem:getGO(), ScrollEnum.ScrollDirV)

	recthelper.setAnchorY(self._goFixList.transform, offset)
end

function Rouge2_MapDiceAnimView:_showFlyEffect(fixItem)
	gohelper.setActive(self._goFlyContent, true)
	fixItem:startFlying(self._goFlyMgr, self._tranFlyContent, self._uiFlyingEndPos)
end

function Rouge2_MapDiceAnimView:_showMiddleValue()
	gohelper.setActive(self._txtMiddle.gameObject, true)
end

function Rouge2_MapDiceAnimView:_updateFixValue(fixItem)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.AddFixValue)
	fixItem:onEndMoveFixValue()

	if not fixItem.fixValue then
		self._totalDicePoint = self._totalDicePoint + fixItem.fixValue
		self._txtMiddle.text = self._totalDicePoint

		gohelper.setActive(self._txtMiddle.gameObject, true)
	end
end

function Rouge2_MapDiceAnimView:playFinishAnim(skipAnim)
	self:onAllFixItemMoveDone()
	gohelper.setActive(self._btnClick.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, false)
	gohelper.setActive(self._btnClose.gameObject, self._isSucceed)

	self._totalDicePoint = self._baseDicePoint + self._totalFixValue
	self._txtMiddle.text = self._totalDicePoint

	gohelper.setActive(self._txtMiddle.gameObject, true)
	gohelper.setActive(self._goResult, true)
	gohelper.setActive(self._goFailure, self._checkRes == Rouge2_MapEnum.AttrCheckResult.Failure)
	gohelper.setActive(self._goSucceed, self._checkRes == Rouge2_MapEnum.AttrCheckResult.Succeed)
	gohelper.setActive(self._goBigSucceed, self._checkRes == Rouge2_MapEnum.AttrCheckResult.BigSucceed)

	if skipAnim then
		self._animator:Play("result", 0, 1)
		self:_onPlayFinishAnimDone()
	else
		self._animator:Play("result", 0, 0)
		self._animatorPlayer:Play("result", self._onPlayFinishAnimDone, self)
	end

	if self._checkRes == Rouge2_MapEnum.AttrCheckResult.Failure then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.DiceFail)
	else
		AudioMgr.instance:trigger(AudioEnum.Rouge2.DiceSucc)
	end
end

function Rouge2_MapDiceAnimView:_onPlayFinishAnimDone()
	self._rollView:checkShowRediceTips()
end

function Rouge2_MapDiceAnimView:_onJumpFinishDice()
	self:destroyFlow()
	self:playFinishAnim()
end

function Rouge2_MapDiceAnimView:_onUpdateMapInfo()
	self:refresh()
end

function Rouge2_MapDiceAnimView:onAllFixItemMoveDone()
	local fixItemList = self._mainView:getFixItemList()

	if fixItemList then
		for i, fixItem in ipairs(fixItemList) do
			fixItem:onEndMoveFixValue()
		end
	end
end

function Rouge2_MapDiceAnimView:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapDiceAnimView:onClose()
	self:destroyFlow()
end

return Rouge2_MapDiceAnimView
