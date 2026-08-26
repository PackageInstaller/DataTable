-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongDrawView.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongDrawView", package.seeall)

local KaRongDrawView = class("KaRongDrawView", KaRongDrawBaseView)
local DelayEnableTriggerEffectTime = 1.13
local WaitEnableTriggerEffectParam = "KaRongDrawController;KaRongDrawEvent;EnableTriggerEffect"

function KaRongDrawView:onInitView()
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#simage_BG")
	self._goTarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._goLine = gohelper.findChild(self.viewGO, "#go_Line")
	self._goCheckPoint = gohelper.findChild(self.viewGO, "#go_Checkpoint")
	self._btnMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Mask")
	self._goDynamic = gohelper.findChild(self.viewGO, "#go_Dynamic")
	self._goDrag = gohelper.findChild(self.viewGO, "#go_Dynamic/#go_Drag")
	self._imagelinetemplater = gohelper.findChildImage(self.viewGO, "#image_line_template_r")
	self._imagelinetemplatel = gohelper.findChildImage(self.viewGO, "#image_line_template_l")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnSkill = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Skill")
	self._goNoLight = gohelper.findChild(self.viewGO, "#btn_Skill/#go_NoLight")
	self._goLight = gohelper.findChild(self.viewGO, "#btn_Skill/#go_Light")
	self._txtTimes = gohelper.findChildText(self.viewGO, "#btn_Skill/#txt_Times")
	self._goTip = gohelper.findChild(self.viewGO, "#go_Tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function KaRongDrawView:addEvents()
	self._btnMask:AddClickListener(self._btnMaskOnClick, self)
	self._btnSkill:AddClickListener(self._btnSkillOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function KaRongDrawView:removeEvents()
	self._btnMask:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function KaRongDrawView:_btnMaskOnClick()
	if self._ctrlInst.usingSkill then
		self._ctrlInst:setUsingSkill(false)
	end
end

function KaRongDrawView:_btnSkillOnClick()
	if self._ctrlInst.skillCnt <= 0 then
		return
	end

	self._ctrlInst:setUsingSkill(true)
end

function KaRongDrawView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function KaRongDrawView:_editableInitView()
	KaRongDrawView.super._editableInitView(self)

	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_Target/txt_Target")
	self.animBtnSkill = self._btnSkill.gameObject:GetComponent(gohelper.Type_Animator)
	self.effectGray = gohelper.findChild(self.viewGO, "#simage_BG/#effect_gray")
	self.effectColour = gohelper.findChild(self.viewGO, "#simage_BG/#effect_colour")
end

function KaRongDrawView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_burn_loop)
	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.InitGameDone, self._initGameDone, self)
	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.UpdateAvatarPos, self._syncAvatar, self)
	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.SkillCntChange, self._refreshSkillCnt, self)
	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.UsingSkill, self._onUsingSkill, self)
	self:startGame()
	self:registerAlertTriggerFunc(KaRongDrawEnum.MazeAlertType.VisitRepeat, self.onVisitRepeatObj)

	self._startGameTime = ServerTime.now()

	TaskDispatcher.runDelay(self._enableTriggerEffect, self, DelayEnableTriggerEffectTime)
	self:_refreshUI()
end

function KaRongDrawView:onClose()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.stop_ui_lushang_burn_loop)
end

function KaRongDrawView:onDestroyView()
	KaRongDrawView.super.onDestroyView(self)
	self:destroy_EndDrag_NoneAlert_Flow()
	TaskDispatcher.cancelTask(self._enableTriggerEffect, self)
end

function KaRongDrawView:startGame()
	KaRongDrawView.super.startGame(self)
	gohelper.setActive(self._btnSkill, false)
end

function KaRongDrawView:_refreshUI()
	local elementCo = self._modelInst:getElementCo()
	local elementId = elementCo and elementCo.id
	local episodeCo = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity3_0Enum.ActivityId.KaRong, elementId)

	if episodeCo then
		if episodeCo.uiTemplate == 1 then
			self._simageBG:LoadImage("singlebg/v3a0_karong_singlebg/v3a0_karong_puzzle_fullbg2.png")
			gohelper.setActive(self.effectColour, true)
		else
			self._simageBG:LoadImage("singlebg/v3a0_karong_singlebg/v3a0_karong_puzzle_fullbg1.png")
			gohelper.setActive(self.effectGray, true)
		end

		self._txtTarget.text = episodeCo.target
	end

	self:_refreshSkillCnt()
end

function KaRongDrawView:_enableTriggerEffect()
	self._enableTrigger = true

	KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.EnableTriggerEffect)
end

function KaRongDrawView:_resetGame()
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	self:stat(KaRongDrawEnum.GameResult.Restart)
	self:restartGame()
	self:_refreshSkillCnt()
end

function KaRongDrawView:getModelInst()
	return KaRongDrawModel.instance
