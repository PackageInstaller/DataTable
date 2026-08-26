-- chunkname: @modules/logic/sp02/operationactivity/view/game/AtomicOperationActivityGameView.lua

module("modules.logic.sp02.operationactivity.view.game.AtomicOperationActivityGameView", package.seeall)

local AtomicOperationActivityGameView = class("AtomicOperationActivityGameView", BaseView)

function AtomicOperationActivityGameView:onInitView()
	self._goTime = gohelper.findChild(self.viewGO, "root/Time/#go_TimeBG")
	self._txtnumcountdown = gohelper.findChildText(self.viewGO, "root/Time/#go_TimeBG/#txt_num_countdown")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "root/Score/#txt_ScoreNum")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._btnClick = gohelper.findChildButton(self.viewGO, "root/#btn_click")
	self._goWarning = gohelper.findChild(self.viewGO, "root/Time/#go_TimeBG/#go_Warning")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityGameView:addEvents()
	self.addEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.InitGame, self.onInitGame, self)
	self.addEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.StartGame, self.onStartGame, self)
	self.addEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.EndGame, self.onEndGame, self)
	self.addEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.ChangeState, self.onChangeState, self)
	self.addEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.RemoveTarget, self.onRemoveTarget, self)
	self.addEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.AddTarget, self.onAddTarget, self)
	self.addClickCb(self, self._btnClick, self.onClickGame, self)
end

function AtomicOperationActivityGameView:removeEvents()
	self.removeEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.InitGame, self.onInitGame, self)
	self.removeEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.StartGame, self.onStartGame, self)
	self.removeEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.EndGame, self.onEndGame, self)
	self.removeEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.ChangeState, self.onChangeState, self)
	self.removeEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.RemoveTarget, self.onRemoveTarget, self)
	self.removeEventCb(self, AtomicOperationActivityGameController.instance, AtomicOperationActivityGameEvent.AddTarget, self.onAddTarget, self)
	self.removeClickCb(self, self._btnClick, self.onClickGame, self)
end

function AtomicOperationActivityGameView:_editableInitView()
	self._goPosRoot = gohelper.findChild(self.viewGO, "root/Pos")
	self._goTargetItem = gohelper.findChild(self.viewGO, "root/Pos/go_robotitem")

	gohelper.setActive(self._goTargetItem, false)

	self._targetItemListDic = {}
	self._useTargetItemList = {}
	self._useTargetItemDic = {}
	self._targetItemTweenDic = {}
	self._posItemList = self:getUserDataTb_()

	local posList = {}

	for i = 1, AtomicOperationActivityEnum.GameMaxTargetCount do
		local itemGo = gohelper.findChild(self.viewGO, string.format("root/Pos/pos%s", i))

		table.insert(self._posItemList, itemGo)

		local pos = {}
		local position = itemGo.transform.localPosition

		pos[1] = position.x
		pos[2] = position.y

		table.insert(posList, pos)
	end

	self.posList = posList

	AtomicOperationActivityGameController.instance:initPosData(posList)
	NavigateMgr.instance:addEscape(self.viewName, self.onClickClose, self)

	self._countDownAnimator = gohelper.findChildComponent(self.viewGO, "root/Time", gohelper.Type_Animator)
	self._scoreAnimator = gohelper.findChildComponent(self.viewGO, "root/Score", gohelper.Type_Animator)
	self._comboAnimator = gohelper.findChildComponent(self.viewGO, "root/ComboTotal", gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(self.viewName, self.onClickClose, self)

	self._goCombo = gohelper.findChild(self.viewGO, "root/ComboTotal")
	self._txtCombo = gohelper.findChildText(self.viewGO, "root/ComboTotal/#txt_ComboNum")
end

function AtomicOperationActivityGameView:onUpdateParam()
	return
end

function AtomicOperationActivityGameView:onOpen()
	self.logicData = AtomicOperationActivityGameModel.instance:getInfoMo()

	AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_mingdi_gsn_open)
end

function AtomicOperationActivityGameView:hideAllTarget()
	for i = 1, AtomicOperationActivityEnum.GameMaxTargetCount do
		local item = self:getTargetItem(i)

		gohelper.setActive(item.goTargetRoot, false)
		item.animator:Play("empty", 0, 0)
	end
end

function AtomicOperationActivityGameView:onClickGame()
	local temp_pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._goPosRoot.transform)

	AtomicOperationActivityGameController.instance:onHitBackground({
		temp_pos.x,
		temp_pos.y
	})
end

function AtomicOperationActivityGameView:onInitGame()
	AtomicOperationActivityGameController.instance:initPosData(self.posList)
	self:hideAllTarget()
	self:refreshTime()

	self.previousScore = nil

	self:refreshScore()

	if self.logicData.useTargetDic and next(self.logicData.useTargetDic) then
		for index, targetMo in pairs(self.logicData.useTargetDic) do
			self:setTargetItemActive(index, true)
			self:refreshItem(targetMo)
			self:changeTargetItemState(index, targetMo.state)
		end
	end

	gohelper.setActive(self._goTime, false)
	self._comboAnimator:Play("close", 0, 0)
