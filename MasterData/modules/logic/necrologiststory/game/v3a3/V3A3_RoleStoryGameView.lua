-- chunkname: @modules/logic/necrologiststory/game/v3a3/V3A3_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a3.V3A3_RoleStoryGameView", package.seeall)

local V3A3_RoleStoryGameView = class("V3A3_RoleStoryGameView", BaseView)

function V3A3_RoleStoryGameView:onInitView()
	self.goPanel = gohelper.findChild(self.viewGO, "Panel")
	self.goFireRoot = gohelper.findChild(self.goPanel, "goFire")
	self.goFire1 = gohelper.findChild(self.goFireRoot, "fire_1")
	self.goFire2 = gohelper.findChild(self.goFireRoot, "fire_2")
	self.goFire3 = gohelper.findChild(self.goFireRoot, "fire_3")
	self.btnFire1 = gohelper.findChildButtonWithAudio(self.goFireRoot, "fire_1")
	self.btnFire2 = gohelper.findChildButtonWithAudio(self.goFireRoot, "fire_2")
	self.btnFire3 = gohelper.findChildButtonWithAudio(self.goFireRoot, "fire_3")
	self.goFireTips = gohelper.findChild(self.viewGO, "Panel/goFire/top_bg")
	self.goMemoryTips = gohelper.findChild(self.viewGO, "Panel/goMemory/top_bg")

	self:initItemList()

	self.goLetter = gohelper.findChild(self.viewGO, "goLetter")
	self.goUnopen = gohelper.findChild(self.goLetter, "unopen")
	self.goOpened = gohelper.findChild(self.goLetter, "opened")
	self.btnLetter = gohelper.findChildButtonWithAudio(self.goLetter, "unopen")
	self.animPanel = self.goPanel:GetComponent(typeof(UnityEngine.Animator))
	self.animLetter = self.goLetter:GetComponent(typeof(UnityEngine.Animator))
	self.goFinished = gohelper.findChild(self.viewGO, "#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A3_RoleStoryGameView:addEvents()
	self.addClickCb(self, self.btnFire1, self.onClickFire, self)
	self.addClickCb(self, self.btnFire2, self.onClickFire, self)
	self.addClickCb(self, self.btnFire3, self.onClickFire, self)
	self.addClickCb(self, self.btnLetter, self.onClickLetter, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, self._onStoryStateChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A3_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnFire1)
	self:removeClickCb(self.btnFire2)
	self:removeClickCb(self.btnFire3)
	self:removeClickCb(self.btnLetter)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, self._onStoryStateChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A3_RoleStoryGameView:_editableInitView()
	return
end

function V3A3_RoleStoryGameView:_onStoryStateChange(storyId)
	self:onStoryStateChangeRefresh()
end

function V3A3_RoleStoryGameView:onClickLetter()
	local isOpened = self.gameBaseMO:getLetterOpened()
	local isFinished = self.gameBaseMO:isStoryFinish(NecrologistStoryEnum.V3A3Story.Last)

	if isOpened and isFinished then
		return
	end

	if isOpened then
		self:playLastStory()
	else
		self.gameBaseMO:setLetterOpened(true)
		self:refreshStage()
	end
end

function V3A3_RoleStoryGameView:_onOpenView(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.GuideView
	})

	if isTop then
		return
	end

	if self.isPlayingFire then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_yuanzheng_bonfire_loop)

		self.isPlayingFire = false
	end
end

function V3A3_RoleStoryGameView:_onCloseViewFinish(viewName)
	if viewName == ViewName.GuideView then
		return
	end

	self:onStoryStateChangeRefresh()
end

function V3A3_RoleStoryGameView:onClickFire()
	local stage = self.gameBaseMO:getFireStage()
	local nextStage = stage + 1

	if nextStage > 2 then
		if not self.gameBaseMO:isStoryFinish(NecrologistStoryEnum.V3A3Story.Second) then
			NecrologistStoryController.instance:openStoryView(NecrologistStoryEnum.V3A3Story.Second, self.gameBaseMO.id)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shuori_evegift_click)

	self.clickCount = self.clickCount or 0
	self.clickCount = self.clickCount + 1

	if self.clickCount < 4 then
		return
	end

	self.clickCount = 0

	self.gameBaseMO:setFireStage(nextStage)
	self:refreshStage()
