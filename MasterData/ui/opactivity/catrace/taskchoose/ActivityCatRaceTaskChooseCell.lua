-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\TaskChoose\\ActivityCatRaceTaskChooseCell.lua

local strClassName = "ActivityCatRaceTaskChooseCell"
local ActivityCatRaceTaskChooseCell = Class(strClassName, UIControls.Child)

function ActivityCatRaceTaskChooseCell:ctor()
	self:initUI()
end

function ActivityCatRaceTaskChooseCell:initUI()
	self.descTxt = UIControls.Label(self, "ImgBg/TextTaskRule")
	self.ruleTxt = UIControls.Label(self, "ImgBg/BgItemUse/Text")
	self.selectBtn = UIControls.Button(self, "")

	self.selectBtn:addEventClick(self._onBtnSelect)

	self.bgImg = UIControls.Image(self, "ImgBg")
end

function ActivityCatRaceTaskChooseCell:setData(achieveData, taskDetail, taskSelectedCallback)
	self.achieveData = achieveData
	self.taskDetail = taskDetail
	self.achieveType = self.achieveData.type
	self.achieveIndex = self.achieveData.index
	self.taskSelectCallback = taskSelectedCallback

	self:setVisible(true)
end

function ActivityCatRaceTaskChooseCell:refreshData()
	self.ruleTxt:setText(self.achieveData.desc_name)
	self.descTxt:setText(self.taskDetail.title)
end

function ActivityCatRaceTaskChooseCell:setState(selected)
	if selected then
		self.bgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas04", "BgMytaskSel00")
	else
		self.bgImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas04", "BgMytaskNml00")
	end
end

function ActivityCatRaceTaskChooseCell:_onBtnSelect()
	if self.taskSelectCallback then
		self:taskSelectCallback(self.taskDetail)
	end
end

return ActivityCatRaceTaskChooseCell
