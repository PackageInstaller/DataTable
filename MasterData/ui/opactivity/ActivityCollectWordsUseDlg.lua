-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsUseDlg.lua

local ResItem = require("ClientData/ResItem")
local ResOpActivityCollectWordsMisc = require("ClientData/ResOpActivityCollectWordsMisc")
local RES_SEND_STATE = {
	{
		Lang.get(61835),
		"BgReceived05"
	},
	{
		Lang.get(61559),
		"BgReceived01"
	},
	{
		Lang.get(61560),
		"BgReceived02"
	},
	[7] = {
		Lang.get(61561),
		"BgReceived03"
	},
	[14] = {
		Lang.get(61562),
		"BgReceived04"
	}
}
local UseSendFriendCell = Class("UseSendFriendCell", UIControls.ScrollViewLoopCell)

function UseSendFriendCell:ctor()
	self:initUI()
end

local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"

function UseSendFriendCell:initUI()
	self.playerName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.serverName = UIControls.Label(self, "BgPanel/TextServer")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.iconServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.btnSend = UIControls.Button(self, "BgPanel/BtnSend")

	self.btnSend:addEventClick(self.onBtnSendClick)

	self.panelDis = UIControls.Panel(self, "BgPanel/DisSendPanel")
	self.panelWord = UIControls.Panel(self, "BgPanel/WordPanel")
	self.imgWord = UIControls.Image(self, "BgPanel/WordPanel/Icon")
	self.imgSendState = UIControls.Image(self, "BgPanel/TextPlayerName/ImgSendState")
	self.textSendState = UIControls.Label(self, "BgPanel/TextPlayerName/ImgSendState/Text")
end

function UseSendFriendCell:setData(data)
	self.data = data

	self.playerName:setText(data.name)
	self.serverName:setText(data.serverName or "")

	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:hideLevel()
	self.btnHead:setEnable(true)
	self.btnHead:setCommInfo(data, false, self)

	if data.gender == Const.GENDER_MAN then
		self.iconSex:setImage(ICON_PATH, "IconMale")
	else
		self.iconSex:setImage(ICON_PATH, "IconFemale")
	end

	if data.sameServer then
		self.iconServer:setImage(ICON_PATH, "IconServerSame")
	else
		self.iconServer:setImage(ICON_PATH, "IconServerElse")
	end

	if data.lack then
		self.panelWord:setVisible(true)

		local iconPath = BaseObject.getItemIconPath(self.mParent.wordId)

		if iconPath then
			self.imgWord:setImage(iconPath[1], iconPath[2])
		end
	else
		self.panelWord:setVisible(false)
	end

	self:refreshState(data.state, data.timeType)
end

function UseSendFriendCell:refreshState(state, timeType)
	if state == "Nml" then
		self.btnSend:setVisible(true)
		self.panelDis:setVisible(false)
	elseif state == "Lock" then
		self.btnSend:setVisible(false)
		self.panelDis:setVisible(true)
	end

	local resStateData = RES_SEND_STATE[timeType]

	if resStateData and self.timeType ~= timeType then
		self.timeType = timeType

		self.textSendState:setText(resStateData[1])
		self.imgSendState:setImage(self.mParent.repAtlas, resStateData[2])
	end

	self.imgSendState:setVisible(not not resStateData)
end

function UseSendFriendCell:onBtnSendClick()
	self.opId = self.mParent.actObj.opId

	if self.mParent.wordsBag[self.mParent.wordPos].num > 0 then
		if self.mParent.sendCount < Const.ACT_COLLECT_WORDS_SENDFRIEND_NUM then
			if self.mParent.actObj:inFreeze() then
				MsgManager.notice(Lang.get(54313))
			else
				CurAvatar:activityRPC(Functor(RPC.opActCollectWordsGivingWord, self.opId, self.data.uid, self.mParent.wordId), self.opId)
			end
		elseif self.mParent.sendCount >= Const.ACT_COLLECT_WORDS_SENDFRIEND_MAX then
			MsgManager.clientNotice(646)
		elseif self.mParent.actObj:inFreeze() then
			MsgManager.notice(Lang.get(54313))
		else
			UIManager.showConfirmWithId(1068, Functor(CurAvatar.activityRPC, CurAvatar, Functor(RPC.opActCollectWordsGivingWord, self.opId, self.data.uid, self.mParent.wordId), self.opId))
		end
	else
		MsgManager.clientNotice(645)
	end
