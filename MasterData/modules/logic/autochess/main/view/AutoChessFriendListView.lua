-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendListView.lua

module("modules.logic.autochess.main.view.AutoChessFriendListView", package.seeall)

local AutoChessFriendListView = class("AutoChessFriendListView", BaseView)

function AutoChessFriendListView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._goFriendItem = gohelper.findChild(self.viewGO, "root/#scroll_list/viewport/content/go_FriendItem")
	self._goFriendItemRoot = gohelper.findChild(self.viewGO, "root/#scroll_list/viewport/content")
	self._goFriendList = gohelper.findChild(self.viewGO, "root/#scroll_list")
	self._goEmpty = gohelper.findChild(self.viewGO, "root/go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessFriendListView:addEvents()
	self._btnClose:AddClickListener(self.onClickClose, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.SelectFriendSnapshot, self.onClickClose, self)
end

function AutoChessFriendListView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function AutoChessFriendListView:onClickModalMask()
	self:closeThis()
end

function AutoChessFriendListView:onClickClose()
	self:closeThis()
end

function AutoChessFriendListView:_editableInitView()
	return
end

function AutoChessFriendListView:onOpen()
	local actId = Activity182Model.instance:getCurActId()
	local actInfo = Activity182Model.instance:getActMo(actId)
	local friendInfoList = actInfo:getFriendInfoList()

	self._friendDataList = {}

	for _, friendInfo in ipairs(friendInfoList) do
		local friendData = {}

		friendData.portrait = friendInfo.portrait
		friendData.name = friendInfo.name
		friendData.rank = friendInfo.rank
		friendData.userId = friendInfo.userId
		self._friendDataList[#self._friendDataList + 1] = friendData
	end

	if #self._friendDataList == 0 then
		gohelper.setActive(self._goEmpty, true)
		gohelper.setActive(self._goFriendList, false)
	else
		gohelper.setActive(self._goEmpty, false)
		gohelper.setActive(self._goFriendList, true)
	end

	self:createFriendItemList()
end

function AutoChessFriendListView:createFriendItemList()
	self._recordItemDict = {}

	gohelper.CreateObjList(self, self._createFriendItem, self._friendDataList, self._goFriendItemRoot, self._goFriendItem, AutoChessFriendItem)
end

function AutoChessFriendListView:_createFriendItem(itemComp, data, index)
	itemComp:onUpdateData(data)
end

function AutoChessFriendListView:onClose()
	return
end

function AutoChessFriendListView:onDestroyView()
	return
end

return AutoChessFriendListView
