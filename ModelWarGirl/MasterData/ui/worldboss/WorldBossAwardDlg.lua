-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossAwardDlg.lua

local ResWorldBossMisc = require("ClientData/ResWorldBossMisc")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local WorldBossPointAwardCell = Class("WorldBossPointAwardCell", UIControls.ScrollViewLoopCell)

function WorldBossPointAwardCell:ctor(...)
	self:initUI()
end

function WorldBossPointAwardCell:initUI(...)
	self.txtNum = UIControls.Label(self, "ContentPanel/TextNum")
	self.txtSelf = UIControls.Label(self, "ContentPanel/TextSelf")
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.awardCells = {}
end

function WorldBossPointAwardCell:setData(data)
	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", data.awardid, true, nil, true)
	self.txtNum:setText(data.score)

	if self.mWindow.pointIndex > self.mIndex then
		self.panelContent:playStateAnimator("RankingAwardCellNml")
		self.txtSelf:setVisible(false)
		self:setAwardState(false)
	elseif self.mWindow.pointIndex == self.mIndex then
		self.panelContent:playStateAnimator("RankingAwardCellSel")
		self.txtSelf:setVisible(true)
		self.txtSelf:setText(string.format(Lang.get(30803), self.mWindow.myPointScore))
		self:setAwardState(self.mWindow.myPointScore >= data.score)
	else
		self.panelContent:playStateAnimator("RankingAwardCellDis")
		self.txtSelf:setVisible(false)
		self:setAwardState(true)
	end

	for i, cell in ipairs(self.awardCells) do
		if cell.object.id == ResWorldBossMisc[1].award_id and data.up_ratio then
			cell:setNumSpe(true, "+" .. data.up_ratio * 0.01)
		else
			cell:setNumSpe(false)
		end
	end
end

function WorldBossPointAwardCell:setAwardState(isGet)
	for i, cell in ipairs(self.awardCells) do
		cell:setGet(isGet)
	end
end

local WorldBossRankAwardCell = Class("WorldBossRankAwardCell", UIControls.ScrollViewLoopCell)

function WorldBossRankAwardCell:ctor(...)
	self:initUI()
end

function WorldBossRankAwardCell:initUI(...)
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

function WorldBossRankAwardCell:setData(data)
	self.txtTitle:setText(string.format(Lang.get(30804), data.score))

	if self.mWindow.rankIndex > self.mIndex then
		self.panelContent:playStateAnimator("WorldBossRankAwardCellNml")
		self.txtSelf:setVisible(false)
	elseif self.mWindow.rankIndex == self.mIndex then
		self.panelContent:playStateAnimator("WorldBossRankAwardCellSel")
		self.txtSelf:setVisible(true)
		self.txtSelf:setText(string.format(Lang.get(30805), self.mWindow.myRankScore))
	else
		self.panelContent:playStateAnimator("WorldBossRankAwardCellNml")
		self.txtSelf:setVisible(false)
	end

	WorldBossCommon.setRankUI(self.rankUIData, data)
	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", data.awardid, true, nil, true)
end

local WorldBossEliteAwardCell = Class("WorldBossEliteAwardCell", UIControls.ScrollViewLoopCell)

function WorldBossEliteAwardCell:ctor(...)
	self:initUI()
end

function WorldBossEliteAwardCell:initUI(...)
	self.txtNum = UIControls.Label(self, "ContentPanel/TextNum")
	self.txtSelf = UIControls.Label(self, "ContentPanel/TextSelf")
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.awardCells = {}
end

function WorldBossEliteAwardCell:setData(data)
	if not data then
		return
	end

	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", data.awardid, true, nil, true)
	self.txtNum:setText(data.score)

	if self.mWindow.eliteIndex > self.mIndex then
		self.txtSelf:setVisible(false)
	elseif self.mWindow.eliteIndex == self.mIndex then
		self.panelContent:playStateAnimator("RankingAwardCellSel")
		self.txtSelf:setVisible(true)
		self.txtSelf:setText(string.format(Lang.get(30803), self.mWindow.myEliteScore))
	else
		self.txtSelf:setVisible(false)
	end
end

local strClassName = "WorldBossAwardDlg"
local WorldBossAwardDlg = Class(strClassName, UIControls.Window)

function WorldBossAwardDlg:ctor(...)
	self:initUI()
	self:initData()
end

function WorldBossAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.tabPoint = UIControls.Button(self, "BgPanel/TabPoint")

	self.tabPoint:addEventClick(self.onTabChanged)

	self.tabRank = UIControls.Button(self, "BgPanel/TabRank")

	self.tabRank:addEventClick(self.onTabChanged)

	self.txtTimePoint = UIControls.Label(self, "BgPanel/TextTimePoint")
	self.txtTimeRank = UIControls.Label(self, "BgPanel/TextTimeRank")
	self.scrollViewRank = UIControls.ScrollViewLoopV(self, "BgPanel/RankAwardList", 0, self.onRankCellChanged)
	self.scrollViewPoint = UIControls.ScrollViewLoopV(self, "BgPanel/PointAwardList", 0, self.onPointCellChanged)
	self.tabElite = UIControls.Button(self, "BgPanel/TabElite")

	self.tabElite:addEventClick(self.onTabChanged)

	self.scrollViewElite = UIControls.ScrollViewLoopV(self, "BgPanel/EliteAwardList", 0, self.onEliteCellChanged)

	local actData = CurAvatar:getWorldBossActData()

	if actData then
		self.tabElite:setVisible(actData:checkEliteModeOpen())
	end
end

function WorldBossAwardDlg:initData(...)
	self.pointAwardInfos = WorldBossCommon.getPartAwardInfos()
	self.rankAwardInfos = WorldBossCommon.getLevelAwardInfos()
	self.eliteAwardInfos = WorldBossCommon.getEliteAwardInfos()
	self.myPointScore = WorldBossCommon.getSumScore()
	self.myRankScore = WorldBossCommon.getSumScore()

	local score = 0
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		score = actData:getEliteMaxScore()
	end

	self.myEliteScore = score
end

function WorldBossAwardDlg:show(...)
	self:refreshTime()
	self:onTabChanged(self.tabPoint)
end

function WorldBossAwardDlg:refreshTime(...)
	local leftTime = WorldBossCommon.getCurBossLeftTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtTimePoint)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTimePoint, leftTime, nil, Lang.get(30590), nil, nil)
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeRank)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTimeRank, leftTime, nil, Lang.get(48690), nil, nil)
end

function WorldBossAwardDlg:refreshPointList(...)
	if self.pointIndex == nil then
		self.pointIndex = self:getMyIndex(self.pointAwardInfos, self.myPointScore)
	end

	self.scrollViewPoint:setTotalCount(#self.pointAwardInfos, math.max(1, self.pointIndex - 1))
end

function WorldBossAwardDlg:refreshRankList(...)
	if self.rankIndex == nil then
		self.rankIndex = self:getMyIndex(self.rankAwardInfos, self.myRankScore)
	end

	self.scrollViewRank:setTotalCount(#self.rankAwardInfos, math.max(1, self.rankIndex - 1))
end

function WorldBossAwardDlg:refreshEliteList(...)
	if self.eliteIndex == nil then
		self.eliteIndex = self:getMyIndex(self.eliteAwardInfos, self.myEliteScore)
	end

	self.scrollViewElite:setTotalCount(#self.eliteAwardInfos, self.eliteIndex)
end

function WorldBossAwardDlg:getMyIndex(infos, score)
	for i = #infos, 1, -1 do
		if score < infos[i].score then
			return math.min(#infos, i + 1)
		end
	end

	return 1
end

function WorldBossAwardDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function WorldBossAwardDlg:onTabChanged(sender)
	if sender == self.tabRank then
		self.tabPoint:setEnable(true)
		self.tabElite:setEnable(true)
		self.scrollViewRank:setVisible(true)
		self.scrollViewPoint:setVisible(false)
		self.scrollViewElite:setVisible(false)
		self.txtTimePoint:setVisible(false)
		self.txtTimeRank:setVisible(true)
		self:refreshRankList()
	elseif sender == self.tabElite then
		self.tabRank:setEnable(true)
		self.tabPoint:setEnable(true)
		self.scrollViewElite:setVisible(true)
		self.scrollViewPoint:setVisible(false)
		self.scrollViewRank:setVisible(false)
		self.txtTimePoint:setVisible(false)
		self.txtTimeRank:setVisible(false)
		self:refreshEliteList()
	else
		self.tabRank:setEnable(true)
		self.tabElite:setEnable(true)
		self.scrollViewRank:setVisible(false)
		self.scrollViewElite:setVisible(false)
		self.scrollViewPoint:setVisible(true)
		self.txtTimePoint:setVisible(true)
		self.txtTimeRank:setVisible(false)
		self:refreshPointList()
	end

	sender:setEnable(false)
end

function WorldBossAwardDlg:onRankCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = WorldBossRankAwardCell(sender, "System/WorldBoss/WorldBossRankAwardCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.rankAwardInfos[newIdx])
end

function WorldBossAwardDlg:onPointCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = WorldBossPointAwardCell(sender, "System/WorldBoss/WorldBossPointAwardCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.pointAwardInfos[newIdx])
end

function WorldBossAwardDlg:onEliteCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = WorldBossEliteAwardCell(sender, "System/WorldBoss/WorldBossEliteAwardCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.eliteAwardInfos[newIdx])
end

return WorldBossAwardDlg
