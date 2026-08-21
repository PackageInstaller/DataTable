-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatApprenticePanel.lua

local ChatCell = require("UI/Chat/ChatCell")
local ChatPlayerCell = Class("ChatApprenticePanel_ChatPlayerCell", UIControls.ScrollViewLoopCell)
local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"
local NAME_WIDTH = 130

function ChatPlayerCell:ctor()
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

function ChatPlayerCell:initData(clickCb)
	self.clickCb = clickCb
end

function ChatPlayerCell:setData(data)
	self.data = data

	self.txtName:setText(data.name)
	self.txtName:limitTextLength(NAME_WIDTH)
	self.btnHead:setCommInfo(data, true, self)
	self.panelVip:setData(data.vip, data.vip_hide)

	if data.gender == Const.GENDER_MAN then
		self.imgSex:setImage(ICON_PATH, "IconMale")
	elseif data.gender == Const.GENDER_WOMAN then
		self.imgSex:setImage(ICON_PATH, "IconFemale")
	end

	if data.sameServer then
		self.imgServer:setImage(ICON_PATH, "IconServerSame")
	else
		self.imgServer:setImage(ICON_PATH, "IconServerElse")
	end

	self.imgServer:setVisible(false)
end

function ChatPlayerCell:setSelect(value)
	self.body:setEnable(not value)
end

function ChatPlayerCell:setRedDot(value)
	self.imgNew:setVisible(value)
end

function ChatPlayerCell:onClick(...)
	self:setRedDot(false)

	if self.clickCb then
		self.clickCb(self)
	end
end

local ChatApprenticePanel = Class("ChatApprenticePanel", UIControls.Panel)

function ChatApprenticePanel:ctor(...)
	self.scrollPlayer = UIControls.ScrollViewLoopV(self, self.mPath .. "/PersonalChatList", 0, self.onFriendCellChanged)
	self.messagePanel = UIControls.ScrollViewLoopV(self, self.mPath .. "/PersonalMessagePanel", 0, self.onMessageCellChanged)

	self.messagePanel:addEventValueChanged(self.onViewValueChanged)

	self.txtName = UIControls.Label(self, self.mPath .. "/TextName")
	self.panelNothing = UIControls.Panel(self, self.mPath .. "/ImgNothing")
	self.msgMap = {}
	self._isLock = false
	self.curUid = nil
	self.msgList = {}
	self.cells = {}
	self.mCurReceives = {
		Const.CHANNEL_PRIVATE
	}
	self.slotOnClickChatPlayerCell = Slot(self.onClickChatPlayerCell, self)
end

function ChatApprenticePanel:onShow()
	self.uidList = CurAvatar.apprenticeUidList or {}

	self:recordCheckTime()

	self.linkHere = false
end

function ChatApprenticePanel:updateMsg(msgDatas)
	self.mMsgDatas = msgDatas
	self.uidList = CurAvatar.apprenticeUidList or {}

	self:initMsgMap(msgDatas)
end

function ChatApprenticePanel:initMsgMap(msgDatas)
	self.msgMap = {}

	local sortRecord = {}

	for _, data in ipairs(msgDatas) do
		local uid

		if data.suid == CurAvatar.uid then
			uid = data.ruid
		else
			uid = data.suid
		end

		if CurAvatar:isMyApprentice(uid) then
			self.msgMap[uid] = self.msgMap[uid] or self:getNewMsgMapInfo(uid)
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
		end
	end

	self:show(sortRecord)
end

