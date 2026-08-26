-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicRhythmGameView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicRhythmGameView", package.seeall)

local AtomicRhythmGameView = class("AtomicRhythmGameView", BaseView)

function AtomicRhythmGameView:onInitView()
	self._gotipBg = gohelper.findChild(self.viewGO, "root/txt_tipsbg")
	self._golockItemContent = gohelper.findChild(self.viewGO, "root/middle/#go_lockItemContent")
	self._gopointContent = gohelper.findChild(self.viewGO, "root/middle/#go_pointContent")
	self._txttime = gohelper.findChildText(self.viewGO, "root/middle/time/#txt_time")
	self._gopointItem = gohelper.findChild(self.viewGO, "root/middle/#go_pointItem")
	self._gocurrent = gohelper.findChild(self.viewGO, "root/middle/#go_current")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_ok", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_reset", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._goclickMask = gohelper.findChild(self.viewGO, "root/#go_clickMask")
	self._gosucc = gohelper.findChild(self.viewGO, "root/#go_succ")
	self._gofail = gohelper.findChild(self.viewGO, "root/#go_fail")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_succ/#btn_close")
	self._btncloseFail = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_fail/#btn_closeFail")
	self._btnForceSucc = gohelper.findChildClick(self.viewGO, "root/#btn_forceSucc")
	self._imageForceProgress = gohelper.findChildImage(self.viewGO, "root/#btn_forceSucc/#image_forceProgress")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicRhythmGameView:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncloseFail:AddClickListener(self._btncloseOnClick, self)
	self._btnForceSucc:AddClickDownListener(self._btnForceSuccOnClickDown, self)
	self._btnForceSucc:AddClickUpListener(self._btnForceSuccOnClickUp, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnRhythmGameGuideFinish, self.gamePlay, self)
end

function AtomicRhythmGameView:removeEvents()
	self._btnok:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btncloseFail:RemoveClickListener()
	self._btnForceSucc:RemoveClickDownListener()
	self._btnForceSucc:RemoveClickUpListener()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnRhythmGameGuideFinish, self.gamePlay, self)
end

function AtomicRhythmGameView:_btnokOnClick()
	if self.isResult or not self.canOperate then
		return
	end

	self:refreshLockState()
end

function AtomicRhythmGameView:_btnresetOnClick()
	self:initData()
	self:refreshUI()
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.cancelTask(self.forbidOperate, self)
	TaskDispatcher.runRepeat(self.refreshUI, self, self.moveNextTime)
end

function AtomicRhythmGameView:_btncloseOnClick()
	self:closeThis()
end

function AtomicRhythmGameView:_btnForceSuccOnClickDown()
	self:cleanProgressTween()

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageForceProgress, 1, (1 - self._imageForceProgress.fillAmount) * 2, self.onForceSuccProgressFull, self)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_crack_loop)
	self.btnForceSuccAnim:Play("click", 0, 0)
	self.btnForceSuccAnim:Update(0)
end

function AtomicRhythmGameView:onForceSuccProgressFull()
	self.isForceSucc = true

	self:showSuccess()
end

function AtomicRhythmGameView:_btnForceSuccOnClickUp()
	self:cleanProgressTween()

	if self._imageForceProgress.fillAmount >= 1 or self.isSucc then
		return
	end

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageForceProgress, 0, self._imageForceProgress.fillAmount * 2)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	self.btnForceSuccAnim:Play("reset", 0, 0)
	self.btnForceSuccAnim:Update(0)
end

function AtomicRhythmGameView:_editableInitView()
	self.lockItemMap = self:getUserDataTb_()
	self.pointItemMap = self:getUserDataTb_()
	self.pointLockIndexList = {}

	gohelper.setActive(self._gopointItem, false)
	gohelper.setActive(self._btnForceSucc.gameObject, false)

	self.moveNextTime = 0.8
	self.canOperateTime = self.moveNextTime - 0.3
	self.lockAnimTime = 0.467
	self.canOperate = true
	self.curPointAnim = self._gocurrent:GetComponent(typeof(UnityEngine.Animator))
	self.lockContentAnim = gohelper.findChild(self.viewGO, "root/middle"):GetComponent(gohelper.Type_Animator)
	self.gameSuccTime = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AtomicGameSuccTime, true)
	self.btnForceSuccAnim = self._btnForceSucc.gameObject:GetComponent(gohelper.Type_Animator)
end

