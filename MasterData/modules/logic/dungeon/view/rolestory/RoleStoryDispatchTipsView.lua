-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchTipsView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTipsView", package.seeall)

local RoleStoryDispatchTipsView = class("RoleStoryDispatchTipsView", BaseView)

function RoleStoryDispatchTipsView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.goLeft = gohelper.findChild(self.viewGO, "Layout/left")

	gohelper.setActive(self.goLeft, true)

	self.goRight = gohelper.findChild(self.viewGO, "Layout/right")
	self.animLeft = self.goLeft:GetComponent(typeof(UnityEngine.Animator))
	self.canvasGroupLeft = self.goLeft:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.animRight = self.goRight:GetComponent(typeof(UnityEngine.Animator))

	self:initLeft()
	self:initRight()

	self.goreward = gohelper.findChild(self.viewGO, "#btn_scorereward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchTipsView:initLeft()
	self.txtLeftLable = gohelper.findChildTextMesh(self.goLeft, "#go_herocontainer/header/label")
	self.btnLeftClose = gohelper.findChildButtonWithAudio(self.goLeft, "#go_herocontainer/header/#btn_close")
	self.goLeftHeroContent = gohelper.findChild(self.goLeft, "#go_herocontainer/Mask/#scroll_hero/Viewport/Content")
	self.goHeroItem = gohelper.findChild(self.goLeftHeroContent, "#go_heroitem")

	gohelper.setActive(self.goHeroItem, false)

	self.leftViewShow = false

	self.animLeft:Play("close", 0, 1)

	self.canvasGroupLeft.blocksRaycasts = false
end

function RoleStoryDispatchTipsView:initRight()
	self.txtTitle = gohelper.findChildTextMesh(self.goRight, "#txt_title")
	self.goDescNode = gohelper.findChild(self.goRight, "descNode")
	self.goTalk = gohelper.findChild(self.goDescNode, "#go_Talk")
	self.animTalk = self.goTalk:GetComponent(typeof(UnityEngine.Animator))
	self.goUnDispatch = gohelper.findChild(self.goDescNode, "#go_UnDispatch")
	self.goDispatching = gohelper.findChild(self.goDescNode, "#go_Dispatching")
	self.goDispatched = gohelper.findChild(self.goDescNode, "#go_Dispatched")
	self.talkList = {}
	self.talkTween = RoleStoryDispatchTalkTween.New()
	self.goContent = gohelper.findChild(self.goTalk, "Scroll DecView/Viewport/Content")
	self.goChatItem = gohelper.findChild(self.goContent, "#go_chatitem")

	gohelper.setActive(self.goChatItem, false)

	self.goArrow = gohelper.findChild(self.goTalk, "Scroll DecView/Viewport/arrow")
	self.btnArrow = gohelper.getClickWithAudio(self.goArrow)
	self.goHeroContainer = gohelper.findChild(self.goRight, "#go_Herocontainer")
	self.txtLabel = gohelper.findChildTextMesh(self.goHeroContainer, "label")
	self.rightHeroItems = {}
	self.goBottom = gohelper.findChild(self.goRight, "Bottom")
	self.animBottom = self.goBottom:GetComponent(typeof(UnityEngine.Animator))
	self.goReward = gohelper.findChild(self.goBottom, "Reward")
	self.txtRewardScore = gohelper.findChildTextMesh(self.goReward, "txt/#txt_score")
	self.goBtn = gohelper.findChild(self.goBottom, "Btn")
	self.goDispatch = gohelper.findChild(self.goBtn, "#go_dispatch")
	self.txtCostTime = gohelper.findChildTextMesh(self.goDispatch, "#txt_costtime")
	self.txtGreenCostTime = gohelper.findChildTextMesh(self.goDispatch, "#txt_costtime_green")
	self.btnDispatch = gohelper.findChildButtonWithAudio(self.goDispatch, "#btn_dispatch")
	self.txtCostNum = gohelper.findChildTextMesh(self.goDispatch, "#btn_dispatch/#txt_num")
	self.btnCanget = gohelper.findChildButtonWithAudio(self.goDispatch, "#btn_finished")
	self.goReturn = gohelper.findChild(self.goBtn, "#go_return")
	self.txtReturnCostTime = gohelper.findChildTextMesh(self.goReturn, "#txt_costtime")
	self.goReturnUpIcon = gohelper.findChild(self.goReturn, "#txt_costtime/upicon")
	self.goReturnNormalIcon = gohelper.findChild(self.goReturn, "#txt_costtime/normalicon")
	self.btnReturn = gohelper.findChildButtonWithAudio(self.goReturn, "#btn_return")
	self.goFinish = gohelper.findChild(self.goBottom, "Finish")
	self.txtFinish = gohelper.findChildTextMesh(self.goFinish, "#txt_finished")
end

function RoleStoryDispatchTipsView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnDispatch, self.onClickBtnDispatch, self)
	self.addClickCb(self, self.btnReturn, self.onClickBtnReturn, self)
	self.addClickCb(self, self.btnCanget, self.onClickBtnCanget, self)
	self.addClickCb(self, self.btnLeftClose, self.onClickBtnLeftClose, self)
	self.addClickCb(self, self.btnArrow, self.onClickBtnArrow, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ClickRightHero, self._onClickRightHero, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ChangeSelectedHero, self._onChangeSelectedHero, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, self._onDispatchSuccess, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchReset, self._onDispatchReset, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchFinish, self._onDispatchFinish, self)
