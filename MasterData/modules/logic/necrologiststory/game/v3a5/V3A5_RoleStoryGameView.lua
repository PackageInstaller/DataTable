-- chunkname: @modules/logic/necrologiststory/game/v3a5/V3A5_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a5.V3A5_RoleStoryGameView", package.seeall)

local V3A5_RoleStoryGameView = class("V3A5_RoleStoryGameView", BaseView)

function V3A5_RoleStoryGameView:onInitView()
	self.goMiddle = gohelper.findChild(self.viewGO, "Middle")
	self.goStart = gohelper.findChild(self.viewGO, "Middle/#go_start")
	self.btnStart = gohelper.findChildButtonWithAudio(self.goStart, "#btn_start")
	self.goStartTip1 = gohelper.findChild(self.viewGO, "Middle/#go_start/txt_tips1")
	self.goStartTip2 = gohelper.findChild(self.viewGO, "Middle/#go_start/txt_tips2")
	self.goProgress = gohelper.findChild(self.viewGO, "Middle/#go_progress")

	local goLongPress = gohelper.findChild(self.viewGO, "Middle/#go_progress/#btn_click")

	self.btnLongPress = SLFramework.UGUI.UIClickListener.Get(goLongPress)
	self.scrollbar = gohelper.findChildScrollbar(self.viewGO, "Middle/#go_progress/Scrollbar")
	self.goHoldEffect = gohelper.findChild(self.viewGO, "Middle/#go_progress/Scrollbar/Sliding Area/Hold")
	self.goResult = gohelper.findChild(self.viewGO, "Middle/#go_result")
	self.goResultFront = gohelper.findChild(self.goResult, "front")
	self.goResultBack = gohelper.findChild(self.goResult, "back")
	self.goBottom = gohelper.findChild(self.viewGO, "Bottom")
	self.goContent = gohelper.findChild(self.viewGO, "Bottom/Content")
	self.goNodeItem = gohelper.findChild(self.viewGO, "Bottom/Content/go_nodeitem")
	self.nodeList = {}
	self.goBullet = gohelper.findChild(self.viewGO, "Bottom/Bullet")

	gohelper.setActive(self.goNodeItem, false)

	self.goTopRight = gohelper.findChild(self.viewGO, "#go_topright")
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goComplete = gohelper.findChild(self.viewGO, "Bottom/Complete")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A5_RoleStoryGameView:addEvents()
	self.addClickCb(self, self.btnStart, self.onClickStart, self)
	self.btnLongPress:AddClickDownListener(self._onLongClickDown, self)
	self.btnLongPress:AddClickUpListener(self._onLongClickUp, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A5_GameAnimFinished, self.showResult, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
end

function V3A5_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnStart)
	self.btnLongPress:RemoveClickDownListener()
	self.btnLongPress:RemoveClickUpListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A5_GameAnimFinished, self.showResult, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
end

function V3A5_RoleStoryGameView:_editableInitView()
	return
end

function V3A5_RoleStoryGameView:backEpisodeView()
	if self.uiState == 1 then
		if self.gameIndex and not self.gameResult then
			self:clearGameRes()
			self:refreshView()
		end

		return true
	end

	return false
end

function V3A5_RoleStoryGameView:_gudieEnd(guideId)
	if guideId == GuideEnum.GuideId.V3A5NecrologistStoryGame then
		self:onShowResultEnd()
	end
end

function V3A5_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V3A5_RoleStoryGameView:onClickStart()
	if not self.curIndex then
		return
	end

	if not self.gameBaseMO:isNodeStoryFinish(self.curIndex) then
		local config = NecrologistStoryV3A5Config.instance:getBaseConfig(self.curIndex)

		NecrologistStoryController.instance:openStoryView(config.storyId, self.gameBaseMO.id)

		return
	end

	local nextIndex = self.curIndex + 1
	local config = NecrologistStoryV3A5Config.instance:getBaseConfig(nextIndex)

	if not config then
		return
	end

	self:startGame(nextIndex)
end

function V3A5_RoleStoryGameView:onClickNodeItem(item)
	return
end

function V3A5_RoleStoryGameView:_onLongClickDown()
	local value = self.scrollbar:GetValue()
	local endValue = 1

	if endValue <= value or self.tweenId then
		return
	end

	local speed = 2
	local time = (endValue - value) * speed

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(value, endValue, time, self.setBarValue, self.onTweenComplete, self, nil, EaseType.Linear)

	gohelper.setActive(self.goHoldEffect, true)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_xuli)
end

function V3A5_RoleStoryGameView:_onLongClickUp()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_bfz_yishi_xuli)
	self:flyCoin()
