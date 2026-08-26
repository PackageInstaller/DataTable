-- chunkname: @modules/logic/summon/view/SummonEquipView.lua

module("modules.logic.summon.view.SummonEquipView", package.seeall)

local SummonEquipView = class("SummonEquipView", BaseView)

function SummonEquipView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._goresultitem = gohelper.findChild(self.viewGO, "#go_result/resultcontent/#go_resultitem")
	self._btnopenall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_openall")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_return")
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._gocontroller = gohelper.findChild(self.viewGO, "#go_controller")
	self._goguide = gohelper.findChild(self.viewGO, "#go_drag/#go_guide")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonEquipView:addEvents()
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
end

function SummonEquipView:removeEvents()
	self._btnreturn:RemoveClickListener()
end

function SummonEquipView:_btnreturnOnClick()
	self:_summonEnd()
end

function SummonEquipView:_editableInitView()
	self:checkInitDrawComp()

	self._animMonitor = self._gocontroller:GetComponent(typeof(UnityEngine.Animation))

	local goLight = gohelper.findChild(self._gocontroller, "shiying")

	self._animLight = goLight:GetComponent(typeof(UnityEngine.Animation))
	goLight = nil
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragListener(self.onDrag, self)
	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)
end

function SummonEquipView:handleSkip()
	if not self._isDrawing then
		return
	end

	self:_hideGuide()

	if self:checkInitDrawComp() then
		self._drawComp:skip()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	SummonController.instance:playSkipAnimation(false)
end

function SummonEquipView:onUpdateParam()
	return
end

function SummonEquipView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnterDraw, self.handleAnimStartDraw, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonDraw, self.onDragComplete, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnd, self.onSummonAnimEnd, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonResultClose, self._summonEnd, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonSkip, self.handleSkip, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.handleCloseView, self)
end

function SummonEquipView:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnterDraw, self.handleAnimStartDraw, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonDraw, self.onDragComplete, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnd, self.onSummonAnimEnd, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonResultClose, self._summonEnd, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonSkip, self.handleSkip, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.handleCloseView, self)
end

function SummonEquipView:startDraw()
	if not self:checkInitDrawComp() then
		self:handleSkip()
	end

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonAward))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_open)
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_amb)
	gohelper.setActive(self._goresult, false)
	gohelper.setActive(self._gocontroller, true)
	SummonController.instance:resetAnim()

	self.summonResult = SummonModel.instance:getSummonResult(true)

	local bestRare = SummonModel.getBestRare(self.summonResult)

	self:_summonMoniterAnimIn()

	if self.summonResult and #self.summonResult > 0 then
		self._isDrawing = true

		self._drawComp:resetDraw(bestRare, #self.summonResult > 1)

		if not SummonController.instance:getIsGuideAnim() then
			SummonController.instance:startPlayAnim()
		else
			self:handleAnimStartDraw()
		end
	end
end

function SummonEquipView:checkInitDrawComp()
	if self._drawComp == nil then
		local summonScene = VirtualSummonScene.instance:getSummonScene()

		self._drawComp = summonScene.director:getDrawComp(SummonEnum.ResultType.Equip)
	end

	return self._drawComp ~= nil
end

function SummonEquipView:handleAnimStartDraw()
	local bestRare = SummonModel.getBestRare(self.summonResult)

	gohelper.setActive(self._godrag.gameObject, true)
	SummonController.instance:forbidAnim()
	self:_initDragArea(bestRare)
	self:_showGuide()
end

function SummonEquipView:_initDragArea(rare)
	self._dragAreaInitialized = true
end

function SummonEquipView:onDragComplete()
	gohelper.setActive(self._godrag, false)
	self:_hideGuide()
	self:_summonStart()
end

function SummonEquipView:_summonStart()
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_draw_card)
	gohelper.setActive(self._godrag.gameObject, false)

	if #self.summonResult > 1 then
		SummonController.instance:drawEquipAnim()
	else
		SummonController.instance:drawEquipOnlyAnim()
	end

	self:_boomEffect()
end

function SummonEquipView:_summonMoniterAnimIn()
	self._animLight.enabled = true

	self._animMonitor:Play(SummonEnum.EquipUIAnim.RootGachaIn)

	if #self.summonResult > 1 then
		self._animLight:Play(SummonEnum.EquipUIAnim.LightGacha10)
	else
		self._animLight:Play(SummonEnum.EquipUIAnim.LightGacha1)
	end
end

