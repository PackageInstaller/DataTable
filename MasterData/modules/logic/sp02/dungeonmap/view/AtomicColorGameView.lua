-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicColorGameView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicColorGameView", package.seeall)

local AtomicColorGameView = class("AtomicColorGameView", BaseView)

function AtomicColorGameView:onInitView()
	self._gotipBg = gohelper.findChild(self.viewGO, "root/txt_tipsbg")
	self._golockItemContent = gohelper.findChild(self.viewGO, "root/middle/#go_lockItemContent")
	self._goouterPointContent = gohelper.findChild(self.viewGO, "root/middle/#go_outerPointContent")
	self._goinnerPointContent = gohelper.findChild(self.viewGO, "root/middle/#go_innerPointContent")
	self._goinnerPosContent = gohelper.findChild(self.viewGO, "root/middle/#go_innerPosContent")
	self._goouterSelect = gohelper.findChild(self.viewGO, "root/middle/circle/#go_outerSelect")
	self._goinnerSelect = gohelper.findChild(self.viewGO, "root/middle/circle/#go_innerSelect")
	self._gopointItem = gohelper.findChild(self.viewGO, "root/middle/#go_pointItem")
	self._btnrotateInner = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_rotateInner", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._btnrotateOuter = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_rotateOuter", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_reset", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._goclickMask = gohelper.findChild(self.viewGO, "root/#go_clickMask")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/#go_success")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_success/#btn_close")
	self._btnForceSucc = gohelper.findChildClick(self.viewGO, "root/#btn_forceSucc")
	self._imageForceProgress = gohelper.findChildImage(self.viewGO, "root/#btn_forceSucc/#image_forceProgress")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicColorGameView:addEvents()
	self._btnrotateInner:AddClickListener(self._btnRotateInnerOnClick, self)
	self._btnrotateOuter:AddClickListener(self._btnRotateOuterOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnForceSucc:AddClickDownListener(self._btnForceSuccOnClickDown, self)
	self._btnForceSucc:AddClickUpListener(self._btnForceSuccOnClickUp, self)
end

function AtomicColorGameView:removeEvents()
	self._btnrotateInner:RemoveClickListener()
	self._btnrotateOuter:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnForceSucc:RemoveClickDownListener()
	self._btnForceSucc:RemoveClickUpListener()
end

function AtomicColorGameView:_btnRotateInnerOnClick()
	self.curCircleType = AtomicDungeonEnum.CircleType.Inner

	self:refreshUI()
	self:rotateInnerCircle()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_color_rotate)
end

function AtomicColorGameView:_btnRotateOuterOnClick()
	self.curCircleType = AtomicDungeonEnum.CircleType.Outer

	self:refreshUI()
	self:rotateOuterCircle()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_color_rotate)
end

function AtomicColorGameView:_btnresetOnClick()
	self:initData()
	self:refreshUI()
end

function AtomicColorGameView:_btncloseOnClick()
	self:closeThis()
end

function AtomicColorGameView:_btnForceSuccOnClickDown()
	self:cleanProgressTween()

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageForceProgress, 1, (1 - self._imageForceProgress.fillAmount) * 2, self.onForceSuccProgressFull, self)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_crack_loop)
	self.btnForceSuccAnim:Play("click", 0, 0)
	self.btnForceSuccAnim:Update(0)
end

function AtomicColorGameView:onForceSuccProgressFull()
	self.isForceSucc = true

	self:showSuccess()
end

function AtomicColorGameView:_btnForceSuccOnClickUp()
	self:cleanProgressTween()

	if self._imageForceProgress.fillAmount >= 1 or self.isSucc then
		return
	end

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageForceProgress, 0, self._imageForceProgress.fillAmount * 2)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	self.btnForceSuccAnim:Play("reset", 0, 0)
	self.btnForceSuccAnim:Update(0)
end

function AtomicColorGameView:_editableInitView()
	self.innerIndexList = {
		4,
		5,
		6
	}
	self.lockItemMap = self:getUserDataTb_()
	self.outerPointItemMap = self:getUserDataTb_()
	self.innerPointItemMap = self:getUserDataTb_()
	self.innerPosItemMap = self:getUserDataTb_()

	gohelper.setActive(self._gopointItem, false)
	gohelper.setActive(self._btnForceSucc.gameObject, false)

	self.circlePosX, self.circlePosY = recthelper.getAnchor(self._goinnerPosContent.transform)
	self.lockContentAnim = gohelper.findChild(self.viewGO, "root/middle"):GetComponent(gohelper.Type_Animator)
	self.gameSuccTime = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AtomicGameSuccTime, true)
	self.btnForceSuccAnim = self._btnForceSucc.gameObject:GetComponent(gohelper.Type_Animator)
