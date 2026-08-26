-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpGameView.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpGameView", package.seeall)

local ActivityWarmUpGameView = class("ActivityWarmUpGameView", BaseView)

function ActivityWarmUpGameView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebase = gohelper.findChildSingleImage(self.viewGO, "#go_progress/#simage_base")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "#simage_map")
	self._gocanvas = gohelper.findChild(self.viewGO, "#go_canvas")
	self._gobottle = gohelper.findChild(self.viewGO, "#go_bottle")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._gointerval = gohelper.findChild(self.viewGO, "#go_progress/#go_interval")
	self._btntrigger = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_trigger")
	self._txttrigger = gohelper.findChildText(self.viewGO, "#btn_trigger/#txt_trigger")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._gotargeticon = gohelper.findChild(self.viewGO, "go_targets/targets/#go_targeticon")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "remaintimebg/#txt_remaintime")
	self._imagebottle = gohelper.findChildImage(self.viewGO, "#go_bottle/#image_bottle")
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_result/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_result/#go_fail")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_mask")
	self._gobottletarget = gohelper.findChild(self.viewGO, "bottle/hu/#go_bottletarget")
	self._gobottlecurveleft = gohelper.findChild(self.viewGO, "bottle/hu/#go_bottlecurveleft")
	self._gobottlecurveright = gohelper.findChild(self.viewGO, "bottle/hu/#go_bottlecurveright")
	self._btnhome = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#go_fail/#btn_home")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#go_fail/#btn_restart")
	self._imageremaintip = gohelper.findChildImage(self.viewGO, "remaintimebg/#image_remaintip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpGameView:addEvents()
	self._btntrigger:AddClickListener(self._btntriggerOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnhome:AddClickListener(self._btnhomeOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function ActivityWarmUpGameView:removeEvents()
	self._btnrestart:RemoveClickListener()
	self._btntrigger:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnhome:RemoveClickListener()
end

ActivityWarmUpGameView.ProgressUIWidth = 940.79

function ActivityWarmUpGameView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("full/bj002"))
	self._simagemap:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi2"))
	self._simagebase:LoadImage(ResUrl.getActivityWarmUpBg("bg_xiadi"))
	self._simagemask:LoadImage(ResUrl.getActivityWarmUpBg("bg_bodian"))

	self._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(self._simagemask.gameObject, SingleBgToMaterial)

	self._bgMaterial:loadMaterial(self._simagemask, "ui_black2transparent")

	self._tfProgress = self._goprogress.transform
	self._goblackbg = gohelper.findChild(self.viewGO, "#go_result/blackbg")
	self._btnblackbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/blackbg")
	self._animBtnTrigger = self._btntrigger:GetComponent(typeof(UnityEngine.Animator))
	self._goAnimCountDown = gohelper.findChild(self.viewGO, "remaintimebg")
	self._animCountDown = self._goAnimCountDown:GetComponent(typeof(UnityEngine.Animator))

	local goTargetIcons = gohelper.findChild(self.viewGO, "go_targets")

	self._animTargetIcons = goTargetIcons:GetComponent(typeof(UnityEngine.Animator))

	local goBottle = gohelper.findChild(self.viewGO, "bottle")

	self._animBottle = goBottle:GetComponent(typeof(UnityEngine.Animator))
	self._flyTargetPos = self._gobottletarget.transform.position
	self._flyCurveLeftPos = self._gobottlecurveleft.transform.position
	self._flyCurveRightPos = self._gobottlecurveright.transform.position

	self.addEventCb(self, ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameTriggerNoHit, self.onGameTriggerNoHit, self)
	self.addEventCb(self, ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameTriggerHit, self.onGameTriggerHit, self)
	self.addEventCb(self, ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameNextRound, self.onGameNextRound, self)
	self.addEventCb(self, ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameOverTimeOut, self.onGameTimeOut, self)
	self.addEventCb(self, ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameOverFinished, self.onGameOverFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCall, self)
	self._btnblackbg:AddClickListener(self._btnblackbgOnClick, self)

	self._targetItems = {}
	self._blockItems = {}
	self._lockAllClick = false
	self._flyIconFlag = {}
	self._rectBottle = self._gobottle.transform
end

function ActivityWarmUpGameView:onDestroyView()
	for _, item in pairs(self._blockItems) do
		item.imageIcon:UnLoadImage()
		item.imageIconCur:UnLoadImage()
	end

	for _, item in pairs(self._targetItems) do
		item.imageIcon:UnLoadImage()
	end

	self._simagebg:UnLoadImage()
	self._simagemap:UnLoadImage()
	self._simagebase:UnLoadImage()
	self._bgMaterial:dispose()
	self._btnblackbg:RemoveClickListener()
end

function ActivityWarmUpGameView:onOpen()
	ActivityWarmUpGameController.instance:clearLastResult()
	ActivityWarmUpGameController.instance:prepareGame()

	self._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	self._animBtnTrigger:Play(UIAnimationName.Start)
	self:refreshGameDisplay()
	self:updateForRemainTime()
	self:updateForPointerMove()
	self:allBlocksPlayAnim(UIAnimationName.Idle)
end

function ActivityWarmUpGameView:onOpenFinish()
	self:refreshAllBlocks()
	self:allBlocksPlayAnim(UIAnimationName.Idle)
end

function ActivityWarmUpGameView:onClose()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	ActivityWarmUpGameModel.instance:release()
	TaskDispatcher.cancelTask(self.onLockCountDownCompleted, self)
	TaskDispatcher.cancelTask(self.onSwitchNextRoundCompleted, self)
	TaskDispatcher.cancelTask(self.onRepeatCountdown, self)
	TaskDispatcher.cancelTask(self.onGameClearAnimCompleted, self)
	UIBlockMgr.instance:endBlock(ActivityWarmUpGameView.UI_BLOCK_GAME_CLEAR)

	self._waitingFlyIconNextRound = false
	self._waitingFlyIconGameOver = false

	self:stopAllFlyIcons()
	self:stopEnterFrame()
end

function ActivityWarmUpGameView:onCloseFinish()
	if not ActivityWarmUpGameController.instance:getSaveResult() then
		ActivityWarmUpGameController.instance:dispatchEvent(ActivityWarmUpEvent.NotifyGameCancel)
	end
end

function ActivityWarmUpGameView:_btntriggerOnClick()
	if self._lockAllClick then
		return
	end

	if not ActivityWarmUpGameController.instance:getIsPlaying() then
		gohelper.setActive(self._goresult, false)

		self._txtremaintime.text = ""

		self._animCountDown:Play("countdown")

		self._lockAllClick = true
		self._waitingFlyIconNextRound = false
		self._waitingFlyIconGameOver = false

		gohelper.setActive(self._imageremaintip.gameObject, false)
		AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
		TaskDispatcher.runRepeat(self.onRepeatCountdown, self, 1)
		TaskDispatcher.runDelay(self.onLockCountDownCompleted, self, 3)
	else
		local isCDNow = ActivityWarmUpGameController.instance:getIsCD()

		if not isCDNow then
			self._animBtnTrigger:Play(UIAnimationName.Click, 0, 0)
			ActivityWarmUpGameController.instance:pointerTrigger()
		end
	end
end

function ActivityWarmUpGameView:onRepeatCountdown()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
end

function ActivityWarmUpGameView:onLockCountDownCompleted()
	TaskDispatcher.cancelTask(self.onLockCountDownCompleted, self)
	TaskDispatcher.cancelTask(self.onRepeatCountdown, self)
	gohelper.setActive(self._imageremaintip.gameObject, true)

	self._lockAllClick = false

	self._animCountDown:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:startGame()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.start_pot_boiling)

	self._txttrigger.text = luaLang("p_activitywarmupgameview_add")

	self._animBtnTrigger:Play(UIAnimationName.Idle)
	self._animBottle:Play("bottle")
	self._animTargetIcons:Play(UIAnimationName.Idle)
	TaskDispatcher.runRepeat(self.onEnterFrame, self, 0.01)

	self._isBtnCD = false
	self._flyIconFlag = {}

	self:updateForRemainTime()
	self:updateForTriggerCD()
	self:allBlocksPlayAnim(UIAnimationName.Loop)
end

function ActivityWarmUpGameView:_btnresetOnClick()
	if self._lockAllClick then
		return
	end

	local function onYesCall()
		self:onRestartComfirm()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WarmUpGameReFight, MsgBoxEnum.BoxType.Yes_No, onYesCall)