end

local strClassName = "ActivityCollectWordsUseDlg"
local ActivityCollectWordsUseDlg = Class(strClassName, UIControls.Window)

function ActivityCollectWordsUseDlg:ctor()
	self:initUI()
end

function ActivityCollectWordsUseDlg:initUI()
	self.closeBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.closeBtn:addEventClick(self.onCloseClick)

	self.imgWordIcon = UIControls.Image(self, "BgPanel/WordPanel/Icon")
	self.textNum = UIControls.Label(self, "BgPanel/WordPanel/TextNum")
	self.textFriendSendNum = UIControls.Label(self, "BgPanel/FriendSendNumPanel/TextNum")
	self.scrollFriendList = UIControls.ScrollViewLoopV(self, "BgPanel/ContentList")

	self.scrollFriendList:addEventCellChanged(self.onCellChanged)

	self.nothingPanel = UIControls.Panel(self, "BgPanel/NothingPanel")
	self.btnChangeR = UIControls.Button(self, "BgPanel/BtnChangeR")

	self.btnChangeR:addEventClick(Functor(self.onChangeClick, self, 1))

	self.btnChangeL = UIControls.Button(self, "BgPanel/BtnChangeL")

	self.btnChangeL:addEventClick(Functor(self.onChangeClick, self, -1))

	self.friendCells = {}
	self.cacheLackWords = {}
end

function ActivityCollectWordsUseDlg:initFriendList()
	local ONE_DAY_TIEM = 86400
	local nextDayTime = ClientUtils.getServerTimeNextDay()

	for i, v in ipairs(self.friendList or {}) do
		if utils.tableIsContainsElement(self.sendFriendsList, v.uid) then
			v.state = "Lock"
		else
			v.state = "Nml"
		end

		if utils.tableIsContainsElement(self.lackWordFriendList, v.uid) then
			v.lack = true
		else
			v.lack = false
		end

		local sendTime = self.friendSendTimeList[v.uid]
		local timeType = 15

		if sendTime then
			if ClientUtils.isTickToday(sendTime) then
				timeType = 1
			elseif nextDayTime >= sendTime + ONE_DAY_TIEM * 13 then
				timeType = 14
			elseif nextDayTime >= sendTime + ONE_DAY_TIEM * 6 then
				timeType = 7
			elseif nextDayTime >= sendTime + ONE_DAY_TIEM * 2 then
				timeType = 3
			elseif nextDayTime >= sendTime + ONE_DAY_TIEM then
				timeType = 2
			end
		end

		v.timeType = timeType
	end
end

function ActivityCollectWordsUseDlg:setData(actObj, wordPos)
	self.actObj = actObj
	self.actData = actObj.actData

	local replaceableCellPath = actObj.clientTemplateData.src_replace

	if replaceableCellPath and replaceableCellPath[1] then
		self.cellAtlas = "System/Activity/" .. replaceableCellPath[1] .. "/CellCollectWordsUse"
	else
		self.cellAtlas = "System/Activity/CollectWords/CellCollectWordsUse"
	end

	if replaceableCellPath and replaceableCellPath[2] then
		self.repAtlas = "Atlas/ActivityAtlas/" .. replaceableCellPath[2]
	else
		self.repAtlas = "Atlas/ActivityAtlas/CollectWordsAtlas/CollectWordsAtlas13"
	end

	self.wordPos = wordPos
	self.maxCount = ResOpActivityCollectWordsMisc[2601].got_max_count
	self.friendList = {}

	for uid, v in pairs(CurAvatar.friendList or {}) do
		v.uid = uid

		table.insert(self.friendList, v)
	end

	self:refreshData(true)
end

