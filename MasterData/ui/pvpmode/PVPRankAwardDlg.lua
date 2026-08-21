-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPRankAwardDlg.lua

local ResRankAward = require("ClientData/ResRankAward")
local ResAsyncPVPMisc = require("ClientData/ResAsyncPVPMisc")
local strClassName = "PVPRankAwardDlg"
local PVPRankAwardDlg = Class(strClassName, UIControls.Window)
local PVPRankAwardCell = require("UI/PVPMode/PVPRankAwardCell")

function PVPRankAwardDlg:ctor()
	self:initUI()
end

function PVPRankAwardDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.timeTxt = UIControls.Label(self, "BgPanel/TextTime")

	local path = "BgPanel/"
	local names = {
		"TabDaily",
		"TabSeason"
	}

	self.tabs = {}

	for _, name in ipairs(names) do
		local btn = UIControls.Button(self, path .. name)

		btn.name = name

		btn:addEventClick(self.onTabClick)
		table.insert(self.tabs, btn)
	end

	self.cells = {}
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList", 0, self.onCellChanged)
	self.myIndex = CurAvatar.pvpRank

	if self.mIndex == nil then
		self.myIndex = ClientUtils.record.pvpRank or 0
	end

	self.itemDatas = {}
	self.itemSeasonDatas = {}

	local temp = {}

	for _, data in pairs(ResRankAward[1]) do
		table.insert(temp, data)
	end

	table.sort(temp, function(v1, v2)
		return v1.id < v2.id
	end)

	for _, data in pairs(temp) do
		table.insert(self.itemSeasonDatas, data)
	end

	temp = {}

	for _, data in pairs(ResRankAward[2]) do
		table.insert(temp, data)
	end

	table.sort(temp, function(v1, v2)
		return v1.id < v2.id
	end)

	for _, data in pairs(temp) do
		table.insert(self.itemDatas, data)
	end

	self.tabData = {
		TabDaily = self.itemDatas,
		TabSeason = self.itemSeasonDatas
	}
end

function PVPRankAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PVPRankAwardCell(sender, "System/AsynPVP/BtnPVPRankAward", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:initData(self.tabData[self.curTab][newIdx])
end

function PVPRankAwardDlg:show()
	self:onTabClick(self.tabs[1])
end

function PVPRankAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PVPRankAwardDlg:onTabClick(sender)
	if sender.name ~= self.curTab then
		self.curTab = sender.name
	end

	self.scrollView:setTotalCount(0)
	self.scrollView:setTotalCount(#self.tabData[self.curTab])
	self:timeInfoChange()

	for _, btn in pairs(self.tabs) do
		btn:setEnable(self.curTab ~= btn.name)
	end
end

function PVPRankAwardDlg:timeInfoChange()
	ClientTimerManager.RemoveSecondTickUI(self.timeTxt)

	if self.curTab == "TabDaily" then
		local leftTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.timeTxt, leftTime, nil, Lang.get(30647))
	else
		local leftTime = CurAvatar:getAsyncPvpLeftTime()

		ClientTimerManager.AddSecondFormatTickUI(self.timeTxt, leftTime, nil, Lang.get(30648))
	end
end

return PVPRankAwardDlg