end

function RoleStoryDispatchTipsView:removeEvents()
	return
end

function RoleStoryDispatchTipsView:_editableInitView()
	return
end

function RoleStoryDispatchTipsView:_onDispatchSuccess()
	self._playTalkTween = false

	self:activeLeftView(false)
	self:refreshView()
end

function RoleStoryDispatchTipsView:_onDispatchReset()
	self._playTalkTween = false

	self:activeLeftView(true)
	self:refreshView()
end

function RoleStoryDispatchTipsView:_onDispatchFinish()
	self._playTalkTween = true
	self.dispatchState = RoleStoryEnum.DispatchState.Finish

	AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_receive)
	self:playRewardTween()
end

function RoleStoryDispatchTipsView:_onChangeSelectedHero()
	self:refreshView()
end

function RoleStoryDispatchTipsView:getDispatchState()
	return self.dispatchState or self.dispatchMo:getDispatchState()
end

function RoleStoryDispatchTipsView:_onClickRightHero(heroMo)
	local state = self:getDispatchState()

	if state == RoleStoryEnum.DispatchState.Normal then
		if not heroMo then
			self:activeLeftView(not self.leftViewShow)
		else
			RoleStoryDispatchHeroListModel.instance:clickHeroMo(heroMo)
		end
	end
end

function RoleStoryDispatchTipsView:onClickBtnArrow()
	return
end

function RoleStoryDispatchTipsView:onClickBtnLeftClose()
	self:activeLeftView(false)
end

function RoleStoryDispatchTipsView:onClickBtnClose()
	if self.leftViewShow then
		self:activeLeftView(false)

		return
	end

	self:closeThis()
end

function RoleStoryDispatchTipsView:onClickBtnDispatch()
	RoleStoryDispatchHeroListModel.instance:sendDispatch()
end

function RoleStoryDispatchTipsView:onClickBtnReturn()
	RoleStoryDispatchHeroListModel.instance:sendReset()
end

function RoleStoryDispatchTipsView:onClickBtnCanget()
	RoleStoryDispatchHeroListModel.instance:sendGetReward()
end

function RoleStoryDispatchTipsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_open)

	self.dispatchId = self.viewParam.dispatchId
	self.storyId = self.viewParam.storyId

	self:refreshData()
	self:refreshView()
	TaskDispatcher.runDelay(self.talkMoveLast, self, 0.1)
end

function RoleStoryDispatchTipsView:onUpdateParam()
	self.dispatchId = self.viewParam.dispatchId
	self.storyId = self.viewParam.storyId

	self:refreshData()
	self:refreshView()
end

function RoleStoryDispatchTipsView:refreshData()
	self.storyMo = RoleStoryModel.instance:getById(self.storyId)
	self.dispatchMo = self.storyMo:getDispatchMo(self.dispatchId)
	self.config = self.dispatchMo.config

	RoleStoryDispatchHeroListModel.instance:onOpenDispatchView(self.storyMo, self.dispatchMo)
	RoleStoryDispatchHeroListModel.instance:initSelectedHeroList(self.dispatchMo.heroIds)
end

function RoleStoryDispatchTipsView:refreshView()
	TaskDispatcher.cancelTask(self.updateDispatchTime, self)
	TaskDispatcher.cancelTask(self.playFinishTween, self)
	self:refreshLeft()
	self:refreshRight()
end

