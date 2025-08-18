-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Hatsune\\ActivityHatsuneMikuAchieveDlg.lua

local ActivityHatsuneMikuAchieveCell = require("UI/OpActivity/Hatsune/ActivityHatsuneMikuAchieveCell")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local achieveStrClass = "ActivityHatsuneMikuAchieveDlg"
local ActivityHatsuneMikuAchieveDlg = Class(achieveStrClass, UIControls.Window)

MixinClass(ActivityHatsuneMikuAchieveDlg, ActivityPanelMixin)

function ActivityHatsuneMikuAchieveDlg:ctor()
	self.itemRootPath = "BgPanel/AwardList/Viewport/Content"
	self.achieveObjs = {}
	self.achieveCells = {}
	self.scrollList = UIControls.ScrollView(self, "BgPanel/AwardList")

	self:initUI()
end

function ActivityHatsuneMikuAchieveDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClose)

	self.titleTxt = UIControls.Label(self, "BgPanel/TextTitle")
end

function ActivityHatsuneMikuAchieveDlg:onOpen()
	ActivityHatsuneMikuAchieveDlg.super.onOpen(self)
	self.scrollList:gotoTop()
end

function ActivityHatsuneMikuAchieveDlg:setData(data, mainActID, title)
	self.itemPrefabPath = "System/Activity/ActivityMiKuConcert/MiKuCumulativeNmlCell"

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.itemPrefabPath = "System/Activity/" .. self.replaceableCellPath[2]
	end

	self.achieves = data
	self.achieveObjs = {}

	for key, value in pairs(self.achieves) do
		local obj = CurAvatar:getActivityObj(value)

		table.insert(self.achieveObjs, obj)
	end

	self.achieveCellDatas = {}

	for index, obj in ipairs(self.achieveObjs) do
		local actData = obj.actData

		for achieveType, typeData in pairs(actData.clientData) do
			for achieveIndex, achieveData in ipairs(typeData) do
				local cellData = {}

				cellData.actData = actData
				cellData.actObj = obj
				cellData.achieveType = achieveType
				cellData.achieveIndex = achieveIndex

				table.insert(self.achieveCellDatas, cellData)
			end
		end
	end

	for index, cell in ipairs(self.achieveCells) do
		cell:setVisible(false)
	end

	for index, cellData in ipairs(self.achieveCellDatas) do
		local cell = self.achieveCells[index]

		if cell == nil then
			cell = ActivityHatsuneMikuAchieveCell(self, self.itemRootPath, self.itemPrefabPath)

			table.insert(self.achieveCells, cell)
		end

		cell:setData(cellData)
		cell:setVisible(true)
	end

	if title then
		self.titleTxt:setText(title)
	end
end

function ActivityHatsuneMikuAchieveDlg:refreshData()
	for index, cell in ipairs(self.achieveCells) do
		cell:refreshData(false)
	end
end

function ActivityHatsuneMikuAchieveDlg:onClose()
	self:setVisible(false)
end

function ActivityHatsuneMikuAchieveDlg:checkRedDot()
	for index, obj in ipairs(self.achieveObjs) do
		local actData = obj.actData

		if actData:checkNew() then
			return true
		end
	end

	return false
end

function ActivityHatsuneMikuAchieveDlg:updateRelatedActivityData(actObj)
	self:refreshData()
end

return ActivityHatsuneMikuAchieveDlg
