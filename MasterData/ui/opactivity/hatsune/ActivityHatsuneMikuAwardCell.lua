-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Hatsune\\ActivityHatsuneMikuAwardCell.lua

local ResOpActivityHatsuneLib = require("ClientData/ResOpActivityHatsuneLib")
local ResOpActivityHatsuneLibDetail = require("ClientData/ResOpActivityHatsuneLibDetail")
local HatsuneMikuConfig = require("UI/OpActivity/Hatsune/HatsuneMikuConfig")
local ActivityHatsuneMikuAwardCell = Class("ActivityHatsuneMikuAwardCell", UIControls.ScrollViewLoopCell)

function ActivityHatsuneMikuAwardCell:ctor()
	self.numBack = UIControls.Image(self, "NumBack")
	self.awardBack = UIControls.Image(self, "AwardBack")
	self.awardShowIcon = UIControls.Image(self, "AwardBack/AwardShowIcon")
	self.iconNew = UIControls.Image(self, "IconNew")
	self.bigAwardBack = UIControls.Image(self, "BigAwardBack")
	self.bigAwardEffect = UIControls.LazyEffectPlayer(self, "BigAwardBack/EffectNode")
	self.choiceImage = UIControls.Image(self, "ChoiceImg")
	self.sliderNum = UIControls.Label(self, "SliderNum")
	self.slider = UIControls.Slider(self, "Slider")
	self.bagImage = UIControls.Image(self, "AwardBack/AwardNode/AwardImage")
	self.bigAwardButton = UIControls.Button(self, "BigAwardBack")

	self.bigAwardButton:addEventClick(self.onBtnAward)

	self.panelBigAwardGrid = UIControls.Panel(self, "BigAwardBack/ItemNode")
	self.bigAwardGrids = {}
	self.bigAwardGetButton = UIControls.Button(self, "BigAwardBack/UIClickThrough")

	self.bigAwardGetButton:addEventClick(self.onBtnAwardSel)

	self.awardButton = UIControls.Button(self, "AwardBack")

	self.awardButton:addEventClick(self.onBtnAward)

	self.awardUniqueButton = UIControls.Button(self, "AwardBack/UIClickThrough")

	self.awardUniqueButton:addEventClick(self.onBtnAwardSel)

	self.state = HatsuneMikuConfig.AwardState.Dis
end

function ActivityHatsuneMikuAwardCell:setData(nodeData, itemList, actID, curProgress, allAwardsNode, mainActData)
	self.mainDlgName = "activityHatsuneMikuDlg"
	self.mainActData = mainActData
	self.actID = actID
	self.nodeData = nodeData
	self.allAwardsNode = allAwardsNode
	self.index = nodeData.index
	self.itemList = itemList
	self.libID = nodeData.lib_id
	self.libDetail = ResOpActivityHatsuneLibDetail[self.libID]
	self.baseImagePath = self.libDetail.award_path

	local count = 0

	for _, value in pairs(self.itemList) do
		count = count + 1
	end

	self.isUnique = count <= 1

	self:refreshData(true)
end

