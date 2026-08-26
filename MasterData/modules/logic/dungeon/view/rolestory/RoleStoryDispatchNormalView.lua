-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchNormalView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchNormalView", package.seeall)

local RoleStoryDispatchNormalView = class("RoleStoryDispatchNormalView", BaseView)

function RoleStoryDispatchNormalView:onInitView()
	self.itemList = {}
	self.goDispatchList = gohelper.findChild(self.viewGO, "DispatchList")
	self.goDispatchScroll = gohelper.findChild(self.viewGO, "DispatchList/#Scroll_Dispatch")
	self.goDispatch = gohelper.findChild(self.viewGO, "DispatchList/#Scroll_Dispatch/Content/#go_NormalDispatch")
	self.content = gohelper.findChild(self.viewGO, "DispatchList/#Scroll_Dispatch/Content")
	self._hLayoutGroup = self.content:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self.dispatchType = RoleStoryEnum.DispatchType.Normal
	self.txtTips = gohelper.findChildTextMesh(self.goDispatch, "Title/txt/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchNormalView:addEvents()
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.NormalDispatchRefresh, self._onNormalDispatchRefresh, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, self._onDispatchStateChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchReset, self._onDispatchStateChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.DispatchFinish, self._onDispatchStateChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onDispatchStateChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function RoleStoryDispatchNormalView:removeEvents()
	return
end

function RoleStoryDispatchNormalView:_editableInitView()
	return
end

function RoleStoryDispatchNormalView:_onCloseView(viewName)
	self:playUnlockTween()
end

function RoleStoryDispatchNormalView:_onDispatchStateChange()
	self:refreshView()
end

function RoleStoryDispatchNormalView:onOpen()
	self.storyId = self.viewParam.storyId or RoleStoryModel.instance:getCurActStoryId()

	self:refreshView()

	if self.normalViewShow then
		local screenWidth = recthelper.getWidth(self.goDispatchList.transform)
		local viewWidth = recthelper.getWidth(self.goDispatch.transform)

		self._hLayoutGroup.padding.right = (screenWidth - viewWidth) / 2

		self:doDelayShow()
	end
end

function RoleStoryDispatchNormalView:playUnlockTween()
	if ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		return
	end

	if self.needTween then
		self:doDelayShow()
	end
end

function RoleStoryDispatchNormalView:doDelayShow()
	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.runDelay(self.delayShow, self, 0.05)
end

function RoleStoryDispatchNormalView:moveLast(tween)
	if self.tweenId then
		return
	end

	self.needTween = false

	local contentTransform = self.content.transform
	local scrollHeight = recthelper.getWidth(contentTransform.parent)
	local contentHeight = recthelper.getWidth(contentTransform)
	local maxPos = math.max(contentHeight - scrollHeight, 0)
	local caleMovePosX = -maxPos

	if tween then
		AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_receive_2)

		self.tweenId = ZProj.TweenHelper.DOAnchorPosX(contentTransform, caleMovePosX, 1, self.onMoveEnd, self)
	else
		recthelper.setAnchorX(contentTransform, caleMovePosX)
	end
end

function RoleStoryDispatchNormalView:onMoveEnd()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	local storyMo = RoleStoryModel.instance:getById(self.storyId)

	if not storyMo then
		return
	end

	GameFacade.showToast(ToastEnum.RoleStoryDispatchNormalUnlock)

	local list = storyMo:getNormalDispatchList()

	self:refreshDispatchList(list, true)
	storyMo:setPlayNormalDispatchUnlockAnimFlag()
end

function RoleStoryDispatchNormalView:delayShow()
	self:moveLast(self.needTween)
end

function RoleStoryDispatchNormalView:onUpdateParam()
	self.storyId = self.viewParam.storyId

	self:refreshView()
end

function RoleStoryDispatchNormalView:refreshView()
	self.normalViewShow = false

	local storyMo = RoleStoryModel.instance:getById(self.storyId)

	if not storyMo then
		self:clearItems()
		gohelper.setActive(self.goDispatch, false)

		return
	end

	local list = storyMo:getNormalDispatchList()

	if #list == 0 then
		self:clearItems()
		gohelper.setActive(self.goDispatch, false)

		return
	end

	self.normalViewShow = true

	gohelper.setActive(self.goDispatch, true)

	local finishCount = 0

	for i, v in ipairs(list) do
		if v:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			finishCount = finishCount + 1
		end
	end

	if storyMo:isScoreFull() then
		self.txtTips.text = luaLang("rolestoryscoreisfull")
	else
		local tag = {
			finishCount,
			#list
		}

		self.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestorynormaldispatchtips"), tag)
	end

	local canPlayUnlockAnim = storyMo:canPlayNormalDispatchUnlockAnim()

	if canPlayUnlockAnim then
		self:refreshDispatchList(list, nil, true)

		self.needTween = true

		self:playUnlockTween()
	else
		self:refreshDispatchList(list)
	end
end

function RoleStoryDispatchNormalView:refreshDispatchList(list, canPlayUnlockAnim, waitUnlock)
	for i = 1, math.max(#list, #self.itemList) do
		self:refreshDispatchItem(self.itemList[i], list[i], i, {
			canPlayUnlockAnim = canPlayUnlockAnim,
			waitUnlock = waitUnlock
		})
	end
end

function RoleStoryDispatchNormalView:refreshDispatchItem(item, data, index, canPlayUnlockAnim)
	item = item or self:createItem(index)

	item:onUpdateMO(data, self.storyId, index, canPlayUnlockAnim)
end

function RoleStoryDispatchNormalView:createItem(index)
	local parentGO = gohelper.findChild(self.goDispatch, string.format("Item/#go_item%s", index))
	local resPath = self.viewContainer:getSetting().otherRes.normalItemRes
	local go = self.viewContainer:getResInst(resPath, parentGO, "go")
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryDispatchNormalItem)

	item.scrollDesc.parentGameObject = self.goDispatchScroll
	self.itemList[index] = item

	return item
end

function RoleStoryDispatchNormalView:_onNormalDispatchRefresh()
	TaskDispatcher.cancelTask(self.playRefreshAudio, self)
	TaskDispatcher.runDelay(self.playRefreshAudio, self, 0.05)
end

function RoleStoryDispatchNormalView:playRefreshAudio()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

function RoleStoryDispatchNormalView:onClose()
	return
end

function RoleStoryDispatchNormalView:clearItems()
	for i, v in ipairs(self.itemList) do
		v:clear()
	end
end

function RoleStoryDispatchNormalView:onDestroyView()
	TaskDispatcher.cancelTask(self.playRefreshAudio, self)
	TaskDispatcher.cancelTask(self._delayShow, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	self:clearItems()
end

return RoleStoryDispatchNormalView
