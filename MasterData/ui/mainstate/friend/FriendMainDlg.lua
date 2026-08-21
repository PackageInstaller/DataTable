-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Friend\\FriendMainDlg.lua

local ResColor = require("ClientData/ResColor")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local UIControls = UIControls
local FriendHeadCell = Class("FriendHeadCell", UIControls.ScrollViewLoopCell)

function FriendHeadCell:ctor()
	self:initUI()
end

function FriendHeadCell:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.bgPlayer = UIControls.Image(self, "BgPlayer")
	self.textName = UIControls.Label(self, "TextPlayerName")
	self.iconSex = UIControls.Image(self, "TextPlayerName/IconSex")
	self.textTime = UIControls.Label(self, "TextPlayerName/TextTime")
	self.panelVip = UIControls.PanelPlayerVip(self, "TextPlayerName/VIPPanel")

	self.textTime:setVisible(true)

	self.textServer = UIControls.Label(self, "TextServer")
	self.imgServer = UIControls.Image(self, "TextServer/IconServer")
	self.btnChat = UIControls.Button(self, "FunPanel/BtnChat")

	self.btnChat:addEventClick(self.onChatClick)

	if ChannelUtil.isDMMGame() then
		self.btnChat:setVisible(false)
	end

	self.btnGiftGet = UIControls.Button(self, "FunPanel/BtnGiftCollect")

	self.btnGiftGet:addEventClick(self.onGiftGetClick)

	self.imgGiftGet = UIControls.Image(self, "FunPanel/BtnGiftCollect/Icon")
	self.btnGiftSend = UIControls.Button(self, "FunPanel/BtnGiftSend")

	self.btnGiftSend:addEventClick(self.onGiftSendClick)

	self.imgGiftSend = UIControls.Image(self, "FunPanel/BtnGiftSend/Icon")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	if CurAvatar.rentTaskFlag then
		self.addConfidantBtn = UIControls.Button(self, "BtnConfidant")

		self.addConfidantBtn:addEventClick(self._onClickConfidant)
		self.addConfidantBtn:setVisible(true)

		self.notConfidantPanel = UIControls.Panel(self, "BtnConfidant/ImgConfidant")
		self.isConfidantPanel = UIControls.Panel(self, "BtnConfidant/ImgConfidantDis")
	end
end

function FriendHeadCell:onSensorClick()
	CurAvatar:showPlayerTips(self.otherPlayer.uid, self)
end

function FriendHeadCell:onChatClick()
	UIManager.getUI("chatDlg", true):addFriendTalk(self.otherPlayer)
end

function FriendHeadCell:onGiftGetClick()
	if CurAvatar:getFriendGetCount() <= 0 then
		MsgManager.notice(Lang.get(30480))

		return
	end

	local getIds = {}
	local sendIds = {}

	table.insert(getIds, self.otherPlayer.uid)
	RPC.buddyGiftOp(getIds, sendIds)
	MsgManager.notice(Lang.get(30481))
end

function FriendHeadCell:onGiftSendClick()
	if CurAvatar:getFriendSendCount() <= 0 then
		MsgManager.notice(Lang.get(30482))

		return
	end

	local getIds = {}
	local sendIds = {}

	table.insert(sendIds, self.otherPlayer.uid)
	RPC.buddyGiftOp(getIds, sendIds)
	MsgManager.notice(Lang.get(30483))
end

function FriendHeadCell:_onClickConfidant()
	if CurAvatar.rentTaskFlag then
		if self.otherPlayer.isMyConfidant then
			RentTaskUtils.delConfidant(self.otherPlayer.uid)
		else
			RentTaskUtils.addConfidant(self.otherPlayer.uid)
		end
	end
end

