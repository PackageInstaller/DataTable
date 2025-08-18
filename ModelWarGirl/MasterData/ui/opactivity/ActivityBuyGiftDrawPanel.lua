-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBuyGiftDrawPanel.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local UserData = require("Helper/UserData")
local strClassName = "RechargeLevelCell"
local RechargeLevelCell = Class(strClassName, UIControls.Child)

function RechargeLevelCell:ctor()
	self.btnGroupon = UIControls.Button(self, "BtnGroupon")

	self.btnGroupon:addEventClick(self.onBtnGrouponClick)

	self.iconNew = UIControls.Image(self, "BtnGroupon/IconNew")
	self.textGroupon = UIControls.Label(self, "BtnGroupon/TextGroupon")
	self.iconNml = UIControls.Image(self, "BtnGroupon/IconNml")
	self.iconSel = UIControls.Image(self, "BtnGroupon/IconSel")
end

function RechargeLevelCell:setData(data)
	self.data = data

	self.textGroupon:setText(self.data.price_title)
	self.btnGroupon:setEnable(self.mParent.curLevel ~= self.data.level_id)
	self.iconNew:setVisible(self.mParent.actObj.actData.showRedDotTab[self.data.level_id] == true and self.data.level_id ~= 1)

	if self.data.tab_icon_path then
		self.iconNml:setImage(self.data.tab_icon_path, self.data.tab_icon .. "Nml")
		self.iconSel:setImage(self.data.tab_icon_path, self.data.tab_icon .. "Sel")
	end
end

function RechargeLevelCell:onBtnGrouponClick()
	for i, cell in pairs(self.mParent.tabCells) do
		cell.btnGroupon:setEnable(true)
	end

	self.btnGroupon:setEnable(false)
	self.iconNew:setVisible(false)

	self.mParent.curLevel = self.data.level_id

	self.mParent:playMainInfoAni()
	self.mParent:refreshRedDot()
end

local strClassName = "GiftLevelDrawPage"
local GiftLevelDrawPage = Class(strClassName, UIControls.Child)
local DRAW_SHARE_CD = 60
local DRAW_LOG_CD = 120

function GiftLevelDrawPage:ctor()
	self.grouponAwardPanel = UIControls.Panel(self, "GrouponAwardPanel")
	self.btnShare = UIControls.Button(self, "GrouponAwardPanel/BtnShare")

	self.btnShare:addEventClick(self.onClickShare)

	self.emptyPanel = UIControls.Panel(self, "AwardPlayerPanel/EmptyPanel")
	self.btnDrawLog = UIControls.Button(self, "AwardPlayerPanel/BtnDrawLog")

	self.btnDrawLog:addEventClick(self.onBtnDrawLogClick)

	self.iconGear = UIControls.Image(self, "GrouponAwardPanel/BgTextTitle/Icon")
	self.textTitle = UIControls.Label(self, "GrouponAwardPanel/BgTextTitle/TextTitle")
	self.textGift = UIControls.Label(self, "GrouponAwardPanel/BgTextGift/TextGift")
	self.textHint = UIControls.Label(self, "GrouponAwardPanel/SliderPanel/BgTextHint/TextHint")
	self.expSlider = UIControls.Slider(self, "GrouponAwardPanel/SliderPanel/ExpSlider")
	self.expText = UIControls.Label(self, "GrouponAwardPanel/SliderPanel/ExpText")
	self.bgNotPartyIn = UIControls.Panel(self, "GrouponAwardPanel/PlayPartyInfoPanel/BgNotPartyIn")
	self.textNotHint = UIControls.Label(self, "GrouponAwardPanel/PlayPartyInfoPanel/BgNotPartyIn/TextHint")
	self.bgPartyIn = UIControls.Panel(self, "GrouponAwardPanel/PlayPartyInfoPanel/BgPartyIn")
	self.textInDec = UIControls.Label(self, "GrouponAwardPanel/PlayPartyInfoPanel/BgPartyIn/TextDec")
	self.bgValue = UIControls.Panel(self, "GrouponAwardPanel/BgValue")
	self.textValueNum = UIControls.Label(self, "GrouponAwardPanel/BgValue/Textnum")
	self.btnGo = UIControls.Button(self, "GrouponAwardPanel/PlayPartyInfoPanel/BtnGo")

	self.btnGo:addEventClick(self.onBtnGoClick)

	self.emptyPanel = UIControls.Panel(self, "AwardPlayerPanel/EmptyPanel")
	self.playerInfoPanel = UIControls.Panel(self, "AwardPlayerPanel/PlayerInfoPanel")
	self.textPlayerName = UIControls.Label(self, "AwardPlayerPanel/PlayerInfoPanel/TextPlayerName")
	self.textServer = UIControls.Label(self, "AwardPlayerPanel/PlayerInfoPanel/TextServer")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "AwardPlayerPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.aniSelf = UIControls.UIAni(self, "")
	self.grids = {}
end

function GiftLevelDrawPage:playPanelAni(aniName)
	self.aniSelf:startAni(aniName)
