-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseGameView.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseGameView", package.seeall)

local AssassinChaseGameView = class("AssassinChaseGameView", BaseView)

function AssassinChaseGameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goSelect = gohelper.findChild(self.viewGO, "#go_Select")
	self._goItem = gohelper.findChild(self.viewGO, "#go_Select/Right/Choose/#go_Item")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Select/Right/Choose/#go_Item/#image_Icon")
	self._txtPath = gohelper.findChildText(self.viewGO, "#go_Select/Right/Choose/#go_Item/#txt_Path")
	self._txtTargetDescr = gohelper.findChildText(self.viewGO, "#go_Select/Right/Choose/#go_Item/#txt_TargetDescr")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Select/Right/Choose/#go_Item/#go_Selected")
	self._txtSelectTips = gohelper.findChildText(self.viewGO, "#go_Select/Right/#txt_SelectTips")
	self._btnOK = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Select/Right/#btn_OK")
	self._goProgress = gohelper.findChild(self.viewGO, "#go_Progress")
	self._txtProgress = gohelper.findChildText(self.viewGO, "#go_Progress/#txt_Progress")
	self._txtProgressTips = gohelper.findChildText(self.viewGO, "#go_Progress/#txt_ProgressTips")
	self._btnChoose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Progress/Right/#btn_Choose")
	self._imageCurDirectionIcon = gohelper.findChildImage(self.viewGO, "#go_Progress/Right/#btn_Choose/#image_CurDirectionIcon")
	self._txtCurDirectionPath = gohelper.findChildText(self.viewGO, "#go_Progress/Right/#btn_Choose/#txt_CurDirectionPath")
	self._btnChange = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Progress/Right/#btn_Change")
	self._txtChangeTips = gohelper.findChildText(self.viewGO, "#go_Progress/Right/#btn_Change/#txt_ChangeTips")
	self._goResult = gohelper.findChild(self.viewGO, "#go_Result")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#go_Result/#simage_Mask")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_Result/Right/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_Result/Right/#go_fail")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Result/Right/#txt_Desc")
	self._goreward = gohelper.findChild(self.viewGO, "#go_Result/Right/#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_Result/Right/#go_reward/#go_rewardItem")
	self._btnfinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Result/Right/LayoutGroup/#btn_finish")
	self._btnnewGame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Result/Right/LayoutGroup/#btn_newGame")
	self._txtGameTimes = gohelper.findChildText(self.viewGO, "#go_Result/Right/LayoutGroup/#btn_newGame/#txt_GameTimes")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinChaseGameView:addEvents()
	self._btnOK:AddClickListener(self._btnOKOnClick, self)
	self._btnChoose:AddClickListener(self._btnChooseOnClick, self)
	self._btnChange:AddClickListener(self._btnChangeOnClick, self)
	self._btnfinish:AddClickListener(self._btnfinishOnClick, self)
	self._btnnewGame:AddClickListener(self._btnnewGameOnClick, self)
	self.addEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnSelectDirection, self.onSelectDirection, self)
	self.addEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, self.onGetInfoUpdate, self)
	self.addEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, self.onGetReward, self)
	self.addEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnDialogueEnd, self.refreshState, self)
end

function AssassinChaseGameView:removeEvents()
	self._btnOK:RemoveClickListener()
	self._btnChoose:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnfinish:RemoveClickListener()
	self._btnnewGame:RemoveClickListener()
	self.removeEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnSelectDirection, self.onSelectDirection, self)
	self.removeEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, self.onGetInfoUpdate, self)
	self.removeEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, self.onGetReward, self)
	self.removeEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnDialogueEnd, self.refreshState, self)
end

function AssassinChaseGameView:_btnOKOnClick()
	if not AssassinChaseModel.instance:isCurActOpen(true) then
		return
	end

	local curSelectId = AssassinChaseModel.instance:getCurDirectionId()

	if curSelectId == nil then
		GameFacade.showToast(ToastEnum.AssassinChaseSelectDirectionTip)

		return
	end

	local infoMo = AssassinChaseModel.instance:getCurInfoMo()

	if infoMo == nil then
		logError("奥德赛 下半活动 追逐游戏活动 信息不存在")

		return
	end

	if infoMo:isSelect() and infoMo:canChangeDirection() == false then
		local changeEndStr = TimeUtil.timestampToString4(infoMo.changeEndTime)

		GameFacade.showToast(ToastEnum.AssassinChaseChangeTimeEndTip, changeEndStr)

		return
	end

	AssassinChaseController.instance:selectionDirection(infoMo.activityId, curSelectId)
