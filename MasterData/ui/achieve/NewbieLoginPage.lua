-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\NewbieLoginPage.lua

local ResAchieve = require("ClientData/ResAchieve")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "NewbieLoginPage"
local NewbieLoginPage = Class(strClassName, UIControls.Child)
local LoginShowAllAwardPanel = Class("LoginShowAllAwardPanel", UIControls.Panel)

function LoginShowAllAwardPanel:ctor(...)
	self:initUI()
end

function LoginShowAllAwardPanel:initUI(...)
	self.closeBtn = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.closeBtn:addEventClick(self._onClick)

	self.movablePanel = UIControls.Panel(self, self.mPath .. "/SignInAllAward")
	self.titleTxt = UIControls.Label(self, self.mPath .. "/SignInAllAward/TextTitle")
	self.gridMountPath = self.mPath .. "/SignInAllAward"
	self.itemGrids = {}
end

local INDEX_POS = {
	{
		-88,
		-408
	},
	{
		156,
		-408
	},
	{
		401,
		-408
	},
	{
		647,
		-408
	},
	{
		494,
		-306
	},
	{
		246,
		-306
	},
	{
		-20,
		-306
	}
}

function LoginShowAllAwardPanel:showAwards(index, achieveId)
	local achieveInfo = ResAchieve[achieveId]

	if not achieveInfo then
		return
	end

	self.titleTxt:setText(string.format(Lang.get(30116), achieveInfo.action_param))

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

	self.movablePanel:setPosition(INDEX_POS[index][1], INDEX_POS[index][2])
end

function LoginShowAllAwardPanel:_onClick(...)
	self:setVisible(false)
end

local DayAwardCell = Class("DayAwardCell", UIControls.Panel)

function DayAwardCell:ctor(...)
	self:initUI()
end

function DayAwardCell:initUI(...)
	self.cellBtn = UIControls.Button(self, self.mPath)

	self.cellBtn:addEventClick(self._onClickBtn)

	self.achieveNameTxt = UIControls.Label(self, self.mPath .. "/TextName")
	self.dayTxt = UIControls.Label(self, self.mPath .. "/TextDay")
	self.awardImg = UIControls.Image(self, self.mPath .. "/Icon")
	self.awardNumTxt = UIControls.Label(self, self.mPath .. "/TextNun")
	self.todayImg = UIControls.Image(self, self.mPath .. "/ImgAirplane")
end

function DayAwardCell:setCellData(index, achieveId)
	self.index = index
	self.achieveId = achieveId

	local achieveInfo = ResAchieve[achieveId]

	if not achieveInfo then
		return
	end

	self.achieveNameTxt:setText(achieveInfo.action_desc or "")
	self.dayTxt:setText(achieveInfo.action_param)

	local awardRandId = achieveInfo.award_randid

	if awardRandId and ResRandClient[awardRandId] and ResRandClient[awardRandId].show_ids then
		local itemId = ResRandClient[awardRandId].show_ids[1]
		local itemNum = ResRandClient[awardRandId].show_nums[1]
		local fakeItem = BaseObject.GetObject(itemId, itemNum)
		local iconPath = fakeItem:getIconPath()

		if iconPath and #iconPath == 2 then
			self.awardImg:setImage(iconPath[1], iconPath[2])
		end

		if itemNum and itemNum > 1 then
			self.awardNumTxt:setText(ClientUtils.getNumShortStr(itemNum))
		else
			self.awardNumTxt:setText("")
		end
	end

	self.awardRandId = awardRandId
end

local BTN_STATE_NAME = {
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInFiveSixNml",
		"BtnSignInFiveSixHigh",
		"BtnSignInFiveSixDis"
	},
	{
		"BtnSignInFiveSixNml",
		"BtnSignInFiveSixHigh",
		"BtnSignInFiveSixDis"
	},
	{
		"BtnSignInEndNml",
		"BtnSignInEndHigh",
		"BtnSignInEndDis"
	}
}

function DayAwardCell:refreshCell()
	if not self.achieveId then
		return
	end

	local achieveStatus = CurAvatar:getAchieveStatus(self.achieveId)
	local btnAnimName = BTN_STATE_NAME[self.index][achieveStatus]

	self.cellBtn:playAnimator(btnAnimName)
	self.awardImg:setImageGray(achieveStatus == Const.ACHIEVE_STATUS.AWARD_GOT)

	self.achieveStatus = achieveStatus
end

function DayAwardCell:showTodayNotice(isShown)
	self.todayImg:setVisible(isShown)
end

function DayAwardCell:_onClickBtn(...)
	if self.achieveStatus == Const.ACHIEVE_STATUS.COMPLETE then
		CurAvatar:getAchieveAward(self.achieveId)
	else
		self.mParent.showAllAwardPanel:showAwards(self.index, self.achieveId)
		self.mParent.showAllAwardPanel:setVisible(true)
	end
end

function NewbieLoginPage:ctor(...)
	self:initUI()
end

function NewbieLoginPage:initUI(...)
	self.awardCells = {}

	for i = 1, 7 do
		local cell = DayAwardCell(self, "BtnSignIn" .. i)

		self.awardCells[i] = cell
	end

	self.showAllAwardPanel = LoginShowAllAwardPanel(self, "SignInAllAwardPanel")

	self.showAllAwardPanel:setVisible(false)
end

function NewbieLoginPage:onPageOpen(...)
	self.achieveList = CurAvatar:getAchieveList(Const.ACHEVE_UPPER_SYSTEM_LOGINTASK)

	if not self.achieveList or #self.achieveList == 0 then
		return
	end

	for i, cell in ipairs(self.awardCells) do
		cell:setCellData(i, self.achieveList[i])
	end

	self:refreshLoginAchieve()
end

function NewbieLoginPage:refreshLoginAchieve()
	local showPlaneIndex = self:_calcTodayIndex()

	for i, cell in ipairs(self.awardCells) do
		cell:refreshCell()
		cell:showTodayNotice(i == showPlaneIndex)
	end
end

function NewbieLoginPage:_calcTodayIndex()
	for i, achieveId in ipairs(self.achieveList) do
		local isQualify = CurAvatar.achieveQualify[achieveId]

		if not isQualify then
			return i - 1
		end
	end

	return #self.achieveList
end

return NewbieLoginPage
