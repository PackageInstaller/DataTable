-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchieveCapPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResItem = require("ClientData/ResItem")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ActivityCapAchieveCell = Class("ActivityCapAchieveCell", UIControls.ScrollViewLoopCell)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/ActivityAtlas01"

function ActivityCapAchieveCell:ctor()
	self.nmlPanel = UIControls.Panel(self, "NmlPanel")
	self.disPanel = UIControls.Panel(self, "DisPanel")
	self.otherPanel = UIControls.Panel(self, "OtherPanel")
	self.items = {}
	self.curPanelPath = "NmlPanel"
	self.isNextToGet = false
	self.stateUIs = {}
	self.grids = {}
end

function ActivityCapAchieveCell:setData(info)
	self.data = info.data
	self.state = info.state
	self.miscInfo = info.miscInfo

	self:_refrehState(info.moneyInfo, info.data)
end

local UI_INFO = {
	{
		"NmlPanel",
		false
	},
	{
		"OtherPanel",
		true
	},
	{
		"DisPanel",
		false
	}
}

function ActivityCapAchieveCell:_refrehState(moneyInfo, awardData)
	local uiState = 0

	uiState = self.isNextToGet == true and 1 or self.state == 3 and 2 or 3

	self.nmlPanel:setVisible(uiState == 1)
	self.otherPanel:setVisible(uiState == 2)
	self.disPanel:setVisible(uiState == 3)

	local curPanelPath = UI_INFO[uiState][1]

	if not self.stateUIs[uiState] then
		local txtNum = UIControls.Label(self, curPanelPath .. "/TextNum")
		local imgIcon = UIControls.Image(self, curPanelPath .. "/Icon")
		local txtRole = UIControls.Label(self, curPanelPath .. "/TextRule")

		self.stateUIs[uiState] = {
			txtNum,
			imgIcon,
			txtRole
		}
	end

	for _, gridItem in ipairs(self.grids) do
		gridItem:destroy()
	end

	self.grids = {}

	local grids = {}
	local gridCfgId = self.miscInfo and self.miscInfo.grid_id or nil
	local iconPath, iconName

	if gridCfgId then
		local resGridData = ResSpecialGridConfig[gridCfgId]

		iconPath = resGridData.get_icon_path
		iconName = resGridData.get_icon_name
	end

	ClientUtils.CreateBonusGrid(self, grids, curPanelPath .. "/AwardPanel", awardData.award, true, nil, true)

	for i, grid in ipairs(grids) do
		self.grids[i] = grid
		grid.isShowPreviewTips = true

		if iconPath then
			grid:changeGetImg(iconPath, iconName)
		end

		grid:setState(false, self.state == 1, true)
	end

	local uis = self.stateUIs[uiState]

	uis[2]:setImageGray(UI_INFO[uiState][2])
	uis[1]:setText(self.data.param)

	if moneyInfo then
		uis[2]:setImage(moneyInfo[1], moneyInfo[2])
	end

	if self.miscInfo then
		if self.miscInfo.desc_name and uis[3] then
			uis[3]:setText(self.miscInfo.desc_name)
		end

		if self.miscInfo.icon_path then
			uis[2]:setImage(self.miscInfo.icon_path, self.miscInfo.icon_name)
		end
	end
end

local classNameStr = "ActivityAchieveCapPage"
local ActivityAchieveCapPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityAchieveCapPage, ActivityPanelMixin)

function ActivityAchieveCapPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.txtRole = UIControls.Label(self, "BgDes/TextDes")
	self.imgItemIcon = UIControls.Image(self, "HavePanel/Icon")
	self.txtItemNum = UIControls.Label(self, "HavePanel/TextNum")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self._onCellChanged)
	self.cells = {}
	self.maxTargetCellIdx = 0
	self.isVisible = false
end

function ActivityAchieveCapPage:_setData(pageData)
	local detailData = {}
	local svrData
	local actId = self.actObj.actId
	local activityType

	for actType, cData in pairs(self.actObj.actData.clientData) do
		if not activityType then
			activityType = actType
			self.activityType = actType
			self.miscInfo = ResOpActivityAchieveMisc[actId][activityType]
		end

		for _, data in ipairs(cData) do
			table.insert(detailData, data)
		end
	end

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	local moneyInfo
	local itemId = self.miscInfo.item_id

	if itemId then
		moneyInfo = UIConst.MONEY_ID2INFO[itemId]

		self.imgItemIcon:setImage(moneyInfo[1], moneyInfo[2])
	elseif self.miscInfo.icon_path then
		self.imgItemIcon:setImage(self.miscInfo.icon_path, self.miscInfo.icon_name)
	end

	local progress = svrData and svrData.progress or 0

	self.txtItemNum:setText(progress)
	self:_setCells(detailData, moneyInfo)
end

function ActivityAchieveCapPage:_setCells(detailData, moneyInfo)
	local actData = self.actObj.actData

	self.achData = {}
	self.maxTargetCellIdx = #detailData - 4

	for idx, data in ipairs(detailData) do
		local state = actData:getAchieveState(self.activityType, idx)

		if state == 3 and not self.toGetCellIdx then
			self.toGetCellIdx = idx
		end

		local info = {}

		info.data = data
		info.state = state
		info.moneyInfo = moneyInfo
		info.miscInfo = self.miscInfo

		table.insert(self.achData, info)
	end

	local idx

	if self.toGetCellIdx then
		idx = self.toGetCellIdx - 3
		idx = idx <= 0 and 1 or idx
	end

	if idx and idx > self.maxTargetCellIdx then
		idx = self.maxTargetCellIdx
	end

	idx = idx and idx or self.maxTargetCellIdx
	self.targetCellIdx = idx

	self.scrollItems:setTotalCount(#self.achData, idx)
end

function ActivityAchieveCapPage:_onShow()
	self.cells = {}

	if self.isVisible == false then
		self.isVisible = true
	elseif self.targetCellIdx >= self.maxTargetCellIdx then
		self.scrollItems:goToBottom()
	else
		self.scrollItems:scrollToCell(self.targetCellIdx)
	end
end

function ActivityAchieveCapPage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		if self.replaceableCellPath and self.replaceableCellPath[1] then
			targetCell = ActivityCapAchieveCell(sender, self.replaceableCellPath[1], newIdx, 0, 0)
		else
			targetCell = ActivityCapAchieveCell(sender, "System/Activity/ActivityAchiCapCell", newIdx, 0, 0)
		end
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	if self.toGetCellIdx and newIdx == self.toGetCellIdx then
		targetCell.isNextToGet = true
	else
		targetCell.isNextToGet = false
	end

	self.cells[newIdx] = targetCell

	self.cells[newIdx]:setData(self.achData[newIdx])
end

return ActivityAchieveCapPage
