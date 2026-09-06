-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryView.lua

module("logic.extensions.story.view.StoryView", package.seeall)

local StoryView = class("StoryView", StoryViewBase)

function StoryView:buildUI()
	StoryView.super.buildUI(self)

	self._txtStoryId = self:getTxt("txtStoryId")
end

function StoryView:onEnter()
	StoryController.instance.isOpeningStoryview = true
	self._interactiveView = self._viewPresentor:getViewByName("StoryInteractiveView")

	StoryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SceneStartLoaded, self._onSceneStartLoaded, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoaded, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	ViewMgr.instance:setCustomViewAttachNode(ViewName.NpcIntrodView, self.mainGO)
	self.registerLocalNotify(self, TaskConst.ON_UI_INTERACTIVE_FINISH, self._onUIInteractiveFinish, self)
	GameUtil.SetActive(self._txtStoryId.gameObject, enableDebug)
	print("onEnter storyview")
end

function StoryView:_openBulletScreen()
	if self._currStory then
		local id = self._currStory.id
		local story_id = self._currStory.story_id

		BulletScreenModel.instance:setEnum(GameEnum.BulletScene.PlotCG)

		local maxStoryId = BulletScreenConfig.instance:getStoryMaxStoryId(id)
		local key = ""

		if id ~= nil then
			key = maxStoryId > 0 and id .. "_" .. story_id or id .. "_0"
		end

		BulletScreenModel.instance:setKey(key)

		local cfgs = BulletScreenConfig.instance:getCfgList(GameEnum.BulletScene.PlotCG, key)
		local hasBullets = #cfgs > 0

		if not ViewMgr.instance:isOpen(ViewName.BulletScreen) then
			if hasBullets then
				UIStateManager.instance:open(ViewName.BulletScreen)
				ViewMgr.instance:setCustomViewAttachNode(ViewName.BulletScreen, self.mainGO)
			end
		elseif self._curBulletKey ~= key and hasBullets then
			GlobalDispatcher:dispatch(GlobalNotify.BulletKeyChanged)
		end

		self._curBulletKey = key
	end
end

function StoryView:onExit()
	ViewMgr.instance:close(ViewName.BulletScreen)

	StoryController.instance.isOpeningStoryview = nil

	ViewMgr.instance:setCustomViewAttachNode(ViewName.NpcIntrodView, nil)
	ViewMgr.instance:setCustomViewAttachNode(ViewName.BulletScreen, nil)
	ViewMgr.instance:setCustomViewAttachNode(ViewName.SendBullet, nil)
	GlobalDispatcher:removeListener(GlobalNotify.SceneStartLoaded, self._onSceneStartLoaded, self)
	GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._onSceneLoaded, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	self.unregisterLocalNotify(self, TaskConst.ON_UI_INTERACTIVE_FINISH, self._onUIInteractiveFinish, self)

	self._isTransitionScene = nil
	self._isOpenNpcIntrod = nil
	self._interactiveView = nil

	for k, v in pairs(self._storysTable) do
		v:setTransitionScene(self._isTransitionScene)
		v:setOpeningNpcIntrod(self._isOpenNpcIntrod)
	end

	ViewMgr.instance:setIngorePriority(self._viewPresentor.viewName)
	StoryView.super.onExit(self)
end

function StoryView:finishCurrStory(op, opParams)
	if self._isTransitionScene or self._isOpenNpcIntrod then
		return
	end

	StoryController.instance:finishCurrStory()
	self:_handleOp(op, opParams)

	if self._currStory then
		self:_tryFinishInteractiveTargetStory(self._currStory)
		self:_handleOp(self._currStory.op, self._currStory.opParams)

		self._currStory = nil
	end

	if self._isTransitionScene or self._isOpenNpcIntrod then
		return
	end

	if not self:showNextStory() then
		self:_finishStory()
	end
end