function FriendHeadCell:setData(otherPlayer)
	self.otherPlayer = otherPlayer

	self.textName:setText(otherPlayer.name)
	self.panelVip:setData(otherPlayer.vip, otherPlayer.vip_hide)

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

	self.btnHead:setPlayer(otherPlayer, true, self)

	if self.otherPlayer.online then
		self.btnHead:setObjGray(false)
		self.textTime:setText(Lang.get(841))

		if otherPlayer.gender == Const.GENDER_MAN then
			self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerMale")
		else
			self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerFemale")
		end
	else
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerDis")
		self.btnHead:setObjGray(true)
		self.textTime:setText(ClientUtils.strServerTimePassed(self.otherPlayer.logout_tick))
	end

	if CurAvatar.rentTaskFlag then
		self:_refreshConfidantState(self.otherPlayer.isMyConfidant)
	end

	if otherPlayer.giftSend then
		self.btnGiftSend:setEnable(false)
		self.imgGiftSend:setImage("Atlas/FriendAtlas/FriendAtlas", "IconGiftSendDone")
	else
		self.btnGiftSend:setEnable(true)
		self.imgGiftSend:setImage("Atlas/FriendAtlas/FriendAtlas", "IconGiftSend")
	end

	if otherPlayer.giftGet then
		if otherPlayer.giftReceive then
			self.btnGiftGet:setEnable(false)
			self.imgGiftGet:setImage("Atlas/FriendAtlas/FriendAtlas", "IconGiftCollectDone")
		else
			self.btnGiftGet:setEnable(true)
			self.imgGiftGet:setImage("Atlas/FriendAtlas/FriendAtlas", "IconGiftCollect")
		end
	else
		self.btnGiftGet:setEnable(false)
		self.imgGiftGet:setImage("Atlas/FriendAtlas/FriendAtlas", "IconGiftCollectDis")
	end
end

function FriendHeadCell:_refreshConfidantState(isConfidant)
	if CurAvatar.rentTaskFlag then
		self.notConfidantPanel:setVisible(not isConfidant)
		self.isConfidantPanel:setVisible(isConfidant)
	end
end

local strClassName = "FriendMainDlg"
local FriendMainDlg = Class(strClassName, UIControls.Window)

function FriendMainDlg:ctor()
	self:initUI()
end

function FriendMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onCloseClick)

	self.textNumGift = UIControls.Label(self, "TextNumGift")
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onTipsClick)

	self.panelEmpty = UIControls.Panel(self, "TextEmpty")
	self.btnFriendAdd = UIControls.Button(self, "BtnFriendAdd")

	self.btnFriendAdd:addEventClick(self.onFriendAddClick)

	self.btnBlackList = UIControls.Button(self, "BtnBlackList")

	self.btnBlackList:setVisible(false)

	self.btnRequest = UIControls.Button(self, "BtnRequest", "TextNum")
	self.dotRequest = UIControls.RedDot(self, "BtnRequest/IconNew")

	self.dotRequest:addHint({
		UIConst.RD_HINT_FRIEND_REQUEST
	})
	self.btnRequest:addEventClick(self.onRequestClick)

	self.btnQuickGift = UIControls.Button(self, "BtnQuickGift")

	self.btnQuickGift:addEventClick(self.onQuickGiftClick)

	self.dotQuickGift = UIControls.RedDot(self, "BtnQuickGift/IconNew")

	self.dotQuickGift:addHint({
		UIConst.RD_HINT_FRIEND_GIFT
	})

	self.cells = {}
	self.scrollItems = UIControls.ScrollViewLoopV(self, "FriendList", 0, self.onCellChanged)

	if CurAvatar.rentTaskFlag then
		self.confidantPanel = UIControls.Panel(self, "ConfidantPanel")
		self.confidantNumTxt = UIControls.Label(self, "ConfidantPanel/TextNum")
		self.confidantTipsBtn = UIControls.Button(self, "ConfidantPanel/BtnTips")

		self.confidantTipsBtn:addEventClick(self._onClickConfidantTips)
	end
end

function FriendMainDlg:onOpen()
	FriendMainDlg.super.onOpen(self)
	self:_refreshPlayer(true)