end

function GiftLevelDrawPage:setData()
	self.actData = self.mParent.actObj.actData
	self.curLevelId = self.mParent.curLevel

	self.grouponAwardPanel:playAnimator("GrouponInfoPanel0" .. self.curLevelId)

	self.data = self.mParent.detailData[self.curLevelId]
	self.curRound = 1
	self.buyTimes = 0
	self.lastRoundWinnerUid = ""

	for i, v in pairs(self.actData.giftDrawData or {}) do
		if v.level == self.curLevelId then
			self.curRound = v.cur_round
			self.buyTimes = v.cur_progress
			self.lastRoundWinnerUid = v.last_winner
		end
	end

	self.textTitle:setText(string.format(Lang.get(86795), self.data.price_title, self.curRound))

	if self.data.gear_icon_path then
		self.iconGear:setImage(self.data.gear_icon_path, self.data.gear_icon)
	end

	ClientUtils.CreateBonusGrid(self, self.grids, "GrouponAwardPanel/AwardList/Content", self.data.award_id, true, nil, true)
	self.textGift:setText(string.format(Lang.get(86796), self.data.price_level))
	self.textHint:setText(string.format(Lang.get(86797), self.data.draw_times - self.buyTimes))
	self.expSlider:setValue(self.buyTimes / self.data.draw_times)
	self.expText:setText(string.format("%d/%d", self.buyTimes, self.data.draw_times))

	if self.data.max_value then
		self.textValueNum:setText(self.data.max_value .. "%")
		self.bgValue:setVisible(true)
	end

	self.curSelfBuyRound = 1
	self.curSelfBuyCount = 0

	for i, v in pairs(self.actData.selfBuyData or {}) do
		if v.level == self.curLevelId then
			self.curSelfBuyRound = v.buy_round or 1
			self.curSelfBuyCount = v.buy_count or 0
		end
	end

	if self.curRound == self.curSelfBuyRound and self.curSelfBuyCount > 0 then
		self.bgNotPartyIn:setVisible(false)
		self.bgPartyIn:setVisible(true)

		local percent = string.format("%0.2f%%", self.curSelfBuyCount / self.data.draw_times * 100)

		self.textInDec:setText(string.format(Lang.get(86798), self.curSelfBuyCount, percent))
	else
		self.bgNotPartyIn:setVisible(true)
		self.bgPartyIn:setVisible(false)
		self.textNotHint:setText(Lang.get(86799))
	end

	self.emptyPanel:setVisible(self.curRound == 1)
	self.playerInfoPanel:setVisible(self.curRound > 1)

	if self.curRound > 1 then
		CurAvatar:getRoleCommInfosNoTip({
			self.lastRoundWinnerUid
		}, Slot(self.setWinnerInfoPanel, self))
	end

	if self.mParent.actObj:inFreeze() then
		self.textHint:setText(Lang.get(32793))
		self.textInDec:setText(Lang.get(32793))
		self.textNotHint:setText(Lang.get(32793))
	end
end

function GiftLevelDrawPage:setWinnerInfoPanel()
	local winnerInfo = CurAvatar:getRoleInfoByUid(self.lastRoundWinnerUid)

	if winnerInfo then
		local commonInfo = winnerInfo.commInfo
		local strName = utils.GetPlayerName(commonInfo.name)

		self.btnHead:setCommInfo(commonInfo, false, self)
		self.btnHead:hideLevel()
		self.textPlayerName:setText(strName)
		self.textServer:setText(commonInfo.serverName)
		self.textPlayerName:setVisible(true)
		self.textServer:setVisible(true)
		self.btnHead:setVisible(true)
	else
		self.textPlayerName:setVisible(false)
		self.textServer:setVisible(false)
	end
end

function GiftLevelDrawPage:checkLastRoundMyWinShow()
	if self.lastRoundWinnerUid == CurAvatar.uid then
		local showStr = UserData.loadCommonData(self.mParent.actObj.startTime .. "GiftDrawWinShow" .. CurAvatar.uid)
		local showTable = {}

		if showStr then
			showTable = ClientUtils.string2Table(showStr)
		end

		if showTable[self.curLevelId] == nil then
			showTable[self.curLevelId] = {}
		end

		if not utils.tableIsContainsElement(showTable[self.curLevelId], self.curRound - 1) then
			table.insert(showTable[self.curLevelId], self.curRound - 1)
			UserData.saveCommonData(self.mParent.actObj.startTime .. "GiftDrawWinShow" .. CurAvatar.uid, ClientUtils.table2String(showTable))
			self:showAwardPanel()
		end
	end
end

function GiftLevelDrawPage:showAwardPanel()
	UIManager.getUI("activityGiftDrawWinnerDlg", true):setData(self.data, self.curRound)
end