end

function KaRongDrawView:getCtrlInst()
	return KaRongDrawController.instance
end

function KaRongDrawView:getDragGo()
	return self._goDrag
end

function KaRongDrawView:getLineParentGo()
	return self._goLine
end

function KaRongDrawView:getPawnParentGo()
	return self._goDynamic
end

function KaRongDrawView:getObjectParentGo(type)
	if type == KaRongDrawEnum.MazeObjType.Block then
		return self._goDynamic
	else
		return self._goCheckPoint
	end
end

function KaRongDrawView:getAlertParentGo()
	return self._goCheckPoint
end

function KaRongDrawView:getMazeObjCls(objType, subType, group)
	self._mazeObjClsMap = self._mazeObjClsMap or {
		[KaRongDrawEnum.MazeObjType.Start] = {
			[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawNormalObj,
			[KaRongDrawEnum.MazeObjSubType.Two] = KaRongDrawNormalObj,
			[KaRongDrawEnum.MazeObjSubType.Three] = KaRongDrawNormalObj
		},
		[KaRongDrawEnum.MazeObjType.End] = {
			[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawCheckObj,
			[KaRongDrawEnum.MazeObjSubType.Two] = KaRongDrawCheckObj,
			[KaRongDrawEnum.MazeObjSubType.Three] = KaRongDrawCheckObj
		},
		[KaRongDrawEnum.MazeObjType.CheckPoint] = {
			[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawCheckObj
		},
		[KaRongDrawEnum.MazeObjType.Block] = {
			[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawBlockObj
		}
	}
	subType = subType or KaRongDrawEnum.MazeObjSubType.Default

	local clsMap = self._mazeObjClsMap[objType]
	local cls = clsMap and clsMap[subType]

	if not cls then
		logError(string.format("find mazeObjCls failed, objType = %s, subType = %s, group = %s", objType, subType, group))
	end

	return cls
end

function KaRongDrawView:getPawnObjCls()
	return KaRongDrawPawnObj
end

function KaRongDrawView:getLineObjCls(lineType)
	if lineType == KaRongDrawEnum.LineType.Map then
		return KaRongDrawMapLine
	end

	return KaRongDrawLine
end

function KaRongDrawView:getAlertObjCls(alertType)
	return KaRongDrawObjAlert
end

function KaRongDrawView:getPawnResUrl()
	return self.viewContainer:getSetting().otherRes[3]
end

function KaRongDrawView:getLineResUrl()
	return self.viewContainer:getSetting().otherRes[2]
end

function KaRongDrawView:getObjectResUrl(objType, subType, group)
	if objType == KaRongDrawEnum.MazeObjType.Block then
		return self.viewContainer:getSetting().otherRes[4]
	else
		return self.viewContainer:getSetting().otherRes[1]
	end
end

function KaRongDrawView:getAlertResUrl(alertType)
	return self.viewContainer:getSetting().otherRes[1]
end

function KaRongDrawView:getLineTemplateFillOrigin()
	return self._imagelinetemplatel.fillOrigin, self._imagelinetemplater.fillOrigin
end

function KaRongDrawView:onVisitRepeatObj(alertObj)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)
end

function KaRongDrawView:_initGameDone()
	self:destroy_EndDrag_NoneAlert_Flow()

	self._endDrag_NoneAlert_Flow = FlowSequence.New()

	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.tryTriggerEffect, self, self._endDrag_NoneAlert_Flow))
	self._endDrag_NoneAlert_Flow:start()
end

function KaRongDrawView:onEndDrag_NoneAlert()
	self:destroy_EndDrag_NoneAlert_Flow()

	self._endDrag_NoneAlert_Flow = FlowSequence.New()

	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.onEndDrag_SyncPawn, self))
	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.syncPath, self))
	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.cleanDragLine, self))
	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.tryTriggerEffect, self, self._endDrag_NoneAlert_Flow))
	self._endDrag_NoneAlert_Flow:registerDoneListener(self.checkGameFinished, self)
	self._endDrag_NoneAlert_Flow:start()
end

function KaRongDrawView:destroy_EndDrag_NoneAlert_Flow()
	if self._endDrag_NoneAlert_Flow ~= nil then
		self._endDrag_NoneAlert_Flow:destroy()

		self._endDrag_NoneAlert_Flow = nil
	end
end

