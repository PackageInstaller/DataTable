-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryGameView", package.seeall)

local V3A2_RoleStoryGameView = class("V3A2_RoleStoryGameView", BaseView)

function V3A2_RoleStoryGameView:onInitView()
	self.goContent = gohelper.findChild(self.viewGO, "Map/Content")
	self.animContent = self.goContent:GetComponent(typeof(UnityEngine.Animator))
	self.baseItemList = {}
	self.txtTabTitle = gohelper.findChildTextMesh(self.viewGO, "tab/title/#txt_title")
	self.goTabItem = gohelper.findChild(self.viewGO, "tab/content/#go_tabitem")

	gohelper.setActive(self.goTabItem, false)

	self.itemTabList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A2_RoleStoryGameView:addEvents()
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, self._onStoryStateChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A2_RoleStoryGameView:removeEvents()
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, self._onStoryStateChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A2_RoleStoryGameView:_editableInitView()
	return
end

function V3A2_RoleStoryGameView:_onStoryStateChange(storyId)
	self:refreshGameState()
	self:onStoryStateChangeRefresh()
end

function V3A2_RoleStoryGameView:_onCloseViewFinish(viewName)
	self:onStoryStateChangeRefresh()
end

function V3A2_RoleStoryGameView:onStoryStateChangeRefresh()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		self._waitRefreshState = true

		return
	end

	self._waitRefreshState = nil

	self:refreshView()
end

function V3A2_RoleStoryGameView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function V3A2_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A2_RoleStoryGameView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
end

function V3A2_RoleStoryGameView:refreshView()
	self:refreshBaseList()
	self:refreshTabList()
end

function V3A2_RoleStoryGameView:refreshBaseList()
	local list = NecrologistStoryV3A2Config.instance:getBaseList()
	local showCount = 0

	for index, config in ipairs(list) do
		local item = self:getBaseItem(index)

		if self:refreshBaseItem(item, config) then
			showCount = showCount + 1
		end
	end

	self:refreshContentX(showCount)
end

function V3A2_RoleStoryGameView:getBaseItem(index)
	local item = self.baseItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.findChild(self.goContent, string.format("go_item%s", index))
		item.goLine = gohelper.findChild(item.go, string.format("image_line%s_%s", index, index + 1))
		item.goLock = gohelper.findChild(item.go, "lock")
		item.goUnlock = gohelper.findChild(item.go, "unlock")
		item.goFinishing = gohelper.findChild(item.go, "finishing")
		item.goMemory = gohelper.findChild(item.go, "#go_memory")

		if not gohelper.isNil(item.goMemory) then
			item.goUnCollect = gohelper.findChild(item.goMemory, "uncollect")
			item.goCollected = gohelper.findChild(item.goMemory, "collected")
		end

		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "#btn_click")

		item.btnClick:AddClickListener(self.onClickBaseItem, self, item)

		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		self.baseItemList[index] = item
	end

	return item
end

function V3A2_RoleStoryGameView:onClickBaseItem(item)
	local config = item.config

	if not config then
		return
	end

	local isUnlock = self.gameBaseMO:isBaseUnlock(config.id)

	if not isUnlock then
		return
	end

	local isFinished = self.gameBaseMO:isBaseFinished(config.id)

	NecrologistStoryController.instance:openStoryView(config.storyId, not isFinished and self.gameBaseMO.id)
end