end

function V3A5_RoleStoryGameView:onOpen()
	self.isFirstOpen = true

	self:refreshParam()
	self:refreshView()

	self.isFirstOpen = false
end

function V3A5_RoleStoryGameView:onClose()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_bfz_yishi_xuli)
end

function V3A5_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A5_RoleStoryGameView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
end

function V3A5_RoleStoryGameView:refreshView()
	self.curIndex = self.gameBaseMO:getCurIndex()

	self:refreshIcon()
	self:refreshNodeList()
	self:refreshBullet()

	if self.gameIndex then
		if self.gameResult then
			self:setUIState(2)
		else
			self:setUIState(1)
		end
	else
		self:setUIState(0)
	end
end

function V3A5_RoleStoryGameView:refreshNodeList()
	local configList = NecrologistStoryV3A5Config.instance:getBaseList()

	for i = 1, math.max(#self.nodeList, #configList) do
		self:refreshNodeItem(i, configList[i])
	end

	local isEnd = self.curIndex == 8

	recthelper.setAnchorX(self.goContent.transform, isEnd and 0 or 480)

	local isComplete = isEnd and self.gameBaseMO:isNodeStoryFinish(self.curIndex) or false

	gohelper.setActive(self.goComplete, isComplete)

	if isComplete and self.isComplete == nil then
		local anim = self.goComplete:GetComponent(typeof(UnityEngine.Animator))

		anim:Play("in", 0, 1)
	end

	self.isComplete = isComplete
end

function V3A5_RoleStoryGameView:refreshNodeItem(index, config)
	local item = self.nodeList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.findChild(self.goContent, string.format("go_item%s", index))
		item.goNode = gohelper.clone(self.goNodeItem, item.go, "item")

		gohelper.setActive(item.goNode, true)

		item.txtIndex = gohelper.findChildTextMesh(item.goNode, "#txt_index")
		item.goUnFinish = gohelper.findChild(item.goNode, "#go_unrecord")
		item.goFinish = gohelper.findChild(item.goNode, "#go_recorded")
		item.goFront = gohelper.findChild(item.goNode, "#go_recorded/image_front")
		item.goBack = gohelper.findChild(item.goNode, "#go_recorded/image_back")
		item.goMid = gohelper.findChild(item.goNode, "#go_recorded/image_mid")
		item.animFinish = item.goFinish:GetComponent(typeof(UnityEngine.Animator))
		item.btn = gohelper.findChildButtonWithAudio(item.goNode, "click")

		item.btn:AddClickListener(self.onClickNodeItem, self, item)

		self.nodeList[index] = item
	end

	item.config = config

	gohelper.setActive(item.go, config ~= nil)

	if not config then
		return
	end

	item.txtIndex.text = string.format("%02d", index)

	local isFinish = self.gameBaseMO:isNodeFinish(config.id)
	local isChange = item.isFinish ~= nil and item.isFinish ~= isFinish

	item.isFinish = isFinish

	gohelper.setActive(item.goUnFinish, not isFinish)
	gohelper.setActive(item.goFinish, isFinish)

	if isFinish then
		if config.id == 8 then
			gohelper.setActive(item.goFront, false)
			gohelper.setActive(item.goBack, false)
			gohelper.setActive(item.goMid, true)
		else
			local status = self.gameBaseMO:getNodeStatus(config.id)

			gohelper.setActive(item.goFront, status == NecrologistStoryEnum.V3A5NodeStatus.Front)
			gohelper.setActive(item.goBack, status == NecrologistStoryEnum.V3A5NodeStatus.Back)
			gohelper.setActive(item.goMid, false)
		end

		if isChange then
			item.animFinish:Play("in", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_coin_glow)
		end
	end
end

function V3A5_RoleStoryGameView:refreshIcon()
	local status

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A5_UpdateCoin, self.curIndex, self.curIndex == 0 and NecrologistStoryEnum.V3A5NodeStatus.Front or self.gameBaseMO:getNodeStatus(self.curIndex))
end

function V3A5_RoleStoryGameView:refreshBullet()
	if self.curIndex == 8 then
		gohelper.setActive(self.goBullet, false)

		return
	end

	gohelper.setActive(self.goBullet, true)

	if not self.bulletList then
		self.bulletList = {}
		self.unfilBulletList = {}

		local unfillGOItem = gohelper.findChild(self.goBullet, "unfill/go_bullet")

		gohelper.setActive(unfillGOItem, false)

		for i = 1, 6 do
			local go = gohelper.findChild(self.goBullet, string.format("filled/%s", i))

			table.insert(self.bulletList, go)

			local unfillGO = gohelper.cloneInPlace(unfillGOItem, tostring(i))

			table.insert(self.unfilBulletList, unfillGO)
		end
	end

	local bulletCount = self.gameBaseMO:getBulletCount()

	for i = 1, 6 do
		gohelper.setActive(self.bulletList[i], i <= bulletCount)
		gohelper.setActive(self.unfilBulletList[i], bulletCount < i)
	end