function RoleStoryDispatchTipsView:refreshLeft()
	if not self.leftViewShow then
		return
	end

	RoleStoryDispatchHeroListModel.instance:refreshHero()

	self.txtLeftLable.text = formatLuaLang("rolestorydispatchcounttips", self.config.count)
end

function RoleStoryDispatchTipsView:refreshRight()
	self.txtTitle.text = self.config.name

	self:refreshDesc()
	self:refreshTalk(self._playTalkTween)

	self._playTalkTween = false

	self:refreshRightHeroContainer()
	self:refreshRightBottom()
end

function RoleStoryDispatchTipsView:refreshDesc()
	local talkHeight = recthelper.getHeight(self.goDescNode.transform)

	recthelper.setHeight(self.goTalk.transform, talkHeight)
end

function RoleStoryDispatchTipsView:refreshRightBottom()
	local state = self:getDispatchState()
	local isFinish = state == RoleStoryEnum.DispatchState.Finish

	gohelper.setActive(self.goFinish, isFinish)
	gohelper.setActive(self.goReward, not isFinish)
	gohelper.setActive(self.goBtn, not isFinish)

	self.txtFinish.text = self.config.completeDesc

	if not isFinish then
		local heros = RoleStoryDispatchHeroListModel.instance:getDispatchHeros()
		local list = {}

		for i, v in ipairs(heros) do
			table.insert(list, v.heroId)
		end

		local isMeetCondition = self.dispatchMo:checkHerosMeetEffectCondition(list)
		local addRewardCount = self.dispatchMo:getEffectAddRewardCount()
		local scoreReward = self.config.scoreReward

		self.txtRewardScore.text = isMeetCondition and addRewardCount > 0 and string.format("%s<#C66030>(+%s)</color>", scoreReward, addRewardCount) or scoreReward

		local isDispatching = state == RoleStoryEnum.DispatchState.Dispatching
		local isNormal = state == RoleStoryEnum.DispatchState.Normal
		local isCanget = state == RoleStoryEnum.DispatchState.Canget

		gohelper.setActive(self.goReturn, isDispatching)
		gohelper.setActive(self.goDispatch, isNormal or isCanget)
		gohelper.setActive(self.btnCanget, isCanget)
		gohelper.setActive(self.btnDispatch, isNormal)

		if isDispatching then
			gohelper.setActive(self.goReturnUpIcon, isMeetCondition)
			gohelper.setActive(self.goReturnNormalIcon, not isMeetCondition)

			self.dispatchEndTime = self.dispatchMo.endTime

			self:updateDispatchTime()
			TaskDispatcher.cancelTask(self.updateDispatchTime, self)
			TaskDispatcher.runRepeat(self.updateDispatchTime, self, 1)
		end

		if isNormal then
			local cost = string.splitToNumber(self.config.consume, "#")
			local costNum = cost[3]
			local hasQuantity = ItemModel.instance:getItemQuantity(cost[1], cost[2])
			local isEnough = costNum <= hasQuantity

			self.txtCostNum.text = isEnough and string.format("-%s", costNum) or string.format("<color=#BF2E11>-%s</color>", costNum)

			local delTimeCount = self.dispatchMo:getEffectDelTimeCount()
			local hasDelTime = isMeetCondition and delTimeCount > 0
			local dispatchTime = self.config.time

			gohelper.setActive(self.txtGreenCostTime, hasDelTime)
			gohelper.setActive(self.txtCostTime, not hasDelTime)

			if hasDelTime then
				self.txtGreenCostTime.text = TimeUtil.second2TimeString(dispatchTime - delTimeCount, true)
			else
				self.txtCostTime.text = TimeUtil.second2TimeString(dispatchTime, true)
			end

			local isEnoughHeroCount = RoleStoryDispatchHeroListModel.instance:isEnoughHeroCount()

			ZProj.UGUIHelper.SetGrayscale(self.btnDispatch.gameObject, not isEnoughHeroCount)
		end

		if isCanget then
			gohelper.setActive(self.txtCostTime, false)
			gohelper.setActive(self.txtGreenCostTime, false)
		end
	end
end

function RoleStoryDispatchTipsView:updateDispatchTime()
	local leftTime = self.dispatchEndTime * 0.001 - ServerTime.now()

	if leftTime < 0 then
		self:refreshView()

		return
	end

	self.txtReturnCostTime.text = TimeUtil.second2TimeString(leftTime, true)
end

