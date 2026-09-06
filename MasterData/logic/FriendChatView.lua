-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendChatView.lua

module("logic.extensions.friend.view.FriendChatView", package.seeall)

local FriendChatView = class("FriendChatView", ChatTableView)
local ChatPrefabTag = {
	Sprite = 4,
	WordOther = 2,
	TimeStamp = 5,
	System = 3,
	WordMy = 1
}

function FriendChatView:ctor()
	FriendChatView.super.ctor(self)

	self._viewName = ViewName.Friend
end

function FriendChatView:bindEvents()
	self._addFriendBtn:AddClickListener(self._onClickAddFriend, self)
	self._pkIniteBtn:AddClickListener(self._onClickPkInite, self)
	self._fetterBtn:AddClickListener(self._onClickFetter, self)
	self._btnTop:AddClickListener(self._onClickbtnTop, self)
end

function FriendChatView:unbindEvents()
	self._addFriendBtn:RemoveClickListener()
	self._pkIniteBtn:RemoveClickListener()
	self._fetterBtn:RemoveClickListener()
	self._btnTop:RemoveClickListener()
end

function FriendChatView:buildUI()
	self._container = self:getGo("main/chatarea")

	local info = goutil.findChild(self._container, "friendInfo")

	self._ImgC_Icon = goutil.findChild(info, "imgHead")
	self._TxtC_Name = goutil.findChildTextComponent(info, "txtName")
	self._txtPower = goutil.findChildTextComponent(info, "Power/txtPower")
	self._txtLevel = goutil.findChildTextComponent(info, "Level/txtLevel")
	self._addFriendBtn = Framework.ButtonAdapter.GetFrom(info, "btnAdd")
	self._pkIniteBtn = Framework.ButtonAdapter.GetFrom(info, "btnBattle")
	self._fetterBtn = Framework.ButtonAdapter.GetFrom(info, "btnLike")
	self._txtFetter = goutil.findChildTextComponent(self._fetterBtn.gameObject, "txtAcount")
	self._Btn_Send = Framework.ButtonAdapter.GetFrom(self._container, "Nego_Bottom/Btn_Send")
	self._Input_Chat = self:getInput("main/chatarea/Nego_Bottom/Input_Chat")
	self._Btn_SpringToMax = Framework.ButtonAdapter.GetFrom(self._container, "Nego_Bottom/Btn_SpringToMax")
	self._TxtC_NotRead = goutil.findChildTextComponent(self._Btn_SpringToMax.btn.gameObject, "TxtC_NotRead")

	self._Input_Chat:SetCharacterLimit(50)

	self._Btn_Emoji = Framework.ButtonAdapter.GetFrom(self._container, "Nego_Bottom/Btn_Emoji")
	self._tableview = self:getGo("main/chatarea/SrlC_Chat"):GetComponent("UITableview")
	self._tableSrollRect = self._tableview.gameObject:GetComponent(ComponentType.ScrollRect)

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)

	self._tableCells = {}
	self._tableCells[ChatPrefabTag.WordMy] = self:getGo("main/chatarea/item_my")
	self._tableCells[ChatPrefabTag.WordOther] = self:getGo("main/chatarea/item_other")
	self._tableCells[ChatPrefabTag.System] = self:getGo("main/chatarea/item_system")
	self._tableCells[ChatPrefabTag.Sprite] = self:getGo("main/chatarea/item_sprite")
	self._tableCells[ChatPrefabTag.TimeStamp] = self:getGo("main/chatarea/item_time")

	for _, v in pairs(self._tableCells) do
		goutil.setActive(v, true)

		local x, y, z = Framework.TransformUtil.GetLocalPos(v.transform, 0, 0, 0)

		Framework.TransformUtil.SetLocalPos(v.transform, x + 10000, y, z)
	end

	self._emojiPoint = self:getGo("emojiPoint")
	self._btnTop = self:getBtn("main/chatarea/friendInfo/btnTop")
	self._txtBtnTop = self:getTxt("main/chatarea/friendInfo/btnTop/txt")
	self._chattopbgGo = self:getGo("main/chatarea/friendInfo/list/topbg")
end

