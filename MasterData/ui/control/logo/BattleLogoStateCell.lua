-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Logo\\BattleLogoStateCell.lua

local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local strClassName = "BattleLogoStateCell"
local BattleLogoStateCell = Class(strClassName, UIControls.Child)

function BattleLogoStateCell:ctor()
	self:initUI()
end

function BattleLogoStateCell:initUI()
	self.iconState = UIControls.Image(self, "Img")
end

function BattleLogoStateCell:setData(userId, stateId, stateLevel)
	self.userId = userId
	self.stateId = stateId
	self.stateLevel = stateLevel

	local stateData = BattleStateData.getStateData(stateId, stateLevel)

	if stateData and stateData.icon_path and stateData.state_icon then
		self.iconState:setImage(stateData.icon_path, stateData.state_icon)
	end
end

return BattleLogoStateCell
