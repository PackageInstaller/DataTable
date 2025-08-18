-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Award\\ActivityCatRaceMileAwardCell.lua

local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local strClassName = "ActivityCatRaceMileAwardCell"
local ActivityCatRaceMileAwardCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function ActivityCatRaceMileAwardCell:ctor()
	self:initUI()
end

function ActivityCatRaceMileAwardCell:initUI()
	self.awardPanel = UIControls.Panel(self, "AwardPanel/GrideAward")
	self.confirmBtn = UIControls.Button(self, "AwardPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onBtnConfirm)

	self.stateTxt = UIControls.Label(self, "AwardPanel/TextState")
	self.bgImg = UIControls.Image(self, "AwardPanel/Bg")
	self.awardBgImg = UIControls.Image(self, "AwardPanel/BgAward")
	self.mileTxt = UIControls.Label(self, "MilePanel/TextMile")
	self.slider = UIControls.Slider(self, "Slider")
	self.awardPointImg = UIControls.Image(self, "Slider/ImgAwardPoint")
	self.targetImg = UIControls.Image(self, "Slider/BgTarget")
	self.speicalAwardImg = UIControls.Image(self, "MilePanel/TextMile/IconMilePost")
	self.curCatImg = UIControls.Image(self, "Slider/ImgCat")
	self.curPosImg = UIControls.Image(self, "ImgDec")
	self.bgMileImg = UIControls.Image(self, "MilePanel/BgMile")
end

function ActivityCatRaceMileAwardCell:setData(data)
	self.actData = data.actData
	self.actObj = self.actData.actObject
	self.opId = self.actObj.opId
	self.achieveType = data.achieveType
	self.achieveIndex = data.achieveIndex
	self.achieveData = data.achieveData

	self:setVisible(true)
	self:refreshData()
end

function ActivityCatRaceMileAwardCell:refreshData()
	local progress = self.actData:getAchieveProgress(self.achieveType)
	local param = self.actData:getAchieveParam(self.achieveType, self.achieveIndex)
	local prevParam = 0

	if self.achieveIndex > 1 then
		prevParam = self.actData:getAchieveParam(self.achieveType, self.achieveIndex - 1)
	end

	local rate = 0

	rate = param <= progress and 1 or progress < prevParam and 0 or (progress - prevParam) / (param - prevParam)

	self.slider:setValue(rate)
	self.mileTxt:setText(self.achieveData.desc_name)
	self.targetImg:setVisible(rate >= 1)

	if self:isCurAchieve() then
		self.curCatImg:setVisible(true)
		self.curPosImg:setVisible(true)
		self.bgMileImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas", "BgMilepost02")
	else
		self.curPosImg:setVisible(false)
		self.curCatImg:setVisible(false)
		self.bgMileImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas", "BgMilepost01")
	end

	local state = self.actData:getAchieveState(self.achieveType, self.achieveIndex)

	if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.confirmBtn:setVisible(true)
		self.stateTxt:setVisible(false)
		self.bgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas04", "BgMytaskSel")

		if self.achieveData.high_award then
			self.awardBgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas", "BgSpecialRewards01")
			self.awardBgImg:setVisible(true)
		else
			self.awardBgImg:setVisible(false)
		end
	elseif state == Const.ACT_ACHIEVE_STATE_GOT then
		self.confirmBtn:setVisible(false)
		self.stateTxt:setVisible(true)
		self.stateTxt:setText(Lang.get(74))
		self.bgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas04", "BgMytaskNml")
		self.awardBgImg:setVisible(false)
	else
		self.confirmBtn:setVisible(false)
		self.stateTxt:setVisible(true)
		self.stateTxt:setText(Lang.get(114))
		self.bgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas04", "BgMytaskNml")
		self.awardBgImg:setVisible(false)

		if self.achieveData.high_award then
			self.awardBgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas", "BgSpecialRewards02")
			self.awardBgImg:setVisible(true)
		else
			self.awardBgImg:setVisible(false)
		end
	end

	local nextAchieve = self.actData:getNextAchieveInfo()

	if not nextAchieve and rate >= 1 then
		self.curCatImg:setVisible(true)
	end

	if self.awardId ~= self.achieveData.award then
		self.awardId = self.achieveData.award

		if self.awardGrids then
			for _, grid in pairs(self.awardGrids) do
				grid:destroy()
			end
		end

		self.awardGrids = {}

		ClientUtils.CreateBonusGrid(self, self.awardGrids, "AwardPanel/GridAward", self.awardId, true, nil, true, CatRaceConfig.GRID_CONFIG)
	end

	local isGot = state == Const.ACT_ACHIEVE_STATE_GOT

	self.bgImg:setImageGray(isGot)

	if self.awardGrids then
		for _, grid in pairs(self.awardGrids) do
			grid:setIconGray(isGot)
		end
	end

	if self.achieveData.high_award then
		self.speicalAwardImg:setVisible(true)
	else
		self.speicalAwardImg:setVisible(false)
	end
end

function ActivityCatRaceMileAwardCell:_onBtnConfirm()
	if self.actObj:inFreeze() or self.actObj:inOpenState() then
		RPC.opActGetAward(self.opId, self.achieveIndex, self.achieveType)

		if self.confirmCallback then
			self.confirmCallback()
		end
	end
end

function ActivityCatRaceMileAwardCell:isCurAchieve()
	local preIndex = self.achieveIndex - 1
	local nextIndex = self.achieveIndex + 1
	local prevParam = 0

	if preIndex >= 1 then
		prevParam = self.actData:getAchieveParam(self.achieveType, preIndex)
	end

	local curProgress = self.actData:getAchieveProgress(self.achieveType)
	local curParam = self.actData:getAchieveParam(self.achieveType, self.achieveIndex)

	if self.actData:getAchieveOneData(self.achieveType, nextIndex) then
		if prevParam < curProgress and curProgress <= curParam then
			return true
		end
	elseif prevParam < curProgress then
		return true
	end

	return false
end

return ActivityCatRaceMileAwardCell