end

function ActivityWarmUpGameView:onRestartComfirm()
	if ActivityWarmUpGameController.instance:getIsPlaying() then
		AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
		self._animBottle:Play(UIAnimationName.Idle)
		ActivityWarmUpGameController.instance:stopGame()
	end

	gohelper.setActive(self._goresult, false)
	gohelper.setActive(self._btntrigger.gameObject, true)
	ActivityWarmUpGameController.instance:clearLastResult()
	ActivityWarmUpGameController.instance:prepareGame()

	self._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	self._animBtnTrigger:Play(UIAnimationName.Start)

	self._isBtnCD = false
	self._waitingFlyIconNextRound = false
	self._waitingFlyIconGameOver = false

	self:stopEnterFrame()
	self:refreshGameDisplay()
	self:updateForRemainTime()
	self:updateForTriggerCD()
	self:updateForPointerMove()
	self:allBlocksPlayAnim("idle")
end

function ActivityWarmUpGameView:_btnblackbgOnClick()
	gohelper.setActive(self._goresult, false)

	if ActivityWarmUpGameController.instance:getSaveResult() then
		self:closeThis()
	end
end

function ActivityWarmUpGameView:_btnhomeOnClick()
	self:closeThis()
end

function ActivityWarmUpGameView:_btnrestartOnClick()
	gohelper.setActive(self._goresult, false)
	self:onRestartComfirm()
