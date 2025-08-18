-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatPersonalPanel.lua

local ChatCell = require("UI/Chat/ChatCell")
local FriendCell = Class("FriendCell", UIControls.ScrollViewLoopCell)
local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"
local NAME_WIDTH = 130

function FriendCell:ctor()
	self:initUI()
end

local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"

function FriendCell:initUI()
	self.body = UIControls.Button(self, "")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:hideLevel()
	self.btnHead:setEnable(false)

	self.txtName = UIControls.Label(self, "TextPlayerName")
	self.imgSex = UIControls.Image(self, "TextPlayerName/IconSex")
	self.imgServer = UIControls.Image(self, "IconServer")
	self.imgNew = UIControls.Image(self, "IconNew")

	self.body:addEventClick(self.onClick)

	self.panelVip = UIControls.PanelPlayerVip(self, "TextPlayerName/VIPPanel")
end

function FriendCell:setData(data)
	self.data = data

	self.txtName:setText(data.base.name)
	self.txtName:limitTextLength(NAME_WIDTH)
	self.btnHead:setCommInfo(data.base, true, self)
	self.panelVip:setData(data.base.vip, data.base.vip_hide)

	if data.base.gender == Const.GENDER_MAN then
		self.imgSex:setImage(ICON_PATH, "IconMale")
	elseif data.base.gender == Const.GENDER_WOMAN then
		self.imgSex:setImage(ICON_PATH, "IconFemale")
	end

	if self.data.newMsgsCount > 0 then
		self.imgNew:setVisible(true)
	else
		self.imgNew:setVisible(false)
	end

	if data.base.sameServer then
		self.imgServer:setImage(ICON_PATH, "IconServerSame")
	else
		self.imgServer:setImage(ICON_PATH, "IconServerElse")
	end

	self.imgServer:setVisible(false)
	self.body:setEnable(self.data.selected == false)
end

function FriendCell:onClick(...)
	if self.data.selected then
		return
	end

	self.mParent:chooseFriend(self.data)
end

local strClassName = "ChatPersonalPanel"
local MAX_FRIEND_COUNT = Const.MAX_PRIVATE_FRIEND
local ChatPersonalPanel = Class(strClassName, UIControls.Panel)

function ChatPersonalPanel:ctor(...)
	self:initUI()
end

function ChatPersonalPanel:initUI()
	self.btnChooseFriend = UIControls.Button(self, self.mPath .. "/BtnChooseFriend")

	self.btnChooseFriend:addEventClick(self.onBtnChooseFriendClick)

	self.friendsPanel = UIControls.ScrollViewLoopV(self, self.mPath .. "/PersonalChatList", 0, self.onFriendCellChanged)
	self.txtChoosingFriend = UIControls.Label(self, self.mPath .. "/TextName")
	self.messagePanel = UIControls.ScrollViewLoopV(self, self.mPath .. "/PersonalMessagePanel", 0, self.onMessageCellChanged)

	self.messagePanel:addEventValueChanged(self.onViewValueChanged)

	self.txtName = UIControls.Label(self, self.mPath .. "/TextName")
	self.panelNothing = UIControls.Panel(self, self.mPath .. "/ImgNothing")
	self.friendInfos = {}
	self.choosingMsgs = {}
	self.msgMap = {}
	self._isLock = false
	self.curFriend = nil
	self.cells = {}
	self.mCurReceives = {
		Const.CHANNEL_PRIVATE
	}
	self.checkInitedMap = {}
end

