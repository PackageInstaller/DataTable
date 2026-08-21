-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpRankAwardGetCell.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local ActivityPvpRankAwardGetCell = Class("ActivityPvpRankAwardGetCell", UIControls.ScrollViewLoopCell)

function ActivityPvpRankAwardGetCell:ctor(...)
	self:initUI()
end

function ActivityPvpRankAwardGetCell:initUI(...)
	self.imgRankLv = UIControls.Image(self, "IconRankLv")
	self.txtRank = UIControls.Label(self, "TextRank")
	self.awardCells = {}
end

function ActivityPvpRankAwardGetCell:setData(data)
	PVPCommon.setRankIconBig(self.imgRankLv, data)
	self.txtRank:setText(data.dan_name)
	ClientUtils.CreateBonusGrid(self, self.awardCells, "AwardPanel", data.dan_award, true, nil, true)
end

return ActivityPvpRankAwardGetCell