end

function ActivityWarmUpGameView:onCloseViewCall(viewName)
	if viewName == ViewName.CommonPropView and ActivityWarmUpGameController.instance:getSaveResult() then
		self:closeThis()
	end
end

function ActivityWarmUpGameView:onGameTriggerNoHit()
	logNormal("onGameTriggerNoHit")
	ActivityWarmUpGameController.instance:markCDTime()
end

function ActivityWarmUpGameView:onGameTriggerHit(blockData)
	logNormal("onGameTriggerHit")
	self:refreshAllTargetIcons()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.trigger_click_nice)
	self._animBtnTrigger:Play(UIAnimationName.Selected, 0, 0)

	local itemObj = self:getBlockItemByData(blockData)

	if itemObj then
		self._flyIconFlag[itemObj] = true

		TaskDispatcher.runRepeat(ActivityWarmUpGameView.playIconFly, itemObj, 0.01)
	end
end

function ActivityWarmUpGameView:onGameNextRound()
	logNormal("onGameNextRound")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.trigger_click_nice)
	ActivityWarmUpGameController.instance:goNextRound()

	self._lockAllClick = true

	if tabletool.len(self._flyIconFlag) > 0 then
		self._waitingFlyIconNextRound = true

		return
	end

	self:nextRoundPlayAnim()
end

function ActivityWarmUpGameView:checkNextRoundWaitFly()
	if self._waitingFlyIconNextRound and tabletool.len(self._flyIconFlag) <= 0 then
		self:nextRoundPlayAnim()

		return true
	end
end

function ActivityWarmUpGameView:nextRoundPlayAnim()
	self._waitingFlyIconNextRound = false

	self._animTargetIcons:Play(UIAnimationName.Switch)
	TaskDispatcher.runDelay(self.onSwitchNextRoundCompleted, self, 0.16)
end

function ActivityWarmUpGameView:onSwitchNextRoundCompleted()
	TaskDispatcher.cancelTask(self.onSwitchNextRoundCompleted, self)

	self._lockAllClick = false

	self:refreshGameDisplay()
	self:allBlocksPlayAnim(UIAnimationName.Open)
end

function ActivityWarmUpGameView:onGameTimeOut()
	logNormal("onGameTimeOut")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	self._animBottle:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:stopGame()
	self:updateForTriggerCD()
	self:stopEnterFrame()
	gohelper.setActive(self._goresult, true)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._simagemask.gameObject, true)
	gohelper.setActive(self._gofail, true)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.play_game_fail)
end

function ActivityWarmUpGameView:onGameOverFinished()
	logNormal("onGameOverFinished")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	self._animBottle:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:stopGame()
	ActivityWarmUpGameController.instance:saveGameClearResult()
	self:stopEnterFrame()

	self._lockAllClick = true

	if tabletool.len(self._flyIconFlag) > 0 then
		self._waitingFlyIconGameOver = true

		return
	end

	self:gameClear()
end

function ActivityWarmUpGameView:checkGameOverWaitFly()
	if self._waitingFlyIconGameOver and tabletool.len(self._flyIconFlag) <= 0 then
		self._waitingFlyIconGameOver = false

		self:gameClear()

		return true
	end