function GiftLevelDrawPage:onClickShare()
	if self.mParent.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	else
		local msgContent = Lang.get(86800)

		local function yesFunc(...)
			RPC.giftDrawGiftShare(self.mParent.actObj.opId, self.curLevelId)
		end

		local function noFunc(...)
			return
		end

		local curTime = ClientUtils.getServerTime()
		local timeDelta = curTime - self.mParent.actObj.actData.lastShareTime

		if timeDelta >= DRAW_SHARE_CD then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, noFunc)
		else
			MsgManager.notice(string.format(Lang.get(86997), DRAW_SHARE_CD - timeDelta))
		end
	end
end

function GiftLevelDrawPage:onBtnDrawLogClick()
	if self.actData.drawLogTime and ClientUtils.getServerTime() - self.actData.drawLogTime < DRAW_LOG_CD then
		if self.actData.drawLogRecordList then
			local activityBuyGiftDrawLogDlg = UIManager.getUI("activityBuyGiftDrawLogDlg", nil, false)

			if activityBuyGiftDrawLogDlg then
				activityBuyGiftDrawLogDlg:setData(self.mParent.actObj, self.curLevelId, self.actData.drawLogRecordList)
			else
				UIManager.getUI("activityBuyGiftDrawLogDlg", true):setData(self.mParent.actObj, self.curLevelId, self.actData.drawLogRecordList)
			end
		end
	else
		CurAvatar.curGiftDrawLogLevelId = self.curLevelId

		RPC.giftDrawWinnersListGet(self.mParent.actObj.opId, self.curLevelId)
	end
end

function GiftLevelDrawPage:onBtnGoClick()
	if self.mParent.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	else
		local jumpId = self.actData.miscTableData.jump_id

		if jumpId then
			JumpGuideManager.jump(jumpId)
		end
	end
end

local strClassName = "ActivityBuyGiftDrawPanel"
local ActivityBuyGiftDrawPanel = Class(strClassName, UIControls.Child)

MixinClass(ActivityBuyGiftDrawPanel, ActivityPanelMixin)

function ActivityBuyGiftDrawPanel:ctor()
	return
end

function ActivityBuyGiftDrawPanel:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.mainPanelAni = UIControls.UIAni(self, "MainInfoPanel")

	self.mainPanelAni:addEventFinish(self.aniFinish)

	self.tabCells = {}
	self.curLevel = 1
	self.freezePanel = UIControls.Panel(self, "FreezePanel")
end

function ActivityBuyGiftDrawPanel:_onShow()
	self:refreshRedDot()

	if self:getVisible() and self.giftLevelDrawPanel then
		self.giftLevelDrawPanel:checkLastRoundMyWinShow()
	end
end

function ActivityBuyGiftDrawPanel:_setData()
	RPC.opActivityData("kOpActivitySyncMgrData", 0, self.actObj.opId)

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.panelPath = self.replaceableCellPath[1]
	else
		self.panelPath = "ActivityGroupon01"
	end

	self.actId = self.actObj.actId
	self.actData = self.actObj.actData
	self.detailData = self.actObj.actData.detailData or {}

	for i, v in ipairs(self.detailData) do
		local tab = self.tabCells[i]

		if tab == nil then
			tab = RechargeLevelCell(self, "TabList/Content", "System/Activity/ActivityGroupon/" .. self.panelPath .. "/GrouponTab", 0, 0, true)
		end

		tab:setData(v)

		self.tabCells[i] = tab
	end

	if self.giftLevelDrawPanel == nil then
		self.giftLevelDrawPanel = GiftLevelDrawPage(self, "MainInfoPanel", "System/Activity/ActivityGroupon/" .. self.panelPath .. "/ActivityGrouponInfoPanel", 0, 0, true)
	end

	self:refreshUI()
end

function ActivityBuyGiftDrawPanel:refreshUI()
	if self.actObj:inFreeze() then
		self.freezePanel:setVisible(true)
	else
		self.freezePanel:setVisible(false)
	end

	self.giftLevelDrawPanel:setData()
end

function ActivityBuyGiftDrawPanel:playMainInfoAni()
	self.mainPanelAni:startAni("HideActivityGrouponMainPanel")
end

function ActivityBuyGiftDrawPanel:playSpecialShow(args)
	local level = args[1]

	if self.curLevel == level then
		self.mainPanelAni:startAni("ResetActivityGrouponMainPanel")
	end
end

function ActivityBuyGiftDrawPanel:aniFinish(animCon, animName)
	if animName == "HideActivityGrouponMainPanel" then
		self:refreshUI()
		self.giftLevelDrawPanel:checkLastRoundMyWinShow()
		self.mainPanelAni:startAni("ShowActivityGrouponMainPanel")
		self.giftLevelDrawPanel:playPanelAni("ShowActivityGrouponInfoPanel")
	end
end

function ActivityBuyGiftDrawPanel:refreshRedDot()
	if self:getVisible() then
		self.actData.showRedDotTab[self.curLevel] = nil

		self.actObj:checkNew()
	end
end

function ActivityBuyGiftDrawPanel:jumpToLevelTab(level)
	self.curLevel = level

	self:refreshUI()
end

function ActivityBuyGiftDrawPanel:_onClosePanel()
	return
end

return ActivityBuyGiftDrawPanel
