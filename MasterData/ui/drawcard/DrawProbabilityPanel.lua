-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawProbabilityPanel.lua

local ResDrawProbilityClient = require("ClientData/ResDrawProbilityClient")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "DrawProbabilityPanel"
local DrawProbabilityPanel = Class(strClassName, UIControls.Panel)
local ProbabilityTitleCell = Class("ProbabilityTitleCell", UIControls.Child)

function ProbabilityTitleCell:ctor(...)
	self:initUI()
end

function ProbabilityTitleCell:initUI(...)
	self.nameDescTxt = UIControls.Label(self, "TextTitleL")
	self.numDescTxt = UIControls.Label(self, "TextTitleR")
end

function ProbabilityTitleCell:setProbabilityDisplay(nameDesc, numDesc)
	self.nameDescTxt:setText(nameDesc)
	self.numDescTxt:setText(numDesc)
end

local ProbabilityCell = Class("ProbabilityCell", UIControls.Child)

function ProbabilityCell:ctor(...)
	self:initUI()
end

function ProbabilityCell:initUI(...)
	self.nameTxt = UIControls.Label(self, "TextName")
	self.numTxt = UIControls.Label(self, "TextNum")
	self.upIcon = UIControls.Image(self, "TextName/IconArrow")
end

function ProbabilityCell:setProbabilityDisplay(name, probability, needUpIcon)
	self.nameTxt:setText(name)
	self.numTxt:setText(probability)
	self.upIcon:setVisible(needUpIcon)
end

function DrawProbabilityPanel:ctor(...)
	self:initUI()
end

function DrawProbabilityPanel:initUI(...)
	if UIControls.checkControlFunc(self, self.mPath .. "/UIClickThrough") then
		self.blockBtn = UIControls.Button(self, self.mPath .. "/UIClickThrough")

		self.blockBtn:addEventClick(self._onClosePanel)
	end

	self.poolTitleTxt = UIControls.Label(self, self.mPath .. "/BgPanel/TextTitle")
	self.probabilityRuleTxt = UIControls.Label(self, self.mPath .. "/BgPanel/TextRule")
	self.contentPath = self.mPath .. "/BgPanel/ProbabilityListPanel/Content"
	self.cells = {}
end

function DrawProbabilityPanel:setPoolInfo(poolName, poolId)
	self.poolTitleTxt:setText(poolName)

	local probabilityInfo = ResDrawProbilityClient[poolId]

	if not probabilityInfo then
		return
	end

	for i, oldCells in ipairs(self.cells) do
		oldCells:destroy()
	end

	self.cells = {}

	for index, info in ipairs(probabilityInfo) do
		local name = info.name
		local probability = info.probability
		local isTitleCell = info.type ~= nil
		local needUpIcon = info.up_icon ~= nil
		local newCell

		if isTitleCell then
			newCell = ProbabilityTitleCell(self, self.contentPath, "System/HeroPool/CellProbabilityNumTitle", 0, 0, true)
		else
			newCell = ProbabilityCell(self, self.contentPath, "System/HeroPool/CellProbabilityNum", 0, 0, true)
		end

		self.cells[index] = newCell

		newCell:setProbabilityDisplay(name, probability, needUpIcon)
	end

	local poolInfo = DrawCardUtils.getPoolClientInfo(poolId)

	if poolInfo and poolInfo.probability_rule then
		self.probabilityRuleTxt:setVisible(true)
		self.probabilityRuleTxt:setText(poolInfo.probability_rule)
	else
		self.probabilityRuleTxt:setVisible(false)
	end
end

function DrawProbabilityPanel:_onClosePanel(...)
	self:setVisible(false)
end

return DrawProbabilityPanel