end

local function FriendSortFunc(friendA, friendB)
	if friendA.online and friendB.online then
		return friendA.level > friendB.level
	elseif friendA.online then
		return true
	elseif friendB.online then
		return false
	else
		return friendA.logout_tick > friendB.logout_tick
	end
end

function FriendMainDlg:refreshPlayer()
	self:_refreshPlayer()
end

function FriendMainDlg:resetPlayer()
	self:_refreshPlayer(true)
end

function FriendMainDlg:_refreshPlayer(isInit)
	self.curPlayers = CurAvatar:getSortedFriends()

	self.btnClose:setText(utils.format(Lang.get(30477), #self.curPlayers, Const.MAX_FRIEND_NUM))
	self:refreshInviteState()
	self:refreshGiftNum()
	self:refreshConfidantNum()

	if #self.curPlayers == 0 then
		self.panelEmpty:setVisible(true)
		self.scrollItems:setVisible(false)

		return
	end

	self.panelEmpty:setVisible(false)
	self.scrollItems:setVisible(true)

	if isInit then
		self.scrollItems:setTotalCount(#self.curPlayers)
	else
		for index, cell in pairs(self.cells) do
			if self.curPlayers[index] then
				cell:setData(self.curPlayers[index])
			end
		end
	end
end

function FriendMainDlg:refreshGiftNum()
	self.textNumGift:setText(utils.format(Lang.get(30478), CurAvatar.friendSend, Const.MAX_FRIEND_GIFT_SEND_NUM))
end

function FriendMainDlg:refreshConfidantNum()
	if CurAvatar.rentTaskFlag then
		self.confidantPanel:setVisible(true)
		self.confidantNumTxt:setText(CurAvatar:getConfidantCount() .. "/" .. RentTaskUtils.getConfidantMaxNum())
	end
end

function FriendMainDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = FriendHeadCell(sender, "System/Friend/BtnFriendCellL", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local info = self.curPlayers[newIdx]

	targetCell:setData(info)
end

function FriendMainDlg:onCloseClick()
	self:setVisible(false)
end

function FriendMainDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_FRIEND)
end

function FriendMainDlg:onFriendAddClick()
	UIManager.getUI("friendAddDlg", true)
end

function FriendMainDlg:_onClickConfidantTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CONFIDANT)
end

function FriendMainDlg:refreshInviteState()
	local count = CurAvatar:getFriendInviteCount()

	if count == 0 then
		self.btnRequest:setText("")
	else
		self.btnRequest:setText("(" .. count .. ")")
	end
end

function FriendMainDlg:onRequestClick()
	if next(CurAvatar.inviteList) ~= nil then
		UIManager.getUI("friendRequestListDlg", true)
	else
		MsgManager.notice(Lang.get(30484))
	end
end

function FriendMainDlg:onQuickGiftClick()
	local getCount = CurAvatar:getFriendGetCount()
	local sendCount = CurAvatar:getFriendSendCount()

	if sendCount <= 0 and getCount <= 0 then
		MsgManager.notice(Lang.get(30485))

		return
	end

	local getIds = {}
	local sendIds = {}

	for index, player in ipairs(self.curPlayers) do
		if sendCount > 0 and not player.giftSend then
			sendCount = sendCount - 1

			table.insert(sendIds, player.uid)
		end

		if getCount > 0 and player.giftGet and not player.giftReceive then
			getCount = getCount - 1

			table.insert(getIds, player.uid)
		end
	end

	if #getIds == 0 and #sendIds == 0 then
		MsgManager.notice(Lang.get(30486))
	else
		if #getIds > 0 then
			MsgManager.notice(string.format(Lang.get(30479), #getIds * 6))
		else
			MsgManager.notice(Lang.get(30487))
		end

		RPC.buddyGiftOp(getIds, sendIds)
	end
end

return FriendMainDlg
