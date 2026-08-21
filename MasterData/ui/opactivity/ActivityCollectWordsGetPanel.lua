-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsGetPanel.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local CommonBonusDlg = require("UI/Common/CommonBonusDlg")
local ResItem = require("ClientData/ResItem")
local ResColor = require("ClientData/ResColor")
local ChildFriendSendCell = Class("ChildFriendSendCell", UIControls.ScrollViewLoopCell)

function ChildFriendSendCell:ctor()
	self:initUI()
end

function ChildFriendSendCell:initUI()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.textName = UIControls.Label(self, "TextName")
	self.textType = UIControls.Label(self, "TextType")
	self.textDate = UIControls.Label(self, "TextDate")
	self.textState = UIControls.Panel(self, "TextState")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.btnGetDis = UIControls.Button(self, "BtnGetDis")

	self.btnGetDis:addEventClick(self.onBtnGetDisClick)
end

function ChildFriendSendCell:onBtnGetClick()
	local mainDlg = UIManager.getUI("activityCollectWordsDlg", nil, false)

	if mainDlg then
		local origin_word = self.imgIcon
		local wordPos = 1

		for i, data in ipairs(self.actObj.actData.wordsBag or {}) do
			if data.id == self.data.itemid then
				wordPos = i
			end
		end

		local target_word = mainDlg.btnWords[wordPos].btn

		CommonBonusDlg.setCustomizeFlyConfig(true, target_word)
	end

	local uid = self.data.uid
	local item_id = self.data.itemid
	local tick = self.data.tick

	CurAvatar:activityRPC(Functor(RPC.opActCollectWordsRecvWord, self.actObj.opId, uid, item_id, tick), self.actObj.opId)
end

function ChildFriendSendCell:onBtnGetDisClick()
	MsgManager.clientNotice(649)
end

function ChildFriendSendCell:setData(data)
	self.actObj = self.mParent.actObj
	self.data = data

	if CurAvatar.friendList[data.uid] then
		self.textName:setText(CurAvatar.friendList[data.uid].name)
	elseif self.actObj.actData.otherPlayerInfo and self.actObj.actData.otherPlayerInfo[data.uid] then
		self.textName:setText(self.actObj.actData.otherPlayerInfo[data.uid])
	else
		self.textName:setText("")
	end

	local itemData = ResItem[data.itemid]

	if itemData and itemData.name then
		self.textType:setText(string.format(Lang.get(62964), ResItem[data.itemid].name))
	end

	local itemData = ResItem[data.itemid]

	if itemData and itemData.sourceIconPath and itemData.sourceIcon then
		self.imgIcon:setImage(itemData.sourceIconPath, itemData.sourceIcon)
	end

	self.textDate:setText(string.format(Lang.get(62965), ClientUtils.getServerTimeData(data.tick, "%m.%d")))

	if data.status == Const.ACT_COLLECT_WORDS_FRIEND_SEND_GOT then
		self.btnGet:setVisible(false)
		self.btnGetDis:setVisible(false)
		self.textState:setVisible(true)
		self.imgIcon:setObjGray(true)
		self.textName:setObjGray(true)
		self.textDate:setObjGray(true)
	else
		self.imgIcon:setObjGray(false)
		self.textName:setObjGray(false)
		self.textDate:setObjGray(false)

		if self.mParent.canGetFriendWord then
			self.btnGet:setVisible(true)
			self.btnGetDis:setVisible(false)
			self.textState:setVisible(false)
		else
			self.btnGet:setVisible(false)
			self.btnGetDis:setVisible(true)
			self.textState:setVisible(false)
		end
	end
end

local strClassName = "ActivityCollectWordsGetPanel"
local ActivityCollectWordsGetPanel = Class(strClassName, UIControls.Window)

function ActivityCollectWordsGetPanel:ctor()
	self:initUI()
end

