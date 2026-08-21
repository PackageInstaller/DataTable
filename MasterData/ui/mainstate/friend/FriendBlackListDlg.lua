-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Friend\\FriendBlackListDlg.lua

local OtherPlayer = require("Common/Object/OtherPlayer")
local UIControls = UIControls
local FriendBlackListHeadCell = Class("FriendBlackListHeadCell", UIControls.ScrollViewLoopCell)

function FriendBlackListHeadCell:ctor()
	self:initUI()
end

function FriendBlackListHeadCell:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.textName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.panelVip = UIControls.PanelPlayerVip(self, "BgPanel/TextPlayerName/VIPPanel")
	self.textServer = UIControls.Label(self, "BgPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.bgPlayer = UIControls.Image(self, "BgPanel/BgPlayer")
	self.btnRequest = UIControls.Button(self, "BgPanel/BtnRequest")

	self.btnRequest:setVisible(false)

	self.imgDone = UIControls.Image(self, "BgPanel/IconRequestDone")
	self.btnDel = UIControls.Button(self, "BgPanel/BtnDel")

	self.btnDel:setVisible(true)
	self.btnDel:addEventClick(self.onDelClick)
end

function FriendBlackListHeadCell:onDelClick()
	RPC.buddyBlackListDel(self.otherPlayer.uid)
end

function FriendBlackListHeadCell:setData(otherPlayer)
	self.otherPlayer = otherPlayer

	self.textName:setText(otherPlayer.name)
	self.panelVip:setData(otherPlayer.vip, otherPlayer.vip_hide)
	self.textServer:setText(otherPlayer.serverName or "")

	if otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	if otherPlayer.gender == Const.GENDER_MAN then
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerMale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerFemale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.btnHead:setPlayer(otherPlayer, true, self)
end

local strClassName = "FriendBlackListDlg"
local FriendBlackListDlg = Class(strClassName, UIControls.Window)

function FriendBlackListDlg:ctor()
	self:initUI()
end

function FriendBlackListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/TextEmpty")
	self.textNum = UIControls.Label(self, "BgPanel/TextNum")
	self.cells = {}
	self.scrollFriendList = UIControls.ScrollViewLoopV(self, "BgPanel/PlayerList")

	self.scrollFriendList:addEventCellChanged(self.onFriendListChanged)
end

function FriendBlackListDlg:onOpen()
	FriendBlackListDlg.super.onOpen(self)
	self:refreshData()
end

local function FriendSortFunc(friendA, friendB)
	return
end

function FriendBlackListDlg:refreshData()
	self.curPlayers = {}

	for _, player in pairs(CurAvatar.blackList) do
		table.insert(self.curPlayers, player)
	end

	self.textNum:setText(utils.format(Lang.get(30476), #self.curPlayers, Const.MAX_BUDDY_BLACKLISTNUM))

	if #self.curPlayers == 0 then
		self.panelEmpty:setVisible(true)
		self.scrollFriendList:setVisible(false)

		return
	end

	self.panelEmpty:setVisible(false)
	self.scrollFriendList:setVisible(true)
	self.scrollFriendList:setTotalCount(#self.curPlayers)
end

function FriendBlackListDlg:onFriendListChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = FriendBlackListHeadCell(sender, "System/Friend/BtnFriendCellS", newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.curPlayers[newIdx])

	self.cells[newIdx] = targetCell
end

function FriendBlackListDlg:onCloseClick()
	self:setVisible(false)
end

return FriendBlackListDlg
