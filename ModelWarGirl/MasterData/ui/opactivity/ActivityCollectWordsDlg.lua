-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResOpActivityCollectWordsMisc = require("ClientData/ResOpActivityCollectWordsMisc")
local ResActivityPlayNodeConfig = require("ClientData/ResActivityPlayNodeConfig")
local ChildCollectWordsAwardCell = Class("ChildCollectWordsAwardCell", UIControls.Child)
local AWARD_USE_SPECIAL_GRID_ID = 31

function ChildCollectWordsAwardCell:ctor()
	self:initUI()

	self.tipsFuncItem = UIControls.TipsConfig()

	self.tipsFuncItem:addConfig(self, Lang.get(588), self.onUseItem, nil, nil, 1)
end

function ChildCollectWordsAwardCell:initUI()
	self.unLockPanel = UIControls.Panel(self, "UnLockPanel")
	self.iconNewRed = UIControls.RedDot(self, "UnLockPanel/IconNews")
	self.lockPanel = UIControls.Panel(self, "LockPanel")
	self.textNum = UIControls.Label(self, "TextNum")
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)
end

function ChildCollectWordsAwardCell:setData(data)
	self.data = data
	self.unLock = data.unLock
	self.type = data.type
	self.opId = self.mParent.actObj.opId
	self.actData = self.mParent.actObj.actData

	self.textNum:setText(data.itemNum)

	if data.unLock then
		self.itemGridPath = "UnLockPanel/GridPanel"

		self.unLockPanel:setVisible(true)
		self.lockPanel:setVisible(false)
	else
		self.itemGridPath = "LockPanel/GridPanel"

		self.unLockPanel:setVisible(false)
		self.lockPanel:setVisible(true)
	end

	if self.type == "random" then
		local isShowRedIcon = CurAvatar:getItemNumById(self.actData.randomPropsID) > 0 and not self.actData:checkQueueRedNew() and not self.actData:checkFriendSendRedNew()

		self.iconNewRed:setVisible(isShowRedIcon)
	else
		self.iconNewRed:setVisible(false)
	end

	self.gridItem = UIControls.getGridAwardContainer(self, self.itemGridPath)

	self.gridItem:setVisible(true)

	self.gridItem.mEnableTips = false

	self.gridItem:setContainerConfig(AWARD_USE_SPECIAL_GRID_ID)

	local fakeItem = BaseObject.GetObject(data.itemId, data.itemNum)

	self.gridItem:setObj(fakeItem)
	self.gridItem:hideTxtNum(true)
end

function ChildCollectWordsAwardCell:onSensorClick()
	local fakeItem = BaseObject.GetObject(self.data.itemId, self.data.itemNum)

	UIManager.getUI("itemTips"):showObj(self, fakeItem, nil, self.tipsFuncItem)
end

function ChildCollectWordsAwardCell:onUseItem()
	if self.type == "random" then
		local function sendRPC(list)
			CurAvatar:activityRPC(Functor(RPC.opActCollectWordsUseItem, self.opId, list.data.id, list.data.num), self.opId)
		end

		UIManager.getUI("openItemConfirmDlg", true):onShow(self.gridItem.object, sendRPC, true)
	elseif self.unLock then
		local function sendRPC(list)
			local num = 0
			local param = {}

			for i, v in ipairs(list or {}) do
				num = num + v.data.num

				if v.data.num > 1 then
					for j = 1, v.data.num do
						table.insert(param, v.param)
					end
				else
					table.insert(param, v.param)
				end
			end

			local chooseDlg = UIManager.tryGetUI("openBoxChooseDlg")

			if chooseDlg then
				chooseDlg:setVisible(false)
			end

			CurAvatar:activityRPC(Functor(RPC.opActCollectWordsUseItem, self.opId, self.data.itemId, num, param), self.opId)
		end

		UIManager.getUI("openBoxChooseDlg", true):openChoose(self.gridItem.object, sendRPC, true, self.actData.wordsBag)
	else
		MsgManager.clientNotice(648)
	end
end

local strClassName = "ActivityCollectWordsDlg"
local ActivityCollectWordsDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityCollectWordsDlg, ActivityPanelMixin)