function ActivityCollectWordsGetPanel:initUI()
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.dropPanel = UIControls.Panel(self, "MainInfoPanel/DropPanel")
	self.friendSendPanel = UIControls.Panel(self, "MainInfoPanel/FriendSendPanel")
	self.btnTabDrop = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnTab1")

	self.btnTabDrop:addEventClick(self.onDropClick)

	self.btnTabFriend = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnTab2")

	self.btnTabFriend:addEventClick(self.onFriendClick)

	self.bgTabDropSel = UIControls.Panel(self, "MainInfoPanel/TabPanel/BtnTab1/BgSel")
	self.bgTabDropDis = UIControls.Panel(self, "MainInfoPanel/TabPanel/BtnTab1/BgDis")
	self.bgTabFriendSel = UIControls.Panel(self, "MainInfoPanel/TabPanel/BtnTab2/BgSel")
	self.bgTabFriendDis = UIControls.Panel(self, "MainInfoPanel/TabPanel/BtnTab2/BgDis")
	self.btnWords = {}
	self.textWords = {}

	for i = 1, 5 do
		local btn_word = UIControls.Button(self, "MainInfoPanel/DropPanel/DropList/BtnWord" .. i)
		local txt_word = UIControls.Label(self, "MainInfoPanel/DropPanel/DropList/BtnWord" .. i .. "/NmlPanel/TextNml")
		local nmlPanel = UIControls.Panel(self, "MainInfoPanel/DropPanel/DropList/BtnWord" .. i .. "/NmlPanel")
		local disPanel = UIControls.Panel(self, "MainInfoPanel/DropPanel/DropList/BtnWord" .. i .. "/DisPanel")
		local disPanelIcon = UIControls.Image(self, "MainInfoPanel/DropPanel/DropList/BtnWord" .. i .. "/DisPanel/Icon")
		local btnGet = UIControls.Button(self, "MainInfoPanel/DropPanel/DropList/BtnWord" .. i .. "/NmlPanel/BtnGet")

		btnGet:addEventClick(Functor(self.onGetWordClick, self, i))
		table.insert(self.btnWords, {
			word_obj = btn_word,
			txt = txt_word,
			nmlPanel = nmlPanel,
			disPanel = disPanel,
			btnGet = btnGet,
			disPanelIcon = disPanelIcon
		})
	end

	self.textQueueNum = UIControls.Label(self, "MainInfoPanel/DropPanel/NumPanel/TextNum")
	self.textSpeedNum = UIControls.Label(self, "MainInfoPanel/DropPanel/SpeedPanel/TextSpeedNum")
	self.panelPause = UIControls.Panel(self, "MainInfoPanel/DropPanel/SpeedPanel/TextPause")
	self.scrollFriendSendList = UIControls.ScrollViewLoopH(self, "MainInfoPanel/FriendSendPanel/FriendSendList")

	self.scrollFriendSendList:addEventCellChanged(self.onCellChanged)

	self.friendCells = {}
	self.textGetFriendNum = UIControls.Label(self, "MainInfoPanel/FriendSendPanel/NumPanel/TextNum")
	self.nothingPanel = UIControls.Panel(self, "MainInfoPanel/FriendSendPanel/NothingPanel")
	self.panelMax = UIControls.Panel(self, "MainInfoPanel/DropPanel/MaxPanel")
	self.panelTime = UIControls.Panel(self, "MainInfoPanel/DropPanel/TimePanel")
	self.refreshTime = UIControls.Label(self, "MainInfoPanel/DropPanel/TimePanel/TextTime")
	self.panelSpeed = UIControls.Panel(self, "MainInfoPanel/DropPanel/SpeedPanel")
	self.panelEnd = UIControls.Panel(self, "MainInfoPanel/DropPanel/ActivityEndPanel")
end