end

function ActivityWarmUpGameView:onEnterFrame()
	ActivityWarmUpGameController.instance:onGameUpdate()
	self:updateForPointerMove()
	self:updateForRemainTime()
	self:updateForTriggerCD()
end

ActivityWarmUpGameView.UI_BLOCK_GAME_CLEAR = "ActivityWarmUpGameView_gameClear"

function ActivityWarmUpGameView:gameClear()
	self._lockAllClick = false

	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.play_game_victory)
	gohelper.setActive(self._goresult, true)
	gohelper.setActive(self._simagemask.gameObject, false)
	gohelper.setActive(self._gosuccess, true)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._btntrigger.gameObject, false)
	UIBlockMgr.instance:startBlock(ActivityWarmUpGameView.UI_BLOCK_GAME_CLEAR)
	TaskDispatcher.runDelay(self.onGameClearAnimCompleted, self, 1.1)
end

function ActivityWarmUpGameView:onGameClearAnimCompleted()
	TaskDispatcher.cancelTask(self.onGameClearAnimCompleted, self)
	UIBlockMgr.instance:endBlock(ActivityWarmUpGameView.UI_BLOCK_GAME_CLEAR)

	if ActivityWarmUpGameController.instance:getSaveResult() then
		ActivityWarmUpGameController.instance:gameClear()
	end
end

function ActivityWarmUpGameView:onPlayFailCompleted()
	gohelper.setActive(self._goresult, false)
	ActivityWarmUpGameController.instance:prepareGame()

	self._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	self._animBtnTrigger:Play(UIAnimationName.Start)

	self._isBtnCD = false

	self:refreshGameDisplay()
end

function ActivityWarmUpGameView:refreshGameDisplay()
	self:refreshAllTargetIcons()
	self:refreshAllBlocks()
end

ActivityWarmUpGameView.FlyProgressSpeed = 0.05
ActivityWarmUpGameView.IconSelectTime = 0.334

function ActivityWarmUpGameView.playIconFly(itemObj)
	local panel = itemObj.panel

	if not itemObj.progress or not itemObj.targetCurvePos then
		itemObj.progress = 0
		itemObj.posX, itemObj.posY, itemObj.posZ = transformhelper.getPos(itemObj.tfIcon)
		itemObj.posXCur, itemObj.posYCur, itemObj.posZCur = transformhelper.getPos(itemObj.tfIconCur)

		if itemObj.posX > panel._flyTargetPos.x then
			itemObj.targetCurvePos = panel._flyCurveRightPos or panel._flyCurveLeftPos
		end

		if itemObj.posXCur > panel._flyTargetPos.x then
			itemObj.targetCurvePosCur = panel._flyCurveRightPos or panel._flyCurveLeftPos
		end

		itemObj.startTime = Time.time

		itemObj.anim:Play(UIAnimationName.Selected)
		itemObj.animCur:Play(UIAnimationName.Selected)

		itemObj.isPlayGo = false
	end

	if Time.time - itemObj.startTime < ActivityWarmUpGameView.IconSelectTime then
		return
	elseif not itemObj.isPlayGo then
		itemObj.isPlayGo = true

		itemObj.anim:Play("go")
		itemObj.animCur:Play("go")
	end

	local progress = math.min(1, itemObj.progress)
	local cosProgress = math.cos(progress * math.pi * 0.5)
	local tarPosX = Mathf.Lerp(panel._flyTargetPos.x, itemObj.targetCurvePos.x, cosProgress)
	local tarPosY = Mathf.Lerp(panel._flyTargetPos.y, itemObj.targetCurvePos.y, cosProgress)
	local tarPosZ = Mathf.Lerp(panel._flyTargetPos.z, itemObj.targetCurvePos.z, cosProgress)

	transformhelper.setPos(itemObj.tfIcon, Mathf.Lerp(itemObj.posX, tarPosX, progress), Mathf.Lerp(itemObj.posY, tarPosY, progress), Mathf.Lerp(itemObj.posZ, tarPosZ, progress))
	transformhelper.setPos(itemObj.tfIconCur, Mathf.Lerp(itemObj.posXCur, tarPosX, progress), Mathf.Lerp(itemObj.posYCur, tarPosY, progress), Mathf.Lerp(itemObj.posZCur, tarPosZ, progress))

	if progress >= 1 then
		ActivityWarmUpGameView.onPlayIconFlyCompleted(itemObj)

		return
	end

	progress = progress + ActivityWarmUpGameView.FlyProgressSpeed
	itemObj.progress = progress