end

function AssassinChaseGameView:_btnChooseOnClick()
	self:_btnChangeOnClick()
end

function AssassinChaseGameView:_btnChangeOnClick()
	local infoMo = AssassinChaseModel.instance:getCurInfoMo()
	local nowTime = ServerTime.now()
	local changeTime = infoMo.changeEndTime

	if changeTime <= nowTime then
		local changeEndStr = TimeUtil.timestampToString4(changeTime)

		GameFacade.showToast(ToastEnum.AssassinChaseChangeTimeEndTip, changeEndStr)

		return
	end

	local constChangeTimeConfig = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.DirectionChangeCount)
	local maxChangeTime = tonumber(constChangeTimeConfig.value)

	if infoMo.chosenInfo.reselectedNum ~= nil and maxChangeTime <= infoMo.chosenInfo.reselectedNum then
		GameFacade.showToast(ToastEnum.AssassinChaseChangeNumsLimitTip)

		return
	end

	self:changeState(AssassinChaseEnum.ViewState.Select)
end

function AssassinChaseGameView:_btnfinishOnClick()
	self:closeThis()
end

function AssassinChaseGameView:_btnnewGameOnClick()
	if not AssassinChaseModel.instance:isCurActOpen(true) then
		return
	end

	self:refreshUI(false)
end

function AssassinChaseGameView:_editableInitView()
	self._goItemParent = gohelper.findChild(self.viewGO, "#go_Select/Right/Choose")

	gohelper.setActive(self._goItem, false)

	self._optionItemList = {}
	self._useOptionItemList = {}
	self._rewardItemList = {}

	gohelper.setActive(self._gorewardItem, false)

	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._loader = SequenceAbLoader.New()

	for _, path in ipairs(AssassinChaseEnum.SpineResPath) do
		self:addResToLoader(self._loader, path)
	end

	self:addResToLoader(self._loader, AssassinChaseEnum.MaterialResPath)
	self._loader:setConcurrentCount(10)
	self._loader:setLoadFailCallback(self._onLoadOneFail)
	self._loader:startLoad(self._onLoadFinish, self)

	self._bgAnimation = gohelper.findChildComponent(self.viewGO, "BG", gohelper.Type_Animation)
	self._bgAnimation2 = gohelper.findChildComponent(self.viewGO, "BG_Top", gohelper.Type_Animation)
end

function AssassinChaseGameView:addResToLoader(loader, path)
	loader:addPath(path)
end

function AssassinChaseGameView:_onLoadOneFail(loader, assetItem)
	logError(string.format("%s:_onLoadOneFail 加载失败, url:%s", self.__cname, assetItem.ResPath))

	if self._callbackFunc and self._callbackObj then
		self._callbackFunc(self._callbackObj)
	end

	self._callbackFunc = nil
	self._callbackObj = nil
end

function AssassinChaseGameView:_onLoadFinish(loader)
	local materialResPath = AssassinChaseEnum.MaterialResPath
	local materialAssetItem = loader:getAssetItem(materialResPath)
	local replaceMaterial = materialAssetItem:GetResource(materialResPath)

	self._spineList = {}

	local spineAllParent = gohelper.findChild(self.viewGO, "Anim")

	for index, path in ipairs(AssassinChaseEnum.SpineResPath) do
		local prefabAssetItem = loader:getAssetItem(path)

		if not prefabAssetItem then
			logError("can not find :" .. path)
		else
			local prefab = prefabAssetItem:GetResource(path)
			local spineGoParent = spineAllParent.transform:GetChild(index - 1)
			local spineGo = gohelper.clone(prefab, spineGoParent.gameObject, "spine")
			local spineItem = MonoHelper.addNoUpdateLuaComOnceToGo(spineGoParent.gameObject, AssassinChaseSpineItem)

			spineItem:replaceMaterial(replaceMaterial)
			table.insert(self._spineList, spineItem)
		end
	end

	if self._callbackFunc and self._callbackObj then
		self._callbackFunc(self._callbackObj)
	end

	self._callbackFunc = nil
	self._callbackObj = nil
end

function AssassinChaseGameView:onUpdateParam()
	return
end

function AssassinChaseGameView:onOpen()
	self.actId = AssassinChaseModel.instance:getCurActivityId()
	self.infoMo = AssassinChaseModel.instance:getCurInfoMo()

	self:refreshUI(true)
end

