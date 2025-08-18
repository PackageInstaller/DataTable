-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Award\\ActivityCatRaceMileAwardDlg.lua

local ActivityCatRaceMileAwardCell = require("UI/OpActivity/CatRace/Award/ActivityCatRaceMileAwardCell")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local strClassName = "ActivityCatRaceMileAwardDlg"
local ActivityCatRaceMileAwardDlg = Class(strClassName, UIControls.Window)

function ActivityCatRaceMileAwardDlg:ctor()
	self:initUI()
end

function ActivityCatRaceMileAwardDlg:initUI()
	self.awardCellMountPath = "BgPanel/AwardList"
	self.awardCellPrefabPath = "System/Activity/ActivityCatRace/BtnCatRaceAwardCell"
	self.cells = {}
	self.awardScroll = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList")

	self.awardScroll:addEventCellChanged(self.onCellChanged)

	self.curPosImg = UIControls.Panel(self, "BgPanel/FrameImgCatRun")
	self.receiveAllBtn = UIControls.Button(self, "BgPanel/BtnReceive")

	self.receiveAllBtn:addEventClick(self._onBtnReceiveAll)

	self.closeBtn = UIControls.Button(self, "BgPanel/BgFrame/DecPanel/Dec03")

	self.closeBtn:addEventClick(self._onBtnClose)
end

function ActivityCatRaceMileAwardDlg:setData(data)
	self.mainActID = data.mainActID
	self.mainActObj = CurAvatar:getActivityObj(self.mainActID)
	self.mainActData = self.mainActObj.actData
	self.actID = self.mainActData.miscData.mile_achieve_id
	self.actObj = CurAvatar:getActivityObj(self.actID)

	if self.actObj then
		self.actData = self.actObj.actData
		self.opID = self.actObj.opId
	end

	self.achieveCellDatas = {}

	for achieveType, typeData in pairs(self.actData.clientData) do
		for achieveIndex, achieveData in ipairs(typeData) do
			local cellData = {}

			cellData.actData = self.actData
			cellData.achieveType = achieveType
			cellData.achieveIndex = achieveIndex
			cellData.achieveData = achieveData

			table.insert(self.achieveCellDatas, cellData)
		end

		self.achieveType = achieveType
	end

	local lastData = self.actData:getNextAchieveInfo()

	if lastData and lastData.index > 1 then
		self.awardScroll:setTotalCount(#self.achieveCellDatas, lastData.index - 1)
	else
		self.awardScroll:setTotalCount(#self.achieveCellDatas)
	end

	self:refreshData()
end

function ActivityCatRaceMileAwardDlg:refreshData()
	for _, cell in pairs(self.cells) do
		cell:refreshData()
	end

	self.receiveAllBtn:setEnable(self.actData:checkNew())
end

function ActivityCatRaceMileAwardDlg:onCellChanged(sender, targetCell, newIdx)
	local data = self.achieveCellDatas[newIdx]

	if not data then
		return
	end

	if targetCell == nil then
		targetCell = ActivityCatRaceMileAwardCell(sender, self.awardCellPrefabPath, newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.achieveCellDatas[newIdx])

	self.cells[newIdx] = targetCell
end

function ActivityCatRaceMileAwardDlg:_onBtnReceiveAll()
	if self.mainActObj:inFreeze() or self.mainActObj:inOpenState() then
		RPC.opActGetAward(self.opID, -1, self.achieveType)
	end
end

function ActivityCatRaceMileAwardDlg:_onBtnClose()
	self:setVisible(false)
end

return ActivityCatRaceMileAwardDlg