function StoryView:_showStory()
	StoryView.super._showStory(self)

	local needInteractive = self._storysTable[self._currStoryType]:isUIInteractiveTargetStory()

	if needInteractive then
		self._storysTable[self._currStoryType].mainGO:SetActive(false)
		self._interactiveView:enableFrict(self._storyBackground:getBgEffIns())
	else
		self._interactiveView:disableFrict()
	end

	self:_openBulletScreen()
	self:_updateTxtStoryId()
end

function StoryView:_handleOp(op, opParams)
	if op and op ~= 0 then
		self._isTransitionScene = nil

		local exeResult = StoryConst.executeOp(op, opParams)

		if exeResult and exeResult.transitionScene then
			self._isTransitionScene = true
		end

		self._isOpenNpcIntrod = exeResult and exeResult.npcInstrod

		if self._isOpenNpcIntrod then
			self._storysTable[self._currStoryType]:endStory()
		end

		for k, v in pairs(self._storysTable) do
			v:setTransitionScene(self._isTransitionScene)
			v:setOpeningNpcIntrod(self._isOpenNpcIntrod)
		end
	end
end

function StoryView:_hasNextStory()
	return StoryModel.instance:hasStory()
end

function StoryView:_getNextStoryOnly()
	local currStory = StoryModel.instance:getCurStory()

	if currStory then
		return currStory:getNextStoryOnly()
	end
end

function StoryView:_getNextStory()
	local currStory = StoryModel.instance:getCurStory()

	return currStory:getNextStory()
end

function StoryView:_beginFadeOut(handler, tgt)
	StoryView.super._beginFadeOut(self, handler, tgt)

	StoryController.instance.isOpeningStoryview = nil
end

function StoryView:_endStory()
	self:close()
end

function StoryView:_onSceneStartLoaded()
	if not SceneMgr.instance:isTransitionFade() then
		if AMBlurScreenEffect.finalTexture and self._storyBackground then
			self._storyBackground:onSceneLoadedStart()
		end

		for k, v in pairs(self._storysTable) do
			v:onSceneLoadedStart()
		end

		ViewMgr.instance:setIngorePriority(self._viewPresentor.viewName, true)

		self._currStoryType = nil
		self._preStoryType = nil

		self._storyBackground.mainGo:SetActive(false)
		self.mainGO:SetActive(false)
	end
end

function StoryView:_onSceneLoaded()
	ViewMgr.instance:setIngorePriority(self._viewPresentor.viewName)
	self._storyBackground.mainGo:SetActive(true)
	self.mainGO:SetActive(true)

	self._isTransitionScene = nil

	for k, v in pairs(self._storysTable) do
		v:onSceneLoadedFinish()
		v:setTransitionScene(self._isTransitionScene)
	end

	if self:_hasNextStory() then
		GlobalModel.instance:showUI(false, GlobalModel.UIFadeTime)
		self:showNextStory()
	else
		StoryController.instance:finishCurrStory()
		self:_endStory()
	end
end

function StoryView:_onViewClose(view)
	if ViewName.NpcIntrodView == view.viewName then
		self._isOpenNpcIntrod = nil

		for k, v in pairs(self._storysTable) do
			v:setOpeningNpcIntrod(nil)
		end

		if not self:showNextStory() then
			self:_finishStory()
		end
	end
end

function StoryView:_onUIInteractiveFinish()
	if self:_hasNextStory() then
		self._storysTable[self._currStoryType].mainGO:SetActive(true)
	end

	self._storysTable[self._currStoryType]:finishStory()
end

function StoryView:_updateTxtStoryId()
	if not enableDebug then
		GameUtil.SetActive(self._txtStoryId.gameObject, false)

		return
	end

	local storyStory = StoryModel.instance:getCurStory()
	local story = storyStory and storyStory:getCurrStory()
	local storyType = story and story.type
	local id = storyStory and storyStory.storyId
	local story_id = story and story.story_id
	local leftStoryStoryCount = #StoryModel.instance:getStories()

	self._txtStoryId.text = string.format("剧情：%s_%s_%s; 待播：%s", id, story_id, storyType, leftStoryStoryCount)
end

return StoryView
