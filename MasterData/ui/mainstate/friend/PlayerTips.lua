-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Friend\\PlayerTips.lua

local strClassName = "PlayerTips"
local PlayerTips = Class(strClassName, UIControls.Window)

function PlayerTips:ctor()
	self:initUI()
end

function PlayerTips:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.textName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.textServer = UIControls.Label(self, "BgPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.textArea = UIControls.Label(self, "BgPanel/TextPosition")
	self.textGuild = UIControls.Label(self, "BgPanel/TextGuild")

	self.textGuild:setVisible(false)

	self.textGuildJob = UIControls.Label(self, "BgPanel/TextGuild/TextGuildJob")
	self.btnChat = UIControls.Button(self, "BgPanel/BtnFucPanel/BtnChat")

	self.btnChat:addEventClick(self.onChatClick)

	self.btnAdd = UIControls.Button(self, "BgPanel/BtnFucPanel/BtnRequest")

	self.btnAdd:addEventClick(self.onAddClick)

	self.btnDel = UIControls.Button(self, "BgPanel/BtnFucPanel/BtnDel")

	self.btnDel:addEventClick(self.onDelClick)

	self.btnBlackList = UIControls.Button(self, "BgPanel/BtnFucPanel/BtnBlacklist", "Text")

	self.btnBlackList:setVisible(false)

	self.btnReport = UIControls.Button(self, "BgPanel/BtnFucPanel/BtnReport")

	self.btnReport:addEventClick(self.onReportClick)

	self.btnBackYard = UIControls.Button(self, "BgPanel/BtnFucPanel/BtnBackyard")

	self.btnBackYard:addEventClick(self.onBackYardClick)
end

function PlayerTips:onChatClick()
	if CurAvatar:inMyBlackList(self.otherPlayer.uid) then
		MsgManager.notice(Lang.get(30491))
	else
		UIManager.getUI("chatDlg", true):addFriendTalk(self.otherPlayer)
		self:setVisible(false)
	end
end

function PlayerTips:onAddClick()
	CurAvatar:addFriend(self.otherPlayer.uid)
end

local ADD_BLACK = 1
local DEL_BLACK = 2

function PlayerTips:onDelClick()
	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", Lang.get(30492), Functor(RPC.buddyDel, self.otherPlayer.uid))
end

function PlayerTips:onReportClick()
	return
end

function PlayerTips:onBackYardClick()
	return
end

function PlayerTips:setPlayer(otherPlayer, orderCell)
	self.otherPlayer = otherPlayer
	self.orderCell = orderCell

	self.textName:setText(otherPlayer.name)

	if otherPlayer.gender == Const.GENDER_MAN then
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.textServer:setText(otherPlayer.serverName or "")

	if otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	self.imgServer:setVisible(false)
	self.btnHead:setPlayer(otherPlayer)
	self.btnBackYard:setVisible(false)
	self.btnReport:setVisible(false)
	self.btnChat:setVisible(true)
	self.btnDel:setVisible(false)
	self.btnAdd:setVisible(true)

	local baseOrder = 0

	if orderCell.mWindow then
		baseOrder = orderCell.mWindow:getOrder()
	end

	self:setOrder(baseOrder + 5)
	self:setVisible(true)
end

function PlayerTips:refreshPlayer()
	self:setPlayer(self.otherPlayer, self.orderCell)
end

return PlayerTips