end

function V3A5_RoleStoryGameView:startGame(index)
	self.gameIndex = index

	gohelper.setActive(self.goHoldEffect, false)
	self:setBarValue(0)
	self:setUIState(1)
end

function V3A5_RoleStoryGameView:setBarValue(value)
	self.scrollbar:SetValue(value)
end

function V3A5_RoleStoryGameView:onTweenComplete()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function V3A5_RoleStoryGameView:flyCoin()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	local value = self.scrollbar:GetValue()

	if value < 0.2 then
		GameFacade.showToast(ToastEnum.V3A5NecrologistStoryTips2)
		self:setBarValue(0)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_coin_throw)

	local result = self.gameBaseMO:getGameResult(self.gameIndex)

	self.gameResult = result

	local animResult = self.gameIndex == 8 and 3 or result == NecrologistStoryEnum.V3A5NodeStatus.Front and 1 or 2

	gohelper.setActive(self.goHoldEffect, false)
	gohelper.setActive(self.goProgress, false)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A5_PlayGameAnim, value, animResult, self.gameIndex)
end

function V3A5_RoleStoryGameView:showResult()
	self:setUIState(2)

	if self.gameIndex == 8 then
		gohelper.setActive(self.goResultFront, false)
		gohelper.setActive(self.goResultBack, false)
	else
		gohelper.setActive(self.goResultFront, self.gameResult == NecrologistStoryEnum.V3A5NodeStatus.Front)
		gohelper.setActive(self.goResultBack, self.gameResult == NecrologistStoryEnum.V3A5NodeStatus.Back)
	end

	local guideConfig = GuideConfig.instance:getGuideCO(GuideEnum.GuideId.V3A5NecrologistStoryGame)

	if GuideController.instance:isForbidGuides() or not guideConfig or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.V3A5NecrologistStoryGame) then
		self:showBlock()
		TaskDispatcher.runDelay(self.onShowResultEnd, self, 1)
	end
end

function V3A5_RoleStoryGameView:onShowResultEnd()
	self:closeBlock()
	self.gameBaseMO:setNodeStatus(self.gameIndex, self.gameResult)

	self.gameIndex = nil
	self.gameResult = nil
end

function V3A5_RoleStoryGameView:setUIState(value)
	self.uiState = value

	if value == 0 then
		self.anim:Play("ui_in1")
		gohelper.setActive(self.goProgress, false)
		gohelper.setActive(self.goResult, false)

		local isIndex8 = self.curIndex == 8
		local isStoryFinish = self.gameBaseMO:isNodeStoryFinish(self.curIndex)

		if isIndex8 then
			gohelper.setActive(self.goStart, not isStoryFinish)
			gohelper.setActive(self.goStartTip1, false)
			gohelper.setActive(self.goStartTip2, not isStoryFinish)
		else
			gohelper.setActive(self.goStart, true)
			gohelper.setActive(self.goStartTip1, isStoryFinish)
			gohelper.setActive(self.goStartTip2, not isStoryFinish)
		end

		return
	end

	self.anim:Play("ui_out1")

	if value == 1 then
		gohelper.setActive(self.goStart, false)
		gohelper.setActive(self.goProgress, true)
		gohelper.setActive(self.goResult, false)

		return
	end

	gohelper.setActive(self.goStart, false)
	gohelper.setActive(self.goProgress, false)
	gohelper.setActive(self.goResult, true)
end

function V3A5_RoleStoryGameView:showBlock()
	GameUtil.setActiveUIBlock(self.viewName, true, false)
end

function V3A5_RoleStoryGameView:closeBlock()
	GameUtil.setActiveUIBlock(self.viewName, false, false)
end

function V3A5_RoleStoryGameView:clearGameRes()
	self.gameIndex = nil

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_bfz_yishi_xuli)
end

function V3A5_RoleStoryGameView:onDestroyView()
	for _, item in pairs(self.nodeList) do
		item.btn:RemoveClickListener()
	end

	self:closeBlock()
	self:clearGameRes()
	TaskDispatcher.cancelTask(self.onShowResultEnd, self)
end

return V3A5_RoleStoryGameView