function ActivityCollectWordsGetPanel:setData(actObj, jumpFriendSendPage)
	self.actObj = actObj
	self.actData = actObj.actData

	local replaceableCellPath = actObj.clientTemplateData.src_replace

	if replaceableCellPath and replaceableCellPath[1] then
		self.cellAtlas = "System/Activity/" .. replaceableCellPath[1] .. "/ChildFriendSend"
	else
		self.cellAtlas = "System/Activity/CollectWords/ChildFriendSend"
	end

	self.getFrinedCount = self.actObj.actData.getFrinedCount
	self.canGetFriendWord = true
	self.friendSendRecords = {}

	for i, v in pairs(self.actObj.actData.friendSendRecords or {}) do
		table.insert(self.friendSendRecords, v)
	end

	if self.getFrinedCount >= Const.ACT_COLLECT_WORDS_GETFRIEND_NUM then
		self.canGetFriendWord = false
	end

	if jumpFriendSendPage then
		self:onFriendClick()
	else
		self:onDropClick()
	end
end

function ActivityCollectWordsGetPanel:onDropClick()
	self.curPage = 1

	self.btnTabFriend:setEnable(true)
	self.btnTabDrop:setEnable(false)
	self.dropPanel:setVisible(true)
	self.friendSendPanel:setVisible(false)
	self:refreshDropPanel()
end

function ActivityCollectWordsGetPanel:refreshDropPanel()
	self.wordsQueue = self.actObj.actData.wordsQueue or {}
	self.friendSendRecords = self.actObj.actData.friendSendRecords
	self.totalNum = 0

	for i = 1, 5 do
		if self.wordsQueue[i] and self.wordsQueue[i].num > 0 then
			self.btnWords[i].nmlPanel:setVisible(true)
			self.btnWords[i].disPanel:setVisible(false)
			self.btnWords[i].btnGet:setVisible(true)
			self.btnWords[i].txt:setText(self.wordsQueue[i].num)

			self.totalNum = self.totalNum + self.wordsQueue[i].num
		else
			self.btnWords[i].nmlPanel:setVisible(false)
			self.btnWords[i].disPanel:setVisible(true)
			self.btnWords[i].disPanelIcon:setImageGray(true)
			self.btnWords[i].btnGet:setVisible(false)
		end
	end

	self.textQueueNum:setText(string.format("%d/%d", self.totalNum, self.actObj.actData.hangUpMaxNum))

	local nextDropTime = self.actObj.actData.fresh_tick + self.actObj.actData.dropInterval
	local curTime = ClientUtils.getServerTime()

	if curTime <= nextDropTime then
		local countTime = nextDropTime - curTime + 5

		ClientTimerManager.AddSecondFormatTickUI(self.refreshTime, countTime, false, "%s", Slot(self.resetTimeOver, self))
	else
		self:resetTimeOver()
	end

	if self.totalNum >= self.actObj.actData.hangUpMaxNum then
		self.textSpeedNum:setVisible(false)
		self.panelPause:setVisible(true)
		self.panelTime:setVisible(false)
		self.panelMax:setVisible(true)
	else
		local time = self.actObj.actData.dropInterval / 60

		self.textSpeedNum:setVisible(true)
		self.panelPause:setVisible(false)
		self.textSpeedNum:setText(string.format(Lang.get(62966), time))
		self.panelTime:setVisible(true)
		self.panelMax:setVisible(false)
	end

	if self.actObj:inFreeze() or not self.actObj:isOpen() then
		self.panelTime:setVisible(false)
		self.panelSpeed:setVisible(false)
		self.panelEnd:setVisible(true)
	else
		self.panelSpeed:setVisible(true)
		self.panelEnd:setVisible(false)
	end
end

function ActivityCollectWordsGetPanel:resetTimeOver()
	if self.actObj:inFreeze() then
		-- block empty
	else
		CurAvatar:activityRPC(Functor(RPC.opActCollectWordsRefreshDeposit, self.actObj.opId), self.actObj.opId)
	end
end

function ActivityCollectWordsGetPanel:onFriendClick()
	self.curPage = 2

	self.btnTabFriend:setEnable(false)
	self.btnTabDrop:setEnable(true)
	self.dropPanel:setVisible(false)
	self.friendSendPanel:setVisible(true)
	self:refreshFriendPanel(true)