end

function AtomicColorGameView:onUpdateParam()
	return
end

function AtomicColorGameView:onOpen()
	self:initData()
	self:refreshUI()
	TaskDispatcher.runDelay(self.showForceSucc, self, self.gameSuccTime)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_lock_unfold)

	self._imageForceProgress.fillAmount = 0
end

function AtomicColorGameView:initData()
	local gameId = self.viewParam.gameId

	self.optionId = self.viewParam.optionId
	self.elementId = self.viewParam.elementId
	self.nextOptionConfig = self.viewParam.nextOptionConfig

	local configData = AtomicDungeonConfig.instance:getColorGameConfig(gameId)

	self.outerPointTypeMap = string.splitToNumber(configData.outerPoint, "#")
	self.innerPointTypeMap = string.splitToNumber(configData.innerPoint, "#")
	self.outerDeltaAngle = 2 * math.pi / 8

	self:initGameScene()

	self.curCircleType = AtomicDungeonEnum.CircleType.Outer
	self.curRotateFinishCount = 0

	gohelper.setActive(self._goclickMask, false)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gotipBg, true)

	self.isSucc = false
	self.isForceSucc = false
end

function AtomicColorGameView:initGameScene()
	for index = 1, 8 do
		local lockItem = self.lockItemMap[index]

		if not lockItem then
			lockItem = {
				go = gohelper.findChild(self._golockItemContent, "go_lockItem" .. index)
			}
			lockItem.goIcon = gohelper.findChild(lockItem.go, "go_icon")
			lockItem.anim = lockItem.go:GetComponent(gohelper.Type_Animator)
			self.lockItemMap[index] = lockItem
		end

		lockItem.canShow = self.outerPointTypeMap[index] > 0
		lockItem.isLock = self.outerPointTypeMap[index] ~= self.innerPointTypeMap[index] and lockItem.canShow
		lockItem.lastLockState = lockItem.isLock

		gohelper.setActive(lockItem.go, lockItem.canShow)
		lockItem.anim:Play("normal", 0, 0)
		lockItem.anim:Update(0)

		local outerPointItem = self.outerPointItemMap[index]

		if not outerPointItem then
			outerPointItem = {
				pos = gohelper.findChild(self._goouterPointContent, "go_pos" .. index)
			}
			outerPointItem.go = gohelper.clone(self._gopointItem, outerPointItem.pos, "outerPointItem" .. index)
			outerPointItem.typeItemMap = {}

			for type = 0, 2 do
				outerPointItem.typeItemMap[type] = gohelper.findChild(outerPointItem.go, "go_type" .. type)
			end

			self.outerPointItemMap[index] = outerPointItem
		end

		gohelper.setActive(outerPointItem.go, true)

		for type, typeItem in pairs(outerPointItem.typeItemMap) do
			gohelper.setActive(typeItem, type == self.outerPointTypeMap[index])
		end

		local innerPosItem = self.innerPosItemMap[index]

		if not innerPosItem then
			innerPosItem = {
				go = gohelper.findChild(self._goinnerPosContent, "go_pos" .. index)
			}
			innerPosItem.posX, innerPosItem.posY = recthelper.getAnchor(innerPosItem.go.transform)
			innerPosItem.radAngle = self.outerDeltaAngle * (index - 1)
			self.innerPosItemMap[index] = innerPosItem
		end

		local innerPointItem = self.innerPointItemMap[index]

		if not innerPointItem then
			innerPointItem = {
				go = gohelper.clone(self._gopointItem, self._goinnerPointContent, "innerPointItem" .. index)
			}
			innerPointItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(innerPointItem.go, AtomicColorInnerPointItem, {
				colorGameView = self,
				circlePosX = self.circlePosX,
				circlePosY = self.circlePosY
			})
			self.innerPointItemMap[index] = innerPointItem
		end

		local data = {
			posX = innerPosItem.posX,
			posY = innerPosItem.posY,
			type = self.innerPointTypeMap[index]
		}

		innerPointItem.comp:refreshUI(data)
	end
end

function AtomicColorGameView:refreshUI()
	gohelper.setActive(self._goouterSelect, self.curCircleType == AtomicDungeonEnum.CircleType.Outer)
	gohelper.setActive(self._goinnerSelect, self.curCircleType == AtomicDungeonEnum.CircleType.Inner)
end

function AtomicColorGameView:rotateOuterCircle()
	gohelper.setActive(self._goclickMask, true)

	for index, innerPointItem in ipairs(self.innerPointItemMap) do
		local curRadAngle = self.innerPosItemMap[index].radAngle
		local targetRadAngle = curRadAngle + self.outerDeltaAngle * 2

		innerPointItem.comp:rotateOuterPointItem(curRadAngle, targetRadAngle)
	end
