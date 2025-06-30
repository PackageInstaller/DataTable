-- chunkname: @IQIGame\\UI\\Guild\\GuildRewardShow\\GuildRewardShowCell.lua

local m = {
	showRewardCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GuildShowRewardCell = require("IQIGame.UI.Guild.GuildRewardShow.GuildShowRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextStatus, GuildRewardShowUIApi:GetString("TextStatus"))
	UGUIUtil.SetTextInChildren(self.BtnGetReward, GuildRewardShowUIApi:GetString("BtnGetRewardLabel"))

	function self.DelegateBtnGetReward()
		self:OnBtnGetReward()
	end

	self.RewardMould:SetActive(false)

	self.showRewardCellPool = UIObjectPool.New(5, function()
		local cell = GuildShowRewardCell.New(UnityEngine.Object.Instantiate(self.RewardMould))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnGetReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnGetReward)
end

function m:RemoveListener()
	self.BtnGetReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGetReward)
end

function m:SetData(data)
	self.data = data

	self:UpDateView()
end

function m:UpDateView()
	self.BgStatus2:SetActive(self.data.state == 1)
	self.BgStatus1:SetActive(self.data.state == 2)
	self.BgStatus3:SetActive(self.data.state == 3)
	self.MaskStatus:SetActive(self.data.state == 3)
	UGUIUtil.SetText(self.TextStage, self.data.cfgInfo.Stage)
	UGUIUtil.SetText(self.TextTargetScore, GuildRewardShowUIApi:GetString("TextTargetScore", self.data.score, self.data.maxScore))

	for i, v in pairs(self.showRewardCells) do
		v.View.transform:SetParent(v.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.showRewardCellPool:Release(v)
	end

	self.showRewardCells = {}

	for i = 1, #self.data.cfgInfo.Reward, 2 do
		local id = self.data.cfgInfo.Reward[i]
		local num = self.data.cfgInfo.Reward[i + 1]
		local cell = self.showRewardCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.RewardSort.transform, false)
		cell:SetData(id, num)
		table.insert(self.showRewardCells, cell)
	end
end

function m:OnBtnGetReward()
	if self.data.state == 1 then
		GuildChallengeModule.GetScore(function()
			local state, score, maxScore = GuildChallengeModule.GetRewardState(self.data.cid)

			if state == 1 then
				GuildChallengeModule.GetRewards({
					self.data.cid
				})
			end
		end)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.showRewardCells) do
		self.showRewardCellPool:Release(v)
	end

	self.showRewardCells = {}

	self.showRewardCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
