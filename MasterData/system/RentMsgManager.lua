-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\RentMsgManager.lua

local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local RentMsgManager = {}
local self = RentMsgManager

function RentMsgManager.registerNoticeUI(uiName, mountPanel, noticeChild)
	if not self.uiDict then
		self.uiDict = {}
	end

	local uiObj = self.uiDict[uiName] or {}

	uiObj.mountPanel = mountPanel
	uiObj.noticeChild = noticeChild
	self.uiDict[uiName] = uiObj
	self.nowRegUI = uiName

	for name, _ in pairs(self.uiDict) do
		if name ~= self.nowRegUI then
			self.unregisterNoticeUI(name)
		end
	end

	self.checkDisplay()
end

function RentMsgManager.unregisterNoticeUI(uiName)
	if self.nowRegUI == uiName then
		self.nowRegUI = nil
	end

	if self.uiDict[uiName] then
		self.closeNoticeUI(self.uiDict[uiName], true)
	end

	self.uiDict[uiName] = nil
end

function RentMsgManager.showNoticeUI(msgToShow, uiObj, leftTick)
	if not uiObj.noticeChild then
		return
	end

	local mountPanel = uiObj.mountPanel
	local noticeChild = uiObj.noticeChild

	mountPanel:setVisible(true)
	noticeChild:setVisible(true)

	if uiObj.inShowing then
		noticeChild:playAni("AgainChildCaseTaskNews", nil, true)
	else
		noticeChild:playAni("ShowChildCaseTaskNews", nil, true)
	end

	noticeChild:inCloseAni(false)

	if msgToShow.msgType == Const.RENT_NOTICE_TYPE.ReqMsg then
		noticeChild:requestNotice(msgToShow.recordInfo, msgToShow.playerComm, leftTick)
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.RespMsg then
		noticeChild:responseNotice(msgToShow.recordInfo, msgToShow.playerComm, leftTick)
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.Letter then
		noticeChild:letterNotice(msgToShow.recordInfo, msgToShow.playerComm, leftTick)
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.CircleInvite then
		local circle = msgToShow.playerComm

		noticeChild:circleInviteNotice(msgToShow.recordInfo, circle, leftTick)
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.GiftDrawMsg then
		noticeChild:opActGiftDrawNotice(msgToShow.recordInfo, msgToShow.playerComm, leftTick)
	end

	uiObj.inShowing = true
end

function RentMsgManager.closeNoticeUI(uiObj, immidiatly)
	uiObj.inShowing = false

	if immidiatly then
		RentMsgManager._realCloseUI(uiObj)
	elseif uiObj.noticeChild then
		uiObj.noticeChild:inCloseAni(true)
		uiObj.noticeChild:playAni("CloseChildCaseTaskNews", Functor(self._realCloseUI, uiObj), true)
	end

	if uiObj.noticeChild then
		uiObj.noticeChild:clear()
	end
end

function RentMsgManager._realCloseUI(uiObj)
	if uiObj and uiObj.mountPanel then
		uiObj.mountPanel:setVisible(false)
	end
end

function RentMsgManager.closeByOperate()
	self._nowUINoshowing()
	self.showNextMsg()
end

function RentMsgManager.closeByForceClose(isCircleInvite)
	self._nowUINoshowing()

	if not isCircleInvite then
		self._onUnoptClose()
	end

	self.showNextMsg()
end

function RentMsgManager.closeByTickEnd(isCircleInvite)
	self._nowUINoshowing()

	if not isCircleInvite then
		self._onUnoptClose()
	end

	self.showNextMsg()
end

function RentMsgManager.closeByOverdue(...)
	self._nowUINoshowing()
	self.showNextMsg()
end

function RentMsgManager._onUnoptClose(...)
	if not self.unOptCloseNum then
		self.unOptCloseNum = 0
	end

	self.unOptCloseNum = self.unOptCloseNum + 1

	if self.unOptCloseNum >= 10 then
		MsgManager.notice(Lang.get(30051))

		self.unOptCloseNum = nil
	end
end

function RentMsgManager._nowUINoshowing()
	if self.nowRegUI and self.uiDict[self.nowRegUI] then
		self.uiDict[self.nowRegUI].inShowing = false
	end
end

function RentMsgManager.addRentMsg(msgType, recordInfo, playerComm)
	if not self.msgCacheList then
		self.msgCacheList = {}
	end

	local msgInfo = {}

	msgInfo.msgType = msgType
	msgInfo.recordInfo = recordInfo
	msgInfo.playerComm = playerComm

	table.insert(self.msgCacheList, msgInfo)
	self.checkDisplay()