end

function AtomicOperationActivityGameView:getTargetItem(index)
	if not self._targetItemListDic[index] then
		local targetItem = {}
		local itemGo = gohelper.cloneInPlace(self._goTargetItem)

		gohelper.setActive(itemGo, true)

		targetItem.itemGo = itemGo
		targetItem.goTargetRoot = gohelper.findChild(itemGo, "#go_Target")
		targetItem.imageRole = gohelper.findChildImage(itemGo, "#go_Target/role/simage_role")
		targetItem.txtScoreAdd = gohelper.findChildText(itemGo, "#go_Target/#txt_ScoreAdd")
		targetItem.txtScoreReduce = gohelper.findChildText(itemGo, "#go_Target/#txt_ScoreReduce")
		targetItem.txtIndex = gohelper.findChildText(itemGo, "#go_Target/#txt_index")
		targetItem.canvasGroup = gohelper.findChildComponent(itemGo, "#go_Target", gohelper.Type_CanvasGroup)
		targetItem.goFriendBg = gohelper.findChild(itemGo, "#go_Target/BaseBG1")
		targetItem.goEnemyBg = gohelper.findChild(itemGo, "#go_Target/BaseBG2")
		targetItem.goAxe = gohelper.findChild(itemGo, "#go_Target/#go_Axe")
		targetItem.goCombo = gohelper.findChild(itemGo, "#go_Target/Combo")
		targetItem.txtComboScore = gohelper.findChildText(itemGo, "#go_Target/Combo/#txt_ComboNum")

		gohelper.setActive(item.goAxe, true)

		targetItem.animator = gohelper.findChildComponent(itemGo, "", gohelper.Type_Animator)
		self._targetItemListDic[index] = targetItem

		local posItem = self._posItemList[index]

		itemGo.transform.localPosition = posItem.transform.localPosition
		targetItem.hitAnimGoList = self:getUserDataTb_()

		local targetConfigList = AtomicOperationActivityConfig.instance:getTargetConfigList()

		for _, targetConfig in ipairs(targetConfigList) do
			local singleAnimGo = gohelper.findChild(itemGo, "#go_Target/#go_Hit" .. targetConfig.id)

			table.insert(targetItem.hitAnimGoList, singleAnimGo)
		end
	end

	return self._targetItemListDic[index]
end

function AtomicOperationActivityGameView:refreshItem(targetMo)
	local item = self:getTargetItem(targetMo.index)
	local targetConfig = AtomicOperationActivityConfig.instance:getTargetConfig(targetMo.targetId)
	local isAdd = targetConfig.firstScore >= 0

	gohelper.setActive(item.txtScoreAdd, false)
	gohelper.setActive(item.txtScoreReduce, false)
	gohelper.setActive(item.goCombo, false)
	gohelper.setActive(item.goEnemyBg, isAdd)
	gohelper.setActive(item.goFriendBg, not isAdd)
	gohelper.setActive(item.txtIndex, false)

	local score = tostring(targetConfig.firstScore)

	item.txtScoreAdd.text = score
	item.txtScoreReduce.text = score
	item.txtIndex.text = score
	item.txtComboScore.text = tostring(targetConfig.firstScore + targetConfig.afterScore)

	UISpriteSetMgr.instance:setSp02AtomicActivityIconSprite(item.imageRole, "sp02_activitygame_robot_" .. tostring(targetConfig.prefab) .. "_1")
end

function AtomicOperationActivityGameView:onStartGame()
	self:refreshTime()
	self._countDownAnimator:Play("idle", 0, 0)
	TaskDispatcher.runRepeat(self.refreshTime, self, AtomicOperationActivityEnum.DelayTime.GameTimeRefresh)
	gohelper.setActive(self._goTime, true)
end

function AtomicOperationActivityGameView:refreshTime()
	local remainTime = math.ceil(self.logicData.remainTime)
	local showWarring = remainTime <= self.logicData.countDownErrorStateTime

	gohelper.setActive(self._goWarning, showWarring)

	self._txtnumcountdown.text = TimeUtil.second2TimeString(remainTime)

	if not self.showWarring and showWarring then
		self._countDownAnimator:Play("countdown", 0, 0)
	end

	if showWarring then
		if remainTime > 0 then
			local deltaTime = self.logicData.remainTime - remainTime

			if deltaTime < 0.2 and deltaTime > -0.2 then
				AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_activity_countdown)
			end
		else
			AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_activity_reward_ending)
		end
	end

	self.showWarring = showWarring
end

function AtomicOperationActivityGameView:onEndGame()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self._countDownAnimator:Play("idle", 0, 0)
	self:clearTweenList()
