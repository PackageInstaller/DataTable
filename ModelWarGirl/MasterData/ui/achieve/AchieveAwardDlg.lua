-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\AchieveAwardDlg.lua

local ResAchieve = require("ClientData/ResAchieve")
local ResRandClient = require("ClientData/ResRandClient")
local ResTrunkAchieveMisc = require("ClientData/ResTrunkAchieveMisc")
local strClassName = "AchieveAwardDlg"
local AchieveAwardDlg = Class(strClassName, UIControls.Window)

function AchieveAwardDlg:ctor(...)
	self:initUI()
end

function AchieveAwardDlg:initUI(...)
	self.desTxt = UIControls.Label(self, "BgPanel/TextDes")
	self.titleTxt = UIControls.Label(self, "BgPanel/TextTitle")
	self.gridMountPath = "BgPanel/AwardList/Content"
	self.closeBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.itemGrids = {}
	self.normalNoticePanel = UIControls.Panel(self, "BgPanel/BgQ")
	self.specNoticePanel = UIControls.Panel(self, "BgPanel/OtherAwardPanel")
	self.specNoticeTxt = UIControls.Label(self, "BgPanel/OtherAwardPanel/TextQ")
	self.specGridMountPath = "BgPanel/OtherAwardPanel/AwardPanel"
	self.specItemGrids = {}
end

function AchieveAwardDlg:showPreviewAward(achieveId)
	local achieveInfo = ResAchieve[achieveId]

	if not achieveInfo then
		return
	end

	for _, grid in ipairs(self.itemGrids) do
		grid:destroy()
	end

	self.itemGrids = {}

	local awardRandId = achieveInfo.award_randid

	if awardRandId and ResRandClient[awardRandId] then
		for i, itemId in ipairs(ResRandClient[awardRandId].show_ids) do
			local itemNum = ResRandClient[awardRandId].show_nums[i]
			local fakeItem = BaseObject.GetObject(itemId, itemNum)
			local grid = UIControls.getGridChild(fakeItem, self, self.gridMountPath)

			grid:setVisible(true)

			grid.mDisableWays = true

			grid:setObj(fakeItem)

			self.itemGrids[i] = grid
		end
	end

	self.desTxt:setText(string.format(Lang.get(30114), achieveInfo.action_desc or Lang.get(30115)))

	local isSpec = ResTrunkAchieveMisc[achieveId] ~= nil

	self.normalNoticePanel:setVisible(not isSpec)
	self.specNoticePanel:setVisible(isSpec)

	if isSpec then
		local specInfo = ResTrunkAchieveMisc[achieveId]
		local itemIds = specInfo.item_id
		local itemNums = specInfo.item_num
		local noticeContent = specInfo.content

		for _, grid in ipairs(self.specItemGrids) do
			grid:destroy()
		end

		self.specItemGrids = {}

		for i, itemId in ipairs(itemIds) do
			local itemNum = itemNums[i]
			local fakeItem = BaseObject.GetObject(itemId, itemNum)
			local grid = UIControls.getGridChild(fakeItem, self, self.specGridMountPath)

			grid:setVisible(true)

			grid.mDisableWays = true

			grid:setObj(fakeItem)

			self.specItemGrids[i] = grid
		end
	end
end

function AchieveAwardDlg:_onClickClose(...)
	self:setVisible(false)
end

return AchieveAwardDlg