function FriendChatView:onEnter()
	FriendChatView.super.onEnter(self)
	FriendController.instance:registerLocalNotify("SelectedIdChange", self._refresh, self)
	self:_refresh()
	GlobalDispatcher:addListener(GlobalNotify.FriendFetterChange, self._OnFetterChange, self)
	self.addGEvent(self, GlobalNotify.ChangeStrangerSwitch, self._refresh, self)
end

function FriendChatView:onExit()
	FriendChatView.super.onExit(self)
	FriendController.instance:unregisterLocalNotify("SelectedIdChange", self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendFetterChange, self._OnFetterChange, self)
end

function FriendChatView:_refresh()
	self._curId = FriendController.instance:getCurSelectedId()

	local isOn = checknumber(self._curId) > 0
	local strangerMsgSwitch = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT)
	local groupId = FriendController.instance:getGroupIdx()

	if groupId == GameEnum.FriendGroup.Stranger and not strangerMsgSwitch then
		isOn = false
	end

	goutil.setActive(self._container, isOn)

	if isOn then
		self:_updateFriendInfo()
		self:_updateChatArea()
	end
end

function FriendChatView:_updateChatArea()
	if self._mo then
		local group = self._mo._groupType

		if group == GameEnum.FriendGroup.Blacklist then
			NewChatModel.instance:ClearChannelMsg(GameEnum.ChatChannel.Private, self._curId)
		end

		goutil.setActive(self._addFriendBtn.gameObject, group == GameEnum.FriendGroup.Stranger)
		goutil.setActive(self._pkIniteBtn.gameObject, group == GameEnum.FriendGroup.Friend)
		goutil.setActive(self._fetterBtn.gameObject, group == GameEnum.FriendGroup.Friend)
		goutil.setActive(self._btnTop.gameObject, group == GameEnum.FriendGroup.Friend)
		self:initChatRoom(GameEnum.ChatChannel.Private, self._curId)
	end
end

function FriendChatView:_updateFriendInfo()
	self._mo = FriendModel.instance:getFriendMo(self._curId)

	if self._mo then
		self._TxtC_Name.text = self._mo._name

		if not string.nilorempty(self._mo.areaName) then
			self._TxtC_Name.text = self._mo._name .. " [" .. self._mo.areaName .. "]"
		end

		HeadItemController.instance:setHeadCell(self._ImgC_Icon, self._mo.headIconId, self._mo.headFrameId, self._mo.vipLv)

		self._txtPower.text = self._mo._zdl
		self._txtLevel.text = self._mo:getLevel()
		self._txtFetter.text = self._mo:getCurFetter()

		local isTopFriend = FriendController.instance:isTopFriendId(self._curId)

		self._txtBtnTop.text = isTopFriend and "取消置顶" or "置顶"

		goutil.setActive(self._chattopbgGo, isTopFriend)
	end
end

function FriendChatView:checkChannelLimit()
	if self._mo and self._mo:getValue("groupType") == GameEnum.FriendGroup.Blacklist then
		FloatWordMgr.instance:show("您无法跟黑名单成员交谈！")

		return false
	end

	return true
end

function FriendChatView:_onClickAddFriend()
	FriendController.instance:addFriend(self._mo._id)
end

function FriendChatView:_onClickPkInite()
	TraincampqiecuoController.instance:sendInvitation(self._mo.headInfo)
end

function FriendChatView:_onClickFetter()
	FriendController.instance:getBuddyFetterInfo(self._mo._id)
end

function FriendChatView:_onClickbtnTop()
	if not FriendController.instance:isTopFriendId(self._curId) then
		FriendController.instance:addTopFriendId(self._curId)
	else
		FriendController.instance:removeTopFriendId(self._curId)
	end

	self:_updateFriendInfo()
end

function FriendChatView:_OnFetterChange()
	if self._mo then
		self._txtFetter.text = self._mo:getCurFetter()
	end
end

function FriendChatView:_createItemChatNormal(data, go, tag)
	local item = self._itemChatMap[go.gameObject]

	if not item then
		item = FriendItemChatNormal.New(go.gameObject, tag)
		self._itemChatMap[go.gameObject] = item
	else
		item:buildUIWithTag(tag)
	end

	item:setEffectClip(self, self._tableSrollRect)
	item:Refresh(data, self._viewName, self._nowTime)

	return item
end

return FriendChatView