function KaRongDrawView:tryTriggerEffect(flow)
	local allEffects = {}
	local posX, posY = self._ctrlInst:getLastPos()
	local obj = KaRongDrawModel.instance:getObjAtPos(posX, posY)
	local canTrigger = KaRongDrawModel.instance:canTriggerEffect(posX, posY)

	if canTrigger then
		allEffects[#allEffects + 1] = obj.effects
		self._triggerEffectPosX = posX
		self._triggerEffectPosY = posY
	end

	local pos = self._ctrlInst:getAvatarPos()

	if pos then
		local obj1 = KaRongDrawModel.instance:getObjAtPos(pos.x, pos.y)

		canTrigger = KaRongDrawModel.instance:canTriggerEffect(pos.x, pos.y)

		if canTrigger then
			allEffects[#allEffects + 1] = obj1.effects
			self._triggerEffectPos = Vector2.New(pos.x, pos.y)
		end
	end

	if #allEffects == 0 then
		return
	end

	self:setCanTouch(false)
	self:buildTriggerEffectFlow(allEffects, flow)
end

function KaRongDrawView:buildTriggerEffectFlow(allEffects, flow)
	if not self._enableTrigger then
		flow:addWork(WaitEventWork.New(WaitEnableTriggerEffectParam))
	end

	local effectFlow = FlowSequence.New()

	for _, effects in ipairs(allEffects) do
		for _, effect in ipairs(effects) do
			local work = self:getTriggerEffectWork(effect)

			if work then
				effectFlow:addWork(work)
			end
		end
	end

	effectFlow:registerDoneListener(self.onTriggerEffectDone, self)
	flow:addWork(effectFlow)
end

function KaRongDrawView:getTriggerEffectWork(effect)
	self._effectClsMap = self._effectClsMap or {
		[KaRongDrawEnum.EffectType.Dialog] = KaRongDialogStep,
		[KaRongDrawEnum.EffectType.Story] = KaRongStoryStep,
		[KaRongDrawEnum.EffectType.Guide] = KaRongGuideStep,
		[KaRongDrawEnum.EffectType.PopView] = KaRongPopViewStep,
		[KaRongDrawEnum.EffectType.AddSkill] = FunctionWork
	}

	local cls = self._effectClsMap[effect.type]

	if cls then
		if effect.type == KaRongDrawEnum.EffectType.AddSkill then
			return cls.New(KaRongDrawController.addSkillCnt, KaRongDrawController.instance)
		else
			return cls.New(effect)
		end
	end
end

function KaRongDrawView:onTriggerEffectDone()
	if self._triggerEffectPosX then
		KaRongDrawModel.instance:setTriggerEffectDone(self._triggerEffectPosX, self._triggerEffectPosY)

		self._triggerEffectPosX = nil
		self._triggerEffectPosY = nil
	end

	if self._triggerEffectPos then
		KaRongDrawModel.instance:setTriggerEffectDone(self._triggerEffectPos.x, self._triggerEffectPos.y)

		self._triggerEffectPos = nil
	end

	self:setCanTouch(true)
	KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.OnTriggerEffectDone)
end

function KaRongDrawView:onGameSucc()
	KaRongDrawView.super.onGameSucc(self)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_level_complete)
	gohelper.setActive(self._gofinish, true)
	gohelper.setActive(self._goTarget, false)
	KaRongDrawController.instance:restartGame()
	self:stat(KaRongDrawEnum.GameResult.Success)
end

local GameResultStatName = {
	[KaRongDrawEnum.GameResult.Success] = "成功",
	[KaRongDrawEnum.GameResult.Abort] = "中断",
	[KaRongDrawEnum.GameResult.Restart] = "重新开始"
}

function KaRongDrawView:stat(gameResult)
	local useTime = ServerTime.now() - self._startGameTime
	local elementCo = KaRongDrawModel.instance:getElementCo()
	local elementId = elementCo and elementCo.id
	local episodeCo = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity3_0Enum.ActivityId.KaRong, elementId)
	local episodeId = episodeCo and episodeCo.id

	if GameResultStatName then
		local resultName = GameResultStatName[gameResult]

		StatController.instance:track(StatEnum.EventName.Exit_Charon_activity, {
			[StatEnum.EventProperties.UseTime] = useTime,
			[StatEnum.EventProperties.MapId] = tostring(episodeId),
			[StatEnum.EventProperties.Result] = resultName
		})
	end
end

function KaRongDrawView:_refreshSkillCnt(isAdd)
	local cnt = self._ctrlInst.skillCnt
	local txt = luaLang("karongdrawview_remaintimes")

	self._txtTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, cnt)

	if isAdd then
		if self._btnSkill.gameObject.activeInHierarchy then
			self.animBtnSkill:Play("get", 0, 0)
		else
			gohelper.setActive(self._btnSkill, true)
			self.animBtnSkill:Play("open", 0, 0)
		end
	else
		self.animBtnSkill:Play("use", 0, 0)
	end
end

function KaRongDrawView:_onUsingSkill(using)
	gohelper.setActive(self._goNoLight, not using)
	gohelper.setActive(self._goLight, using)
	gohelper.setActive(self._goTip, using)
	gohelper.setActive(self._goTarget, not using)
	gohelper.setActive(self._btnMask, using)
	gohelper.setActive(self._goDrag, not using)
end

return KaRongDrawView
