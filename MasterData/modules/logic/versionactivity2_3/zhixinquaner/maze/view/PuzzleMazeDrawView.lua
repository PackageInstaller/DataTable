-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeDrawView.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeDrawView", package.seeall)

local PuzzleMazeDrawView = class("PuzzleMazeDrawView", PuzzleMazeDrawBaseView)
local DelayEnableTriggerEffectTime = 1.13
local WaitEnableTriggerEffectParam = "PuzzleMazeDrawController;PuzzleEvent;EnableTriggerEffect"

function PuzzleMazeDrawView:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._goconnect = gohelper.findChild(self.viewGO, "#go_connect")
	self._imagelinetemplater = gohelper.findChildImage(self.viewGO, "#image_line_template_r")
	self._imagelinetemplatel = gohelper.findChildImage(self.viewGO, "#image_line_template_l")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._goplane = gohelper.findChild(self.viewGO, "#go_map/#go_plane")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._txtTarget = gohelper.findChildText(self.viewGO, "Target/txt_Target")
	self._goCheckMark = gohelper.findChild(self.viewGO, "Target/txt_Target/image_Check/image_CheckMark")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PuzzleMazeDrawView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, self._initGameDone, self)
end

function PuzzleMazeDrawView:removeEvents()
	self._btnreset:RemoveClickListener()
end

function PuzzleMazeDrawView:onOpen()
	PuzzleMazeDrawView.super.onOpen(self)
	self:registerAlertTriggerFunc(PuzzleEnum.MazeAlertType.VisitRepeat, self.onVisitRepeatObj)
	self:refreshTargetTips()

	self._startGameTime = ServerTime.now()

	TaskDispatcher.cancelTask(self._enableTriggerEffect, self)
	TaskDispatcher.runDelay(self._enableTriggerEffect, self, DelayEnableTriggerEffectTime)
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_EnterView)
end

function PuzzleMazeDrawView:_enableTriggerEffect()
	self._enableTrigger = true

	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.EnableTriggerEffect)
end

function PuzzleMazeDrawView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function PuzzleMazeDrawView:_resetGame()
	local canTouch = self:canTouch()

	if not canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	self:stat(PuzzleEnum.GameResult.Restart)
	self:restartGame()
end

function PuzzleMazeDrawView:restartGame()
	PuzzleMazeDrawView.super.restartGame(self)
	gohelper.setActive(self._goplane, false)
	gohelper.setActive(self._goCheckMark, false)
end

function PuzzleMazeDrawView:getModelInst()
	return PuzzleMazeDrawModel.instance
end

function PuzzleMazeDrawView:getCtrlInst()
	return PuzzleMazeDrawController.instance
end

function PuzzleMazeDrawView:getDragGo()
	return self._gomap
end

function PuzzleMazeDrawView:getLineParentGo()
	return self._goconnect
end

function PuzzleMazeDrawView:getPawnParentGo()
	return self._gomap
end

function PuzzleMazeDrawView:getObjectParentGo()
	return self._gomap
end

function PuzzleMazeDrawView:getAlertParentGo()
	return self._gomap
end