end

function AtomicColorGameView:doRotateFinish()
	self.curRotateFinishCount = self.curRotateFinishCount + 1

	if self.curCircleType == AtomicDungeonEnum.CircleType.Outer and self.curRotateFinishCount == 8 then
		self:allOuterRotateFinish()
	elseif self.curCircleType == AtomicDungeonEnum.CircleType.Inner and self.curRotateFinishCount == 3 then
		self:allInnerRotateFinish()
	end

	self:checkAndRefreshLockState()
end

function AtomicColorGameView:rotateInnerCircle()
	gohelper.setActive(self._goclickMask, true)

	for index, posIndex in ipairs(self.innerIndexList) do
		if self.innerIndexList[index + 1] then
			if not self.innerIndexList[index + 1] then
				local nextPosIndex = self.innerIndexList[1]
				local targetPosItem = self.innerPosItemMap[nextPosIndex]
				local innerPointItem = self.innerPointItemMap[posIndex]

				innerPointItem.comp:rotateInnerPointItem(targetPosItem.posX, targetPosItem.posY)
			end
		end
	end
end

function AtomicColorGameView:allOuterRotateFinish()
	self.curRotateFinishCount = 0

	gohelper.setActive(self._goclickMask, false)

	local tempInnerPointItemMap = tabletool.copy(self.innerPointItemMap)

	for index = #self.innerPointItemMap, 1, -1 do
		local targetIndex = (index - 3 + 8) % 8 + 1

		self.innerPointItemMap[index] = tempInnerPointItemMap[targetIndex]
		self.innerPointItemMap[index].go.name = "innerPointItem" .. index
	end
end

function AtomicColorGameView:allInnerRotateFinish()
	self.curRotateFinishCount = 0

	gohelper.setActive(self._goclickMask, false)

	local finalPosIndex = self.innerIndexList[#self.innerIndexList]
	local finalInnerPointItem = tabletool.copy(self.innerPointItemMap[finalPosIndex])

	for index = #self.innerIndexList, 1, -1 do
		local curPosIndex = self.innerIndexList[index]

		if index > 1 then
			local lastPosIndex = self.innerIndexList[index - 1]

			self.innerPointItemMap[curPosIndex] = self.innerPointItemMap[lastPosIndex]
		else
			self.innerPointItemMap[curPosIndex] = finalInnerPointItem
		end

		self.innerPointItemMap[curPosIndex].go.name = "innerPointItem" .. curPosIndex
	end
end

function AtomicColorGameView:checkAndRefreshLockState()
	self.haveLockItem = false

	for index, lockItem in ipairs(self.lockItemMap) do
		lockItem.lastLockState = lockItem.isLock
		lockItem.isLock = self.outerPointTypeMap[index] ~= self.innerPointItemMap[index].comp.colorType and lockItem.canShow

		if lockItem.isLock then
			self.haveLockItem = true
		end

		if lockItem.canShow and lockItem.lastLockState ~= lockItem.isLock then
			local animName = lockItem.isLock and "extend" or "retract"

			lockItem.anim:Play(animName, 0, 0)
			lockItem.anim:Update(0)

			if not lockItem.isLock then
				AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_bolt_land)
			end
		end
	end

	if not self.haveLockItem then
		TaskDispatcher.runDelay(self.showSuccess, self, AtomicDungeonEnum.lockAnimTime)
	end
end

function AtomicColorGameView:showSuccess()
	self.isSucc = true

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_decrypt_success)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_lock_success)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	TaskDispatcher.cancelTask(self.showForceSucc, self)
	gohelper.setActive(self._gosuccess, true)
	self.lockContentAnim:Play("out", 0, 0)
	self.lockContentAnim:Update(0)
	gohelper.setActive(self._gotipBg, false)
	gohelper.setActive(self._golefttop, false)
	gohelper.setActive(self._btnrotateInner.gameObject, false)
	gohelper.setActive(self._btnrotateOuter.gameObject, false)
	gohelper.setActive(self._btnForceSucc.gameObject, false)
	gohelper.setActive(self._btnreset.gameObject, false)
end

function AtomicColorGameView:showForceSucc()
	if self.isSucc then
		return
	end

	gohelper.setActive(self._btnForceSucc.gameObject, true)
end

function AtomicColorGameView:cleanProgressTween()
	if self.progressTweenId then
		ZProj.TweenHelper.KillById(self.progressTweenId)

		self.progressTweenId = nil
	end
end

function AtomicColorGameView:onClose()
	TaskDispatcher.cancelTask(self.showSuccess, self)
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

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	self:cleanProgressTween()
end

function AtomicColorGameView:onDestroyView()
	return
end

return AtomicColorGameView