local PRIVILEGE_SPECIAL_GRID_ID = 30

function ActivityCollectWordsDlg:ctor()
	self.isMergeing = false
end

function ActivityCollectWordsDlg:initUI()
	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/ChildCollectWordsAward"
	else
		self.cellPath = "System/Activity/CollectWords/ChildCollectWordsAward"
	end

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.repAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
	else
		self.repAtlas = "Atlas/ActivityAtlas/CollectWordsAtlas/CollectWordsAtlas13"
	end

	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.panelAwardUse = UIControls.Panel(self, "MainInfoPanel/AwardUsePanel")
	self.panelGridPrivilege = UIControls.Panel(self, "MainInfoPanel/GridPrivilegePanel")
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnGetWords = UIControls.Button(self, "MainInfoPanel/BtnGetWords")

	self.btnGetWords:addEventClick(self.onGetWordsClick)

	self.btnTask = UIControls.Button(self, "MainInfoPanel/BtnTask")

	self.btnTask:addEventClick(self.onTaskClick)

	self.iconNewTask = UIControls.RedDot(self, "MainInfoPanel/BtnTask/IconNew")
	self.btnAchieve = UIControls.Button(self, "MainInfoPanel/BtnPointTask")

	self.btnAchieve:addEventClick(self.onAchieveClick)

	self.btnAvg = UIControls.Button(self, "MainInfoPanel/BtnAVG")

	self.btnAvg:addEventClick(self.onBtnAvgClick)

	self.btnFriend = UIControls.Button(self, "MainInfoPanel/BtnFriend")

	self.btnFriend:addEventClick(Functor(self.setSendPanelState, self, "HideMainInfoPanel"))

	self.textSendFriend = UIControls.Label(self, "MainInfoPanel/BtnFriend/TextSendState")
	self.textTitleFriend = UIControls.Label(self, "MainInfoPanel/BtnFriend/TextTitle")
	self.iconNewSendRed = UIControls.Panel(self, "MainInfoPanel/BtnFriend/IconNew")
	self.textNumSendAward = UIControls.Label(self, "MainInfoPanel/SendAwardPanel/TextNum")
	self.btnBack = UIControls.Button(self, "BtnBack")

	self.btnBack:addEventClick(Functor(self.setSendPanelState, self, "ShowMainInfoPanel"))

	self.textBagNum = UIControls.Label(self, "MainInfoPanel/BagNumPanel/TextNum")
	self.iconNewDrop = UIControls.Image(self, "MainInfoPanel/BtnGetWords/IconNewDrop")
	self.iconNewFriend = UIControls.Panel(self, "MainInfoPanel/BtnGetWords/IconNewFriend")
	self.iconNewAchi = UIControls.Image(self, "MainInfoPanel/BtnPointTask/IconNew")
	self.iconDropMax = UIControls.Panel(self, "MainInfoPanel/BtnGetWords/IconDropMax")
	self.bgAward = UIControls.Panel(self, "MainInfoPanel/BtnPointTask/BgAward")
	self.bgNone = UIControls.Panel(self, "MainInfoPanel/BtnPointTask/BgNone")
	self.scoreNum = UIControls.Label(self, "MainInfoPanel/BtnPointTask/NumPanel/TextNum")
	self.scoreIcon = UIControls.Image(self, "MainInfoPanel/BtnPointTask/NumPanel/Icon")
	self.animInfoPanel = UIControls.UIAni(self, "MainInfoPanel")
	self.btnWords = {}
	self.textWords = {}

	for i = 1, 5 do
		local btn_word = UIControls.Button(self, "MainInfoPanel/BagPanel/BtnWord" .. i)

		btn_word:addEventClick(Functor(self.selectWord, self, i))

		local txt_word = UIControls.Label(self, "MainInfoPanel/BagPanel/BtnWord" .. i .. "/NmlPanel/TextNml")
		local nmlPanel = UIControls.Panel(self, "MainInfoPanel/BagPanel/BtnWord" .. i .. "/NmlPanel")
		local disPanel = UIControls.Panel(self, "MainInfoPanel/BagPanel/BtnWord" .. i .. "/DisPanel")
		local btnSend = UIControls.Button(self, "MainInfoPanel/BagPanel/BgWord" .. i .. "/BtnSend")
		local imgGift = UIControls.Image(self, "MainInfoPanel/BagPanel/BgWord" .. i .. "/BtnSend/ImgGift")

		btnSend:addEventClick(Functor(self.btnSendClick, self, i))
		table.insert(self.btnWords, {
			btn = btn_word,
			txt = txt_word,
			nmlPanel = nmlPanel,
			disPanel = disPanel,
			imgGift = imgGift
		})
	end

	self.bgPrivilegeList = {}

	for i = 1, 5 do
		local bg = UIControls.Panel(self, "MainInfoPanel/BgPrivilegePanel/Bg" .. i)

		table.insert(self.bgPrivilegeList, bg)
	end