function SummonEquipView:_boomEffect()
	local bestRare = SummonModel.getBestRare(self.summonResult)
	local uiMonitorAnimName, effectUrl

	uiMonitorAnimName = #self.summonResult > 1 and SummonEnum.EquipUIAnim.RootGachaStart10Prefix or SummonEnum.EquipUIAnim.RootGachaStart1Prefix

	if bestRare == 2 then
		effectUrl = SummonEnum.SummonPreloadPath.EquipBoomN
		uiMonitorAnimName = uiMonitorAnimName .. SummonEnum.EquipUIAnim.RootGachaStartRare3
	elseif bestRare == 3 then
		effectUrl = SummonEnum.SummonPreloadPath.EquipBoomR
		uiMonitorAnimName = uiMonitorAnimName .. SummonEnum.EquipUIAnim.RootGachaStartRare4
	elseif bestRare == 4 then
		effectUrl = SummonEnum.SummonPreloadPath.EquipBoomSR
		uiMonitorAnimName = uiMonitorAnimName .. SummonEnum.EquipUIAnim.RootGachaStartRare5
	elseif bestRare >= 5 then
		effectUrl = SummonEnum.SummonPreloadPath.EquipBoomSSR
		uiMonitorAnimName = uiMonitorAnimName .. SummonEnum.EquipUIAnim.RootGachaStartRare5
	end

	if effectUrl then
		local boomGO = SummonController.instance:getBoomNode(SummonEnum.ResultType.Equip)

		self._boomEffectWrap = SummonEffectPool.getEffect(effectUrl, boomGO)

		self._boomEffectWrap:setAnimationName(SummonEnum.BoomEquipEffectAnimationName[effectUrl])
		self._boomEffectWrap:play()
	end

	self._animLight.enabled = false

	self._animMonitor:Play(uiMonitorAnimName)
end

function SummonEquipView:onSummonAnimEnd()
	gohelper.setActive(self._goresult, true)
	gohelper.setActive(self._btnreturn.gameObject, false)
	gohelper.setActive(self._btnopenall.gameObject, #self.summonResult > 1)
end

function SummonEquipView:_summonEnd()
	SummonController.instance:clearSummonPopupList()

	self.summonResult = {}

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonNormal))
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	gohelper.setActive(self._gosummon, true)
	gohelper.setActive(self._goresult, false)
	gohelper.setActive(self._gocontroller, false)

	if self._boomEffectWrap then
		SummonEffectPool.returnEffect(self._boomEffectWrap)

		self._boomEffectWrap = nil
	end

	SummonController.instance:resetAnim()

	local param = {}

	param.jumpPoolId = SummonController.instance:getLastPoolId()

	SummonMainController.instance:openSummonView(param)
	self:_gc()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonEquipEnd)
end

function SummonEquipView:_showGuide()
	TaskDispatcher.cancelTask(self._showGuide, self)
	gohelper.setActive(self._goguide, true)
end

function SummonEquipView:_hideGuide()
	TaskDispatcher.cancelTask(self._showGuide, self)
	gohelper.setActive(self._goguide, false)
end

function SummonEquipView:onDragBegin(param, eventData)
	self._lastDragTime = nil
	self._lastDragPos = nil
	self._lastDragPos = recthelper.screenPosToAnchorPos(eventData.position, self._godrag.transform)

	self._drawComp:startDrag()
end

function SummonEquipView:onDragEnd(param, eventData)
	self._lastDragPos = nil

	self._drawComp:endDrag()
end

function SummonEquipView:onDrag(param, eventData)
	if not self._dragAreaInitialized then
		return
	end

	local threshold = 0.2
	local curPos = recthelper.screenPosToAnchorPos(eventData.position, self._godrag.transform)

	if not self._lastDragPos then
		self._lastDragPos = curPos

		return
	end

	local distance = math.abs(curPos.y - self._lastDragPos.y)

	if threshold < distance then
		self._drawComp:updateDistance(curPos.y - self._lastDragPos.y)

		self._lastDragPos = curPos
	end
end

function SummonEquipView:handleCloseView(viewName)
	if viewName == ViewName.SummonEquipGainView then
		if self.summonResult then
			if #self.summonResult == 1 then
				self:_summonEnd()
			else
				SummonController.instance:nextSummonPopupParam()
			end
		end
	elseif viewName == ViewName.CommonPropView and self.summonResult and #self.summonResult == 10 then
		self:_summonEnd()
	end
end

function SummonEquipView:_gc()
	self._summonCount = (self._summonCount or 0) + (self.summonResult and #self.summonResult)

	if self._summonCount >= 10 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)

		self._summonCount = 0
	end
end

function SummonEquipView:onDestroyView()
	if self._drag then
		self._drag:RemoveDragListener()
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

return SummonEquipView