end

function ActivityCollectWordsGetPanel:sortFriendSendRecordList()
	table.sort(self.friendSendRecords, function(a, b)
		if a.status ~= b.status then
			return a.status == Const.ACT_COLLECT_WORDS_FRIEND_SEND_NOT_GOT
		else
			return a.tick < b.tick
		end
	end)
end

function ActivityCollectWordsGetPanel:refreshFriendPanel(isSort)
	self.getFrinedCount = self.actObj.actData.getFrinedCount

	for i, record in pairs(self.actObj.actData.friendSendRecords or {}) do
		for j, data in pairs(self.friendSendRecords or {}) do
			if data.uid == record.uid and data.tick == record.tick and data.itemid == record.itemid then
				data.status = record.status
			end
		end
	end

	self.textGetFriendNum:setText(string.format("%d/%d", self.getFrinedCount, Const.ACT_COLLECT_WORDS_GETFRIEND_NUM))

	if self.getFrinedCount >= Const.ACT_COLLECT_WORDS_GETFRIEND_NUM then
		self.canGetFriendWord = false
	end

	if isSort then
		self:sortFriendSendRecordList()
	end

	if #self.friendSendRecords > 0 then
		self.scrollFriendSendList:setVisible(true)
		self.nothingPanel:setVisible(false)
		self.scrollFriendSendList:setTotalCount(#self.friendSendRecords, 1)
	else
		self.scrollFriendSendList:setVisible(false)
		self.nothingPanel:setVisible(true)
	end
end

function ActivityCollectWordsGetPanel:refreshData()
	if self.curPage == 1 then
		self:refreshDropPanel()
	else
		self:refreshFriendPanel()
	end
end

function ActivityCollectWordsGetPanel:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or ChildFriendSendCell(sender, self.cellAtlas, newIdx)

	if not self.friendSendRecords or #self.friendSendRecords == 0 then
		return
	end

	if self.friendSendRecords[newIdx] ~= nil then
		targetCell:setData(self.friendSendRecords[newIdx])
	end

	self.friendCells[newIdx] = targetCell
end

function ActivityCollectWordsGetPanel:onGetWordClick(index)
	local num = 0

	for i, v in pairs(self.actObj.actData.wordsBag or {}) do
		num = num + v.num
	end

	if num >= self.actObj.actData.bagLimit then
		MsgManager.clientNotice(650)
	else
		local item_id = self.actObj.actData.wordsBag[index].id
		local mainDlg = UIManager.getUI("activityCollectWordsDlg", nil, false)

		if mainDlg then
			local origin_word = self.btnWords[index].word_obj
			local target_word = mainDlg.btnWords[index].btn

			CommonBonusDlg.setCustomizeFlyConfig(true, target_word)
		end

		CurAvatar:activityRPC(Functor(RPC.opActCollectWordsGetDeposit, self.actObj.opId, item_id), self.actObj.opId)
	end
end

function ActivityCollectWordsGetPanel:onGetDeposit(itemId)
	if ResItem[itemId] then
		MsgManager.notice(string.format(Lang.get(62967), ResItem[itemId].name))
	end
end

function ActivityCollectWordsGetPanel:onRecvWord(itemId)
	if ResItem[itemId] then
		MsgManager.notice(string.format(Lang.get(62968), ResItem[itemId].name))
	end
end

function ActivityCollectWordsGetPanel:onCloseClick()
	self:setVisible(false)
end

function ActivityCollectWordsGetPanel:onClose()
	local mainDlg = UIManager.tryGetUI("activityCollectWordsDlg")

	if mainDlg then
		mainDlg:playAni("CloseActivityCollectWordsGet")
		mainDlg:checkMergeWords()
	end

	ActivityCollectWordsGetPanel.super.onClose(self)
end

return ActivityCollectWordsGetPanel
