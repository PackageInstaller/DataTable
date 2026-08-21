-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpPartAwardDlg.lua

local ResArenaDan = require("ClientData/ResArenaDan")
local PVPCommon = require("Logic/PVP/PVPCommon")
local ActivityPvpPartAwardCell = Class("ActivityPvpPartAwardCell", UIControls.ScrollViewLoopCell)

function ActivityPvpPartAwardCell:ctor(...)
	self:initUI()
end

function ActivityPvpPartAwardCell:initUI(...)
	self.txtSelf = UIControls.Label(self, "ContentPanel/TextSelf")
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.awardCells = {}
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "ContentPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function ActivityPvpPartAwardCell:setData(data)
	PVPCommon.setRankUI(self.rankUIData, data)

	local randId, index

	if self.mWindow.isSeason then
		randId = data.settle_award
		index = self.mWindow.mySeasonIndex
	else
		randId = data.dan_award
		index = self.mWindow.myPartIndex
	end

	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", randId, true, nil, true)

	local zoneInfo = PVPCommon.getZoneInfoByDan(data.dan)

	self.txtTitle:setText(string.format(Lang.get(30653), data.low_score, zoneInfo.name))

	if index > self.mIndex then
		self.panelContent:playStateAnimator("WorldBossRankAwardCellNml")
		self.txtSelf:setVisible(false)
		self:setAwardState(false)
	elseif index == self.mIndex then
		self.panelContent:playStateAnimator("WorldBossRankAwardCellSel")
		self.txtSelf:setVisible(true)
		self.txtSelf:setText(utils.format(Lang.get(30652), self.mWindow.score, self.mWindow.zoneInfo.name))
		self:setAwardState(true)
	else
		self.panelContent:playStateAnimator("WorldBossRankAwardCellNml")
		self.txtSelf:setVisible(false)
		self:setAwardState(true)
	end
end

function ActivityPvpPartAwardCell:setAwardState(isGet)
	if self.mWindow.isSeason then
		isGet = false
	end

	for i, cell in ipairs(self.awardCells) do
		cell:setGet(isGet)
	end
end

local strClassName = "ActivityPvpPartAwardDlg"
local ActivityPvpPartAwardDlg = Class(strClassName, UIControls.Window)

function ActivityPvpPartAwardDlg:ctor(...)
	self:initUI()
	self:initData()
end

function ActivityPvpPartAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRank = UIControls.Button(self, "BgPanel/TabRank")

	self.btnRank:addEventClick(self.onTabClick)

	self.btnSeason = UIControls.Button(self, "BgPanel/TabFinal")

	self.btnSeason:addEventClick(self.onTabClick)

	self.txtTime = UIControls.Label(self, "BgPanel/TextTime")
	self.txtRankTips = UIControls.Label(self, "BgPanel/TextRankTips")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/RankAwardList", 0, self.onCellChanged)
end

function ActivityPvpPartAwardDlg:initData(...)
	self.data = {}

	for i = #ResArenaDan, 1, -1 do
		table.insert(self.data, ResArenaDan[i])
	end

	local score, awardDan, league = 0, 0, 0
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData then
		score = actData.score
		awardDan = actData.award_dan
		league = actData.league
	end

	self.score = score
	self.myPartIndex = math.min(#ResArenaDan - awardDan + 1, #ResArenaDan)

	local partInfo = PVPCommon.getPartInfoByScore(score)

	self.mySeasonIndex = #ResArenaDan - partInfo.dan + 1
	self.zoneInfo = PVPCommon.getZoneInfo(league)

	self.txtRankTips:setText(ClientUtils.getClientNotice(330))
	self:refreshTime()
	self:onTabClick(self.btnRank)
end

function ActivityPvpPartAwardDlg:refreshTime(...)
	local leftTime = 0
	local actObj = CurAvatar:getPVPArenaActivity()

	if actObj then
		leftTime = actObj.actData:getLeftTimeToEnd()
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48690), nil, nil)
end

function ActivityPvpPartAwardDlg:refreshList()
	local index = self.isSeason and self.mySeasonIndex or self.myPartIndex

	self.scrollView:setTotalCount(#self.data, math.max(1, index - 1))
end

function ActivityPvpPartAwardDlg:tabChange()
	if self.isSeason then
		self.txtTime:setVisible(true)
		self.txtRankTips:setVisible(false)
	else
		self.txtTime:setVisible(false)
		self.txtRankTips:setVisible(true)
	end

	self:refreshList()
end

function ActivityPvpPartAwardDlg:onTabClick(sender)
	sender:setEnable(false)

	if self.btnRank ~= sender then
		self.btnRank:setEnable(true)

		self.isSeason = true
	else
		self.isSeason = false

		self.btnSeason:setEnable(true)
	end

	self:tabChange()
end

function ActivityPvpPartAwardDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function ActivityPvpPartAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityPvpPartAwardCell(sender, "System/ActivityPVP/ActivityPVPRankAwardCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.data[newIdx])
end

return ActivityPvpPartAwardDlg
