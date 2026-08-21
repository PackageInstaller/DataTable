-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPRankAwardCell.lua

local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "PVPRankAwardCell"
local PVPRankAwardCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PVPRankAwardCell:ctor()
	self:initUI()
end

function PVPRankAwardCell:initUI()
	self.rankTxt = UIControls.Label(self, "TextRank")
	self.rankSelfTxt = UIControls.Label(self, "TextRank/TextRankSelf")
	self.textRankTitle = UIControls.Label(self, "TextRank/TextRankTitle")
	self.imgBg = UIControls.Image(self, "")
	self.myIndex = self.mWindow.myIndex or 0
	self.awards = {}
end

local ICON_PATH2 = "Atlas/CommonAtlas/BgAtlas2"

function PVPRankAwardCell:initData(itemDatas)
	self.textRankTitle:setVisible(not RegionUtils.isSEA())

	self.endIndex = itemDatas.index_low_bound
	self.startIndex = itemDatas.index

	if self.endIndex ~= self.startIndex then
		self.rankTxt:setText(self.startIndex .. -self.endIndex)
	else
		self.rankTxt:setText(self.startIndex)
	end

	if self.endIndex == nil and self.myIndex == self.startIndex or self.myIndex >= self.startIndex and self.myIndex <= self.endIndex then
		self.rankSelfTxt:setText(string.format(Lang.get(30646), self.myIndex))
		self.rankSelfTxt:setVisible(true)
		self.imgBg:setImage(ICON_PATH2, "BgLineSel01")
	else
		self.rankSelfTxt:setVisible(false)
		self.imgBg:setImage(ICON_PATH2, "BgLineNml")
	end

	local id = itemDatas.award
	local bonus = ResRandClient[id] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	for i = 1, #showNums do
		if self.awards[i] then
			if showIds[i] then
				local clientItem = BaseObject.GetObject(showIds[i], showNums[i])

				self.awards[i]:setObj(clientItem)
				self.awards[i]:setVisible(true)
			end
		else
			local newGrid = UIControls.getGridContainer(self, "AwardPanel")

			table.insert(self.awards, newGrid)

			newGrid.mDisableWays = true

			if showIds[i] then
				local clientItem = BaseObject.GetObject(showIds[i], showNums[i])

				newGrid:setObj(clientItem)
				newGrid:setVisible(true)
			end
		end
	end

	for i = #showNums + 1, #self.awards do
		if self.awards[i] ~= nil then
			self.awards[i]:setVisible(false)
		end
	end
end

return PVPRankAwardCell