function AssassinChaseGameView:onGetInfoUpdate()
	logNormal("act206 onGetInfoUpdate")

	if self.state ~= AssassinChaseEnum.ViewState.Result then
		logNormal("act206 onGetInfoUpdate result")
		self:refreshUI(false)
	end
end

function AssassinChaseGameView:refreshUI(isOpen)
	self:refreshState(isOpen)
end

function AssassinChaseGameView:refreshState(isOpen)
	if ViewMgr.instance:isOpen(ViewName.AssassinChaseChatView) then
		ViewMgr.instance:closeView(ViewName.AssassinChaseChatView)
	end

	local infoMo = self.infoMo
	local state = infoMo:getCurState()

	self:changeState(state, isOpen)
end

function AssassinChaseGameView:changeState(state, isOpen)
	logNormal("act206 changeState")

	local stateFunction = state == AssassinChaseEnum.ViewState.Select and (isOpen and self.refreshChatState or self.refreshSelectState) or state == AssassinChaseEnum.ViewState.Result and self.refreshResultState or self.refreshProgressState

	self.state = state
	self.isOpen = isOpen

	TaskDispatcher.cancelTask(self.delayRefreshNodeState, self)

	if isOpen then
		self:delayRefreshNodeState()
	else
		TaskDispatcher.runDelay(self.delayRefreshNodeState, self, 0.167)
	end

	if state ~= AssassinChaseEnum.ViewState.Result then
		self:playAnim(state, isOpen)
	end

	if self._spineList then
		stateFunction(self)
	else
		self._callbackFunc = stateFunction
		self._callbackObj = self
	end
end

function AssassinChaseGameView:delayRefreshNodeState()
	local state = self.state
	local isOpen = self.isOpen

	logNormal("delayRefreshNodeState")
	TaskDispatcher.cancelTask(self.delayRefreshNodeState, self)
	gohelper.setActive(self._goSelect, state == AssassinChaseEnum.ViewState.Select and not isOpen)
	gohelper.setActive(self._goProgress, state == AssassinChaseEnum.ViewState.Progress)
	gohelper.setActive(self._goResult, state == AssassinChaseEnum.ViewState.Result)
end

function AssassinChaseGameView:refreshSpineState(state)
	if not state then
		return
	end

	local spineState
	local infoMo = AssassinChaseModel.instance:getCurInfoMo()

	self:playSpine(state == AssassinChaseEnum.ViewState.Select and (infoMo:isSelect() and AssassinChaseEnum.SpineState.Walk or AssassinChaseEnum.SpineState.Idle) or state == AssassinChaseEnum.ViewState.Result and AssassinChaseEnum.SpineState.Walk or AssassinChaseEnum.SpineState.Walk)

	local otherRoleItem = self._spineList[AssassinChaseEnum.OtherRoleIndex]

	gohelper.setActive(otherRoleItem.go, infoMo:isSelect() or state ~= AssassinChaseEnum.ViewState.Select)
end

function AssassinChaseGameView:setOtherRolePosition(offset, isTween, time)
	if self._spineList then
		local otherRoleItem = self._spineList[AssassinChaseEnum.OtherRoleIndex]

		if otherRoleItem then
			otherRoleItem:setRolePosition(offset, isTween, time)
		end
	end
end

function AssassinChaseGameView:setMainRolePosition(offset, isTween, time)
	if self._spineList then
		for index, item in ipairs(self._spineList) do
			if index ~= AssassinChaseEnum.OtherRoleIndex then
				item:setRolePosition(offset, isTween, time)
			end
		end
	end
end

function AssassinChaseGameView:playSpine(spineState, showBubble)
	if self._spineList then
		for index, spineItem in ipairs(self._spineList) do
			local spineName

			spineItem:play(index == AssassinChaseEnum.MainRoleIndex and AssassinChaseEnum.MainRoleSpineState[spineState] or AssassinChaseEnum.OtherRoleSpineState[spineState], true, false)
			spineItem:setBubbleActive(showBubble)
		end
	end
end

function AssassinChaseGameView:playAnim(state, isOpen)
	local animName

	if isOpen then
		animName = "open"
	elseif state == AssassinChaseEnum.ViewState.Select then
		animName = "to_select"

		AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_tan)
	else
		animName = state == AssassinChaseEnum.ViewState.Result and "finish" or "to_progress"
	end

	self._animator:Play(animName, 0, 0)
	logNormal("act206 playAnim AnimName: " .. animName .. " isOpen：" .. tostring(isOpen))
end

