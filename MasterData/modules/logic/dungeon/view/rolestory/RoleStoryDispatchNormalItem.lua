-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchNormalItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchNormalItem", package.seeall)

local RoleStoryDispatchNormalItem = class("RoleStoryDispatchNormalItem", ListScrollCellExtend)

function RoleStoryDispatchNormalItem:onInitView()
	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.txtOrder = gohelper.findChildTextMesh(self.viewGO, "#txt_order")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "#txt_title")
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "#scroll_Desc/Viewport/#txt_DecContent")
	self.scrollDesc = gohelper.findChild(self.viewGO, "#scroll_Desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goFinish = gohelper.findChild(self.viewGO, "#go_finish")
	self.finishAnim = gohelper.findChildComponent(self.goFinish, "icon/go_hasget", typeof(UnityEngine.Animator))
	self.goDispatching = gohelper.findChild(self.viewGO, "#go_dispatching")
	self.txtDispatchTime = gohelper.findChildTextMesh(self.goDispatching, "#txt_time")
	self.goGoto = gohelper.findChild(self.viewGO, "#go_goto")
	self.btnGoto = gohelper.findChildButtonWithAudio(self.goGoto, "#btn_goto")
	self.goCanget = gohelper.findChild(self.viewGO, "#go_canget")
	self.btnCanget = gohelper.findChildButtonWithAudio(self.goCanget, "#btn_canget")
	self.rewardAnim = gohelper.findChildComponent(self.goCanget, "#btn_canget/ani", typeof(UnityEngine.Animator))
	self.goLocked = gohelper.findChild(self.viewGO, "#go_locked")
	self.lockedAnim = gohelper.findChildComponent(self.viewGO, "#go_locked", typeof(UnityEngine.Animator))
	self.txtLockedOrder = gohelper.findChildTextMesh(self.goLocked, "#txt_order")
	self.txtLocked = gohelper.findChildTextMesh(self.goLocked, "#txt_locked")
	self.btnClick = gohelper.getClickWithAudio(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchNormalItem:addEvents()
	self.addClickCb(self, self.btnGoto, self.onClickBtnGoto, self)
	self.addClickCb(self, self.btnCanget, self.onClickBtnCanget, self)
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function RoleStoryDispatchNormalItem:removeEvents()
	return
end

function RoleStoryDispatchNormalItem:refreshItem()
	TaskDispatcher.cancelTask(self.refreshItem, self)

	self.isPlayingRefresh = false

	if not self.data then
		self:clear()
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local config = self.data.config

	self.txtOrder.text = string.format("%02d", self.index)
	self.txtLockedOrder.text = string.format("%02d", self.index)

	self:refreshState()

	if not self.isPlayingRefresh then
		self.txtTitle.text = luaLang("rolestorydispatchtitle_2")
		self.txtContent.text = config.desc
	end
end

function RoleStoryDispatchNormalItem:_onCloseView(viewName)
	if viewName == ViewName.RoleStoryDispatchTipsView then
		self:checkPlayAnim()
	end
end

function RoleStoryDispatchNormalItem:checkPlayAnim()
	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		local state = self.data:getDispatchState()

		if state == RoleStoryEnum.DispatchState.Finish then
			self:playFinishAnim()
		end

		if self.canPlayUnlockAnim then
			self.canPlayUnlockAnim = false

			self.data:setRefreshAnimFlag()
			gohelper.setActive(self.goLocked, true)
			self.lockedAnim:Play("unlock")
			TaskDispatcher.runDelay(self.refreshItem, self, 1.5)
		elseif self.data:canPlayRefreshAnim() then
			self.data:setRefreshAnimFlag()
			RoleStoryController.instance:dispatchEvent(RoleStoryEvent.NormalDispatchRefresh)
			self.viewAnim:Play("refresh", 0, 0)

			self.isPlayingRefresh = true

			TaskDispatcher.runDelay(self.refreshItem, self, 0.5)
		end
	end
end

function RoleStoryDispatchNormalItem:playFinishAnim()
	if self.data:checkFinishAnimIsPlayed() then
		self.finishAnim:Play("go_hasget_idle")
	else
		self.data:setFinishAnimFlag()
		self.finishAnim:Play("go_hasget_in")
	end
end

function RoleStoryDispatchNormalItem:refreshState()
	local state = self.data:getDispatchState()

	if self.waitUnlock then
		state = RoleStoryEnum.DispatchState.Locked
	end

	gohelper.setActive(self.goFinish, state == RoleStoryEnum.DispatchState.Finish)
	gohelper.setActive(self.goDispatching, state == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(self.goGoto, state == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(self.goCanget, state == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(self.goLocked, state == RoleStoryEnum.DispatchState.Locked)
	self:refreshDispatchTime(state)

	if self.waitUnlock then
		return
	end

	if state == RoleStoryEnum.DispatchState.Canget then
		self.rewardAnim:Play("loop")
	end

	self:checkPlayAnim()
end

function RoleStoryDispatchNormalItem:refreshDispatchTime(state)
	TaskDispatcher.cancelTask(self.updateDispatchTime, self)

	if state ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	self.dispatchEndTime = self.data.endTime

	self:updateDispatchTime()
	TaskDispatcher.runRepeat(self.updateDispatchTime, self, 1)
end

function RoleStoryDispatchNormalItem:updateDispatchTime()
	local leftTime = self.dispatchEndTime * 0.001 - ServerTime.now()

	if leftTime < 0 then
		self:refreshItem()

		return
	end

	self.txtDispatchTime.text = TimeUtil.second2TimeString(leftTime, true)
end

function RoleStoryDispatchNormalItem:onUpdateMO(data, storyId, index, param)
	self.data = data
	self.index = index
	self.storyId = storyId
	self.param = param or {}
	self.canPlayUnlockAnim = self.param.canPlayUnlockAnim
	self.waitUnlock = self.param.waitUnlock

	self:refreshItem()
end

function RoleStoryDispatchNormalItem:onClickBtnGoto()
	self:openTipsView()
end

function RoleStoryDispatchNormalItem:onClickBtnCanget()
	self:openTipsView()
end

function RoleStoryDispatchNormalItem:onClickBtnClick()
	self:openTipsView()
end

function RoleStoryDispatchNormalItem:openTipsView()
	if not self.data then
		return
	end

	local state = self.data:getDispatchState()

	if state == RoleStoryEnum.DispatchState.Locked or state == RoleStoryEnum.DispatchState.goFinish then
		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchTipsView, {
		dispatchId = self.data.id,
		storyId = self.storyId
	})
end

function RoleStoryDispatchNormalItem:_editableInitView()
	return
end

function RoleStoryDispatchNormalItem:clear()
	TaskDispatcher.cancelTask(self.updateDispatchTime, self)
end

function RoleStoryDispatchNormalItem:onDestroyView()
	self:clear()
	TaskDispatcher.cancelTask(self.refreshItem, self)
end

return RoleStoryDispatchNormalItem
