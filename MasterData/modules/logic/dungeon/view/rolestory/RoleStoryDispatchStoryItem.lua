-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchStoryItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchStoryItem", package.seeall)

local RoleStoryDispatchStoryItem = class("RoleStoryDispatchStoryItem", ListScrollCellExtend)

function RoleStoryDispatchStoryItem:onInitView()
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

function RoleStoryDispatchStoryItem:addEvents()
	self.addClickCb(self, self.btnGoto, self.onClickBtnGoto, self)
	self.addClickCb(self, self.btnCanget, self.onClickBtnCanget, self)
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function RoleStoryDispatchStoryItem:removeEvents()
	return
end

function RoleStoryDispatchStoryItem:refreshItem()
	if not self.data then
		self:clear()
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.txtOrder.text = string.format("%02d", self.index)
	self.txtLockedOrder.text = string.format("%02d", self.index)
	self.txtTitle.text = formatLuaLang("rolestorydispatchtitle_1", GameUtil.getNum2Chinese(self.index))
	self.txtContent.text = self.data.desc

	self:refreshState()

	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		self:playFinishAnim()
	end

	self.notFirstUpdate = true
end

function RoleStoryDispatchStoryItem:refreshState()
	local storyMo = RoleStoryModel.instance:getById(self.data.heroStoryId)
	local state = storyMo:getDispatchState(self.data.id)

	gohelper.setActive(self.goFinish, state == RoleStoryEnum.DispatchState.Finish)
	gohelper.setActive(self.goDispatching, state == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(self.goGoto, state == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(self.goCanget, state == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(self.goLocked, state == RoleStoryEnum.DispatchState.Locked)

	if state == RoleStoryEnum.DispatchState.Locked then
		local unlockEpisodeId = self.data.unlockEpisodeId
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(unlockEpisodeId)
		local dungeonName = string.format("%s %s", DungeonConfig.instance:getEpisodeDisplay(unlockEpisodeId), episodeConfig.name)

		self.txtLocked.text = formatLuaLang("room_formula_lock_episode", dungeonName)
	end

	self:refreshDispatchTime(state)

	if state == RoleStoryEnum.DispatchState.Canget then
		self.rewardAnim:Play("loop")
	end

	self:checkPlayAnim()
end

function RoleStoryDispatchStoryItem:_onCloseView(viewName)
	if viewName == ViewName.RoleStoryDispatchTipsView then
		self:checkPlayAnim()
	end
end

function RoleStoryDispatchStoryItem:checkPlayAnim()
	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		local storyMo = RoleStoryModel.instance:getById(self.data.heroStoryId)
		local dispatchMo = storyMo:getDispatchMo(self.data.id)
		local state = dispatchMo:getDispatchState()

		if state == RoleStoryEnum.DispatchState.Finish then
			self:playFinishAnim()
		end

		if dispatchMo:canPlayRefreshAnim() then
			dispatchMo:setRefreshAnimFlag()
			gohelper.setActive(self.goGoto, false)
			gohelper.setActive(self.goLocked, true)
			TaskDispatcher.cancelTask(self.playUnlockAnim, self)

			if not self.notFirstUpdate then
				TaskDispatcher.runDelay(self.playUnlockAnim, self, 1)
			else
				self:playUnlockAnim()
			end
		end
	end
end

function RoleStoryDispatchStoryItem:playUnlockAnim()
	self.lockedAnim:Play("unlock")
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryDispatchUnlock)
	TaskDispatcher.runDelay(self.refreshItem, self, 1.5)
end

function RoleStoryDispatchStoryItem:playFinishAnim()
	local storyMo = RoleStoryModel.instance:getById(self.data.heroStoryId)
	local dispatchMo = storyMo:getDispatchMo(self.data.id)
	local state = dispatchMo:getDispatchState()

	if state == RoleStoryEnum.DispatchState.Finish then
		if dispatchMo:checkFinishAnimIsPlayed() then
			self.finishAnim:Play("go_hasget_idle")
		else
			dispatchMo:setFinishAnimFlag()
			self.finishAnim:Play("go_hasget_in")
		end
	end
end

function RoleStoryDispatchStoryItem:refreshDispatchTime(state)
	TaskDispatcher.cancelTask(self.updateDispatchTime, self)

	if state ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	local storyMo = RoleStoryModel.instance:getById(self.data.heroStoryId)
	local dispatchMo = storyMo:getDispatchMo(self.data.id)

	self.dispatchEndTime = dispatchMo.endTime

	self:updateDispatchTime()
	TaskDispatcher.runRepeat(self.updateDispatchTime, self, 1)
end

function RoleStoryDispatchStoryItem:updateDispatchTime()
	local leftTime = self.dispatchEndTime * 0.001 - ServerTime.now()

	if leftTime < 0 then
		self:refreshItem()

		return
	end

	self.txtDispatchTime.text = TimeUtil.second2TimeString(leftTime, true)
end

function RoleStoryDispatchStoryItem:onUpdateMO(data, index)
	self.data = data
	self.index = index

	self:refreshItem()
end

function RoleStoryDispatchStoryItem:onClickBtnGoto()
	self:openTipsView()
end

function RoleStoryDispatchStoryItem:onClickBtnCanget()
	self:openTipsView()
end

function RoleStoryDispatchStoryItem:onClickBtnClick()
	self:openTipsView()
end

function RoleStoryDispatchStoryItem:openTipsView()
	if not self.data then
		return
	end

	local storyMo = RoleStoryModel.instance:getById(self.data.heroStoryId)
	local state = storyMo:getDispatchState(self.data.id)

	if state == RoleStoryEnum.DispatchState.Locked then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchLockTips)

		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchTipsView, {
		dispatchId = self.data.id,
		storyId = self.data.heroStoryId
	})
end

function RoleStoryDispatchStoryItem:_editableInitView()
	return
end

function RoleStoryDispatchStoryItem:clear()
	TaskDispatcher.cancelTask(self.playUnlockAnim, self)
	TaskDispatcher.cancelTask(self.updateDispatchTime, self)
	TaskDispatcher.cancelTask(self.refreshItem, self)
end

function RoleStoryDispatchStoryItem:onDestroyView()
	self:clear()
end

return RoleStoryDispatchStoryItem
