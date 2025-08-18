-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Friend\\FriendRequestListDlg.lua

local OtherPlayer = require("Common/Object/OtherPlayer")
local UIControls = UIControls
local FriendRequestListHeadCell = Class("FriendRequestListHeadCell", UIControls.ScrollViewLoopCell)

function FriendRequestListHeadCell:ctor()
	self:initUI()
end

function FriendRequestListHeadCell:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.textName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.panelVip = UIControls.PanelPlayerVip(self, "BgPanel/TextPlayerName/VIPPanel")
	self.textServer = UIControls.Label(self, "BgPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.bgPlayer = UIControls.Image(self, "BgPanel/BgPlayer")
	self.btnRefuse = UIControls.Button(self, "BgPanel/BtnRefuse")

	self.btnRefuse:addEventClick(self.onRefuseClick)

	self.btnAgree = UIControls.Button(self, "BgPanel/BtnAgree")

	self.btnAgree:addEventClick(self.onAgreeClick)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)
end

function FriendRequestListHeadCell:onSensorClick()
	CurAvatar:showPlayerTips(self.otherPlayer.uid, self)
end

function FriendRequestListHeadCell:onRefuseClick()
	RPC.buddyInviteOp(self.otherPlayer.uid, "kBuddyInviteRefuse")
end

function FriendRequestListHeadCell:onAgreeClick()
	if CurAvatar:getFriendCount() >= Const.MAX_FRIEND_NUM then
		MsgManager.notice(Lang.get(30490))

		return
	end

	RPC.buddyInviteOp(self.otherPlayer.uid, "kBuddyInviteAccept")
end

function FriendRequestListHeadCell:setData(otherPlayer)
	self.otherPlayer = otherPlayer

	self.textName:setText(otherPlayer.name)
	self.panelVip:setData(otherPlayer.vip, otherPlayer.vip_hide)

	if otherPlayer.gender == Const.GENDER_MAN then
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerMale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerFemale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.textServer:setText(otherPlayer.serverName or "")

	if otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	self.btnHead:setPlayer(otherPlayer, true, self)
end

local strClassName = "FriendRequestListDlg"
local FriendRequestListDlg = Class(strClassName, UIControls.Window)

function FriendRequestListDlg:ctor()
	self:initUI()
end

function FriendRequestListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.cells = {}
	self.scrollFriendList = UIControls.ScrollViewLoopV(self, "BgPanel/PlayerList")

	self.scrollFriendList:addEventCellChanged(self.onFriendListChanged)

	self.textFriendNum = UIControls.Label(self, "BgPanel/TextNum1")
	self.textRequestNum = UIControls.Label(self, "BgPanel/TextNum2")
	self.btnAllRefuse = UIControls.Button(self, "BgPanel/BtnAllRefuse")

	self.btnAllRefuse:addEventClick(self.onAllRefuseClick)

	self.btnAllAgree = UIControls.Button(self, "BgPanel/BtnAllAgree")

	self.btnAllAgree:addEventClick(self.onAllAgreeClick)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/TextEmpty")
end

function FriendRequestListDlg:onOpen()
	FriendRequestListDlg.super.onOpen(self)
	self:refreshData()
end

local function FriendSortFunc(friendA, friendB)
	return
end

function FriendRequestListDlg:refreshData()
	self.curPlayers = {}

	for _, player in pairs(CurAvatar.inviteList) do
		table.insert(self.curPlayers, player)
	end

	self.textFriendNum:setText(utils.format(Lang.get(30488), CurAvatar:getFriendCount(), Const.MAX_FRIEND_NUM))
	self.textRequestNum:setText(utils.format(Lang.get(30489), #self.curPlayers, Const.MAX_FRIEND_REQUEST_NUM))

	if #self.curPlayers == 0 then
		self.panelEmpty:setVisible(true)
		self.scrollFriendList:setVisible(false)

		return
	end

	self.panelEmpty:setVisible(false)
	self.scrollFriendList:setVisible(true)
	self.scrollFriendList:setTotalCount(#self.curPlayers)
end

function FriendRequestListDlg:onFriendListChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = FriendRequestListHeadCell(sender, "System/Friend/BtnFriendCellRequest", newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.curPlayers[newIdx])

	self.cells[newIdx] = targetCell
end

function FriendRequestListDlg:onCloseClick()
	self:setVisible(false)
end

function FriendRequestListDlg:onAllRefuseClick()
	if #self.curPlayers > 0 then
		RPC.buddyInviteOp("", "kBuddyInviteRefuseAll")
	end
end

function FriendRequestListDlg:onAllAgreeClick()
	if CurAvatar:getFriendCount() >= Const.MAX_FRIEND_NUM then
		MsgManager.notice(Lang.get(30490))

		return
	end

	if #self.curPlayers > 0 then
		RPC.buddyInviteOp("", "kBuddyInviteAcceptAll")
	end
end

return FriendRequestListDlg
