-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpGambleAwardTipsDlg.lua

local ResBPPvpBetAward = require("ClientData/ResBPPvpBetAward")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResItem = require("ClientData/ResItem")
local ResRandClient = require("ClientData/ResRandClient")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local TopPvpGambleAwardCell = Class("TopPvpGambleAwardCell", UIControls.Child)

function TopPvpGambleAwardCell:ctor(...)
	self:initUI()
end

function TopPvpGambleAwardCell:initUI()
	self.imgTockenIcon = UIControls.Image(self, "TokenPanel/Icon")
	self.txtTockenNum = UIControls.Label(self, "TokenPanel/TextNum")
	self.imgAwardIcon = UIControls.Image(self, "AwardPanel/Icon")
	self.txtAwardNum = UIControls.Label(self, "AwardPanel/TextNum")
end

function TopPvpGambleAwardCell:setData()
	return
end

local TopPvpGambleAwardTipsTitleCell = Class("TopPvpGambleAwardTipsTitleCell", UIControls.Child)

function TopPvpGambleAwardTipsTitleCell:ctor()
	return
end

local strClassName = "TopPvpGambleAwardTipsDlg"
local TopPvpGambleAwardTipsDlg = Class(strClassName, UIControls.Window)

function TopPvpGambleAwardTipsDlg:ctor(...)
	self:initUI()
end

function TopPvpGambleAwardTipsDlg:initUI(...)
	self.txtRule = UIControls.Label(self, "Bg/TextRule")

	local coidId = ResBPPvpMisc[1].bet_coin
	local item = ResItem[coidId]

	if item then
		self.iconPath = item.sourceIconPath
		self.iconName = item.sourceIcon
	end

	self.title = TopPvpGambleAwardTipsTitleCell(self, "Bg/AwardPanel", "System/TopPVP/CellAwardNumTitle")

	self.title:setVisible(true)

	self.cells = {}

	for index, oneAward in ipairs(ResBPPvpBetAward) do
		local newCell = TopPvpGambleAwardCell(self, "Bg/AwardPanel", "System/TopPVP/CellAwardNum")

		newCell:setVisible(true)

		if self.iconPath and self.iconName then
			newCell.imgTockenIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/" .. self.iconPath, self.iconName)
			newCell.txtTockenNum:setText(oneAward.coin_num)
			newCell.imgAwardIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/" .. oneAward.icon_path, oneAward.icon_name)

			local awardId = oneAward.award

			if awardId then
				local showNum = ResRandClient[awardId].show_nums[1] or 0

				newCell.txtAwardNum:setText(showNum)
			end
		end

		table.insert(self.cells, newCell)
	end

	self.txtRule = UIControls.Label(self, "Bg/TextRule")

	self.txtRule:setText(ResBPPvpShow[13070010].desc)
end

return TopPvpGambleAwardTipsDlg
