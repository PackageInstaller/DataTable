-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawRecordPanel.lua

local strClassName = "DrawRecordPanel"
local DrawRecordPanel = Class(strClassName, UIControls.Panel)
local DrawRecordCell = Class("DrawRecordCell", UIControls.ScrollViewLoopCell)

function DrawRecordCell:ctor(...)
	self.starImg = UIControls.Image(self, "")
	self.nameTxt = UIControls.Label(self, "TxName")
	self.timeTxt = UIControls.Label(self, "TxtTime")
end

local StarImgPath = {
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordGreen"
	},
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordBlue"
	},
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordPurple"
	},
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordPurple"
	},
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordGold"
	},
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordPick"
	},
	{
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgRecordRed"
	}
}
local StarFontColor = {
	nil,
	nil,
	"CF75FE",
	"CF75FE",
	"FFD92F",
	"FD71B1",
	"FF3125"
}

function DrawRecordCell:setRecordData(name, time, star)
	if star and StarFontColor[star] then
		name = string.format("<color=#%s>%s</color>", StarFontColor[star], name)
		time = string.format("<color=#%s>%s</color>", StarFontColor[star], time)
	end

	self.nameTxt:setText(name)
	self.timeTxt:setText(time)

	if star and StarImgPath[star] then
		local qualityPath = StarImgPath[star]

		self.starImg:setImage(qualityPath[1], qualityPath[2])
	end
end

function DrawRecordPanel:ctor(...)
	self:initUI()
end

function DrawRecordPanel:initUI(...)
	if UIControls.checkControlFunc(self, self.mPath .. "/BtnBlockClose") then
		self.closeBtn = UIControls.Button(self, self.mPath .. "/BtnBlockClose")

		self.closeBtn:addEventClick(self._onClickClose)
	end

	self.switchBtn = UIControls.Button(self, self.mPath .. "/BgPanel/RulePanel/BtnRule")

	self.switchBtn:addEventClick(self._onSwitchRule)

	self.ruleTxt = UIControls.Panel(self, self.mPath .. "/BgPanel/RulePanel/TextRuleDes")
	self.upArrow = UIControls.Image(self, self.mPath .. "/BgPanel/RulePanel/BtnRule/ImgUp")
	self.downArrow = UIControls.Image(self, self.mPath .. "/BgPanel/RulePanel/BtnRule/ImgDown")
	self.emptyTxt1 = UIControls.Label(self, self.mPath .. "/BgPanel/TxtDes")
	self.emptyTxt2 = UIControls.Label(self, self.mPath .. "/BgPanel/TxtDes1")
	self.recordScroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/BgPanel/DrawLogListPanel")

	self.recordScroll:addEventCellChanged(self.onCellChanged)

	self.cellList = {}
end

function DrawRecordPanel:setRecordData(recordList)
	self.recordList = recordList

	local hasRecord = #recordList > 0

	self.emptyTxt1:setVisible(not hasRecord)
	self.emptyTxt2:setVisible(not hasRecord)
	self.recordScroll:setTotalCount(#self.recordList)
	self.recordScroll:goToTop()

	self.ruleVisible = false

	self:_refreshRule()
end

function DrawRecordPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = DrawRecordCell(sender, "System/HeroPool/DrawLogCell", newIdx)
	else
		self.cellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local record = self.recordList[newIdx]

	if record then
		local heroId = record[1]
		local time = record[2]
		local star = record[3]
		local hero = BaseObject.GetObject(heroId)

		targetCell:setVisible(true)
		targetCell:setRecordData(hero.name, ClientUtils.getServerTimeData(time, "%Y-%m-%d %H:%M:%S"), star)
	end

	self.cellList[newIdx] = targetCell
end

function DrawRecordPanel:_refreshRule(...)
	self.ruleTxt:setVisible(self.ruleVisible)
	self.upArrow:setVisible(not self.ruleVisible)
	self.downArrow:setVisible(self.ruleVisible)
end

function DrawRecordPanel:_onClickClose(...)
	self:setVisible(false)
end

function DrawRecordPanel:_onSwitchRule(...)
	self.ruleVisible = not self.ruleVisible

	self:_refreshRule()
end

return DrawRecordPanel