end

function ActivityWarmUpGameView.onPlayIconFlyCompleted(itemObj)
	local panel = itemObj.panel

	panel._flyIconFlag[itemObj] = nil
	itemObj.targetCurvePos = nil
	itemObj.progress = nil
	itemObj.isPlayGo = false

	TaskDispatcher.cancelTask(ActivityWarmUpGameView.playIconFly, itemObj)

	local rs1 = panel:checkNextRoundWaitFly()
	local rs2 = panel:checkGameOverWaitFly()

	if not rs1 and not rs2 and tabletool.len(panel._flyIconFlag) == 0 then
		panel:refreshAllBlockAfterFly()
	end
end

function ActivityWarmUpGameView:stopAllFlyIcons()
	for _, itemObj in pairs(self._blockItems) do
		TaskDispatcher.cancelTask(ActivityWarmUpGameView.playIconFly, itemObj)

		itemObj.targetCurvePos = nil
		itemObj.progress = nil
		itemObj.isPlayGo = false
		self._flyIconFlag[itemObj] = nil
	end
end

function ActivityWarmUpGameView:refreshAllTargetIcons()
	local targetMatList = ActivityWarmUpGameModel.instance:getTargetMatIDs()

	self:hideAllTargetIcon()

	for i, matID in ipairs(targetMatList) do
		local item = self:getOrCreateIcon(i)
		local isUsed = ActivityWarmUpGameModel.instance:matIsUsed(matID)

		if isUsed then
			gohelper.setActive(item.go, false)
		else
			self:refreshTargetIcon(item, matID, i)
		end
	end
end

function ActivityWarmUpGameView:refreshTargetIcon(item, matID, index)
	gohelper.setActive(item.go, true)

	local _, iconPath = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, matID)

	if not string.nilorempty(iconPath) then
		item.imageIcon:LoadImage(iconPath)
	end
end

function ActivityWarmUpGameView:refreshAllBlocks()
	local blockList = ActivityWarmUpGameModel.instance:getBlockDatas()

	self:stopAllFlyIcons()
	self:hideAllBlock()

	for i, blockData in ipairs(blockList) do
		local item = self:getOrCreateBlock(i)

		self:refreshBlock(item, blockData)
	end
end

function ActivityWarmUpGameView:allBlocksPlayAnim(animName)
	for _, item in pairs(self._blockItems) do
		item.anim:Play(animName, 0, 0)
		item.animCur:Play(animName, 0, 0)
	end
end

function ActivityWarmUpGameView:refreshAllBlockAfterFly()
	local blockList = ActivityWarmUpGameModel.instance:getBlockDatas()
	local blockSet = {}

	for i, blockData in ipairs(blockList) do
		local item = self:getOrCreateBlock(i)

		blockSet[item] = true

		self:refreshBlock(item, blockData)
	end

	for _, item in pairs(self._blockItems) do
		if not blockSet[item] then
			item.blockData = nil

			gohelper.setActive(item.go, false)
		end
	end
end

function ActivityWarmUpGameView:refreshBlock(item, blockData)
	local matID = ActivityWarmUpGameModel.instance:getBindMatByBlock(blockData)

	if matID then
		local _, iconPath = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, matID)

		if not string.nilorempty(iconPath) then
			item.imageIcon:LoadImage(iconPath)
			item.imageIconCur:LoadImage(iconPath)
		end
	end

	gohelper.setActive(item.go, not ActivityWarmUpGameModel.instance:matIsUsed(matID))

	if self._flyIconFlag[item] then
		return
	end

	recthelper.setAnchor(item.tfIcon, item.iconAnchorX, item.iconAnchorY)
	recthelper.setAnchor(item.tfIconCur, item.iconCurAnchorX, item.iconCurAnchorY)

	item.blockData = blockData

	local intervalLen = blockData.endPos - blockData.startPos

	recthelper.setAnchorX(item.rectProgress, ActivityWarmUpGameView.ProgressUIWidth * blockData.startPos)
	recthelper.setWidth(item.rectProgress, ActivityWarmUpGameView.ProgressUIWidth * intervalLen)
	item.anim:Play(UIAnimationName.Loop)
	item.animCur:Play(UIAnimationName.Loop)

	local isTarget = ActivityWarmUpGameModel.instance:isCurrentTarget(blockData)

	gohelper.setActive(item.goNormal, not isTarget)
	gohelper.setActive(item.goCur, isTarget)