function ChatApprenticePanel:show(sortRecord)
	if not self:getVisible() then
		return
	end

	self._isLock = false

	for _, uid in pairs(self.uidList) do
		self.msgMap[uid] = self.msgMap[uid] or self:getNewMsgMapInfo(CurAvatar.apprenticeDic[uid])
	end

	table.sort(self.uidList, function(uid1, uid2)
		if sortRecord[uid1] then
			return sortRecord[uid1] > (sortRecord[uid2] or 0)
		elseif sortRecord[uid2] then
			return sortRecord[uid2] < (sortRecord[uid1] or 0)
		else
			return CurAvatar.apprenticeDic[uid1].time > CurAvatar.apprenticeDic[uid2].time
		end
	end)

	if self.curUid then
		local idx = utils.getIndexByValue(self.uidList, self.curUid)

		if idx <= 0 then
			self.curUid = self.uidList[1]
		end
	else
		self.curUid = self.uidList[1]
	end

	self:choosePlayer(self.curUid)
	self.scrollPlayer:setTotalCount(#self.uidList)
end

function ChatApprenticePanel:onFriendCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChatPlayerCell(sender, "System/Chat/PersonalChatCell", newIdx)

		targetCell:initData(self.slotOnClickChatPlayerCell)
	else
		targetCell.mIndex = newIdx
	end

	local uid = self.uidList[newIdx]

	targetCell:setData(CurAvatar.apprenticeDic[uid])

	local checkSelect = uid == self.curUid

	targetCell:setSelect(checkSelect)
	targetCell:setRedDot(#self.msgMap[uid].newMsgs > 0)

	if checkSelect then
		self.selectCell = targetCell
	end
end

function ChatApprenticePanel:choosePlayer(uid)
	self.curUid = uid
	self.otherPlayer = CurAvatar.apprenticeDic[uid]
	self.msgMapInfo = self.msgMap[self.curUid]

	self.txtName:setText(self.otherPlayer.name)
	self:clearNewMsg()

	self.msgList = self.msgMapInfo.msgs

	self:refreshMsgList(1)
	self.mParent:inputEnable()
	self:recordCheckTime()
	MsgManager.refreshRed()
end

function ChatApprenticePanel:refreshMsgList(jumpIdx)
	local count = #self.msgList

	self.messagePanel:setTotalCount(count, jumpIdx)
	self.panelNothing:setVisible(count <= 0)
	self.mWindow:setNewHint(#self.msgMapInfo.newMsgs)
end

function ChatApprenticePanel:onMessageCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChatCell(sender, "System/Chat/BroChatMessageInfoPanel", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.msgList[newIdx], self.mParent:isNeedShowTime(newIdx, self.msgList))
end

function ChatApprenticePanel:onViewValueChanged(sender, vx, vy)
	if vy < 99 then
		self._isLock = true
	else
		self:clearNewMsg()
		self:refreshMsgList(1)
	end
end

function ChatApprenticePanel:onMsgReceive(msgData)
	local isSelf = CurAvatar and msgData.suid == CurAvatar.uid
	local uid = 0

	if isSelf then
		uid = msgData.ruid
	else
		uid = msgData.suid
	end

	local msgMapInfo = self.msgMap[uid]

	if uid == self.curUid then
		if self._isLock and not isSelf then
			table.insert(msgMapInfo.newMsgs, msgData)
			self.mWindow:setNewHint(#msgMapInfo.newMsgs)
		else
			if isSelf then
				self:clearNewMsg()
			end

			table.insert(msgMapInfo.msgs, msgData)

			msgData.is_unread = false

			self:refreshMsgList(1)
		end
	else
		table.insert(msgMapInfo.newMsgs, msgData)
	end
end

function ChatApprenticePanel:getNewMsgMapInfo(uid)
	return {
		uid = uid,
		newMsgs = {},
		msgs = {}
	}
end

function ChatApprenticePanel:clearNewMsg()
	local newMsgs = self.msgMapInfo.newMsgs

	if #newMsgs > 0 then
		for i, msg in ipairs(newMsgs) do
			msg.is_unread = false

			table.insert(self.msgMapInfo.msgs, msg)
		end

		self.msgMapInfo.newMsgs = {}
	end

	self._isLock = false
end

function ChatApprenticePanel:recordCheckTime(...)
	if self.curUid then
		local recordTime = 0

		if self.msgMapInfo then
			local msgs = self.msgMapInfo.msgs

			if #msgs > 0 then
				recordTime = math.max(recordTime, msgs[#msgs].time)
			end
		end

		ClientUtils.record.checkRecord[self.curUid] = {
			time = recordTime
		}
	end
end

function ChatApprenticePanel:onBtnChooseFriendClick()
	return
end

function ChatApprenticePanel:onClickChatPlayerCell(cell)
	if self.selectCell then
		self.selectCell:setSelect(false)
	end

	self.selectCell = cell

	cell:setSelect(true)
	self:choosePlayer(cell.data.uid)
end

function ChatApprenticePanel:talkWithPlayer(otherPlayer)
	self:choosePlayer(otherPlayer.uid)
end

function ChatApprenticePanel:onHintGoTop(...)
	local _newMsgs = self.msgMapInfo.newMsgs
	local count = #_newMsgs

	self:clearNewMsg()
	self:refreshMsgList(count)
end

function ChatApprenticePanel:getCurUid()
	return self.curUid
end

function ChatApprenticePanel:getPlayerInfo(uid)
	return CurAvatar.apprenticeDic[uid]
end

function ChatApprenticePanel:refreshShow(...)
	self:refreshMsgList(1)
end

function ChatApprenticePanel:refreshApprenticeList()
	return
end

return ChatApprenticePanel