end

function V3A3_RoleStoryGameView:initItemList()
	self.goMemoryRoot = gohelper.findChild(self.goPanel, "goMemory")
	self.itemList = {}

	for i = 1, 4 do
		local go = gohelper.findChild(self.goMemoryRoot, string.format("go_memory%s", i))
		local item = self:getUserDataTb_()

		item.go = go
		item.index = i
		item.goLock = gohelper.findChild(item.go, "lock")
		item.goUnlock = gohelper.findChild(item.go, "unlock")
		item.goFinish = gohelper.findChild(item.go, "unlock/go_finish")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickItem, self, item)

		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		item.animFinish = gohelper.findChildComponent(item.go, "unlock/go_finish/go_hasget", typeof(UnityEngine.Animator))

		table.insert(self.itemList, item)
	end
end

function V3A3_RoleStoryGameView:onClickItem(item)
	if not item then
		return
	end

	local state = self.gameBaseMO:getStoryState(item.storyId)
	local isLock = state == NecrologistStoryEnum.StoryState.Lock

	if isLock then
		return
	end

	local isFinish = state == NecrologistStoryEnum.StoryState.Finish

	NecrologistStoryController.instance:openStoryView(item.storyId, not isFinish and self.gameBaseMO.id)
end

function V3A3_RoleStoryGameView:onStoryStateChangeRefresh()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		self._waitRefreshState = true

		return
	end

	self._waitRefreshState = nil

	self:refreshView()
end

function V3A3_RoleStoryGameView:onOpen()
	self.isFirstOpen = true

	self:refreshParam()
	self:refreshView()

	self.isFirstOpen = false
end

function V3A3_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A3_RoleStoryGameView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
end

function V3A3_RoleStoryGameView:refreshView()
	self:refreshStage()
end

function V3A3_RoleStoryGameView:refreshStage()
	TaskDispatcher.cancelTask(self.playFireAudio, self)
	TaskDispatcher.cancelTask(self._dispatchShowLetter, self)
	TaskDispatcher.cancelTask(self._dispatchShowFire, self)
	TaskDispatcher.cancelTask(self.playLastStory, self)
	TaskDispatcher.cancelTask(self.playSecondStory, self)
	gohelper.setActive(self.goFinished, false)

	local isMemoryFinish = self.gameBaseMO:isStoryFinish(NecrologistStoryEnum.V3A3Story.Memory)

	if isMemoryFinish then
		self:showLetter()

		return
	end

	gohelper.setActive(self.goLetter, false)
	gohelper.setActive(self.goPanel, true)
	self:showFire()

	if self.gameBaseMO:isStoryFinish(NecrologistStoryEnum.V3A3Story.Second) then
		self:showMemory()
	end
end

function V3A3_RoleStoryGameView:showLetter()
	if self.isPlayingFire then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_yuanzheng_bonfire_loop)

		self.isPlayingFire = false
	end

	gohelper.setActive(self.goPanel, false)
	gohelper.setActive(self.goLetter, true)

	local isOpened = self.gameBaseMO:getLetterOpened()
	local isChange = self.isOpenedLetter ~= nil and self.isOpenedLetter ~= isOpened

	if not isOpened then
		TaskDispatcher.runDelay(self._dispatchShowLetter, self, 0.1)
	end

	if isOpened then
		if isChange then
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_lushang_zhihuibu_paper2)
			self.animLetter:Play("open")
			GameUtil.setActiveUIBlock(self.viewName, true, false)
			TaskDispatcher.runDelay(self.playLastStory, self, 0.7)
		elseif self.isFirstOpen then
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_lushang_zhihuibu_paper2)
			self.animLetter:Play("open_in")
		else
			self.animLetter:Play("openidle")
		end
	else
		self.animLetter:Play("unopen_in")
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_lushang_zhihuibu_fanhui)
	end

	self.isOpenedLetter = isOpened

	local isFinished = self.gameBaseMO:isStoryFinish(NecrologistStoryEnum.V3A3Story.Last)

	gohelper.setActive(self.goFinished, isFinished)
end

