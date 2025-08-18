-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBuyGiftDrawLogDlg.lua

local strClassName = "RechargeLogLevelCell"
local RechargeLogLevelCell = Class(strClassName, UIControls.Child)

function RechargeLogLevelCell:ctor()
	self.btnGroupon = UIControls.Button(self, "BtnGroupon")

	self.btnGroupon:addEventClick(self.onBtnGrouponClick)

	self.textGroupon = UIControls.Label(self, "BtnGroupon/TextGroupon")
end

function RechargeLogLevelCell:setData(data)
	self.data = data

	self.textGroupon:setText(self.data.price_title)
	self.btnGroupon:setEnable(self.mParent.levelId ~= self.data.level_id)
end

function RechargeLogLevelCell:onBtnGrouponClick()
	for i, cell in pairs(self.mParent.tabCells) do
		cell.btnGroupon:setEnable(true)
	end

	self.btnGroupon:setEnable(false)

	self.mParent.levelId = self.data.level_id

	self.mParent:refreshDrawLogPanel()
end

local strClassName = "DrawLogCell"
local DrawLogCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function DrawLogCell:ctor()
	self.textRound = UIControls.Label(self, "TextRound")
	self.textPlayerName = UIControls.Label(self, "TextPlayerName")
	self.textServer = UIControls.Label(self, "TextServer")
	self.textTime = UIControls.Label(self, "TextTime")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.bg = UIControls.Image(self, "Bg")
	self.bgMark = UIControls.Panel(self, "BgMark")
end

function DrawLogCell:setData(data)
	self.data = data

	self.textRound:setText(string.format(Lang.get(86792), self.data.round))

	local timeStr = ClientUtils.getServerTimeData(self.data.time, "%Y-%m-%d %H:%M:%S")

	self.textTime:setText(string.format(Lang.get(86996), timeStr))

	if self.mParent.levelBuyRoundData[self.data.round] then
		self.bg:setImage("Atlas/ActivityAtlas/ActivityGrouponAtlas/ActivityGrouponCommonAtlas", "BgWinTable01")
		self.bgMark:setVisible(true)
	else
		self.bg:setImage("Atlas/ActivityAtlas/ActivityGrouponAtlas/ActivityGrouponCommonAtlas", "BgWinTable02")
		self.bgMark:setVisible(false)
	end

	local winnerInfo = CurAvatar:getRoleInfoByUid(self.data.uid)

	if winnerInfo then
		local commonInfo = winnerInfo.commInfo
		local strName = utils.GetPlayerName(commonInfo.name)

		self.btnHead:setCommInfo(commonInfo, false, self)
		self.btnHead:hideLevel()
		self.textPlayerName:setText(strName)
		self.textServer:setText(commonInfo.serverName)
	end
end

local strClassName = "GiftLevelDrawLogPanel"
local GiftLevelDrawLogPanel = Class(strClassName, UIControls.Child)

function GiftLevelDrawLogPanel:ctor()
	self.drawLogListScroll = UIControls.ScrollViewLoopV(self, "DrawLogListPanel")

	self.drawLogListScroll:addEventCellChanged(self.onCellChanged)

	self.drawLogListPanel = UIControls.Panel(self, "DrawLogListPanel")
	self.emptyPanel = UIControls.Panel(self, "EmptyPanel")
	self.cells = {}
	self.checkPlayerLevels = {}
end

function GiftLevelDrawLogPanel:setData()
	self.winnerList = {}
	self.buyRoundDatas = self.mParent.actObj.actData.buyRoundDatas or {}
	self.levelBuyRoundData = self.buyRoundDatas[self.mParent.levelId] or {}

	for i, v in pairs(self.mParent.levelList or {}) do
		if v.level == self.mParent.levelId then
			self.winnerList = v.winner
		end
	end

	if #self.winnerList > 0 then
		if self.checkPlayerLevels[self.mParent.levelId] == nil then
			local winnerUids = {}

			for i, v in pairs(self.winnerList) do
				table.insert(winnerUids, v.uid)
			end

			CurAvatar:getRoleCommInfosNoTip(winnerUids)

			self.checkPlayerLevels[self.mParent.levelId] = true
		end

		table.sort(self.winnerList, function(a, b)
			return a.round > b.round
		end)
		self.drawLogListScroll:setTotalCount(#self.winnerList)
		self.drawLogListPanel:setVisible(true)
		self.emptyPanel:setVisible(false)
	else
		self.drawLogListPanel:setVisible(false)
		self.emptyPanel:setVisible(true)
	end
end

function GiftLevelDrawLogPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = DrawLogCell(sender, "System/Activity/ActivityGroupon/GrouponDrawLogCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.winnerList[newIdx])
	targetCell:setVisible(true)
end

local strClassName = "ActivityBuyGiftDrawLogDlg"
local ActivityBuyGiftDrawLogDlg = Class(strClassName, UIControls.Window)

function ActivityBuyGiftDrawLogDlg:ctor()
	self:initUI()
end

function ActivityBuyGiftDrawLogDlg:initUI()
	self.btnRule = UIControls.Button(self, "DrawLogPanel/BgPanel/RulePanel/BtnRule")

	self.btnRule:addEventClick(self.onBtnRuleClick)

	self.upArrow = UIControls.Image(self, "DrawLogPanel/BgPanel/RulePanel/BtnRule/ImgUp")
	self.downArrow = UIControls.Image(self, "DrawLogPanel/BgPanel/RulePanel/BtnRule/ImgDown")
	self.textRuleDes = UIControls.Panel(self, "DrawLogPanel/BgPanel/RulePanel/TextRuleDes")
	self.tabCells = {}
end

function ActivityBuyGiftDrawLogDlg:setData(actObj, level, level_list)
	self.actObj = actObj
	self.levelList = level_list
	self.levelId = level
	self.detailData = self.actObj.actData.detailData or {}

	for i, v in ipairs(self.detailData) do
		local tab = self.tabCells[i]

		if tab == nil then
			tab = RechargeLogLevelCell(self, "DrawLogPanel/BgPanel/TabList/Content", "System/Activity/ActivityGroupon/GrouponDrawLogTab", 0, 0, true)
		end

		tab:setData(v)

		self.tabCells[i] = tab
	end

	if self.giftLevelDrawLogPanel == nil then
		self.giftLevelDrawLogPanel = GiftLevelDrawLogPanel(self, "DrawLogPanel/BgPanel/MainInfoPanel", "System/Activity/ActivityGroupon/GrouponDrawLogPanel", 0, 0, true)
	end

	self:refreshDrawLogPanel()
end

function ActivityBuyGiftDrawLogDlg:refreshDrawLogPanel()
	self.giftLevelDrawLogPanel:setData()
end

function ActivityBuyGiftDrawLogDlg:onBtnRuleClick()
	if self.textRuleDes:getVisible() then
		self.textRuleDes:setVisible(false)
		self.upArrow:setVisible(true)
		self.downArrow:setVisible(false)
	else
		self.textRuleDes:setVisible(true)
		self.upArrow:setVisible(false)
		self.downArrow:setVisible(true)
	end
end

return ActivityBuyGiftDrawLogDlg