function ChatPersonalPanel:show(sortRecord, notFriend)
	if not self:getVisible() then
		return
	end

	self._isLock = false
	self.friendInfos = {}

	if CurAvatar.friendList then
		for uid, info in pairs(CurAvatar.friendList) do
			if not CurAvatar:isMyMaster(uid) and not CurAvatar:isMyApprentice(uid) and info then
				local t = self:newFirendInfo(info)

				table.insert(self.friendInfos, t)

				self.msgMap[uid] = self.msgMap[uid] or self:newMsgMapInfo(t)
				self.msgMap[uid].friendInfo = t
				t.newMsgsCount = #self.msgMap[uid].newMsgs
			end
		end
	end

	for uid, info in pairs(notFriend) do
		if info then
			local t = self:newFirendInfo(info)

			table.insert(self.friendInfos, t)

			self.msgMap[uid] = self.msgMap[uid] or self:newMsgMapInfo(t)
			self.msgMap[uid].friendInfo = t
			t.newMsgsCount = #self.msgMap[uid].newMsgs
		end
	end

	if self.outFriendInfo then
		local uid = self.outFriendInfo.uid

		sortRecord[uid] = os.time() + 10000000

		if self.msgMap[uid] then
			-- block empty
		else
			local t = self:newFirendInfo(self.outFriendInfo)

			table.insert(self.friendInfos, t)

			self.msgMap[uid] = self:newMsgMapInfo(t)
			t.newMsgsCount = 0
		end
	end

	table.sort(self.friendInfos, function(v1, v2)
		local uid1, uid2 = v1.base.uid, v2.base.uid

		if sortRecord[uid1] then
			return sortRecord[uid1] > (sortRecord[uid2] or 0)
		elseif sortRecord[uid2] then
			return sortRecord[uid2] < (sortRecord[uid1] or 0)
		else
			return v1.base.time > v2.base.time
		end
	end)
	self.friendsPanel:setTotalCount(self:getCount(self.friendInfos, true))
	self:chooseFriend()
end

function ChatPersonalPanel:newFirendInfo(info)
	return {
		selected = false,
		newMsgsCount = 0,
		base = info
	}
end

function ChatPersonalPanel:newMsgMapInfo(friendInfo)
	return {
		newMsgs = {},
		msgs = {},
		friendInfo = friendInfo
	}
end

function ChatPersonalPanel:refreshRedHint()
	local isNewMsg = false

	for i, friendInfo in ipairs(self.friendInfos) do
		if i <= MAX_FRIEND_COUNT and friendInfo.newMsgsCount > 0 then
			isNewMsg = true

			break
		end
	end

	self:setRedHintState(isNewMsg)
end

