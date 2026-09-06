-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendBlackListView.lua

module("logic.extensions.friend.view.FriendBlackListView", package.seeall)

local FriendBlackListView = class("FriendBlackListView", TableViewComponent)

function FriendBlackListView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "SrlC_Search"
	}
end

function FriendBlackListView:ctor()
	FriendBlackListView.super.ctor(self)
end

function FriendBlackListView:destroyUI()
	FriendBlackListView.super.destroyUI(self)
end

function FriendBlackListView:onExitFinished()
	FriendBlackListView.super.onExitFinished(self)
end

function FriendBlackListView:onEnterFinished()
	FriendBlackListView.super.onEnterFinished(self)
end

function FriendBlackListView:unbindEvents()
	FriendBlackListView.super.unbindEvents(self)
end

function FriendBlackListView:bindEvents()
	FriendBlackListView.super.bindEvents(self)
end

function FriendBlackListView:onExit()
	FriendBlackListView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BlackListRemove, self._updateUI, self)
end

function FriendBlackListView:buildUI()
	FriendBlackListView.super.buildUI(self)

	self._emptyTips = self:getGo("EmptyTips")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtManCount")
end

function FriendBlackListView:onEnter()
	FriendBlackListView.super.onEnter(self)
	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.BlackListRemove, self._updateUI, self)
end

function FriendBlackListView:_updateUI()
	local group = GameEnum.FriendGroup.Blacklist

	self._curViewDatas = FriendModel.instance:getGroupDatas(group)
	self._nowTime = ServerTime.nowServerLook()

	self:reloadData()
	goutil.setActive(self._emptyTips, #self._curViewDatas == 0)

	self._txtCount.text = "黑名单数   " .. #self._curViewDatas .. "/" .. FriendConfig.instance:GetMaxCount(group)
end

function FriendBlackListView:_updateCell(view, cell, data)
	local container = cell.gameObject
	local imgIconChange = goutil.findChild(container, "ImgC_Icon")
	local txtName = goutil.findChildTextComponent(container, "TxtC_Name")
	local txtPower = goutil.findChildTextComponent(container, "ImgZdl/TxtZdl")
	local btnRemove = Framework.ButtonAdapter.GetFrom(container, "btnRemove")
	local txtLevel = goutil.findChildTextComponent(container, "txtLevel")

	btnRemove:AddClickListener(function()
		self:_onClickRemove(data)
	end)

	txtName.text = data._name

	if not string.nilorempty(data.areaName) then
		txtName.text = data._name .. " [" .. data.areaName .. "]"
	end

	HeadItemController.instance:setHeadCell(imgIconChange, data.headIconId, data.headFrameId, data.vipLv)

	txtPower.text = data._zdl
	txtLevel.text = ""
end

function FriendBlackListView:_onClickRemove(data)
	FriendController.instance:RemoveBlacklist(data._id)
end

return FriendBlackListView
