-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameView.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameView", package.seeall)

local DeleikeGameView = class("DeleikeGameView", BaseView)

function DeleikeGameView:onInitView()
	self._goJoystick = gohelper.findChild(self.viewGO, "#go_Joystick")
	self._goTarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_Target/#txt_Target")
	self._goCancle = gohelper.findChild(self.viewGO, "#go_Cancle")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Back")
	self._btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Tips")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Confirm")
	self._goDragTip1 = gohelper.findChild(self.viewGO, "#go_DragTip1")
	self._goDragTip2 = gohelper.findChild(self.viewGO, "#go_DragTip2")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DeleikeGameView:addEvents()
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self._btnTips:AddClickListener(self._btnTipsOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
end

function DeleikeGameView:removeEvents()
	self._btnBack:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function DeleikeGameView:_btnBackOnClick()
	DeleikeGameMgr.instance:undoLastCut()
	DeleikeController.instance:onGameRevert()
end

function DeleikeGameView:_btnTipsOnClick()
	return
end

function DeleikeGameView:_btnConfirmOnClick()
	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:cancelDrag()
	end
end

function DeleikeGameView:_btnResetOnClick()
	self.anim:Play("open", 0, 0)

	self.isDraging = false
	self.skillDraging = false

	DeleikeController.instance:dispatchEvent(DeleikeEvent.ResetGame)
	self:refreshSkillCnt(1)
	self:refreshSkillCnt(2)
	DeleikeController.instance:onGameReset()
end

function DeleikeGameView:_editableInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.animCancle = gohelper.findComponentAnim(self._goCancle)

	gohelper.setActive(self._goCancle, false)
	gohelper.setActive(self._btnConfirm, false)

	self.skillItems = {}
	self._skillAngles = {
		0,
		0
	}

	for i = 1, 2 do
		local skillItem = self:getUserDataTb_()
		local goSkill = gohelper.findChild(self.viewGO, "go_Skill" .. i)

		skillItem.animSkill = gohelper.findComponentAnim(goSkill)
		skillItem.goFrame = gohelper.findChild(goSkill, "go_Frame")
		skillItem.imageSkill = gohelper.findChildImage(goSkill, "image_Skill")
		skillItem.txtCount = gohelper.findChildText(goSkill, "image_Skill/txt_Count")
		skillItem.goHandle = gohelper.findChild(goSkill, "go_Handle")
		skillItem.goAdd = gohelper.findChild(goSkill, "go_add")
		skillItem.go = goSkill
		skillItem.transform = goSkill.transform
		self.skillItems[i] = skillItem
	end

	self.isDraging = false
	self.skillDraging = false

	gohelper.setActive(self._btnBack, false)
end

function DeleikeGameView:onOpen()
	self.addEventCb(self, DeleikeController.instance, DeleikeEvent.Skill2DragStateChanged, self._onDragStateChanged, self)
	self.addEventCb(self, DeleikeController.instance, DeleikeEvent.UndoStateChanged, self._onUndoStateChanged, self)
	self.addEventCb(self, DeleikeController.instance, DeleikeEvent.SkillCntChange, self.refreshSkillCnt, self)
	self.addEventCb(self, DeleikeController.instance, DeleikeEvent.Skill2FirstDrag, self._onFirstDrag, self)

	for i = 1, 2 do
		local skillItem = self.skillItems[i]

		CommonDragHelper.instance:registerDragObj(skillItem.go, nil, self._onDrag, nil, self._checkDrag, self, i, true)

		skillItem.click = SLFramework.UGUI.UIClickListener.Get(skillItem.go)
		skillItem.click.canMultTouch = true

		skillItem.click:AddClickDownListener(self._onSkillBtnDown, self, i)
		skillItem.click:AddClickUpListener(self._onSkillBtnUp, self, i)
	end

	local gameCfg = DeleikeGameMgr.instance.gameCfg

	self._txtTarget.text = gameCfg.targetDesc

	TaskDispatcher.cancelTask(self._openPostProcess, self)
	TaskDispatcher.runRepeat(self._openPostProcess, self, 0)
end

function DeleikeGameView:_openPostProcess()
	PostProcessingMgr.instance:setUIActive(true)
end

function DeleikeGameView:onOpenFinish()
	self.anim.enabled = true

	self:refreshSkillCnt(1)
	self:refreshSkillCnt(2)
	PostProcessingMgr:setIgnoreUIBlur(true)

	self.ppvalue = {
		localMaskActive = true,
		bloomActive = true
	}
	self.cachePPValue = {}

	for key, value in pairs(self.ppvalue) do
		local curValue = PostProcessingMgr.instance:getUIPPValue(key)

		if curValue ~= value then
			self.cachePPValue[key] = curValue

			PostProcessingMgr.instance:setUIPPValue(key, value)
		end
	end
end

function DeleikeGameView:onCloseFinish()
	for key, value in pairs(self.cachePPValue) do
		PostProcessingMgr.instance:setUIPPValue(key, value)
	end

	PostProcessingMgr:setIgnoreUIBlur(false)
end

function DeleikeGameView:onDestroyView()
	for i = 1, 2 do
		local skillItem = self.skillItems[i]

		CommonDragHelper.instance:unregisterDragObj(skillItem.go)

		if skillItem.click then
			skillItem.click:RemoveClickDownListener()
			skillItem.click:RemoveClickUpListener()

			skillItem.click = nil
		end
	end

	TaskDispatcher.cancelTask(self.delayHideCancle, self)
	TaskDispatcher.cancelTask(self._openPostProcess, self)
end

function DeleikeGameView:refreshSkillCnt(skillId, isAdd)
	local player = DeleikeGameMgr.instance.player

	if player then
		local skillCount = player:getSkillCount(skillId)
		local skillItem = self.skillItems[skillId]

		skillItem.txtCount.text = luaLang("multiple") .. tostring(skillCount)

		if isAdd then
			gohelper.setActive(skillItem.goAdd, false)
			gohelper.setActive(skillItem.goAdd, true)
		end

		local animName = skillCount == 0 and "gray" or "idle"

		skillItem.animSkill:Play(animName, 0, 0)
	end
end

function DeleikeGameView:_onDragStateChanged(active)
	self.skillDraging = active

	gohelper.setActive(self._goDragTip2, active)

	if active then
		gohelper.setActive(self._btnBack, false)
	else
		gohelper.setActive(self._btnConfirm, false)
		self:_refreshBackBtn()
	end
end

function DeleikeGameView:_onUndoStateChanged(active)
	gohelper.setActive(self._btnBack, active)
end

function DeleikeGameView:_refreshBackBtn()
	gohelper.setActive(self._btnBack, DeleikeGameMgr.instance:canUndo())
end

function DeleikeGameView:_onFirstDrag()
	gohelper.setActive(self._btnConfirm, true)
end

function DeleikeGameView:_checkDrag(index)
	if self.skillDraging then
		return true
	end

	if DeleikeGameMgr.instance.inputLocked then
		return true
	end

	local player = DeleikeGameMgr.instance.player

	if not player then
		return true
	end

	local count = player:getSkillCount(index)

	return count < 1
end

function DeleikeGameView:_beginDrag(index, pointerEventData)
	self.isDraging = true

	gohelper.setActive(self._goDragTip1, true)
	gohelper.setActive(self._btnReset, false)
	gohelper.setActive(self._btnBack, false)
	TaskDispatcher.cancelTask(self.delayHideCancle, self)
	gohelper.setActive(self._goCancle, true)
	self.animCancle:Play("unhand_open", 0, 0)

	self.isDragInCancle = false

	local skillItem = self.skillItems[index]

	gohelper.setActive(skillItem.goFrame, true)
	gohelper.setActive(skillItem.goHandle, true)
	skillItem.animSkill:Play("hold_in", 0, 0)

	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:onSkillBtnDragBegin(index)
	end
end

function DeleikeGameView:_onDrag(index, pointerEventData)
	if self.isDraging then
		self:_setDragInCancle(self:_isPointerInCancle(pointerEventData))
		self:_updateSkillPointer(index, pointerEventData.position)
	end
end

function DeleikeGameView:_endDrag(index, pointerEventData)
	if not self.isDraging then
		return
	end

	gohelper.setActive(self._goDragTip1, false)
	gohelper.setActive(self._btnReset, true)

	local skillItem = self.skillItems[index]

	gohelper.setActive(skillItem.goFrame, false)
	gohelper.setActive(skillItem.goHandle, false)
	skillItem.animSkill:Play("hold_out", 0, 0)

	local cancelled = self:_isPointerInCancle(pointerEventData)
	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:onSkillBtnDragEnd(cancelled)
	end

	self:_refreshBackBtn()

	if self._goCancle.activeInHierarchy then
		local animName = self.isDragInCancle and "hand_close" or "unhand_close"

		self.animCancle:Play(animName, 0, 0)
		TaskDispatcher.runDelay(self.delayHideCancle, self, 0.16)
	end

	self.isDraging = false
end

function DeleikeGameView:_updateSkillPointer(index, screenPos)
	local skillItem = self.skillItems[index]
	local localPoint = recthelper.screenPosToAnchorPos(screenPos, skillItem.transform)

	transformhelper.setLocalPosXY(skillItem.goHandle.transform, localPoint.x, localPoint.y)

	local mgr = DeleikeGameMgr.instance
	local player = mgr.player
	local skillMgr = mgr.skillMgr

	if not player or not skillMgr or not mgr.sceneRootRt then
		return
	end

	local px, py = player:getLogicPos()
	local scenePoint = recthelper.screenPosToAnchorPos(screenPos, mgr.sceneRootRt)
	local dx = scenePoint.x - px
	local dy = scenePoint.y - py
	local distSq = dx * dx + dy * dy

	if distSq < 0.0001 then
		return
	end

	local targetAngle = math.atan2(dy, dx)
	local smoothRadius = DeleikeEnum.JoyStickInnerRadius

	if distSq < smoothRadius * smoothRadius then
		if not self._skillAngles[index] then
			local curAngle = targetAngle
			local diff = targetAngle - curAngle

			diff = (diff + math.pi) % (2 * math.pi) - math.pi

			local t = 1 - math.exp(-DeleikeEnum.JoyStickSmoothSpeed * Time.deltaTime)

			curAngle = curAngle + diff * t
			self._skillAngles[index] = curAngle
			targetAngle = curAngle
		end
	else
		self._skillAngles[index] = targetAngle
	end

	skillMgr:onSkillBtnDragMove(math.cos(targetAngle), math.sin(targetAngle))
end

function DeleikeGameView:_onSkillBtnDown(index, position)
	if self:_checkDrag(index) then
		return
	end

	self:_beginDrag(index)
	self:_updateSkillPointer(index, position)
end

function DeleikeGameView:_onSkillBtnUp(index, position)
	self:_endDrag(index, {
		position = position
	})
end

function DeleikeGameView:delayHideCancle()
	gohelper.setActive(self._goCancle, false)
end

function DeleikeGameView:_isPointerInCancle(pointerEventData)
	local pos = pointerEventData.position

	return recthelper.screenPosInRect(self._goCancle.transform, nil, pos.x, pos.y)
end

function DeleikeGameView:_setDragInCancle(inCancle)
	if self.isDragInCancle == inCancle then
		return
	end

	self.isDragInCancle = inCancle

	self.animCancle:Play(inCancle and "hand_in" or "hand_out", 0, 0)
end

return DeleikeGameView