end

function ActivityCollectWordsDlg:onOpen()
	ActivityCollectWordsDlg.super.onOpen(self)
end

function ActivityCollectWordsDlg:onOpenOver()
	self.mOpening = false

	self:onVisibleChanged(true)

	if not self.inAVG then
		BeginnerManager.onTriggerCanvasOpen(self.mPrefabKey)
	end
end

function ActivityCollectWordsDlg:AVGEndCallback()
	if not self.inAVG then
		return
	end

	self.inAVG = false
end

function ActivityCollectWordsDlg:_setData()
	self.miscData = self.actObj.actData.miscData or ResOpActivityCollectWordsMisc[2601]

	if self.actObj:isNewOpened() and not self.initedAVG and self.miscData.enter_avg then
		local avg_id = ResActivityPlayNodeConfig[self.miscData.enter_avg].avg_id

		UIManager.playAVG(avg_id, nil, Slot(self.AVGEndCallback, self))

		self.inAVG = true
		self.initedAVG = true
	end

	if not self.isInited then
		self:checkMergeWords()

		if self.actObj:inFreeze() then
			-- block empty
		else
			CurAvatar:activityRPC(Functor(RPC.opActCollectWordsRefreshDeposit, self.actObj.opId), self.actObj.opId)
		end

		self:checkFriendName()
	end

	self.actId = self.actObj.actId

	local actData = self.actObj.actData

	self.actData = actData
	self.wordsBag = actData.wordsBag
	self.wordsQueue = actData.wordsQueue
	self.privilegeList = actData.privilegeList

	local actObj = CurAvatar:getActivityObj(self.miscData.task_achieve_id)

	if actObj then
		self.iconNewTask:addHint({
			actObj.redDotId
		})
		CurAvatar:addActivityRelated(actObj.actId, "activityCollectWordsDlg", self.actId)

		if actObj.templateData.relate_act then
			local achieves = actObj.templateData.relate_act

			for key, value in pairs(achieves) do
				CurAvatar:addActivityRelated(value, "activityCollectWordsDlg", self.actId)
			end
		end
	end

	self.totalNum = 0
	self.totalQueueNum = 0

	for i = 1, 5 do
		if self.wordsBag[i] and self.wordsBag[i].num > 0 then
			self.btnWords[i].nmlPanel:setVisible(true)
			self.btnWords[i].disPanel:setVisible(false)
			self.btnWords[i].txt:setText(self.wordsBag[i].num)
			self.btnWords[i].imgGift:setImage(self.repAtlas, "BtnSendGift")

			self.totalNum = self.totalNum + self.wordsBag[i].num
		else
			self.btnWords[i].nmlPanel:setVisible(false)
			self.btnWords[i].disPanel:setVisible(true)
			self.btnWords[i].imgGift:setImage(self.repAtlas, "BtnSendGiftN")
		end

		if self.wordsQueue[i] and self.wordsQueue[i].num > 0 then
			self.totalQueueNum = self.totalQueueNum + self.wordsQueue[i].num
		end
	end

	self.textBagNum:setText(string.format("<color=#eea451>%d</color>/%d", self.totalNum, self.actData.bagLimit))

	local sendNum = utils.getTableElemCount(self.actData.sendFriendsList)
	local titleDes = Lang.get(61205)
	local sendStateDes = Lang.get(61556)
	local sendMaxCount = self.miscData.got_max_count or 3
	local isFinish = sendMaxCount <= sendNum

	if isFinish then
		sendNum = sendMaxCount
	end

	local progress = sendNum .. "/" .. sendMaxCount

	sendStateDes = isFinish and sendStateDes or string.format(Lang.get(61557), progress)

	if not self.actObj:inFreeze() then
		local isShowSendRedIcon = not isFinish and self.totalNum > 0

		self.iconNewSendRed:setVisible(isShowSendRedIcon)
	else
		self.iconNewSendRed:setVisible(false)
	end

	self.textTitleFriend:setText(titleDes)
	self.textSendFriend:setText(sendStateDes)
	self.textNumSendAward:setText(progress)

	for i, grid in ipairs(self.awardGrids or {}) do
		grid:destroy()
	end

	self.awardGrids = {}

	local randId = self.miscData.giving_award
	local resRandData = ResRandClient[randId]

	if randId and resRandData then
		for i, itemId in ipairs(resRandData.show_ids) do
			local itemNum = resRandData.show_nums[i]
			local fakeItem = BaseObject.GetObject(itemId, itemNum)
			local grid = UIControls.getGridChild(fakeItem, self, "MainInfoPanel/SendAwardPanel/GridAward")

			grid:setVisible(true)

			grid.mDisableWays = true

			grid:setObj(fakeItem)

			if isFinish then
				grid:setObjGray(true)
			end

			self.awardGrids[i] = grid
		end
	end

	for i, cell in pairs(self.childAwardCell or {}) do
		cell:destroy()
	end

	self.childAwardCell = {}

	for i, itemId in ipairs(self.privilegeList or {}) do
		self.childAwardCell[i] = UIControls.getGridAwardContainer(self, "MainInfoPanel/GridPrivilegePanel")

		self.childAwardCell[i]:setVisible(true)

		self.childAwardCell[i].mEnableTips = false

		self.childAwardCell[i]:setContainerConfig(PRIVILEGE_SPECIAL_GRID_ID)

		local fakeItem = BaseObject.GetObject(itemId)

		self.childAwardCell[i]:setObj(fakeItem)
		self.childAwardCell[i]:hideTxtNum(true)
	end

	for i = 1, 5 do
		if i <= #self.privilegeList then
			self.bgPrivilegeList[i]:setVisible(true)
		else
			self.bgPrivilegeList[i]:setVisible(false)
		end
	end

	if self.randomPropsCell then
		self.randomPropsCell:destroy()
	end

	if self.orientationPropsCell then
		self.orientationPropsCell:destroy()
	end

	self.randomPropsNum = CurAvatar:getItemNumById(self.actObj.actData.randomPropsID)
	self.orientationPropsNum = CurAvatar:getItemNumById(self.actObj.actData.orientationPropsID)

	if self.randomPropsNum > 0 then
		self.randomPropsCell = ChildCollectWordsAwardCell(self, "MainInfoPanel/AwardUsePanel", self.cellPath)

		local data = {}

		data.itemId = self.actObj.actData.randomPropsID
		data.itemNum = self.randomPropsNum
		data.type = "random"
		data.unLock = true

		self.randomPropsCell:setData(data)
		self.randomPropsCell:setVisible(true)
	end

	if self.orientationPropsNum > 0 then
		self.orientationPropsCell = ChildCollectWordsAwardCell(self, "MainInfoPanel/AwardUsePanel", self.cellPath)

		local data = {}

		data.itemId = self.actObj.actData.orientationPropsID
		data.itemNum = self.orientationPropsNum
		data.type = "orientation"
		data.unLock = self.actObj.actData.isWordUnLock

		self.orientationPropsCell:setData(data)
		self.orientationPropsCell:setVisible(true)
	end

	local iconPath = BaseObject.getItemIconPath(self.miscData.score_item_id or 510292)

	if iconPath then
		self.scoreIcon:setImage(iconPath[1], iconPath[2])
	end

	self:setNextHighAward()

	self.actObj.actData.skipCheckItemNew = true

	self:checkRedNew()

	self.isInited = true