end

RentMsgManager.COUNT_DOWN_TICK = 30

function RentMsgManager.checkDisplay()
	local haveCircleInviteMsg = false

	for _, msgToShow in ipairs(self.msgCacheList) do
		if msgToShow.msgType == Const.RENT_NOTICE_TYPE.CircleInvite then
			haveCircleInviteMsg = true

			break
		end
	end

	if not haveCircleInviteMsg and not CurAvatar.rentMsgNoticeOn and not CurAvatar.rentLetterNoticeOn or not self.msgCacheList or #self.msgCacheList == 0 then
		for uiName, uiObj in pairs(self.uiDict) do
			self.closeNoticeUI(uiObj, not uiObj.inShowing)
		end

		return
	end

	if not self.uiDict or next(self.uiDict) == nil then
		return
	end

	if not self.nowRegUI then
		return
	end

	local uiObj = self.uiDict[self.nowRegUI]

	if not uiObj or not uiObj.noticeChild then
		return
	end

	if uiObj.inShowing then
		uiObj.noticeChild:ensureSlider()

		return
	end

	local msgToShow = self.msgCacheList[1]
	local leftTick

	if not msgToShow.startShowTick then
		msgToShow.startShowTick = ClientUtils.getServerTime()
		leftTick = RentMsgManager.COUNT_DOWN_TICK
	else
		leftTick = RentMsgManager.COUNT_DOWN_TICK - (ClientUtils.getServerTime() - msgToShow.startShowTick)

		if leftTick <= 0 then
			self.showNextMsg()

			return
		end
	end

	if not self._checkDataValid(msgToShow) then
		self.showNextMsg()

		return
	end

	self.showNoticeUI(msgToShow, uiObj, leftTick)
end

function RentMsgManager._checkDataValid(msgToShow)
	if msgToShow.msgType == Const.RENT_NOTICE_TYPE.ReqMsg then
		local record = msgToShow.recordInfo
		local renterUid = record.renterUid
		local groupTaskId = record.groupTaskId
		local teamId = record.teamId

		return RentTaskUtils.checkOwnerRecordInStatus(groupTaskId, renterUid, teamId, Const.RENT_APPLY_STATUS.Applying)
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.RespMsg then
		local record = msgToShow.recordInfo
		local groupTaskId = record.groupTaskId
		local uid = record.uid
		local teamId = record.teamId
		local overdueTick = record.overdueTick

		if overdueTick and overdueTick <= ClientUtils.getServerTime() then
			return false
		end

		return RentTaskUtils.isGroupTaskValid(groupTaskId) and RentTaskUtils.checkBorrowerRecordNewBorrowed(uid, teamId, groupTaskId)
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.Letter then
		return true
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.CircleInvite then
		local record = msgToShow.recordInfo
		local overdueTick = record.tick + 86400

		if overdueTick and overdueTick <= ClientUtils.getServerTime() then
			return false
		else
			return true
		end
	elseif msgToShow.msgType == Const.RENT_NOTICE_TYPE.GiftDrawMsg then
		return true
	end

	return false
end

function RentMsgManager.showNextMsg()
	table.remove(self.msgCacheList, 1)
	self.checkDisplay()
end

function RentMsgManager.clearRentMsg(isClearCircleInvite)
	if self.msgCacheList and #self.msgCacheList > 0 then
		for i = #self.msgCacheList, 1, -1 do
			if not isClearCircleInvite or self.msgCacheList[i].msgType == Const.RENT_NOTICE_TYPE.CircleInvite then
				table.remove(self.msgCacheList, i)
			end
		end
	else
		self.msgCacheList = {}
	end

	if self.uiDict and #self.msgCacheList == 0 then
		for uiName, uiObj in pairs(self.uiDict) do
			self.closeNoticeUI(uiObj, true)
		end
	end
end

function RentMsgManager.closeAnyCircleMsgByOperation(circleGid)
	if self.msgCacheList and #self.msgCacheList > 0 then
		for i = #self.msgCacheList, 1, -1 do
			if self.msgCacheList[i].msgType == Const.RENT_NOTICE_TYPE.CircleInvite and self.msgCacheList[i].playerComm.gid == circleGid then
				if i == 1 then
					self.closeByOperate()
				else
					table.remove(self.msgCacheList, i)
				end
			end
		end
	end
end

return RentMsgManager