function PuzzleMazeDrawView:getMazeObjCls(objType, subType, group)
	self._mazeObjClsMap = self._mazeObjClsMap or {
		[PuzzleEnum.MazeObjType.Start] = {
			[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeNormalObj
		},
		[PuzzleEnum.MazeObjType.End] = {
			[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeCheckObj
		},
		[PuzzleEnum.MazeObjType.CheckPoint] = {
			[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeCheckObj
		},
		[PuzzleEnum.MazeObjType.Switch] = {
			[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeSwitchObj
		},
		[PuzzleEnum.MazeObjType.Block] = {
			[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeNormalObj
		}
	}
	subType = subType or PuzzleEnum.MazeObjSubType.Default

	local clsMap = self._mazeObjClsMap[objType]
	local cls = clsMap and clsMap[subType]

	if not cls then
		logError(string.format("find mazeObjCls failed, objType = %s, subType = %s, group = %s", objType, subType, group))
	end

	return cls
end

function PuzzleMazeDrawView:getPawnObjCls()
	return PuzzleMazePawnObj
end

function PuzzleMazeDrawView:getLineObjCls(lineType)
	if lineType == PuzzleEnum.LineType.Map then
		return PuzzleMazeMapLine
	end

	return PuzzleMazeLine
end

function PuzzleMazeDrawView:getAlertObjCls(alertType)
	return PuzzleMazeObjAlert
end

function PuzzleMazeDrawView:getPawnResUrl()
	return self.viewContainer:getSetting().otherRes[3]
end

function PuzzleMazeDrawView:getLineResUrl()
	return self.viewContainer:getSetting().otherRes[2]
end

function PuzzleMazeDrawView:getObjectResUrl(objType, subType, group)
	if objType == PuzzleEnum.MazeObjType.Switch then
		return self.viewContainer:getSetting().otherRes[4]
	else
		return self.viewContainer:getSetting().otherRes[1]
	end
end

function PuzzleMazeDrawView:getAlertResUrl(alertType)
	return self.viewContainer:getSetting().otherRes[1]
end

function PuzzleMazeDrawView:getLineTemplateFillOrigin()
	return self._imagelinetemplatel.fillOrigin, self._imagelinetemplater.fillOrigin
end

function PuzzleMazeDrawView:onVisitRepeatObj(alertObj)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)
end

function PuzzleMazeDrawView:onEndRefreshCheckPoint(lastCheckSum, checkSum, lastCheckCount, checkCount)
	if lastCheckSum ~= nil and lastCheckSum ~= checkSum and lastCheckCount <= checkCount then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_unlock)
	end

	PuzzleMazeDrawView.super.onEndRefreshCheckPoint(self, lastCheckSum, checkSum, lastCheckCount, checkCount)
end

function PuzzleMazeDrawView:onBeginDragFailed(pointerEventData)
	GameFacade.showToast(ToastEnum.DungeonPuzzle)
end

function PuzzleMazeDrawView:onBeginDrag_SyncPawn()
	PuzzleMazeDrawView.super.onBeginDrag_SyncPawn(self)

	if not self._alreadyDrag then
		local x1, y1 = PuzzleMazeDrawModel.instance:getStartPoint()

		self:closeCheckObject(x1, y1)

		self._alreadyDrag = true
	end
end

function PuzzleMazeDrawView:_initGameDone()
	self:destroy_EndDrag_NoneAlert_Flow()

	self._endDrag_NoneAlert_Flow = FlowSequence.New()

	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.tryTriggerEffect, self, self._endDrag_NoneAlert_Flow))
	self._endDrag_NoneAlert_Flow:start()
end

function PuzzleMazeDrawView:onEndDrag_NoneAlert()
	self:destroy_EndDrag_NoneAlert_Flow()

	self._endDrag_NoneAlert_Flow = FlowSequence.New()

	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.onEndDrag_SyncPawn, self))
	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.syncPath, self))
	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.cleanDragLine, self))
	self._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(self.tryTriggerEffect, self, self._endDrag_NoneAlert_Flow))
	self._endDrag_NoneAlert_Flow:registerDoneListener(self.checkGameFinished, self)
	self._endDrag_NoneAlert_Flow:start()
end

function PuzzleMazeDrawView:destroy_EndDrag_NoneAlert_Flow()
	if self._endDrag_NoneAlert_Flow ~= nil then
		self._endDrag_NoneAlert_Flow:destroy()

		self._endDrag_NoneAlert_Flow = nil
	end
end

function PuzzleMazeDrawView:tryTriggerEffect(flow)
	local posX, posY = self._ctrlInst:getLastPos()
	local obj = PuzzleMazeDrawModel.instance:getObjAtPos(posX, posY)

	if not obj or not obj.effects or #obj.effects <= 0 then
		return
	end

	local canTrigger = PuzzleMazeDrawModel.instance:canTriggerEffect(posX, posY)

	if not canTrigger then
		return
	end

	self:setCanTouch(false)

	self._triggerEffectPosX = posX
	self._triggerEffectPosY = posY

	self:buildTriggerEffectFlow(obj.effects, flow)
