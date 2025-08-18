-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PoolDrawLogCell.lua

local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local strClassName = "PoolDrawLogCell"
local PoolDrawLogCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PoolDrawLogCell:ctor()
	self:initUI()
end

function PoolDrawLogCell:initUI()
	self.imgSelf = UIControls.Image(self, "")
	self.bgGashapon = UIControls.Image(self, "BgGashapon")
	self.textGrade = UIControls.Label(self, "TextGrade")
	self.textName = UIControls.Label(self, "TextName")
	self.textTime = UIControls.Label(self, "TextTime")
end

function PoolDrawLogCell:setData(data)
	self.data = data

	local gashaponId = self.data[3]

	self.configData = ResPetGashaponConfig[gashaponId]

	local atlas = "Atlas/PetPoolAtlas/PetPoolProbabilityAtlas/PetPoolProbabilityAtlas02"
	local imgName = {
		"BgGreen",
		"BgBlue",
		"BgYellow",
		"BgPink"
	}

	self.imgSelf:setImage(atlas, imgName[self.configData.quality])

	if self.configData.icon_path then
		self.bgGashapon:setImage(self.configData.icon_path, self.configData.icon)
	end

	self.textGrade:setText(self.configData.gashapon_name)

	local time = self.data[2]

	self.textTime:setText(ClientUtils.getServerTimeData(time, "%Y-%m-%d %H:%M:%S"))

	local itemId = self.data[1]
	local item = BaseObject.GetObject(itemId)

	self.textName:setText(item.name)
end

return PoolDrawLogCell