function ChatPersonalPanel:getCount(t, isFriendList)
	if isFriendList then
		self:refreshRedHint()

		return math.min(#t, MAX_FRIEND_COUNT)
	end

	return #t
end

function ChatPersonalPanel:getPlayerInfo(uid)
	if self.msgMap[uid] then
		return self.msgMap[uid].friendInfo.base
	end
end

function ChatPersonalPanel:chooseFriend(data)
	for i, info in ipairs(self.friendInfos) do
		if not data then
			if i == 1 then
				self.curFriend = info.base
				info.selected = true
			else
				info.selected = false
			end
		elseif data ~= info then
			info.selected = false
		else
			self.curFriend = info.base
			info.selected = true
		end
	end

	self.friendsPanel:setTotalCount(self:getCount(self.friendInfos, true))

	if self.curFriend then
		self:initChoosingMsg(self.curFriend)
		self.txtName:setText(self.curFriend.name)
		self.mParent:inputEnable()
		self:setVisible(true)
	end

	self:recordCheckTime()
end

function ChatPersonalPanel:setVisible(v)
	local state = self:getVisible()

	ChatPersonalPanel.super.setVisible(self, v)

	if v == state or v then
		return
	end

	self:recordCheckTime()

	self.linkHere = false
end

function ChatPersonalPanel:recordCheckTime(...)
	if self.curFriend then
		local recordTime = 0

		if self.msgMap[self.curFriend.uid] then
			local msgs = self.msgMap[self.curFriend.uid].msgs

			if #msgs > 0 then
				recordTime = math.max(recordTime, msgs[#msgs].time)
			end
		end

		ClientUtils.record.checkRecord[self.curFriend.uid] = {
			time = recordTime
		}
	end
end

function ChatPersonalPanel:destroy()
	if self.cells then
		for i, chatCell in pairs(self.cells) do
			chatCell:destroy()
		end
	end

	self.cells = {}

	self:setVisible(false)
end

function ChatPersonalPanel:initMsgMap(msgDatas)
	local uid = 0

	self.msgMap = {}

	local sortRecord = {}
	local notFriend = {}

	for _, data in ipairs(msgDatas) do
		if data.suid == CurAvatar.uid then
			uid = data.ruid
		else
			uid = data.suid
		end

		if CurAvatar:isMyMaster(uid) or CurAvatar:isMyApprentice(uid) then
			-- block empty
		else
			self.msgMap[uid] = self.msgMap[uid] or self:newMsgMapInfo(self:newFirendInfo(MsgManager.getPlayerInfo(uid)))
			ClientUtils.record.checkRecord[uid] = ClientUtils.record.checkRecord[uid] or {
				time = 0
			}

			if sortRecord[uid] then
				if sortRecord[uid] < data.time then
					sortRecord[uid] = data.time
				end
			else
				sortRecord[uid] = data.time
			end

			if data.is_unread then
				table.insert(self.msgMap[uid].newMsgs, data)
			else
				table.insert(self.msgMap[uid].msgs, data)
			end

			if not CurAvatar.friendList[uid] and not notFriend[uid] then
				notFriend[uid] = MsgManager.getPlayerInfo(uid)
			end
		end
	end

	self:show(sortRecord, notFriend)
end

function ChatPersonalPanel:updateMsg(msgDatas)
	self.mMsgDatas = msgDatas

	if not self.linkHere then
		self:initMsgMap(msgDatas)
	end
end

function ChatPersonalPanel:initChoosingMsg(friendInfo)
	self.choosingMsgs = {}

	if friendInfo and self.msgMap[friendInfo.uid] then
		self.choosingMsgs = self.msgMap[friendInfo.uid].msgs

		if true or #self.choosingMsgs == 0 then
			for _, msg in ipairs(self.msgMap[friendInfo.uid].newMsgs) do
				msg.is_unread = false

				table.insert(self.choosingMsgs, msg)
			end

			self.msgMap[friendInfo.uid].msgs = self.choosingMsgs
			self.msgMap[friendInfo.uid].newMsgs = {}
			self.msgMap[friendInfo.uid].friendInfo.newMsgsCount = 0

			self.friendsPanel:setTotalCount(self:getCount(self.friendInfos, true))
		end
	end

	self:refreshMsgListTop()
end

function ChatPersonalPanel:onFriendCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = FriendCell(sender, "System/Chat/PersonalChatCell", newIdx)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.friendInfos[newIdx])
end

function ChatPersonalPanel:onViewValueChanged(sender, vx, vy)
	if vy < 99 then
		self._isLock = true
	else
		self:checkNewMsg()
	end
end

function ChatPersonalPanel:getCurUid()
	return self.curFriend.uid
end

function ChatPersonalPanel:addFriendTalkOut(otherFriend)
	self.linkHere = false
	self.outFriendInfo = otherFriend

	self:initMsgMap(self.mMsgDatas or {})

	self.outFriendInfo = nil
end

function ChatPersonalPanel:addFriendTalk(otherFriend, needSelect)
	local uid = otherFriend.uid
	local index = -1

	if self.msgMap[uid] then
		for idx, info in ipairs(self.friendInfos) do
			if info.base.uid == uid then
				index = idx

				break
			end
		end

		local t

		if index == -1 then
			t = self:newFirendInfo(otherFriend)
		else
			t = self.friendInfos[index]

			table.remove(self.friendInfos, index)
		end

		table.insert(self.friendInfos, 1, t)

		self.msgMap[uid].friendInfo = t
	else
		local t

		if CurAvatar.friendList[uid] then
			t = self:newFirendInfo(CurAvatar.friendList[uid])
		else
			t = self:newFirendInfo(otherFriend)
		end

		table.insert(self.friendInfos, 1, t)

		self.msgMap[uid] = self:newMsgMapInfo(t)
	end

	if needSelect then
		self:chooseFriend()
		self.friendsPanel:scrollToCell(1)
	end
end

function ChatPersonalPanel:_updateNews(otherUid, msgData)
	if otherUid and (self.curFriend and otherUid ~= self.curFriend.uid or not self.curFriend) then
		local needSelect = self.curFriend == nil

		if self.msgMap[otherUid] then
			self:addFriendTalk(self.msgMap[otherUid].friendInfo.base, needSelect)
		else
			local otherPlayer = MsgManager.getPlayerInfo(otherUid, linkHere)

			self:addFriendTalk(otherPlayer, needSelect)
		end
	end

	if not otherUid and self.curFriend then
		otherUid = self.curFriend.uid
	end

	if self.msgMap[otherUid].friendInfo then
		self.msgMap[otherUid].friendInfo.newMsgsCount = #self.msgMap[otherUid].newMsgs

		self.friendsPanel:setTotalCount(self:getCount(self.friendInfos, true))
	end

	if self.curFriend and otherUid == self.curFriend.uid then
		local curNewCount = 0

		for i, msgData in ipairs(self.msgMap[otherUid].newMsgs) do
			for j, channel in ipairs(self.mCurReceives) do
				if msgData.channel == channel then
					curNewCount = curNewCount + 1
				end
			end
		end

		self.mWindow:setNewHint(curNewCount)
	end
end

function ChatPersonalPanel:onHintGoTop(...)
	local _newMsgs = self.msgMap[self.curFriend.uid].newMsgs
	local count = #_newMsgs

	self:checkNewMsg()
	self:refreshMsgList(count)
end

function ChatPersonalPanel:checkNewMsg(...)
	local _newMsgs = self.msgMap[self.curFriend.uid].newMsgs
	local count = #_newMsgs

	if #_newMsgs > 0 then
		for i, msgData in ipairs(_newMsgs) do
			msgData.is_unread = false

			table.insert(self.msgMap[self.curFriend.uid].msgs, msgData)
		end

		self.msgMap[self.curFriend.uid].newMsgs = {}

		self:_updateNews()
		self:refreshMsgList()
	end

	self._isLock = false
end

function ChatPersonalPanel:onMsgReceive(msgData)
	local avatar = CurAvatar
	local isSelf = avatar and msgData.suid == avatar.uid
	local isCurFriend = self.curFriend and (msgData.suid == self.curFriend.uid or msgData.ruid == self.curFriend.uid)
	local otherUid = 0

	if isSelf then
		otherUid = msgData.ruid
	else
		otherUid = msgData.suid
	end

	if CurAvatar:isMyMaster(otherUid) or CurAvatar:isMyApprentice(otherUid) then
		return
	end

	if isCurFriend and (not self._isLock or isSelf or self.checkInitedMap[self.curFriend.uid] ~= true) then
		table.insert(self.msgMap[self.curFriend.uid].msgs, msgData)

		self.choosingMsgs = self.msgMap[self.curFriend.uid].msgs
		msgData.is_unread = false

		self:refreshMsgListTop()
		self:setRedHintState(false)
		self:refreshRedHint()
	else
		if self.msgMap[otherUid] and self.msgMap[otherUid].newMsgs then
			-- block empty
		else
			local t = self:newFirendInfo(MsgManager.getPlayerInfo(otherUid))

			self.msgMap[otherUid] = self:newMsgMapInfo(t)

			table.insert(self.friendInfos, 1, t)
		end

		table.insert(self.msgMap[otherUid].newMsgs, msgData)
		self:_updateNews(otherUid, msgData)
		self:refreshMsgList()
	end
end

function ChatPersonalPanel:setRedHintState(v)
	RedDotManager.setKeyState(UIConst.RD_HINT_CHAT_PRIVATE, v)
end

function ChatPersonalPanel:onBtnChooseFriendClick()
	if utils.getTableElemCount(CurAvatar.friendList) == 0 then
		MsgManager.notice(Lang.get(30167))

		return
	end

	UIManager.getUI("chooseFriendDlg", true):show({})
end

function ChatPersonalPanel:onMessageCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChatCell(sender, "System/Chat/BroChatMessageInfoPanel", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.choosingMsgs[newIdx], self.mParent:isNeedShowTime(newIdx, self.choosingMsgs))
end

function ChatPersonalPanel:refreshShow(...)
	self:refreshMsgListTop()
end

function ChatPersonalPanel:refreshMsgListTop(...)
	self:refreshMsgList(1)
end

function ChatPersonalPanel:refreshMsgList(jumpIdx)
	local count = #self.choosingMsgs

	if count > 5 and self.curFriend then
		self.checkInitedMap[self.curFriend.uid] = true
	end

	self.messagePanel:setTotalCount(count, jumpIdx)
	self.panelNothing:setVisible(count <= 0)
end

function ChatPersonalPanel:refreshFriendList(player)
	if player then
		for i, f in ipairs(self.friendInfos) do
			if f.base.uid == player.uid then
				for k, v in pairs(player) do
					f.base[k] = v
				end

				break
			end
		end
	end

	self.friendsPanel:setTotalCount(#self.friendInfos, nil)
end

return ChatPersonalPanel