end

function PuzzleMazeDrawView:buildTriggerEffectFlow(effects, flow)
	if not self._enableTrigger then
		flow:addWork(WaitEventWork.New(WaitEnableTriggerEffectParam))
	end

	local effectFlow = FlowSequence.New()

	for _, effect in ipairs(effects) do
		local cls = self:getTriggerEffectCls(effect.type)

		if cls then
			local work = cls.New()

			work:initData(effect)
			effectFlow:addWork(work)
		end
	end

	effectFlow:registerDoneListener(self.onTriggerEffectDone, self)
	flow:addWork(effectFlow)
end

function PuzzleMazeDrawView:getTriggerEffectCls(effectType)
	self._effectClsMap = self._effectClsMap or {
		[PuzzleEnum.EffectType.Dialog] = ZhiXinQuanErDialogStep,
		[PuzzleEnum.EffectType.Story] = ZhiXinQuanErStoryStep,
		[PuzzleEnum.EffectType.Guide] = ZhiXinQuanErGuideStep
	}

	return self._effectClsMap[effectType]
end

function PuzzleMazeDrawView:onTriggerEffectDone()
	PuzzleMazeDrawModel.instance:setTriggerEffectDone(self._triggerEffectPosX, self._triggerEffectPosY)

	self._triggerEffectPosX = nil
	self._triggerEffectPosY = nil

	self:setCanTouch(true)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnTriggerEffectDone)
end

function PuzzleMazeDrawView:closeCheckObject(x1, y1)
	local key = PuzzleMazeHelper.getPosKey(x1, y1)
	local itemObj = self._objectMap[key]

	if itemObj and itemObj.setCheckIconVisible then
		itemObj:setCheckIconVisible(false)
	end
end

function PuzzleMazeDrawView:onGameSucc()
	PuzzleMazeDrawView.super.onGameSucc(self)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	gohelper.setActive(self._gofinish, true)
	gohelper.setActive(self._goCheckMark, true)
	PuzzleMazeDrawController.instance:restartGame()
	self:stat(PuzzleEnum.GameResult.Success)
end

function PuzzleMazeDrawView:refreshTargetTips()
	local modelInst = self:getModelInst()
	local elementCo = modelInst and modelInst:getElementCo()
	local elementId = elementCo and elementCo.id
	local episodeCo = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, elementId)

	if episodeCo then
		self._txtTarget.text = episodeCo.target or ""
	end
end

function PuzzleMazeDrawView:onClose()
	PuzzleMazeDrawView.super.onClose(self)
	self:destroy_EndDrag_NoneAlert_Flow()
	TaskDispatcher.cancelTask(self._enableTriggerEffect, self)
end

local GameResultStatName = {
	[PuzzleEnum.GameResult.Success] = "成功",
	[PuzzleEnum.GameResult.Abort] = "中断",
	[PuzzleEnum.GameResult.Restart] = "重新开始"
}

function PuzzleMazeDrawView:stat(gameResult)
	local useTime = ServerTime.now() - self._startGameTime
	local elementCo = PuzzleMazeDrawModel.instance:getElementCo()
	local elementId = elementCo and elementCo.id
	local episodeCo = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, elementId)
	local episodeId = episodeCo and episodeCo.id

	if GameResultStatName then
		local resultName = GameResultStatName[gameResult]

		StatController.instance:track(StatEnum.EventName.Exit_Flutterpage_activity, {
			[StatEnum.EventProperties.UseTime] = useTime,
			[StatEnum.EventProperties.MapId] = tostring(episodeId),
			[StatEnum.EventProperties.Result] = resultName
		})
	end
end

return PuzzleMazeDrawView