end

function ActivityCollectWordsDlg:checkFriendName()
	local uids = {}

	for i, data in pairs(self.actObj.actData.friendSendRecords or {}) do
		if not CurAvatar.friendList[data.uid] then
			table.insert(uids, data.uid)
		end
	end

	if #uids > 0 then
		CurAvatar:getRoleCommInfosNoTip(uids, Slot(self.getFriendInfoCB, self))
	end
end

function ActivityCollectWordsDlg:getFriendInfoCB(infos)
	self.actObj.actData.otherPlayerInfo = {}

	for i, info in pairs(infos) do
		local uid = info.commInfo.uid
		local name = info.commInfo.name

		self.actObj.actData.otherPlayerInfo[uid] = name
	end
end

function ActivityCollectWordsDlg:checkRedNew()
	if self.actData:checkQueueRedNew() then
		self.jumpFriendSendPage = false

		self.iconNewDrop:setVisible(true)
		self.iconNewFriend:setVisible(false)
	elseif self.actData:checkFriendSendRedNew() then
		self.jumpFriendSendPage = true

		self.iconNewDrop:setVisible(false)
		self.iconNewFriend:setVisible(true)
	else
		self.jumpFriendSendPage = false

		self.iconNewDrop:setVisible(false)
		self.iconNewFriend:setVisible(false)
	end

	self.iconNewAchi:setVisible(self.actData:checkAchiRedNew() == true)
	self.iconDropMax:setVisible(self.totalQueueNum >= self.actObj.actData.hangUpMaxNum)
	self.actObj:checkNew()