function ActivityCollectWordsUseDlg:refreshData(isSort)
	self.wordsBag = self.actData.wordsBag
	self.sendFriendsList = self.actData.sendFriendsList
	self.sendCount = utils.getTableElemCount(self.sendFriendsList)
	self.friendSendTimeList = {}

	for i, v in ipairs(self.actData.friendSendRecords) do
		self.friendSendTimeList[v.uid] = v.tick
	end

	local wordsTypeCount = 0

	for i, v in ipairs(self.wordsBag) do
		if v.num > 0 then
			wordsTypeCount = wordsTypeCount + 1
		end
	end

	local isShowBtnChange = wordsTypeCount > 1

	self.btnChangeR:setVisible(isShowBtnChange)
	self.btnChangeL:setVisible(isShowBtnChange)

	local bagData = self.wordsBag[self.wordPos]

	self.textNum:setText(bagData.num)

	local sendNum = self.sendCount
	local sendMaxCount = self.maxCount or 3

	if sendMaxCount < sendNum then
		sendNum = sendMaxCount
	end

	self.textFriendSendNum:setText(sendNum .. "/" .. sendMaxCount)

	self.wordId = bagData.id

	local itemData = ResItem[self.wordId]

	if itemData and itemData.sourceIconPath and itemData.sourceIcon then
		self.imgWordIcon:setImage(itemData.sourceIconPath, itemData.sourceIcon)
	end

	if not self.actObj:inFreeze() then
		local cacheData = self.cacheLackWords[self.wordId]

		if not cacheData then
			if self.actData:checkOverFriendsDataRefreshTime() then
				CurAvatar:activityRPC(Functor(RPC.opActCollectWordsGetBuddyWord, self.actObj.opId, self.wordId), self.actObj.opId)

				self.actData.lastFriendRefreshTime = ClientUtils.getServerTime()
			else
				self:onCollectWordsGetBuddyInfo(isSort, {}, false)
			end
		else
			self:onCollectWordsGetBuddyInfo(isSort, cacheData)
		end
	end
end

function ActivityCollectWordsUseDlg:onCollectWordsGetBuddyInfo(isSort, friendList, isReset)
	if isReset then
		self.cacheLackWords[self.wordId] = friendList
	end

	self.lackWordFriendList = friendList

	self:initFriendList()

	if isSort then
		table.sort(self.friendList, function(a, b)
			if a.state ~= b.state then
				return a.state == "Nml"
			else
				if a.timeType ~= b.timeType then
					return a.timeType < b.timeType
				end

				if a.lack ~= b.lack then
					return a.lack == true
				end
			end
		end)
	end

	if #self.friendList == 0 then
		self.nothingPanel:setVisible(true)
	else
		self.nothingPanel:setVisible(false)
		self.scrollFriendList:setTotalCount(#self.friendList, 1)
	end
end

function ActivityCollectWordsUseDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UseSendFriendCell(sender, self.cellAtlas, newIdx)

	if not self.friendList or #self.friendList == 0 then
		return
	end

	if self.friendList[newIdx] ~= nil then
		targetCell:setData(self.friendList[newIdx])
	end

	self.friendCells[newIdx] = targetCell
end

function ActivityCollectWordsUseDlg:onChangeClick(num)
	local oldWordId = self.wordPos

	self:getNextPos(self.wordPos, num)

	if oldWordId == self.wordPos then
		return
	end

	self:refreshData(true)
end

function ActivityCollectWordsUseDlg:getNextPos(startPos, pos)
	local nextPos = startPos + pos
	local curPos

	if nextPos > 5 then
		curPos = nextPos - 5
	elseif nextPos < 1 then
		curPos = nextPos + 5
	else
		curPos = nextPos
	end

	if self.wordsBag[curPos].num <= 0 then
		self:getNextPos(nextPos, pos)
	else
		self.wordPos = curPos
	end
end

function ActivityCollectWordsUseDlg:updateActivityData()
	self:refreshData()
end

function ActivityCollectWordsUseDlg:onCloseClick()
	self:setVisible(false)
end

return ActivityCollectWordsUseDlg
