-- chunkname: @IQIGame\\UI\\Activity\\PicturePuzzle\\PicturePuzzleRewardCell.lua

local m = {
	state = 1
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(data, index, picturePuzzleID)
	self.cfgPuzzleReward = data
	self.picturePuzzleID = picturePuzzleID

	UGUIUtil.SetText(self.TextIndex, index)

	self.state = ActivePicturePuzzleModule.GetPicRewardState(self.picturePuzzleID, self.cfgPuzzleReward.Id)

	self.State1:SetActive(self.state == 1)
	self.State2:SetActive(self.state == 2)
	self.State3:SetActive(self.state == 3)
	self.RedTag:SetActive(self.state == 2)
end

function m:OnBtnSelf()
	local rewards = {}

	for i = 1, #self.cfgPuzzleReward.Reward, 2 do
		local rewardId = self.cfgPuzzleReward.Reward[i]
		local rewardNum = self.cfgPuzzleReward.Reward[i + 1]

		table.insert(rewards, {
			id = rewardId,
			num = rewardNum
		})
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		Rewards = rewards,
		State = self.state,
		GetCallback = function()
			ActivePicturePuzzleModule.ImagePuzzleGetUnlockReward(self.picturePuzzleID, self.cfgPuzzleReward.Id)
		end
	})
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
