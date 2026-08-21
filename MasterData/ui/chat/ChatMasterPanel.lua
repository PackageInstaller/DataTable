-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatMasterPanel.lua

local ChatCell = require("UI/Chat/ChatCell")
local ChatMasterPanel = Class("ChatMasterPanel", UIControls.Panel)

function ChatMasterPanel:ctor(...)
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
end

function ChatMasterPanel:onShow()
	self.uidList = {
		CurAvatar.master.uid
	}

	self:recordCheckTime()

	self.linkHere = false
end

function ChatMasterPanel:updateMsg(msgDatas)
	self.mMsgDatas = msgDatas
	self.uidList = {
		CurAvatar.master.uid
	}

	self:initMsgMap(msgDatas)
	MsgManager.refreshRed()
end

function ChatMasterPanel:initMsgMap(msgDatas)
	self.msgMap = {}

	local sortRecord = {}

	for _, data in ipairs(msgDatas) do
		local uid

		if data.suid == CurAvatar.uid then
			uid = data.ruid
		else
			uid = data.suid
		end

		if CurAvatar:isMyMaster(uid) then
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

	self.msgMap[CurAvatar.master.uid] = self.msgMap[CurAvatar.master.uid] or self:getNewMsgMapInfo(CurAvatar.master.uid)
	self._isLock = false

	self:choosePlayer()
end

function ChatMasterPanel:choosePlayer()
	self.curUid = CurAvatar.master.uid
	self.otherPlayer = CurAvatar.master
	self.msgMapInfo = self.msgMap[self.curUid]

	self.txtName:setText(self.otherPlayer.name)
	self:clearNewMsg()

	self.msgList = self.msgMapInfo.msgs

	self:refreshMsgList(1)
	self.mParent:inputEnable()
	self:recordCheckTime()
end

function ChatMasterPanel:refreshMsgList(jumpIdx)
	local count = #self.msgList

	self.messagePanel:setTotalCount(count, jumpIdx)
	self.panelNothing:setVisible(count <= 0)
	self.mWindow:setNewHint(#self.msgMapInfo.newMsgs)
end

function ChatMasterPanel:onMessageCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChatCell(sender, "System/Chat/BroChatMessageInfoPanel", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.msgList[newIdx], self.mParent:isNeedShowTime(newIdx, self.msgList))
	targetCell:outSetWidth(true)
end

function ChatMasterPanel:onViewValueChanged(sender, vx, vy)
	if vy < 99 then
		self._isLock = true
	else
		self:clearNewMsg()
		self:refreshMsgList(1)
	end
end

function ChatMasterPanel:onMsgReceive(msgData)
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

function ChatMasterPanel:getNewMsgMapInfo(uid)
	return {
		uid = uid,
		newMsgs = {},
		msgs = {}
	}
end

function ChatMasterPanel:clearNewMsg()
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

function ChatMasterPanel:recordCheckTime(...)
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

function ChatMasterPanel:talkWithPlayer(otherPlayer)
	self:choosePlayer(otherPlayer.uid)
end

function ChatMasterPanel:onHintGoTop(...)
	local _newMsgs = self.msgMapInfo.newMsgs
	local count = #_newMsgs

	self:clearNewMsg()
	self:refreshMsgList(count)
end

function ChatMasterPanel:getCurUid()
	return self.curUid
end

function ChatMasterPanel:getPlayerInfo()
	return CurAvatar.master
end

function ChatMasterPanel:refreshShow(...)
	self:refreshMsgList(1)
end

function ChatMasterPanel:refreshApprenticeList()
	return
end

return ChatMasterPanel