function AssassinChaseGameView:playBgLoop(isPlay)
	if isPlay then
		self._bgAnimation:Play()
		self._bgAnimation2:Play()
	else
		self._bgAnimation:Stop()
		self._bgAnimation2:Stop()
	end
end

function AssassinChaseGameView:refreshChatState()
	logNormal("对话")
	self:refreshSpineState(self.state)
	self:setMainRolePosition(-100, false)
	self:setOtherRolePosition(-100, false)
	AssassinChaseController.instance:openDialogueView(self.actId)
	self:playBgLoop(false)
end

function AssassinChaseGameView:refreshSelectState()
	self:refreshSpineState(self.state)

	local infoMo = self.infoMo

	if infoMo:isSelect() then
		self:playBgLoop(true)
		self:setMainRolePosition(-50, true, 0.5)
		self:setOtherRolePosition(200, true, 0.5)
	else
		self:playBgLoop(false)
		self:setMainRolePosition(-100, false)
		self:setOtherRolePosition(-100, false)
	end

	local optionIds = infoMo.optionDirections
	local optionItemList = self._optionItemList
	local optionCount = #optionIds
	local optionItemCount = #optionItemList

	tabletool.clear(self._useOptionItemList)

	for index, optionId in ipairs(optionIds) do
		local optionItem

		if optionItemCount < index then
			local itemGo = gohelper.clone(self._goItem, self._goItemParent)

			optionItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, AssassinChaseOptionItem)

			table.insert(self._optionItemList, optionItem)
		else
			optionItem = optionItemList[index]
		end

		table.insert(self._useOptionItemList, optionItem)
		optionItem:setActive(true)
		optionItem:setData(infoMo.activityId, optionId)
	end

	if optionCount < optionItemCount then
		for i = optionIds + 1, optionItemCount do
			local item = optionItemList[i]

			item:clear()
		end
	end

	local todayEndTime = ServerTime.getToadyEndTimeStamp()
	local changeEndTime = todayEndTime + infoMo.nextDayChangeOffset
	local changeEndStr = TimeUtil.timestampToString4(changeEndTime)

	self._txtSelectTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLangUTC("assassinChase_change_direction_time_tip"), changeEndStr)
end

function AssassinChaseGameView:onSelectDirection(directionId)
	for _, optionItem in ipairs(self._useOptionItemList) do
		optionItem:setSelect(directionId)
		AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_common_click_chase)
	end
end

function AssassinChaseGameView:refreshProgressState()
	self:refreshSpineState(self.state)

	local isOpen = self.isOpen

	if isOpen then
		self:setMainRolePosition(-50, false)
		self:setOtherRolePosition(200, false)
	else
		self:setMainRolePosition(-50, true, 0.5)
		self:setOtherRolePosition(200, true, 0.5)
	end

	self:playBgLoop(true)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_run)

	local infoMo = self.infoMo
	local dayEndTime = infoMo.rewardTime
	local changeEndTime = infoMo.changeEndTime
	local dayEndStr = TimeUtil.timestampToString4(dayEndTime)
	local changeEndStr = TimeUtil.timestampToString4(changeEndTime)
	local dayEndDesc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLangUTC("assassinChase_get_reward_time_tip"), dayEndStr)

	self._txtProgressTips.text = dayEndDesc

	local constChangeTimeConfig = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.DirectionChangeCount)
	local maxChangeTime = tonumber(constChangeTimeConfig.value)

	self._txtChangeTips.text = infoMo.chosenInfo.reselectedNum ~= nil and maxChangeTime <= infoMo.chosenInfo.reselectedNum and dayEndDesc or GameUtil.getSubPlaceholderLuaLangOneParam(luaLangUTC("assassinChase_change_direction_time_tip"), changeEndStr)

	local directionId = infoMo.chosenInfo.currentDirection
	local optionConfig = AssassinChaseConfig.instance:getDirectionConfig(self.actId, directionId)

	if optionConfig == nil then
		logError("奥德赛 下半活动 追逐游戏活动 方向id不存在 id:" .. directionId)
		self:clear()

		return
	end

	self._txtCurDirectionPath.text = optionConfig.name

	if string.nilorempty(optionConfig.pic) then
		return
	end

	UISpriteSetMgr.instance:setSp01Act205Sprite(self._imageCurDirectionIcon, optionConfig.pic)
end

