-- chunkname: @IQIGame\\UI\\Maze\\IllusionMazeRewardCell.lua

local m = {}
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.RewardCell = MazeRewardCell.New(self.RewardCellGO)
end

function m:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
	self.View:SetActive(itemCid ~= 0)
	self.RewardCell:SetData(itemCid, 1, isFirstPassReward, isUncertain)
	UGUIUtil.SetText(self.NumText, IllusionMazeSettlementUIApi:GetString("RewardItemNumText", itemNum))
end

function m:Dispose()
	self.RewardCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
