-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonDragView.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonDragView", package.seeall)

local RoomCritterSummonDragView = class("RoomCritterSummonDragView", BaseView)

function RoomCritterSummonDragView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._goresultitem = gohelper.findChild(self.viewGO, "#go_result/resultcontent/#go_resultitem")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_return")
	self._btnopenall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_openall")
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._goguide = gohelper.findChild(self.viewGO, "#go_drag/#go_guide")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonDragView:addEvents()
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onSummonSkip, self._onSummonSkip, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCanDrag, self._onCanDrag, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onEndSummon, self._onSummonDragEnd, self)
end

function RoomCritterSummonDragView:removeEvents()
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onSummonSkip, self._onSummonSkip, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCanDrag, self._onCanDrag, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onEndSummon, self._onSummonDragEnd, self)
end

function RoomCritterSummonDragView:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragListener(self.onDrag, self)
	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)
	gohelper.setActive(self._goresultitem, false)
	gohelper.setActive(self._goresult, false)
end

function RoomCritterSummonDragView:onOpen()
	gohelper.setActive(self._godrag.gameObject, false)

	self._lastDragAngle = nil
end

function RoomCritterSummonDragView:onClose()
	TaskDispatcher.cancelTask(self._showGuide, self)
end

function RoomCritterSummonDragView:onDestroyView()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
end

function RoomCritterSummonDragView:_runDelayShowGuide()
	gohelper.setActive(self._goguide, false)
	TaskDispatcher.runDelay(self._showGuide, self, 0.3)
end

function RoomCritterSummonDragView:_showGuide()
	TaskDispatcher.cancelTask(self._showGuide, self)
	gohelper.setActive(self._goguide, true)
end

function RoomCritterSummonDragView:_hideGuide()
	TaskDispatcher.cancelTask(self._showGuide, self)
	gohelper.setActive(self._goguide, false)
end

function RoomCritterSummonDragView:onDragBegin(param, eventData)
	if self._startPlayAnim then
		return
	end

	self._lastDragAngle = eventData.position

	self:_hideGuide()
end

local dragDis = 1

function RoomCritterSummonDragView:onDragEnd(param, eventData)
	if not self._lastDragAngle or self._startPlayAnim then
		return
	end

	local isDown = self._lastDragAngle.y - eventData.position.y > dragDis

	if isDown and self.viewParam then
		if self.viewParam.critterMo then
			local co = self.viewParam.critterMo:getDefineCfg()

			if self.viewParam.critterMo then
				self._startPlayAnim = true

				CritterSummonController.instance:onSummonDragEnd(self.viewParam.mode, self.viewParam.critterMo.rare)
				self:_hideGuide()
				gohelper.setActive(self._godrag.gameObject, false)

				local mode = self.viewParam.mode
				local audioId = RoomSummonEnum.SummonMode[mode].AudioId

				self._audioId = AudioMgr.instance:trigger(audioId)

				return
			end
		end
	end

	self:_runDelayShowGuide()
end

function RoomCritterSummonDragView:onDrag(param, eventData)
	return
end

function RoomCritterSummonDragView:_onSummonSkip()
	self:openSummonGetCritterView(self.viewParam, true)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

function RoomCritterSummonDragView:_onCanDrag()
	gohelper.setActive(self._godrag.gameObject, true)
	self:_runDelayShowGuide()
end

function RoomCritterSummonDragView:_onSummonDragEnd()
	self:openSummonGetCritterView(self.viewParam, false)
end

function RoomCritterSummonDragView:openSummonGetCritterView(param, isSkip)
	if param.mode == RoomSummonEnum.SummonType.Summon and param.critterMOList and #param.critterMOList > 1 then
		ViewMgr.instance:openView(ViewName.RoomCritterSummonResultView, param)
		ViewMgr.instance:closeView(ViewName.RoomCritterSummonSkipView)
	else
		CritterSummonController.instance:openSummonGetCritterView(param, isSkip)
	end
end

return RoomCritterSummonDragView