end

function AtomicOperationActivityGameView:onRemoveTarget(tempRemoveList)
	if self.logicData then
		for _, index in ipairs(tempRemoveList) do
			self:setTargetItemActive(index, false)
		end
	end
end

function AtomicOperationActivityGameView:setTargetItemActive(index, active)
	local item = self:getTargetItem(index)

	gohelper.setActive(item.goTargetRoot, active)
	item.animator:Play("empty", 0, 0)
end

function AtomicOperationActivityGameView:onAddTarget(tempAddList)
	if self.logicData then
		for _, index in ipairs(tempAddList) do
			self:setTargetItemActive(index, true)

			local targetMo = self.logicData.singleTargetDic[index]

			self:refreshItem(targetMo)
			self:changeTargetItemState(index, targetMo.state)
		end
	end
end

function AtomicOperationActivityGameView:changeTargetItemState(index, state)
	if self.logicData then
		local item = self:getTargetItem(index)
		local targetMo = self.logicData:getTargetNode(index)

		if self._targetItemTweenDic[index] then
			ZProj.TweenHelper.KillById(self._targetItemTweenDic[index])
		end

		if state == AtomicOperationActivityEnum.TargetState.HitDisappear then
			-- block empty
		elseif state == AtomicOperationActivityEnum.TargetState.Disappear then
			item.animator:Play("down", 0, 0)
		elseif state == AtomicOperationActivityEnum.TargetState.Normal then
			item.animator:Play("up", 0, 0)
		else
			local targetConfig = AtomicOperationActivityConfig.instance:getTargetConfig(targetMo.targetId)
			local isAdd = targetConfig.firstScore >= 0
			local showBigNum = targetConfig.id == AtomicOperationActivityEnum.TargetId.Boss
			local isCombo = self.logicData.comboCount >= AtomicOperationActivityEnum.ComboLimit

			gohelper.setActive(item.txtScoreAdd, isAdd and showBigNum and not isCombo)
			gohelper.setActive(item.txtIndex, isAdd and not showBigNum and not isCombo)
			gohelper.setActive(item.txtScoreReduce, not isAdd)
			gohelper.setActive(item.goCombo, isCombo)

			if not isAdd then
				AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_yuanzheng_debuff_poison)
			elseif showBigNum then
				AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_bulaochuan_laser_hit)
			else
				AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_yuanzheng_daji)
			end

			self:refreshScore()
			item.animator:Play("click", 0, 0)

			for targetId, animGo in ipairs(item.hitAnimGoList) do
				gohelper.setActive(animGo, targetConfig.id == targetId)
			end

			gohelper.setAsLastSibling(item.itemGo)
		end
	end
end

function AtomicOperationActivityGameView:refreshScore()
	local curScore = self.logicData.curScore

	if self.previousScore then
		local animName = curScore > self.previousScore and "add" or "lose"

		self._scoreAnimator:Play(animName, 0, 0)
		TaskDispatcher.cancelTask(self.returnScoreAnimToNormal, self)
		TaskDispatcher.runDelay(self.returnScoreAnimToNormal, self, AtomicOperationActivityEnum.DelayTime.AddScore)
	end

	self.previousScore = curScore
	self._txtScoreNum.text = tostring(self.logicData.curScore)

	local isCombo = self.logicData.comboCount >= AtomicOperationActivityEnum.ComboLimit

	if self.isCombo then
		if isCombo then
			self._comboAnimator:Play("add", 0, 0)
		else
			self._comboAnimator:Play("close", 0, 0)
		end
	elseif isCombo then
		self._comboAnimator:Play("open", 0, 0)
	end

	self.isCombo = isCombo

	if isCombo then
		self._txtCombo.text = tostring(self.logicData.comboCount)
	end
end

function AtomicOperationActivityGameView:returnScoreAnimToNormal()
	TaskDispatcher.cancelTask(self.returnScoreAnimToNormal, self)
	self._scoreAnimator:Play("idle", 0, 0)
end

function AtomicOperationActivityGameView:clearTweenList()
	if self._targetItemTweenDic and next(self._targetItemTweenDic) then
		for _, id in pairs(self._targetItemTweenDic) do
			ZProj.TweenHelper.KillById(id)
		end
	end
end

function AtomicOperationActivityGameView:onChangeState(index, state)
	self:changeTargetItemState(index, state)
end

function AtomicOperationActivityGameView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self:clearTweenList()
end

function AtomicOperationActivityGameView:onClickClose()
	AtomicOperationActivityGameController.instance:tryEndGame()
end

function AtomicOperationActivityGameView:onDestroyView()
	TaskDispatcher.cancelTask(self.returnScoreAnimToNormal, self)

	for _, item in ipairs(self._targetItemListDic) do
		tabletool.clear(item.hitAnimGoList)
	end
end

return AtomicOperationActivityGameView