function AtomicRhythmGameView:initData()
	self.isSucc = false
	self.isForceSucc = false
	self.animIndex = nil

	local gameId = self.viewParam.gameId

	self.elementId = self.viewParam.elementId
	self.optionId = self.viewParam.optionId
	self.nextOptionConfig = self.viewParam.nextOptionConfig
	self.configData = AtomicDungeonConfig.instance:getRhythmGameConfig(gameId)
	self.pointTypeMap = string.splitToNumber(self.configData.point, "#")

	math.randomseed(os.time())
	self:initGameScene()
	gohelper.setActive(self._goclickMask, false)
	gohelper.setActive(self._gosucc, false)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._gocurrent, false)
	gohelper.setActive(self._gotipBg, true)

	self.curTime = self.configData.time + 1
	self.isResult = false

	self.curPointAnim:Play("idle", 0, 0)
	self.curPointAnim:Update(0)

	self.lockIndex = math.random(1, #self.pointLockIndexList)
	self.curIndex = self.pointLockIndexList[self.lockIndex]

	TaskDispatcher.cancelTask(self.refreshUI, self)
end

function AtomicRhythmGameView:initGameScene()
	for index = 1, 8 do
		local lockItem = self.lockItemMap[index]

		if not lockItem then
			lockItem = {
				go = gohelper.findChild(self._golockItemContent, "go_lockItem" .. index)
			}
			lockItem.goIcon = gohelper.findChild(lockItem.go, "go_icon")
			lockItem.anim = lockItem.go:GetComponent(gohelper.Type_Animator)
			self.lockItemMap[index] = lockItem

			if self.pointTypeMap[index] > 0 then
				table.insert(self.pointLockIndexList, index)
			end
		end

		lockItem.canShow = self.pointTypeMap[index] > 0
		lockItem.isLock = true

		gohelper.setActive(lockItem.go, lockItem.canShow)
		lockItem.anim:Play("normal", 0, 0)
		lockItem.anim:Update(0)

		local pointItem = self.pointItemMap[index]

		if not pointItem then
			pointItem = {
				pos = gohelper.findChild(self._gopointContent, "go_pos" .. index)
			}
			pointItem.go = gohelper.clone(self._gopointItem, pointItem.pos, "pointItem" .. index)
			pointItem.goNormal = gohelper.findChild(pointItem.go, "go_normal")
			pointItem.goUnlock = gohelper.findChild(pointItem.go, "go_unlock")
			pointItem.posX, pointItem.posY = recthelper.getAnchor(pointItem.pos.transform)
			self.pointItemMap[index] = pointItem
		end

		gohelper.setActive(pointItem.go, true)
		gohelper.setActive(pointItem.goNormal, true)
		gohelper.setActive(pointItem.goUnlock, false)
	end
end

function AtomicRhythmGameView:onUpdateParam()
	return
end

function AtomicRhythmGameView:onOpen()
	self:initData()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_lock_unfold)

	self._imageForceProgress.fillAmount = 0
end

function AtomicRhythmGameView:onOpenFinish()
	self:refreshUI(true)

	local isGuideFinish = HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.AtomicRhythmGame)
	local isForbidGuide = GuideController.instance:isForbidGuides()

	if isGuideFinish or isForbidGuide then
		self:gamePlay()
	end
end

function AtomicRhythmGameView:gamePlay()
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.runRepeat(self.refreshUI, self, self.moveNextTime)
	TaskDispatcher.runDelay(self.showForceSucc, self, self.gameSuccTime)
end

function AtomicRhythmGameView:refreshUI(firstOpen)
	self.lockIndex = self.lockIndex + 1 > #self.pointLockIndexList and 1 or self.lockIndex + 1
	self.curIndex = self.pointLockIndexList[self.lockIndex]
	self.animIndex = self.animIndex or nil
	self.curTime = self.curTime - 1

	gohelper.setActive(self._gocurrent, self.lockItemMap[self.curIndex].canShow)
	gohelper.setActive(self._goclickMask, false)

	self.canOperate = true

	if not firstOpen then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_activity_countdown)
	end

	if self.curTime > 0 then
		local tens = math.floor(self.curTime / 10) % 10
		local units = self.curTime % 10

		self._txttime.text = string.format("<sprite=%s><sprite=%s>", tens, units)
	else
		self._txttime.text = string.format("<sprite=%s><sprite=%s>", 0, 0)
	end

	local pointItem = self.pointItemMap[self.curIndex]

	recthelper.setAnchor(self._gocurrent.transform, pointItem.posX, pointItem.posY)
	self.curPointAnim:Play("light", 0, 0)
	self.curPointAnim:Update(0)
	self:refreshLockItemState()
	self:checkResult()
	TaskDispatcher.cancelTask(self.forbidOperate, self)
	TaskDispatcher.runDelay(self.forbidOperate, self, self.canOperateTime)