function RoleStoryDispatchTipsView:refreshRightHeroContainer()
	self.txtLabel.text = self.config.effectDesc

	local heros = RoleStoryDispatchHeroListModel.instance:getDispatchHeros()

	for i = 1, 4 do
		self:refreshRightHeroItem(self.rightHeroItems[i], heros[i], i)
	end
end

function RoleStoryDispatchTipsView:refreshRightHeroItem(item, data, index)
	item = item or self:createRightHeroItem(index)

	item:onUpdateMO(data, index, self.config.count)
end

function RoleStoryDispatchTipsView:createRightHeroItem(index)
	local go = gohelper.findChild(self.goHeroContainer, string.format("herocontainer/go_selectheroitem%s", index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryDispatchRightHeroItem)

	self.rightHeroItems[index] = item

	return item
end

function RoleStoryDispatchTipsView:refreshTalk(playTween)
	local state = self:getDispatchState()

	gohelper.setActive(self.goUnDispatch, state == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(self.goDispatching, state == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(self.goDispatched, state == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(self.goTalk, state == RoleStoryEnum.DispatchState.Finish)

	if state ~= RoleStoryEnum.DispatchState.Finish then
		for i, v in ipairs(self.talkList) do
			v:onUpdateMO()
		end

		self.talkTween:clearTween()

		return
	end

	local talkIds = string.splitToNumber(self.config.talkIds, "#")

	self:refreshTalkList(talkIds, playTween)

	if playTween then
		self.animTalk:Play("open")
		self.talkTween:playTalkTween(self.talkList)
	else
		self.talkTween:clearTween()
	end
end

function RoleStoryDispatchTipsView:talkMoveLast()
	local state = self:getDispatchState()

	if state == RoleStoryEnum.DispatchState.Normal then
		return
	end

	local contentTransform = self.goContent.transform
	local scrollHeight = recthelper.getHeight(contentTransform.parent)
	local contentHeight = recthelper.getHeight(contentTransform)
	local maxPos = math.max(contentHeight - scrollHeight, 0)

	recthelper.setAnchorY(contentTransform, maxPos)
end

function RoleStoryDispatchTipsView:refreshTalkList(talkIds, playTween)
	local list = {}

	for i, v in ipairs(talkIds) do
		local talkCfg = RoleStoryConfig.instance:getTalkConfig(v)

		if RoleStoryDispatchHeroListModel.instance:canShowTalk(talkCfg) then
			table.insert(list, talkCfg)
		end
	end

	for i = 1, math.max(#list, #self.talkList) do
		self:refreshTalkItem(self.talkList[i], list[i], i)
	end
end

function RoleStoryDispatchTipsView:refreshTalkItem(item, data, index)
	item = item or self:createTalkItem(index)

	item:onUpdateMO(data, index)
end

function RoleStoryDispatchTipsView:createTalkItem(index)
	local go = gohelper.clone(self.goChatItem, self.goContent, string.format("go%s", index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryDispatchTalkItem)

	self.talkList[index] = item

	return item
end

function RoleStoryDispatchTipsView:activeLeftView(active)
	if self.leftViewShow == active then
		return
	end

	self.leftViewShow = active
	self.canvasGroupLeft.blocksRaycasts = active

	if active then
		self.animLeft:Play("open")
		self.animRight:Play("switch1")
		self:refreshLeft()
	else
		self.animLeft:Play("close")
		self.animRight:Play("switch2")
	end
end

function RoleStoryDispatchTipsView:playRewardTween()
	self.animBottom:Play("reward")
	gohelper.setActive(self.goreward, false)
	gohelper.setActive(self.goreward, true)
	TaskDispatcher.runDelay(self.playFinishTween, self, 1.66)
end

function RoleStoryDispatchTipsView:playFinishTween()
	gohelper.setActive(self.goFinish, true)
	self.animBottom:Play("finish")
	TaskDispatcher.runDelay(self.refreshView, self, 0.23)
end

function RoleStoryDispatchTipsView:onClose()
	return
end

function RoleStoryDispatchTipsView:onDestroyView()
	TaskDispatcher.cancelTask(self.talkMoveLast, self)
	RoleStoryDispatchHeroListModel.instance:onCloseDispatchView()
	TaskDispatcher.cancelTask(self.updateDispatchTime, self)
	TaskDispatcher.cancelTask(self.playFinishTween, self)
	TaskDispatcher.cancelTask(self.refreshView, self)

	if self.talkTween then
		self.talkTween:destroy()
	end
end

return RoleStoryDispatchTipsView
