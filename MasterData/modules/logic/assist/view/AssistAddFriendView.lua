-- chunkname: @modules/logic/assist/view/AssistAddFriendView.lua

module("modules.logic.assist.view.AssistAddFriendView", package.seeall)

local AssistAddFriendView = class("AssistAddFriendView", BaseView)

function AssistAddFriendView:onInitView()
	self._goAddItem = gohelper.findChild(self.viewGO, "FriendList/#go_AddItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssistAddFriendView:addEvents()
	self.addEventCb(self, AssistController.instance, AssistEvent.CloseAddFriendView, self.closeThis, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
end

function AssistAddFriendView:_editableInitView()
	return
end

function AssistAddFriendView:onOpen()
	self.likeMarks = {}
	self.addMarks = {}
	self.itemList = {}
	self.records = self.viewParam

	for k, record in ipairs(self.records) do
		local item = self:getUserDataTb_()
		local go = gohelper.cloneInPlace(self._goAddItem, "item" .. tostring(record.userId))

		item.go = go
		item.anim = gohelper.findComponentAnim(go)

		local goPlayerIcon = gohelper.findChild(go, "up/go_PlayerIcon")
		local playerIcon = IconMgr.instance:getCommonPlayerIcon(goPlayerIcon)

		playerIcon:setMOValue(record.userId, "", 0, record.portrait)
		playerIcon:setShowLevel(false)
		playerIcon:setEnableClick(false)

		local txtName = gohelper.findChildText(go, "up/txt_Name")

		txtName.text = record.username

		local btnLike = gohelper.findChildButtonWithAudio(go, "down/btn_Like")

		self.addClickCb(self, btnLike, self._btnLikeOnClick, self, k)

		item.txtCount = gohelper.findChildText(go, "down/btn_Like/txt_Count")
		item.txtCount.text = record.count
		item.goOn = gohelper.findChild(go, "down/btn_Like/txt_Count/go_LikeOn")

		local btnAdd = gohelper.findChildButtonWithAudio(go, "down/btn_Add")

		self.addClickCb(self, btnAdd, self._btnAddFrienOnClick, self, k)

		item.canvasGroupAdd = gohelper.onceAddComponent(btnAdd.gameObject, gohelper.Type_CanvasGroup)

		local isMyFriend = SocialModel.instance:isMyFriendByUserId(record.userId)

		gohelper.setActive(btnAdd, not isMyFriend)

		self.addMarks[k] = isMyFriend
		self.itemList[k] = item
	end

	gohelper.setActive(self._goAddItem, false)
end

function AssistAddFriendView:onDestroyView()
	if not self._delayCallbacks then
		return
	end

	for _, callback in ipairs(self._delayCallbacks) do
		TaskDispatcher.cancelTask(callback, self)
	end

	self._delayCallbacks = nil
end

function AssistAddFriendView:_btnLikeOnClick(index)
	if self.likeMarks[index] then
		return
	end

	self.likeMarks[index] = true

	gohelper.setActive(self.itemList[index].goOn, true)

	local item = self.itemList[index]

	item.txtCount.text = self.records[index].count + 1

	item.anim:Play("like", 0, 0)

	local function callback(self)
		self:checkHide(index)
	end

	self._delayCallbacks = self._delayCallbacks or {}

	table.insert(self._delayCallbacks, callback)
	TaskDispatcher.runDelay(callback, self, 0.5)
end

function AssistAddFriendView:_btnAddFrienOnClick(index)
	if self.addMarks[index] then
		return
	end

	self.addMarks[index] = true

	local userId = self.records[index].userId

	FriendRpc.instance:sendApplyRequest(userId)

	self.itemList[index].canvasGroupAdd.alpha = 0.5

	self:checkHide(index)
end

function AssistAddFriendView:onOpenView(viewName)
	if viewName == self.viewName then
		return
	end

	self:closeThis()
end

function AssistAddFriendView:checkHide(index)
	if self.likeMarks[index] and self.addMarks[index] then
		gohelper.setActive(self.itemList[index].go, false)
	end
end

return AssistAddFriendView