function V3A2_RoleStoryGameView:refreshBaseItem(item, config)
	item.config = config

	if not config then
		gohelper.setActive(item.go, false)

		return
	end

	local baseState = self.gameBaseMO:getBaseState(config.id)
	local lastState = item.baseState

	item.baseState = baseState

	gohelper.setActive(item.go, baseState ~= NecrologistStoryEnum.V3A2BaseState.Hide)

	if baseState == NecrologistStoryEnum.V3A2BaseState.Hide then
		return
	end

	if lastState and lastState ~= baseState then
		if baseState == NecrologistStoryEnum.V3A2BaseState.Normal then
			item.anim:Play("go_unlock")
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shengyan_yishi_unlock)
		elseif baseState == NecrologistStoryEnum.V3A2BaseState.Lock then
			item.anim:Play("go_lock")
		elseif baseState == NecrologistStoryEnum.V3A2BaseState.Finish then
			item.anim:Play("go_finish")
		end
	elseif baseState == NecrologistStoryEnum.V3A2BaseState.Normal then
		item.anim:Play("unlock")
	elseif baseState == NecrologistStoryEnum.V3A2BaseState.Lock then
		item.anim:Play("lock")
	elseif baseState == NecrologistStoryEnum.V3A2BaseState.Finish then
		item.anim:Play("finish")
	end

	local unlockItem = config.unlockItem

	gohelper.setActive(item.goMemory, unlockItem ~= 0)

	if unlockItem ~= 0 then
		local isCollected = self.gameBaseMO:isItemUnlock(unlockItem)

		gohelper.setActive(item.goUnCollect, not isCollected)
		gohelper.setActive(item.goCollected, isCollected)
	end

	local isUnlock = baseState == NecrologistStoryEnum.V3A2BaseState.Normal
	local isFinished = baseState == NecrologistStoryEnum.V3A2BaseState.Finish

	gohelper.setActive(item.goLock, not isFinished and not isUnlock)
	gohelper.setActive(item.goUnlock, not isFinished and isUnlock)
	gohelper.setActive(item.goFinishing, isFinished)
	gohelper.setActive(item.goLine, isFinished)

	return true
end

function V3A2_RoleStoryGameView:clearBaseList()
	if self.baseItemList then
		for _, item in pairs(self.baseItemList) do
			item.btnClick:RemoveClickListener()
		end

		self.baseItemList = nil
	end
end

function V3A2_RoleStoryGameView:refreshContentX(baseShowCount)
	local flag = 1

	flag = baseShowCount < 4 and 1 or baseShowCount < 6 and 2 or 3

	local lastFlag = self.baseFlag

	self.baseFlag = flag

	if lastFlag and lastFlag ~= flag then
		self.animContent:Play(string.format("from%s", flag))
	else
		self.animContent:Play(string.format("from%s_idle", flag))
	end
end

function V3A2_RoleStoryGameView:refreshTabList()
	local list = NecrologistStoryV3A2Config.instance:getItemList()
	local count = #list
	local showCount = 0

	for index, config in ipairs(list) do
		local item = self:getTabItem(index)

		if self:refreshTabItem(item, config) then
			showCount = showCount + 1
		end
	end

	self.txtTabTitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rolestory_madierda_gameview_title"), showCount, count)
end

function V3A2_RoleStoryGameView:getTabItem(index)
	local item = self.itemTabList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self.goTabItem, tostring(index))
		item.simageTab = gohelper.findChildSingleImage(item.go, "#simage_tab")
		item.btnClick = gohelper.findButtonWithAudio(item.go)

		item.btnClick:AddClickListener(self.onClickTabItem, self, item)

		item.unlockVx = gohelper.findChild(item.go, "#unlock_vx")
		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		self.itemTabList[index] = item
	end

	return item
end

function V3A2_RoleStoryGameView:onClickTabItem(item)
	local config = item.config

	if not config then
		return
	end

	ViewMgr.instance:openView(ViewName.V3A2_RoleStoryItemTipsView, {
		config = config
	})
end

function V3A2_RoleStoryGameView:refreshTabItem(item, config)
	item.config = config

	gohelper.setActive(item.go, config ~= nil)

	if not config then
		return
	end

	local isUnlock = self.gameBaseMO:isItemUnlock(config.id) or false
	local resPath = string.format("singlebg/dungeon/rolestory_singlebg/madierda/rolestory_madierda_tab%s_%s.png", config.image, isUnlock and 1 or 0)

	item.simageTab:LoadImage(resPath)
	gohelper.setActive(item.unlockVx, isUnlock)

	local lastUnlock = item.isUnlock

	item.isUnlock = isUnlock

	if lastUnlock ~= nil and lastUnlock ~= isUnlock and isUnlock then
		item.anim:Play("unlock")
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shengyan_yishi_rewards)
	else
		item.anim:Play("idle")
	end

	return isUnlock
end

function V3A2_RoleStoryGameView:clearTabList()
	if self.itemTabList then
		for _, item in pairs(self.itemTabList) do
			item.btnClick:RemoveClickListener()
			item.simageTab:UnLoadImage()
		end

		self.itemTabList = nil
	end
end

function V3A2_RoleStoryGameView:refreshGameState()
	return
end

function V3A2_RoleStoryGameView:onDestroyView()
	self:clearBaseList()
	self:clearTabList()
end

return V3A2_RoleStoryGameView