end

function AtomicRhythmGameView:forbidOperate()
	self.canOperate = false
end

function AtomicRhythmGameView:refreshLockItemState()
	for index, pointItem in pairs(self.pointItemMap) do
		local isLock = self.lockItemMap[index].isLock

		gohelper.setActive(pointItem.goNormal, isLock or index == self.curIndex and not self.isResult)
		gohelper.setActive(pointItem.goUnlock, (not isLock or nil) and (self.isResult or index ~= self.curIndex))
	end
end

function AtomicRhythmGameView:refreshLockState()
	local curLockItem = self.lockItemMap[self.curIndex]

	if curLockItem and curLockItem.canShow and self.animIndex ~= self.curIndex then
		curLockItem.isLock = not curLockItem.isLock
		self.animIndex = self.curIndex

		local animName = curLockItem.isLock and "extend" or "retract"

		curLockItem.anim:Play(animName, 0, 0)
		curLockItem.anim:Update(0)
		TaskDispatcher.runDelay(self.lockAnimTweenFinish, self, self.lockAnimTime)
	end
end

function AtomicRhythmGameView:lockAnimTweenFinish()
	self.animIndex = nil

	self:checkResult()
end

function AtomicRhythmGameView:checkResult()
	self.isSucc = true

	for _, lockItem in pairs(self.lockItemMap) do
		if lockItem.canShow and lockItem.isLock then
			self.isSucc = false

			break
		end
	end

	if self.isSucc then
		self:showSuccess()
	elseif self.curTime <= 0 then
		TaskDispatcher.cancelTask(self.showForceSucc, self)
		gohelper.setActive(self._gosucc, false)
		gohelper.setActive(self._gofail, true)
		gohelper.setActive(self._gocurrent, false)
		gohelper.setActive(self._gotipBg, false)
		gohelper.setActive(self._btnForceSucc.gameObject, false)
		gohelper.setActive(self._btnreset.gameObject, false)
		TaskDispatcher.cancelTask(self.refreshUI, self)

		self.isResult = true

		self:refreshLockItemState()
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	end
end

function AtomicRhythmGameView:showSuccess()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_decrypt_success)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_lock_success)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	gohelper.setActive(self._gosucc, true)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._gocurrent, false)
	gohelper.setActive(self._gotipBg, false)
	gohelper.setActive(self._btnok.gameObject, false)
	gohelper.setActive(self._golefttop, false)
	gohelper.setActive(self._btnForceSucc.gameObject, false)
	gohelper.setActive(self._btnreset.gameObject, false)
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.cancelTask(self.showForceSucc, self)

	self.isSucc = true
	self.isResult = true

	self:refreshLockItemState()
	self.lockContentAnim:Play("out", 0, 0)
	self.lockContentAnim:Update(0)
end

function AtomicRhythmGameView:showForceSucc()
	if self.isSucc or self.curTime <= 0 or self.isResult then
		return
	end

	gohelper.setActive(self._btnForceSucc.gameObject, true)
end

function AtomicRhythmGameView:cleanProgressTween()
	if self.progressTweenId then
		ZProj.TweenHelper.KillById(self.progressTweenId)

		self.progressTweenId = nil
	end
end

function AtomicRhythmGameView:onClose()
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.cancelTask(self.forbidOperate, self)
	TaskDispatcher.cancelTask(self.lockAnimTweenFinish)
	TaskDispatcher.cancelTask(self.showForceSucc, self)

	local isFinish = AtomicDungeonModel.instance:isElementFinish(self.elementId)

	if self.isSucc and not self.nextOptionConfig and not isFinish then
		local optionParam = {}

		optionParam.optionId = self.optionId

		AtomicRpc.instance:sendAtomicMapInteractRequest(self.elementId, optionParam)

		local statData = AtomicDungeonModel.instance:getElementStatData(self.elementId)

		AtomicDungeonStatHelper.instance:sendPuzzleGameInteractInfo(statData, self.isForceSucc)
	end

	if self.isSucc then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.GameFinish)
	end

	self:cleanProgressTween()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
end

function AtomicRhythmGameView:onDestroyView()
	return
end

return AtomicRhythmGameView
