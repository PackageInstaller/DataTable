-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Achieve\\ActivityPredictAchieve.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityPredictAchieveCell = Class("ActivityPredictAchieveCell", UIControls.ScrollViewLoopCell)

function ActivityPredictAchieveCell:ctor()
	self:initUI()
end

function ActivityPredictAchieveCell:initUI()
	self.panelNm = UIControls.Panel(self, "AwardPanel/BgNmlAward")
	self.panelBig = UIControls.Panel(self, "AwardPanel/BgBigAward")
	self.btnGet = UIControls.Button(self, "AwardPanel/BtnGet")

	self.btnGet:addEventClick(self.onGetClick)

	self.sliderProgress = UIControls.Slider(self, "Slider")
	self.textProgress = UIControls.Label(self, "SliderNum")
	self.itemGrids = {}
end

function ActivityPredictAchieveCell:setData(data, preData)
	self.actData = self.mParent.actObj.actData
	self.achieveData = data

	if data.high_award then
		self.panelBig:setVisible(true)
		self.panelNm:setVisible(false)
	else
		self.panelBig:setVisible(false)
		self.panelNm:setVisible(true)
	end

	local showProgress, maxProgress = self.actData:getAchieveShowProgress(data)
	local startProgress = 0

	if preData then
		startProgress = preData.param

		if data.type == 30 then
			startProgress = startProgress / 100
		end

		showProgress = math.max(0, showProgress - startProgress)
		maxProgress = maxProgress - startProgress
	end

	self.sliderProgress:setValue(showProgress / maxProgress)
	self.textProgress:setText(maxProgress + startProgress)
	ClientUtils.CreateBonusGrid(self, self.itemGrids, "AwardPanel/AwardNode", data.award, true, nil, true)

	local achState = self.actData:getAchieveState(data.type, data.index)

	if achState == Const.ACT_ACHIEVE_STATE_GOT then
		self.btnGet:setVisible(false)
		self:playStateAnimator("PayAddUpCellDis")
	elseif achState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.btnGet:setVisible(true)
		self:playStateAnimator("PayAddUpCellSel")
	else
		self.btnGet:setVisible(false)
		self:playStateAnimator("PayAddUpCellNml")
	end

	for _, grid in ipairs(self.itemGrids) do
		grid:setGet(achState == Const.ACT_ACHIEVE_STATE_GOT)
	end
end

function ActivityPredictAchieveCell:onGetClick()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.actObj.opId, self.achieveData.index, self.achieveData.type), self.mParent.actObj.opId)
end

local classNameStr = "ActivityPredictAchieve"
local ActivityPredictAchieve = Class(classNameStr, UIControls.Child)

MixinClass(ActivityPredictAchieve, ActivityPanelMixin)

function ActivityPredictAchieve:_setData()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textPredict = UIControls.Label(self, "BigAwardPanel/BgTextDes/TextDes")
	self.panelPredict = UIControls.Panel(self, "BigAwardPanel")
	self.panelMax = UIControls.Panel(self, "EmptyPanel")
	self.predictGrids = {}
	self.textProgress = UIControls.Label(self, "AddUpPanel/AddDayNum/TxtNum")
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopH(self, "AwardList")

	self.scroll:addEventCellChanged(self.onCellChanged)
end

function ActivityPredictAchieve:_onShow()
	self.achieveData = {}

	for achieveType, typeData in pairs(self.actObj.actData.clientData) do
		self.achieveData = typeData

		break
	end

	self:refreshData()
end

function ActivityPredictAchieve:refreshData()
	local actData = self.actObj.actData
	local curProgress = 0

	if actData.serverData[self.achieveData[1].type] then
		curProgress = actData.serverData[self.achieveData[1].type].progress
	end

	local nextBigData, nowIndex

	for index, data in ipairs(self.achieveData) do
		if actData:getAchieveState(data.type, data.index) ~= Const.ACT_ACHIEVE_STATE_GOT then
			nowIndex = index

			break
		end
	end

	for index, data in ipairs(self.achieveData) do
		if curProgress < data.param and data.high_award then
			nextBigData = data

			break
		end
	end

	local showProgress, maxProgress = actData:getAchieveShowProgress(self.achieveData[1])

	self.textProgress:setText(showProgress)

	if nextBigData then
		self.panelMax:setVisible(false)
		self.panelPredict:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.predictGrids, "BigAwardPanel/GiftPanel", nextBigData.award, true, nil, true)

		local showProgress, maxProgress = actData:getAchieveShowProgress(nextBigData)
		local need = maxProgress - showProgress

		if actData.miscData and actData.miscData.special_notice_format then
			self.textPredict:setText(string.format(actData.miscData.special_notice_format, need))
		end
	else
		self.panelMax:setVisible(true)
		self.panelPredict:setVisible(false)
	end

	nowIndex = nowIndex or #self.achieveData

	self.scroll:setTotalCount(#self.achieveData, math.max(0, nowIndex - 1))
end

function ActivityPredictAchieve:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityPredictAchieveCell(sender, "System/Activity/ActivityPayAddUp/ActivityPayAddUpCell01", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.achieveData[newIdx], self.achieveData[newIdx - 1])

	self.cells[newIdx] = targetCell
end

function ActivityPredictAchieve:onActivityDataRefresh()
	self:refreshData()
end

function ActivityPredictAchieve:updateRelatedActivityData()
	self:refreshData()
end

return ActivityPredictAchieve