function ActivityHatsuneMikuAwardCell:refreshData()
	self:setVisible(true)

	self.curProgress = self.mainActData.cheerNum

	self.sliderNum:setText(self.nodeData.progress_need)

	if self.grids then
		for _, grid in pairs(self.grids) do
			grid:destroy()
		end
	end

	self.grids = nil

	if not self.isUnique then
		local bagPath = self.libDetail.bag_path
		local bagIcon = self.libDetail.bag_icon

		self.bagImage:setImage(bagPath, bagIcon)
		self.bagImage:setVisible(true)
	else
		self.grids = {}

		local gridConfig = {}

		gridConfig.checkNeedConvertObject = true

		ClientUtils.CreateBonusGrid(self, self.grids, "AwardBack/AwardNode", self.itemList[1].award_id, true, nil, true, nil, nil, gridConfig)
		self.bagImage:setVisible(false)
	end

	if self.curProgress then
		if self.nodeData.progress_need > self.curProgress then
			self:refreshState(HatsuneMikuConfig.AwardState.Dis)
		elseif self.mainActData.nodeDict[self.index] then
			self:refreshState(HatsuneMikuConfig.AwardState.Nml)
		else
			self:refreshState(HatsuneMikuConfig.AwardState.Sel)
		end
	else
		self:refreshState(HatsuneMikuConfig.AwardState.Dis)
	end

	if self.allAwardsNode then
		local curIndex = self.nodeData.index
		local prevIndex = curIndex - 1
		local prevProgressNeed = 0

		if self.allAwardsNode[prevIndex] then
			prevProgressNeed = self.allAwardsNode[prevIndex].progress_need
		end

		local len = self.nodeData.progress_need - prevProgressNeed
		local dis = self.curProgress - prevProgressNeed

		dis = math.max(0, dis)

		local rate = dis / len

		rate = math.min(rate, 1)

		self.slider:setValue(rate, 0, true)
	end
end

function ActivityHatsuneMikuAwardCell:refreshState(state)
	self.state = state

	local canSel = state == HatsuneMikuConfig.AwardState.Sel
	local isGet = state == HatsuneMikuConfig.AwardState.Nml
	local isDis = state == HatsuneMikuConfig.AwardState.Dis

	if self.libDetail.award_flag then
		self.awardBack:setVisible(false)
		self.bigAwardBack:setVisible(true)
		self.bigAwardBack:setImage(self.baseImagePath, self.libDetail.award_back .. state)
		self.bigAwardEffect:setVisible(canSel)

		if self.libDetail.show_award then
			self.panelBigAwardGrid:setVisible(true)
			ClientUtils.CreateBonusGrid(self, self.bigAwardGrids, "BigAwardBack/ItemNode", self.libDetail.show_award, true, nil, true)

			for _, grid in ipairs(self.bigAwardGrids) do
				grid:setGet(not canSel)
				grid:setState(not canSel, false, true)
			end
		else
			self.panelBigAwardGrid:setVisible(false)
		end
	else
		self.awardBack:setVisible(true)
		self.bigAwardBack:setVisible(false)
		self.awardBack:setImage(self.baseImagePath, self.libDetail.award_back .. state)

		if self.libDetail.award_icon then
			self.awardShowIcon:setVisible(true)
			self.awardShowIcon:setImage(self.baseImagePath, self.libDetail.award_icon .. state)
		else
			self.awardShowIcon:setVisible(false)
		end
	end

	self.iconNew:setVisible(canSel)
	self.bagImage:setImageGray(not canSel)
	self.awardUniqueButton:setVisible(canSel)
	self.bigAwardGetButton:setVisible(canSel)
	self.choiceImage:setVisible(isGet)

	if self.grids then
		for key, grid in pairs(self.grids) do
			grid:setGet(not canSel)
			grid:setState(not canSel, false, true)
		end
	end

	if isDis then
		self.numBack:setImage(self.baseImagePath, "BgProgressBlack")
	else
		self.numBack:setImage(self.baseImagePath, "BgProgress")
	end
end

function ActivityHatsuneMikuAwardCell:onBtnAward()
	if self.state ~= HatsuneMikuConfig.AwardState.Sel and not self.isUnique then
		local uiWindow = UIManager.tryGetUI(self.mainDlgName)

		if uiWindow then
			uiWindow:openShowChoose(self.nodeData, self:getPosition())
		end
	end
end

function ActivityHatsuneMikuAwardCell:onBtnAwardSel()
	if self.state == HatsuneMikuConfig.AwardState.Sel then
		local uiWindow = UIManager.tryGetUI(self.mainDlgName)

		if uiWindow then
			uiWindow:getNodeAward(self.nodeData)
		end
	end
end

function ActivityHatsuneMikuAwardCell:onClick()
	local openBoxChooseDlg = UIManager.getUI("openBoxChooseDlg", true)

	openBoxChooseDlg:openChoose()
end

return ActivityHatsuneMikuAwardCell