end

function ActivityWarmUpGameView:stopEnterFrame()
	TaskDispatcher.cancelTask(self.onEnterFrame, self)
end

function ActivityWarmUpGameView:updateForPointerMove()
	local curX = ActivityWarmUpGameView.ProgressUIWidth * (ActivityWarmUpGameModel.instance.pointerVal - 0.5)

	recthelper.setAnchorX(self._rectBottle, curX)

	local pointerValue = ActivityWarmUpGameModel.instance.pointerVal
	local blockData = ActivityWarmUpGameModel.instance:getBlockDataByPointer(pointerValue)
	local matID = ActivityWarmUpGameModel.instance:getBindMatByBlock(blockData)

	self._imagebottle.color = blockData and not ActivityWarmUpGameModel.instance:matIsUsed(matID) and Color.New(0.9568627, 0.5294118, 0.3176471, 1) or Color.New(1, 1, 1, 1)
end

function ActivityWarmUpGameView:updateForRemainTime()
	local remainTime = ActivityWarmUpGameController.instance:getRemainTime() or ActivityWarmUpGameController.instance:getSettingRemainTime()

	if remainTime ~= nil then
		self._txtremaintime.text = tostring(remainTime)

		if remainTime ~= self._lastRemainTime then
			if ActivityWarmUpGameController.instance:getIsPlaying() then
				AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
			end

			self._lastRemainTime = remainTime
		end
	else
		self._txtremaintime.text = ""
	end
end

function ActivityWarmUpGameView:updateForTriggerCD()
	self._isBtnCD = ActivityWarmUpGameController.instance:getIsCD()

	ZProj.UGUIHelper.SetGrayscale(self._btntrigger.gameObject, self._isBtnCD)
end

function ActivityWarmUpGameView:getOrCreateBlock(index)
	local item = self._blockItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gointerval, "item_interval_" .. tostring(index))

		item.go = go
		item.imageProgress = gohelper.findChildImage(go, "#image_interval")
		item.imageIcon = gohelper.findChildSingleImage(go, "#image_interval/go_normal/#simage_icon")
		item.imageIconCur = gohelper.findChildSingleImage(go, "#image_interval/go_next/#simage_icon")
		item.tfIcon = item.imageIcon.transform
		item.tfIconCur = item.imageIconCur.transform
		item.rect = go.transform
		item.rectProgress = item.imageProgress.transform
		item.panel = self

		local animGo = gohelper.findChild(go, "#image_interval/go_normal")

		item.anim = animGo:GetComponent(typeof(UnityEngine.Animator))
		item.goNormal = animGo
		animGo = gohelper.findChild(go, "#image_interval/go_next")
		item.animCur = animGo:GetComponent(typeof(UnityEngine.Animator))
		item.goCur = animGo
		item.iconAnchorX, item.iconAnchorY = recthelper.getAnchor(item.tfIcon)
		item.iconCurAnchorX, item.iconCurAnchorY = recthelper.getAnchor(item.tfIconCur)
		item.iconPos = item.rect.position
		self._blockItems[index] = item
	end

	return item
end

function ActivityWarmUpGameView:getBlockItemByData(blockData)
	for _, itemObj in pairs(self._blockItems) do
		if itemObj.blockData == blockData then
			return itemObj
		end
	end
end

function ActivityWarmUpGameView:getOrCreateIcon(index)
	local item = self._targetItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gotargeticon, "item_icon_" .. tostring(index))

		item.go = go
		item.imageIcon = gohelper.findChildSingleImage(go, "#simage_icon")
		item.rect = go.transform
		self._targetItems[index] = item
	end

	return item
end

function ActivityWarmUpGameView:hideAllTargetIcon()
	for _, item in pairs(self._targetItems) do
		gohelper.setActive(item.go, false)
	end
end

function ActivityWarmUpGameView:hideAllBlock()
	for _, item in pairs(self._blockItems) do
		item.blockData = nil

		gohelper.setActive(item.go, false)
	end
end

return ActivityWarmUpGameView