end

function ActivityCollectWordsDlg:setNextHighAward()
	for i, grid in pairs(self.specialAwardGridList or {}) do
		grid:destroy()
	end

	self.specialAwardGridList = {}

	local achieve_actObj = CurAvatar:getActivityObj(self.miscData.achieve_id)

	if achieve_actObj and achieve_actObj:isValid() then
		self.nextHighAward = nil

		local svrData

		for _, sData in pairs(achieve_actObj.actData.serverData) do
			svrData = sData
		end

		local nowProcess = svrData and svrData.progress or 0

		self.scoreNum:setText(nowProcess)

		for actType, cData in pairs(achieve_actObj.actData.clientData) do
			for _, data in ipairs(cData) do
				if nowProcess < data.param and data.high_award then
					self.nextHighAward = data.award

					break
				end
			end
		end

		if self.nextHighAward then
			self.bgAward:setVisible(true)
			self.bgNone:setVisible(false)

			for i, itemId in ipairs(ResRandClient[self.nextHighAward].show_ids or {}) do
				local itemNum = ResRandClient[self.nextHighAward].show_nums[i]
				local fakeItem = BaseObject.GetObject(itemId, itemNum)
				local grid = UIControls.getGridAwardContainer(self, "MainInfoPanel/BtnPointTask/AwardPreviewPanel/GridPanel")

				grid.mDisableWays = true

				grid:setObj(fakeItem)
				grid:setVisible(true)
				grid:setSpecEffect("Effects/UI/efx_ui_bingoGrid.prefab", "System/Task/GridEfxCellNoMask")

				self.specialAwardGridList[i] = grid
			end
		else
			self.bgAward:setVisible(false)
			self.bgNone:setVisible(true)
		end
	end
end

function ActivityCollectWordsDlg:checkPlayAVG()
	if self.isMergeing then
		local avgInfo = self.miscData.avg
		local mergeTimes = self.actObj.actData.mergeWordsTimes or 0
		local needPlayAvg = {}

		for i, info in ipairs(self.miscData.avg or {}) do
			if self.mergeTimes and mergeTimes > info.param and (mergeTimes == self.mergeTimes or mergeTimes - self.mergeTimes < info.param) or info.param == mergeTimes then
				local avg_id = ResActivityPlayNodeConfig[info.id].avg_id

				table.insert(needPlayAvg, avg_id)
			end
		end

		self:playAVGAndSendMsg(needPlayAvg)

		self.isMergeing = false
	end
end

function ActivityCollectWordsDlg:playAVGAndSendMsg(avgTable)
	local needPlayAvg = avgTable

	if #needPlayAvg > 0 then
		local avgNum = #needPlayAvg
		local avgId = needPlayAvg[1]

		table.remove(needPlayAvg, 1)

		if needPlayAvg[1] then
			UIManager.playAVG(avgId, nil, Functor(self.playAVGAndSendMsg, self, needPlayAvg), true)
		else
			UIManager.playAVG(avgId)
		end
	end