function V3A3_RoleStoryGameView:showFire()
	TaskDispatcher.runDelay(self.playFireAudio, self, 0.1)
	gohelper.setActive(self.goMemoryRoot, false)
	gohelper.setActive(self.goFireTips, true)
	gohelper.setActive(self.goMemoryTips, false)

	local lastStage = self.stage
	local stage = self.gameBaseMO:getFireStage()
	local isChange = lastStage and lastStage ~= stage

	if stage == 1 then
		self.animPanel:Play("idle")
	elseif stage == 2 then
		self.animPanel:Play("fireup")
	end

	self.stage = stage

	gohelper.setActive(self.goFire1, stage == 1)
	gohelper.setActive(self.goFire2, false)
	gohelper.setActive(self.goFire3, stage == 2)

	if stage == 1 then
		TaskDispatcher.runDelay(self._dispatchShowFire, self, 0.1)
	end

	if isChange and stage == 2 and not self.gameBaseMO:isStoryFinish(NecrologistStoryEnum.V3A3Story.Second) then
		GameUtil.setActiveUIBlock(self.viewName, true, false)
		TaskDispatcher.runDelay(self.playSecondStory, self, 1.2)
	end
end

function V3A3_RoleStoryGameView:_dispatchShowLetter()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A3_ShowLetter)
end

function V3A3_RoleStoryGameView:_dispatchShowFire()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A3_ShowFire)
end

function V3A3_RoleStoryGameView:playLastStory()
	GameUtil.setActiveUIBlock(self.viewName, false, false)
	NecrologistStoryController.instance:openStoryView(NecrologistStoryEnum.V3A3Story.Last, self.gameBaseMO.id)
end

function V3A3_RoleStoryGameView:playSecondStory()
	GameUtil.setActiveUIBlock(self.viewName, false, false)
	NecrologistStoryController.instance:openStoryView(NecrologistStoryEnum.V3A3Story.Second, self.gameBaseMO.id)
end

function V3A3_RoleStoryGameView:showMemory()
	gohelper.setActive(self.goMemoryRoot, true)
	gohelper.setActive(self.goFireTips, false)
	gohelper.setActive(self.goMemoryTips, true)

	local storyId = NecrologistStoryEnum.V3A3Story.Memory

	for i = 4, 1, -1 do
		self:refreshItem(self.itemList[i], storyId)

		storyId = storyId - 1
	end
end

function V3A3_RoleStoryGameView:refreshItem(item, storyId)
	item.storyId = storyId

	local state = self.gameBaseMO:getStoryState(storyId)
	local isLock = state == NecrologistStoryEnum.StoryState.Lock

	gohelper.setActive(item.goLock, isLock)
	gohelper.setActive(item.goUnlock, not isLock)

	if not isLock then
		local isFinish = state == NecrologistStoryEnum.StoryState.Finish

		gohelper.setActive(item.goFinish, isFinish)

		if isFinish then
			if not item.isFinish then
				item.animFinish:Play("finish")
			else
				item.animFinish:Play("idle")
			end
		end

		item.isFinish = isFinish
	end

	if isLock then
		item.anim:Play("lock")
	elseif item.isLock then
		gohelper.setActive(item.goLock, true)
		item.anim:Play("unlock")
	else
		item.anim:Play("normal")
	end

	item.isLock = isLock
end

function V3A3_RoleStoryGameView:playFireAudio()
	if not self.isPlayingFire then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yuanzheng_bonfire_loop)

		self.isPlayingFire = true
	end
end

function V3A3_RoleStoryGameView:onDestroyView()
	if self.isPlayingFire then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_yuanzheng_bonfire_loop)

		self.isPlayingFire = false
	end

	TaskDispatcher.cancelTask(self.playFireAudio, self)
	TaskDispatcher.cancelTask(self._dispatchShowLetter, self)
	TaskDispatcher.cancelTask(self._dispatchShowFire, self)
	TaskDispatcher.cancelTask(self.playLastStory, self)
	TaskDispatcher.cancelTask(self.playSecondStory, self)
	GameUtil.setActiveUIBlock(self.viewName, false, false)

	if self.itemList then
		for _, item in ipairs(self.itemList) do
			item.btn:RemoveClickListener()
		end

		self.itemList = nil
	end
end

return V3A3_RoleStoryGameView