function AssassinChaseGameView:refreshResultState()
	logNormal("act206 refreshResultState")
	self:refreshSpineState(self.state)
	self:playBgLoop(true)
	self:setMainRolePosition(-50, false)
	self:setOtherRolePosition(200, false)
	self:setMainRolePosition(25, true, 0.5)
	self:setOtherRolePosition(-25, true, 1.1)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_run)
	self:autoGetReward()

	local infoMo = self.infoMo

	if infoMo == nil then
		logError("奥德赛 下半活动 追逐游戏活动 信息不存在")

		return
	end

	local config = AssassinChaseConfig.instance:getRewardConfig(infoMo.chosenInfo.rewardId)

	self._txtDesc.text = config.des

	self:refreshReward(infoMo.chosenInfo.rewardId, config.reward)
end

function AssassinChaseGameView:onOtherRoleFinish()
	TaskDispatcher.cancelTask(self.onOtherRoleFinish, self)
end

function AssassinChaseGameView:onMainRoleFinish()
	TaskDispatcher.cancelTask(self.onMainRoleFinish, self)
end

function AssassinChaseGameView:autoGetReward()
	self:_lockScreen(true)
	logNormal("奥德赛 下半追逐游戏 自动领奖")
	TaskDispatcher.cancelTask(self.playFinishAnim, self)
	TaskDispatcher.runDelay(self.playFinishAnim, self, 1.2)
end

function AssassinChaseGameView:playFinishAnim()
	TaskDispatcher.cancelTask(self.playFinishAnim, self)
	self:playAnim(self.state)
	self:playSpine(AssassinChaseEnum.SpineState.Skill, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_win_chase)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.stop_ui_s01_yunying_run)
	self:playBgLoop(false)
	TaskDispatcher.runDelay(self.getReward, self, 1.2)
end

function AssassinChaseGameView:getReward()
	TaskDispatcher.cancelTask(self.getReward, self)

	local activityId = self.actId

	AssassinChaseController.instance:getReward(activityId)
end

function AssassinChaseGameView:onGetReward()
	logNormal("奥德赛 下半追逐游戏 领奖")

	for _, item in ipairs(self._rewardItemList) do
		item:setGetState(true)
	end

	self:_lockScreen(false)
end

function AssassinChaseGameView:refreshReward(rewardId, rewardParam)
	local haveReward = not string.nilorempty(rewardParam)

	gohelper.setActive(self._goreward, haveReward)

	if haveReward == false then
		logError("奥德赛 下半活动 追逐游戏活动 奖励为空 id:" .. rewardId)

		return
	end

	local singleRewardParams = string.split(rewardParam, "|")
	local itemList = self._rewardItemList
	local itemCount = #itemList
	local rewardCount = #singleRewardParams

	for index, singleRewardParam in ipairs(singleRewardParams) do
		local rewardItem

		if itemCount < index then
			local itemGo = gohelper.clone(self._gorewardItem, self._goreward)

			rewardItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, AssassinChaseRewardItem)

			table.insert(itemList, rewardItem)
		else
			rewardItem = itemList[index]
		end

		rewardItem:setActive(true)
		rewardItem:setGetState(false)
		rewardItem:setData(singleRewardParam)
	end

	if rewardCount < itemCount then
		for i = rewardCount + 1, itemCount do
			local item = itemList[i]

			item:setActive(false)
		end
	end
end

function AssassinChaseGameView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AssassinChaseResultView")
		TaskDispatcher.runDelay(self.forceEndLock, self, AssassinChaseEnum.ForceEndLockTime)
	else
		UIBlockMgr.instance:endBlock("AssassinChaseResultView")
		UIBlockMgrExtend.setNeedCircleMv(true)
		TaskDispatcher.cancelTask(self.forceEndLock, self)
	end
end

function AssassinChaseGameView:forceEndLock()
	self:_lockScreen(false)
	logError("奥德赛 下半活动 自动领奖失效")
end

function AssassinChaseGameView:onClose()
	TaskDispatcher.cancelTask(self.forceEndLock, self)
	TaskDispatcher.cancelTask(self.getReward, self)
	TaskDispatcher.cancelTask(self.playFinishAnim, self)
	TaskDispatcher.cancelTask(self.delayRefreshNodeState, self)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.stop_ui_s01_yunying_run)

	local infoMo = self.infoMo

	if infoMo:isSelect() and ViewMgr.instance:isOpen(ViewName.Act205GameStartView) then
		ViewMgr.instance:closeView(ViewName.Act205GameStartView)
	end
end

function AssassinChaseGameView:onDestroyView()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return AssassinChaseGameView
