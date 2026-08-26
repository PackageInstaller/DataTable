-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchStoryView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchStoryView", package.seeall)

local RoleStoryDispatchStoryView = class("RoleStoryDispatchStoryView", BaseView)

function RoleStoryDispatchStoryView:onInitView()
	self.itemList = {}
	self.goDispatchScroll = gohelper.findChild(self.viewGO, "DispatchList/#Scroll_Dispatch")
	self.goDispatch = gohelper.findChild(self.viewGO, "DispatchList/#Scroll_Dispatch/Content/#go_RolestoryDispatch")
	self.content = gohelper.findChild(self.viewGO, "DispatchList/#Scroll_Dispatch/Content")
	self.dispatchType = RoleStoryEnum.DispatchType.Story
	self.btnScore = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_scorereward")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "#btn_scorereward/score/#txt_score")
	self.goScoreRed = gohelper.findChild(self.viewGO, "#btn_scorereward/#go_rewardredpoint")
	self.scoreAnim = gohelper.findChildComponent(self.viewGO, "#btn_scorereward/ani", typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchStoryView:addEvents()
	self.addClickCb(self, self.btnScore, self.onClickBtnScore, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onUpdateInfo, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, self._onScoreUpdate, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, self._onScoreUpdate, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, self._onDispatchStateChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchReset, self._onDispatchStateChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchFinish, self._onDispatchStateChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.StoryDispatchUnlock, self._onStoryDispatchUnlock, self)
end

function RoleStoryDispatchStoryView:removeEvents()
	return
end

function RoleStoryDispatchStoryView:_editableInitView()
	return
end

function RoleStoryDispatchStoryView:onClickBtnScore()
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function RoleStoryDispatchStoryView:_onDispatchStateChange()
	self:refreshView()
end

function RoleStoryDispatchStoryView:_onUpdateInfo()
	self:refreshScore()
	self:refreshView()
end

function RoleStoryDispatchStoryView:_onScoreUpdate()
	self:refreshScore()
end

function RoleStoryDispatchStoryView:_onStoryChange()
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function RoleStoryDispatchStoryView:onOpen()
	self.storyId = self.viewParam.storyId or RoleStoryModel.instance:getCurActStoryId()

	self:refreshScore()
	self:refreshView()
	TaskDispatcher.runDelay(self.delayShow, self, 0.05)
end

function RoleStoryDispatchStoryView:delayShow()
	local storyMo = RoleStoryModel.instance:getById(self.storyId)

	if not storyMo then
		return
	end

	local list = storyMo:getNormalDispatchList()

	if #list == 0 then
		local curItem

		for i, v in ipairs(self.itemList) do
			if v.data and RoleStoryEnum.DispatchState.Canget == storyMo:getDispatchState(v.data.id) then
				curItem = v

				break
			end
		end

		if not curItem then
			for i, v in ipairs(self.itemList) do
				if v.data and RoleStoryEnum.DispatchState.Normal == storyMo:getDispatchState(v.data.id) then
					curItem = v

					break
				end
			end
		end

		if curItem then
			local transform = curItem.viewGO.transform.parent
			local contentTransform = self.content.transform
			local scrollHeight = recthelper.getWidth(contentTransform.parent)
			local contentHeight = recthelper.getWidth(contentTransform) + 92
			local maxPos = math.max(contentHeight - scrollHeight, 0)
			local posX = recthelper.getAnchorX(transform) - 37
			local showPos = math.min(posX, maxPos)

			recthelper.setAnchorX(contentTransform, -showPos)
		end
	end
end

function RoleStoryDispatchStoryView:onUpdateParam()
	self.storyId = self.viewParam.storyId

	self:refreshScore()
	self:refreshView()
end

function RoleStoryDispatchStoryView:refreshView()
	local list = RoleStoryConfig.instance:getDispatchList(self.storyId, self.dispatchType) or {}

	for i = 1, math.max(#list, #self.itemList) do
		self:refreshDispatchItem(self.itemList[i], list[i], i)
	end
end

function RoleStoryDispatchStoryView:refreshDispatchItem(item, data, index)
	item = item or self:createItem(index)

	item:onUpdateMO(data, index)
end

function RoleStoryDispatchStoryView:createItem(index)
	local parentGO = gohelper.findChild(self.goDispatch, string.format("Item/#go_item%s", index))
	local resPath = self.viewContainer:getSetting().otherRes.storyItemRes
	local go = self.viewContainer:getResInst(resPath, parentGO, "go")
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryDispatchStoryItem)

	item.scrollDesc.parentGameObject = self.goDispatchScroll
	self.itemList[index] = item

	return item
end

function RoleStoryDispatchStoryView:refreshScore()
	local storyId = self.storyId
	local storyMo = RoleStoryModel.instance:getById(storyId)

	self.txtScore.text = storyMo and storyMo:getScore() or 0

	local red = storyMo and storyMo:hasScoreReward()

	gohelper.setActive(self.goScoreRed, red)

	if red then
		self.scoreAnim:Play("loop")
	else
		self.scoreAnim:Play("idle")
	end
end

function RoleStoryDispatchStoryView:_onStoryDispatchUnlock()
	TaskDispatcher.cancelTask(self.playUnlockAudio, self)
	TaskDispatcher.runDelay(self.playUnlockAudio, self, 0.05)
end

function RoleStoryDispatchStoryView:playUnlockAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_unlock)
end

function RoleStoryDispatchStoryView:onClose()
	return
end

function RoleStoryDispatchStoryView:onDestroyView()
	TaskDispatcher.cancelTask(self.playUnlockAudio, self)
	TaskDispatcher.cancelTask(self._delayShow, self)
end

return RoleStoryDispatchStoryView