end

function ActivityCollectWordsDlg:checkMergeWords()
	local isCanMerge, times = self.actObj.actData:checkMergeWords()

	if isCanMerge then
		self.isMergeing = true
		self.mergeTimes = times

		CurAvatar:activityRPC(Functor(RPC.opActCollectWordsComposeWord, self.actObj.opId, times), self.actObj.opId)
	end
end

function ActivityCollectWordsDlg:_onShow()
	return
end

function ActivityCollectWordsDlg:updateActivityData()
	self:_setData()

	local getPanel = UIManager.tryGetUI("activityCollectWordsGetPanel")

	if getPanel then
		getPanel:refreshData()
	end

	local chooseDlg = UIManager.tryGetUI("activityCollectWordsChooseDlg")

	if chooseDlg then
		chooseDlg:updateActivityData()
	end

	local useDlg = UIManager.tryGetUI("activityCollectWordsUseDlg")

	if useDlg then
		useDlg:updateActivityData()
	end
end

function ActivityCollectWordsDlg:updateRelatedActivityData()
	self:_setData()
end

function ActivityCollectWordsDlg:onComposeWords(times)
	UIManager.getUI("activityCollectWordsComposeDlg", true):setData(times)
end

function ActivityCollectWordsDlg:onTaskClick()
	local actObj = CurAvatar:getActivityObj(self.miscData.task_achieve_id)

	if actObj and actObj:isValid() then
		CurAvatar:jumpToShowActivity(actObj.actId)
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivityCollectWordsDlg:onAchieveClick()
	local actObj = CurAvatar:getActivityObj(self.miscData.achieve_id)

	if actObj and actObj:isValid() then
		CurAvatar:addActivityRelated(actObj.actId, "activityCollectWordsAchieveDlg")

		local achieveDlg = UIManager.getUI("activityCollectWordsAchieveDlg", true)

		achieveDlg:setParentActivity(self.actObj)
		achieveDlg:onShowActivity({
			actObj.clientTemplateData,
			actObj
		})
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivityCollectWordsDlg:selectWord(index)
	if self.wordsBag[index] and self.wordsBag[index].num > 0 then
		UIManager.getUI("activityCollectWordsChooseDlg", true):setData(self.actObj, index)
	else
		MsgManager.clientNotice(647)
	end
end

function ActivityCollectWordsDlg:btnSendClick(index)
	if self.wordsBag[index] and self.wordsBag[index].num > 0 then
		UIManager.getUI("activityCollectWordsUseDlg", true):setData(self.actObj, index)
	else
		MsgManager.notice(Lang.get(61558))
	end
end

function ActivityCollectWordsDlg:onGetWordsClick()
	self:playAni("ShowActivityCollectWordsGet")
	UIManager.getUI("activityCollectWordsGetPanel", true):setData(self.actObj, self.jumpFriendSendPage)
end

function ActivityCollectWordsDlg:onBtnAvgClick()
	local avgInfo = {
		{
			param = 0,
			lock_desc = "",
			id = self.miscData.enter_avg
		}
	}

	for i, avg in ipairs(self.miscData.avg or {}) do
		table.insert(avgInfo, avg)
	end

	local mergeTimes = self.actObj.actData.mergeWordsTimes or 0

	UIManager.getUI("activityCollectWordsAVGPreviewDlg", true):setData(avgInfo, mergeTimes, self.actObj)
end

function ActivityCollectWordsDlg:setSendPanelState(animName)
	self.animInfoPanel:startAni(animName, true)

	local isShowMain = animName == "ShowMainInfoPanel"

	self.btnClose:setVisible(isShowMain)
	self.btnBack:setVisible(not isShowMain)
end

function ActivityCollectWordsDlg:onCloseClick()
	self:setVisible(false)
end

function ActivityCollectWordsDlg:destroy()
	ActivityCollectWordsDlg.super.destroy(self)
end

return ActivityCollectWordsDlg
